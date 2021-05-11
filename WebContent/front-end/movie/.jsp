<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.movie.model.*"%>
<%@ page import="com.comment.model.*"%>
<%
	MovieService movieSvc = new MovieService();
	List<MovieVO> list = movieSvc.getAll();
	pageContext.setAttribute("list", list);
	
	List<MovieVO> listTopTen = movieSvc.getTopTen();
	pageContext.setAttribute("listTopTen", listTopTen);
%>
<!DOCTYPE html>
<html>
<head>
<title>List All Movies</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Movies Pro Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- //for-mobile-apps -->
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<!-- pop-up -->
<link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
<!-- //pop-up -->
<link href="css/easy-responsive-tabs.css" rel='stylesheet' type='text/css'/>
<link rel="stylesheet" type="text/css" href="css/zoomslider.css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link href="css/font-awesome.css" rel="stylesheet"> 
<script type="text/javascript" src="js/modernizr-2.6.2.min.js"></script>
<!--/web-fonts-->
<link href='//fonts.googleapis.com/css?family=Tangerine:400,700' rel='stylesheet' type='text/css'>
<link href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900" rel="stylesheet">
<link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
<!--//web-fonts-->

<style>
div>div>div>div>a>img{
width:10px;
height:10px;
}


</style>


</head>
<body>
<!--/main-header-->
  <!--/banner-section-->
	<div id="demo-1" class="banner-inner">
	 <div class="banner-inner-dott">
		<!--/header-w3l-->
			   <div class="header-w3-agileits" id="home">
			     <div class="inner-header-agile part2">	
				<nav class="navbar navbar-default">
					<div class="navbar-header">
