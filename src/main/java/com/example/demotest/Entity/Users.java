package com.example.demotest.Entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * 个人持久化类
 */
@Data
@Entity
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
@Table(name="tb_users")
public class Users implements Serializable{

    private static final long serialVersionUID = 1L;
    @Id
    private Long id;       //雪花id  用法 long id = SnowFlake.nextId();
    private String username; //员工姓名
    private String password; //密码
    private String sex;      //性别
    private Long eid;      //员工工号
    private String job;      //职位
    private Float basicSalary; //基本工资
    private Float welfarePoints;   //剩余积分
    private String phone;    //手机号
    private String idcard;   //身份证号
    @CreatedDate
    @JSONField(name = "joinTime",format = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date joinTime;   //入职时间
//    @DateTimeFormat()
    @JSONField(name = "leaveTime",format = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date leaveTime;   //离职时间
    private String address;  //地址
    private Boolean isWork;  //是否在职

    @ManyToOne( fetch=FetchType.EAGER,
            targetEntity=Role.class)
    @JoinColumn(name="rid",referencedColumnName="id")
    private Role role;

    @ManyToOne( fetch=FetchType.EAGER,
            targetEntity=Salary.class)
    @JoinColumn(name="sid",referencedColumnName="id")
    private Salary salary;
}



