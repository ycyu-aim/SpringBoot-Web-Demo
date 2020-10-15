package com.example.demotest.Entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelTarget;
import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.io.Serializable;
import javax.persistence.*;

/**
 * 个人持久化类
 */
@Data
@Entity
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
@Table(name="tb_users")
@ExcelTarget("Users")
public class Users implements Serializable{

    private static final long serialVersionUID = 1L;
    @Id
    @Excel(name = "ID", width = 20)
    private Long id;       //雪花id  用法 long id = SnowFlake.nextId();
    @Excel(name = "员工姓名")
    private String username; //员工姓名
    @Excel(name = "密码", width = 20)
    private String password; //密码
    @Excel(name = "性别", width = 10)
    private String sex;      //性别
    @Excel(name = "员工工号", width = 10)
    private Long eid;      //员工工号
    @Excel(name = "职位", width = 10)
    private String job;      //职位
    @Excel(name = "基本工资", width = 10)
    private Float basicSalary; //基本工资
//    @Excel(name = "剩余积分", width = 10)
    private Float welfarePoints;   //剩余积分
    @Excel(name = "手机号", width = 20)
    private String phone;    //手机号
    @Excel(name = "身份证号", width = 20)
    private String idcard;   //身份证号
    @CreatedDate
    @JSONField(name = "joinTime",format = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "入职时间", databaseFormat = "yyyyMMddHHmmss", format = "yyyy-MM-dd",  width = 20)
    private Date joinTime;   //入职时间
//    @DateTimeFormat()
    @JSONField(name = "leaveTime",format = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "离职时间", databaseFormat = "yyyyMMddHHmmss", format = "yyyy-MM-dd",  width = 20)
    private Date leaveTime;   //离职时间
    @Excel(name = "地址", width = 20)
    private String address;  //地址
    @Excel(name = "是否在职", width = 10)
    private Boolean isWork;  //是否在职

    @ManyToOne( fetch=FetchType.EAGER,
            targetEntity=Role.class)
    @JoinColumn(name="rid",referencedColumnName="id")
    private Role role;

}



