<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.List"%>
<%@ page import="com.movie.model.*"%>
<%@ page import="com.comment.model.*"%>
<%@ page import="com.rating.model.*"%>
<%@ page import="com.expectation.model.*"%>
<%@ page import="java.sql.Date"%>
<%@ page import="com.mem.model.*"%>


<%
	MovieService movieSvc = new MovieService();	
	List<MovieVO> listTopFive = movieSvc.getTopFive();
	pageContext.setAttribute("listTopFive", listTopFive);
	
	
	List<MovieVO> latestMovie = movieSvc.getLatestMovie();
	pageContext.setAttribute("latestMovie", latestMovie);
	
	MovieVO movieVO = (MovieVO) request.getAttribute("movieVO"); //MovieServlet.java(Concroller), �s�Jreq��movieVO����
	RatingVO ratingCount = (RatingVO) request.getAttribute("ratingCount");
	ExpectationVO expectationCount = (ExpectationVO)request.getAttribute("expectationCount");
	
	java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
	pageContext.setAttribute("today", today);
	
// 	int memberNumber = 9; //��ɭn�����qsession��memVO�X��
// 	pageContext.setAttribute("memberNumber", memberNumber);

MemVO memVO = (MemVO) session.getAttribute("memVO");
if (memVO == null){
	memVO = new MemVO();
	memVO.setMember_no(999);
}
pageContext.setAttribute("memVO", memVO);
%>
<%-- <jsp:useBean id="memVO" scope="session" type="com.mem.model.MemVO" /> --%>
<%-- <jsp:useBean id="listComments_ByMovieno" scope="request" type="java.util.Set<CommentVO>" /> --%>
<%-- <jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" /> --%>
<!DOCTYPE html>
<html>
<head>
<title>List One Movie</title>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>

<script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>

<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<style>
#chart{
  width:50px;
  height:50px;
}
#s1:hover { 
 color:#24BCE3 !important;                         
 cursor: pointer; 
 transform:scale(1.2,1.2);      
}
#s2:hover { 
 color:#41A2E6 !important;                         
 cursor: pointer; 
 transform:scale(1.2,1.2);      
}
#s3:hover { 
 color:#7F6CEE !important;                         
 cursor: pointer; 
 transform:scale(1.2,1.2);      
}
#s4:hover { 
 color:#B63DF6 !important;                         
 cursor: pointer;  
 transform:scale(1.2,1.2);     
}
#s5:hover { 
 color:#F407FE !important;                         
 cursor: pointer;  
 transform:scale(1.2,1.2);     
}
#t1:hover { 
 color:#A5C4FC !important;                         
 cursor: pointer;
 transform:scale(1.2,1.2);       
}
#t2:hover { 
 color:#fbc2eb !important;                         
 cursor: pointer;
 transform:scale(1.2,1.2);       
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
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<h1><a href="<%=request.getContextPath()%>/index.jsp"><span>M</span>ovies <span>H</span>it</a></h1>
					</div>
					<!-- navbar-header -->
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav">
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">�|���M�� <b class="caret"></b></a>
                                    <ul class="dropdown-menu multi-column columns-2">
                                        <li>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="<%=request.getContextPath()%>/backend/mem/select_page.jsp">�|���n�J</a></li>
                                                    <li><a href="genre.html">�ӽз|��</a></li>
                                                    <li><a href="genre.html">�q������</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="horror.html">���ά���</a></li>
                                                    <li><a href="genre.html">�|���A��</a></li>
                                                    <li><a href="genre.html">�|��QA</a></li>
                                                </ul>
                                            </div>
