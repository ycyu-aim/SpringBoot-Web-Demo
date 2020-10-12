package com.example.demotest.Controller;


import ch.qos.logback.classic.LoggerContext;
import com.example.demotest.Entity.Admin;
import com.example.demotest.Service.AdminService;
import com.example.demotest.Service.UsersService;
import com.example.demotest.util.ConvertUtil;
import com.example.demotest.util.redis.RedisKeyUtil;
//import io.micrometer.core.instrument.util.StringUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/admin")
public class AdminController {


    @Autowired
    private AdminService adminService;
    @Autowired
    private UsersService usersService;
    @Autowired
    RedisKeyUtil redisKeyUtilss;


    private final Logger log= LoggerFactory.getLogger(LoggerContext.class);

    @RequestMapping("/indexA")
    public String indexS(HttpSession session, HttpServletResponse response) {
        String forword="admin/indexA";
        Admin admin=adminService.findByUsername(this.getUsername());
        session.setAttribute("admin", admin);
        log.info("进入管理员界面 当前管理员为+"+admin);
        return forword;
    }
  /*
    仪表盘界面
   */
    @RequestMapping("/home")
    public String welcome(Model model) {
        String forword="admin/home";
//        先查缓存中是否有数据如果没有数据再去查询数据库并把数据放入缓存失效时间为一个小时
        if (StringUtils.isNotEmpty(redisKeyUtilss.getString("longTotal"))){
            Long longTotal  = ConvertUtil.stringToLong(redisKeyUtilss.getString("longTotal"));
            Long joinCount  = ConvertUtil.stringToLong(redisKeyUtilss.getString("joinCount"));
            Long leaveCount  = ConvertUtil.stringToLong(redisKeyUtilss.getString("leaveCount"));
            model.addAttribute("longTotal",longTotal);
            model.addAttribute("joinCount",joinCount);
            model.addAttribute("leaveCount",leaveCount);
            log.info("redis返回+"+model.toString());
            return forword;
        } else {
            Long longTotal = usersService.countUserByIsWork();
            Long joinCount = usersService.countRecentlyJoinedWorker();
            Long leaveCount = usersService.countRecentlyLeaveWorker();
            redisKeyUtilss.setString("longTotal",longTotal.toString());redisKeyUtilss.expire("longTotal",60*60);
              redisKeyUtilss.setString("joinCount",joinCount.toString());redisKeyUtilss.expire("joinCount",60*60);
               redisKeyUtilss.setString("leaveCount",leaveCount.toString());redisKeyUtilss.expire("leaveCount",60*60);

            model.addAttribute("longTotal",longTotal);
            model.addAttribute("joinCount",joinCount);
            model.addAttribute("leaveCount",leaveCount);
            log.info("进入仪表盘界面 当前mdel返回的数据为+"+model.toString());
            return forword;
        }

    }
    /*
     各职业人数分布 饼图 开发工程师 实施工程师 DBA 产品经理 项目经理 HR 顺序分布（size=6）
     */
    @ResponseBody
    @RequestMapping("/getPie1")
    public ResponseEntity<?> getPie(){
        if (StringUtils.isNotEmpty(redisKeyUtilss.getString("getPie1"))){
            List lists = ConvertUtil.string2List(redisKeyUtilss.getString("getPie1").substring(1,17), ", ");
            List list2 = new ArrayList();
            for (int i = 0; i < lists.size(); i++){
                list2.add(ConvertUtil.stringToLong(lists.get(i).toString()));
            }
            log.info("从redis中取出各职业人数分布 饼图"+list2);
            return ResponseEntity.ok(list2);
        } else {
            List list = usersService.getUserCountByJob();
            redisKeyUtilss.setString("getPie1",list.toString());redisKeyUtilss.expire("getPie1",60*60);
            log.info("存入list 饼图");
            log.info("各职业人数分布 饼图 开发工程师 实施工程师 DBA 产品经理 项目经理 HR 顺序分布（size=6）"+list);
            return ResponseEntity.ok(list);
        }

    }

