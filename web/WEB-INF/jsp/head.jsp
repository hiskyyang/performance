<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="header">
    <div class="header-bannaer"></div>
    <div class="header-menu">
        <a href="exam/list">考核管理</a>
        <c:if test="${sessionScope.user.role==0}">
            &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a href="code/list">字典管理</a>
        </c:if>
        &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;<a href="user/list">用户管理</a>
    </div>
    <div class="header-user">
        ${sessionScope.user.name}
        &nbsp;&nbsp;
        <a href="auth/logout">退出</a>
    </div>
</div>