<!-- 						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> -->
<!-- 							<span class="sr-only">Toggle navigation</span> -->
<!-- 							<span class="icon-bar"></span> -->
<!-- 							<span class="icon-bar"></span> -->
<!-- 							<span class="icon-bar"></span> -->
<!-- 						</button> -->
						<h1><a href="<%=request.getContextPath()%>/index.jsp"><span>M</span>ovies <span>H</span>it</a></h1>
					</div>
					<!-- navbar-header -->
					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
							<ul class="nav navbar-nav">
							<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">會員專區 <b class="caret"></b></a>
								<ul class="dropdown-menu multi-column columns-3">
									<li>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="<%=request.getContextPath()%>/backend/mem/select_page.jsp">會員登入</a></li>
												<li><a href="genre.html">申請會員</a></li>
											</ul>
										</div>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">訂票紀錄</a></li>
												<li><a href="horror.html">揪團紀錄</a></li>
											</ul>
										</div>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">會員服務</a></li>
												<li><a href="genre.html">會員QA</a></li>
											</ul>
										</div>
										<div class="clearfix"></div>
									</li>
								</ul>
							</li>
							<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">電影介紹<b class="caret"></b></a>
								<ul class="dropdown-menu multi-column columns-3">
									<li>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="<%=request.getContextPath()%>/front-end/movie/select_movie_page.jsp">搜尋電影</a></li>
												<li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=動作片">動作片</a></li>
												<li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=劇情片">劇情片</a></li>
												<li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=恐怖片">恐怖片</a></li>
												<li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=喜劇片">喜劇片</a></li>
												<li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=動畫片">動畫片</a></li>
											</ul>
										</div>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="<%=request.getContextPath()%>/front-end/movie/listAllMovie.jsp">所有電影</a></li>
												<li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=冒險片">冒險片</a></li>
												<li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=戰爭片">戰爭片</a></li>
												<li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=驚悚片">驚悚片</a></li>
												<li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=劇情片">愛情片</a></li>
												<li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=音樂片">音樂片</a></li>
											</ul>
										</div>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">哈燒影榜</a></li>
												<li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=科幻片">科幻片</a></li>
												<li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=史詩片">史詩片</a></li>
												<li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=懸疑片">懸疑片</a></li>
												<li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=奇幻片">奇幻片</a></li>
												<li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=歌舞劇">歌舞劇</a></li>
											</ul>
										</div>
										<div class="clearfix"></div>
									</li>
								</ul>
							</li>
							<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">電影評論<b class="caret"></b></a>
								<ul class="dropdown-menu multi-column columns-3">
									<li>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="<%=request.getContextPath()%>/front-end/comment/select_comment_page.jsp">搜尋評論</a></li>
												<li><a href="genre.html">評論</a></li>
											</ul>
										</div>
									<li>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="<%=request.getContextPath()%>/front-end/comment/listAllComment.jsp">所有評論</a></li>
												<li><a href="genre.html">沒啥好說</a></li>
											</ul>
										</div>
									<li>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">搜尋評論</a></li>
												<li><a href="genre.html">沒啥好說</a></li>
											</ul>
										</div>
										<div class="clearfix"></div>
									</li>
								</ul>
							</li>
							<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">揪團啾啾<b class="caret"></b></a>
								<ul class="dropdown-menu multi-column columns-3">
									<li>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">搜尋揪團</a></li>
												<li><a href="genre.html">快速揪團</a></li>
											</ul>
										</div>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">搜尋揪團</a></li>
												<li><a href="genre.html">快速揪團</a></li>
											</ul>
										</div>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">搜尋揪團</a></li>
												<li><a href="genre.html">快速揪團</a></li>
											</ul>
										</div>
										<div class="clearfix"></div>
									</li>
								</ul>
							</li>
							<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">電影討論區<b class="caret"></b></a>
								<ul class="dropdown-menu multi-column columns-3">
									<li>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">討論啥</a></li>
												<li><a href="genre.html">討論你</a></li>
											</ul>
										</div>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">討論啥</a></li>
												<li><a href="genre.html">討論你</a></li>
											</ul>
										</div>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">討論啥</a></li>
												<li><a href="genre.html">討論你</a></li>
											</ul>
										</div>
										<div class="clearfix"></div>
									</li>
								</ul>
							</li>
							<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">餐飲<b class="caret"></b></a>
								<ul class="dropdown-menu multi-column columns-3">
									<li>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">要吃啥</a></li>
												<li><a href="genre.html">吃屎吧</a></li>
											</ul>
										</div>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">要吃啥</a></li>
												<li><a href="genre.html">吃屎吧</a></li>
											</ul>
										</div>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">要吃啥</a></li>
												<li><a href="genre.html">吃屎吧</a></li>
											</ul>
										</div>
										<div class="clearfix"></div>
									</li>
								</ul>
							</li>
							<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">活動公告<b class="caret"></b></a>
								<ul class="dropdown-menu multi-column columns-3">
									<li>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">影城公告</a></li>
											</ul>
										</div>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">影城活動</a></li>
											</ul>
										</div>
										<div class="col-sm-4">
											<ul class="multi-column-dropdown">
												<li><a href="genre.html">合作夥伴</a></li>
											</ul>
										</div>
										<div class="clearfix"></div>
									</li>
								</ul>
							</li>
							<li class="active"><a href="index.html">影城介紹</a></li>	
						</ul>
					</div>	
			
					<div class="clearfix"> </div>	
				</nav>
					<div class="w3ls_search">
									<div class="cd-main-header">
										<ul class="cd-header-buttons">
											<li><a class="cd-search-trigger" href="#cd-search"> <span></span></a></li>
										</ul> <!-- cd-header-buttons -->
									</div>
										<div id="cd-search" class="cd-search">
											<form method="post" action="<%=request.getContextPath()%>/movie/movie.do" >
												<input type="text" name="MOVIE_NAME" value="" placeholder="請輸入電影名稱" onkeydown="if (event.keyCode == 13) sendMessage();">
												<input type="hidden" name="action" value="listMovies_ByCompositeQuery">
											</form>
										</div>
								</div>
	
			</div> 

			   </div>
		<!--//header-w3l-->
		</div>
    </div>
  <!--/banner-section-->
 <!--//main-header-->
	         <!--/banner-bottom-->
			  <div class="w3_agilits_banner_bootm">
			     <div class="w3_agilits_inner_bottom">
			            <div class="col-md-6 wthree_agile_login">
						     <ul>
									<li><i class="fa fa-phone" aria-hidden="true"></i> (+886) 0912 345 678</li>
									<li><a href="#" class="login"  data-toggle="modal" data-target="#myModal4">Login</a></li>
									<li><a href="#" class="login reg"  data-toggle="modal" data-target="#myModal5">Register</a></li>

								</ul>
						</div>
				</div>
			</div>
			<!--//banner-bottom-->
		     <!-- Modal1 -->
					<div class="modal fade" id="myModal4" tabindex="-1" role="dialog" >

							<div class="modal-dialog">
							<!-- Modal content-->
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4>Login</h4>
										<div class="login-form">
											<form action="#" method="post">
												<input type="email" name="email" placeholder="E-mail" required="">
												<input type="password" name="password" placeholder="Password" required="">
												<div class="tp">
													<input type="submit" value="LOGIN NOW">
												</div>
												<div class="forgot-grid">
												       <div class="log-check">
														<label class="checkbox"><input type="checkbox" name="checkbox">Remember me</label>
														</div>
														<div class="forgot">
															<a href="#" data-toggle="modal" data-target="#myModal2">Forgot Password?</a>
														</div>
														<div class="clearfix"></div>
													</div>
												
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
				<!-- //Modal1 -->
				  <!-- Modal1 -->
					<div class="modal fade" id="myModal5" tabindex="-1" role="dialog" >

							<div class="modal-dialog">
							<!-- Modal content-->
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4>Register</h4>
										<div class="login-form">
											<form action="#" method="post">
											    <input type="text" name="name" placeholder="Name" required="">
												<input type="email" name="email" placeholder="E-mail" required="">
												<input type="password" name="password" placeholder="Password" required="">
												<input type="password" name="conform password" placeholder="Confirm Password" required="">
												<div class="signin-rit">
														<span class="agree-checkbox">
														<label class="checkbox"><input type="checkbox" name="checkbox">I agree to your <a class="w3layouts-t" href="#" target="_blank">Terms of Use</a> and <a class="w3layouts-t" href="#" target="_blank">Privacy Policy</a></label>
													</span>
												</div>
												<div class="tp">
													<input type="submit" value="REGISTER NOW">
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
				<!-- //Modal1 -->
				<!-- breadcrumb -->
				<div class="w3_breadcrumb">
					<div class="breadcrumb-inner">	
						<ul>
							<li><a href="<%=request.getContextPath()%>/index.jsp">Home</a></li>
						</ul>
					</div>
				</div>
			<!-- //breadcrumb -->

			<!--/content-inner-section-->
				<div class="w3_content_agilleinfo_inner">
					<div class="agile_featured_movies">
	<%@ include file="pages/page1.file"%>
		<!--/tv-movies-->

