package com.example.demotest.Entity;



import lombok.Data;
import lombok.ToString;

import java.io.Serializable;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;

import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
@Data
@Entity
@Table(name="tb_admin")
public class Admin implements Serializable{

    private static final long serialVersionUID = 1L;
    @Id
    private Long id;
    private String username;
    private String password;

    @ManyToMany(cascade = {CascadeType.REFRESH},fetch = FetchType.EAGER)  //级联
    @JoinTable(name="tb_admin_role",   //多对多生成的表
            joinColumns={@JoinColumn(name="aid")},
            inverseJoinColumns={@JoinColumn(name="roleid")})
    private List<Role> roles;
}







