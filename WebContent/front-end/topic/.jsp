<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.topic.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
// 	TopicService TopicSvc = new TopicService();
//  List<TopicVO> list = TopicSvc.getAll();
//  pageContext.setAttribute("list",list);
%>
<jsp:useBean id="topicSvc" scope="page" class="com.topic.model.TopicService" />

<html>
<head>
<title>所有員工資料 - listAllTopic.jsp</title>

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
	width: 1300px;
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
		 <h3>所有員工資料 - listAllTopic.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
		<th>討論主題編號</th>
		<th>討論主題</th>		
		<th>修改</th>	
		<th>刪除</th>	
		
	</tr>
	<c:forEach var="topicVO" items="${topicSvc.all}">
		
		<tr>
			<td>${topicVO.topicno}</td>
			<td>${topicVO.topic}</td>

			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/topic/topic.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="topicno"  value="${topicVO.topicno}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/topic/topic.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="topicno"  value="${topicVO.topicno}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/topic/topic.do" style="margin-bottom: 0px;">
			    <input type="submit" value="送出查詢"> 
			    <input type="hidden" name="topicno" value="${topicVO.topicno}">
			    <input type="hidden" name="action" value="listArticles_ByTopicno_B"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>