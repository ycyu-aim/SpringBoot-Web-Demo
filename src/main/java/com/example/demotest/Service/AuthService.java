package com.example.demotest.Service;



import java.util.ArrayList;
import java.util.List;

import com.example.demotest.Entity.Admin;
import com.example.demotest.Entity.Role;
import com.example.demotest.Entity.Users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;



/**
 * 需要实现UserDetailsService接口
 * 因为在Spring Security中配置的相关参数需要是UserDetailsService类型的数据
 * */
@Service
public class AuthService implements UserDetailsService{

    // 注入持久层接口UserRepository
    @Autowired
    AdminService adminService;

    @Autowired
    UsersService userService;
    @Autowired
    PasswordEncoder passwordEncoder;

    /*
     *  重写UserDetailsService接口中的loadUserByUsername方法，通过该方法查询到对应的用户(non-Javadoc)
     *  返回对象UserDetails是Spring Security中一个核心的接口。
     *  其中定义了一些可以获取用户名、密码、权限等与认证相关的信息的方法。
     */

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 调用持久层接口findByLoginName方法查找用户，此处的传进来的参数实际是id
        System.out.println("loadUserByUsername");
        Admin admin=null;
        Users users = null;
        try {
            admin = adminService.findByUsername(username);
        } catch (Exception e) {
            // TODO: handle exception
        }
        try {
            users = userService.findByUsername(username);
        } catch (Exception e) {
            // TODO: handle exception
        }

        if(admin==null && users ==null)
            throw new UsernameNotFoundException("用户名不存在");

        List<GrantedAuthority> authorities = new ArrayList<>();
        String password = null;
        List<Role> roles = null;
        if (admin != null){
            System.out.println(admin);
            roles= admin.getRoles();
            password=admin.getPassword().trim();
            // 获得当前用户权限集合
            for (Role role : roles) {
                // 将关联对象Role的authority属性保存为用户的认证权限
                authorities.add(new SimpleGrantedAuthority(role.getAuthority()));
            }
        }
        if(users !=null){
            System.out.println(users);
            Role  role= users.getRole();
            authorities.add(new SimpleGrantedAuthority(role.getAuthority()));
            password=users.getPassword().trim();
        }
        // 创建List集合，用来保存用户权限，GrantedAuthority对象代表赋予给当前用户的权限
        System.out.println("测试"+passwordEncoder.encode("1"));
        System.out.println("loadUserByUsername");
        // 此处返回的是org.springframework.security.core.userdetails.User类，该类是Spring Security内部的实现
        return new User(username, password, authorities);
    }

}
