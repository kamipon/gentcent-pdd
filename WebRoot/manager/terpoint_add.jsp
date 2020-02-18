<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>


<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>代理新增</title>

    <link rel="shortcut icon" href="favicon.ico">
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>代理新增</h5>
                </div>
                <div class="ibox-content">
                    <form method="post" class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><font color="red">*</font>名称</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="name">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><font color="red">*</font>账号</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="userName">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><font color="red">*</font>密码</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="passWord">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><font color="red">*</font>联系方式</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="phone">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><font color="red">*</font>开启商家数量</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="activityNum">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><font color="red">*</font>到期时间</label>
                            <div class="col-sm-10">
                                <input type="text" id="daoqi" name="overTime" readonly="readonly" class="form-control"
                                       class="Wdate" size="12">
                            </div>
                        </div>
                        <div>
                            <button class="btn btn-primary" type="button" id="add_terpoint">新增</button>
                            <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="<%=basePath%>manager/js/city.js"></script>
<script src="js/jquery.min63b9.js?v=2.1.4"></script>
<script src="js/layer/layer.js"></script>
<script type="text/javascript" src="js/childrenToMenu.js"></script>
<script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>


<script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
<script type="text/javascript" src="<%=basePath%>js/distpicker.data.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/distpicker.min_huo.js"></script>
<script src="${cp }/manager/js/plugins/summernote/summernote.min.js"></script>
<script src="${cp }/manager/js/plugins/summernote/summernote.js"></script>
</body>
<script type="text/javascript">
    (function () {
        var pHtmlStr = '';
        for (var name in pc) {
            pHtmlStr = pHtmlStr + '<option>' + name + '</option>';
        }
        $("#province").html(pHtmlStr);
        $("#province").change(function () {
            var pname = $("#province option:selected").text();
            var pHtmlStr = '';
            var cityList = pc[pname];
            for (var index in cityList) {
                pHtmlStr = pHtmlStr + '<option>' + cityList[index] + '</option>';
            }
            $("#city").html(pHtmlStr);
            var ci = $("#city option");
            if (ro != '1') {
                var city = "${terpoint.city}";
                $(ci).each(function () {
                    if (this.value == city) {
                        $(this).attr("selected", "selected");
                        $("#city").attr("disabled", "disabled");
                    }
                });
            }
        });
        $("#province").change();
    })();
    var te = "${terpoint.province}";
    var selected = $("#province  option");
    $(selected).each(function () {
        if (this.value == te) {
            $(this).attr("selected", "selected");
            $("#province").change();
            $("#province").attr("disabled", "disabled");
            $("#city").attr("disabled", "disabled");
        }
    });
    Date.prototype.toLocaleString = function () {
        return this.getFullYear() + "-" + (this.getMonth() + 1) + "-" + this.getDate() + " " + this.getHours() + ":" + this.getMinutes() + ":" + this.getSeconds();
    };

    function getDaoQi() {
        var da = new Date();
        var end;
        if ($("#type").val() == 0) {
            end = da.valueOf() + 13 * 24 * 3600 * 1000;
        } else {
            end = da.valueOf() + 365 * 24 * 3600 * 1000;
        }
        var date1 = new Date(end);
        $("#daoqi").val(date1.toLocaleString());
    }

    $(function () {
        getDaoQi();
        $("#add_terpoint").click(function () {
            //商户名
            var name = $.trim($("input[name='name']").val());
            //商户名
            var userName = $.trim($("input[name='userName']").val());
            //商户名
            var passWord = $.trim($("input[name='passWord']").val());
            //联系方式
            var phone = $.trim($("input[name='phone']").val());
            //联系方式
            var activityNum = $.trim($("input[name='activityNum']").val());
            //到期时间
            var overTime = $.trim($("input[name='overTime']").val());
            var flag = validate(
                name, "请输入商家名称!",
                userName, "请输入账号!",
                passWord, "请输入密码!",
                phone, "请输入联系方式",
                overTime, "请选择到期时间",
                activityNum, "请输入开启商家数量,请不要输入非数字的其他字符"
            );
            if (flag) {
                $.ajax({
                    url: "terPoint/add",
                    type: "post",
                    data: {
                        name: name,
                        userName: userName,
                        passWord: passWord,
                        phone: phone,
                        overTime: overTime,
                        activityNum: activityNum,
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.flag) {
                            layer.msg(data.msg);
                            goFresh("terPoint");
                        } else {
                            layer.msg(data.msg);
                        }
                    }
                });
            }
            return false;
        });

        function validate(date1, msg1, date2, msg2, date3, msg3, date4, msg4, date5, msg5, date6, msg6) {
            var re = /^[0-9]+$/;
            if (date1 == '') {
                layer.msg(msg1);
                return false;
            } else if (date2 == '') {
                layer.msg(msg2);
                return false;
            } else if (date3 == '') {
                layer.msg(msg3);
                return false;
            } else if (date4 == '') {
                layer.msg(msg4);
                return false;
            } else if (date5 == '') {
                layer.msg(msg5);
                return false;
            } else if (date6 == '') {
                layer.msg(msg6);
                return false;
            }

            return true;
        }
    });

    function show() {
        var a = $("#jibie").val();
        if (a == 0) {
            $("#no").css("display", "block");
        } else {
            $("#no").css("display", "none");
            $("shangji").val("1");
        }
    }
</script>
</html>
