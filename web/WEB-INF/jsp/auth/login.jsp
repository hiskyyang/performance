<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=basePath%>js/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%=basePath%>js/auth.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/public.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/public.css">
<title>用户登录</title>
</head>
<body>
	<div class="panel">
		<div class="panel-title">用户登录</div>
		<div class="panel-searchForm">
			<form id="myForm" method="post" action="auth/login">
				<table>
					<tr>
						<td colspan="2">登录</td>
					</tr>
					<tr>
						<td>账号:</td>
						<td><input id="name" name="name" value="hisky"/></td>
					</tr>
					<tr>
						<td>密码:</td>
						<td><input id="password" name="password" type="password" value="123456"/></td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="button" value="登录" onclick="login()" />
							<input type="reset" value="重置" />
						</td>
					</tr>
					<tr>
						<td>${errorMsg}</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>
