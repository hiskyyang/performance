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
<jsp:include page="../head.jsp"/>
<div class="panel">
    <div class="panel-title">用户管理</div>
    <div class="panel-searchForm">
        <form id="myForm" method="get" action="code/list">
            <table>
                <tr>
                    <td>Type</td>
                    <td>
                        <select id="type" name="type">
                            <option value="">--请选择--</option>
                            <c:forEach var="type" items="${types}">
                                <option value="${type}" ${type==code.type ? "selected" : ""}>${type}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Code</td>
                    <td>
                        <input id="code" name="code" value="${code.code}">
                        </input>
                    </td>
                </tr>
                <tr>
                    <td>Value</td>
                    <td>
                        <input id="value" name="value" value="${code.value}">
                        </input>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="查询"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="button" value="添加"
                               onclick="window.open('code/code', '_blank', 'height=180, width=500, top=10, left=10')"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <div class="panel-dataGrid">
        <table width="100%">
            <tr>
                <td class="panel-dataGrid-headerColumn" width="20%">Type</td>
                <td class="panel-dataGrid-headerColumn" width="20%">Code</td>
                <td class="panel-dataGrid-headerColumn" width="20%">Value</td>
                <td class="panel-dataGrid-headerColumn" width="20%">Sequence</td>
                <td class="panel-dataGrid-headerColumn" width="20%">操作</td>
            </tr>
            <c:forEach var="c" items="${list}">
                <tr>
                    <td class="panel-dataGrid-dataColumn">${c.type}</td>
                    <td class="panel-dataGrid-dataColumn">${c.code}</td>
                    <td class="panel-dataGrid-dataColumn">${c.value}</td>
                    <td class="panel-dataGrid-dataColumn">${c.sequence}</td>
                    <td class="panel-dataGrid-dataColumn">
                        <a href="javascript:void(0)" onclick="deleteCode(${c.codeId})">删除</a>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="javascript:void(0)"
                           onclick="window.open('code/code?codeId=${c.codeId}', '_blank', 'height=180, width=500, top=10, left=10')">更新</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
</body>
</html>
