<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.authority.model.*"%>
<%@ page import="com.function.model.*"%>
<%@ page import="com.employee.model.*"%>

<%-- <% --%>
<!-- // 	FunctionService functionSvc1 = new FunctionService(); -->
<!-- // 	System.out.println(functionSvc1.getOneFunction(12).getFunction_desc()); -->

<%-- %> --%>

<%-- <jsp:useBean id="listAuths_ByEmpno" scope="request" type="java.util.Set<AuthorityVO>" /> <!-- 於EL此行可省略 --> --%>
<jsp:useBean id="authoritytSvc" scope="page" class="com.authority.model.AuthorityService" />
<jsp:useBean id="functionSvc" scope="page" class="com.function.model.FunctionService" />
<jsp:useBean id="employeeSvc" scope="page" class="com.employee.model.EmployeeService" />


<html>
<head><title>部門員工 - listAuths_ByEmpno.jsp</title>

<style>
  table#table-2 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-2 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>


<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
<tr>
<th>員工：<font color="blue">${employeeSvc.getOneEmp(empno).empname} </font> 權限列表</th>
</tr>
</table>

 <table>
	<tr>
		<th>功能編號 </th>
		<th>功能名稱</th>
		<th>權限狀態</th>
<!-- 		<th>修改</th> -->
<!-- 		<th>刪除</th> -->
	</tr>
	
	<c:forEach var="authorityVO" items="${listAuths_ByEmpno}" >
		<tr>
			<td>${authorityVO.function_no}</td>
			<td>${functionSvc.getOneFunction(authorityVO.function_no).function_desc}</td>
			<td>
			<c:if test="${authorityVO.auth_status eq 'Y'}">
			<font color="red"><b>${authorityVO.auth_status}</b></font>
			</c:if>
			<c:if test="${authorityVO.auth_status eq 'N'}">
			<font color="black">${authorityVO.auth_status}</font>
			</c:if>
			</td>
<%-- 			<td><c:forEach var="deptVO" items="${deptSvc.all}"> --%>
<%--                     <c:if test="${authorityVO.deptno==deptVO.deptno}"> --%>
<%-- 	                    ${deptVO.deptno}【<font color=orange>${deptVO.dname}</font> - ${deptVO.loc}】 --%>
<%--                     </c:if> --%>
<%--                 </c:forEach> --%>
<!-- 			</td> -->
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" style="margin-bottom: 0px;"> --%>
<!-- 			    <input type="submit" value="修改">  -->
<%-- 			    <input type="hidden" name="empno"      value="${authorityVO.empno}"> --%>
<%-- 			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--><!-- 目前尚未用到  --> --%>
<!-- 			    <input type="hidden" name="action"	   value="getOne_For_Update"></FORM> -->
<!-- 			</td> -->
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" style="margin-bottom: 0px;"> --%>
<!-- 			    <input type="submit" value="刪除"> -->
<%-- 			    <input type="hidden" name="empno"      value="${authorityVO.empno}"> --%>
<%-- 			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--> --%>
<!-- 			    <input type="hidden" name="action"     value="delete"></FORM> -->
<!-- 			</td> -->
		</tr>
	</c:forEach>
</table>

<!-- <br>本網頁的路徑:<br><b> -->
<%--    <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br> --%>
<%--    <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b> --%>

</body>
</html>