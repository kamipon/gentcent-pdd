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


    <title>注册</title>

    <link rel="shortcut icon" href="favicon.ico">
    <link href="css/bootstrap.minb16a.css?v=3.3.5" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min1fc6.css?v=4.0.0" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>manager/js/date/WdatePicker.js"></script>
    <script type="text/javascript" src="js/11cms.js"></script>
    <link href="css/image_plugin.css" rel="stylesheet" type="text/css"/>
    <link href="//cdn.bootcss.com/summernote/0.8.1/summernote.css" rel="stylesheet">
    <link href="${cp }/manager/css/plugins/summernote/summernote.css" rel="stylesheet">
    <link href="${cp }/manager/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>注册</h5>
                </div>
                <div class="ibox-content">
                    <form method="post" class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><font color="red">*</font>商家名</label>
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
                                <input type="text" class="form-control" name="password">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><font color="red">*</font>联系方式</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="phone">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">描述</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="desc">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">到期时间</label>
                            <div class="col-sm-10">
                                <input id="daoqi" type="text" name="overTime" readonly="readonly" class="form-control"
                                       class="Wdate" size="12">
                            </div>
                        </div>


                        <div>
                            <button class="btn btn-primary" type="button" id="add_activity">新增</button>
                            <button class="btn btn-primary" type="reset" id="remove" value="重置">重置</button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>
<script src="js/jquery.min63b9.js?v=2.1.4"></script>
<script src="js/bootstrap.minb16a.js?v=3.3.5"></script>
<script src="js/content.mine209.js?v=1.0.0"></script>
<script src="js/plugins/iCheck/icheck.min.js"></script>
<script src="js/layer/layer.js"></script>
<script type="text/javascript" src="js/childrenToMenu.js"></script>
<script type="text/javascript" src="<%=basePath%>manager/js/chengs.js"></script>
<script src="${cp }/manager/js/plugins/summernote/summernote.min.js"></script>
<script src="${cp }/manager/js/plugins/summernote/summernote.js"></script>
<script src="${cp }/manager/js/plugins/summernote/summernote-zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>manager/js/city.js"></script>
<jsp:include page="plugin_image.jsp"></jsp:include>
</body>
<script type="text/javascript">
    Date.prototype.toLocaleString = function () {
        return this.getFullYear() + "-" + (this.getMonth() + 1) + "-" + this.getDate() + " " + this.getHours() + ":" + this.getMinutes() + ":" + this.getSeconds();
    };

    function getDaoQi() {
        var da = new Date();
        var end;
        if ($("#type").val() == 0) {
            end = da.valueOf() + 7 * 24 * 3600 * 1000;
        } else {
            end = da.valueOf() + 365 * 24 * 3600 * 1000;
        }
        var date1 = new Date(end);
        $("#daoqi").val(date1.toLocaleString());
        guoQi();
    }

    function guoQi() {
        if ($("#type").val() == 0) {
            $("#daoqi").removeAttr("onclick");
        } else {
            $("#daoqi").attr("onclick", "WdatePicker()");
        }
    }

    $(function () {
        guoQi();
        getDaoQi();
        $("#add_activity").click(function () {
            //商家名
            var name = $.trim($("input[name='name']").val());
            //联系方式
            var phone = $.trim($("input[name='phone']").val());
            //账号
            var userName = $.trim($("input[name='userName']").val());
            //密码
            var password = $.trim($("input[name='password']").val());
            //描述
            var desc = $.trim($("input[name='desc']").val());
            //到期时间
            var overTime = $.trim($("input[name='overTime']").val());

            //商家类型*/
            var type = 1;

            var flag = validate(
                name, "请输入商家名称!",
                userName, "请输入账号",
                password, "请输入密码",
                phone, "请输入联系方式"
            );
            if (flag) {
                $.ajax({
                    url: "activity/add",
                    type: "post",
                    data: {
                        name: name,
                        phone: phone,
                        userName: userName,
                        password: password,
                        desc: desc,
                        overTime: overTime,
                        type: type
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.flag) {
                            layer.msg(data.msg);
                            goFresh("activity");
                        } else {
                            layer.msg(data.msg);
                        }
                    }
                });
            }
            return false;
        });

        function validate(date1, msg1, date2, msg2, date3, msg3, date4, msg4/*,date5,msg5,date6,msg6,date7,msg7,date8,msg8*/) {
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
            }
            return true;
        }
    });

    function showImg(imgId) {
        var ref = $("#" + imgId);
        render(function (url) {
            $(ref).attr("src", url);
            $(ref).removeAttr("style");
            $(ref).height(100);
            $(ref).width(100);
        });
    }

</script>
</html>