<!--                                             <div class="clearfix"></div> -->
                                        </li>
                                    </ul>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">�q�v����<b class="caret"></b></a>
                                    <ul class="dropdown-menu multi-column columns-3">
                                        <li>
                                            <div class="col-sm-4">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="<%=request.getContextPath()%>/front-end/movie/select_movie_page.jsp">�j�M�q�v</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�ʧ@��">�ʧ@��</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�@����">�@����</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�Ǹo��">�Ǹo��</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=���Ƥ�">���Ƥ�</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�߼@��">�߼@��</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�ʵe��">�ʵe��</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-4">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="<%=request.getContextPath()%>/front-end/movie/listAllMovie.jsp">�Ҧ��q�v</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�_�I��">�_�I��</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�Ԫ���">�Ԫ���</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=ĵ���">ĵ���</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�宪��">�宪��</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�R����">�R����</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=���֤�">���֤�</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-4">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">���N�v�]</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=��ۤ�">��ۤ�</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�v�֤�">�v�֤�</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�_�ۤ�">�_�ۤ�</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�a�ä�">�a�ä�</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=������">������</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�q�R�@">�q�R�@</a></li>
                                                </ul>
                                            </div>
                                            <div class="clearfix"></div>
                                        </li>
                                    </ul>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">�q�v����<b class="caret"></b></a>
                                    <ul class="dropdown-menu multi-column columns-2">
                                        <li>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="<%=request.getContextPath()%>/front-end/comment/select_comment_page.jsp">�j�M����</a></li>
                                                    <li><a href="genre.html">����</a></li>
                                                </ul>
                                            </div>
                                        <li>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="<%=request.getContextPath()%>/front-end/comment/listAllComment.jsp">�Ҧ�����</a></li>
                                                    <li><a href="genre.html">�Sԣ�n��</a></li>
                                                </ul>
                                            </div>
                                        <li>
                                            <div class="clearfix"></div>
                                        </li>
                                    </ul>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">���γ��<b class="caret"></b></a>
                                    <ul class="dropdown-menu multi-column columns-2">
                                        <li>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">�j�M����</a></li>
                                                    <li><a href="genre.html">�ֳt����</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">�j�M����</a></li>
                                                    <li><a href="genre.html">�ֳt����</a></li>
                                                </ul>
                                            </div>
                                            <div class="clearfix"></div>
                                        </li>
                                    </ul>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">�Q�װ�<b class="caret"></b></a>
                                    <ul class="dropdown-menu multi-column columns-2">
                                        <li>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">�Q��ԣ</a></li>
                                                    <li><a href="genre.html">�Q�קA</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">�Q��ԣ</a></li>
                                                    <li><a href="genre.html">�Q�קA</a></li>
                                                </ul>
                                            </div>
                                            <div class="clearfix"></div>
                                        </li>
                                    </ul>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">�\��<b class="caret"></b></a>
                                    <ul class="dropdown-menu multi-column columns-2">
                                        <li>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">�n�Yԣ</a></li>
                                                    <li><a href="genre.html">�Y�˧a</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-6">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">�n�Yԣ</a></li>
                                                    <li><a href="genre.html">�Y�˧a</a></li>
                                                </ul>
                                            </div>
                                            <div class="clearfix"></div>
                                        </li>
                                    </ul>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">���i<b class="caret"></b></a>
                                    <ul class="dropdown-menu multi-column columns-1">
                                        <li>
                                            <div class="col-sm-12">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">�v�����i</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-12">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">�v������</a></li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-12">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="genre.html">�X�@�٦�</a></li>
                                                </ul>
                                            </div>
                                            <div class="clearfix"></div>
                                        </li>
                                    </ul>
                                </li>
<!--                                 <li class="active"><a href="index.html">�v������</a></li> -->
                                <li><img  class="media-object" src="${pageContext.request.contextPath}/mem/mem.do?action=view_memPic&member_no=${memVO.member_no}" 
                                style="border-radius:50%; width:50px; height:50px;"></li>
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
								<input type="text" name="MOVIE_NAME" value="" placeholder="�п�J�q�v�W��" onkeydown="if (event.keyCode == 13) sendMessage();">
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
									<li><i class="fa fa-phone" aria-hidden="true"></i> (+886) 0912 345 678 ${memVO.member_no}</li>
									<li><a href="#" class="login"  data-toggle="modal" data-target="#myModal4">�n�J</a></li>
									<li><a href="#" class="login reg"  data-toggle="modal" data-target="#myModal5">���U</a></li>
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
				            <div class="inner-agile-w3l-part-head">
					            <h3 class="w3l-inner-h-title">${movieVO.moviename}</h3>
								<p class="w3ls_head_para"></p>
							</div>
							   <div class="latest-news-agile-info">
								   <div class="col-md-8 latest-news-agile-left-content">
											<div class="single video_agile_player">
												 <div class="video-grid-single-page-agileits"> 
													<a class="w3_play_icon" href="#small-dialog">
	                            						<img src="${pageContext.request.contextPath}/movie/DBGifReader2.do?movieno=${movieVO.movieno}" 
	                            						alt="" class="img-responsive" title="�I���[��i${movieVO.moviename}�j�̷s�w�i" /> 
 	                       							</a>
 	                       						</div>
