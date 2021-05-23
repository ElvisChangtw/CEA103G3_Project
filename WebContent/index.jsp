<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.movie.model.*"%>
<%@ page import="com.comment.model.*"%>
<%@ page import="com.expectation.model.*"%>
<%@ page import="com.mem.model.*"%>

<%
	MovieService movieSvc = new MovieService();	
	List<MovieVO> inTheatersMovie = movieSvc.getInTheatersMovie();
	pageContext.setAttribute("inTheatersMovie", inTheatersMovie);
	
	MovieVO oneNewestinTheatersMovie = movieSvc.getOneNewestInTheatersMovie();
	pageContext.setAttribute("oneNewestinTheatersMovie", oneNewestinTheatersMovie);
	
	List<MovieVO> comingSoonMovie = movieSvc.getComingSoonMovie();
	pageContext.setAttribute("comingSoonMovie", comingSoonMovie);
	
	MovieVO oneNewestComingSoonMovie = movieSvc.getOneNewestComingSoonMovie();
	pageContext.setAttribute("oneNewestComingSoonMovie", oneNewestComingSoonMovie);
	
	List<MovieVO> allTopRatingInTheatersMovie = movieSvc.getAllTopRatingInTheatersMovie();
	pageContext.setAttribute("allTopRatingInTheatersMovie", allTopRatingInTheatersMovie);
	
	List<MovieVO> allTopExpectationComingSoonMovie = movieSvc.getAllTopExpectationComingSoonMovie();
	pageContext.setAttribute("allTopExpectationComingSoonMovie", allTopExpectationComingSoonMovie);
	
	List<MovieVO> listTopTen = movieSvc.getTopTen();
	pageContext.setAttribute("listTopTen", listTopTen);
	
	MovieVO bestMovie = movieSvc.getBestMovie();
	pageContext.setAttribute("bestMovie", bestMovie);
	
// 	List<MovieVO> list = movieSvc.getAll();
// 	pageContext.setAttribute("list", list);
	
	List<MovieVO> latestMovie = movieSvc.getLatestMovie();
	pageContext.setAttribute("latestMovie", latestMovie);
	
// 	List<MovieVO> listTopFive = movieSvc.getTopFive();
// 	pageContext.setAttribute("listTopFive", listTopFive);
	
	movieSvc.createMovieIdex();
	
	MemVO memVO = (MemVO) session.getAttribute("memVO");
	if(memVO == null){
// 		memVO = (new MemService()).getOneMem(99);
		memVO = new MemVO();
		memVO.setMember_no(99);
	}
	pageContext.setAttribute("memVO", memVO);
%>

<!DOCTYPE html>
<html>
<head>
    <title>MoviesHit</title>
    <!-- for-mobile-apps -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=big5" />
    <meta name="keywords" content="Movies Pro Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
    Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
    <script type="application/x-javascript">
        addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);

        function hideURLbar() { window.scrollTo(0, 1); }
    </script>
    <link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <!-- pop-up -->
    <link href="<%=request.getContextPath()%>/css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
    <!-- //pop-up -->
    <link href="<%=request.getContextPath()%>/css/easy-responsive-tabs.css" rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/zoomslider.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styleForMH.css" />
    <link href="<%=request.getContextPath()%>/css/font-awesome.css" rel="stylesheet">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/modernizr-2.6.2.min.js"></script>
    <!--/web-fonts-->
    <link href='//fonts.googleapis.com/css?family=Tangerine:400,700' rel='stylesheet' type='text/css'>
    <link href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900" rel="stylesheet">
    <link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    <!--//web-fonts-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
    
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styleForGroup.css">
<style>
	div.form-group>button.btn {
	    border-radius: 3px;
	}
	.chart .chart2{
		width:50px;
		height:50px;
	}
</style>


</head>

<body>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font color='red'>�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>


    <!--/main-header-->
    <!--/banner-section-->
    <div id="demo-1" data-zs-src='["<%=request.getContextPath()%>/images/1.jpg", "<%=request.getContextPath()%>/images/2.jpg", "<%=request.getContextPath()%>/images/3.jpg","<%=request.getContextPath()%>/images/4.jpg"]' data-zs-overlay="dots">    
        <div class="demo-inner-content">
            <!--/header-w3l-->
            <div class="header-w3-agileits" id="home">
                <div class="inner-header-agile">
                    <nav class="navbar navbar-default">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                            	<span class="sr-only">Toggle navigation</span>
                            	<span class="icon-bar"></span>
                            	<span class="icon-bar"></span>
                            	<span class="icon-bar"></span>
                            </button>
                            <h1><a href="<%=request.getContextPath()%>/index.jsp"><span>M</span>ovies<span>H</span>it
                            <img src="<%=request.getContextPath()%>/images/logo.png" width=40 height=40></a></h1>
                        </div>
                        <!-- navbar-header -->
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav">
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">�q�v����<b class="caret"></b></a>
                                    <ul class="dropdown-menu multi-column columns-3">
                                        <li>
                                             <div class="col-sm-4">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="<%=request.getContextPath()%>/front-end/movie/listAllMovie.jsp">�Ҧ��q�v</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�_�I��">�_�I��</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�Ԫ���">�Ԫ���</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=ĵ���">ĵ���</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�宪��">�宪��</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�R����">�R����</a></li>
                                                    
                                                </ul>
                                            </div>
                                            <div class="col-sm-4">
                                                <ul class="multi-column-dropdown">
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
                                                    
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=��ۤ�">��ۤ�</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�v�֤�">�v�֤�</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=���֤�">���֤�</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�a�ä�">�a�ä�</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=������">������</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�q�R�@">�q�R�@</a></li>
                                                </ul>
                                            </div>
                                            <div class="clearfix"></div>
                                        </li>
                                    </ul>
                                </li>
                                
                                <li><a href="<%=request.getContextPath()%>/front-end/article/listAllArticle.jsp">�]�޽׾�</a></li>
                                <li><a href="<%=request.getContextPath()%>/front-end/group/group_front_page.jsp">���γ��</a></li>
                               	<li><a href="<%=request.getContextPath()%>/front-end/news/listAllNews.jsp">�̷s����</a></li>
