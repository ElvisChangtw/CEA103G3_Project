<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.comment.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	CommentDAO dao = new CommentDAO();
    List<CommentVO> list = dao.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有評論資料 - listAllComment1_byDAO.jsp</title>

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
		 <h3>所有評論資料 - listAllComment1_byDAO.jsp</h3>
		 <h4><a href="select_comment_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0"></a></h4>
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
		<th>評論編號</th>
		<th>會員編號</th>
		<th>電影編號</th>
		<th>評論內容</th>
		<th>建立時間</th>
		<th>修改時間</th>
		<th>評論狀態</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="commentVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr>
			<td>${commentVO.commentno}</td>
			<td>${commentVO.memberno}</td>
			<td>${commentVO.movieno}</td>
			<td>${commentVO.content}</td>
			<td>${commentVO.creatdate}</td>
			<td>${commentVO.modifydate}</td>
			<td>${commentVO.status}</td>
		</tr>
	</c:forEach>
</table>

<%@ include file="page2.file" %>
</body>
</html>