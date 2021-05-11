<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.reply.model.*"%>

<%-- 萬用複合查詢-可由客戶端select_page.jsp隨意增減任何想查詢的欄位 --%>
<%-- 此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能--%>

<jsp:useBean id="listReplys_ByCompositeQuery" scope="request" type="java.util.List<ReplyVO>" /> <!-- 於EL此行可省略 -->
<jsp:useBean id="articleSvc" scope="page" class="com.article.model.ArticleService" />


<html>
<head><title>複合查詢 - listReplys_ByCompositeQuery.jsp</title>

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

<h4>
☆萬用複合查詢  - 可由客戶端 select_page.jsp 隨意增減任何想查詢的欄位<br>
☆此頁作為複合查詢時之結果練習，<font color=red>已增加分頁、送出修改、刪除之功能</font></h4>
<table id="table-1">
	<tr><td>
		 <h3>所有員工資料 - listAllReply.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/reply/select_page.jsp"><img src="<%=request.getContextPath()%>/front-end/reply/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>


<table>
	<tr>
		<th>回復編號</th>
		<th>文章編號</th>
		<th>會員姓名</th>
		<th>回復內容</th>
		<th>新增回復時間</th>
		<th>更新回復時間</th>
		<th>回復狀態</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="pages/page1_ByCompositeQuery.file" %>
	<c:forEach var="replyVO" items="${listReplys_ByCompositeQuery}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr align='center' valign='middle' ${(replyVO.reply_no==param.reply_no) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色而已-->
			<td>${replyVO.reply_no}</td>
			
			<td><c:forEach var="articleVO" items="${articleSvc.all}">
                    <c:if test="${replyVO.article_no==articleVO.articleno}">
	                    ${articleVO.articleno}【${articleVO.content}】
                    </c:if>
                </c:forEach>
			</td>
			<td>${replyVO.member_no}</td>
			<td>${replyVO.content}</td>
			<td>${replyVO.crt_dt}</td>
			<td>${replyVO.modify_dt}</td>	
			<td>${replyVO.status}</td>		

			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reply/reply.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改"> 
			     <input type="hidden" name="reply_no"    value="${replyVO.reply_no}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action"	    value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reply/reply.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="reply_no"      value="${replyVO.reply_no}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action"     value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="pages/page2_ByCompositeQuery.file" %>

<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>