<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ord_food.model.*"%>
<%@ page import="java.util.*"%>

<%
  Ord_foodVO ord_foodVO = (Ord_foodVO) request.getAttribute("ord_foodVO");
  Ord_foodService ord_foodSvc = new Ord_foodService();
  List<Ord_foodVO> list = ord_foodSvc.getAll();
  pageContext.setAttribute("list", list);
%>

<%= ord_foodVO==null %>
<jsp:useBean id="foodSvc" scope="page" class="com.food.model.FoodService" />

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>餐點資料新增 - addOrd_food.jsp</title>

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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
  img{
  	width: 100%;
  	height: 100px;
  	margin: 0 auto;
  }
  div{
  	border: 1px solid gray;
  	display: inline-block;
  	width: 200px;
  	height: 250px;
  	margin-bottom: 10px;
  	text-align:center
  	
  }
  
		
</style>


</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>餐點資料新增 - addTicket_type.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/ord_food/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/theater/images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>選擇餐點:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ord_food/ord_food.do" name="form1">

		<c:forEach var="foodVO" items = "${foodSvc.all}">
			<div>
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
<br>
<input type="hidden" name="action" value="insert2">
<input type="submit" value="送出">
</FORM>

</body>
</html>