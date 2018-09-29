package com.basic.cache.util;

import com.user.vo.User;
import org.springframework.expression.EvaluationContext;
import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class SpringELParser {

    private static ExpressionParser parser = new SpelExpressionParser();

    //  private static Logger log = Logger.getLogger(SpelParser.class);
    // String prefix = "'Book.'+#bookId";
    // int bookId = 100;
    public static String parseKey(String key, String condition, String[] paramNames, Object[] arguments) {
        try {
            if (!checkCondition(condition, paramNames, arguments)) {
                return null;
            }
            Expression expression = parser.parseExpression(key);
            EvaluationContext context = new StandardEvaluationContext();
            int length = paramNames.length;
            if (length > 0) {
                for (int i = 0; i < length; i++) {
                    context.setVariable(paramNames[i], arguments[i]);
                }
            }
            return expression.getValue(context, String.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean checkCondition(String condition, String[] paramNames, Object[] arguments) {
        if (condition.length() < 1) {
            return true;
        }
        Expression expression = parser.parseExpression(condition);
        EvaluationContext context = new StandardEvaluationContext();
        int length = paramNames.length;
        if (length > 0) {
            for (int i = 0; i < length; i++) {
                context.setVariable(paramNames[i], arguments[i]);
            }
        }
        return expression.getValue(context, boolean.class);
    }

    public static String parseKey(Object arg) {
        String key = "";
        try {
            Class clazz = arg.getClass();
            String name = clazz.getName();
            String clazzShortName = name.substring(name.lastIndexOf(".") + 1);

            String idAttributeName = getIdAttributeName(clazzShortName);

            Object value = getValue(arg, idAttributeName);

            String prefix = String.format("'%s_'+#%s",clazzShortName, idAttributeName);

            key = parseKey(prefix, "", new String[]{idAttributeName}, new Object[]{value});
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        return key;
    }

    private static Object getValue(Object arg, String id) throws NoSuchMethodException, IllegalAccessException, InvocationTargetException {
        String methodName = getMethodName(id);
        Class clazz = arg.getClass();
        Method method = clazz.getMethod(methodName);
        return method.invoke(arg);
    }

    private static String getIdAttributeName(String shortName) {
        return shortName + "Id";
    }

    private static String getMethodName(String attribute) {
        return "get" + attribute;
    }

    public static void main(String[] args) {
        try {
            User user = new User();
            user.setUserId(123);

            String key = parseKey(user);

            System.out.println(key);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
