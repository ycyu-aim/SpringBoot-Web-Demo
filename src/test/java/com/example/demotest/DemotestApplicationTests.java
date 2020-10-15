package com.example.demotest;

import ch.qos.logback.classic.LoggerContext;
import com.example.demotest.Dao.LogDao;
import com.example.demotest.Entity.Log;
import com.example.demotest.Entity.Users;
import com.example.demotest.Service.LogService;
import com.example.demotest.Service.UsersService;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@SpringBootTest
class DemotestApplicationTests {

    @Test
    void contextLoads() {
        Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        log.info("当前时间{}"+formatter.format(date));
//        List<Map<String, Object>> mapList = logService.countByToday();
//        log.info("当前ListDATA{}"+mapList.toString());
    }

    @Autowired
    private LogService logService;

    private final Logger log= LoggerFactory.getLogger(LoggerContext.class);

}
