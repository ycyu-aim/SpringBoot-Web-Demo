<%@ taglib prefix="disabled" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

	<script type="text/javascript" src="<%=basePath%>js/js113.js"></script>
<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">
<script src="<%=basePath%>js/jquery-1.11.3.min.js"></script>
<script src="<%=basePath%>js/bootstrap.min.js"></script>
<style type="text/css">
	.onEmpCount{
		width:100%;
		height:auto;
		border:0px solid gray;
		padding:5px;
		color: #a6e1ec;
	}
</style>
	<style type="text/css">
		.ibox, .ibox-content {
			border: 0px !important;
		}
		span.info-box-icon {
			border-top-left-radius: 2px;
			border-top-right-radius: 0;
			border-bottom-right-radius: 0;
			border-bottom-left-radius: 2px;
			display: block;
			float: left;
			height: 90px;
			width: 90px;
			text-align: center;
			font-size: 45px;
			line-height: 90px;
			background: rgba(0, 0, 0, 0.2);
			color: #fff;
		}
	</style>
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
</head>
<body>




	<footer th:replace="dashboard/footer :: footer"></footer>


</body>
<script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>
<script type="text/javascript">
	$(function(){
		var pieChart = echarts.init(document.getElementById("echarts-pie-chart"));
		var pieoption = null
		$.get("<%=basePath%>admin/getPie1", function(data) {
			WorkerType = data;
			console.log(WorkerType);
			var pieoption = {
				title : {
					text: '公司职业分布',
					subtext: '各职业分布',
					x:'center'
				},
				tooltip : {
					trigger: 'item',
					formatter: "{a} <br/>{b} : {c} ({d}%)"
				},
				legend: {
					orient : 'vertical',
					x : 'left',
					data:['开发工程师' ,'实施工程师','DBA','产品经理','项目经理','HR']
				},
				calculable : true,
				series : [
					{
						name:'人数',
						type:'pie',
						radius : '55%',
						center: ['50%', '60%'],
						data:[
							{value:WorkerType[0], name:'开发工程师'},
							{value:WorkerType[1], name:'实施工程师'},
							{value:WorkerType[2], name:'DBA'},
							{value:WorkerType[3], name:'产品经理'},
							{value:WorkerType[4], name:'项目经理'},
							{value:WorkerType[5], name:'HR'}
						]
					}
				]
			};
			pieChart.setOption(pieoption);
			$(window).resize(pieChart.resize);
		}) ;

		var lineChart = echarts.init(document.getElementById("echarts-line-chart"));
		var lineoption = null
		$.get("<%=basePath%>admin/getline1", function(data) {
			var json = data;
			var mouth = json[0];
			var joinCount = json[1];
			var leaveCount = json[2];

			var lineoption = {
				animation: false,
				title : {
					text : '出入职情况分析'
				},
				tooltip : {
					trigger : 'axis'
				},
				legend: {
					data:['入职', '离职']
				},
				grid: {
					left: '10%',
					right: '10%', ///   调整大小
					bottom: '10%',
					show:true, //  边框是否显示
					containLabel: true
				},
				xAxis : {
					type : 'category',
					splitLine : {
						show : true
					},
					data : mouth

				},
				yAxis : {
					splitLine : {
						show : false
					},
					axisLabel:{
						formatter: function (value) {
							var texts = [];
							if(value<=4){
								texts.push('人事波动小');
							}
							else if (value <=10) {
								texts.push('人事波动正常');
							}
							else if (value<= 20) {
								texts.push('人事波动大');
							}
							else if(value<= 60){
								texts.push('人事波动巨大');
							}
							else{
								texts.push('人事跑路ing');
							}
							return texts;
						}
					},

				},

				series : [
					{
						name : '入职',
						type : 'line',
						data :  joinCount,
						markPoint : {
							data : [ {
								type : 'max',
								name : '历史最大值'
							}, {
								type : 'min',
								name : '历史最小值'
							} ]
						},
						markLine : {
							data : [ {
								type : 'average',
								name : '平均值'
							} ]
						}

					},
					{
						name : '离职',
						type : 'line',
						data :  leaveCount,
						markPoint : {
							data : [ {
								type : 'max',
								name : '历史最大值'
							}, {
								type : 'min',
								name : '历史最小值'
							} ]
						},
						markLine : {
							data : [ {
								type : 'average',
								name : '平均值'
							} ]
						}
					}
				]
			};
			console.log(lineoption);
			lineChart.setOption(lineoption);
			$(window).resize(lineChart.resize);
		});


		var barChart = echarts.init(document.getElementById("echarts-bar-chart"));
		var baroption = null;
		$.get("<%=basePath%>admin/getBar1", function(data) {
		    var Salary = data;
				console.log("柱形图"+Salary) ;
			var baroption = {
				tooltip : {
					show : true
				},
				legend : {
					data : [ '销量' ]
				},
				xAxis : [ {
					type : 'category',
					data : [ "5K以下", "5-10K", "10-15K", "超过15K" ]
				} ],
				yAxis : [ {
					type : 'value'
				} ],
				series : [ {
					"name" : "个数",
					"type" : "bar",
					"data" : [Salary[0],
								Salary[1],
								Salary[2],
								Salary[3]]
				} ]
			};
			barChart.setOption(baroption);
			$(window).resize(barChart.resize);
		});


	});

</script>
</html>

