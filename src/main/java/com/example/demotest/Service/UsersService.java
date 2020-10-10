package com.example.demotest.Service;



import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import com.example.demotest.Dao.UsersDao;
import com.example.demotest.Entity.Role;
import com.example.demotest.Entity.Users;
import com.example.demotest.Enum.BasicSalary;
import com.example.demotest.Enum.Job;

import com.example.demotest.util.snowflakeId.SequenceUtils;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.servlet.http.HttpServletResponse;


import io.micrometer.core.instrument.util.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.*;


@Service
public class UsersService {
    @Autowired
    private UsersDao userDao;
    // 依赖注入加密接口
    @Autowired
    private PasswordEncoder passwordEncoder;

    public Users findByUsername(String username) {
        return userDao.findByUsername(username).get();
    }

    /**
     *  详情查看 user by id
     * @param id
     * @return
     */
    public Users findById(Long id) {
        return userDao.getOne(id);
    }

    /**
     * 添加员工 需要事务支持
     * @param user
     */
    @Transactional
    public void   saveUser(Users user) {
        user.setEid(userDao.getMaxEiD()+1);
        user.setId(SequenceUtils.nextId()); //雪花算法ID生成
        user.setPassword("$2a$10$36A/etwTPl2PscyArcEpzeAyvhC3cd1IJZYMXv27jIp67j0BOOpJa");
//        user.setRole();
        user.setJoinTime(new Date());
        user.setIsWork(Boolean.TRUE);
        userDao.save(user);
        userDao.setUserRole(user.getId());
        System.out.println("user.getId()"+user.getId());
    };
    /**
     * 修改密码 需要事务支持
     */
    @Modifying
    @Transactional
    public void   updatePassword(Long id,String password) {
            userDao.updatePassword(id,passwordEncoder.encode(password));
    };
    /**
     * 修改员工 需要事务支持
     * @param user
     */
    @Modifying
    @Transactional
    public void   updateUser(Users user) {
        if(!user.getIsWork()&&user.getLeaveTime()==null){
            user.setLeaveTime(new Date());
            userDao.save(user);
            userDao.setUserRole(user.getId());
        }else {
            user.setLeaveTime(null);
            userDao.save(user);
            userDao.setUserRole(user.getId());
        }

    };
    //删除 需要事务支持
    @Transactional
    public void delete(Long id) {
        userDao.deleteById(id);
    };

