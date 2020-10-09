package com.example.demotest.Entity;

import lombok.Data;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * 职位对应福利类
 */
@Data
@Entity
@Table(name="tb_salary")
public class Salary implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    private Long id;       //雪花id
    private String job; // 职位
    private Float welfarePoints; //福利积分

}