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
    <title>结果查询</title>
</head>
<body>
<jsp:include page="../head.jsp"/>
<div class="panel">
    <div class="panel-title">
        结果查询-->${user.team}组-->${user.name}
    </div>
    <div class="panel-searchForm">
        <form id="myForm" method="get" action="performance/report">
            <input type="hidden" name="examId" value="${examId}"/>
            <table>
                <tr>
                    <td>分组:</td>
                    <td>
                        <select id="team" name="team" onchange="myForm.submit()">
                            <option value="">请选择</option>
                            <c:forEach var="code" items="${teams}">
                                <option value="${code.code}" ${team==code.code?"selected":""}>${code.value}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        成员：
                    </td>
                    <td>
                        <c:forEach var="u" items="${users}">
                            <input type="radio" name="userId" value="${u.userId}" ${u.userId==user.userId?"checked":""} onchange="myForm.submit()"/>${u.name}&nbsp;&nbsp;&nbsp;&nbsp;
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <td>
                        评分人：
                    </td>
                    <td>
                        <c:forEach var="u" items="${users}">
                            <c:if test="${user.userId != u.userId}">
                                <input type="radio" name="createdUserId" value="${u.userId}" ${u.userId==createdUser.userId?"checked":""} onchange="myForm.submit()"/>${u.name}&nbsp;&nbsp;&nbsp;&nbsp;
                            </c:if>
                        </c:forEach>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div class="panel-searchForm">
        <table width="100%">
            <tr>
                <td width="50">
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
                    </table>
                </td>

                <td width="50%" valign="top">
                    <jsp:include page="reference.jsp"/>
                </td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>
