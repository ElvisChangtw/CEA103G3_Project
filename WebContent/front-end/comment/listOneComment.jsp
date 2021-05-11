<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.comment.model.*"%>
<%@ page import="com.movie.model.*"%>

<%-- 取出 Concroller CommentServlet.java已存入request的CommentVO物件--%>
<%CommentVO commentVO = (CommentVO) request.getAttribute("commentVO");%>

<%-- 取出 對應的MovieVO物件--%>
<%
  MovieService movieSvc = new MovieService();
  MovieVO movieVO = movieSvc.getOneMovie(commentVO.getMovieno());
  request.setAttribute("movieVO", movieVO);
%>

<html>
<head>
<title>評論資料 - listOneComment.jsp</title>

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
	width: 600px;
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
		<tr>
			<td>
				<h3>評論資料 - ListOneComment.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front-end/comment/select_comment_page.jsp"><img
						src="<%=request.getContextPath()%>/images/comment_images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
						<a
						href="<%=request.getContextPath()%>/front-end/movie/select_movie_page.jsp"><img
						src="<%=request.getContextPath()%>/images/movie_images/movie.jpg"
						width="80" height="80" border="0">回電影首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>評論編號</th>
			<th>會員編號</th>
			<th>電影</th>
			<th>評論內容</th>
			<th>建立時間</th>
			<th>修改時間</th>
			<th>評論狀態</th>
		</tr>
			<tr>
				<td>${commentVO.commentno}</td>
				<td>${commentVO.memberno}</td>
				<td>${commentVO.movieno}【${movieVO.moviename}】</td>
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
			</tr>
	</table>

</body>
</html>