<%--                                 <li class="active"><a href="<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp">�n�J/���U</a></li> --%>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">�|���M��<b class="caret"></b></a>
                                    <ul class="dropdown-menu multi-column columns-1">
                                        <li><a href="<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">�|������</a></li>
                                        <li><a href="<%=request.getContextPath()%>/front-end/mem/memberInfo.jsp">�|����T</a></li>
                                    </ul>
                                </li>
                            </ul>
                            
                        </div>
                        
                        <div class="clearfix"> </div>

                    </nav>
                    
                    <div class="w3ls_search">
						<div class="cd-main-header">
							<ul class="cd-header-buttons">
								<c:choose>
									<c:when test="${memVO.member_no == 99}">
										<li class="active rhs"><a id="login-btn"  href="<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp">�n�J</a></li>
									</c:when>
									<c:otherwise>
										<li class="active rhs">
												<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${memVO.member_no}" 
												id="${groupVO.group_no}-${memVO.member_no}" alt="�|�L�Ϥ�" width="60px;" height="60px" 
												style="border-radius:50%;" class="clickable" />
											<a id="welcome"> ${memVO.mb_name } &nbsp</a>
											<a id="logout-btn" href="#"> �n�X </a>
										</li>
									</c:otherwise>
								</c:choose>
								<li><a class="cd-search-trigger" href="#cd-search"> <span></span></a></li>
							</ul> <!-- cd-header-buttons -->
						</div>
						<div id="cd-search" class="cd-search">
							<form method="post" action="<%=request.getContextPath()%>/movie/movie.do" name="form1">
								<input id="search-context"  type="text" name="MOVIE_NAME" value="" placeholder="�п�J�q�v�W��" onkeydown="if (event.keyCode == 13) sendMessage();">
								<input type="hidden" name="action" value="listMovies_ByCompositeQuery">
							</form>
							<div id="search-results"class="container" >
							</div>
						</div>
						
					</div>
					
                </div>
            </div>
            <!--//header-w3l-->
            <!--/banner-info-->
            <div class="baner-info">
                <h3>�] <span>��</span> �q �v </h3>
                <h4>May the Force be with you.</h4>
                <a class="w3_play_icon1" href="#small-dialog">
                   	�[ �� �w �i
                </a>
            </div>
            <!--/banner-ingo-->
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
                    <li><a href="#" class="login" data-toggle="modal" data-target="#myModal4">�n�J</a></li>
                    <li><a href="#" class="login reg" data-toggle="modal" data-target="#myModal5">���U</a></li>
                </ul>
            </div>
        </div>
    </div>
    <!--//banner-bottom-->
    <!-- Modal1 -->
    <div class="modal fade" id="myModal4" tabindex="-1" role="dialog">
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
  
<!--    �q��+�峹�϶��}�l -->
   <section class="booking_area">
   	<div class="container-fluid">
   		<div class="row">
   		
   		 <!-- �q���}�l-->
   			<div class="col-sm-4">
		    	<div class="booking-form">
                	<div class="form-header">
                       <h1>�q��</h1>
                    </div>
                    <form>
                    	<div class="form-group">
                        	<span class="form-label">�q�v</span>
                        	<select class="form-control">
                        	<c:forEach var="movieVO" items="${inTheatersMovie}"> 
								<option value="${movieVO.movieno}">${movieVO.moviename} 
							</c:forEach> 
<!--                                <option>���q�p��</option> -->
<!--                                <option>�Y��ϴ�</option> -->
<!--                                <option>�P�ڤj�� �Ѧ�̪��U�_</option> -->
<!--                                <option>���l�u��</option> -->
<!--                                <option>���N�Ԥj�Ԫ���</option> -->
                            </select>
                            <span class="select-arrow"></span>
                        </div>
                        <div class="form-group">
                           <span class="form-label">����</span>
                           <select class="form-control">
                               <option>�����@</option>
                               <option>�����G</option>
                               <option>�����T</option>
                               <option>�����|</option>
                               <option>������</option>
                           </select>
                           <span class="select-arrow"></span>
                        </div>
                        <div class="form-group">
                           <span class="form-label">��M�ɶ�</span>
                           <input class="form-control" type="datetime-local" required>
                        </div>
                        <div class="form-btn">
                           <button class="submit-btn">Book Now</button>
                        </div>
                    </form>
            	</div>
   			</div>
   			<!-- �q������-->
			<!--�峹�}�l -->
   			<div class="col-sm-8">
				 <div class="container article-form">
                    <div class="article-table table-responsive">
                        <div class="table-header">
                            <h1>�����峹</h1>
                        </div>
                        <table class="table">
                            <thead class="thead-light">
                                <tr class="success">
                                    <th scope="col">#</th>
                                    <th scope="col">���D</th>
                                    <th scope="col">���e</th>
                                    <th scope="col">�o��ɶ�</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th scope="row">1</th>
                                    <td>ť���c�F�j���N���}��</td>
                                    <td>���}��</td>
                                    <td>2021-03-20 00:00</td>
                                </tr>
                                <tr>
                                    <th scope="row">2</th>
                                    <td>�A���W�l�n�n�ݳ�</td>
                                    <td>�G�ƫܷP�H�A�e�����u���C�t���]�ܨ��!</td>
                                    <td>2021-03-20 00:00</td>
                                </tr>
                                <tr>
                                    <th scope="row">3</th>
                                    <td>�ѯ઺�[��߱o</td>
                                    <td>�ڬݤ�����!!!</td>
                                    <td>2021-03-12 00:00</td>
                                </tr>
                                <tr>
                                    <th scope="row">4</th>
                                    <td>�s���P�����̷s����</td>
                                    <td>�ڷ|���A�A���ާA�b���̡AGOODLUCK!</td>
                                    <td>2021-03-12 00:00</td>
                                </tr>
                                <tr>
                                    <th scope="row">5</th>
                                    <td>��MOVIESHIT�����q��</td>
                                    <td>���x�e500�I�ơA�A�e�]����!</td>
                                    <td>2021-04-01 00:00</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>   				
   			</div>
   			<!-- �峹����-->
   		</div>
   	</div>
   </section>
	<!--�q��+�峹�϶����� -->
	
