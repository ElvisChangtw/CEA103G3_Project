<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ord_ticket_type.model.*"%>
<%@ page import="com.ord_food.model.*"%>
<%@ page import="com.food.model.*"%>
<%@ page import="com.ticket_type.model.*"%>
<%@ page import="java.util.*"%>

<%
//	Ord_ticket_typeVO ord_ticket_typeVO = (Ord_ticket_typeVO) request.getAttribute("ord_ticket_typeVO");
//	Ord_ticket_typeService ord_ticket_typeSvc = new Ord_ticket_typeService();
//	List<Ord_ticket_typeVO> list = ord_ticket_typeSvc.getAll();
//	pageContext.setAttribute("list", list);
	
// 	  Ord_foodVO ord_foodVO = (Ord_foodVO) request.getAttribute("ord_foodVO");
// 	  Ord_foodService ord_foodSvc = new Ord_foodService();
// 	  List<Ord_foodVO> list1 = ord_foodSvc.getAll();
// 	  pageContext.setAttribute("list1", list1);
%>


<jsp:useBean id="ticket_typeSvc" scope="page" class="com.ticket_type.model.Ticket_typeService" />
<jsp:useBean id="foodSvc" scope="page" class="com.food.model.FoodService" />

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>訂單票種資料新增 - addOrd_ticket_type.jsp</title>

<style>
table {
	width: 600px;
	background-color: white;
	margin-top: 20px;
	/* 	margin-bottom: 1px; */
}

table, th, td {
	border: 0px;
}

th {
	background-color: #337ab7;
	text-align: left;
	color: white;
}

td {
	line-height: 30px;
	color: black;
}

#div1, #div6 {
	width: 600px;
/* 	height: 150px; */
/* 	background-color: rgba(0, 0, 0, 0.5); */
	padding-top: 10px;
	padding-bottom: 10px;
}
#div2,#div7{
	background-color: rgba(0, 0, 0, 0.5);
	padding-top: 10px;
	padding-bottom: 10px;
}

FORM {
	margin-bottom: 20px;
}

#h2, #h3 {
	text-align: center;
	margin-top: 20px;
	color: white; 
}

#p1, #p2 {
	text-align: center;
	color: white;
}

img{
  	width: 115px;
  	height: 100px;
  	margin: 0 auto;
  }
</style>


</head>
<body bgcolor='white'>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/order/order.do" name="form1">
		<div id="div1">
			<div id="div2">
				<h2 id="h2">選擇電影票</h2>
				<p id="p1">選擇您希望購買的電影票張數和類型.請注意系統將自動為您保留可訂的最佳座位, 每筆交易最多可購買10張電影票</p>
			</div>
			<table>
				<tr>
					<th>票種</th>
					<th>數量</th>
					<th>價格</th>
				</tr>
				<c:forEach var="ticket_typeVO" items="${ticket_typeSvc.all}">

					<tr>
						<td>${ticket_typeVO.ticket_desc}</td>
						<td>$ ${ticket_typeVO.ticket_price}</td>
						<td><select name="ticket_count">
								<option value="0">0</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
						</select>
					</tr>
					<input type="hidden" name="ticket_type_no"
						value="${ticket_typeVO.ticket_type_no}">
					<input type="hidden" name="ticket_price"
						value="${ticket_typeVO.ticket_price}">
				</c:forEach>

			</table>
		</div>

		<div id="div6">
			<div id="div7">
				<h2 id="h3">選擇餐飲</h2>
				<p id="p2">請選擇販賣部商品並結帳</p>
			</div>
				<c:forEach var="foodVO" items = "${foodSvc.all}">
					<div style="display: inline-block; margin-top: 20px; text-align:center;">
						<img src="<%=request.getContextPath()%>/food/food.do?action=getPic&food_no=${foodVO.food_no}" >
						<p>${foodVO.food_name}</p>
						<p>$ ${foodVO.food_price}</p>
						<select name="food_count">
							<option value="0">0</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
						</select>
						<input type="hidden" name="food_no"  value="${foodVO.food_no}">
						<input type="hidden" name="food_price"  value="${foodVO.food_price}">
					</div>
				</c:forEach>
			<input type="hidden" name="action" value="sendToST">
<!-- 			<input type="hidden" name="action" value="insert3"> -->
			
			<input type="submit" value="繼續   →" style="margin-top: 20px; background-color: #337ab7; 
			color: white; border: white; width:100px; height:50px; margin-left: 100%;">
		</div>
	</FORM>

	
</body>
</html>