<!-- 為模糊查詢跳轉頁面時準備 -->
<%-- 	<c:forEach var="movieVO" items="${list}"> --%>
<%-- 			<c:if test="${movieVO.getCategory().indexOf('動作片')!=-1}"> --%>
<!-- 					<h3 class="agile_w3_title hor-t">Action <span>Movies</span> </h3> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${movieVO.getCategory().indexOf('冒險片')!=-1}"> --%>
<!-- 					<h3 class="agile_w3_title hor-t">Adventure <span>Movies</span> </h3> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${movieVO.getCategory().indexOf('科幻片')!=-1}"> --%>
<!-- 					<h3 class="agile_w3_title hor-t">Science fiction <span>Movies</span> </h3> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${movieVO.getCategory().indexOf('劇情片')!=-1}"> --%>
<!-- 					<h3 class="agile_w3_title hor-t">喜劇<span>Movies</span> </h3> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${movieVO.getCategory().indexOf('戰爭片')!=-1}"> --%>
<!-- 					<h3 class="agile_w3_title hor-t">喜劇<span>Movies</span> </h3> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${movieVO.getCategory().indexOf('史詩片')!=-1}"> --%>
<!-- 					<h3 class="agile_w3_title hor-t">喜劇<span>Movies</span> </h3> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${movieVO.getCategory().indexOf('恐怖片')!=-1}"> --%>
<!-- 					<h3 class="agile_w3_title hor-t">喜劇<span>Movies</span> </h3> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${movieVO.getCategory().indexOf('驚悚片')!=-1}"> --%>
<!-- 					<h3 class="agile_w3_title hor-t">喜劇<span>Movies</span> </h3> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${movieVO.getCategory().indexOf('懸疑片')!=-1}"> --%>
<!-- 					<h3 class="agile_w3_title hor-t">喜劇<span>Movies</span> </h3> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${movieVO.getCategory().indexOf('喜劇片')!=-1}"> --%>
<!-- 					<h3 class="agile_w3_title hor-t">喜劇<span>Movies</span> </h3> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${movieVO.getCategory().indexOf('愛情片')!=-1}"> --%>
<!-- 					<h3 class="agile_w3_title hor-t">喜劇<span>Movies</span> </h3> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${movieVO.getCategory().indexOf('奇幻片')!=-1}"> --%>
<!-- 					<h3 class="agile_w3_title hor-t">喜劇<span>Movies</span> </h3> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${movieVO.getCategory().indexOf('動畫片')!=-1}"> --%>
<!-- 					<h3 class="agile_w3_title hor-t">喜劇<span>Movies</span> </h3> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${movieVO.getCategory().indexOf('音樂片')!=-1}"> --%>
<!-- 					<h3 class="agile_w3_title hor-t">喜劇<span>Movies</span> </h3> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${movieVO.getCategory().indexOf('歌舞劇')!=-1}"> --%>
<!-- 					<h3 class="agile_w3_title hor-t">喜劇<span>Movies</span> </h3> -->
<%-- 			</c:if> --%>
<%-- 	</c:forEach>													 --%>
		

		
					<h3 class="agile_w3_title hor-t">All <span>Movies</span> </h3>
		<c:forEach var="movieVO" items="${list}"  begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
					 <div ${(movieVO.movieno==param.movieno) ? 'bgcolor=#CCCCFF':''} class="wthree_agile-requested-movies tv-movies">
										<div class="col-md-2 w3l-movie-gride-agile requested-movies">
															<a href="<%=request.getContextPath()%>/front-end/movie/listOneMovie.jsp" class="hvr-sweep-to-bottom">
															<img src="${pageContext.request.contextPath}/movie/DBGifReader4.do?movieno=${movieVO.movieno}"
															 title="${movieVO.moviename}" class="img-responsive" alt=" " style="width:255px; height:300px;">
																<div class="w3l-action-icon"><i class="fa fa-play-circle-o" aria-hidden="true" ></i></div>
															</a>
																<div class="mid-1 agileits_w3layouts_mid_1_home">
																	<div class="w3l-movie-text">
																		<h6><a href="single.html">${movieVO.moviename}</a></h6>
																	</div>
																	<div class="mid-2 agile_mid_2_home">
																		<p>上映日期: <fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /><br>						
																		下映日期: <fmt:formatDate value="${movieVO.offdate}" pattern="yyyy-MM-dd" /></p>
		
																<c:choose>
																	<c:when test="${movieVO.rating <= 2.0}">
																		<div class="block-stars">
																			<ul class="w3l-ratings">	
																				<li><i class="fa fa-star" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
																			</ul> 
	 																	</div>
																		<div class="clearfix"></div>
																	</c:when>
																	<c:when test="${movieVO.rating <= 4.0}">
																		<div class="block-stars">
																			<ul class="w3l-ratings">	
																				<li><i class="fa fa-star" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
																			</ul> 
	 																	</div>
																		<div class="clearfix"></div>
																	</c:when>
																	<c:when test="${movieVO.rating <= 6.0}">
																		<div class="block-stars">
																			<ul class="w3l-ratings">
																				<li><i class="fa fa-star" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
																			</ul> 
	 																	</div>
																		<div class="clearfix"></div>
																	</c:when>
																	<c:when test="${movieVO.rating <= 8.0}">
																		<div class="block-stars">
																			<ul class="w3l-ratings">
																				<li><i class="fa fa-star" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
																			</ul> 
	 																	</div>
																		<div class="clearfix"></div>
																	</c:when>
																	<c:when test="${movieVO.rating <= 10.0}">
																		<div class="block-stars">
																			<ul class="w3l-ratings">
																				<li><i class="fa fa-star" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star" aria-hidden="true"></i></li>
																			</ul> 
	 																	</div>
																		<div class="clearfix"></div>
																	</c:when>
																	<c:otherwise>
																		<li>尚無評分</li>
																	</c:otherwise>
																	</c:choose>	
																	</div>
																</div>
															<div class="ribben one">
																<p>NEW</p>
															</div>
													</div>
												</div>
		</c:forEach>
			<!--//tv-movies-->
					  <div class="blog-pagenat-wthree">
								<ul>
								<%if (rowsPerPage<rowNumber) {%>
    								<%if(pageIndex>=rowsPerPage){%>
    								<li><a class="frist" href="<%=request.getRequestURI()%>?whichPage=1">第一頁</a></li>
									<li><a class="frist" href="<%=request.getRequestURI()%>?whichPage=<%=whichPage-1%>">上一頁</a></li>
										 <%}%> 
 									<%if(pageIndex<pageIndexArray[pageNumber-1]){%>
									<li><a class="last" href="<%=request.getRequestURI()%>?whichPage=<%=whichPage+1%>">下一頁</a></li>
									<li><a class="last" href="<%=request.getRequestURI()%>?whichPage=<%=pageNumber%>">最後一頁</a></li>
									 <%}%>
								<%}%> 
								</ul>
				<!--//requested-movies-->
				  <h3 class="agile_w3_title"> Top <font color=red>Ten</font> Movies <span>Review</span></h3>
			<!--/movies-->
			
	
			<div class="w3_agile_latest_movies">
				<div id="owl-demo" class="owl-carousel owl-theme">
			<% int i = 1;%>
			<c:forEach var="movieVO" items="${listTopTen}">	
					<div class="item">
						<div class="w3l-movie-gride-agile w3l-movie-gride-slider ">
							<a href="single.html" class="hvr-sweep-to-bottom"><img src="${pageContext.request.contextPath}/movie/DBGifReader4.do?movieno=${movieVO.movieno}"
							 title="${movieVO.moviename}" class="img-responsive" alt=" " style="width:255px; height:300px;"/>
								<div class="w3l-action-icon"><i class="fa fa-play-circle-o" aria-hidden="true"></i></div>
							</a>
							<div class="mid-1 agileits_w3layouts_mid_1_home">
								<div class="w3l-movie-text">
									<h6><a href="single.html">${movieVO.moviename}</a></h6>							
								</div>
								<div class="mid-2 agile_mid_2_home">
									<p>上映日期: <fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /><br>						
									下映日期: <fmt:formatDate value="${movieVO.offdate}" pattern="yyyy-MM-dd" /></p>
									<c:choose>
										<c:when test="${movieVO.rating <= 2.0}">
											<div class="block-stars">
												<ul class="w3l-ratings">	
													<li><i class="fa fa-star" aria-hidden="true"></i></li>
													<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
													<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
													<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
													<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
												</ul> 
	 										</div>
											<div class="clearfix"></div>
										</c:when>
										<c:when test="${movieVO.rating <= 4.0}">
											<div class="block-stars">
												<ul class="w3l-ratings">	
													<li><i class="fa fa-star" aria-hidden="true"></i></li>
													<li><i class="fa fa-star" aria-hidden="true"></i></li>
													<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
													<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
													<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
												</ul> 
	 										</div>
											<div class="clearfix"></div>
										</c:when>
										<c:when test="${movieVO.rating <= 6.0}">
											<div class="block-stars">
												<ul class="w3l-ratings">
													<li><i class="fa fa-star" aria-hidden="true"></i></li>
													<li><i class="fa fa-star" aria-hidden="true"></i></li>
													<li><i class="fa fa-star" aria-hidden="true"></i></li>
													<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
													<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
												</ul> 
	 										</div>
											<div class="clearfix"></div>
										</c:when>
										<c:when test="${movieVO.rating <= 8.0}">
											<div class="block-stars">
												<ul class="w3l-ratings">
													<li><i class="fa fa-star" aria-hidden="true"></i></li>
													<li><i class="fa fa-star" aria-hidden="true"></i></li>
													<li><i class="fa fa-star" aria-hidden="true"></i></li>
													<li><i class="fa fa-star" aria-hidden="true"></i></li>
													<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
												</ul> 
	 										</div>
										<div class="clearfix"></div>
										</c:when>
										<c:when test="${movieVO.rating <= 10.0}">
											<div class="block-stars">
												<ul class="w3l-ratings">
												<% for (int j=1 ; j<=5; j++) { %>
													<li><i class="fa fa-star" aria-hidden="true"></i></li>
												<% } %>
												</ul> 
	 										</div>
											<div class="clearfix"></div>
										</c:when>
										<c:otherwise>
											<li>尚無評分</li>
										</c:otherwise>
									</c:choose>	
									<div class="clearfix"></div>
								</div>
							</div>
							<div class="ribben one">
								<p>TOP <%= i %></p>
								<% i++; %>
							</div>
						</div>
					</div>
				</c:forEach>		


