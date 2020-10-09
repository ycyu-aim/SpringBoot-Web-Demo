package com.example.demotest.Controller;


import ch.qos.logback.classic.LoggerContext;
import com.example.demotest.Entity.Users;
import com.example.demotest.Service.UsersService;
import com.example.demotest.core.Result;
import com.example.demotest.util.ConvertUtil;
import com.example.demotest.util.PageData;
import com.example.demotest.util.redis.RedisKeyUtil;
import io.micrometer.core.instrument.util.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;
import java.util.Set;

@CrossOrigin   //跨域
@Controller
@RequestMapping("/user")
public class UserController {
   @Autowired
    private UsersService usersService;
    @Autowired
    RedisKeyUtil redisKeyUtilss;

    private final Logger log= LoggerFactory.getLogger(LoggerContext.class);

    /**
     * 用户管理界面
     * @param page 分页数据
     * @param rows
     * @param user 查询条件
     * @param model 查询条件数据回显
     * @return
     */
    @RequestMapping(value="/toUser.action")  //到管理员页面
    public String toReaderA(@RequestParam(defaultValue="1")Integer page,
                            @RequestParam(defaultValue="10")Integer rows, Users user,
                            Model model) {
        Page<Users> pageS =usersService.getUsersByPage(user,page, rows );
        List<Users> users = pageS.getContent();
        // 将分页查询出的结果数据进行分析，然后把数据存入到PageData对象中去保存起来响应给浏览器展示
        PageData pageData = new PageData();
        pageData.setPage(pageS.getNumber()+1);
        pageData.setRows(users);
        pageData.setSize(pageS.getSize());
        pageData.setTotal((int)pageS.getTotalElements());
        model.addAttribute("username",user.getUsername());
        model.addAttribute("eid",user.getEid());
        model.addAttribute("page",pageData);
        log.info("测试分页 查询出Content"+pageS.getContent() +"测试model数据"+model);
        return "admin/user";
    }

    /**
     *   输入联想  AJAX
     * @param
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/getUsernameList.action")
    public ResponseEntity<?> getUsernameList(String username){
        log.info("ajax传值"+username);
        Result result = new Result();
        if(StringUtils.isEmpty(username)){
            result.setCode(500);
            result.setMsg("FALSE");
            log.error("查询失败,返回值为"+result);
            return ResponseEntity.ok(result);
        }
        else if (!redisKeyUtilss.getSet(username).isEmpty()){
            Set<String> set = (Set<String>) redisKeyUtilss.getSet(username);
            log.info("set.toString"+set.toString());
            List lists = ConvertUtil.string2List(set.toString()
                    .substring(set.toString().length()-set.toString().length()+2,
                            set.toString().length()-2), ", ");;
            result.setCode(200);
            result.setMsg("OK");
            result.setData(lists);
            log.info("redis中查询出符合条件的姓名为"+result.getData());
            return ResponseEntity.ok(lists);
          }else {
              Set<String> set =  usersService.findUsernameByUsernameLike(username);
              redisKeyUtilss.addSet(username,set);redisKeyUtilss.expire(username,60*60);
              result.setCode(200);
              result.setMsg("OK");
              result.setData(set);
              log.info("查询出符合条件的姓名为"+result.getData());
              return ResponseEntity.ok(set);
          }

    }



    /**
     *   添加用户  AJAX
     * @param users 用户表单数据
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/add.action")
        public ResponseEntity<?> addUser(@RequestBody Users users){
        Result result = new Result();
        if(Objects.isNull(users)){
            result.setCode(500);
            result.setMsg("FALSE");
            log.error("添加失败,返回值为"+result);
            return ResponseEntity.ok(result);
        }
            result.setCode(200);
            result.setMsg("OK");
        usersService.saveUser(users);
        log.info("添加成功"+users);
        return ResponseEntity.ok(result);
    }

    /**
     * 通过id获取职工信息 详细查看或者修改使用
     * @param id
     * @return
     */
    @RequestMapping("/getUserById.action")
    @ResponseBody
    public Users getUserById(Long id) {
        if (id!=null){
                Users users = usersService.findById(id);
                log.info("get Users by id"+id);
                  return users;
        }else {
            log.error("数据异常");
            return null;
        }
    }
    /**
     * 更新职员  form数据序列化
     */
    @RequestMapping("/updateUser.action")
    @ResponseBody
    public  ResponseEntity<?>  userUpdate(Users users) {
        Result result = new Result();
        if(users.getId() != null){
            usersService.updateUser(users);
            result.setCode(200);
            result.setMsg("OK");
            log.info("操作成功,更新的职员id为"+users.getId());
            return ResponseEntity.ok(result);
       } else {
            result.setCode(500);
            result.setMsg("FALSE");
            log.error("操作失败"+result);
            return   ResponseEntity.ok(result);
        }
    }

    /**
     * 批量删除
     * @param ids
     * @return
     */
    @RequestMapping(value = "/deleteByIds.action",method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity deleteByIds(String ids) {
        Result result = new Result();
        if (ids.contains(",")) {
            List lists = ConvertUtil.string2List(ids, ",");
            try {
                //批量删除
                if (lists != null && lists.size() >= 1) {
                    log.info("批量删除开始 测试第一个数据ConvertUtil--" + ConvertUtil.stringToLong(lists.get(1).toString()));
                    for (int i = 0; i < lists.size(); i++) {
                        usersService.delete(ConvertUtil.stringToLong(lists.get(i).toString()));
                    }
                }
            } catch (Exception e) {
                result.setCode(500);
                result.setMsg("FALSE");
                log.error("批量删除操作失败+"+e);
                return ResponseEntity.ok(result);
            }
            result.setCode(200);
            result.setMsg("OK");
            log.info("批量删除成功,ids为"+lists);
            return ResponseEntity.ok(result);
        }else {
            List lists = ConvertUtil.array2List(ids);
            usersService.delete(ConvertUtil.stringToLong(lists.get(0).toString()));
            result.setCode(200);
            result.setMsg("OK");
            log.info("批量删除失败，进入单个删除,id为"+lists);
            return  ResponseEntity.ok(result);
        }
    }
    /**
     * 删除职员
     */
    @RequestMapping("/deleteUser.action")
    @ResponseBody
    public ResponseEntity<?> userDelete(Long id) {
        Result result = new Result();
        if(id != null ){ //success return
            usersService.delete(id);
            result.setCode(200);
            result.setMsg("OK");
            log.info("删除成功,id为"+id);
            return  ResponseEntity.ok(result);
        } else{  //false return
            result.setCode(500);
            result.setMsg("FALSE");
            log.error("删除失败,id为"+id);
            return   ResponseEntity.ok(result);
        }
    }

}
