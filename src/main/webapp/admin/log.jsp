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

<div class="wrapper wrapper-content animated fadeInRight">
        <div class="col-sm-12">
            <div class="row">
                <div class="col-sm-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5 align="center">
                                <i class="fas fa-paper-plane"></i> <span class="badge" style="color:whitesmoke" >请求日志情况分析</span>
                            </h5>
                        </div>
                        <div class="ibox-content">
                            <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
                            <div id="echarts-line-chart" style="width: 1500px;height:300px;">
                            </div>
                        </div>
                    </div>
                    <br><br><br>
                </div>
            </div>
        </div>
        <footer th:replace="dashboard/footer :: footer"></footer>


</body>
<script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>
<script type="text/javascript">
    $(function(){
        var lineChart = echarts.init(document.getElementById("echarts-line-chart"));
        var lineoption = null
        $.get("<%=basePath%>admin/getlineDB", function(data) {
            var json = data;
            var mouth = json[0];
            var getTime = json[1];
            var postTime = json[2];

           var lineoption = {
                tooltip: {
                    trigger: 'axis',
                    position: function (pt) {
                        return [pt[0], '10%'];
                    }
                },
                title: {
                    // left: 'center',
                    text: '请求访问数据图(毫秒)',
                },
               legend: {
                   data:['GET请求', 'POST请求']
               },
                toolbox: {
                    feature: {
                        dataZoom: {
                            yAxisIndex: 'none'
                        },
                        restore: {},
                        saveAsImage: {}
                    }
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: mouth
                },
                yAxis: {
                    type: 'value',
                    boundaryGap: [0, '100%']
                },
                dataZoom: [{
                    type: 'inside',
                    start: 0,
                    end: 10
                }, {
                    start: 0,
                    end: 10,
                    handleIcon: 'M10.7,11.9v-1.3H9.3v1.3c-4.9,0.3-8.8,4.4-8.8,9.4c0,5,3.9,9.1,8.8,9.4v1.3h1.3v-1.3c4.9-0.3,8.8-4.4,8.8-9.4C19.5,16.3,15.6,12.2,10.7,11.9z M13.3,24.4H6.7V23h6.6V24.4z M13.3,19.6H6.7v-1.4h6.6V19.6z',
                    handleSize: '80%',
                    handleStyle: {
                        color: '#fff',
                        shadowBlur: 3,
                        shadowColor: 'rgba(0, 0, 0, 0.6)',
                        shadowOffsetX: 2,
                        shadowOffsetY: 2
                    }
                }],
                series: [
                    {
                        name: 'GET请求',
                        type: 'line',
                        smooth: true,
                        symbol: 'none',
                        sampling: 'average',
                        itemStyle: {
                            color: 'rgb(255, 70, 131)'
                        },
                        areaStyle: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                offset: 0,
                                color: 'rgb(255, 158, 68)'
                            }, {
                                offset: 1,
                                color: 'rgb(255, 70, 131)'
                            }])
                        },
                        data: getTime
                    }
                    ,
                    {
                        name: 'POST请求',
                        type: 'line',
                        smooth: true,
                        symbol: 'none',
                        sampling: 'average',
                        itemStyle: {
                            color: 'rgb(150 205 205)'
                        },
                        areaStyle: {
                            color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                offset: 0,
                                color: 'rgb(150 205 205)'
                            }, {
                                offset: 1,
                                color: 'rgb(150 205 205)'
                            }])
                        },
                        data: postTime
                    }
                ]
            };
            console.log(lineoption);
            lineChart.setOption(lineoption);
            $(window).resize(lineChart.resize);
        });


    });

</script>
</html>

