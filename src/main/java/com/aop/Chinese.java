package com.aop;

import org.springframework.stereotype.Component;

@Component
public class Chinese implements Human {
    public void speak() {
        System.out.println("Chinese is speaking...");
    }
}
