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
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css" />
<%-- <link rel="stylesheet" href="<%=basePath%>css/app.css" /> --%>
<link rel="stylesheet" href="<%=basePath%>css/bootstrap-theme.min.css"/> 
<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.css" />
<script type="text/javascript" src="<%=basePath%>js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
<title>Insert title here</title>

</head>
<body>
<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">AccessDenied页面</h3>
		</div>
</div>
	<h3><span style="color: red; "></span> 您没有权限访问页面!
	<a href="<%=basePath%>logout">安全退出</a></h3>
</body>
</html>