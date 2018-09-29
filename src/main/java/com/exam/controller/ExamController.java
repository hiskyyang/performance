package com.exam.controller;

import com.basic.cache.service.CacheManager;
import com.code.vo.Code;
import com.exam.service.ExamService;
import com.exam.vo.Exam;
import com.measure.service.MeasureService;
import com.measure.vo.Measure;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("exam")
public class ExamController {
    @Autowired
    ExamService examService;
    @Autowired
    MeasureService measureService;
    @Autowired
    CacheManager cacheManager;

    @RequestMapping(value = "exam", method = {RequestMethod.GET})
    public ModelAndView exam(Exam exam) {
        ModelAndView mav = new ModelAndView();

        constructModelAndView(mav, exam);

        mav.setViewName("exam/exam");
        return mav;
    }

    private void constructModelAndView(ModelAndView mav, Exam exam) {
        mav.addObject("statuses", cacheManager.getCodes("examStatus"));

        if (exam.getExamId() != null) {
            exam = examService.get(exam);
            mav.addObject("exam", exam);
        }
    }

    @RequestMapping(value = "add", method = {RequestMethod.POST})
    @ResponseBody
    public int add(Exam exam) {
        try {
            examService.add(exam);
            return exam.getExamId();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @RequestMapping("delete")
    @ResponseBody
    public int delete(Exam exam) {
        try {
            Measure measure = new Measure();
            measure.setExamId(exam.getExamId());
            List<Measure> measures = measureService.list(measure);
            measures.forEach(m -> measureService.delete(m));

            return examService.delete(exam);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @RequestMapping("update")
    @ResponseBody
    public int update(Exam exam) {
        try {
            examService.update(exam);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @RequestMapping("list")
    public ModelAndView list(Exam exam) {
        ModelAndView mav = new ModelAndView();

        List<Exam> exams = examService.list(exam);
        format(exams);
        mav.addObject("exams", exams);
        mav.addObject("exam", exam);
        mav.setViewName("exam/list");
        return mav;
    }

    private void format(List<Exam> exams) {
        Map<String, String> examStatusMap = cacheManager.getCodeMap("examStatus");
        for (Exam exam : exams) {
            exam.setStatus(examStatusMap.get(exam.getStatus()));
        }
    }

    @InitBinder
    public void initBinder(ServletRequestDataBinder bin) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        CustomDateEditor cust = new CustomDateEditor(sdf, true);
        bin.registerCustomEditor(Date.class, cust);
    }
}
