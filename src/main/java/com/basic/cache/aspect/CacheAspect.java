package com.basic.cache.aspect;

import com.basic.cache.service.CacheManager;
import com.basic.cache.util.SpringELParser;
import com.sun.org.apache.bcel.internal.classfile.Signature;
import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

@Aspect
@Component
public class CacheAspect {
    Logger log = Logger.getLogger(this.getClass());

    @Autowired
    private CacheManager cacheManager;

    @Pointcut("@annotation(com.basic.cache.aspect.GetFromCache)")
    public void getFromCache() {
    }

    @Around("getFromCache()")
    public Object aroundGetFromCache(ProceedingJoinPoint pjp) throws Throwable {
        String key = getKey(pjp);
        Class t = getClass(pjp);

        Object cachedObj = cacheManager.get(key, t);
        if (cachedObj != null) {
            log.info(String.format("Find the object from cache, key=%s,value=%s", key, cachedObj));
            return cachedObj;
        }

        log.info("Find nothing from cache, call service.");
        int expiration = getExpiration(pjp, true);
        Object object = pjp.proceed(pjp.getArgs());
        cacheManager.put(key, object, expiration);
        log.info(String.format("Update the object to cache, key=%s,value=%s", key, object));
        return object;
    }

    private Class getClass(ProceedingJoinPoint pjp) {
        Object args[] = pjp.getArgs();
        return args[0].getClass();
    }

    public String getKey(ProceedingJoinPoint pjp) {
        Object args[] = pjp.getArgs();
        String key = SpringELParser.parseKey(args[0]);
        return key;
    }

    @Pointcut("@annotation(com.basic.cache.aspect.UpdateCache)")
    public void updateCache() {
    }

    @Around("updateCache()")
    public Object aroundUpdateCache(ProceedingJoinPoint pjp) throws Throwable {
        Object object = pjp.proceed(pjp.getArgs());
        String key = SpringELParser.parseKey(object);
        int expiration = getExpiration(pjp, false);
        cacheManager.put(key, object, expiration);
        log.info(String.format("Update the object to cache, key=%s,value=%s", key, object));
        return object;
    }

    private int getExpiration(ProceedingJoinPoint pjp, boolean read) {
        MethodSignature methodSignature = (MethodSignature) pjp.getSignature();
        Method method = methodSignature.getMethod();
        int expiration;
        if (read) {
            GetFromCache annotation = method.getAnnotation(GetFromCache.class);
            expiration = annotation.expiration();
        } else {
            UpdateCache annotation = method.getAnnotation(UpdateCache.class);
            expiration = annotation.expiration();
        }
        return expiration;
    }

    @Pointcut("@annotation(com.basic.cache.aspect.DeleteCache)")
    public void deleteCache() {
    }

    @Around("deleteCache()")
    public Object aroundDeleteCache(ProceedingJoinPoint pjp) throws Throwable {
        Object object = pjp.proceed(pjp.getArgs());
        String key = getKey(pjp);
        cacheManager.remove(key);
        log.info(String.format("Delete from cache, key=%s", key));
        return object;
    }
}
