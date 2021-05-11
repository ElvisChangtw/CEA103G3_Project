<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%-- <%@ page import="com.article.model.*"%> --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	//ArticleVO articleVO = (ArticleVO) request.getAttribute("articleVO"); //ArticleServlet.java(Concroller), 存入req的ArticleVO物件
%>

<html>
<head>
<title>員工資料 - listOneArticle.jsp</title>

<style>
  table#table-2 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-2 h4 {
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
	width: 100%;
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
<table id="table-2">
	<tr><td>
		 <h3>員工資料 - ListOneArticle.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/article/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>文章編號</th>
		<th>會員姓名</th>
		<th>文章類型</th>
		<th>文章內容</th>
		<th>文章標題</th>
		<th>新增文章時間</th>
		<th>更新文章時間</th>
		<th>文章狀態</th>
		<th>點讚數</th>
	</tr>
	<tr>
<%-- 		<td><%=articleVO.getArticleno()%></td>	 --%>
<%-- 		<td><%=articleVO.getMemberno()%></td> --%>
<%-- 		<td><%=articleVO.getArticletype()%></td> --%>
<%-- 		<td><%=articleVO.getContent()%></td> --%>
<%-- 		<td><%=articleVO.getArticleheadline()%></td> --%>
		<td>${articleVO.articleno}</td>	
		<td>${articleVO.memberno}</td>
		<td>${articleVO.articletype}</td>
		<td>${articleVO.content}</td>
		<td>${articleVO.articleheadline}</td>
<%-- 		<td><%=articleVO.getCrtdt()%></td> --%>
		<td><fmt:formatDate value="${articleVO.crtdt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
<%-- 		<td><%=articleVO.getUpdatedt()%></td> --%>
		<td><fmt:formatDate value="${articleVO.updatedt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		<td>${articleVO.status}</td>	
		<td>${articleVO.likecount}</td>	
		
<%-- 		<td><%=articleVO.getStatus()%></td> --%>
<%-- 		<td><%=articleVO.getLikecount()%></td> --%>
		
	</tr>
</table>

</body>
</html>