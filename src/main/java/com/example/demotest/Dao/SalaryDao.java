package com.example.demotest.Dao;

import com.example.demotest.Entity.Salary;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface SalaryDao extends JpaRepository<Salary,Long>, JpaSpecificationExecutor<Salary> {

}
