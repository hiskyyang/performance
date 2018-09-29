<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
    <script type="text/javascript" src="<%=basePath%>js/performance/performance.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/public.css">
    <title>绩效管理</title>
</head>
<body>
<jsp:include page="../head.jsp"/>
<div class="panel">
    <div class="panel-title">
        绩效管理-->${user.team}组-->${user.name}
    </div>
    <div class="panel-searchForm">
        <c:forEach var="u" items="${users}">
            <a href="performance/list?examId=${examId}&userId=${u.userId}">${u.name}</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </c:forEach>
    </div>
    <div class="panel-searchForm">
        <form id="myForm" method="post" action="code/add">
            <table>
                <tr>
                    <td width="30%">指标</td>
                    <td width="30%">权重</td>
                    <td width="40%">分数</td>
                </tr>
                <c:forEach var="performance" items="${performances}">
                    <input type="hidden" id="performanceId" name="performanceId" value="${performance.performanceId}"/>
                    <tr>
                        <td>${performance.measureName}</td>
                        <td>${performance.measureWeight}%</td>
                        <td>
                            <input name="score" id="score" value="${performance.score}"
                                   onkeyup="this.value=this.value.replace(/\D/g,'')"
                                   onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
                        </td>
                    </tr>
                </c:forEach>

                <c:set var="sum" value="0"/>
                <c:forEach var="performance" items="${performances}">
                    <c:set value="${performance.score * (performance.measureWeight/100) + sum }" var="sum"/>
                </c:forEach>
                <tr>
                    <td><B>最终得分</B></td>
                    <td></td>
                    <td>
                        <B>${sum}</B>
                    </td>
                </tr>

                <tr>
                    <td><input type="button" value="保存" onclick="save()"/></td>
                </tr>
            </table>

            <br>
            评分标准
            <table>
                <tr>
                    <td width="50%">优秀</td><td width="50%">90-100</td>
                </tr>
                <tr>
                    <td width="30%">良好</td><td width="30%">80-89</td>
                </tr>
                <tr>
                    <td width="30%">一般</td><td width="30%">70-79</td>
                </tr>
                <tr>
                    <td width="30%">勉强</td><td width="30%">60-69</td>
                </tr>
                <tr>
                    <td width="30%">不合格</td><td width="30%">0-59</td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>
