<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.movie.model.*"%>
<%@ page import="com.comment.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	MovieService movieSvc1 = new MovieService();
	List<MovieVO> list = movieSvc1.getAll();
	pageContext.setAttribute("list", list);
%>
<%-- <jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" /> --%>

<html>
<head>
<title>後台 瀏覽所有電影</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Movies Pro Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- //for-mobile-apps -->
<link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<!-- pop-up -->
<link href="<%=request.getContextPath()%>/css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
<!-- //pop-up -->
<link href="<%=request.getContextPath()%>/css/easy-responsive-tabs.css" rel='stylesheet' type='text/css'/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/zoomslider.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/table-style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/basictable.css" />
<!-- list-css -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/list.css" type="text/css" media="all" />
<!-- //list-css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
<link href="<%=request.getContextPath()%>/css/font-awesome.css" rel="stylesheet"> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/modernizr-2.6.2.min.js"></script>
<!--/web-fonts-->
<link href='//fonts.googleapis.com/css?family=Tangerine:400,700' rel='stylesheet' type='text/css'>
<link href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900" rel="stylesheet">
<link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
<!--//web-fonts-->
<script src="https://unpkg.com/ionicons@5.4.0/dist/ionicons.js"></script>	
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>

</head>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<!--/content-inner-section-->
		<div class="w3_content_agilleinfo_inner">
				<div class="agile_featured_movies">
				<div class="inner-agile-w3l-part-head">
			            <h3 class="w3l-inner-h-title">後台瀏覽所有電影</h3>
					</div>
		            <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
				<div id="myTabContent" class="tab-content">
					<div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
						<div class="agile-news-table">
						<%@ include file="pages/page1.file"%>
<!-- 									<table id="table-breakpoint"> -->
								<table>
								<thead  align="center">
								  <tr>
									<th align="center">照片1</th>
									<th align="center">照片2</th>
									<th align="center">導演</th>
									<th align="center">演員</th>
									<th align="center">類型</th>
									<th align="center">長度</th>
									<th align="center">狀態</th>
									<th align="center">上映/下映</th>
									<th align="center">分級</th>
									<th align="center">預告片</th>
									<th align="center">修改</th>
									<th align="center">刪除</th>
								  </tr>
								</thead>
								<tbody>
								<c:forEach var="movieVO" items="${list}" begin="<%=pageIndex%>"
									end="<%=pageIndex+rowsPerPage-1%>">

								  <tr>
									<td>
										<a href="${pageContext.request.contextPath}/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}">
										<img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}" 
										alt="尚無圖片" width="100px;" height="120px" title="${movieVO.moviename}"/> 
										<span  style="text-align: center; display:block; font-size:10px; font-weight:bold;">${movieVO.moviename}</span></a></td>
									<td>
										<a href="${pageContext.request.contextPath}/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}">
										<img src="${pageContext.request.contextPath}/movie/DBGifReader2.do?movieno=${movieVO.movieno}" 
										alt="尚無圖片" width="100px;" height="120px" title="${movieVO.moviename}"/></a></td>
									
									<td width="50px;">${movieVO.director}</td>
									<td width="50px;">${movieVO.actor}</td>
									<td width="80px;">${movieVO.category}</td>
									
									<c:choose>
										<c:when test="${movieVO.length >0}">
											<td width="80px;">${movieVO.length}分鐘</td>
										</c:when>
										<c:otherwise>
											<td width="80px;">無效時間</td>
										</c:otherwise>
									</c:choose>
									
									<c:choose>
										<c:when test="${movieVO.status.equals('0')}">
											<td width="70px;">上映中</td>
										</c:when>
										<c:when test="${movieVO.status.equals('1')}">
											<td width="70px;">未上映</td>
										</c:when>
										<c:when test="${movieVO.status.equals('2')}">
											<td width="70px;">已下檔</td>
										</c:when>
										<c:otherwise>
											<td width="70px;">無效狀態</td>
										</c:otherwise>
									</c:choose>
									
									<td width="105px;">
										<fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /><br>
										<fmt:formatDate value="${movieVO.offdate}" pattern="yyyy-MM-dd" />
									</td>
									
									<c:choose>
										<c:when test="${movieVO.grade.equals('0')}">
											<td width="70px;">普遍級</td>
										</c:when>
										<c:when test="${movieVO.grade.equals('1')}">
											<td width="70px;">保護級</td>
										</c:when>
										<c:when test="${movieVO.grade.equals('2')}">
											<td width="70px;">輔導級</td>
										</c:when>
										<c:when test="${movieVO.grade.equals('3')}">
											<td width="70px;">限制級</td>
										</c:when>
										<c:otherwise>
											<td width="70px;">尚未分級</td>
										</c:otherwise>
									</c:choose>
										
									<td width="50px;"><a class="w3_play_icon1" href="${movieVO.trailor}">觀看</a></td>
									
									<td width="50px;">
										<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" style="margin-bottom: 0px;">
											<input type="submit" value="修改"> 
											<input type="hidden" name="movieno" value="${movieVO.movieno}"> 
											<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
											<!--送出本網頁的路徑給Controller-->
											<input type="hidden" name="whichPage" value="<%=whichPage%>">
											<!--送出當前是第幾頁給Controller-->
											<input type="hidden" name="action" value="getOne_For_Update">
										</FORM>
									</td>
									
									<td width="50px;">
										<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" style="margin-bottom: 0px;">
											<input type="submit" value="刪除"> 
											<input type="hidden" name="movieno" value="${movieVO.movieno}"> 
											<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
											<!--送出本網頁的路徑給Controller-->
											<input type="hidden" name="whichPage" value="<%=whichPage%>">
											<!--送出當前是第幾頁給Controller-->
											<input type="hidden" name="action" value="delete">
										</FORM>
									</td>
								</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="blog-pagenat-wthree">
					<ul>
					<%@ include file="pages/page2.file"%>
					</ul>
				</div>	
			</div>
		</div>
	</div>
</div>
<!--//content-inner-section-->


</body>
</html>