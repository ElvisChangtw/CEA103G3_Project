<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.food.model.*"%>

<%
  FoodVO foodVO = (FoodVO) request.getAttribute("foodVO");
%>
<%= foodVO==null %>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>廳院資料新增 - addTheater.jsp</title>

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

</style>
</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3> 場次資料新增 - addFood.jsp </h3></td><td>
		 <h4> <a href="<%=request.getContextPath()%>/back-end/food/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/theater/images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/food/food.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>餐點名稱</td>
		<td>
			<input name="food_name" type="text" value="${foodVO.food_name}">
		</td>
	</tr>
	<tr>
		<td>餐點種類 </td>
		
		<td>
			<select name="food_type">
					<option value= "0" ${(foodVO.food_type == "0") ? "selected" : "" }>熟食類</option>
					<option value= "1" ${(foodVO.food_type == "1" ) ? "selected" : "" }>飲料類</option>
					<option value= "2" ${(foodVO.food_type == "2" ) ? "selected" : "" }>爆米花類</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>餐點價格</td>
		<td>
			<input name="food_price"  type="number" max="2000" min="0" value="${foodVO.food_price}">
		</td>
	</tr>
	<tr>
		<td>餐點圖片</td>
		<td>
			<input name="food_pic" type="file">
		</td>
	</tr>
	<tr>
		<td>餐點狀態</td>
		<td>
			<select name="food_status">
				<option value="0" ${foodVO.food_status == 0 ? "selected" : ""}>下架</option>
				<option value="1" ${foodVO.food_status == 1 ? "selected" : ""}>上架</option>
			</select>
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增">
</FORM>


</body>
</html>