<%@ page language="java"  import="java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="navigationTag" uri="http://navigationTag.com/common/"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">

    <link rel="stylesheet" href="<%=basePath%>css/materialize.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

	<script type="text/javascript" src="<%=basePath%>js/js113.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/materialize.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/materialize.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
	<script src="http://static.runoob.com/assets/jquery-validation-1.14.0/lib/jquery.js"></script>
	<script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
	<script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>



<style type="text/css">
	.error{
		color:red;
	}
	.tp{
		font-size: 20px;
	}
    input::-webkit-input-placeholder{
        color:red;
    }
    input::-moz-placeholder{   /* Mozilla Firefox 19+ */
        color:red;
    }
    input:-moz-placeholder{    /* Mozilla Firefox 4 to 18 */
        color:red;
    }
    input:-ms-input-placeholder{  /* Internet Explorer 10-11 */
        color:red;
    }

    /* label color */
    .input-field label {
        color: #000;
    }
    /* label focus color */
    .input-field input[type=text]:focus + label {
        color: #000;
    }
    /* label underline focus color */
    .input-field input[type=text]:focus {
        border-bottom: 1px solid #000;
        box-shadow: 0 1px 0 0 #000;
    }
    /* valid color */
    .input-field input[type=text].valid {
        border-bottom: 1px solid #000;
        box-shadow: 0 1px 0 0 #000;
    }
    /* invalid color */
    .input-field input[type=text].invalid {
        border-bottom: 1px solid #000;
        box-shadow: 0 1px 0 0 #000;
    }
    /* icon prefix focus color */
    .input-field .prefix.active {
        color: #000;
    }


