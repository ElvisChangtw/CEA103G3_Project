<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.mem.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  MemVO memVO = (MemVO) request.getAttribute("memVO"); 
%>

<html>
<head>
<title>員工資料 - listOneEmp.jsp</title>

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
	width: 1200px;
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
  tr td img {
  	width:150px;
  	height:150px;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>員工資料 - ListOneEmp.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/mem/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
		<tr>
			<th>會員編號</th>
			<th>會員姓名</th>
			<th>會員信箱</th>
			<th>會員密碼</th>
			<th>會員生日</th>
			<th>會員照片</th>
			<th>會員電話</th>
			<th>會員地址</th>
			<th>會員狀態</th>
			<th>會員積分</th>
			<th>會員身分</th>
			<th>會員註冊日</th>
		</tr>

		<tr>
			<td>${memVO.member_no}</td>
			<td>${memVO.mb_name}</td>
			<td>${memVO.mb_email}</td>
			<td>${memVO.mb_pwd}</td>
			<td>${memVO.mb_bd}</td>
			<td><img src="${pageContext.request.contextPath}/mem/mem.do?action=view_memPic&member_no=${memVO.member_no}"></td>
			<td>${memVO.mb_phone}</td>
			<td>${memVO.mb_city}${memVO.mb_address}</td> 
			<c:choose>
				<c:when test="${memVO.status=='0'}">
				<td>審核中</td>
				</c:when>
				<c:when test="${memVO.status=='1'}">
				<td>已通過審核</td>
				</c:when>
				<c:when test="${memVO.status=='2'}">
				<td>已停權</td>
				</c:when>
				<c:when test="${memVO.status=='3'}">
				<td>已停用</td>
				</c:when>
				<c:otherwise>
				<td>無效狀態</td>
				</c:otherwise>
			</c:choose>
			<td>${memVO.mb_point}</td>
			<td>${(memVO.mb_level=="1")? "一般會員":"專職影評"}</td>
			<td>${memVO.crt_dt}</td>
		</tr>
</table>

</body>
</html>