package com.example.demotest.Dao;

import com.example.demotest.Entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
                                        //Users为实体类名称，Long为主键Id类型，JpaSpecificationExecutor为分页查询
public interface UsersDao extends JpaRepository<Users,Long> , JpaSpecificationExecutor<Users> {
    /**
     * 登录鉴权使用
     * @param username
     * @return
     */
    Optional<Users> findByUsername(String username);

    /**
     * 分职位查询在职的员工数量 饼图
     * @param job
     * @param iswork
     * @return
     */
    Long countByJobAndIsWork(String job,Boolean iswork);

    /**
     * 查询在职员工工资分布情况 柱形图
     * @param iswork
     * @param down
     * @param up
     * @return
     */
    Long countByIsWorkAndBasicSalaryBetween(Boolean iswork,Float down,Float up);

    /**
     * 查询在职员工数量
     * @param isWork
     * @return
     */
    Long countByIsWork(Boolean isWork);

    /**
     * 添加新员工时查询最大的工号
     * @return
     */
    @Query("select  coalesce(max(u.eid),0)  from Users u ")
    Long getMaxEiD( );

    /**
     * 查询最近一个月入职的员工总数
     * @return
     */
    @Query(value = "select count(id) AS total from TB_USERS where JOIN_TIME>systimestamp-interval'30'day",nativeQuery = true)
    Long countRecentlyJoinedWorker();
    /**
     * 查询最近一个月离职的员工总数
     * @return
     */
    @Query(value = "select count(id) AS total from TB_USERS where LEAVE_TIME>systimestamp-interval'30'day",nativeQuery = true)
    Long countRecentlyLeaveWorker();

    /**
     * 查询今年十二个月离职和入职的同事分布情况  折线图
     * @return
     */
    @Query(value = "select t2.datevalue as timeDateMM, nvl(t1.count, 0) as INScanCount ,nvl(t0.count, 0) as OutScanCount \n" +
            "  from (select count(*) as count, month_time\n" +
            "          from (select to_char(TB_USERS.LEAVE_TIME, 'MM') as month_time\n" +
            "                  from TB_USERS)\n" +
            "         group by month_time\n" +
            "         order by month_time asc) t0,\n" +
            "         \n" +
            "          (select count(*) as count, month_time\n" +
            "          from (select to_char(TB_USERS.JOIN_TIME, 'MM') as month_time\n" +
            "                  from TB_USERS)\n" +
            "         group by month_time\n" +
            "         order by month_time asc) t1,\n" +
            "         \n" +
            "       (select '' || lpad(level, 2, 0) datevalue\n" +
            "          from dual\n" +
            "        connect by level < 13) t2\n" +
            "        \n" +
            " where t0.month_time(+) = t2.datevalue AND t1.month_time(+) = t2.datevalue\n" +
            " order by t2.datevalue\n",nativeQuery = true)
          List<Map<String, Object>> getJoinAndLeaveByMouth();

    /**
     * 查询 like姓名的员工
     * @param
     * @return
     */
    @Query(value = " SELECT USERNAME FROM TB_USERS where USERNAME LIKE '%'||?1||'%' ",nativeQuery = true)
    Set<String> findUsernameByUsernameLike(String username);
}
