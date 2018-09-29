package com.performance.controller;

import com.basic.cache.service.CacheManager;
import com.code.vo.Code;
import com.exam.vo.Exam;
import com.measure.service.MeasureService;
import com.measure.vo.Measure;
import com.performance.service.PerformanceService;
import com.performance.vo.Performance;
import com.user.service.UserService;
import com.user.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("performance")
public class PerformanceController {
    @Autowired
    UserService userService;
    @Autowired
    MeasureService measureService;
    @Autowired
    PerformanceService performanceService;
    @Autowired
    CacheManager cacheManager;

    @RequestMapping("list")
    public ModelAndView list(HttpServletRequest request, Integer examId, Integer userId) {
        ModelAndView mav = new ModelAndView();

        User sessionUser = (User) request.getSession().getAttribute("user");
        List<User> users = getUsersByTeam(sessionUser);
        users = excludeMyself(sessionUser, users);
        mav.addObject("users", users);

        if (null == userId || !users.stream().map(u -> u.getUserId()).collect(Collectors.toSet()).contains(userId)) {
            userId = users.get(0).getUserId();
        }

        performanceService.init(sessionUser.getUserId(), examId, users);

        Performance performance = new Performance();
        performance.setUserId(userId);
        performance.setExamId(examId);
        performance.setCreatedUserId(sessionUser.getUserId());
        List<Performance> performances = performanceService.list(performance);
        mav.addObject("performances", performances);

        mav.addObject("examId", examId);
        mav.setViewName("performance/list");
        return mav;
    }

    private List<User> excludeMyself(User sessionUser, List<User> users) {
        return users.stream().filter(u -> !sessionUser.getUserId().equals(u.getUserId())).collect(Collectors.toList());
    }

    private List<User> getUsersByTeam(User sessionUser) {
        User param = new User();
        param.setTeam(sessionUser.getTeam());
        List<User> users = userService.list(param);
        return users;
    }

    @RequestMapping("update")
    @ResponseBody
    public int update(@RequestBody List<Performance> performances) {
        try {
            performanceService.update(performances);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