<nav class="navbar navbar-light" style="background-color: #75D9B5;">
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" name="form1" class="form-inline my-2 my-lg-0 composite-query">
		<div class="form-row">
			�j�M�q�v:&ensp;
			<div class="form-group col-2">
				 <input type="text" name="MOVIE_NAME" value="" class="form-control" placeholder="�п�J�q�v" size="10"><br>
			</div>&ensp;
			
			<div class="form-group col-2">
				<input type="text" name="DIRECTOR" value="" class="form-control" placeholder="�п�J�ɺt" size="10"><br>
			</div>&ensp;
	       
	       <div class="form-group col-2">
				<input type="text" name="ACTOR" value="" class="form-control" placeholder="�п�J�t��" size="10"><br>
			</div>&ensp;
	      
	       <div class="form-group col-2">
<!-- 				<input type="text" name="PREMIERE_DT" id="f_date1" class="form-control" placeholder="�п�J�[�v���" size="12"> -->
 		       <input type="text" name="OFF_DT" id="f_date2" class="form-control" placeholder="�п�J�[�v���" size="12"><br> 
			</div>&ensp;

			<div class="form-group col-2">
	       <select  name="category" class="form-control form-control-sm">
				<option value="">�п�ܹq�v����</option>
				<option value="�ʧ@��">�ʧ@��</option>
				<option value="�_�I��">�_�I��</option>
				<option value="��ۤ�">��ۤ�</option>
				<option value="�Ǹo��">�Ǹo��</option>
				<option value="ĵ���">ĵ���</option>
				<option value="�߼@��">�߼@��</option>
				<option value="�@����">�@����</option>
				<option value="�R����">�R����</option>
	       	</select><br>
	       	</div>&ensp;
	       	
<!-- 	       	<div class="form-group col-2"> -->
<!-- 	       	<select size="1" name="STATUS" class="form-control form-control-sm"> -->
<!-- 				<option value="">�п�ܹq�v���A</option> -->
<!-- 				<option value="0">�W�M��</option> -->
<!-- 				<option value="1">���W�M</option> -->
<!-- 				<option value="2">�w�U��</option> -->
<!--       		</select><br> -->
<!--     		</div>&ensp; -->
	       	
       		<div class="form-group col-2">
       		<select size="1" name="GRADE" class="form-control form-control-sm">
				<option value="">�п�ܹq�v����</option>
				<option value="0">���M��</option>
				<option value="1">�O�@��</option>
				<option value="2">���ɯ�</option>
				<option value="3">�����</option>
       		</select><br>
			</div>&ensp;
       		
       		<div class="form-group col-2">
       		<select size="1" name="RATING" class="form-control form-control-sm">
				<option value="">�������C��</option>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
      		</select><br>
       		</div>&ensp;
       		
       		<div class="form-group col-2">
       		<select size="1" name="EXPECTATION" class="form-control form-control-sm">
				<option value="">���ݫפ��C��</option>
				<option value="0.2">20%</option>
				<option value="0.4">40%</option>
				<option value="0.6">60%</option>
				<option value="0.8">80%</option>
				<option value="0.9">90%</option>
				<option value="0.95">95%</option>
       		</select><br>
			</div>&ensp;
			
			<div class="form-group col-2">
				<input type="hidden" name="action" value="listMovies_ByCompositeQuery">
		      	&ensp;<button class="btn btn-danger btn-sm" type="submit" value="�e�X">�j�M</button>
	      	</div>
		</div>
     </FORM>
</nav>


    <div class="modal fade" id="myModal5" tabindex="-1" role="dialog">
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
    <!--/content-inner-section-->
    <div class="w3_content_agilleinfo_inner">
        <div class="agile_featured_movies">
            <!--/agileinfo_tabs-->
            <div class="agileinfo_tabs">
                <!--/tab-section-->
                <div id="horizontalTab">
                    <ul class="resp-tabs-list">
                        <li style="font-size:20px;">�W�M��</li>
                        <li style="font-size:20px;">�Y�N�W�M</li>
                        <li style="font-size:20px;">�Ʀ�]</li>
                    </ul>
                           
                    <div class="resp-tabs-container">
                        <div class="tab1">
                            <div class="tab_movies_agileinfo">
                                <div class="w3_agile_featured_movies">
                                    
                                    <div class="col-md wthree_agile-movies_list">
                                    
                                    
                                    <c:forEach var="movieVO" items="${inTheatersMovie}">
                                        <div class="w3l-movie-gride-agile">
                                            <a href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}" class="hvr-sweep-to-bottom" style="width:100%;">
                                            <img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}" title="${movieVO.moviename}" class="img-responsive" alt=" " style="width:100%; height:230px;">
                                                <div class="w3l-action-icon">
                                                <i class="fa fa-play-circle-o" aria-hidden="true"></i></div>
                                            </a>
                                            <div class="mid-1 agileits_w3layouts_mid_1_home">
                                                <div class="w3l-movie-text">
                                               		<h6><a href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}"><span style="font-weight:bold; font-size:15px; color:#766BB0;" >${movieVO.moviename}</span></a></h6>
                                                </div>
                                                <div class="mid-2 agile_mid_2_home">
													<p style="font-size:13px;">�W�M���: <fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /></p><br>
                                                <div class="mid-2 agile_mid_2_home">
													<p><font color=red>${movieVO.rating} ��</font></p>
												</div>	
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
																	<li >�|�L����</li>
																</ul>
															</div>
															<div class="clearfix"></div>
														</c:otherwise>
													</c:choose>	
                                                </div>
                                            </div>
