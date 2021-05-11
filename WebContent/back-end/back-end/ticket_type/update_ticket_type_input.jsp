<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ticket_type.model.*"%>

<%
	Ticket_typeVO ticket_typeVO = (Ticket_typeVO) request.getAttribute("ticket_typeVO");
%>

<%= ticket_typeVO==null %>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>場次資料修改 - update_ticket_type_input.jsp</title>

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
		 <h3>場次資料修改 - update_ticket_type_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/ticket_type/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/theater/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ticket_type/ticket_type.do" name="form1">
<table>
	<tr>
		<td>票種編號:<font color=red><b>*</b></font></td>
		<td>${ticket_typeVO.ticket_type_no}</td>
	</tr>
	<tr>
		<td>票種</td>
		<td>
			<select name="ticket_type">
				<option value="0" ${(ticket_typeVO.ticket_type==0) ? "selected" : ""} >2D</option>
				<option value="1" ${(ticket_typeVO.ticket_type==1) ? "selected" : ""} >3D</option>
				<option value="2" ${(ticket_typeVO.ticket_type==2) ? "selected" : ""} >IMAX</option>
				<option value="3" ${(ticket_typeVO.ticket_type==3) ? "selected" : ""} >2D_IMAX</option>
				<option value="4" ${(ticket_typeVO.ticket_type==4) ? "selected" : ""} >3D_IMAX</option>
				<option value="5" ${(ticket_typeVO.ticket_type==5) ? "selected" : ""} >數位</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>票價:</td>
		<td>
			<input type="text" name="ticket_price" value="${(ticket_typeVO==null) ? '280' : ticket_typeVO.ticket_price}">
		</td>
	</tr>
	<tr>
		<td>票種說明</td>
		<td>
			<input type="text" name="ticket_desc" value="${(ticket_typeVO==null) ? '全票' : ticket_typeVO.ticket_desc}">
		</td>
	</tr>

</table>
<br>


<input type="hidden" name="action" value="update">
<input type="hidden" name="ticket_type_no" value="${ticket_typeVO.ticket_type_no}">
<input type="submit" id="submit" value="送出修改"></FORM>

</body>
</html>