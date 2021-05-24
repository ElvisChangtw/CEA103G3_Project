<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.order.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	OrderService orderSvc = new OrderService();
    List<OrderVO> list = orderSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<% 
	java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");; 
	pageContext.setAttribute("df",df);
%>

<html>
<head>
<title>所有場次資料 - listAllOrder.jsp</title>

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
		 <h3>所有訂單資料 - listAllOrder.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/order/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/theater/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
		<th>會員編號</th>
		<th>場次編號</th>
		<th>成立時間</th>
		<th>訂單狀態</th>
		<th>訂單種類</th>
		<th>付款方式</th>
		<th>訂單總價</th>
		<th>座位</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="orderVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${orderVO.order_no}</td>
			<td>${orderVO.member_no}</td>
			<td>${orderVO.showtime_no}</td>
			<td>${df.format(orderVO.crt_dt)}</td>
			<td>
				<c:choose>
					<c:when test="${orderVO.order_status == 0 }">
						未付款
					</c:when>
					<c:when test="${orderVO.order_status == 1 }">
						已付款
					</c:when>
					<c:when test="${theaterVO.theater_type == 2 }">
						已取消
					</c:when>
				</c:choose>
			</td>
			<td>${orderVO.order_type == 0 ? "現場" : "線上"}</td>
			<td>
				<c:choose>
					<c:when test="${orderVO.payment_type == 0 }">
						信用卡
					</c:when>
					<c:when test="${orderVO.payment_type == 1 }">
						現金
					</c:when>
					<c:when test="${orderVO.payment_type == 2 }">
						現場付款
					</c:when>
				</c:choose>
			</td>
			<td>${orderVO.total_price }</td>
			<td>${orderVO.seat_name}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/order/order.do" style="margin-bottom: 0px;">
			     <input type="submit" value="查看">
			     <input type="hidden" name="order_no"  value="${orderVO.order_no}">
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">
			     <input type="hidden" name="action"	value="getOne_For_Order"></FORM>
<%-- 				${orderVO.seat_no} --%>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/order/order.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="order_no"  value="${orderVO.order_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/order/order.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="order_no"  value="${orderVO.order_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

<%if (request.getAttribute("orderVO")!=null){%>
<%-- <jsp:include page="listOneOrder.jsp" /> --%>
<%} %>
</body>
</html>