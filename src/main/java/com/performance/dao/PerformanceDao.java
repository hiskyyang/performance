package com.performance.dao;

import com.basic.dao.BaseDao;
import com.measure.vo.Measure;
import com.performance.vo.Performance;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PerformanceDao extends BaseDao<Performance> {
    public void adds(List<Performance> performances) {
        sqlSession.insert("Performance.adds", performances);
    }
}