<!-- 寫道這					 -->
<!--//movies-->
				</div>
			</div>
		</div>
<!--//content-inner-section-->
		
<!--/footer-bottom-->
	<div class="contact-w3ls" id="contact">
			<div class="footer-w3lagile-inner">
				<h2>Sign up for our <span>Newsletter</span></h2>
				<p class="para">May the Force be with you.</p>
				<div class="footer-contact">
<!-- EMAIL action	-->				
					<form action="#" method="post"> 
						<input type="email" name="Email" placeholder="Enter your email...." required=" ">
						<input type="submit" value="Subscribe">
					</form>
				</div>
					<div class="footer-grids w3-agileits">
						<div class="col-md-2 footer-grid">
						<h4>Release</h4>
							<ul> 
								<li><a href="#" title="Release 2016">2016</a></li> 
								<li><a href="#" title="Release 2015">2015</a></li>
								<li><a href="#" title="Release 2014">2014</a></li> 
								<li><a href="#" title="Release 2013">2013</a></li> 
								<li><a href="#" title="Release 2012">2012</a></li>
								<li><a href="#" title="Release 2011">2011</a></li> 
							</ul>
						</div>
								<div class="col-md-2 footer-grid">
						<h4>Movies</h4>
							<ul>
								
								<li><a href="genre.html">ADVENTURE</a></li>
								<li><a href="comedy.html">COMEDY</a></li>
								<li><a href="series.html">FANTASY</a></li>
								<li><a href="series.html">ACTION  </a></li>
								<li><a href="genre.html">MOVIES  </a></li>
								<li><a href="horror.html">HORROR  </a></li>
								
							</ul>
						</div>
				

							<div class="col-md-2 footer-grid">
								<h4>Review Movies</h4>
									<ul class="w3-tag2">
									<li><a href="comedy.html">Comedy</a></li>
									<li><a href="horror.html">Horror</a></li>
									<li><a href="series.html">Historical</a></li>
									<li><a href="series.html">Romantic</a></li>
									<li><a href="series.html">Love</a></li>
									<li><a href="genre.html">Action</a></li>
									<li><a href="single.html">Reviews</a></li>
									<li><a href="comedy.html">Comedy</a></li>
									<li><a href="horror.html">Horror</a></li>
									<li><a href="series.html">Historical</a></li>
									<li><a href="series.html">Romantic</a></li>
									<li><a href="genre.html">Love</a></li>
									<li><a href="comedy.html">Comedy</a></li>
									<li><a href="horror.html">Horror</a></li>
									<li><a href="genre.html">Historical</a></li>
									
								</ul>


						</div>
								<div class="col-md-2 footer-grid">
						<h4>Latest Movies</h4>
							<div class="footer-grid1">
								<div class="footer-grid1-left">
									<a href="single.html"><img src="images/1.jpg" alt=" " class="img-responsive"></a>
								</div>
								<div class="footer-grid1-right">
									<a href="single.html">eveniet ut molesti</a>
									
								</div>
								<div class="clearfix"> </div>
							</div>
							<div class="footer-grid1">
								<div class="footer-grid1-left">
									<a href="single.html"><img src="images/2.jpg" alt=" " class="img-responsive"></a>
								</div>
								<div class="footer-grid1-right">
									<a href="single.html">earum rerum tenet</a>
									
								</div>
								<div class="clearfix"> </div>
							</div>
							<div class="footer-grid1">
							
								<div class="footer-grid1-left">
									<a href="single.html"><img src="images/4.jpg" alt=" " class="img-responsive"></a>
								</div>
								<div class="footer-grid1-right">
									<a href="single.html">eveniet ut molesti</a>
									
								</div>
								<div class="clearfix"> </div>
							</div>
							<div class="footer-grid1">
								<div class="footer-grid1-left">
									<a href="single.html"><img src="images/3.jpg" alt=" " class="img-responsive"></a>
								</div>
								<div class="footer-grid1-right">
									<a href="single.html">earum rerum tenet</a>
									
								</div>
								<div class="clearfix"> </div>
							</div>


						</div>
						<div class="col-md-2 footer-grid">
						   <h4 class="b-log"><a href="index.html"><span>M</span>ovies <span>P</span>ro</a></h4>
							<div class="footer-grid-instagram">
							<a href="single.html"><img src="images/m1.jpg" alt=" " class="img-responsive"></a>
							</div>
							<div class="footer-grid-instagram">
							<a href="single.html"><img src="images/m2.jpg" alt=" " class="img-responsive"></a>
							</div>
							<div class="footer-grid-instagram">
								<a href="single.html"><img src="images/m3.jpg" alt=" " class="img-responsive"></a>
							</div>
							<div class="footer-grid-instagram">
							<a href="single.html"><img src="images/m4.jpg" alt=" " class="img-responsive"></a>
							</div>
							<div class="footer-grid-instagram">
								<a href="single.html"><img src="images/m5.jpg" alt=" " class="img-responsive"></a>
							</div>
							<div class="footer-grid-instagram">
							<a href="single.html"><img src="images/m6.jpg" alt=" " class="img-responsive"></a>
							</div>
								
							<div class="clearfix"> </div>
						</div>
						<div class="clearfix"> </div>
						<ul class="bottom-links-agile">
								<li><a href="icons.html" title="Font Icons">Icons</a></li> 
								<li><a href="short-codes.html" title="Short Codes">Short Codes</a></li> 
								<li><a href="contact.html" title="contact">Contact</a></li> 
								
							</ul>
					</div>
					<h3 class="text-center follow">Connect <span>Us</span></h3>
						<ul class="social-icons1 agileinfo">
							<li><a href="#"><i class="fa fa-facebook"></i></a></li>
							<li><a href="#"><i class="fa fa-twitter"></i></a></li>
							<li><a href="#"><i class="fa fa-linkedin"></i></a></li>
							<li><a href="#"><i class="fa fa-youtube"></i></a></li>
							<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
						</ul>	
					
			 </div>
						
			</div>
			<div class="w3agile_footer_copy">
				    <p> 2021 Movies Hit. Allghts reserved | Design by <a href="<%=request.getContextPath()%>/index.jsp">CEA103G3</a></p>
			</div>
		<a href="#home" id="toTop" class="scroll" style="display: block;"> <span id="toTopHover" style="opacity: 1;"> </span></a>

