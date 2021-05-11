<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ord_ticket_type.model.*"%>
<%@ page import="com.ticket_type.model.*"%>
<%@ page import="com.ticket_type.model.*"%>
<%@ page import="java.util.*"%>

<%
  Ord_ticket_typeVO ord_ticket_typeVO = (Ord_ticket_typeVO) request.getAttribute("ord_ticket_typeVO");
  Ord_ticket_typeService ord_ticket_typeSvc = new Ord_ticket_typeService();
  List<Ord_ticket_typeVO> list = ord_ticket_typeSvc.getAll();
  pageContext.setAttribute("list", list);
%>
<%= ord_ticket_typeVO==null %>

<jsp:useBean id="ticket_typeSvc" scope="page" class="com.ticket_type.model.Ticket_typeService" />

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>訂單票種資料新增 - addOrd_ticket_type.jsp</title>

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
		 <h3>訂單票種資料新增 - addOrd_ticket_type.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/ord_ticket_type/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/theater/images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ord_ticket_type/ord_ticket_type.do" name="form1">
		<c:forEach var="ticket_typeVO" items = "${ticket_typeSvc.all}">
			<div>
<%-- 				<p>${ticket_typeVO.ticket_desc}</p> --%>
<%-- 				<p>$ ${ticket_typeVO.ticket_price}</p> --%>
<!-- 				<select name="ticket_count"> -->
<!-- 					<option value="0">0</option> -->
<!-- 					<option value="1">1</option> -->
<!-- 					<option value="2">2</option> -->
<!-- 					<option value="3">3</option> -->
<!-- 					<option value="4">4</option> -->
<!-- 					<option value="5">5</option> -->
<!-- 				</select> -->
				
				<input type="hidden" name="ticket_type_no"  value="${ticket_typeVO.ticket_type_no}">
				<input type="hidden" name="ticket_price"  value="${ticket_typeVO.ticket_price}">
			</div>
		</c:forEach>
<br>
<input type="hidden" name="action" value="insert2">
<input type="submit" value="送出新增">
</FORM>

</body>
</html>