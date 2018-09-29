package com.auth.controller;

import com.user.vo.User;
import com.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("auth")
public class AuthController {
	@Autowired
	UserService userService;

	@RequestMapping(value = "login", method = { RequestMethod.GET })
	public ModelAndView login() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("auth/login");
		return mav;
	}

	@RequestMapping(value = "login", method = { RequestMethod.POST })
	public ModelAndView login(User user, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<User> list = userService.list(user);
		if (list.size() > 0 && list.get(0) != null) {
			user = list.get(0);
			session.setAttribute("user", user);
			mav.addObject("user", user);
			mav.setViewName("redirect:/exam/list");
			return mav;
		} else {
			mav.addObject("errorMsg", "账号或密码错误！");
			mav.setViewName("auth/login");
			return mav;
		}
	}

	@RequestMapping("logout")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		session.removeAttribute("user");
		mav.setViewName("auth/login");
		return mav;
	}
}
