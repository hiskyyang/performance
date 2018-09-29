package com.aop;


import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class HumanAspect {

    @Pointcut("execution(* *.speak())")
    public void pointcut() {
    }

    @Before("pointcut()")
    public void before() {
        System.out.println("before speaking...");
    }

    @After("pointcut()")
    public void after() {
        System.out.println("after speak...");
    }
}
