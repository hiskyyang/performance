package com.auth.controller;

import java.net.URISyntaxException;


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

@ContextConfiguration("classpath:/spring/spring-test.xml")
public class AuthControllerTest extends AbstractTestNGSpringContextTests {
	@Autowired
	private RequestMappingHandlerAdapter handlerAdapter;
	@Autowired
	private RequestMappingHandlerMapping handlerMapping;

//	@Test
	public void test() throws Exception, URISyntaxException {
		MockHttpServletRequest req = null;
		MockHttpServletResponse res = null;
		Object handler = null;
		ModelAndView mav = null;
		/**
		 * 登录
		 */
		req = new MockHttpServletRequest();
		req.setMethod("POST");
		req.setCharacterEncoding("utf-8");
		req.setRequestURI("/auth/login");
		req.addParameter("studentId", "15");
		req.addParameter("name", "test");
		res = new MockHttpServletResponse();
		handler = handlerMapping.getHandler(req).getHandler();
		mav = handlerAdapter.handle(req, res, handler);
		Assert.assertNotNull(mav);
		System.out.println(mav);
	}
}
