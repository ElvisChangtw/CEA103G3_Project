<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.report_article.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	Report_ArticleVO report_articleVO = (Report_ArticleVO) request.getAttribute("report_articleVO"); //ArticleServlet.java(Concroller), 存入req的ArticleVO物件
%>

<html>
<head>
<title>員工資料 - listOneReport_ArticleVO.jsp</title>

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
	width: 1000px;
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

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>員工資料 - ListOneReport_Article.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/report_article/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/report_article/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>檢舉編號</th>
		<th>文章編號</th>
		<th>檢舉內容</th>
		<th>新增檢舉時間</th>
		<th>會員編號</th>
		<th>更新檢舉時間</th>
		<th>檢舉狀態</th>
		<th>備註</th>
	</tr>
	<tr>
		<td><%=report_articleVO.getReportno()%></td>
		<td><%=report_articleVO.getArticleno()%></td>
		<td><%=report_articleVO.getContent()%></td>	
		<td><fmt:formatDate value="${report_articleVO.crtdt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>		
		<td><%=report_articleVO.getMemberno()%></td>
		<td><fmt:formatDate value="${report_articleVO.executedt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>		
		<td><%=report_articleVO.getStatus()%></td>
		<td><%=report_articleVO.getDesc()%></td>

	</tr>
</table>

</body>
</html>