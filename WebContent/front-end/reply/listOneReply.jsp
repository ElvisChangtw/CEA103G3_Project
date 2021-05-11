<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.reply.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	ReplyVO replyVO = (ReplyVO) request.getAttribute("replyVO"); //ReplServlet.java(Concroller), 存入req的ReplyVO物件 -->
%> 

<%-- <%  --%>
<!-- // 	Integer reply_no = new Integer(request.getParameter("reply_no"));  -->
<!-- // 	ReplyService replySvc = new ReplyService(); -->
<!-- // 	ReplyVO replyVO = replySvc.getOneReply(reply_no); -->
<%-- %> --%>

<html>
<head>
<title>員工資料 - listOneArticle.jsp</title>

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
		 <h3>員工資料 - ListOneArticle.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/reply/select_page.jsp"><img src="<%=request.getContextPath()%>/front-end/reply/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>回復編號</th>
		<th>文章編號</th>
		<th>會員編號</th>
		<th>回復內容</th>
		<th>新增回復時間</th>
		<th>更新回復時間</th>
		<th>回復狀態</th>
	</tr>
	<tr>
		<td><%=replyVO.getReply_no()%></td>	
		<td><%=replyVO.getArticle_no()%></td>
		<td><%=replyVO.getMember_no()%></td>
		<td><%=replyVO.getContent()%></td>
		<td><fmt:formatDate value="${replyVO.crt_dt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		<td><fmt:formatDate value="${replyVO.modify_dt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		<td><%=replyVO.getStatus()%></td>
	</tr>
</table>

</body>
</html>