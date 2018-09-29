package com.aop;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class AOPTest {
    public static void main(String args[]){
        ApplicationContext ctx = new ClassPathXmlApplicationContext("classpath:com/aop/spring-aop-test.xml");
        Human human = (Human) ctx.getBean("chinese");
        human.speak();
    }
}
