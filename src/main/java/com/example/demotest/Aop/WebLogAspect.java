package com.example.demotest.Aop;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import javax.persistence.EntityManager;
import javax.servlet.http.HttpServletRequest;
import javax.xml.crypto.Data;
import javax.xml.ws.Response;

import com.example.demotest.Dao.LogDao;
import com.example.demotest.Entity.Log;
import com.example.demotest.util.snowflakeId.SequenceUtils;
import org.apache.poi.ss.formula.functions.Now;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Aspect
@Component
public class WebLogAspect {

    private final Logger logger = LoggerFactory.getLogger(WebLogAspect.class);
    @Autowired
    LogDao logDao;
    @Autowired
    private EntityManager entityManager;
    /**
     * 调用controller包下的任意类的任意方法时均会调用此方法
     */
    @Pointcut("execution(* com.example.demotest.Controller.*.*(..))")
    public void pointCut() {}

    @Around("pointCut()")
    public Object run(ProceedingJoinPoint joinPoint) throws Throwable {

        //获取方法参数值数组
        Object[] args = joinPoint.getArgs();
        //得到其方法签名
        MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
        //获取方法参数类型数组
        Class[] paramTypeArray = methodSignature.getParameterTypes();
        Date date = new Date();
        long startTime = System.currentTimeMillis();
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");

        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();//这个RequestContextHolder是Springmvc提供来获得请求的东西
        HttpServletRequest request = ((ServletRequestAttributes)requestAttributes).getRequest();

        if (args.length==0&&paramTypeArray.length==0){
            Object result = joinPoint.proceed(args);
            return result;
        }

        if (EntityManager.class.isAssignableFrom(paramTypeArray[paramTypeArray.length - 1])) {
            //如果方法的参数列表最后一个参数是entityManager类型，则给其赋值
            args[args.length - 1] = entityManager;
        }

            logger.info("======>请求:{}接口开始,开始时间:{}", request.getRequestURL().toString(),formatter.format(date.getTime()));
            logger.info("请求参数为{}",args);
            // 记录下请求内容
            logger.info("################URL : " + request.getRequestURL().toString());
            logger.info("################HTTP_METHOD : " + request.getMethod());
            logger.info("################IP : " + request.getRemoteAddr());
            logger.info(("################formatter_Start_Time : " + formatter.format(date.getTime())));
            //下面这个getSignature().getDeclaringTypeName()是获取包+类名的   然后后面的joinPoint.getSignature.getName()获取了方法名
            logger.info("################CLASS_METHOD : " + joinPoint.getSignature().getDeclaringTypeName() + "." + joinPoint.getSignature().getName());
            long endTime = System.currentTimeMillis();
             Date date1 = new Date();

            logger.info("======>请求:{}接口完成,结束时间:{},耗时:{}毫秒",  request.getRequestURL().toString(),formatter.format(date1.getTime()),(endTime - startTime));
        //动态修改其参数
        //注意，如果调用joinPoint.proceed()方法，则修改的参数值不会生效，必须调用joinPoint.proceed(Object[] args)
        Object result = joinPoint.proceed(args);
        logger.info("响应结果为{}",result);

        //如果这里不返回result，则目标对象实际返回值会被置为null
        //持久化日志
        Log log = new Log();
        log.setId(SequenceUtils.nextId());
        log.setUrl(request.getRequestURL().toString());
        log.setHttp_method(request.getMethod());

        if (Arrays.toString(args).length()>200){
            log.setArgs(Arrays.toString(args).substring(0,200));
        }else {
            log.setArgs(Arrays.toString(args));
        }
        log.setResult(result.toString());
        log.setIp(request.getRemoteAddr());
        log.setStartTime(date);
        log.setEndTime(date1);
        log.setDurationTime(endTime - startTime);
        logger.info("持久化日志{}",log);
        logDao.save(log);
        return result;
    }


}
