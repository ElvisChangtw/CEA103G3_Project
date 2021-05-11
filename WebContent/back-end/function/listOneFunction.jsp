<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.function.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  FunctionVO functionVO = (FunctionVO) request.getAttribute("functionVO"); //EmpServlet.java(Concroller), 存入req的functionVO物件
%>

<html>
<head>
<title>員工資料 - listOneFunction.jsp</title>

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
		 <h3>員工資料 - ListOneFunction.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>功能編號</th>
		<th>功能說明</th>
		<th>功能狀態</th>
	</tr>
	<tr>
		<td><%=functionVO.getFunction_no()%></td>
		<td><%=functionVO.getFunction_desc()%></td>
		<td><%=functionVO.getStatus()%></td>
	</tr>
</table>

</body>
</html>