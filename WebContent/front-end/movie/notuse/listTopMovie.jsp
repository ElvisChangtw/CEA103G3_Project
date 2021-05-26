<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.movie.model.*"%>
<%@ page import="com.comment.model.*"%>
<%
	MovieService movieSvc = new MovieService();
	List<MovieVO> list = movieSvc.getTopTen();
	pageContext.setAttribute("listTopTen", list);
%>
<!DOCTYPE html>
<html>
<head>
<title>List Top Movies</title>
<!-- <!-- for-mobile-apps -->
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!-- <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> -->
<!-- <meta name="keywords" content="Movies Pro Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template,  -->
<!-- Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" /> -->
<!-- <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); -->
<!-- 		function hideURLbar(){ window.scrollTo(0,1); } </script> -->
<!-- <!-- //for-mobile-apps --> -->
<!-- <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" /> -->
<!-- <!-- pop-up --> -->
<!-- <link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all" /> -->
<!-- <!-- //pop-up --> -->
<!-- <link href="css/easy-responsive-tabs.css" rel='stylesheet' type='text/css'/> -->
<!-- <link rel="stylesheet" type="text/css" href="css/zoomslider.css" /> -->
<!-- <link rel="stylesheet" type="text/css" href="css/style.css" /> -->
<!-- <link href="css/font-awesome.css" rel="stylesheet">  -->
<!-- <script type="text/javascript" src="js/modernizr-2.6.2.min.js"></script> -->
<!-- <!--/web-fonts--> -->
<!-- <link href='//fonts.googleapis.com/css?family=Tangerine:400,700' rel='stylesheet' type='text/css'> -->
<!-- <link href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900" rel="stylesheet"> -->
<!-- <link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'> -->
<!-- <!--//web-fonts--> -->

<style>
div>div>div>div>a>img{
width:10px;
height:10px;
}

tr td a>img {
	width: 150px;
	height: 150px;
}

tr td h4 a>img {
	width: 100px;
	height: 32px;
}

table#table-1 {
	background-color: orange;
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
	height: 200px;
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
	/* 	word-wrap: break-word; */
	/*    	table-layout: fixed; */
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
		<tr>
			<td>
				<h3>所有電影資料 - listAllMovie.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/index.jsp"><img
						src="<%=request.getContextPath()%>/images/movie_images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

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
			<th>刪除<font color=red>(關聯測試與交易-小心)</font></th>
			<th>查詢電影評論</th>
		</tr>
		<%@ include file="pages/page1.file"%>
		<c:forEach var="movieVO" items="${listTopTen}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
			<tr ${(movieVO.movieno==param.movieno) ? 'bgcolor=#CCCCFF':''}>
<!-- 				<td><FORM METHOD="post" -->
<%-- 						ACTION="<%=request.getContextPath()%>/comment/comment.do" --%>
<!-- 						style="margin-bottom: 0px;"> -->
<!-- 						<input type="submit" name="thisMovieComments" -->
<%-- 							value="${movieVO.movieno}" style="border: none;"> <input --%>
<!-- 							type="hidden" name="action" value="getThisMovieComment"> -->
<!-- 					</FORM></td> -->
				<td>${movieVO.movieno}</td>
				<td>${movieVO.moviename}</td>
				<!-- 用老師範例註冊去顯示圖片,並且使用註冊的/movie/DBGifReader1.do? 瀏覽器只會幫你押上http://localhost:8081,要加上${pageContext.request.contextPath}代表CEA103G3才是正確路徑-->
				<td><a href="${movieVO.trailor}"> <img
						src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}"></a></td>
				<!-- 用MovieServlet的action=getPic寫法 (老師建議不要用 另外寫一支讀圖片的servlet比較好)-->
				<%-- 							<td><img src="${pageContext.request.contextPath}/movie/movie.do?action=getPicForDisplay&movieno=${movieVO.movieno}"></td>				 --%>
				<td>${movieVO.director}</td>
				<td>${movieVO.actor}</td>
				<td>${movieVO.category}</td>
				<c:choose>
					<c:when test="${((movieVO.length)/60)<1}">
						<td>${movieVO.length}分鐘</td>
					</c:when>
					<c:when test="${(((movieVO.length)/60)%1)==0}">
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
						<input type="submit" value="修改"> <input type="hidden"
							name="movieno" value="${movieVO.movieno}"> <input
							type="hidden" name="requestURL"
							value="<%=request.getServletPath()%>">
						<!--送出本網頁的路徑給Controller-->
						<input type="hidden" name="whichPage" value="<%=whichPage%>">
						<!--送出當前是第幾頁給Controller-->
						<input type="hidden" name="action" value="getOne_For_Update">


						<input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
					
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/movie/movie.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除"> <input type="hidden"
							name="movieno" value="${movieVO.movieno}"> <input
							type="hidden" name="requestURL"
							value="<%=request.getServletPath()%>">
						<!--送出本網頁的路徑給Controller-->
						<input type="hidden" name="whichPage" value="<%=whichPage%>">
						<!--送出當前是第幾頁給Controller-->
						<input type="hidden" name="action" value="delete">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/movie/movie.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="送出查詢"> <input type="hidden"
							name="movieno" value="${movieVO.movieno}"> <input
							type="hidden" name="requestURL"
							value="<%=request.getServletPath()%>">
						<!--送出本網頁的路徑給Controller-->
						<input type="hidden" name="whichPage" value="<%=whichPage%>">
						<!--送出當前是第幾頁給Controller-->
						<input type="hidden" name="action"
							value="listComments_ByMovieno_B">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="pages/page2.file"%>
	<%
		if (request.getAttribute("listComments_ByMovieno") != null) {
	%>
<%-- 	<jsp:include page="listComments_ByMovieno.jsp" /> --%>
	<%
		}
	%>


</body>
</html>