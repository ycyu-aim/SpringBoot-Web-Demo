<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title >Spring Boot Security示例</title>
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=basePath%>css/app.css" />
<link rel="stylesheet" href="<%=basePath%>css/bootstrap-theme.min.css"/>
<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.css" />
<script type="text/javascript" src="<%=basePath%>js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>


<script type="text/javascript">

	$(function(){
		$("#loginBtn").click(function(){
			var username = $("#username");
			var password = $("#password");
			var msg = "";

			// if(password.val() === ""){
			// 	msg = "需要填写密码!";
			// 	password.focus();
			// }
			if(msg !== ""){
				console.log(msg);
				//配置一个透明的询问框
				return false;
			}
			$("#loginForm").submit();
		});
	});
</script>
</head>
<body>
<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title" align="center">简单Spring Boot 示例</h3>
		</div>
</div>
<div id="mainWrapper">
		<div class="login-container">
			<div class="login-card">
				<div class="login-form">
					<!-- 表单提交到login -->
					<form id="loginForm" action="<%=basePath%>login" method="post" class="form-horizontal">
					
						<c:if test="${param.error != null}">
							<div class="alert alert-danger">
								<p><font color="red">用户名或密码错误!</font></p>
							</div>
						</c:if>
						  
					    <c:if test="${param.logout != null}">
						  <div class="alert alert-success">
								<p><font color="red">用户已注销成功!</font></p>
							</div>
						</c:if> 
						<div class="input-group input-sm">
							<label class="input-group-addon"><i class="fa fa-user"></i></label>
							<input type="text"  class="form-control" id="username" name="username" placeholder="请输入用户名"/>
						</div>
						<div class="input-group input-sm">
							<label class="input-group-addon"><i class="fa fa-lock"></i></label> 
							<input type="password" class="form-control" id="password" name="password" placeholder="请输入密码"/>
						</div>
						<div class="form-actions">
							<input id="loginBtn" type="button"
								class="btn btn-block btn-primary btn-default" value="登录"/>
								
						</div>
					</form>
					<br>
<%--					<a href="/goRegisterPage" class="btn btn-block btn-primary btn-default">注册</a>--%>

				</div>
			</div>
		</div>
	</div>
</body>
</html>