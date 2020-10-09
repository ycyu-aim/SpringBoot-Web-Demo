package com.example.demotest;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configurable
@SpringBootApplication()
public class DemotestApplication {

    public static void main(String[] args) {

        SpringApplication.run(DemotestApplication.class, args);
    }
    /*
     *  BCryptPasswordEncoder是Spring Security提供的PasswordEncoder接口是实现类
     *  用来创建密码的加密程序，避免明文存储密码到数据库
     */
    @Bean
    public PasswordEncoder passwordEncoder() {

        return new BCryptPasswordEncoder();
    }

}
