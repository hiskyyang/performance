<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="<%=basePath%>js/jquery/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/public.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/code/code.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/public.css">
    <title>字典管理</title>
</head>
<body>
<div class="panel">
    <div class="panel-title">字典管理</div>
    <div class="panel-searchForm">
        <form id="myForm" method="post" action="code/add">
            <input type="hidden" id="codeId" name="codeId" value="${code.codeId}"/>
            <table>
                <tr>
                    <td>Type</td>
                    <td>
                        <select id="type" name="type">
                            <option value="">--请选择--</option>
                            <c:forEach var="type" items="${types}">
                                <option value="${type}" ${code.type==type?"selected":""}>${type}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Code</td>
                    <td><input id="code" name="code" value="${code.code}"></td>
                </tr>
                <tr>
                    <td>Value</td>
                    <td><input id="value" name="value" value="${code.value}"></td>
                </tr>
                <tr>
                    <td>Sequence</td>
                    <td><input id="sequence" name="sequence" value="${code.sequence}"></td>
                </tr>
                <tr>
                    <td><input type="button" value="保存" onclick="save()"/></td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>