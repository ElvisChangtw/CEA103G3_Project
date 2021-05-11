<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.topic.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	TopicVO topicVO = (TopicVO) request.getAttribute("topicVO"); //ReplServlet.java(Concroller), 存入req的TopicVO物件
%>

<html>
<head>
<title>員工資料 - listOneTopicVO.jsp</title>

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
		 <h3>員工資料 - ListOneTopic.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/topic/select_page.jsp"><img src="<%=request.getContextPath()%>/front-end/topic/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>討論主題編號</th>
		<th>討論主題</th>

	</tr>
	<tr>
		<td><%=topicVO.getTopicno()%></td>	
		<td><%=topicVO.getTopic()%></td>

	</tr>
</table>

</body>
</html>