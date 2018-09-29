<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <script type="text/javascript" src="<%=basePath%>js/measure/measure.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/public.css">
    <title>指标管理</title>
</head>
<body>
<div class="panel">
    <div class="panel-title">指标管理</div>
    <input type="hidden" id="examId" name="examId" value="${measure.examId}"/>
    <div class="panel-searchForm">
        <br/>
        <input type="button" value="添加"
               onclick="window.open('measure/measure?examId=${measure.examId}', '_blank', 'height=160, width=500, top=10, left=10')"/>
        <br/>
    </div>
    <div class="panel-dataGrid">
        <table width="100%">
            <tr>
                <td class="panel-dataGrid-headerColumn" width="20%">名称</td>
                <td class="panel-dataGrid-headerColumn" width="20%">权重</td>
                <td class="panel-dataGrid-headerColumn" width="40%">描述</td>
                <td class="panel-dataGrid-headerColumn" width="20%">操作</td>
            </tr>
            <c:forEach var="performance" items="${measures}">
                <tr>
                    <td class="panel-dataGrid-dataColumn">${performance.name}</td>
                    <td class="panel-dataGrid-dataColumn">${performance.weight}</td>
                    <td class="panel-dataGrid-dataColumn">${performance.description}</td>
                    <td class="panel-dataGrid-dataColumn">
                        <a href="javascript:void(0)" onclick="deleteMeasure(${performance.measureId})">删除</a>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="javascript:void(0)"
                           onclick="window.open('measure/measure?measureId=${performance.measureId}', '_blank', 'height=160, width=500, top=10, left=10')">更新</a>
                    </td>
                </tr>
            </c:forEach>

            <c:set value="0" var="sum"/>
            <c:forEach var="performance" items="${measures}">
                <c:set value="${performance.weight + sum}" var="sum"/>
            </c:forEach>
            <tr>
                <td class="panel-dataGrid-dataColumn">
                    <B>权重合计</B>
                </td>
                <td class="panel-dataGrid-dataColumn">
                    <c:choose>
                        <c:when test="${sum==100}">
                            <B>${sum}</B>
                        </c:when>
                        <c:otherwise>
                            <font color="red">${sum}</font>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="panel-dataGrid-dataColumn"></td>
                <td class="panel-dataGrid-dataColumn"></td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>