<!--                                             <div class="ribben"> -->
<!--                                                 <p>NEW</p> -->
<!--                                             </div> -->
                                        </div>
                                       </c:forEach>
                                    
                                    
                                    </div>
                                    <div class="clearfix"> </div>
                                </div>
                                <div class="cleafix"></div>
                            </div>
                        </div>
                        

                        <div class="tab2">
                            <div class="tab_movies_agileinfo">
                                <div class="w3_agile_featured_movies">
                                    <div class="col-md wthree_agile-movies_list">
                                    <c:forEach var="movieVO" items="${comingSoonMovie}">
                                        <div class="w3l-movie-gride-agile">
                                            <a href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}" class="hvr-sweep-to-bottom" style="width:100%;">
                                            <img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}" title="${movieVO.moviename}" class="img-responsive" alt=" " style="width:100%;px; height:230px;">
                                                <div class="w3l-action-icon">
                                                <i class="fa fa-play-circle-o" aria-hidden="true"></i></div>
                                            </a>
                                            <div class="mid-1 agileits_w3layouts_mid_1_home">
                                                <div class="w3l-movie-text">
                                               		<h6><a href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}"><span style="font-weight:bold; font-size:15px; color:#766BB0;" >${movieVO.moviename}</span></a></h6>
                                                </div>
                                                <div class="mid-2 agile_mid_2_home">
													<p style="font-size:13px;">�W�M���: <fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /></p>
                                                <div class="mid-2 agile_mid_2_home">
													<p><font color=red>���ݫ� &nbsp;&thinsp;: ${movieVO.expectation * 100} %�Q��</font></p>
												</div>
													<div class="clearfix"></div>
                                                </div>
                                            </div>
                                            <div class="ribben">
                                                <p>NEW</p>
                                            </div>
                                        </div>
                                       </c:forEach>

                                    </div>
                                    <div class="clearfix"> </div>
                                </div>
                                <div class="cleafix"></div>
                            </div>
                        </div>
                        
                        
                        
                        <div class="tab3">
                            <div class="tab_movies_agileinfo">
                                <div class="w3_agile_featured_movies">
						            <!--//tab-section-->
						            <h3 class="agile_w3_title"> �����Ƨ�(�W�M��) <span>Movies</span></h3>
						            <!--/movies-->
						            <div class="w3_agile_latest_movies">
						                <div id="owl-demo" class="owl-carousel owl-theme">
						                <% int i = 1;%>
						                <c:forEach var="movieVO" items="${allTopRatingInTheatersMovie}">	
						                    <div class="item">
						                        <div class="w3l-movie-gride-agile w3l-movie-gride-slider ">
						                            <a href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}" class="hvr-sweep-to-bottom" style="width:100%;">
						                            <img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}" 
						                            title="${movieVO.moviename}" class="img-responsive" alt=" " style="width:225px; height:270px;"/>
						                                <div class="w3l-action-icon"><i class="fa fa-play-circle-o" aria-hidden="true"></i></div>
						                            </a>
						                            <div class="mid-1 agileits_w3layouts_mid_1_home">
						                                <div class="w3l-movie-text">
						                                    <h6><a href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}"><span style="font-weight:bold; font-size:17px; color:#766BB0;" >${movieVO.moviename} </span></a></h6>
						                                </div>
						                                <div class="mid-2 agile_mid_2_home">
															<p>�W�M���: <fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /></p>
														<div class="mid-2 agile_mid_2_home">
															<p><font color=red>${movieVO.rating} ��</font></p>
														</div>
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
																		<% for (int s=1 ; s<=5; s++) { %>
																			<li><i class="fa fa-star" aria-hidden="true"></i></li>
																		<% } %>
																		</ul> 
							 										</div>
																	<div class="clearfix"></div>
																</c:when>
																<c:otherwise>
																	<div class="block-stars">
																		<ul style="list-style-type:none; font-size:14px;">
																			<li >�|�L����</li>
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
						                </div>
						            </div>
						            
						            <h3 class="agile_w3_title"> ���ݱƧ�(�Y�N�W�M) <span>Movies</span></h3>
						            <!--/movies-->
						            <div class="w3_agile_latest_movies">
						                <div id="owl-demo2" class="owl-carousel owl-theme">
						                <% int j = 1;%>
						                <c:forEach var="movieVO" items="${allTopExpectationComingSoonMovie}">	
						                    <div class="item">
						                        <div class="w3l-movie-gride-agile w3l-movie-gride-slider ">
						                            <a href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}" class="hvr-sweep-to-bottom" style="width:100%;">
						                            <img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}" 
						                            title="${movieVO.moviename}" class="img-responsive" alt=" " style="width:225px; height:270px;"/>
						                                <div class="w3l-action-icon"><i class="fa fa-play-circle-o" aria-hidden="true"></i></div>
						                            </a>
						                            <div class="mid-1 agileits_w3layouts_mid_1_home">
						                                <div class="w3l-movie-text">
						                                    <h6><a href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}"><span style="font-weight:bold; font-size:17px; color:#766BB0;" >${movieVO.moviename} </span></a></h6>
						                                </div>
						                                <div class="mid-2 agile_mid_2_home">
															<p>�W�M���: <fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /></p>
														<div class="mid-2 agile_mid_2_home">
															<p><font color=red>���ݫ� &nbsp;&thinsp;: &nbsp;&nbsp;&thinsp; ${movieVO.expectation * 100} %�Q��</font></p>
														</div>
															<div class="clearfix"></div>
														</div>
						                            </div>
						                            <div class="ribben one">
						                                <p>TOP <%= j %></p>
														<% j++; %>
						                            </div>
						                        </div>
						                    </div>
						               	</c:forEach>
						                </div>
						            </div>
                                </div>
                                <div class="cleafix"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!--//movies-->

            <!--/top-movies-->
            <h3 class="agile_w3_title">Top Movies <span>Review</span> </h3>
            <div class="top_movies">
                <div class="tab_movies_agileinfo">
                    <div class="w3_agile_featured_movies two">
                        <div class="col-md-8 wthree_agile-movies_list second-top">
                            
                        <c:forEach var="movieVO" items="${listTopTen}">
	                        <div class="w3l-movie-gride-agile1">
	                            <a href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}" class="hvr-sweep-to-bottom" style="width:100%;">
	                            <img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}" title="${movieVO.moviename}" class="img-responsive" alt=" " style="width:100%; height:230px;">
	                                <div class="w3l-action-icon">
	                                <i class="fa fa-play-circle-o" aria-hidden="true"></i></div>
	                            </a>
	                            <div class="mid-1 agileits_w3layouts_mid_1_home">
	                                <div class="w3l-movie-text">
	                               		<h6><a href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}"><span style="font-weight:bold; font-size:15px; color:#766BB0;" >${movieVO.moviename}</span></a></h6>
	                                   </div>
	                                   <div class="mid-2 agile_mid_2_home">
										<p style="font-size:13px;">�W�M���: <fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /></p>
										                                   <div class="mid-2 agile_mid_2_home">
										<p><font color=red>${movieVO.rating} ��</font></p>
										</div>	
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
												<li >�|�L����</li>
											</ul>
										</div>
										<div class="clearfix"></div>
										</c:otherwise>
										</c:choose>	
	                                </div>
	                            </div>
	                            <div class="ribben">
	                                <p>NEW</p>
	                            </div>
	                        </div>
                        </c:forEach>  
                        </div>
                       

                        
                        <div class="col-md-4 video_agile_player">
	                        <div class="video-grid-single-page-agileits" >
	                        	 <a class="w3_play_icon" href="#small-dialog3">
	                            	<img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${bestMovie.movieno}" 
	                            	alt="" class="img-responsive" title="�I���[��i${bestMovie.moviename}�j�̷s�w�i"/> 
 	                       		</a>
							</div>
	                        <div class="player-text">
	                            <p class="fexi_header">${bestMovie.moviename}</p>
	                            <p class="fexi_header_para">
	                            	<span>�ɺt<label>:</label></span>${bestMovie.director}
	                            </p>
	                            <p class="fexi_header_para">
	                            	<span class="conjuring_w3">�t��<label>:</label></span>${bestMovie.actor}
	                            </p>
	                            <p class="fexi_header_para">
									<span>�q�v����<label>:</label></span>${bestMovie.category}
								</p>
								<p class="fexi_header_para">
									<span>�W�M���<label>:</label></span>
									<fmt:formatDate value="${bestMovie.premiredate}"
										pattern="yyyy-MM-dd" />
								</p>
								<p class="fexi_header_para">
									<span>�U�M���<label>:</label></span>
									<fmt:formatDate value="${bestMovie.offdate}" pattern="yyyy-MM-dd" />
								</p>
								<p class="fexi_header_para">
									<span>����<label>:</label></span>
									<c:choose>
										<c:when test="${((bestMovie.length)/60)<1}">
											<td>${bestMovie.length}����</td>
										</c:when>
										<c:when test="${(((bestMovie.length)/60)%1)==0}">
											<td><fmt:formatNumber type="number"
													value="${((bestMovie.length)-(bestMovie.length%60))/60}" />�p��</td>
										</c:when>
										<c:when test="${((bestMovie.length)/60)>1}">
											<td><fmt:formatNumber type="number"
													value="${((bestMovie.length)-(bestMovie.length%60))/60}" />�p��<fmt:formatNumber
													type="number" value="${bestMovie.length%60}" />����</td>
										</c:when>
										<c:otherwise>
											<td>�L�Įɶ�</td>
										</c:otherwise>
									</c:choose>
								</p>
								<p class="fexi_header_para">
									<span>�q�v����<label>:</label></span>
									<c:choose>
										<c:when test="${bestMovie.grade.equals('0')}">
											<td>���M��</td>
										</c:when>
										<c:when test="${bestMovie.grade.equals('1')}">
											<td>�O�@��</td>
										</c:when>
										<c:when test="${bestMovie.grade.equals('2')}">
											<td>���ɯ�</td>
										</c:when>
										<c:when test="${bestMovie.grade.equals('3')}">
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
										<c:when test="${bestMovie.status.equals('0')}">
											<td>�W�M��</td>
										</c:when>
										<c:when test="${bestMovie.status.equals('1')}">
											<td>���W�M</td>
										</c:when>
										<c:when test="${bestMovie.status.equals('2')}">
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
								<div id="ratingValue3" style="display:none;">${bestMovie.rating}</div>
								<p id="rating3" class="fexi_header_para fexi_header_para1"> </p>
								<p id="noRating3" class="fexi_header_para "></p>
				                                     
				                <p class="fexi_header_para ">
									<span>�q�v���ݫ�<label>:</label></span>
								</p>
								<div id="expectationValue3">
									<p class="fexi_header_para ">
									<td><fmt:formatNumber type="number" value="${bestMovie.expectation*100}"/> % �Q��</td>
									</p>
								</div>
	                          </div>
	                      </div>
                        <div class="clearfix"> </div>
                    </div>
                    <div class="cleafix"></div>
                </div>
            </div>
            <!--//top-movies-->
        </div>
    </div>
    <!--//content-inner-section-->
    <!--/footer-bottom-->
    <div class="contact-w3ls" id="contact">
        <div class="footer-w3lagile-inner">
            <div class="footer-grids w3-agileits">
                <div class="col-md-2 footer-grid">
                    <h4 class="b-log"><a><span>�~</span>��</a></h4>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2021" title="Release 2021">2021</a></li>
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2020" title="Release 2020">2020</a></li>
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2019" title="Release 2019">2019</a></li>
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2018" title="Release 2018">2018</a></li>
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2017" title="Release 2017">2017</a></li>
                    </ul>
                </div>
                <div class="col-md-2 footer-grid">
                    <h4 class="b-log"><a><span>��</span>�t</a></h4>
                    <div class="footer-grid1">
                        <div class="footer-grid1-left">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&DIRECTOR=Steven Spielberg">
                                <img src="<%=request.getContextPath()%>/images/index/Steven Spielberg.jpg" alt=" " width="60px" height="50px"></a>
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
                                <img src="<%=request.getContextPath()%>/images/index/Michael Bay.jpg" alt=" " width="60px" height="50px"></a>
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
                                <img src="<%=request.getContextPath()%>/images/index/James Cameron.jpg" alt=" " width="60px" height="50px"></a>
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
                                <img src="<%=request.getContextPath()%>/images/index/Christopher Nolan.jpg" alt=" " width="60px" height="50px"></a>
                        </div>
                        <div class="footer-grid1-right">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&DIRECTOR=Christopher Nolan">
                                Christopher Nolan</a>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                </div>
                <div class="col-md-2 footer-grid">
                    <h4 class="b-log"><a><span>��</span>�s <span>�q</span>�v</a></h4>
                    <c:forEach var="movieVO" items="${latestMovie}">
                        <div class="footer-grid-instagram">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}">
                            <img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}" title=" " width="80px" height="100px"></a>
                        </div>
                    </c:forEach>
