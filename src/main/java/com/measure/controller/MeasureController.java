package com.measure.controller;

import com.basic.cache.service.CacheManager;
import com.measure.service.MeasureService;
import com.measure.vo.Measure;
import com.user.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("measure")
public class MeasureController {
    @Autowired
    MeasureService measureService;
    @Autowired
    CacheManager cacheManager;

    @RequestMapping(value = "measure", method = {RequestMethod.GET})
    public ModelAndView measure(Measure measure) {
        ModelAndView mav = new ModelAndView();

        constructModelAndView(mav, measure);

        mav.setViewName("measure/measure");
        return mav;
    }

    private void constructModelAndView(ModelAndView mav, Measure measure) {
        if (measure.getMeasureId() != null) {
            measure = measureService.get(measure);
            mav.addObject("measure", measure);
        }
    }

    @RequestMapping(value = "add", method = {RequestMethod.POST})
    @ResponseBody
    public int add(Measure measure) {
        try {
            measureService.add(measure);
            return measure.getMeasureId();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @RequestMapping("delete")
    @ResponseBody
    public int delete(Measure measure) {
        try {
            return measureService.delete(measure);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @RequestMapping("update")
    @ResponseBody
    public int update(Measure measure) {
        try {
            measureService.update(measure);
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @RequestMapping("list")
    public ModelAndView list(HttpServletRequest request, Measure measure) {
        ModelAndView mav = new ModelAndView();

        List<Measure> measures = measureService.list(measure);

        User sessionUser = (User) request.getSession().getAttribute("user");
        if(!sessionUser.getRole().equals("0")){
            measures = Collections.emptyList();
        }
        mav.addObject("measures", measures);
        mav.addObject("measure", measure);
        mav.setViewName("measure/list");
        return mav;
    }
}
