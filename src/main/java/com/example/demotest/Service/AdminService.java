package com.example.demotest.Service;

import com.example.demotest.Dao.AdminDao;
import com.example.demotest.Entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class AdminService {
    @Autowired
    private AdminDao adminDao;

    public Admin findByUsername(String username) {
        // TODO Auto-generated method stub
        return adminDao.findByUsername(username).get();
    }
}