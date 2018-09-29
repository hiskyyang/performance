package com.exam.service;

import com.basic.service.BaseService;
import com.exam.vo.Exam;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class ExamService extends BaseService<Exam> {
    Logger log = Logger.getLogger(this.getClass());

}