<script src="js/jquery-1.11.1.min.js"></script>
	<!-- Dropdown-Menu-JavaScript -->
			<script>
				$(document).ready(function(){
					$(".dropdown").hover(            
						function() {
							$('.dropdown-menu', this).stop( true, true ).slideDown("fast");
							$(this).toggleClass('open');        
						},
						function() {
							$('.dropdown-menu', this).stop( true, true ).slideUp("fast");
							$(this).toggleClass('open');       
						}
					);
				});
			</script>
		<!-- //Dropdown-Menu-JavaScript -->
		<!-- search-jQuery -->
				<script src="js/main.js"></script>
			<!-- //search-jQuery -->
			<script src="js/simplePlayer.js"></script>
			<script>
				$("document").ready(function() {
					$("#video").simplePlayer();
				});
			</script>
			<script>
				$("document").ready(function() {
					$("#video1").simplePlayer();
				});
			</script>
			<script>
				$("document").ready(function() {
					$("#video2").simplePlayer();
				});
			</script>
				<script>
				$("document").ready(function() {
					$("#video3").simplePlayer();
				});
			</script>
			<script>
				$("document").ready(function() {
					$("#video4").simplePlayer();
				});
			</script>
			<script>
				$("document").ready(function() {
					$("#video5").simplePlayer();
				});
			</script>
			<script>
				$("document").ready(function() {
					$("#video6").simplePlayer();
				});
			</script>

			<!-- pop-up-box -->  
		<script src="js/jquery.magnific-popup.js" type="text/javascript"></script>
	<!--//pop-up-box -->

			<div id="small-dialog1" class="mfp-hide">
		<iframe src="https://player.vimeo.com/video/165197924?color=ffffff&title=0&byline=0&portrait=0"></iframe>
	</div>
	<div id="small-dialog2" class="mfp-hide">
		<iframe src="https://player.vimeo.com/video/165197924?color=ffffff&title=0&byline=0&portrait=0"></iframe>
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
<script src="js/easy-responsive-tabs.js"></script>
<script>
$(document).ready(function () {
$('#horizontalTab').easyResponsiveTabs({
type: 'default', //Types: default, vertical, accordion           
width: 'auto', //auto or any width like 600px
fit: true,   // 100% fit in a container
closed: 'accordion', // Start closed if in accordion view
activate: function(event) { // Callback function if tab is switched
var $tab = $(this);
var $info = $('#tabInfo');
var $name = $('span', $info);
$name.text($tab.text());
$info.show();
}
});
$('#verticalTab').easyResponsiveTabs({
type: 'vertical',
width: 'auto',
fit: true
});
});
</script>
<link href="css/owl.carousel.css" rel="stylesheet" type="text/css" media="all">
<script src="js/owl.carousel.js"></script>
<script>
	$(document).ready(function() { 
		$("#owl-demo").owlCarousel({
	 
		 autoPlay: 3000, //Set AutoPlay to 3 seconds
		  autoPlay : true,
		   navigation :true,

		  items : 5,
		  itemsDesktop : [640,4],
		  itemsDesktopSmall : [414,3]
	 
		});
	 
	}); 
</script> 

<!--/script-->
<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>

<script type="text/javascript">
			jQuery(document).ready(function($) {
				$(".scroll").click(function(event){		
					event.preventDefault();
					$('html,body').animate({scrollTop:$(this.hash).offset().top},900);
				});
			});
</script>
 <script type="text/javascript">
						$(document).ready(function() {
							/*
							var defaults = {
					  			containerID: 'toTop', // fading element id
								containerHoverID: 'toTopHover', // fading element hover id
								scrollSpeed: 1200,
								easingType: 'linear' 
					 		};
							*/
							
							$().UItoTop({ easingType: 'easeOutQuart' });
							
						});
					</script>
<!--end-smooth-scrolling-->
	<script src="js/bootstrap.js"></script>

 

</body>
</html>