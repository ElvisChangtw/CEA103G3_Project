<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.employee.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  EmployeeVO employeeVO = (EmployeeVO) request.getAttribute("employeeVO"); //EmpServlet.java(Concroller), 存入req的employeeVO物件
%>

<html>
<head>
<title>員工資料 - listOneEmployee.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
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
	width: 1000px;
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

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>員工資料 - ListOneEmployee.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>員工編號</th>
		<th>員工姓名</th>
		<th>員工密碼</th>
		<th>性別</th>
		<th>電話</th>
		<th>電子郵件</th>
		<th>職稱</th>
		<th>雇用日期</th>
		<th>離職日期</th>
		<th>在職狀態</th>
	</tr>
	<tr>
		<td><%=employeeVO.getEmpno()%></td>
		<td><%=employeeVO.getEmpname()%></td>
		<td><%=employeeVO.getEmppwd()%></td>
		<td><%=employeeVO.getGender()%></td>
		<td><%=employeeVO.getTel()%></td>
		<td><%=employeeVO.getEmail()%></td>
		<td><%=employeeVO.getTitle()%></td>
		<td><%=employeeVO.getHiredate()%></td>
		<td><%=employeeVO.getQuitdate()%></td>
		<td><%=employeeVO.getStatus()%></td>
	</tr>
</table>

</body>
</html>