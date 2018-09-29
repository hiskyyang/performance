package com.student.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.testng.AbstractTestNGSpringContextTests;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.net.URISyntaxException;

@ContextConfiguration("classpath:/spring/spring-test.xml")
public class StudentControllerTest extends AbstractTestNGSpringContextTests {
    @Autowired
    private RequestMappingHandlerAdapter handlerAdapter;
    @Autowired
    private RequestMappingHandlerMapping handlerMapping;

//    	@Test
    public void testStudent() throws Exception, URISyntaxException {
        MockHttpServletRequest req = null;
        MockHttpServletResponse res = null;
        Object handler = null;
        ModelAndView mav = null;
        /**
         * 添加学生
         */
        req = new MockHttpServletRequest();
        req.setMethod("POST");
        req.setCharacterEncoding("utf-8");
        req.setRequestURI("/student/add");
        req.addParameter("name", "中国");
        req.addParameter("sex", "1");
        req.addParameter("home", "云南");
        res = new MockHttpServletResponse();
        handler = handlerMapping.getHandler(req).getHandler();
        mav = handlerAdapter.handle(req, res, handler);
        String studentId = res.getContentAsString();
        Assert.assertNotEquals(studentId, "0");
        System.out.println(studentId);
        /**
         * 修改
         */
        req = new MockHttpServletRequest();
        req.setRequestURI("/student/update");
        req.addParameter("studentId", studentId);
        req.addParameter("name", "中国11");
        req.addParameter("sex", "1");
        req.addParameter("home", "云南11");
        res = new MockHttpServletResponse();
        handler = handlerMapping.getHandler(req).getHandler();
        mav = handlerAdapter.handle(req, res, handler);
        Assert.assertNotEquals(res.getContentAsString(), "0");
        /**
         * 删除
         */
        req = new MockHttpServletRequest();
        req.setRequestURI("/student/delete");
        req.addParameter("studentId", studentId);
        res = new MockHttpServletResponse();
        handler = handlerMapping.getHandler(req).getHandler();
        mav = handlerAdapter.handle(req, res, handler);
        Assert.assertNotEquals(res.getContentAsString(), "0");
    }
}
