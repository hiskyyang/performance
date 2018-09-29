package com.measure.service;

import com.basic.service.BaseService;
import com.exam.vo.Exam;
import com.measure.vo.Measure;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class MeasureService extends BaseService<Measure> {
    Logger log = Logger.getLogger(this.getClass());

}