<%--                      <c:forEach var="movieVO" items="${comingSoonMovie}"> --%>
<!--                         <div class="footer-grid-instagram"> -->
<%--                             <a href="${pageContext.request.contextPath}/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}"> --%>
<%--                             <img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}" title=" " width="80px" height="100px"></a> --%>
<!--                         </div> -->
<%--                     </c:forEach> --%>
                    <div class="clearfix"> </div>
                </div>
                <div class="col-md-2 footer-grid">
                    <h4 class="b-log"><a><span>�t</span>��</a></h4>
                    <div class="footer-grid1">
                        <div class="footer-grid1-left">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&ACTOR=Leonardo Wilhelm DiCaprio">
                                <img src="<%=request.getContextPath()%>/images/index/Leonardo DiCaprio.jpg" alt=" " width="60px" height="50px"></a>
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
                                <img src="<%=request.getContextPath()%>/images/index/Tom Cruise.jpg" alt=" " width="60px" height="50px"></a>
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
                                <img src="<%=request.getContextPath()%>/images/index/Emma Stone.jpg" alt=" " width="60px" height="50px"></a>
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
                                <img src="<%=request.getContextPath()%>/images/index/Anne Hathaway.jpg" alt=" " width="60px" height="50px"></a>
                        </div>
                        <div class="footer-grid1-right">
                            <a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&ACTOR=Anne Hathaway">
                                Anne Hathaway</a>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                </div>
                <div class="col-md-2 footer-grid">
                    <h4 class="b-log"><a><span>��</span>�� <span></span> <span>�q</span>�v</a></h4>
                    <ul>
                        <c:forEach var="movieVO" items="${listTopTen}" begin="0" end ="4">
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
        $(document).ready(function() {
            $(".dropdown").hover(
                function() {
                    $('.dropdown-menu', this).stop(true, true).slideDown("fast");
                    $(this).toggleClass('open');
                },
                function() {
                    $('.dropdown-menu', this).stop(true, true).slideUp("fast");
                    $(this).toggleClass('open');
                }
            );
        });
    </script>
    <!-- //Dropdown-Menu-JavaScript -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.zoomslider.min.js"></script>
    <!-- search-jQuery -->
    <script src="<%=request.getContextPath()%>/js/main.js"></script>
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
    <!-- pop-up-box -->
    <script src="<%=request.getContextPath()%>/js/jquery.magnific-popup.js" type="text/javascript"></script>
    <!--//pop-up-box -->
    <div id="small-dialog1" class="mfp-hide">
        <iframe src="https://www.youtube.com/embed/${oneNewestinTheatersMovie.embed}"></iframe>
    </div>
    <div id="small-dialog2" class="mfp-hide">
        <iframe src="https://www.youtube.com/embed/${oneNewestComingSoonMovie.embed}"></iframe>
    </div>
    <div id="small-dialog3" class="mfp-hide">
        <iframe src="https://www.youtube.com/embed/${bestMovie.embed}"></iframe>
    </div>
    <div id="small-dialog" class="mfp-hide">
        <iframe src="https://www.youtube.com/embed/26Q8duJW11s"></iframe>
    </div>
    <script>
        $(document).ready(function() {
            $('.w3_play_icon,.w3_play_icon1,.w3_play_icon2,.w3_play_icon3').magnificPopup({
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
                autoPlay: true,
                navigation: true,

                items: 5,
                itemsDesktop: [640, 4],
                itemsDesktopSmall: [414, 3]

            });

        });
        $(document).ready(function() {
            $("#owl-demo2").owlCarousel({

                autoPlay: 3000, //Set AutoPlay to 1 seconds
                autoPlay: true,
                navigation: true,

                items: 5,
                itemsDesktop: [640, 4],
                itemsDesktopSmall: [414, 3]

            });

        });
    </script>
    <!--/script-->
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/move-top.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/easing.js"></script>
    <script type="text/javascript">
        jQuery(document).ready(function($) {
            $(".scroll").click(function(event) {
                event.preventDefault();
                $('html,body').animate({ scrollTop: $(this.hash).offset().top }, 900);
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
</body>
<script>

$(document).ready(initialDrawRating1);
$(document).ready(initialDrawRating2);
$(document).ready(initialDrawRating3);

function initialDrawRating1() {
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
			"<td> ${oneNewestComingSoonMovie.rating} ��</td>"
			
			
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
			"<td> ${oneNewestComingSoonMovie.rating} ��</td>"
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
			"<td> ${oneNewestComingSoonMovie.rating} ��</td>"
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
			"<td> ${oneNewestComingSoonMovie.rating} ��</td>"
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
			"<td> ${oneNewestComingSoonMovie.rating} ��</td>"
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
			"<td> ${oneNewestComingSoonMovie.rating} ��</td>"
		);
	}else{
		$("#noRating").text("�|�L����");
	}
}

function initialDrawRating2() {
	if($("#ratingValue2").text() <= 0){
		$("#noRating2").text("�|�L����");
	}else if($("#ratingValue2").text() < 1.0){
// 		$("#rating").html("");
		$("#rating2").append(				
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${oneNewestComingSoonMovie.rating} ��</td>"
		);
	}else if($("#ratingValue2").text() < 2.0){
		$(".all-star").css("color","gray");
// 		$("#s1").css("color","yellow");
// 		$("#rating").html("");
		$("#rating2").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${oneNewestComingSoonMovie.rating} ��</td>"
		);
	}else if($("#ratingValue2").text() < 3.0){
		$(".all-star").css("color","gray");
// 		$("#s1,#s2").css("color","yellow");
// 		$("#rating").html("");
		$("#rating2").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${oneNewestComingSoonMovie.rating} ��</td>"
		);
	}else if($("#ratingValue2").text() < 4.0){
		$(".all-star").css("color","gray");
// 		$("#s1,#s2,#s3").css("color","yellow");
// 		$("#rating").html("");
		$("#rating2").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${oneNewestComingSoonMovie.rating} ��</td>"
		); 
	}else if($("#ratingValue2").text() < 5.0){
		$(".all-star").css("color","gray");
// 		$("#s1,#s2,#s3,#s4").css("color","yellow");
// 		$("#rating").html("");
		$("#rating2").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${oneNewestComingSoonMovie.rating} ��</td>"
		);
	}else if($("#ratingValue2").text() === "5.0"){
		$(".all-star").css("color","gray");
// 		$("#s1,#s2,#s3,#s4,#s5").css("color","yellow");
// 		$("#rating").html("");
		$("#rating2").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${oneNewestComingSoonMovie.rating} ��</td>"
		);
	}else{
		$("#noRating2").text("�|�L����");
	}
}

