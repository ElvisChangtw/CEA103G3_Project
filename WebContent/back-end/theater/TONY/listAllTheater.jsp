<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.theater.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    TheaterService theaterSvc = new TheaterService();
    List<TheaterVO> list = theaterSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<html>
<head>
<title>所有廳院資料 - listAllTheater.jsp</title>

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
	width: 700px;
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
		 <h3>所有廳院資料 - listAllTheater.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/theater/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/theater/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
		<th>廳院編號</th>
		<th>廳院名稱</th>
		<th>廳院種類</th>
		<th>廳院配置</th>
<!-- 		<th>座位名稱</th> -->
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="theaterVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${theaterVO.theater_no}</td>
			<td>${theaterVO.theater_name}</td>
			<td>
				<c:choose>
					<c:when test="${theaterVO.theater_type == 0 }">
					2D
					</c:when>
					<c:when test="${theaterVO.theater_type == 1 }">
					3D
					</c:when>
					<c:when test="${theaterVO.theater_type == 2 }">
					IMAX
					</c:when>
					<c:when test="${theaterVO.theater_type == 3 }">
					2D_IMAX
					</c:when>
					<c:when test="${theaterVO.theater_type == 4 }">
					3D_IMAX
					</c:when>
<%-- 					<c:when test="${theaterVO.theater_type == 5 }"> --%>
<%-- 					</c:when> --%>
				</c:choose>
			</td>
<!-- 			<td>查看</td> -->
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/theater/theater.do" style="margin-bottom: 0px;">
			     <input type="submit" value="查看">
			     <input type="hidden" name="theater_no"  value="${theaterVO.theater_no}">
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">
			     <input type="hidden" name="action"	value="getOne_For_Theater"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/theater/theater.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="theater_no"  value="${theaterVO.theater_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/theater/theater.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="theater_no"  value="${theaterVO.theater_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

<%if (request.getAttribute("theaterVO")!=null){%>
<jsp:include page="listOneTheater.jsp" />
<%} %>
</body>
</html>