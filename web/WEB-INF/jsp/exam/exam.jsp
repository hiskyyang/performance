<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="<%=basePath%>css/jquery-ui/jquery-ui-1.9.2.custom.css" rel="stylesheet">
    <link href="<%=basePath%>css/jquery-ui/jquery.ui.all.css" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath%>js/jquery/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery-ui/jquery-ui-1.9.2.custom.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/public.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/exam/exam.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/public.css">
    <script>
        $(function () {
            $("#startTime").datepicker({
                "dateFormat": "yy-mm-dd",
                changeMonth: true,
                changeYear: true,
                showOtherMonths: true,
                selectOtherMonths: true
            });

            $("#endTime").datepicker({
                "dateFormat": "yy-mm-dd",
                changeMonth: true,
                changeYear: true,
                showOtherMonths: true,
                selectOtherMonths: true
            });
        });
    </script>
    <title>样品管理</title>
</head>
<body>
    <div class="panel">
        <div class="panel-title">考核管理</div>
        <div class="panel-searchForm">
            <form id="myForm" method="post" action="exam/add">
                <input type="hidden" value="${exam.examId}" id="examId" name="examId"/>
                <table>
                    <tr>
                        <td>名称:</td>
                        <td><input id="name" name="name" value="${exam.name}"/></td>
                    </tr>
                    <tr>
                        <td>开始时间:</td>
                        <td><input id="startTime" name="startTime"
                                   value="<fmt:formatDate value="${exam.startTime}" pattern= "yyyy-MM-dd"/>"></td>
                    </tr>
                    <tr>
                        <td>结束时间:</td>
                        <td><input id="endTime" name="endTime"
                                   value="<fmt:formatDate value="${exam.endTime}" pattern= "yyyy-MM-dd"/>"></td>
                    </tr>
                    <tr>
                        <td>状态:</td>
                        <td>
                            <select id="status" name="status">
                                <option value="">请选择</option>
                                <c:forEach var="code" items="${statuses}">
                                    <option value="${code.code}" ${exam.status==code.code?"selected":""}>${code.value}</option>
                                </c:forEach>
                            </select>
                        </td>
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