<!-- 										            <div class="video-grid-single-page-agileits"> -->
<%-- 														<div data-video="${movieVO.embed}" id="video"> <img src="${pageContext.request.contextPath}/movie/DBGifReader2.do?movieno=${movieVO.movieno}" alt="" > </div> --%>
<!-- 													</div> -->
													 <h4>Official Trailer | ${movieVO.actor}</h4>
													 <c:if test="${today.before(movieVO.offdate)}">
													 	<c:if test="${today.after(movieVO.premiredate)}">
													 		<tr>
																<td><span style="color:#524066; font-weight:1000; font-size:30px;">����:&emsp;</span></td>
																<td><input type="hidden" name="rating" value="" id="con"/>
																	<i class="fa fa-star fa-2x all-star" id="s1" style="color:gray"></i>
																	<i class="fa fa-star fa-2x all-star" id="s2" style="color:gray"></i>
																	<i class="fa fa-star fa-2x all-star" id="s3" style="color:gray"></i>
																	<i class="fa fa-star fa-2x all-star" id="s4" style="color:gray"></i>
																	<i class="fa fa-star fa-2x all-star" id="s5" style="color:gray"></i>
																</td>
													 		</tr>
														 </c:if>
													
														 <c:if test="${today.before(movieVO.premiredate)}">													 
															 <tr>
																<td><span style="color:#524066; font-weight:1000; font-size:30px;">���ݫ�:&emsp;</span></td>
																	<i class="fa fa-thumbs-up fa-2x thumbs" id="t1" style="color:gray"></i>&ensp;
																	<i class="fa fa-thumbs-down fa-2x thumbs" id="t2" style="color:gray"></i>
															 </tr>
													 	</c:if>
													 </c:if>
										    </div>
									    

<jsp:include page ="listComments_ByMovieno.jsp"/>	

							
	<div class="col-md-4 latest-news-agile-right-content">
			<div class="video-grid-single-page-agileits">
				<img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}"
					alt="" class="img-responsive">
			</div>
			<div class="player-text side-bar-info">
				<p class="fexi_header">${movieVO.moviename}</p>
				<p class="fexi_header_para">
					<span>�ɺt<label>:</label></span>${movieVO.director}
				</p>
				<div class="clearfix">
					<p class="fexi_header_para">
						<span class="conjuring_w3">�t��<label>:</label></span>
						${movieVO.actor}
					</p>
					<p class="fexi_header_para">
						<span>�q�v����<label>:</label></span>${movieVO.category}
					</p>
					<p class="fexi_header_para">
						<span>�W�M���<label>:</label></span>
						<fmt:formatDate value="${movieVO.premiredate}"
							pattern="yyyy-MM-dd" />
					</p>
					<p class="fexi_header_para">
						<span>�U�M���<label>:</label></span>
						<fmt:formatDate value="${movieVO.offdate}" pattern="yyyy-MM-dd" />
					</p>
					<p class="fexi_header_para">
						<span>����<label>:</label></span>
						<c:choose>
							<c:when test="${((movieVO.length)/60)<1}">
								<td>${movieVO.length}����</td>
							</c:when>
							<c:when test="${(((movieVO.length)/60)%1)==0}">
								<td><fmt:formatNumber type="number"
										value="${((movieVO.length)-(movieVO.length%60))/60}" />�p��</td>
							</c:when>
							<c:when test="${((movieVO.length)/60)>1}">
								<td><fmt:formatNumber type="number"
										value="${((movieVO.length)-(movieVO.length%60))/60}" />�p��<fmt:formatNumber
										type="number" value="${movieVO.length%60}" />����</td>
							</c:when>
							<c:otherwise>
								<td>�L�Įɶ�</td>
							</c:otherwise>
						</c:choose>
					</p>
					<p class="fexi_header_para">
						<span>�q�v����<label>:</label></span>
						<c:choose>
							<c:when test="${movieVO.grade.equals('0')}">
								<td>���M��</td>
							</c:when>
							<c:when test="${movieVO.grade.equals('1')}">
								<td>�O�@��</td>
							</c:when>
							<c:when test="${movieVO.grade.equals('2')}">
								<td>���ɯ�</td>
							</c:when>
							<c:when test="${movieVO.grade.equals('3')}">
								<td>�����</td>
							</c:when>
							<c:otherwise>
								<td>�|������</td>
							</c:otherwise>
						</c:choose>
					</p>
					<p class="fexi_header_para">
						<span>�q�v���A<label>:</label></span>
						<c:choose>
							<c:when test="${movieVO.status.equals('0')}">
								<td>�W�M��</td>
							</c:when>
							<c:when test="${movieVO.status.equals('1')}">
								<td>���W�M</td>
							</c:when>
							<c:when test="${movieVO.status.equals('2')}">
								<td>�w�U��</td>
							</c:when>
							<c:otherwise>
								<td>�L�Ī��A</td>
							</c:otherwise>
						</c:choose>
					</p>
					
					<p class="fexi_header_para fexi_header_para1">
						<span>�q�v����<label>:</label></span> 
					</p>
					<div id="ratingValue" style="display:none;">${movieVO.rating}</div>
					<p id="rating" class="fexi_header_para fexi_header_para1"> </p>
					<p id="noRating" class="fexi_header_para "></p>

					<p class="fexi_header_para ">
						<span>�q�v���ݫ�<label>:</label></span>
					</p>
					<div id="expectationValue" style="display:none;">${movieVO.expectation}</div>
					<p id="expectation" class="fexi_header_para ">
					</p>
					<p id="noExpectation" class="fexi_header_para "></p>
			</div>
			
			</div>
			<div class="clearfix">
				<div class="booking-form">
					<div class="form-header">
						<h1>�q��</h1>
					</div>
					<form>
						<div class="form-group">
							<span class="form-label">�q�v</span> <select class="form-control">
							<c:forEach var="movieVO" items="${movieSvc.all}">
								<option value="${movieVO.movieno}" ${(commentVO.movieno==movieVO.movieno)? 'selected':'' } >${movieVO.moviename} 
 							</c:forEach> 
							</select> <span class="select-arrow"></span>
						</div>
						<div class="form-group">
							<span class="form-label">����</span> <select class="form-control">
								<option>�����@</option>
								<option>�����G</option>
								<option>�����T</option>
								<option>�����|</option>
								<option>������</option>
							</select> <span class="select-arrow"></span>
						</div>
						<div class="form-group">
							<span class="form-label">��M�ɶ�</span> <input class="form-control"
								type="datetime-local" required>
						</div>
						<div class="form-btn">
							<button class="submit-btn">Book Now</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="clearfix"></div>
 	</div> <!--include latest-news-agile-info ����������-->

	</div><!--include agile_featured_movies ����������-->
	</div><!--include w3_content_agilleinfo_inner ����������-->
	<!--//content-inner-section-->

	<!--/footer-bottom -->
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
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2017" title="Release 2017">2017--${openModal}--</a></li>
                    </ul>
                </div>
                <div class="col-md-2 footer-grid">
                    <h4 class="b-log"><a><span>D</span>irector</a></h4>
                    <div class="footer-grid1">
                        <div class="footer-grid1-left">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&DIRECTOR=Steven Spielberg">
                                <img src="<%=request.getContextPath()%>/images/index/Steven Spielberg.jpg" alt=" " width="40px" height="50px"></a>
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
                                <img src="<%=request.getContextPath()%>/images/index/Michael Bay.jpg" alt=" " width="40px" height="50px"></a>
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
                                <img src="<%=request.getContextPath()%>/images/index/James Cameron.jpg" alt=" " width="40px" height="50px"></a>
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
                                <img src="<%=request.getContextPath()%>/images/index/Christopher Nolan.jpg" alt=" " width="40px" height="50px"></a>
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
                                <img src="<%=request.getContextPath()%>/images/index/Leonardo DiCaprio.jpg" alt=" " width="40px" height="50px"></a>
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
                                <img src="<%=request.getContextPath()%>/images/index/Tom Cruise.jpg" alt=" " width="40px" height="50px"></a>
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
                                <img src="<%=request.getContextPath()%>/images/index/Emma Stone.jpg" alt=" " width="40px" height="50px"></a>
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
                                <img src="<%=request.getContextPath()%>/images/index/Anne Hathaway.jpg" alt=" " width="40px" height="50px"></a>
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