    //分页查询用户信息
    @SuppressWarnings("serial")
    public Page<Users> getUsersByPage( final Users user , int pageIndex , int pageSize ) {
        // 指定排序参数对象：根据id，进行降序查询
        Sort sort = Sort.by(Sort.Direction.DESC, "id");
        // 分页查询用户信息，返回分页实体对象数据,过滤条件为员工编号、姓名、职位。
        // pages对象中包含了查询出来的数据信息，以及与分页相关的信息
        Page<Users>  pages= userDao.findAll(new Specification<Users>() {
            @Override
            public Predicate toPredicate(Root<Users> root, CriteriaQuery<?> query,
                                         CriteriaBuilder cb) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if(user!=null){
                    if(user.getIsWork()==null){
                    if(!StringUtils.isEmpty(user.getUsername())){
                        predicates.add(cb.like(root.<String> get("username"), "%"+user.getUsername()+"%"));
                    }
                    if(user.getEid() != null){
                        predicates.add(cb.equal(root.<String> get("eid"), user.getEid()));
                    }
                    if(!StringUtils.isEmpty(user.getSex())){
                        predicates.add(cb.equal(root.<String> get("sex"), user.getSex()));
                    }
                    if(!StringUtils.isEmpty(user.getJob())){
                        predicates.add(cb.equal(root.<String> get("job"), user.getJob()));
                    }
                    }
                    else if (user.getIsWork()){
                        predicates.add(cb.equal(root.<String> get("isWork"), user.getIsWork()));

                            if (!StringUtils.isEmpty(user.getUsername())) {
                                predicates.add(cb.like(root.<String>get("username"), "%" + user.getUsername() + "%"));
                            }
                            if (user.getEid() != null) {
                                predicates.add(cb.equal(root.<String>get("eid"), user.getEid()));
                            }
                            if (!StringUtils.isEmpty(user.getSex())) {
                                predicates.add(cb.equal(root.<String>get("sex"), user.getSex()));
                            }
                            if (!StringUtils.isEmpty(user.getJob())) {
                                predicates.add(cb.equal(root.<String>get("job"), user.getJob()));
                            }

                    }else {
                        predicates.add(cb.equal(root.<String> get("isWork"), user.getIsWork()));
                            if (user.getEid() != null) {
                                predicates.add(cb.equal(root.<String>get("eid"), user.getEid()));
                            }
                            if (!StringUtils.isEmpty(user.getSex())) {
                                predicates.add(cb.equal(root.<String>get("sex"), user.getSex()));
                            }
                            if (!StringUtils.isEmpty(user.getJob())) {
                                predicates.add(cb.equal(root.<String>get("job"), user.getJob()));
                            }
                    }
                }
                return query.where(predicates.toArray(new Predicate[predicates.size()])).getRestriction();
            }
        },PageRequest.of(pageIndex-1, pageSize, sort));
        return pages;
    };

    /**
     * 查询在职员工工资分布情况 柱形图
     * @return
     */
    public List countByIsWorkAndBasicSalaryBetween(){
        List list = new ArrayList();
        for(BasicSalary basicSalary: BasicSalary.values()){
            Long count = userDao.countByIsWorkAndBasicSalaryBetween(Boolean.TRUE,basicSalary.getDown(),basicSalary.getUp());
            list.add(count);
        }
        return list;
    }

    /*
    查询在职人数
     */
    public Long countUserByIsWork(){
        return  userDao.countByIsWork(Boolean.TRUE);
    }

    /*
   查询最近一个月入职人数
    */
    public Long countRecentlyJoinedWorker(){
        return  userDao.countRecentlyJoinedWorker();
    }
    /*
   查询最近一个月离职人数
    */
    public Long countRecentlyLeaveWorker(){
        return  userDao.countRecentlyLeaveWorker();
    }

    /*
    通过职位查询数量  饼图 p1
     */
    public  List getUserCountByJob( ){
        List list = new ArrayList();
        for(Job job: Job.values()){
            Long count = userDao.countByJobAndIsWork(job.getCode(),Boolean.TRUE);
            System.out.println(job.getCode()+count);
           list.add(count);
        }
        return list;
    }
    /*
    查询今年十二个月离职和入职的同事分布情况  折线图
     */
    public List<Map<String, Object>> getJoinAndLeaveByMouth(){
        return userDao.getJoinAndLeaveByMouth();
    }

    /**
     * 查询 like姓名的员工 前端输入联想
     * @param username
     * @return
     */
    public Set<String> findUsernameByUsernameLike(String username){
        return userDao.findUsernameByUsernameLike(username);
    }

    public void downExcel(HttpServletResponse response){
        List<Users> list = getAllUser();

        //指定列表标题和工作表名称
        ExportParams params = new ExportParams("职员信息表","职员");
        Workbook workbook = ExcelExportUtil.exportExcel(params,Users.class,list);
        response.setHeader("content-Type","application/vnd.ms-excel");
         final String fileOthername="职员信息表";
        response.setHeader("Content-Disposition","attachment;filename="+System.currentTimeMillis()+fileOthername+".xls");
        response.setCharacterEncoding("UTF-8");
        try {;
            workbook.write(response.getOutputStream());
            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public List<Users> getAllUser(){
        return userDao.findAll();
    }


    public void downExcelByIds(HttpServletResponse response,List list){
        //指定列表标题和工作表名称
        ExportParams params = new ExportParams("职员信息表","职员");
        Workbook workbook = ExcelExportUtil.exportExcel(params,Users.class,list);
        response.setHeader("content-Type","application/vnd.ms-excel");
        final String fileOthername="职员信息表";
        response.setHeader("Content-Disposition","attachment;filename="+System.currentTimeMillis()+fileOthername+".xls");
        response.setCharacterEncoding("UTF-8");
        try {
            workbook.write(response.getOutputStream());
            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }



}

