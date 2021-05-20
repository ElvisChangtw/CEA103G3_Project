<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.movie.model.*"%>

<%-- 萬用複合查詢-可由客戶端select_page.jsp隨意增減任何想查詢的欄位 --%>
<%-- 此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能--%>

<jsp:useBean id="listMovies_ByCompositeQuery" scope="request"
	type="java.util.List<MovieVO>" />
<!-- 於EL此行可省略 -->
<%-- <jsp:useBean id="RatingSvc" scope="page" class="com.rating.model.RatingService" /> --%>


<html>
<head>
<title>複合查詢 - listMovies_ByCompositeQuery.jsp</title>

<style>
tr td a>img {
	width: 150px;
	height: 150px;
}

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
		☆萬用複合查詢 - 可由客戶端 select_movie_page.jsp 隨意增減任何想查詢的欄位<br>
		☆此頁作為複合查詢時之結果練習，<font color=red>已增加分頁、送出修改、刪除之功能</font>
	</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有員工資料 - listAllMovie.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front-end/movie/select_movie_page.jsp">
						<img
						src="<%=request.getContextPath()%>/images/movie_images/back1.gif"
						width="100" height="32" border="0">回首頁
					</a>
				</h4>
			</td>
		</tr>
	</table>


	<table>
		<tr>
			<th>電影編號</th>
			<th>電影名稱</th>
			<th>電影照片</th>
			<th>導演</th>
			<th>演員</th>
			<th>電影類型</th>
			<th>電影長度</th>
			<th>電影狀態</th>
			<th>上映日期</th>
			<th>下檔日期</th>
			<th>預告片</th>
			<th>電影分級</th>
			<th>評分</th>
			<th>期待度</th>
			<th>修改</th>
			<th>刪除</th>
		</tr>
		<%@ include file="pages/page1_ByCompositeQuery.file"%>
		<c:forEach var="movieVO" items="${listMovies_ByCompositeQuery}"
			begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
			<tr align='center' valign='middle'
				${(movieVO.movieno==param.movieno) ? 'bgcolor=#CCCCFF':''}>
				<!--將修改的那一筆加入對比色而已-->
				<td><FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/comment/comment.do"
						style="margin-bottom: 0px;">
						<input type="submit" name="thisMovieComments"
							value="${movieVO.movieno}" style="border: none;"> <input
							type="hidden" name="action" value="getThisMovieComment">
				</FORM></td>
				<td>${movieVO.moviename}</td>
				<td><a href="${movieVO.trailor}">
				<img
						src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}">
				</a></td>
				<td>${movieVO.director}</td>
				<td>${movieVO.actor}</td>
				<td>${movieVO.category}</td>
				<c:choose>
					<c:when test="${((movieVO.length)/60)<1}">
						<td>${movieVO.length}分鐘</td>
					</c:when>
					<c:when test="${((movieVO.length)/60)==1}">
						<td><fmt:formatNumber type="number"
								value="${((movieVO.length)-(movieVO.length%60))/60}" />小時</td>
					</c:when>
					<c:when test="${((movieVO.length)/60)>1}">
						<td><fmt:formatNumber type="number"
								value="${((movieVO.length)-(movieVO.length%60))/60}" />小時<fmt:formatNumber
								type="number" value="${movieVO.length%60}" />分鐘</td>
					</c:when>
					<c:otherwise>
						<td>無效時間</td>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${movieVO.status.equals('0')}">
						<td>上映中</td>
					</c:when>
					<c:when test="${movieVO.status.equals('1')}">
						<td>未上映</td>
					</c:when>
					<c:when test="${movieVO.status.equals('2')}">
						<td>已下檔</td>
					</c:when>
					<c:otherwise>
						<td>無效狀態</td>
					</c:otherwise>
				</c:choose>
				<td><fmt:formatDate value="${movieVO.premiredate}"
						pattern="yyyy-MM-dd" /></td>
				<td><fmt:formatDate value="${movieVO.offdate}"
						pattern="yyyy-MM-dd" /></td>
				<td><a href="${movieVO.trailor}">${movieVO.moviename}</a></td>
				<c:choose>
					<c:when test="${movieVO.grade.equals('0')}">
						<td>普遍級</td>
					</c:when>
					<c:when test="${movieVO.grade.equals('1')}">
						<td>保護級</td>
					</c:when>
					<c:when test="${movieVO.grade.equals('2')}">
						<td>輔導級</td>
					</c:when>
					<c:when test="${movieVO.grade.equals('3')}">
						<td>限制級</td>
					</c:when>
					<c:otherwise>
						<td>尚未分級</td>
					</c:otherwise>
				</c:choose>
				<td>${movieVO.rating}</td>
				<td>${movieVO.expectation}</td>
			<td>
			  <FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/movie/movie.do"
						style="margin-bottom: 0px;">
			     <input type="submit" value="修改"> 
			     <input type="hidden" name="movieno" value="${movieVO.movieno}">
			     <input type="hidden" name="requestURL"
							value="<%=request.getServletPath()%>">
						<!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage" value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
			</td>
			<td>
			  <FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/movie/movie.do"
						style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="movieno" value="${movieVO.movieno}">
			     <input type="hidden" name="requestURL"
							value="<%=request.getServletPath()%>">
						<!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage" value="<%=whichPage%>">  <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action" value="delete">
					</FORM>
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