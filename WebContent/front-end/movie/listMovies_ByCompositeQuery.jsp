<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.movie.model.*"%>

<jsp:useBean id="listMovies_ByCompositeQuery" scope="request" type="java.util.List<MovieVO>" />

<%	
	MovieService movieSvc = new MovieService();	
	List<MovieVO> listTopFive = movieSvc.getTopFive();
	pageContext.setAttribute("listTopFive", listTopFive);

	List<MovieVO> latestMovie = movieSvc.getLatestMovie();
	pageContext.setAttribute("latestMovie", latestMovie);
	
	List<MovieVO> listTopTen = movieSvc.getTopTen();
	pageContext.setAttribute("listTopTen", listTopTen);
%>
<!DOCTYPE html>
<html>
<head>
<title>List Movies By ComposiiteQuery</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=big5" />
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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
<link href="<%=request.getContextPath()%>/css/font-awesome.css" rel="stylesheet"> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/modernizr-2.6.2.min.js"></script>
<!--/web-fonts-->
<link href='//fonts.googleapis.com/css?family=Tangerine:400,700' rel='stylesheet' type='text/css'>
<link href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900" rel="stylesheet">
<link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
<!--//web-fonts-->
<script src="https://unpkg.com/ionicons@5.4.0/dist/ionicons.js"></script>	
<style>
.footer-directorAndActor {
width:40px;
height:50px;

.blog-pagenat-wthree{
    border: 1px solid red;
    clear: both;
}

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
                                    <ul class="dropdown-menu multi-column columns-2">
                                        <li>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="<%=request.getContextPath()%>/backend/mem/select_page.jsp">會員登入</a></li>
                                                    <li><a href="genre.html">申請會員</a></li>
                                                    <li><a href="genre.html">訂票紀錄</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="horror.html">揪團紀錄</a></li>
                                                    <li><a href="genre.html">會員服務</a></li>
                                                    <li><a href="genre.html">會員QA</a></li>
                                                </ul>
                                            </div>
                                            <!-- <div class="clearfix"></div> -->
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
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=犯罪片">犯罪片</a></li>
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
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=警匪片">警匪片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=驚悚片">驚悚片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=愛情片">愛情片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=音樂片">音樂片</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-4">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">哈燒影榜</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=科幻片">科幻片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=史詩片">史詩片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=奇幻片">奇幻片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=懸疑片">懸疑片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=文藝片">文藝片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=歌舞劇">歌舞劇</a></li>
                                                </ul>
                                            </div>
                                            <div class="clearfix"></div>
                                        </li>
                                    </ul>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">電影評論<b class="caret"></b></a>
                                    <ul class="dropdown-menu multi-column columns-2">
                                        <li>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="<%=request.getContextPath()%>/front-end/comment/select_comment_page.jsp">搜尋評論</a></li>
                                                    <li><a href="genre.html">評論</a></li>
                                                </ul>
                                            </div>
                                        <li>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="<%=request.getContextPath()%>/front-end/comment/listAllComment.jsp">所有評論</a></li>
                                                    <li><a href="genre.html">沒啥好說</a></li>
                                                </ul>
                                            </div>
                                        <li>
                                            <div class="clearfix"></div>
                                        </li>
                                    </ul>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">揪團啾啾<b class="caret"></b></a>
                                    <ul class="dropdown-menu multi-column columns-2">
                                        <li>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">搜尋揪團</a></li>
                                                    <li><a href="genre.html">快速揪團</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-6">
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
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">討論區<b class="caret"></b></a>
                                    <ul class="dropdown-menu multi-column columns-2">
                                        <li>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">討論啥</a></li>
                                                    <li><a href="genre.html">討論你</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-6">
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
                                    <ul class="dropdown-menu multi-column columns-2">
                                        <li>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">要吃啥</a></li>
                                                    <li><a href="genre.html">吃屎吧</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-6">
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
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">公告<b class="caret"></b></a>
                                    <ul class="dropdown-menu multi-column columns-1">
                                        <li>
                                            <div class="col-sm-12">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">影城公告</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-12">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">影城活動</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-12">
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
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	<%@ include file="pages/page1_ByCompositeQuery.file"%>
		<!--/tv-movies-->
		<c:forEach var="movieVO" items="${listMovies_ByCompositeQuery}"
			begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
					 <div ${(movieVO.movieno==param.movieno) ? 'bgcolor=#CCCCFF':''} class="wthree_agile-requested-movies tv-movies">
										<div class="col-md-2 w3l-movie-gride-agile requested-movies">
															<a href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}" class="hvr-sweep-to-bottom">
															<img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}"
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
																	<c:when test="${movieVO.rating < 1.0}">
																		<div class="block-stars">
																			<ul class="w3l-ratings">	
																				<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
																				<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
																			</ul> 
	 																	</div>
																		<div class="clearfix"></div>
																	</c:when>
																	<c:when test="${movieVO.rating < 2.0}">
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
																	<c:when test="${movieVO.rating < 3.0}">
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
																	<c:when test="${movieVO.rating < 4.0}">
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
																	<c:when test="${movieVO.rating < 5.0}">
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
																	<c:when test="${movieVO.rating == 5.0}">
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
																		<div class="block-stars">
																			<ul style="list-style-type:none; font-size:14px;">
																				<li >尚無評分</li>
																			</ul>
																		</div>
																		<div class="clearfix"></div>
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
									<%@ include file="pages/page2_ByCompositeQuery.file" %>
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
							<a href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}" class="hvr-sweep-to-bottom">
							<img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}"
							 title="${movieVO.moviename}" class="img-responsive" alt=" " style="width:255px; height:300px;"/>
								<div class="w3l-action-icon"><i class="fa fa-play-circle-o" aria-hidden="true"></i></div>
							</a>
							<div class="mid-1 agileits_w3layouts_mid_1_home">
								<div class="w3l-movie-text">
									<h6><a href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}">${movieVO.moviename}</a></h6>							
								</div>
								<div class="mid-2 agile_mid_2_home">
									<p>上映日期: <fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /><br>						
									下映日期: <fmt:formatDate value="${movieVO.offdate}" pattern="yyyy-MM-dd" /></p>
									<c:choose>
										<c:when test="${movieVO.rating <= 1.0}">
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
										<c:when test="${movieVO.rating <= 2.0}">
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
										<c:when test="${movieVO.rating <= 3.0}">
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
										<c:when test="${movieVO.rating <= 4.0}">
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
										<c:when test="${movieVO.rating <= 5.0}">
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
											<div class="block-stars">
												<ul style="list-style-type:none; font-size:14px;">
													<li >尚無評分</li>
												</ul>
											</div>
											<div class="clearfix"></div>
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


