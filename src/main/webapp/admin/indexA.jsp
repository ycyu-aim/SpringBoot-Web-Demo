<%@ page language="java"  import="java.util.*" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="navigationTag" uri="http://navigationTag.com/common/"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title></title>
<meta name="renderer" content="webkit"> 
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=basePath%>css/materialize.css">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<link rel="stylesheet" href="<%=basePath%>css/layui.css">

<%--	<script src="<%=basePath%>js/layui.js"></script>--%>
<%--	<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>--%>
<script src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/materialize.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/materialize.min.js"></script>
	<script type="text/javascript" src="http://static.cloud.linesno.com/asserts/ajax/libs/layer/layer.min.js"></script>

<script src="<%=basePath%>js/bootstrap.min.js"></script>

	<style type="text/css">
		.tp{
			font-size: 20px;
			color: #6d4c41;
		}
		header, main, footer {
			padding-left: 300px;
		}

		@media only screen and (max-width : 100%) {
			header, main, footer {
				padding-left: 0;
			}
		}

	</style>
<script type="text/javascript">
	function logout(){
		layer.confirm('确认退出，谨慎操作！', {icon: 7, title: '警告'}, function (index) {
			window.location.href = "<%=basePath%>logout"
		});
	}

</script>
</head>
<body>

			<nav>
				<div class="nav-wrapper">
					<a href="<%=basePath%>admin/indexA" class="brand-logo center">微人事</a>
					<ul id="nav-mobile" class="right hide-on-med-and-down">
						<li><button class="btn waves-effect waves-light black" onclick="logout()"/>注销</li>
					</ul>
				</div>
			</nav>


	<div class="row clearfix">
		<div id="ddd" class="col-md-2 column">
			<ul id="slide-out" class="side-nav fixed">
				<li><div class="userView">
					<div class="background">
						<img src="<%=basePath%>img/back.jpg">
					</div>
					<a ><img class="circle" src="<%=basePath%>img/myBoy.jpg"></a>
					<a ><span class="white-text name">Hello admin: ${admin.username}</span></a>
					<a ><span class="white-text email">765341731@qq.com</span></a>
				</div></li>
				<li><a href="<%=basePath%>admin/home" target="table"><i class="material-icons" >view_list</i>人事仪盘表</a></li>
				<li><a href="<%=basePath%>user/toUser.action" target="table"><i class="material-icons" >perm_contact_calendar</i>员工信息</a></li>
				<li><a  onclick="logout()"><i class="material-icons" >report_problem</i>注销</a></li>
					<div class="background">
						<img src="<%=basePath%>img/lore.jpg">
					</div>
					<div class="background">
						<img src="<%=basePath%>img/lore.jpg">
					</div>
			</ul>
		</div>

		<div class="col-md-10 column">

			<iframe  name="table" frameborder="0" width="100%" style="height:110%;">
            </iframe>
		</div>

	</div>
			<footer class="page-footer">
				<div class="container">
					<div class="row">
						<div class="col l6 s12">
							<%--                <h5 class="white-text">页脚内容</h5>--%>
							<%--                <p class="grey-text text-lighten-4">你可以用行和列来组织你的页脚内容。</p>--%>
						</div>
						<div class="col l4 offset-l2 s12">
							<%--                <h5 class="white-text">链接</h5>--%>
							<ul>
								<%--                    <li><a class="grey-text text-lighten-3" href="#!">链接 4</a></li>--%>
							</ul>
						</div>
					</div>
				</div>
				<div class="footer-copyright">
					<div class="container">
						© 2020 桂ICP备19012427号, All rights reserved.
					</div>
				</div>
			</footer>

</body>


</html>

