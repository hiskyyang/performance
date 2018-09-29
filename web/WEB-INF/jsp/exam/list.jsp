<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
        $(function() {
            $( "#startTime" ).datepicker({
                "dateFormat": "yy-mm-dd",
                changeMonth: true,
                changeYear: true,
                showOtherMonths: true,
                selectOtherMonths: true
            });

            $( "#endTime" ).datepicker({
                "dateFormat": "yy-mm-dd",
                changeMonth: true,
                changeYear: true,
                showOtherMonths: true,
                selectOtherMonths: true
            });
        });
    </script>
    <title>考核管理</title>
</head>
<body>
    <jsp:include page="../head.jsp"/>
    <div class="panel">
        <div class="panel-title">考核管理</div>
        <div class="panel-searchForm">
            <form id="myForm" method="get" action="exam/list">
                <table>
                    <tr>
                        <td>名称:</td>
                        <td><input id="name" name="name" value="${exam.name}"/></td>
                    </tr>
                    <tr>
                        <td>开始时间:</td>
                        <td>
                            <input id="startTime" name="startTime" value="<fmt:formatDate value="${exam.startTime}" pattern= "yyyy-MM-dd"/>"/>
                        </td>
                    </tr>
                    <tr>
                        <td>结束时间:</td>
                        <td>
                            <input id="endTime" name="endTime" value="<fmt:formatDate value="${exam.endTime}" pattern= "yyyy-MM-dd"/>"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" value="查询"/>&nbsp;&nbsp;&nbsp;&nbsp;
                            <c:if test="${sessionScope.user.role==0}">
                                <input type="button" value="添加" onclick="window.open('exam/exam', '_blank', 'height=180, width=500, top=10, left=10')"/> &nbsp;&nbsp;&nbsp;&nbsp;
                            </c:if>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="panel-dataGrid">
            <table width="100%">
                <tr>
                    <td class="panel-dataGrid-headerColumn" width="10%">名称</td>
                    <td class="panel-dataGrid-headerColumn" width="10%">开始时间</td>
                    <td class="panel-dataGrid-headerColumn" width="10%">结束时间</td>
                    <td class="panel-dataGrid-headerColumn" width="20%">状态</td>
                    <td class="panel-dataGrid-headerColumn" width="20%">操作</td>
                </tr>
                <c:forEach var="exam" items="${exams}">
                    <tr>
                        <td class="panel-dataGrid-dataColumn">${exam.name}</td>
                        <td class="panel-dataGrid-dataColumn">
                            <fmt:formatDate value="${exam.startTime}" pattern= "yyyy-MM-dd"/>
                        </td>
                        <td class="panel-dataGrid-dataColumn">
                            <fmt:formatDate value="${exam.endTime}" pattern= "yyyy-MM-dd"/>
                        </td>
                        <td class="panel-dataGrid-dataColumn">${exam.status}</td>
                        <td class="panel-dataGrid-dataColumn">
                            <c:if test="${sessionScope.user.role==0}">
                                <a href="javascript:void(0)" onclick="deleteExam(${exam.examId})">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <a href="javascript:void(0)" onclick="window.open('exam/exam?examId=${exam.examId}', '_blank', 'height=180, width=500, top=10, left=10')">更新</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <a href="measure/list?examId=${exam.examId}" target="_blank">指标管理</a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <a href="performance/report?examId=${exam.examId}" target="_blank">评分结果</a>&nbsp;&nbsp;&nbsp;&nbsp;
                            </c:if>
                            <a href="performance/list?examId=${exam.examId}" target="_blank">开始评分</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</body>
</html>
