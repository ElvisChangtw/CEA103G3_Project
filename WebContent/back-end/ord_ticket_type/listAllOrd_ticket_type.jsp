<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ord_ticket_type.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	Ord_ticket_typeService ord_ticket_typeSvc = new Ord_ticket_typeService();
    List<Ord_ticket_typeVO> list = ord_ticket_typeSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<html>
<head>
<title>所有場次資料 - listAllTicket_type.jsp</title>

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

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有場次資料 - listAllTicket_type.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/ord_ticket_type/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/theater/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

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
		<th>訂單編號</th>
		<th>票種編號</th>
		<th>票種數量</th>
		<th>票種價格</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="ord_ticket_typeVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${ord_ticket_typeVO.order_no}</td>
			<td>${ord_ticket_typeVO.ticket_type_no}</td>
			<td>${ord_ticket_typeVO.ticket_count}</td>
			<td>${ord_ticket_typeVO.price}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ord_ticket_type/ord_ticket_type.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="ticket_type_no"  value="${ord_ticket_typeVO.ticket_type_no}">
			     <input type="hidden" name="order_no"  value="${ord_ticket_typeVO.order_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ord_ticket_type/ord_ticket_type.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="ticket_type_no"  value="${ord_ticket_typeVO.ticket_type_no}">
			     <input type="hidden" name="order_no"  value="${ord_ticket_typeVO.order_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

<%if (request.getAttribute("ord_ticket_typeVO")!=null){%>
<jsp:include page="listOneOrd_ticket_type.jsp" />
<%} %>
</body>
</html>