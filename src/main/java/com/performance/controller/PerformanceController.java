package com.performance.controller;

import com.basic.cache.service.CacheManager;
import com.code.vo.Code;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
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
        mav.addObject("examId", examId);

        User sessionUser = (User) request.getSession().getAttribute("user");
        List<User> users = getUsersByTeam(sessionUser.getTeam());
        users = excludeMyself(sessionUser, users);
        mav.addObject("users", users);
        if(users.size() == 0){
            return mav;
        }

        User user = constructUser(userId, users);
        mav.addObject("user", user);

        performanceService.init(sessionUser.getUserId(), examId, users);

        List<Performance> performances = constructPerformances(examId, user.getUserId(), sessionUser.getUserId());
        mav.addObject("performances", performances);

        mav.setViewName("performance/list");
        return mav;
    }

    private List<Performance> constructPerformances(Integer examId, Integer userId, Integer createdUserId) {
        Performance performance = new Performance();
        performance.setExamId(examId);
        performance.setUserId(userId);
        performance.setCreatedUserId(createdUserId);
        List<Performance> performances = performanceService.list(performance);
        Measure measure = new Measure();
        measure.setExamId(examId);
        List<Measure> measures = measureService.list(measure);
        Map<Integer, Measure> measureMap = measures.stream().collect(Collectors.toMap(Measure::getMeasureId, m -> m));

        performances.forEach(p -> {
            Measure m = measureMap.get(p.getMeasureId());
            p.setMeasureWeight(m.getWeight());
            p.setMeasureName(m.getName());
        });
        return performances;
    }

    private User constructUser(Integer userId, List<User> users) {
        User user = users.stream().collect(Collectors.toMap(User::getUserId, u -> u)).get(userId);
        if (null == user && users.size() > 0) {
            user = users.get(0);
            user.setTeam(cacheManager.getCodeMap("team").get(user.getTeam()));
        }
        return user;
    }

    private List<User> excludeMyself(User sessionUser, List<User> users) {
        return users.stream().filter(u -> !sessionUser.getUserId().equals(u.getUserId())).collect(Collectors.toList());
    }

    private List<User> getUsersByTeam(String team) {
        User param = new User();
        param.setTeam(team);
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

    @RequestMapping("report")
    public ModelAndView report(HttpServletRequest request, Integer examId, String team, Integer userId, Integer createdUserId) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("examId", examId);

        User sessionUser = (User) request.getSession().getAttribute("user");
        if (!sessionUser.getRole().equals("0")) {
            //TODO
        }

        List<Code> teams = cacheManager.getCodes("team");
        mav.addObject("teams", teams);

        if (team == null) {
            team = teams.get(0).getCode();
        }
        mav.addObject("team", team);

        List<User> users = getUsersByTeam(team);
        mav.addObject("users", users);

        User user = constructUser(userId, users);
        mav.addObject("user", user);

        User createdUser = constructUser(createdUserId, excludeMyself(user, users));
        mav.addObject("createdUser", createdUser);

        List<Performance> performances = constructPerformances(examId, user.getUserId(), createdUser.getUserId());
        mav.addObject("performances", performances);

        mav.setViewName("performance/report");
        return mav;
    }
}