<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
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
			<script src="http://localhost:8081/CEA103G3_Work/js/simplePlayer.js"></script>
<%-- 			<script src="<%=request.getContextPath()%>/js/simplePlayer.js"></script> --%>
<%-- 			<%System.out.print(request.getContextPath() + "/js/simplePlayer.js") %> --%>
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
			<script>
				$("document").ready(function() {
					$("#video6").simplePlayer();
				});
			</script>

			<!-- pop-up-box -->  
		<script src="<%=request.getContextPath()%>/js/jquery.magnific-popup.js" type="text/javascript"></script>
	<!--//pop-up-box -->
	<div id="small-dialog" class="mfp-hide">
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
$(document).ready(drawPieChart);


function drawPieChart() {
	var canvas = document.createElement('canvas');
	canvas.id     = "chart";
	canvas.style.width  = 50;
	canvas.style.height = 50;
	canvas.style.zIndex   = 99;
	if(${movieVO.expectation} != 0){
		$("#expectation").html("");//���N�e���M�� �A�e�ϼh
		$("#expectation").append("<td><fmt:formatNumber type="number" value="${movieVO.expectation*100}"/> % �Q��</td>"+"<td> (�w�� <fmt:formatNumber type="number" value="  ${expectationCount.expectation}"/> �H�벼)</td>").append(canvas);
		var ctx = document.getElementById("chart").getContext('2d');
		var chart = new Chart(ctx, {
			type: 'pie',
			data: {
				labels: ["�Q��", "���Q��"],
				datasets: [{
				label: '# of Votes',
				data: [${movieVO.expectation*100},100-(${movieVO.expectation*100})],
				backgroundColor: [
					'rgba(252,157,153,1)',
					'rgba(249,204,173,1)',
				],
				borderColor: [
					'rgba(252,157,153,1.5)',
					'rgba(249,204,173,1.5)',
				],
				borderWidth: 1
				}]
			} 
		});
	}else{
		$("#noExpectation").text("�|�L���ݫ�");
	}
}
	