<!--//movies-->
				</div>
			</div>
		</div>
<!--//content-inner-section-->
		
<!--/footer-bottom-->
 <div class="contact-w3ls" id="contact">
        <div class="footer-w3lagile-inner">
            <div class="footer-grids w3-agileits">
                <div class="col-md-2 footer-grid">
                    <h4 class="b-log"><a><span>Y</span>ear</a></h4>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2021" title="Release 2021">2021</a></li>
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2020" title="Release 2020">2020</a></li>
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2019" title="Release 2019">2019</a></li>
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2018" title="Release 2018">2018</a></li>
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2017" title="Release 2017">2017</a></li>
                    </ul>
                </div>
                <div class="col-md-2 footer-grid">
                    <h4 class="b-log"><a><span>D</span>irector</a></h4>
                    <div class="footer-grid1">
                        <div class="footer-grid1-left">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&DIRECTOR=Steven Spielberg">
                                <img src="<%=request.getContextPath()%>/images/index/Steven Spielberg.jpg" alt=" " class="footer-directorAndActor" ></a>
                        </div>
                        <div class="footer-grid1-right">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&DIRECTOR=Steven Spielberg">
                                Steven Spielberg</a>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="footer-grid1">
                        <div class="footer-grid1-left">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&DIRECTOR=Michael Bay">
                                <img src="<%=request.getContextPath()%>/images/index/Michael Bay.jpg" alt=" " class="footer-directorAndActor" ></a>
                        </div>
                        <div class="footer-grid1-right">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&DIRECTOR=Michael Bay">
                                Michael Bay</a>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="footer-grid1">
                        <div class="footer-grid1-left">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&DIRECTOR=James Cameron">
                                <img src="<%=request.getContextPath()%>/images/index/James Cameron.jpg" alt=" " class="footer-directorAndActor" ></a>
                        </div>
                        <div class="footer-grid1-right">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&DIRECTOR=James Cameron">
                                James Cameron</a>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="footer-grid1">
                        <div class="footer-grid1-left">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&DIRECTOR=Christopher Nolan">
                                <img src="<%=request.getContextPath()%>/images/index/Christopher Nolan.jpg" alt=" " class="footer-directorAndActor" ></a>
                        </div>
                        <div class="footer-grid1-right">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&DIRECTOR=Christopher Nolan">
                                Christopher Nolan</a>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                </div>
                <div class="col-md-2 footer-grid">
                    <h4 class="b-log"><a><span>L</span>atest <span>M</span>ovie</a></h4>
                    <c:forEach var="movieVO" items="${latestMovie}">
                        <div class="footer-grid-instagram">
                             <a href="${pageContext.request.contextPath}/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}">
                            <img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}" title=" " width="86px" height="103px"></a>
                        </div>
                    </c:forEach>
                    <div class="clearfix"> </div>
                </div>
                <div class="col-md-2 footer-grid">
                    <h4 class="b-log"><a><span>A</span>ctor</a></h4>
                    <div class="footer-grid1">
                        <div class="footer-grid1-left">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&ACTOR=Leonardo Wilhelm DiCaprio">
                                <img src="<%=request.getContextPath()%>/images/index/Leonardo DiCaprio.jpg" alt=" " class="footer-directorAndActor" ></a>
                        </div>
                        <div class="footer-grid1-right">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&ACTOR=Leonardo Wilhelm DiCaprio">
                                Leonardo DiCaprio</a>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="footer-grid1">
                        <div class="footer-grid1-left">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&ACTOR=Tom Cruise">
                                <img src="<%=request.getContextPath()%>/images/index/Tom Cruise.jpg" alt=" " class="footer-directorAndActor" ></a>
                        </div>
                        <div class="footer-grid1-right">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&ACTOR=Tom Cruise">
                                Tom Cruise</a>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="footer-grid1">
                        <div class="footer-grid1-left">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&ACTOR=Emma Stone">
                                <img src="<%=request.getContextPath()%>/images/index/Emma Stone.jpg" alt=" " class="footer-directorAndActor" ></a>
                        </div>
                        <div class="footer-grid1-right">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&ACTOR=Emma Stone">
                                Emma Stone</a>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="footer-grid1">
                        <div class="footer-grid1-left">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&ACTOR=Anne Hathaway">
                                <img src="<%=request.getContextPath()%>/images/index/Anne Hathaway.jpg" alt=" " class="footer-directorAndActor" ></a>
                        </div>
                        <div class="footer-grid1-right">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&ACTOR=Anne Hathaway">
                                Anne Hathaway</a>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                </div>
                <div class="col-md-2 footer-grid">
                    <h4 class="b-log"><a><span>T</span>op <span>F</span>ive <span>M</span>ovies</a></h4>
                    <ul>
                        <c:forEach var="movieVO" items="${listTopFive}">
                            <li><a href="genre.html">${movieVO.moviename}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="clearfix"> </div>
            </div>
            <h3 class="text-center follow">Connect <span>Us</span></h3>
            <ul class="social-icons1 agileinfo">
                <li><a href="https://zh-tw.facebook.com/"><i class="fa fa-facebook"></i></a></li>
                <li><a href="https://www.youtube.com/"><i class="fa fa-youtube"></i></a></li>
                <li><a href="https://tw.linkedin.com/"><i class="fa fa-linkedin"></i></a></li>
                <li><a href="https://www.google.com/"><i class="fa fa-google"></i></a></li>
                <li><a href="https://github.com/"><i class="fa fa-github"></i></a></li>
            </ul>
        </div>
    </div>
    <div class="w3agile_footer_copy">
        <p>2021 Movies Hit. All rights reserved | Design by <a>CEA103G3</a></p>
    </div>
    <a href="#home" id="toTop" class="scroll" style="display: block;"> <span id="toTopHover" style="opacity: 1;"> </span></a>

