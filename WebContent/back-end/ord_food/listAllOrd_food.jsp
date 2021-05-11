<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ord_food.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	Ord_foodService ord_foodSvc = new Ord_foodService();
    List<Ord_foodVO> list = ord_foodSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<html>
<head>
<title>所有場次資料 - listAllOrd_food.jsp</title>

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
		 <h3>所有場次資料 - listAllOrd_food.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/ord_food/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/theater/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
		<th>餐點編號</th>
		<th>餐點數量</th>
		<th>餐點價格</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="ord_foodVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${ord_foodVO.order_no}</td>
			<td>${ord_foodVO.food_no}</td>
			<td>${ord_foodVO.food_count}</td>
			<td>${ord_foodVO.price}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ord_food/ord_food.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="order_no"  value="${ord_foodVO.order_no}">
			     <input type="hidden" name="food_no"  value="${ord_foodVO.food_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ord_food/ord_food.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="order_no"  value="${ord_foodVO.order_no}">
			     <input type="hidden" name="food_no"  value="${ord_foodVO.food_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

<%if (request.getAttribute("ord_foodVO")!=null){%>
<jsp:include page="listOneOrd_food.jsp" />
<%} %>
</body>
</html>