function thumbsUpDrawPieChart(newExpectation,countExpectation) {
	
	let nowExpectation = Math.round(newExpectation*100);
	let totalExpectation = countExpectation;
	
	var canvas = document.createElement('canvas');
	canvas.id     = "chart";
	canvas.style.width  = 50;
	canvas.style.height = 50;
	canvas.style.zIndex   = 99;
	if(totalExpectation != 0){
		$("#expectation").html("");//���N�e���M�� �A�e�ϼh
		$("#noExpectation").html("");
		$("#expectation").append("<td> "+nowExpectation+"% �Q��  </td>"+"<td> (�w�� "+ totalExpectation + " �H�벼)</td>").append(canvas);
		var ctx = document.getElementById("chart").getContext('2d');
		var chart = new Chart(ctx, {
			type: 'pie',
			data: {
				labels: ["�Q��", "���Q��"],
				datasets: [{
				label: '# of Votes',
				data: [newExpectation*100 , 100-(newExpectation*100)],
				backgroundColor: [
					'rgba(252,157,153,1)',
					'rgba(249,204,173,1)',
				],
				borderColor: [
					'rgba(252,157,153,1.5)',
					'rgba(249,204,173,1.5)',
				],
				borderWidth: 1
				}]
			} 
		});
	}else{
			$("#noExpectation").text("�|�L���ݫ�");
		}
	}
	
	
function thumbsDownDrawPieChart(newExpectation, countExpectation) {
	
	let nowExpectation = Math.round(newExpectation*100);
	let totalExpectation = countExpectation;
	
	var canvas = document.createElement('canvas');
	canvas.id     = "chart";
	canvas.style.width  = 50;
	canvas.style.height = 50;
	canvas.style.zIndex   = 99;
	if(totalExpectation != 0){
		$("#expectation").html("");//���N�e���M�� �A�e�ϼh
		$("#noExpectation").html("");
		$("#expectation").append("<td> "+nowExpectation+"% �Q��  </td>"+"<td> (�w�� "+ totalExpectation + " �H�벼)</td>").append(canvas);
		var ctx = document.getElementById("chart").getContext('2d');
		var chart = new Chart(ctx, {
			type: 'pie',
			data: {
				labels: ["�Q��", "���Q��"],
				datasets: [{
				label: '# of Votes',
				data: [newExpectation*100 , 100-(newExpectation*100)],
				backgroundColor: [
					'rgba(252,157,153,1)',
					'rgba(249,204,173,1)',
				],
				borderColor: [
					'rgba(252,157,153,1.5)',
					'rgba(249,204,173,1.5)',
				],
				borderWidth: 1
				}]
			} 
		});
	}else{
			$("#noExpectation").text("�|�L���ݫ�");
		}
	}
	
	
