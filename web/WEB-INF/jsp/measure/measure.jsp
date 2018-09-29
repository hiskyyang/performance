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
        <div class="panel-searchForm">
            <form id="myForm" method="post" action="measure/add">
                <input type="hidden" value="${measure.examId}" id="examId" name="measureId"/>
                <input type="hidden" value="${measure.measureId}" id="measureId" name="measureId"/>
                <table>
                    <tr>
                        <td>名称:</td>
                        <td><input id="name" name="name" value="${measure.name}"/></td>
                    </tr>
                    <tr>
                        <td>描述:</td>
                        <td><input id="description" name="description" value="${measure.description}"/></td>
                    </tr>
                    <tr>
                        <td>权重:</td>
                        <td><input id="weight" name="weight" value="${measure.weight}"/></td>
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