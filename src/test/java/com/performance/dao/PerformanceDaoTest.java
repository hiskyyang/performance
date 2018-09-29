package com.performance.dao;

import com.performance.vo.Performance;
import org.junit.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.testng.AbstractTestNGSpringContextTests;
import org.testng.annotations.Test;

import java.util.LinkedList;
import java.util.List;

@ContextConfiguration("classpath:/spring/spring-test.xml")
public class PerformanceDaoTest extends AbstractTestNGSpringContextTests {
    @Autowired
    PerformanceDao dao;

    @Test
    public void test() {
        Performance performance = constructPerformance();
        performance = dao.add(performance);

        performance.setName("Hisky");
        dao.update(performance);

        performance = dao.get(performance);
        System.out.println(performance);

        int effectRows = dao.delete(performance);
        Assert.assertEquals(effectRows == 1, true);
    }

    private Performance constructPerformance() {
        Performance performance = new Performance();
        performance.setUserId(1);
        performance.setName("Hisky");
        performance.setLevel("TeamLeader");
        performance.setTeam("cogency");
        performance.setExamId(0);
        performance.setMeasureId(0);
        performance.setMeasureName("Test");
        performance.setMeasureWeight(10);
        performance.setScore(90);
        performance.setCreatedUserId(1);
        return performance;
    }

    //    @Test
    public void patchAddTest() {
        List<Performance> performances = new LinkedList<>();
        for (int i = 0; i < 2; i++) {
            Performance performance = constructPerformance();

            performances.add(performance);
        }
        dao.adds(performances);
    }
}
