<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.List"%>
<%@ page import="com.movie.model.*"%>
<%@ page import="com.comment.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	MovieVO movieVO = (MovieVO) request.getAttribute("movieVO"); //MovieServlet.java(Concroller), 存入req的movieVO物件
%>

<html>
<head>
<title>電影資料 - listOneMovie.jsp</title>

<style>
tr td>img{
	width:150px;
	height:150px;
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
				<h3>電影資料 - ListOneMovie.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front-end/movie/select_movie_page.jsp"><img
						src="<%=request.getContextPath()%>/images/movie_images/back1.gif" width="100" height="32" border="0">回首頁</a>
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
		</tr>
		<tr>
			<td><FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/comment/comment.do"
				style="margin-bottom: 0px;">
				<input type="submit" name="thisMovieComments" value="${movieVO.movieno}"
				style="border: none;"> <input type="hidden" name="action"
				value="getThisMovieComment">
			</FORM></td>     
			<td><%=movieVO.getMoviename()%></td>
<!-- 用老師範例註冊去顯示圖片,並且使用註冊的/movie/DBGifReader1.do? 瀏覽器只會幫你押上http://localhost:8081,要加上${pageContext.request.contextPath}代表CEA103G3才是正確路徑-->
			<td><img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=<%=movieVO.getMovieno()%>"></td> 	
<!-- 用老師範例去顯示圖片 並用web.xml註冊的DBGifReader1.do去使用,瀏覽器會自動幫你押上http://localhost:8081/CEA103G3加上web.xml註冊的/movie/DBGifReader1.do(老師建議寫明確路徑不要用)-->
<%-- 			<td><img src="DBGifReader1.do?movieno=<%=movieVO.getMovieno()%>"></td> --%>
<!-- 用MovieServlet的action=getPic寫法 (老師建議不要用 另外寫一支讀圖片的servlet比較好)-->
<%-- 			<td><img src="${pageContext.request.contextPath}/movie/movie.do?action=getPicForDisplay&movieno=<%=movieVO.getMovieno()%>"></td> --%>
			<td><%=movieVO.getDirector()%></td>
			<td><%=movieVO.getActor()%></td>
			<td><%=movieVO.getCategory()%></td>
			<td><%=movieVO.getLength()%></td>
			<td><%=movieVO.getStatus()%></td>
			<td><%=movieVO.getPremiredate()%></td>
			<td><%=movieVO.getOffdate()%></td>
			<td><%=movieVO.getTrailor()%></td>
			<td><%=movieVO.getGrade()%></td>
			<td><%=movieVO.getRating()%></td>
			<td><%=movieVO.getExpectation()%></td>
		</tr>
	</table>
<jsp:include page ="listComments_ByMovieno2.jsp"/>
</body>
</html>