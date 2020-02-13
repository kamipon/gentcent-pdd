<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath }"></c:set>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>红包管理-红包转账安全证书</title>
	<link rel="shortcut icon" href="favicon.ico">
	<link href="css/bootstrap.minb16a.css" rel="stylesheet">
	<link href="css/font-awesome.min93e3.css" rel="stylesheet">
	<link href="css/plugins/iCheck/custom.css" rel="stylesheet">
	<link href="css/animate.min.css" rel="stylesheet">
	<link href="css/style.min1fc6.css" rel="stylesheet">
	<script src="${cp }/js/jquery.min63b9.js?v=2.1.4"></script>
	<script type="text/javascript" src="${cp }/manager/date/WdatePicker.js"></script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>
							红包管理-红包转账安全证书
						</h5>
						<div class="ibox-content" style="background-color: white;padding: 20px 5px 20px;">
							<form action="brokerage/upredbook" name="form1" method="post">
						   		<table  width="100%" border="0" cellspacing="1" cellpadding="0" style="" class="table_border">
				                    <tbody class="pn-ltbody" id="user">
				                        <tr>
				                        	<td width="30%">
				                        		上传安全证书(仅上传结尾为.P12的证书，上传后刷新查看是否上传成功):
				                        	</td>
				                            <td style="height: 40px;padding-left: 20px"  align="left">
					                            <input type="file" class="required" onChange="submitFile(this);" 
													name="upload" id="upload" />
												<span style="color: red;font-size: 11px">
													<c:if test="${red.newFileName!=null}">
														*文件已上传至服务器
													</c:if>
													<c:if test="${red.newFileName==null}">
														*文件未上传
													</c:if>
												</span>
				                            </td>
				                        </tr>
				                    </tbody>
				                </table>
							</form>
							<iframe name="hidden_frame" id="hidden_frame" style="display: none" style="display:none"></iframe>
						</div>
						<jsp:include page="message.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="${cp }/js/11cms.js"></script>
	<script type="text/javascript" src="${cp }/js/childrenToMenu.js"></script>
	<script src="${cp }/js/layer/layer.js"></script>
	<script type="text/javascript">
		function submitFile(){
	      	var f=this.form1;
	      	var temp=f.action;
			f.action="present/upload";
			f.target="hidden_frame";
			f.enctype="multipart/form-data";
			f.submit();
			f.action=temp;
			f.target="";
			f.removeAttribute("enctype");
	    }

		function old(oldpassword){
			var password=$('#redpassword').val();
			if(oldpassword!=password){
				alert("旧密码填写错误，请重新输入");
				return false;
			}else{
				return true;
			}
	    }
	</script>
</body>
</html>