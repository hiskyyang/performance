package com.measure.dao;

import com.exam.dao.ExamDao;
import com.exam.vo.Exam;
import com.measure.vo.Measure;
import org.junit.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.testng.AbstractTestNGSpringContextTests;
import org.testng.annotations.Test;

import java.util.Date;

@ContextConfiguration("classpath:/spring/spring-test.xml")
public class MeasureDaoTest extends AbstractTestNGSpringContextTests {
    @Autowired
    MeasureDao dao;

    @Test
    public void test() throws Exception {
        Measure measure = new Measure();
        measure.setName("Test");
        measure.setDescription("Description");
        measure.setWeight(100);
        measure.setExamId(0);
        measure = dao.add(measure);

        measure.setName("Updated");
        dao.update(measure);

        measure = dao.get(measure);
        System.out.println(measure);

        int effectRows = dao.delete(measure);
        Assert.assertEquals(effectRows == 1, true);
    }
}