    @ResponseBody
    @RequestMapping("/getBar1")
    public ResponseEntity<?> getBar(){
        if (StringUtils.isNotEmpty(redisKeyUtilss.getString("getBar1"))){
            //        取  去掉首位跟末尾 [] 在按 ", " 截取 后 List<String> to List<Long>
            List lists = ConvertUtil.string2List(redisKeyUtilss.getString("getBar1").substring(1,11), ", ");

            List list2 = new ArrayList();
            for (int i = 0; i < lists.size(); i++){
                list2.add(ConvertUtil.stringToLong(lists.get(i).toString()));
            }
            log.info("redis各工资阶段人数分布 柱形图 "+list2);
            return ResponseEntity.ok(list2);
        } else {
            List list = usersService.countByIsWorkAndBasicSalaryBetween();
            redisKeyUtilss.setString("getBar1",list.toString());redisKeyUtilss.expire("getBar1",60*60);
            log.info("各工资阶段人数分布 柱形图 0-5K 5-10k 10-15k >15k "+list);
            return ResponseEntity.ok(list);
        }
    }
    /*
     12个月入职离职分布折线图 X轴为月份 Y轴为人数  line1
     */
    @ResponseBody
    @RequestMapping("/getline1")
    public ResponseEntity<?> getLine(){

         if (StringUtils.isNotEmpty(redisKeyUtilss.getString("timeDateMM"))){
             //        取  去掉首位跟末尾 [] 在按 ", " 截取 后 List<String> to List<Long>
             List moutnRedis = ConvertUtil.string2List(redisKeyUtilss.getString("timeDateMM")
                     .substring(redisKeyUtilss.getString("timeDateMM").length()-redisKeyUtilss.getString("timeDateMM").length()+1,
                             redisKeyUtilss.getString("timeDateMM").length()-1), ", ");
             List joinCountRedis = ConvertUtil.string2List(redisKeyUtilss.getString("INScanCount")
                     .substring(redisKeyUtilss.getString("INScanCount").length()-redisKeyUtilss.getString("INScanCount").length()+1,
                             redisKeyUtilss.getString("INScanCount").length()-1), ", ");
             List leaveCountRedis = ConvertUtil.string2List(redisKeyUtilss.getString("OutScanCount")
                     .substring(redisKeyUtilss.getString("OutScanCount").length()-redisKeyUtilss.getString("OutScanCount").length()+1,
                             redisKeyUtilss.getString("OutScanCount").length()-1), ", ");
             List dataList = new ArrayList();
             dataList.add(moutnRedis);
             dataList.add(joinCountRedis);
             dataList.add(leaveCountRedis);
             log.info(" redis 12个月入职离职分布折线图 X轴为月份 Y轴为人数  line1"+dataList);
             return ResponseEntity.ok(dataList);
         }else {
             List<Map<String, Object>> mapList = usersService.getJoinAndLeaveByMouth();
        /*
        将数据分别放入 count month
         */
             List moutn = new ArrayList();
             List joinCount = new ArrayList();
             List leaveCount = new ArrayList();
             final String  mm= "月";
//             oracle
             for (Map<String, Object> map:mapList){
                 moutn.add(map.get("timeDateMM")+mm);
                 joinCount.add(map.get("INScanCount"));
             }
//             mysql
//             for (Map<String, Object> map:mapList){
//                 moutn.add(map.get("month")+mm);
//                 joinCount.add(map.get("INScanCount"));
//             }

             for (Map<String, Object> map1:mapList){
                 leaveCount.add(map1.get("OutScanCount"));
             }

             redisKeyUtilss.setString("timeDateMM",moutn.toString());redisKeyUtilss.expire("timeDateMM",60*60);
             redisKeyUtilss.setString("INScanCount",joinCount.toString());redisKeyUtilss.expire("INScanCount",60*60);
             redisKeyUtilss.setString("OutScanCount",leaveCount.toString());redisKeyUtilss.expire("OutScanCount",60*60);
             List dataList = new ArrayList();
             dataList.add(moutn);
             dataList.add(joinCount);
             dataList.add(leaveCount);

             log.info(" 12个月入职离职分布折线图 X轴为月份 Y轴为人数  line1"+dataList);
             return ResponseEntity.ok(dataList);
         }

    }

    /**
     * 根据id查询客户详情
     */
    private String getUsername(){
        String id = SecurityContextHolder.getContext().getAuthentication().getName();
        log.info("username = " + id);
        return id;
    }
}

