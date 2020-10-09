package com.example.demotest.Controller;


import ch.qos.logback.classic.LoggerContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;


@Controller
public class AppController {

    private final Logger log= LoggerFactory.getLogger(LoggerContext.class);

    @RequestMapping("/")
    public String index() {
        log.info("index /");
        return "index";
    }

    @RequestMapping(value = "/login")
    public String login(String id,Model model) {
        log.info("前往登录");
        return "login";
    }
    /**
     * 无权限界面
     * */
    @RequestMapping(value = "/accessDenied")
    public String accessDeniedPage(Model model) {
        System.out.println("accessDenied");
        model.addAttribute("user", getUsername());
        model.addAttribute("role", getAuthority());
        log.info("accessDenied"+"user"+getUsername()+"role"+getAuthority());
        return "accessDenied";
    }
    /**
     * 注销
     * */
    @RequestMapping(value="/logout")
    public String logoutPage (HttpServletRequest request, HttpServletResponse response) {
        // Authentication是一个接口，表示用户认证信息
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        // 如果用户认知信息不为空，注销
        if (auth != null){
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        // 重定向到login页面
        return "redirect:/login?logout";
    }

    /**
     * 获得当前用户名称
     * */
    private String getUsername(){
        String id = SecurityContextHolder.getContext().getAuthentication().getName();
        log.info("username = " + id);
        return id;
    }

    /**
     * 获得当前用户权限
     * */
    private String getAuthority(){
        // 获得Authentication对象，表示用户认证信息。
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        List<String> roles = new ArrayList<String>();
        // 将角色名称添加到List集合
        for (GrantedAuthority a : authentication.getAuthorities()) {
            roles.add(a.getAuthority());
        }
        log.info("role = " + roles);
        return roles.toString();
    }

}