function initialDrawRating3() {
	if($("#ratingValue3").text() <= 0){
		$("#noRating3").text("�|�L����");
	}else if($("#ratingValue3").text() < 1.0){
// 		$("#rating").html("");
		$("#rating3").append(				
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${bestMovie.rating} ��</td>"
		);
	}else if($("#ratingValue3").text() < 2.0){
		$(".all-star").css("color","gray");
// 		$("#s1").css("color","yellow");
// 		$("#rating").html("");
		$("#rating3").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${bestMovie.rating} ��</td>"
		);
	}else if($("#ratingValue3").text() < 3.0){
		$(".all-star").css("color","gray");
// 		$("#s1,#s2").css("color","yellow");
// 		$("#rating").html("");
		$("#rating3").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${bestMovie.rating} ��</td>"
		);
	}else if($("#ratingValue3").text() < 4.0){
		$(".all-star").css("color","gray");
// 		$("#s1,#s2,#s3").css("color","yellow");
// 		$("#rating").html("");
		$("#rating3").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${bestMovie.rating} ��</td>"
		); 
	}else if($("#ratingValue3").text() < 5.0){
		$(".all-star").css("color","gray");
// 		$("#s1,#s2,#s3,#s4").css("color","yellow");
// 		$("#rating").html("");
		$("#rating3").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${bestMovie.rating} ��</td>"
		);
	}else if($("#ratingValue3").text() >= 5.0){
		$(".all-star").css("color","gray");
// 		$("#s1,#s2,#s3,#s4,#s5").css("color","yellow");
// 		$("#rating").html("");
		$("#rating3").append(				
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${bestMovie.rating} ��</td>"
		);
	}else{
		$("#noRating3").text("�|�L����");
	}
}
</script>
<script>
<% 
	ExpectationService expectationSvc = new ExpectationService();
	ExpectationVO expectationCount1 = expectationSvc.getThisMovieToatalExpectation(oneNewestinTheatersMovie.getMovieno());
	pageContext.setAttribute("expectationCount1", expectationCount1);
	
	ExpectationVO expectationCount2 = expectationSvc.getThisMovieToatalExpectation(oneNewestComingSoonMovie.getMovieno());
	pageContext.setAttribute("expectationCount2", expectationCount2);
