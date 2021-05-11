<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.report_comment.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	ReportCommentDAO dao = new ReportCommentDAO();
    List<ReportCommentVO> list = dao.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有檢舉評論資料 - listAllReportComment1_byDAO.jsp</title>

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
		 <h3>所有檢舉評論資料 - listAllReportComment1_byDAO.jsp</h3>
		 <h4><a href="select_report_comment_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0"></a></h4>
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
		<th>檢舉編號</th>
		<th>評論編號</th>
		<th>檢舉內容</th>
		<th>檢舉日期</th>
		<th>會員編號</th>
		<th>處理日期</th>
		<th>檢舉狀態</th>
		<th>備註</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="reportcommentVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr>
			<td>${reportcommentVO.reportno}</td>
			<td>${reportcommentVO.commentno}</td>
			<td>${reportcommentVO.content}</td>
			<td>${reportcommentVO.creatdate}</td>
			<td>${reportcommentVO.memberno}</td>
			<td>${reportcommentVO.executedate}</td>
			<td>${reportcommentVO.status}</td>
			<td>${reportcommentVO.desc}</td>
		</tr>
	</c:forEach>
</table>

<%@ include file="page2.file" %>
</body>
</html>