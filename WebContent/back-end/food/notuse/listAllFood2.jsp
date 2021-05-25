<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.food.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	FoodService foodSvc = new FoodService();
    List<FoodVO> list = foodSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<html>
<head>
<title>所有餐點資料 - listAllFood.jsp</title>

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
		 <h3>所有餐點資料 - listAllFood.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/food/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/theater/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

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
		<th>餐點編號</th>
		<th>餐點名稱</th>
		<th>餐點種類</th>
		<th>場點價格</th>
		<th>餐點圖片</th>
		<th>餐點狀態</th>
	</tr>
	<%@ include file="pages/page1.file" %> 
	<c:forEach var="foodVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${foodVO.food_no}</td>
			<td>${foodVO.food_name}</td>
			<td>
				<c:choose>
					<c:when test="${foodVO.food_type == 0 }">
						熟食類
					</c:when>
					<c:when test="${foodVO.food_type == 1 }">
						飲料
					</c:when>
					<c:when test="${foodVO.food_type == 3 }">
						爆米花類
					</c:when>
				</c:choose>
			</td>
			<td>${foodVO.food_price}</td>
			<td><img src="<%=request.getContextPath()%>/food/food.do?action=getPic&food_no=${foodVO.food_no}" style="width: 150px; height: 140px;"></td>
			<td>
				${foodVO.food_status == 0 ? "下架" : "上架"}
			</td>
			
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/food/food.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="查看"> -->
<%-- 			     <input type="hidden" name="food_no"  value="${foodVO.food_no}"> --%>
<%-- 			     <input type="hidden" name="whichPage"	value="<%=whichPage%>"> --%>
<!-- 			     <input type="hidden" name="action"	value="getOne_For_Food"></FORM> -->
<!-- 			</td> -->
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/food/food.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="food_no"  value="${foodVO.food_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/food/food.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="food_no"  value="${foodVO.food_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="pages/page2.file" %>

<%-- <%if (request.getAttribute("foodVO")!=null){%> --%>
<%-- <jsp:include page="listOneFood.jsp" /> --%>
<%-- <%} %> --%>
</body>
</html>