%>



$(document).ready(drawPieChart1);
$(document).ready(drawPieChart2);
$(document).ready(function(){
	$("#logout-btn").click(function(){
		window.location.href = '<%=request.getContextPath()%>/index.jsp';
	});
	let hasLoggedIn = <%= memVO.getMember_no() %>;
	if(hasLoggedIn != 99){
		$("#welcome").show();
		$("#login-btn").hide();
		$("#logout-btn").show();
	} else{
		$("#welcome").hide();
		$("#login-btn").show();
		$("#logout-btn").hide();
	}
	
});

function drawPieChart1() {
	var canvas = document.createElement('canvas');
	canvas.id     = "chart";
	canvas.style.width  = 50;
	canvas.style.height = 50;
	canvas.style.zIndex   = 99;
	if($("#expectationValue").text() != 0){
		$("#expectation").html("");//���N�e���M�� �A�e�ϼh
// 		<td><fmt:formatNumber type="number" value="${movieVO.expectation*100}"/>���ռƦr�榡��</td>	
// 		$("#expectation").append("<td>${movieVO.expectation*100}% �Q��  </td>").append(canvas);
		$("#expectation").append("<td><fmt:formatNumber type="number" value="${oneNewestinTheatersMovie.expectation*100}"/> % �Q��</td>").append(canvas);
		var ctx = document.getElementById("chart").getContext('2d');
		var chart = new Chart(ctx, {
			type: 'pie',
			data: {
				labels: ["�Q��", "���Q��"],
				datasets: [{
				label: '# of Votes',
				data: [${oneNewestinTheatersMovie.expectation*100},100-(${oneNewestinTheatersMovie.expectation*100})],
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


function drawPieChart2() {
	var canvas = document.createElement('canvas');
	canvas.id     = "chart2";
	canvas.style.width  = 50;
	canvas.style.height = 50;
	canvas.style.zIndex   = 99;
	if($("#expectationValue2").text() != 0){
		$("#expectation2").html("");//���N�e���M�� �A�e�ϼh
// 		<td><fmt:formatNumber type="number" value="${movieVO.expectation*100}"/>���ռƦr�榡��</td>	
// 		$("#expectation").append("<td>${movieVO.expectation*100}% �Q��  </td>").append(canvas);
		$("#expectation2").append("<td><fmt:formatNumber type="number" value="${oneNewestComingSoonMovie.expectation*100}"/> % �Q��</td>").append(canvas);
		var ctx = document.getElementById("chart2").getContext('2d');
		var chart = new Chart(ctx, {
			type: 'pie',
			data: {
				labels: ["�Q��", "���Q��"],
				datasets: [{
				label: '# of Votes',
				data: [${oneNewestComingSoonMovie.expectation*100},100-(${oneNewestComingSoonMovie.expectation*100})],
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
		$("#noExpectation2").text("�|�L���ݫ�");
	}
}
</script>
<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />

<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
 	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '',              //value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });
        
        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
 	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '',              //value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });

</script>

<script>

    	$("#search-context").on('input propertychange', function(){
    		$("#search-results").html('<hr class="hrhr">');
    		if(!$(this).val() == ""){
    			var result;
    			console.log("�e�X�j�M = " + $(this).val());
    			let json_result_list = getResults($(this).val());
        		console.log("���^���G");
    			console.log(json_result_list);
        		if(json_result_list != undefined ){
	        		for ( movieVO of json_result_list){
	        			console.log(movieVO.moviename);
	        			console.log(movieVO.actor);
	        			console.log(movieVO.premiredate);
	        			console.log(movieVO.movieno);
	        			let link = '<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=' + movieVO.movieno  + '' ;
	        			var dt = new Date(movieVO.premiredate);
	        			var yr = 1900 + dt.getYear();
	        			result = 
		    				'<div class="rslt row" onclick="location.href=\'' + link+ '\'" > ' +
		    				'	<div class="col-md-3"> ' +
		    		   		'			<img src="<%=request.getContextPath()%>/movie/DBGifReader2.do?movieno=' + movieVO.movieno + '" title=" " width="260px" height="120px"> ' +
		    		  		'		</div> ' +
		    		  		'		<div class="col-md-9">' +
		    				'		<p class="mov-name">'+ movieVO.moviename +  '</p>' +
		    				'		<p class="non-mov-name">'+ movieVO.actor +  '</p> ' +
		    				'		<p class="non-mov-name">'+ yr +  '</p> ' +
		    	  			'	</div>' +
		    				'</div>' +
		    				'<hr class="hrhr">';
		    			
		        		$("#search-results").html(
		        				$("#search-results").html() + result
		        		);
	        		}
        		}
    		}
    	});

    	function getResults(words){
    		let json;
			$.ajax({
					url: "<%=request.getContextPath()%>/movie/movie.do",
					type:"POST",
					data: {
						MOVIE_NAME: words,
						action:"search_Ajax"
					},
					async: false,
					success: function(data){
						console.log(data);
						json = JSON.parse(data).results;
					}
				});
			return json;
	}
    	
    </script>


</html>