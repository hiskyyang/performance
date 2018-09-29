package com.performance.service;

import com.basic.cache.service.CacheManager;
import com.basic.service.BaseService;
import com.exam.vo.Exam;
import com.measure.service.MeasureService;
import com.measure.vo.Measure;
import com.performance.dao.PerformanceDao;
import com.performance.vo.Performance;
import com.user.service.UserService;
import com.user.vo.User;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Service
public class PerformanceService extends BaseService<Performance> {
    Logger log = Logger.getLogger(this.getClass());

    @Autowired
    UserService userService;
    @Autowired
    MeasureService measureService;
    @Autowired
    CacheManager cacheManager;

    //    @UpdateCache
    public void init(Integer createdUserId, Integer examId, List<User> users) {
        Measure measure = new Measure();
        measure.setExamId(examId);
        List<Measure> measures = measureService.list(measure);

        if (isValid(createdUserId, examId, users, measures)) {
            return;
        }

        List<Performance> performances = constructPerfomances(examId, createdUserId, users, measures);
        PerformanceDao performanceDao = (PerformanceDao) baseDao;
        performanceDao.adds(performances);
    }

    private List<Performance> constructPerfomances(Integer examId, Integer createdUseId, List<User> users, List<Measure> measures) {
        Map<String, String> teamMaps = cacheManager.getCodeMap("team");
        Map<String, String> levelMaps = cacheManager.getCodeMap("level");
        List<Performance> performances = new LinkedList<Performance>();
        for (User user : users) {
            for (Measure measure : measures) {
                Performance performance = new Performance();
                performance.setUserId(user.getUserId());
                performance.setName(user.getName());
                performance.setLevel(levelMaps.get(user.getLevel()));
                performance.setTeam(teamMaps.get(user.getTeam()));
                performance.setExamId(examId);
                performance.setMeasureId(measure.getMeasureId());
                performance.setMeasureName(measure.getName());
                performance.setMeasureWeight(measure.getWeight());
                performance.setCreatedUserId(createdUseId);
                performances.add(performance);
            }
        }
        return performances;
    }

    private boolean isValid(Integer createdUserId, Integer examId, List<User> users, List<Measure> measures) {
        Performance performance = new Performance();
        performance.setCreatedUserId(createdUserId);
        performance.setExamId(examId);
        List<Performance> performances = baseDao.list(performance);
        if (performances.size() == users.size() * measures.size()) {
            return true;
        }

        performances.forEach(p -> baseDao.delete(p));
        return false;
    }

    public void update(List<Performance> performances) {
        for (Performance performance : performances) {
            baseDao.update(performance);
        }
    }

}
