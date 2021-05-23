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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/table-style-back.css" />
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

<style>

</style>
</head>
<body>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
<nav class="navbar navbar-light" style="background-color: #75D9B5;">
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" name="form1" class="form-inline my-2 my-lg-0 composite-query">
		<br><div class="form-row">
			搜尋電影:&ensp;
			<div class="form-group col-2">
				 <input type="text" name="MOVIE_NAME" value="" class="form-control" placeholder="請輸入電影" size="10"><br>
			</div>&ensp;
			
			<div class="form-group col-2">
				<input type="text" name="DIRECTOR" value="" class="form-control" placeholder="請輸入導演" size="10"><br>
			</div>&ensp;
	       
	       <div class="form-group col-2">
				<input type="text" name="ACTOR" value="" class="form-control" placeholder="請輸入演員" size="10"><br>
			</div>&ensp;
	      
			<div class="form-group col-2">
	       <select  name="category" class="form-control form-control-sm">
				<option value="">請選擇電影類型</option>
				<option value="動作片">動作片</option>
				<option value="冒險片">冒險片</option>
				<option value="科幻片">科幻片</option>
				<option value="犯罪片">犯罪片</option>
				<option value="警匪片">警匪片</option>
				<option value="喜劇片">喜劇片</option>
				<option value="劇情片">劇情片</option>
				<option value="愛情片">愛情片</option>
	       	</select><br>
	       	</div>&ensp;
	       	
	       	<div class="form-group col-2">
	       	<select size="1" name="STATUS" class="form-control form-control-sm">
				<option value="">請選擇電影狀態</option>
				<option value="0">上映中</option>
				<option value="1">未上映</option>
				<option value="2">已下檔</option>
      		</select><br>
    		</div>&ensp;
    		
    		<div class="form-group col-2">
				<input type="text" name="PREMIERE_DT" id="f_date1" class="form-control" placeholder="請輸入上映日期" size="12">&ensp;
 		       <input type="text" name="OFF_DT" id="f_date2" class="form-control" placeholder="請輸入下映日期" size="12"><br> 
			</div>&ensp;
	       	
       		<div class="form-group col-2">
       		<select size="1" name="GRADE" class="form-control form-control-sm">
				<option value="">請選擇電影分級</option>
				<option value="0">普遍級</option>
				<option value="1">保護級</option>
				<option value="2">輔導級</option>
				<option value="3">限制級</option>
       		</select><br>
			</div>&ensp;
       		
<!--        		<div class="form-group col-2"> -->
<!--        		<select size="1" name="RATING" class="form-control form-control-sm"> -->
<!-- 				<option value="">評分不低於</option> -->
<!-- 				<option value="1">1</option> -->
<!-- 				<option value="2">2</option> -->
<!-- 				<option value="3">3</option> -->
<!-- 				<option value="4">4</option> -->
<!-- 				<option value="5">5</option> -->
<!--       		</select><br> -->
<!--        		</div>&ensp; -->
       		
<!--        		<div class="form-group col-2"> -->
<!--        		<select size="1" name="EXPECTATION" class="form-control form-control-sm"> -->
<!-- 				<option value="">期待度不低於</option> -->
<!-- 				<option value="0.2">20%</option> -->
<!-- 				<option value="0.4">40%</option> -->
<!-- 				<option value="0.6">60%</option> -->
<!-- 				<option value="0.8">80%</option> -->
<!-- 				<option value="0.9">90%</option> -->
<!-- 				<option value="0.95">95%</option> -->
<!--        		</select><br> -->
<!-- 			</div>&ensp; -->
			
			<div class="form-group col-2">
				<input type="hidden" name="action" value="listMovies_ByCompositeQuery_back">
		      	&ensp;<button class="btn btn-danger btn-sm" type="submit" value="送出">搜尋</button>
	      	</div>
		</div><br>
     </FORM>
</nav>

	

	<!--/content-inner-section-->
		<div class="w3_content_agilleinfo_inner">
				<div class="agile_featured_movies">
				<div class="inner-agile-w3l-part-head">
			    <h3 class="w3l-inner-h-title">後台瀏覽所有電影</h3>
			    	<div class="col-sm-3">
						<a href="<%=request.getContextPath()%>/back-end/movie/addMovie.jsp" class="btn btn-success" ><i class="material-icons">&#xE147;</i><span>Add New Movie</span></a>
					</div>
<%-- 			            <li><a href='<%=request.getContextPath()%>/back-end/movie/addMovie.jsp'>Add</a></li> --%>
				</div>
		            <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
				<div id="myTabContent" class="tab-content">
					<div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
						<div class="agile-news-table">
						<%@ include file="pages/page1.file"%>
<!-- 									<table id="table-breakpoint"> -->
								<table>
								<thead  align="center" class="123">
								  <tr class="123">
									<th align="center">劇照1</th>
									<th align="center">劇照2</th>
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

								  <tr  ${(movieVO.movieno == param.movieno) ? 'style="background-color:#7d4627;"':''}>
									<td>
										<a href="${pageContext.request.contextPath}/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}">
										<img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}" 
										alt="尚無圖片" width="80px;" height="100px" title="${movieVO.moviename}"/> 
										<span  style="text-align: center; display:block; font-size:10px; font-weight:bold;">${movieVO.moviename}</span></a></td>
									<td>
										<a href="${pageContext.request.contextPath}/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}">
										<img src="${pageContext.request.contextPath}/movie/DBGifReader2.do?movieno=${movieVO.movieno}" 
										alt="尚無圖片" width="80px;" height="100px" title="${movieVO.moviename}"/></a></td>
									
									<td width="50px;">${movieVO.director}</td>
									<td width="50px;">${movieVO.actor}</td>
									<td width="80px;">${movieVO.category}</td>
									
									<c:choose>
										<c:when test="${movieVO.length >0}">
											<td width="90px;">${movieVO.length}分鐘</td>
										</c:when>
										<c:otherwise>
											<td width="90px;">尚無時間</td>
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
										
									<td width="50px;"><a class="w3_play_icon1" href="${movieVO.trailor}">觀賞</a></td>
<!-- 									<td> -->
<!-- 										<div id="coverImg" onclick="onPlayerReady()">  -->
<!-- 										<a class="w3_play_icon1" >觀賞</a></div>  -->
<!-- 										<div id="ytplayer" style="display:none"></div> -->
<!-- 									</td> -->
									
									<td width="50px;">
										<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" style="margin-bottom: 0px;">
											<input type="submit" value="修改"
											 class="btn btn-outline-danger" style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#73BDBE; font-weight:bold; color:white;"> 
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
											<input type="submit" value="刪除"
											class="btn btn-outline-danger" style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#FC9C9D; font-weight:bold; color:white;"> 
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











			<!-- pop-up-box -->  
		<script src="<%=request.getContextPath()%>/js/jquery.magnific-popup.js" type="text/javascript"></script>
	<!--//pop-up-box -->
	<div id="small-dialog-${movieVO.movieno}" class="mfp-hide">
		<iframe src="https://www.youtube.com/embed/${movieVO.embed}"></iframe>
	</div>
	<script>
		$(document).ready(function() {
		$('.w3_play_icon,.w3_play_icon1,.w3_play_icon2').magnificPopup({
			type: 'inline',
			fixedContentPos: false,
			fixedBgPos: true,
			overflowY: 'auto',
			closeBtnInside: true,
			preloader: false,
			midClick: true,
			removalDelay: 300,
			mainClass: 'my-mfp-zoom-in'
		});
																		
		});
	</script>

</body>
</html>