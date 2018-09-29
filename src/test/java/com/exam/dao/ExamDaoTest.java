package com.exam.dao;

import com.exam.vo.Exam;
import org.junit.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.testng.AbstractTestNGSpringContextTests;
import org.testng.annotations.Test;

import java.util.Date;

@ContextConfiguration("classpath:/spring/spring-test.xml")
public class ExamDaoTest extends AbstractTestNGSpringContextTests {
    @Autowired
    ExamDao dao;

    @Test
    public void test() throws Exception {
        Exam exam = new Exam();
        exam.setName("Test");
        exam.setStartTime(new Date());
        exam.setEndTime(new Date());
        exam.setStatus("1");
        exam = dao.add(exam);

        exam.setName("Updated");
        dao.update(exam);

        exam = dao.get(exam);
        System.out.println(exam);

        int effectRows = dao.delete(exam);
        Assert.assertEquals(effectRows == 1, true);
    }
}
