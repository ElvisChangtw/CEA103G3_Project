<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.ord_ticket_type.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  Ord_ticket_typeVO ord_ticket_typeVO = (Ord_ticket_typeVO) request.getAttribute("ord_ticket_typeVO"); //Tikcet_typeServlet.java(Concroller), 存入req的theaterVO物件
%>

<html>
<head>
<title>訂單票種資料 - listOneOrd_tikcet_type.jsp</title>

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
	width: 700px;
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
		 <h3>訂單票種資料 - ListOneTikcet_type.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/ord_ticket_type/select_page.jsp"><img src="/CEA103G3/back-end/theater/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>訂單編號</th>
		<th>票種編號</th>
		<th>票種數量</th>
		<th>票種價格</th>
	</tr>
	
	<tr>
			<td>${ord_ticket_typeVO.order_no}</td>
			<td>${ord_ticket_typeVO.ticket_type_no}</td>
			<td>${ord_ticket_typeVO.ticket_count}</td>
			<td>${ord_ticket_typeVO.price}</td>
	</tr>
</table>
	
</body>
</html>