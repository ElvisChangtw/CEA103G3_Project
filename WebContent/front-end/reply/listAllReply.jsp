<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.reply.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	ReplyService replySvc = new ReplyService();
    List<ReplyVO> list = replySvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有回覆資料 - listAllReply.jsp</title>

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
		 <h3>所有回覆 - listAllReply.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/reply/select_page.jsp"><img src="<%=request.getContextPath()%>/front-end/reply/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
		<th>回復編號</th>
		<th>文章編號</th>
		<th>會員編號</th>		
		<th>回復內容</th>
		<th>新增回復時間</th>
		<th>更新回復時間</th>
		<th>回復狀態</th>
		<th>修改</th>
		<th>刪除</th>

	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="replyVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">		
		<tr>			
			<td>${replyVO.reply_no}</td>
			<td>${replyVO.article_no}</td>
			<td>${replyVO.member_no}</td>
			<td>${replyVO.content}</td>				
			<td><fmt:formatDate value="${replyVO.crt_dt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td><fmt:formatDate value="${replyVO.modify_dt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td>${replyVO.status}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reply/reply.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="reply_no"  value="${replyVO.reply_no}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reply/reply.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="reply_no"  value="${replyVO.reply_no}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>			
		</tr>
		
	</c:forEach>
</table>
<%@ include file="page2.file" %>

<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>


</body>
</html>