<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ord_food.model.*"%>

<html>
<head>
<title>IBM Ord_food: Home</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>IBM Ord_food: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Ord_food: Home</p>

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='<%=request.getContextPath()%>/back-end/ord_food/listAllOrd_food.jsp'>List</a> all Ord_foods.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ord_food/ord_food.do" >
        <b>輸入訂單編號 (如1):</b>
        <input type="text" name="order_no">
        <br>
        <b>輸入餐點編號 (如1):</b>
        <input type="text" name="food_no">
        <br>
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

	<jsp:useBean id="ord_foodSvc" scope="page" class="com.ord_food.model.Ord_foodService" />

  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ord_food/ord_food.do" >
       <b>選擇訂單編號:</b>
       <select size="1" name="order_no">
         <c:forEach var="ord_foodVO" items="${ord_foodSvc.all}" > 
          <option value="${ord_foodVO.order_no}">${ord_foodVO.order_no}
         </c:forEach>   
       </select>
       <br>
       <b>選擇票種編號:</b>
       <select size="1" name="food_no">
         <c:forEach var="ord_foodVO" items="${ord_foodSvc.all}" >
          <option value="${ord_foodVO.food_no}">${ord_foodVO.food_no}
         </c:forEach>   
       </select>
       <br>
       
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
    
  </li>
  
</ul>


<h3>票種管理</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/back-end/ord_food/addOrd_food.jsp'>Add</a> a new Ord_food.</li>
  <li><a href='<%=request.getContextPath()%>/back-end/ord_food/addOrd_food2.jsp'>Add</a> a new Ord_food2.</li>
</ul>

</body>
</html>