</style>
	<style type="text/css">
		.autoComplete {margin:8px;position:relative;float:left;}
		.autoComplete input {width:200px;height:25px;margin:0;padding:0;line-height:25px;}
		.autoComplete ul {z-index:-12;padding:0px;margin:0px;border:1px #333 solid;width:200px;background:white;display:none;position:absolute;left:0;top:28px;*margin-left:9px;*margin-top:2px;margin-top:1px\0;}
		.autoComplete li {list-style:none;}
		.autoComplete li a {display:block;color:#000;text-decoration:none;padding:1px 0 1px 5px;_width:97%;}
		.autoComplete li a:hover {color:#000;background:#ccc;border:none;}

		/**
 * 隐藏默认的checkbox
 */
		/*input[type=checkbox] {*/
		/*	visibility: hidden;*/
		/*}*/

	</style>

	<script type="text/javascript">
		//<![CDATA[
		var getElementsByClassName = function (searchClass, node, tag) {/* 兼容各浏览器的选择class的方法；(写法参考了博客园：http://www.cnblogs.com/rubylouvre/archive/2009/07/24/1529640.html，想了解更多请看这个地址) */
			node = node || document, tag = tag ? tag.toUpperCase() : "*";
			if(document.getElementsByClassName){/* 支持getElementsByClassName的浏览器 */
				var temp = node.getElementsByClassName(searchClass);
				if(tag=="*"){
					return temp;
				} else {
					var ret = new Array();
					for(var i=0; i<temp.length; i++)
						if(temp[i].nodeName==tag)
							ret.push(temp[i]);
					return ret;
				}
			}else{/* 不支持getElementsByClassName的浏览器 */
				var classes = searchClass.split(" "),
						elements = (tag === "*" && node.all)? node.all : node.getElementsByTagName(tag),
						patterns = [], returnElements = [], current, match;
				var i = classes.length;
				while(--i >= 0)
					patterns.push(new RegExp("(^|\\s)" + classes[i] + "(\\s|$)"));
				var j = elements.length;
				while(--j >= 0){
					current = elements[j], match = false;
					for(var k=0, kl=patterns.length; k<kl; k++){
						match = patterns[k].test(current.className);
						if(!match) break;
					}
					if(match) returnElements.push(current);
				}
				return returnElements;
			}
		};
		var addEvent=(function(){/* 用此函数添加事件防止事件覆盖 */
			if(document.addEventListener){
				return function(type, fn){ this.addEventListener(type, fn, false); };
			}else if(document.attachEvent){
				return function(type,fn){
					this.attachEvent('on'+type, function () {
						return fn.call(this, window.event);/* 兼容IE */
					});
				};
			}
		})();
		;(function(window){
			/* 插件开始 */
			var autoComplete=function(o){
				var handler=(function(){
					var handler=function(e,o){ return new handler.prototype.init(e,o); };/* 为每个选择的dom都创建一个相对应的对象，这样选择多个dom时可以很方便地使用 */
					handler.prototype={
						e:null, o:null, timer:null, show:0, input:null, popup:null,
						init:function(e,o){/* 设置初始对象 */
							this.e=e, this.o=o,
									this.input=this.e.getElementsByTagName(this.o.input)[0],
									this.popup=this.e.getElementsByTagName(this.o.popup)[0],
									this.initEvent();/* 初始化各种事件 */
						},
						match:function(quickExpr,value,source){/* 生成提示 */
							var li = null;
							for(var i in source){
								if( value.length>0 && quickExpr.exec(source[i])!=null ){
									li = document.createElement('li');
									li.innerHTML = '<a href="javascript:;">'+source[i]+'</a>';
									this.popup.appendChild(li);
								}
							}
							if(this.popup.getElementsByTagName('a').length)
								this.popup.style.display='block';
							else
								this.popup.style.display='none';
						},
						ajax:function(type,url,quickExpr,search){/* ajax请求远程数据 */
							var xhr = window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest();
							xhr.open(type,url,true);/* 同异步在此修改 */
							xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
							var that=this;
							xhr.onreadystatechange = function(){
								if(xhr.readyState==4) {
									if(xhr.status==200) {
										var data = eval(xhr.responseText);
										that.match(quickExpr,search,data);/* 相同于成功的回调函数 */
									}else{
										alert("请求页面异常!");/* 请求失败 */
									}
								}
							};
							xhr.send(null);
						},
						fetch:function(ajax,search,quickExpr){
							var that=this;
							this.ajax(ajax.type,ajax.url+search,quickExpr,search);
						},
						initEvent:function(){/* 各事件的集合 */
							var that=this;
							this.input.onfocus = function(){
								if(this.inputValue) this.value = this.inputValue;
								var value=this.value, quickExpr=RegExp('^'+value,'i'), self=this;
								var els = that.popup.getElementsByTagName('a');
								if(els.length>0) that.popup.style.display = 'block';
								that.timer=setInterval(function(){
									if(value!=self.value){/* 判断输入内容是否改变，兼容中文 */
										value=self.value;
										that.popup.innerHTML='';
										if(value!=''){
											quickExpr=RegExp('^'+value);
											if(that.o.source) that.match(quickExpr,value,that.o.source);
											else if(that.o.ajax) that.fetch(that.o.ajax,value,quickExpr);
										}
									}
								},200);
							};
							this.input.onblur = function(){/*  输入框添加事件 */
								if(this.value!=this.defaultValue) this.inputValue = this.value;
								clearInterval(that.timer);
								var current=-1;/* 记住当前有焦点的选项 */
								var els = that.popup.getElementsByTagName('a');
								var len = els.length-1;
								var aClick = function(){
									that.input.inputValue = this.firstChild.nodeValue;
									that.popup.innerHTML='';
									that.popup.style.display='none';
									that.input.focus();
								};
								var aFocus = function(){
									for(var i=len; i>=0; i--){
										if(this.parentNode===that.popup.children[i]){
											current = i;
											break;
										}
									}
									//that.input.value = this.firstChild.nodeValue;
									for(var k in that.o.elemCSS.focus){
										this.style[k] = that.o.elemCSS.focus[k];
									}
								};
								var aBlur= function(){
									for(var k in that.o.elemCSS.blur)
										this.style[k] = that.o.elemCSS.blur[k];
								};
								var aKeydown = function(event){
									event = event || window.event;/* 兼容IE */
									if(current === len && event.keyCode===9){/* tab键时popup隐藏 */
										that.popup.style.display = 'none';
									}else if(event.keyCode==40){/* 处理上下方向键事件方便选择提示的选项 */
										current++;
										if(current<-1) current=len;
										if(current>len){
											current=-1;
											that.input.focus();
										}else{
											that.popup.getElementsByTagName('a')[current].focus();
										}
									}else if(event.keyCode==38){
										current--;
										if(current==-1){
											that.input.focus();
										}else if(current<-1){
											current = len;
											that.popup.getElementsByTagName('a')[current].focus();
										}else{
											that.popup.getElementsByTagName('a')[current].focus();
										}
									}
								};
								for(var i=0; i<els.length; i++){/* 为每个选项添加事件 */
									els[i].onclick = aClick;
									els[i].onfocus = aFocus;
									els[i].onblur = aBlur;
									els[i].onkeydown = aKeydown;
								}
							};
							this.input.onkeydown = function(event){
								event = event || window.event;/* 兼容IE */
								var els = that.popup.getElementsByTagName('a');
								if(event.keyCode==40){
									if(els[0]) els[0].focus();
								}else if(event.keyCode==38){
									if(els[els.length-1]) els[els.length-1].focus();
								}else if(event.keyCode==9){
									if(event.shiftKey==true) that.popup.style.display = 'none';
								}
							};
							this.e.onmouseover = function(){ that.show=1; };
							this.e.onmouseout = function(){ that.show=0; };
							addEvent.call(document,'click',function(){
								if(that.show==0){
									that.popup.style.display='none';
								}
							});/* 处理提示框dom元素不支持onblur的情况 */
						}
					};
					handler.prototype.init.prototype=handler.prototype;/* JQuery style，这样我们在处的时候就不用每个dom元素都用new来创建对象了 */
					return handler;/* 把内部的处理函数传到外部 */
				})();
				if(this.length){/* 处理选择多个dom元素 */
					for(var a=this.length-1; a>=0; a--){/* 调用方法为每个选择的dom生成一个处理对象，使它们不互相影响 */
						handler(this[a],o);
					}
				}else{/* 处理选择一个dom元素 */
					handler(this,o);
				}
				return this;
			};
			return window.autoComplete = autoComplete;/* 暴露方法给全局对象 */
			/* 插件结束 */
		})(window);
		/* 调用 */
		var username = $('#add_username').val();
		addEvent.call(null,'load',function(){
			autoComplete.call( getElementsByClassName('autoComplete'), {/* 使用call或apply调用此方法 */
				// source:['0123','023',123,1234,212,214,'033333','0352342',1987,17563,20932],/* 提示时在此数组中搜索 */
				ajax:{ type:'post',url:'<%=basePath%>user/getUsernameList.action?username=' },/* 如果使用ajax则远程返回的数据格式要与source相同 */
				elemCSS:{ focus:{'color':'black','background':'#ccc'}, blur:{'color':'black','background':'transparent'} },/* 些对象中的key要js对象中的style属性支持 */
				input:'input',/* 输入框使用input元素 */
				popup:'ul'/* 提示框使用ul元素 */
			});
		});
		//]]>
	</script>
    <script type="text/javascript">
        var a_idx = 0;
        jQuery(document).ready(function($) {
            $("body").click(function(e) {
                var a = new Array("❤富强❤","❤民主❤","❤文明❤","❤和谐❤","❤自由❤","❤平等❤","❤公正❤","❤法治❤","❤爱国❤","❤敬业❤","❤诚信❤","❤友善❤");
                var $i = $("<span></span>").text(a[a_idx]);
                a_idx = (a_idx + 1) % a.length;
                var x = e.pageX,
                    y = e.pageY;
                $i.css({
                    "z-index": 999999999999999999999999999999999999999999999999999999999999999999999,
                    "top": y - 20,
                    "left": x,
                    "position": "absolute",
                    "font-weight": "bold",
                    "color": "rgb("+~~(255*Math.random())+","+~~(255*Math.random())+","+~~(255*Math.random())+")"
                });
                $("body").append($i);
                $i.animate({
                        "top": y - 180,
                        "opacity": 0
                    },
                    1500,
                    function() {
                        $i.remove();
                    });
            });

        });

    </script>
<title>Insert title here</title>
</head>

<body>

<div class="container">
	<div class="row clearfix">
		<div class="panel panel-default">
			<div class="panel-body">
				<form class="form-inline" method="post" 
				      action="<%=basePath%>user/toUser.action">
					<div class="form-group">
						<label for="username"><p class="tp" style="color: #0C0C0C"></p></label>
							<div class="autoComplete" style="z-index:19">
								<input type="text" class="form-control" placeholder="姓名:" id="username" value="${username}" name="username" >
								<ul><li></li></ul>
							</div>
					</div>
					<div class="form-group">
						<label for="eid"><p class="tp" style="color: #0C0C0C">工号:</p></label>
						<input type="text" class="form-control" id="eid" value="${eid}" name="eid" >
					</div>
                    <div class="form-group">
						<p>
							<input name="sex" value="女" type="radio" id="test1"  />
							<label for="test1">女士</label>
						</p>
						<p>
							<input name="sex" value="男" type="radio" id="test2" />
							<label for="test2" >男士</label>
						</p>
					</div>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<div class="form-group">
						<p>
							<input name="isWork" value="true" type="radio" id="test3"  />
							<label for="test3">在职</label>
						</p>
						<p>
							<input name="isWork" value="false" type="radio" id="test4" />
							<label for="test4" >离职</label>
						</p>
					</div>
					&nbsp;&nbsp;&nbsp;&nbsp;
                    <div class="form-group">
						<label  for="job"><p class="tp" style="color: #0C0C0C">Job list</p></label>
                            <select class="browser-default" name="job" id="job">
                                <option value="" disabled selected>Choose your Job</option>
                                <option value ="开发工程师">开发工程师</option>
                                <option value ="实施工程师">实施工程师</option>
                                <option value="DBA">DBA</option>
                                <option value="产品经理">产品经理</option>
                                <option value="项目经理">项目经理</option>
                                <option value="HR">HR</option>
                            </select>
                    </div>
					<button class="btn waves-effect waves-light green" type="submit" name="action">查询
						<i class="material-icons right">send</i>
					</button>
				</form>
				<form class="form-inline"  onsubmit="return false">
                    <a class="btn-floating btn-large waves-effect waves-light blue"  type="button"  data-toggle="modal" data-target="#myModal">ADD<i class="material-icons">add</i></a>
                    <a href="#" class="btn waves-effect waves-light green" onclick="exportUserInfoExcel()">全部导出</a>
                    <a href="#" class="btn waves-effect waves-light 1de9b6 teal accent-3" onclick="exportById()">批量导出</a>
<%--					<a class="btn waves-effect waves-light green" href="<%=basePath%>user/exportUserInfoExcel"  type="button"  >全部导出Excel表格<i class="material-icons">add</i></a>--%>

				</form>
			</div>
		</div>
	</div>

	<div class="container">
	<div class="row clearfix">

	</div>
</div>
	
	<div class="row clearfix">
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="col-md-11 column">
					<table class="table  table-hover">
						<thead>
							<tr>
								<th><input type="checkbox" class="i-checks" name="test5" id="all" >
									<label for="all"></label></th>
								<th><i class="small material-icons">explicit</i>工号</th>
								<th><i class="small material-icons">perm_contact_calendar</i>姓名</th>
								<th><i class="small material-icons">perm_identity</i>性别</th>
								<th><i class="small material-icons">supervisor_account</i>职位</th>
								<th><i class="small material-icons">phone</i>手机号码</th>
								<th><i class="small material-icons">assignment_late</i>是否在职</th>
								<th><a href="#" class="btn waves-effect waves-light ef6c00 orange darken-3" onclick="deleteAll()">批量删除</a></th>
							</tr>
						</thead>
						<tbody id="questionlist">
						
							<c:forEach var="user" items="${page.rows}" varStatus="status" >
								<tr class="aa" draggable="true">
									<td>
										<input type="checkbox"  id="${user.id}" name="idone"  value="${user.id}" >
										<label for="${user.id}"></label>
									</td>
									<td>
										<c:out value="${user.eid }"/>
									</td>
									<td>
										<c:out value="${user.username }"/>
									</td>
									<td>
										<c:out value="${user.sex }"/>
									</td>
									<td>
										<c:out value="${user.job }"/>
									</td>
									<td>
										<c:out value="${user.phone }"/>
									</td>
									<td>
										<c:out value="${user.isWork }"/>
									</td>

									<td>
										<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#customerEditDialog" onclick= "editUser(${user.id})">详情or修改</a>
										<a href="#" class="btn waves-effect waves-light red" onclick="deleteUser(${user.id})">删除</a>

									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="col-md-12 text-right">
						<navigationTag:page url="${pageContext.request.contextPath }/user/toUser.action" />
					</div>
				</div>
			</div>
		</div>
		</div>
		
	</div>
<!-- 模态框开始（Modal） -->

<div class="modal fade bs-example-modal-lg" id="myModal"  style="height:fit-content" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
        <div class="modal-dialog modal-lg">
            <div class='yellow'>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
				</button>
				<h4 class="modal-title" id="myModalLabel"  align="center">NEW WORKER
				</h4>
			</div>

            <div class="row">
                <form id="validateAdd" class="col s12" >
                    <div class="row">
                        <div class=".input-field col s6">
							<label for="add_username">Name：</label>
                            <i class="material-icons prefix"></i>
                            <input id="add_username" type="text" placeholder="姓名 username" class="validate" required>
                        </div>
                        <div class=".input-field col s6">
							<label for="add_phone">tel：</label>
                            <i class="material-icons prefix"></i>
                            <input id="add_phone" type="tel" placeholder="电话 tel"  maxlength="11" class="validate" required>

                        </div>
                    </div>
                    <div class="row">
                        <div class=".input-field col s2">
							<label for="add_sex">性别选择 </label>
					 		<select class="browser-default" id="add_sex" required>
								<option value="" disabled selected>Choose sex</option>
								<option value="男">小哥哥</option>
								<option value="女">小姐姐</option>
							</select>
                        </div>
						<div class=".input-field col s4">
                            <label  for="add_job">职位 Choose</label>
							<select class="browser-default" id="add_job" required>
								<option value="" disabled selected>Choose Job</option>
								<option value ="开发工程师">开发工程师</option>
								<option value ="实施工程师">实施工程师</option>
								<option value="DBA">DBA</option>
								<option value="产品经理">产品经理</option>
                                <option value="项目经理">项目经理</option>
								<option value="HR">HR</option>
							</select>
						</div>
                        <div class="input-field col s2">
                            <label  for="add_basicSalary">基本工资:</label>
                            <input id="add_basicSalary" type="text" placeholder="工资 " class="validate" >
                        </div>
					</div>
                    <div class="row">
                        <div class="input-field col s6">
							<label  for="add_idcard">身份证号码:</label>
                            <input id="add_idcard" type="text" placeholder="身份证号码 idcard" maxlength="18" class="validate" >

                        </div>
                        <div class="input-field col s6">
							<label  for="add_address">地址:</label>
                            <input id="add_address" type="text" placeholder="地址 address" class="validate" >

                        </div>
                    </div>
                    <button  type="reset" class="btn btn-danger btn-xs">重置</button>
                </form>
            </div>
			<div class="card-panel">
<%--				<h5>Primary Buttons</h5>--%>
				<button id="buttonAdd" class="btn waves-effect waves-light red"  onclick="addUser()">确认<i class="material-icons right">send</i></button>
                <button type="button" class="btn waves-effect waves-light yellow " data-dismiss="modal">关闭<i class="material-icons right">cancel</i></button>
<%--				<button class="btn waves-effect waves-light red disabled" data-dismiss="modal" >Cancel<i class="material-icons right">cancel</i></button>--%>
			</div>
		</div>
	</div>
</div>
<%--添加模态框结束--%>
<!-- 修改职员模态框 -->
<div class="modal fade bs-example-modal-lg" id="customerEditDialog" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
	<div class="modal-dialog modal-lg">
		<div class='red'>
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
			</button>
			<h4 class="modal-title" id="myModalLabel1"  align="center">ALTER WORKER MESSAGE
			</h4>
		</div>

		<div class="row">
			<form class="col s12" id="edit_user_form">
				<input type="hidden" id="edit_id" name="id"/>
				<input type="hidden" id="edit_password" name="password"/>
				<input type="hidden" id="edit_eid" name="eid"/>
				<input type="hidden" id="edit_welfarePoints" name="welfarePoints"/>
				<input type="hidden" id="edit_joinTime" name="joinTime"/>
				<input type="hidden" id="edit_leaveTime" name="leaveTime"/>
				<div class="row">
					<div class=".input-field col s6">
						<label for="edit_username">Name：</label>
						<i class="material-icons prefix"></i>
						<input id="edit_username" type="text" placeholder="姓名 username"  name="username" class="validate" required>
					</div>
					<div class=".input-field col s6">
						<label for="edit_phone">tel：</label>
						<i class="material-icons prefix"></i>
						<input id="edit_phone" type="tel" placeholder="电话 tel" name="phone" maxlength="11" class="validate" required>

					</div>
				</div>
				<div class="row">
					<div class=".input-field col s6"><p>Sex：</p>
						<p>
							<input name="sex" value="女" type="radio" id="sexW" required/>
							<label for="sexW">女士</label>
						</p>
						<p>
							<input name="sex" value="男" type="radio" id="sexM" />
							<label for="sexM">男士</label>
						</p>
					</div>
					<div class=".input-field col s6"><p>是否在职：</p>
						<p>
							<input name="isWork" value="true" type="radio" id="workT" required/>
							<label for="workT">在职</label>
						</p>
						<p>
							<input name="isWork" value="false" type="radio" id="workF" />
							<label for="workF">离职</label>
						</p>
					</div>
				</div>

				<div class="row">
					<div class=".input-field col s2">
						<label  for="edit_job">Job list</label>
						<select class="browser-default" id="edit_job" name="job" required>
							<option value="" disabled selected>Choose your Job</option>
							<option value ="开发工程师">开发工程师</option>
							<option value ="实施工程师">实施工程师</option>
							<option value="DBA">DBA</option>
							<option value="产品经理">产品经理</option>
							<option value="项目经理">项目经理</option>
							<option value="HR">HR</option>
						</select>
					</div>
					<div class=".input-field col s2">
						<label  for="edit_basicSalary">基本工资:</label>
						<input id="edit_basicSalary" name="basicSalary" type="text" placeholder="工资" class="validate">
					</div>
				</div>
				<div class="row">
					<div class=".input-field col s3">
						<label  for="edit_idCard">身份证号码:</label>
						<input id="edit_idCard" name="idcard" type="text" placeholder="身份证号码 idcard" maxlength="18" class="validate" >

					</div>
					<div class=".input-field col s6">
						<label  for="edit_address">地址:</label>
						<input id="edit_address" name="address" type="text" placeholder="地址 address" class="validate">

					</div>
				</div>


				<button  type="reset" class="btn btn-danger btn-xs">重置</button>
			</form>
		</div>
		<div class="card-panel">
<%--			<h5>Primary Buttons</h5>--%>
			<button class="btn waves-effect waves-light red"  onclick="updateUser()">修改<i class="material-icons right">send</i></button>
			<button type="button" class="btn waves-effect waves-light yellow " data-dismiss="modal">关闭<i class="material-icons right">cancel</i></button>

		</div>
	</div>
</div>



</body>

<%--<script type="text/javascript" src="https://res.weiunity.com/msg/msg.js"></script>--%>
<script type="text/javascript" src="http://static.cloud.linesno.com/asserts/ajax/libs/layer/layer.min.js"></script>



<script type="text/javascript">
	//全选
	var oall=document.getElementById("all");
	var oid=document.getElementsByName("idone");
	oall.onclick=function(){//勾选全选时
		for(var i=0;i<oid.length;i++){
			//所有的选择框和全选一致
			oid[i].checked=oall.checked;
		}
	};

</script>
<script type="text/javascript">
	function deleteAll() {
		var idss = '';
		$('input:checkbox[name="idone"]').each(function () {
			if (this.checked === true) {
				idss += this.value + ',';
			}
		});
		if (!idss){
			layer.msg('请至少选中一个', {icon: 2, time: 1500});
			return false;
		} else {
		layer.confirm('批量删除后不可恢复，谨慎操作！', {icon: 7, title: '警告'}, function (index) {
			$.ajax({
				type: 'POST',
				url: "<%=basePath%>user/deleteByIds.action",
				data: {ids: idss},
				dataType: 'json',
				success: function (data) {
					if (data.code === 200) {
						layer.msg(data.msg, {icon: 1, time: 1000},function (index){
							window.location.reload();
							layer.close();
						});
					} else {
						layer.msg(data.msg, {icon: 2, time: 3000});
					}
				}
			});
		});
		}
	}




</script>
<script type="text/javascript" >
	function addUser(){
	    //form表单校验
		let flag = $('#validateAdd').valid();
		if(!flag) return;
		var username = $('#add_username').val();
		var sex = $('#add_sex').val();
		var job = $('#add_job').val();
		var basicSalary = $('#add_basicSalary').val();
		var phone = $('#add_phone').val();
		var idcard = $('#add_idcard').val();
		var address = $('#add_address').val();
        /*
        正则检验
         */
		var regPhone = /(^1(3|4|5|6|7|8|9)\d{9}$)/;
		if (!regPhone.test(phone)) {
			layer.msg('手机号码,请输入正确的数值，13/14/15/16/17/18/19开头的号码', {icon: 2, time: 3000});
			return ;
		};
		var regIdcard = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
		if (!regIdcard.test(idcard)) {
			layer.msg('身份证输入错误,请输入正确的数值', {icon: 2, time: 3000});
			return ;
		};
        var str = address.replace(/(^\s*)|(\s*$)/g, '');//去除空格;
        if (str == '' || str == undefined || str == null) {
            layer.msg('请输入地址，前中后不要包含空格', {icon: 2, time: 3000});
            return ;
        }
		var regBasicSalary = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
		if (!regBasicSalary.test(basicSalary)) {
			layer.msg('工资输入错误,请输入正确的数值，例如正确：588.00 or 588 错误: 558a or adawd', {icon: 2, time: 3000});
			return ;
		};


	$.ajax({
	url : "<%=basePath%>user/add.action",
	type : "post",
	data :JSON.stringify({username: username,
		sex: sex,
		job: job,
		basicSalary: basicSalary,
		phone: phone,
		idcard: idcard,
		address: address}),
	// 定义发送请求的数据格式为JSON字符串
	contentType : "application/json;charset=UTF-8",
	//定义回调响应的数据格式为JSON字符串,该属性可以省略
	dataType : "json",
	//成功响应的结果
	success : function(data){
		if (data.code === 200) {
			layer.msg(data.msg, {icon: 1, time: 1000},function (index){
				window.location.reload();
				layer.close();
			});
		} else {
			layer.msg(data.msg, {icon: 2, time: 3000});
		}
	}
	})
	};
	function editUser(id) {
		$.ajax({
			type:"get",
			url:"<%=basePath%>user/getUserById.action",
			data:{"id":id},
			success:function(data) {
				$("#edit_id").val(data.id);
				$("#edit_username").val(data.username);
				$("#edit_password").val(data.password);
				// $("#edit_sex").val(data.sex);
				$("#edit_eid").val(data.eid);
				$("#edit_job").val(data.job);
				$("#edit_basicSalary").val(data.basicSalary);
				$("#edit_welfarePoints").val(data.welfarePoints);
				$("#edit_phone").val(data.phone);
				$("#edit_idCard").val(data.idcard);
				$("#edit_joinTime").val(data.joinTime);
				$("#edit_leaveTime").val(data.leaveTime);
				$("#edit_address").val(data.address);

				if (data.sex===("女")) {
					$("input[id=sexW][value='女']").attr("checked",true);//value=34的radio被选中
				} else {
					$("input[id=sexM][value='男']").attr("checked",true);//value=34的radio被选中
				}
				if (data.isWork) {
					$("input[id=workT][value='true']").attr("checked",true);//value=34的radio被选中
				} else {
					$("input[id=workF][value='false']").attr("checked",true);//value=34的radio被选中
				}

			}
		});
	};

	function updateUser() {
        let flag = $('#edit_user_form').valid();
        if(!flag) return;
        var basicSalary = $('#edit_basicSalary').val();
        var phone = $('#edit_phone').val();
        var idcard = $('#edit_idCard').val();
        var address = $('#edit_address').val();
        /*
        正则检验
         */
        var regPhone = /(^1(3|4|5|6|7|8|9)\d{9}$)/;
        if (!regPhone.test(phone)) {
            layer.msg('手机号码,请输入正确的数值，13/14/15/16/17/18/19开头的号码', {icon: 2, time: 3000});
            return ;
        };
        var regIdcard = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if (!regIdcard.test(idcard)) {
            layer.msg('身份证输入错误,请输入正确的数值', {icon: 2, time: 3000});
            return ;
        };
        var str = address.replace(/(^\s*)|(\s*$)/g, '');//去除空格;
        if (str == '' || str == undefined || str == null) {
            layer.msg('请输入地址，前中后不要包含空格', {icon: 2, time: 3000});
            return ;
        }
        var regBasicSalary = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
        if (!regBasicSalary.test(basicSalary)) {
            layer.msg('工资输入错误,请输入正确的数值，例如正确：588.00 or 588 错误: 558a or adawd', {icon: 2, time: 3000});
            return ;
        };



		$.ajax({
			type: "POST",
			dataType: "json",
			contentType: "application/x-www-form-urlencoded;charset=UTF-8",
			url: "<%=basePath%>user/updateUser.action",
			data: $("#edit_user_form").serialize(),
			beforeSend: function () {
			},
			success: function (data) {
				if (data.code === 200) {
					layer.msg(data.msg, {icon: 1, time: 1000},function (index){
						window.location.reload();
						layer.close();
					});
				} else {
					layer.msg(data.msg, {icon: 2, time: 3000});
				}
			}
		});
	};
	// 删除
	function deleteUser(id) {
			layer.confirm('删除后不可恢复，谨慎操作！', {icon: 7, title: '警告'}, function (index) {
			$.post("<%=basePath%>user/deleteUser.action",{"id":id},
					function(data){
						if (data.code === 200) {
							layer.msg(data.msg, {icon: 1, time: 1000},function (index){
								window.location.reload();
								layer.close();
							});
						} else {
							layer.msg(data.msg, {icon: 2, time: 3000});
						}
					});
		});
	}


    function exportUserInfoExcel(){
        layer.confirm('确定全部导出吗！', {icon: 7, title: '确认'}, function (index) {

            layer.msg("正在导出", {icon: 1, time: 2000},function (index){
                window.location.href = "<%=basePath%>user/exportUserInfoExcel";
                                    layer.close();
                                });
        });
    }

    function exportById() {
        var idss = '';
        $('input:checkbox[name="idone"]').each(function () {
            if (this.checked === true) {
                idss += this.value + ',';
            }
        });
        var ids=idss;
        console.log(ids);
        if (!idss){
            layer.msg('请至少选中一个', {icon: 2, time: 1500});
            return false;
        } else {
            layer.confirm('确定将选中的数据导出吗！', {icon: 7, title: '确认'}, function (index) {
				layer.msg("正在导出", {icon: 1, time: 2000},function (index){
					window.location.href = "<%=basePath%>user/exportByIds.action?ids="+ ids;
					layer.close();
				});

            });
        }
    }
</script>

</html>