$(document).ready(function(){
	$("#t1").click(function(){
		if(${memVO.member_no}==999){
			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: '�Х��n�J',
				  showConfirmButton: false,
				  timer: 1500
				})
				
			setTimeout(function(){
				document.location.href="<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp";
			}, 1500);
		}else{
			$(".thumbs").css("color","gray");
			$("#t1").css("color","#4194CA");	
			$("#t2").css("color","gray");
			$("#con1").val("1.0");
			
			let movieno = "${movieVO.movieno}";
			let memberno = "${memVO.member_no}";
			let expectation = "1.0";
			
			$.ajax({
				url:"<%=request.getContextPath()%>/expectation/expectation.do?action=insertOrUpdate",
				data:{
					"memberno":memberno,	
					"movieno":movieno,
					"expectation":expectation		   
				},
				type:"POST",
				success:function(json){
					let jsonobj = JSON.parse(json);
					console.log("json = " + json);
					console.log(jsonobj);
					let newExpectation = jsonobj.newExpectation;
					let countExpectation = jsonobj.countExpectation;
					thumbsUpDrawPieChart(newExpectation , countExpectation);
					
				}
			 });
			
			Swal.fire({
	            position: "center",
	            icon: "success",
	            title: "�ڦn����RRRRR",
	            showConfirmButton: false,
	            timer: 5000,
				width: 600,
				padding: '3em',
				background: '#fff url(/images/trees.png)',
				backdrop: `
				  rgba(0,0,0,0.4)
				  url("<%=request.getContextPath()%>/images/gif/hotBoy.gif")
				  left center
				  no-repeat
				`
	        });
			 $("#leaveBtn").show();
		}
	})
	
	$("#t2").click(function(){
		if(${memVO.member_no}==999){
			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: '�Х��n�J',
				  showConfirmButton: false,
				  timer: 1500
				})
				
			setTimeout(function(){
				document.location.href="<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp";
			}, 1500);
		}else{
			$(".thumbs").css("color","gray");
			$("#t2").css("color","#D66B75");
			$("#t1").css("color","gray");
			$("#con1").val("0.0");
			
			let movieno = "${movieVO.movieno}";
			let memberno = "${memVO.member_no}";
			let expectation = "0.0";
			
			$.ajax({
				url:"<%=request.getContextPath()%>/expectation/expectation.do?action=insertOrUpdate",
				data:{
					"memberno":memberno,	
					"movieno":movieno,
					"expectation":expectation		   
				},
				type:"POST",
				success:function(json){
					let jsonobj = JSON.parse(json);
					console.log("json = " + json);
					console.log(jsonobj);
					let newExpectation = jsonobj.newExpectation;
					let countExpectation = jsonobj.countExpectation;
					thumbsDownDrawPieChart(newExpectation , countExpectation);
				}
			 });
			
			Swal.fire({
	            position: "center",
	            icon: "success",
	            title: "�ڦn����RRRRR",
	            showConfirmButton: false,
	            timer: 5000,
				width: 600,
				padding: '3em',
				background: '#fff url(/images/trees.png)',
				backdrop: `
				  rgba(0,0,0,0.4)
				  url("https://zodiac.tw/uploads/1455625798-jI266.jpg")
				  left center
				  no-repeat
				`
	        });
			 $("#leaveBtn").show();
		}
	})
})

</script>	
<script>
$(document).ready(initialDrawRating);

function initialDrawRating() {
	if($("#ratingValue").text() <= 0){
		$("#noRating").text("�|�L����");
	}else if($("#ratingValue").text() < 1.0){
// 		$("#rating").html("");
		$("#rating").append(				
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${movieVO.rating} ��</td>"+
			"<td> (�w��<fmt:formatNumber type="number" value=" ${ratingCount.rating}"/> �H�벼)</td>"
		);
	}else if($("#ratingValue").text() < 2.0){
		$(".all-star").css("color","gray");
// 		$("#s1").css("color","yellow");
// 		$("#rating").html("");
		$("#rating").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${movieVO.rating} ��</td>"+
			"<td> (�w��<fmt:formatNumber type="number" value=" ${ratingCount.rating}"/> �H�벼)</td>"
		);
	}else if($("#ratingValue").text() < 3.0){
		$(".all-star").css("color","gray");
// 		$("#s1,#s2").css("color","yellow");
// 		$("#rating").html("");
		$("#rating").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${movieVO.rating} ��</td>"+
			"<td> (�w��<fmt:formatNumber type="number" value=" ${ratingCount.rating}"/> �H�벼)</td>"
		);
	}else if($("#ratingValue").text() < 4.0){
		$(".all-star").css("color","gray");
// 		$("#s1,#s2,#s3").css("color","yellow");
// 		$("#rating").html("");
		$("#rating").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${movieVO.rating} ��</td>"+
			"<td> (�w��<fmt:formatNumber type="number" value=" ${ratingCount.rating}"/> �H�벼)</td>"
		); 
	}else if($("#ratingValue").text() < 5.0){
		$(".all-star").css("color","gray");
// 		$("#s1,#s2,#s3,#s4").css("color","yellow");
// 		$("#rating").html("");
		$("#rating").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${movieVO.rating} ��</td>"+
			"<td> (�w��<fmt:formatNumber type="number" value=" ${ratingCount.rating}"/> �H�벼)</td>"
		);
	}else if($("#ratingValue").text() === "5.0"){
		$(".all-star").css("color","gray");
// 		$("#s1,#s2,#s3,#s4,#s5").css("color","yellow");
// 		$("#rating").html("");
		$("#rating").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${movieVO.rating} ��</td>"+
			"<td> (�w��<fmt:formatNumber type="number" value=" ${ratingCount.rating}"/> �H�벼)</td>"
		);
	}else{
		$("#noRating").text("���~����");
	}
}


