<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.comment.model.*"%>
<%@ page import="java.util.List"%>
<%@ page import="com.movie.model.*"%>

<%-- <jsp:useBean id="listComments_ByMovieno" scope="request" type="java.util.Set<CommentVO>" /> <!-- 於EL此行可省略 --> --%>
<jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />
<jsp:useBean id="commentSvc" scope="page" class="com.comment.model.CommentService" />
<% 
	MovieVO movieVO = (MovieVO) request.getAttribute("movieVO");
%>


<html>
<head><title>部門員工 - listComments_ByMovieno.jsp</title>

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
<table id="table-2">
	<tr><td>
		 <h3>電影評論 - listComments_ByMovieno.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/movie/select_movie_page.jsp"><img src="<%=request.getContextPath()%>/images/movie_images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
		<th>電影</th>
		<th>評論內容</th>
		<th>建立時間</th>
		<th>修改時間</th>
		<th>評論狀態</th>
		<th>修改</th>
		<th>刪除 </th>
	</tr>
	
	
<%-- 	<c:forEach var="commentVO" items="${listComments_ByMovieno}" > --%>
	<c:forEach var="commentVO" items="${commentSvc.getOneMovieComment(movieVO.getMovieno())}" >
<%-- 		<tr ${(commentVO.commentno==param.commentno) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色--> --%>
			<td>${commentVO.commentno}</td>
			<td>${commentVO.memberno}</td>
			<td>
				<c:forEach var="movieVO" items="${movieSvc.all}">
                    <c:if test="${commentVO.movieno==movieVO.movieno}">
	                   <font color=orange>${movieVO.movieno}</font>【${movieVO.moviename}】
                    </c:if>
                </c:forEach>
            </td>
			<td>${commentVO.content}</td>
			<td><fmt:formatDate value="${commentVO.creatdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td><fmt:formatDate value="${commentVO.modifydate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<c:choose>
				<c:when test="${commentVO.status.equals('0')}">
					<td>正常發佈</td>
				</c:when>
				<c:when test="${commentVO.status.equals('1')}">
					<td>暫存評論</td>
				</c:when>
				<c:when test="${commentVO.status.equals('2')}">
					<td>已下架</td>
				</c:when>
				<c:otherwise>
					<td>無效狀態</td>
				</c:otherwise>
			</c:choose>	
					
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/comment/comment.do" style="margin-bottom: 0px;">
			    <input type="submit" value="修改"> 
			    <input type="hidden" name="commentno"      value="${commentVO.commentno}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--><!-- 目前尚未用到  -->
			    <input type="hidden" name="action"	   value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/comment/comment.do" style="margin-bottom: 0px;">
			    <input type="submit" value="刪除">
			    <input type="hidden" name="commentno"      value="${commentVO.commentno}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			    <input type="hidden" name="action"     value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>