<script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
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
				<script src="<%=request.getContextPath()%>/js/main.js"></script>
			<!-- //search-jQuery -->
			<script src="<%=request.getContextPath()%>/js/simplePlayer.js"></script>
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
		<script src="<%=request.getContextPath()%>/js/jquery.magnific-popup.js" type="text/javascript"></script>
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
<script src="<%=request.getContextPath()%>/js/easy-responsive-tabs.js"></script>
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
<link href="<%=request.getContextPath()%>/css/owl.carousel.css" rel="stylesheet" type="text/css" media="all">
<script src="<%=request.getContextPath()%>/js/owl.carousel.js"></script>
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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/move-top.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/easing.js"></script>

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
	<script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
<script>

var YTdeferred = jQuery.Deferred();

window.onYouTubeIframeAPIReady = function() {
	YTdeferred.resolve(window.YT);
};

(function( $ ) {

	$.ajaxSetup({
		cache: true
	});

	$.getScript( "https://www.youtube.com/iframe_api")
		.done(function( script, textStatus ) {
	});

	$.fn.simplePlayer = function() {

		var	video = $(this);

		var play = $('<div />', { id: 'play' }).hide();

		var defaults = {
				autoplay: 1,
				autohide: 1,
				border: 0,
				wmode: 'opaque',
				enablejsapi: 1,
				modestbranding: 1,
				version: 3,
				hl: 'en_US',
				rel: 0,
				showinfo: 0,
				hd: 1,
				iv_load_policy: 3 // add origin
			};

		// onYouTubeIframeAPIReady

		YTdeferred.done(function(YT) {
			play.appendTo( video ).fadeIn('slow');
		});

		function onPlayerStateChange(event) {
			if (event.data == YT.PlayerState.ENDED) {
				play.fadeIn(500);
			}
		}

		function onPlayerReady(event) {
			var replay = document.getElementById('play');
			replay.addEventListener('click', function() {
				player.playVideo();
			});
		}

		play.bind('click', function () {

			if ( !$('#player' ).length ) {

				$('<iframe />', {
					id: 'player',
					src: 'https://www.youtube.com/embed/' + video.data('video') + '?' + $.param(defaults)
				})
				.attr({ width: video.width(), height: video.height(), seamless: 'seamless' })
				.css('border', 'none')
				.appendTo( video );

				video.children('img').hide();

				$(this).css('background-image', 'url(play-button.png), url(' + video.children().attr('src') + ')').hide();
	
				player = new YT.Player('player', {events: {'onStateChange': onPlayerStateChange, 'onReady': onPlayerReady}});
			}

			$(this).hide();
		});

		return this;
	};
}( jQuery ));
</script>

 

</body>
</html>