// console.log("ratingValue" + $("#ratingValue").text());
function drawRating(newRating,countRating) {
	console.log("newRating="+newRating);
	console.log("countRating="+countRating);
	let nowRating = newRating;
	let totalRating = countRating;
	if(totalRating <= 0){
		$("#noRating").text("�|�L����");
	}else if(newRating < 1.0){
		$("#rating").html("");
		$("#noRating").html("");
		$("#rating").append(				
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> "+nowRating+" ��</td>"+
			"<td> (�w�� "+totalRating+" �H����)</td>"
		);
	}else if(newRating < 2.0){
		$("#rating").html("");
		$("#noRating").html("");
		$("#rating").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> "+nowRating+" ��</td>"+
			"<td> (�w�� "+totalRating+" �H����)</td>"
		);
	}else if(newRating < 3.0){
		$("#rating").html("");
		$("#noRating").html("");
		$("#rating").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> "+nowRating+" ��</td>"+
			"<td> (�w�� "+totalRating+" �H����)</td>"
		);
	}else if(newRating < 4.0){
		$("#rating").html("");
		$("#noRating").html("");
		$("#rating").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> "+nowRating+" ��</td>"+
			"<td> (�w�� "+totalRating+" �H����)</td>"
		);
	}else if(newRating < 5.0){
		$("#rating").html("");
		$("#noRating").html("");
		$("#rating").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> "+nowRating+" ��</td>"+
			"<td> (�w�� "+totalRating+" �H����)</td>"
		);
	}else if(newRating == 5.0){
		$("#rating").html("");
		$("#noRating").html("");
		$("#rating").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> "+nowRating+" ��</td>"+
			"<td> (�w�� "+totalRating+" �H����)</td>"
		);
	}else{
		$("#noRating").text("���~����");
	}
}

