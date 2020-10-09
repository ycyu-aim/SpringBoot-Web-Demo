package com.example.demotest.Entity;



import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Table(name="tb_role")
public class Role implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name="id")
    private Long id;
    @Column(name="authority")
    private String authority;
    private String authorityDesc;

    public Role() {
        super();
        // TODO Auto-generated constructor stub
    }

}