$(document).ready(function(){
	$("#s1").click(function(){
		if(${memVO.member_no}==999){
			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: '�Х��n�J',
				  showConfirmButton: false,
				  timer: 1500
				})
				
			setTimeout(function(){
				document.location.href="<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp";
			}, 1500);
		}else{
			$(".all-star").css("color","gray");
			$("#s1").css("color","yellow");
			$("#con").val("1.0");
			
			let movieno = "${movieVO.movieno}";
			let memberno = "${memVO.member_no}";
			let rating = "1.0";
			
			$.ajax({
				url:"<%=request.getContextPath()%>/rating/rating.do?action=insertOrUpdate",
				data:{
					"memberno":memberno,	
					"movieno":movieno,
					"rating":rating		   
				},
				type:"POST",
				success:function(json){
					let jsonobj = JSON.parse(json);
					let newRating = jsonobj.newRating;
					let countRating = jsonobj.countRating;
					$('#ratingValue').text(newRating);
					drawRating(newRating,countRating); 
				}
			 });
			
			Swal.fire({
	            position: "center",
	            icon: "success",
	            title: "�@�P����",
	            showConfirmButton: false,
	            timer: 3000,
				width: 600,
				padding: '3em',
				background: '#fff url(/images/trees.png)',
				backdrop: `
				  rgba(0,0,0,0.4)
				  url("<%=request.getContextPath()%>/images/gif/11.gif")
				  left center
				  no-repeat
				`
	        });
			 $("#leaveBtn").show();
		}
	})
	
	$("#s2").click(function(){
		if(${memVO.member_no}==999){
			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: '�Х��n�J',
				  showConfirmButton: false,
				  timer: 1500
				})
				
			setTimeout(function(){
				document.location.href="<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp";
			}, 1500);
		}else{
			$(".all-star").css("color","gray");
			$("#s1,#s2").css("color","yellow");
			$("#con").val("2.0");
			
			let movieno = "${movieVO.movieno}";
			let memberno = "${memVO.member_no}";
			let rating = "2.0";
			
			$.ajax({
				url:"<%=request.getContextPath()%>/rating/rating.do?action=insertOrUpdate",
				data:{
					"memberno":memberno,	
					"movieno":movieno,
					"rating":rating		   
				},
				type:"POST",
				success:function(json){
					let jsonobj = JSON.parse(json);
					let newRating = jsonobj.newRating;
					let countRating = jsonobj.countRating;
					$('#ratingValue').text(newRating);
					drawRating(newRating,countRating); 
				}
			 });
			
			Swal.fire({
	            position: "center",
	            icon: "success",
	            title: "�G�P�Q�Q",
	            showConfirmButton: false,
	            timer: 3000,
				width: 600,
				padding: '3em',
				background: '#fff url(/images/trees.png)',
				backdrop: `
				  rgba(0,0,0,0.4)
				  url("https://memes.tw/user-maker-thumbnail/a1c21b379244a82960756bf4f8def57a.gif")
				  left center
				  no-repeat
				`
	        });
			 $("#leaveBtn").show();
		}
	})
	
	$("#s3").click(function(){
		if(${memVO.member_no}==999){
			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: '�Х��n�J',
				  showConfirmButton: false,
				  timer: 1500
				})
				
			setTimeout(function(){
				document.location.href="<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp";
			}, 1500);
		}else{
			$(".all-star").css("color","gray");
			$("#s1,#s2,#s3").css("color","yellow");
			$("#con").val("3.0");
			
			let movieno = "${movieVO.movieno}";
			let memberno = "${memVO.member_no}";
			let rating = "3.0";
			
			$.ajax({
				url:"<%=request.getContextPath()%>/rating/rating.do?action=insertOrUpdate",
				data:{
					"memberno":memberno,	
					"movieno":movieno,
					"rating":rating		   
				},
				type:"POST",
				success:function(json){
					let jsonobj = JSON.parse(json);
					let newRating = jsonobj.newRating;
					let countRating = jsonobj.countRating;
					$('#ratingValue').text(newRating);
					drawRating(newRating,countRating); 
					
				}
			 });
			
			Swal.fire({
	            position: "center",
	            icon: "success",
	            title: "�T�P�l�l",
	            showConfirmButton: false,
	            timer: 3000,
				width: 600,
				padding: '3em',
				background: '#fff url(/images/trees.png)',
				backdrop: `
				  rgba(0,0,0,0.4)
				  url("https://64.media.tumblr.com/8210fd413c5ce209678ef82d65731443/tumblr_mjphnqLpNy1s5jjtzo1_400.gifv")
				  left top
				  no-repeat
				`
	        });
			 $("#leaveBtn").show();
		}
	})
	
	$("#s4").click(function(){
		if(${memVO.member_no}==999){
			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: '�Х��n�J',
				  showConfirmButton: false,
				  timer: 1500
				})
				
			setTimeout(function(){
				document.location.href="<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp";
			}, 1500);
		}else{
			$(".all-star").css("color","gray");
			$("#s1,#s2,#s3,#s4").css("color","yellow");
			$("#con").val("4.0");
			
			let movieno = "${movieVO.movieno}";
			let memberno = "${memVO.member_no}";
			let rating = "4.0";
			
			$.ajax({
				url:"<%=request.getContextPath()%>/rating/rating.do?action=insertOrUpdate",
				data:{
					"memberno":memberno,	
					"movieno":movieno,
					"rating":rating		   
				},
				type:"POST",
				success:function(json){
					let jsonobj = JSON.parse(json);
					let newRating = jsonobj.newRating;
					let countRating = jsonobj.countRating;
					$('#ratingValue').text(newRating);
					drawRating(newRating,countRating); 
				}
			 });
			
			Swal.fire({
	            position: "center",
	            icon: "success",
	            title: "�|�P�t�t",
	            showConfirmButton: false,
	            timer: 3000,
				width: 600,
				padding: '3em',
				background: '#fff url(/images/trees.png)',
				backdrop: `
				  rgba(0,0,0,0.4)
				  url("<%=request.getContextPath()%>/images/gif/yee.gif")
				  left top
				  no-repeat
				`
	        });
			 $("#leaveBtn").show();
		}
	})
	
	$("#s5").click(function(){
		if(${memVO.member_no}==999){
			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: '�Х��n�J',
				  showConfirmButton: false,
				  timer: 1500
				})
				
			setTimeout(function(){
				document.location.href="<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp";
			}, 1500);
		}else{
			$(".all-star").css("color","gray");
			$("#s1,#s2,#s3,#s4,#s5").css("color","yellow");
			$("#con").val("5.0");
			
			let movieno = "${movieVO.movieno}";
			let memberno = "${memVO.member_no}";
			let rating = "5.0";
			
			$.ajax({
				url:"<%=request.getContextPath()%>/rating/rating.do?action=insertOrUpdate",
				data:{
					"memberno":memberno,	
					"movieno":movieno,
					"rating":rating		   
				},
				type:"POST",
				success:function(json){
					let jsonobj = JSON.parse(json);
					let newRating = jsonobj.newRating;
					let countRating = jsonobj.countRating;
					$('#ratingValue').text(newRating);
					drawRating(newRating,countRating); 
				}
			 });
			
			Swal.fire({
	            position: "center",
	            icon: "success",
	            title: "���P�j�j",
	            showConfirmButton: false,
	            timer: 3000,
				width: 600,
				padding: '3em',
				background: '#fff url(/images/trees.png)',
				backdrop: `
				  rgba(123,123,123,0.4)
				  url("<%=request.getContextPath()%>/images/gif/2.gif")
				  left center
				  no-repeat
				`
	        });
			 $("#leaveBtn").show();
		}
	})
})
</script> 



</body>
</html>