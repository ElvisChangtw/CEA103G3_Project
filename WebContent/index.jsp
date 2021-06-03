<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.movie.model.*"%>
<%@ page import="com.comment.model.*"%>
<%@ page import="com.expectation.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.article.model.*"%>
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
	
	ArticleService articleSvc = new ArticleService();
	List<ArticleVO> listTopFiveArticles = articleSvc.getArticleLikeCount();
	pageContext.setAttribute("listTopFiveArticles", listTopFiveArticles);
	
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
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

<style>
    .icons{
  display: inline;
  float: right
}
.notification{
/*   bottom: 25px; */
bottom: 45px; 
/*   left: 340px; */
left: 1420px; 
  position: relative;
  display: inline-block;
}

.number{
  font-size:3px;
  height: 22px;
  width:  22px;
  background-color: #21d207;
  border-radius: 20px;
  color: white;
  text-align: center;
  position: absolute;
  top: -7px;
  left: 65px;
  padding: 3px;
  border-style: solid;
  border-width: 2px;
}

.number:empty {
   display: none;
}

.notBtn{
  transition: 0.5s;
  cursor: pointer
}

.fas{
  font-size: 25pt;
  padding-bottom: 10px;
  color: white;
  margin-right: 40px;
  margin-left: 40px;
}

.box{
  width: 400px;
  height: 0px;
  border-radius: 10px;
  transition: 0.5s;
  position: absolute;
  overflow-y: scroll;
  padding: 0px;
  left: -300px;
  margin-top: 5px;
  background-color: #F4F4F4;
  -webkit-box-shadow: 10px 10px 23px 0px rgba(0,0,0,0.2);
  -moz-box-shadow: 10px 10px 23px 0px rgba(0,0,0,0.1);
  box-shadow: 10px 10px 23px 0px rgba(0,0,0,0.1);
  cursor: context-menu;
}

.fas:hover {
  color: #d63031;
}

.notBtn:hover > .box{
  height: 60vh
}

.content{
  padding: 20px;
  color: black;
  vertical-align: middle;
  text-align: left;
}

.gry{
  background-color: #F4F4F4;
}

.top{
  color: black;
  padding: 10px
}

.display{
  position: relative;
  z-index:99;
}

.cont{
  position: absolute;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: #F4F4F4;
}

.cont:empty{
  display: none;
}

.stick{
  text-align: center;  
  display: block;
  font-size: 50pt;
  padding-top: 70px;
  padding-left: 80px
}

.stick:hover{
  color: black;
}

.cent{
  text-align: center;
  display: block;
}

.sec{
  padding: 25px 10px;
  background-color: #F4F4F4;
  transition: 0.5s;
}

.profCont{
  padding-left: 15px;
}

.profile{
  -webkit-clip-path: circle(50% at 50% 50%);
  clip-path: circle(50% at 50% 50%);
  width: 75px;
  float: left;
}

.txt{
  vertical-align: top;
  font-size: 1.25rem;
  padding: 5px 10px 0px 115px;
}

.sub{
  font-size: 1rem;
  color: grey;
}

.new{
  border-style: none none solid none;
  background-color: rgb(252, 255, 229);
}

.sec:hover{
  background-color: #BFBFBF;
}
#mic, #mic-using{
	width: 40px;
    height: 40px;
    position: absolute;
    top: 15px;
    right: 12px;
}
 

    </style>

<style>
  /* 通知用 */
  @import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

.fadeOut {
  opacity: 0 !important;
}

#create {
  border: none !important;
  padding: 8px !important;
  font-size:15px !important;
  color: #FFF !important;
  background-color: firebrick !important;
  border-radius: 8px !important;
}

.alert-container{
  z-index:99;
  position: fixed !important;
  right: 10px !important;
  bottom: 10px !important;
}

.alert {
  position: relative !important;
  background-color: white !important;
  border: 5px solid lightblue !important;
  height: 130px !important;
  width: 290px !important;
  border-radius: 15px !important;
  margin-bottom: 15px !important;
  color: #40bde6 !important;
  padding: 20px 15px 0 15px !important;
  transition: opacity 2s !important;
}

.alert span {
  font-size: 1.3rem !important;
  position: absolute !important;
  top: 3px !important;
  right: 12px !important;
  cursor: pointer !important;

}
.alertTxt{
  font-size: 17px !important;
  position: absolute !important;
  top: 0px !important;
  right: 12px !important;
  cursor: pointer !important;
  margin-top:23px !important;
  width:170px !important;

}
.alertImg{
  width:80px !important;
  margin-left:-5px !important;

}

.alertTxt .alertTime{
	position:fixed;
	bottom:40px;
	right:40px;
	font-size:10px !important;
	color:gray;
}
</style>


</head>

<body onload="connect();" onunload="disconnection();">

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font color='red'>請修正以下錯誤:</font>
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
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">電影介紹<b class="caret"></b></a>
                                    <ul class="dropdown-menu multi-column columns-3">
                                        <li>
                                             <div class="col-sm-4">
                                                <ul class="multi-column-dropdown">
                                                    <li><a href="<%=request.getContextPath()%>/front-end/movie/listAllMovie.jsp">所有電影</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=冒險片">冒險片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=戰爭片">戰爭片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=警匪片">警匪片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=驚悚片">驚悚片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=愛情片">愛情片</a></li>
                                                    
                                                </ul>
                                            </div>
                                            <div class="col-sm-4">
                                                <ul class="multi-column-dropdown">
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
                                                    
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=科幻片">科幻片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=史詩片">史詩片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=音樂片">音樂片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=懸疑片">懸疑片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=文藝片">文藝片</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=歌舞劇">歌舞劇</a></li>
                                                </ul>
                                            </div>
                                            <div class="clearfix"></div>
                                        </li>
                                    </ul>
                                </li>
                                
                                <li><a href="<%=request.getContextPath()%>/front-end/article/listAllArticle.jsp">魔穴論壇</a></li>
                                <li><a href="<%=request.getContextPath()%>/front-end/group/group_front_page.jsp">揪團啾啾</a></li>
                               	<li><a href="<%=request.getContextPath()%>/front-end/news/listAllNews.jsp">最新消息</a></li>
<%--                                 <li class="active"><a href="<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp">登入/註冊</a></li> --%>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">會員專區<b class="caret"></b></a>
                                    <ul class="dropdown-menu multi-column columns-1">
                                        <c:choose>
	                                        <c:when test="${memVO==null || memVO.member_no==99 }">
	                                        	<li><a href="#" onclick="loginFirst()" >會員中心</a></li>
	                                        	<li><a href="#" onclick="loginFirst()" >會員資訊</a></li>
	                                        	<li><a href="#" onclick="loginFirst()" >好友管理</a></li>
	                                        </c:when>
	                                        <c:otherwise>
	                                        	<li><a href="<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">會員中心</a></li>
	                                        	<li><a href="<%=request.getContextPath()%>/front-end/mem/memberInfo.jsp">會員資訊</a></li>
	                                        	<li><a href="<%=request.getContextPath()%>/front-end/relationship/select_page.jsp">好友管理</a></li>
	                                        </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </li>
                            </ul>
                            
                        </div>
                        
                        <div class="clearfix"> </div>

                    </nav>
                    
                    <div class="w3ls_search">
						<div class="cd-main-header">
							<div class = "notification">
									  <a href = "#">
									  <div class = "notBtn" href = "#">
									    <div id="number" class = "number"></div>
									    <i class="fas fa-bell"></i>
									      <div class = "box">
									        <div class = "display">
									          <div class = "nothing"> 
									            <i class="fas fa-child stick"></i> 
									            <div class = "cent"></div>
									          </div>
									          <div class = "cont"><!-- Fold this div and try deleting evrything inbetween -->
					
									         </div>
									        </div>
									     </div>
									  </div>
									    </a>
									</div>
							<ul class="cd-header-buttons">
								<c:choose>
									<c:when test="${memVO.member_no == 99}">
										<li class="active rhs"><a id="login-btn"  href="<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp">登入</a></li>
									</c:when>
									<c:otherwise>
										<li class="active rhs">
											<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${memVO.member_no}" 
												id="${groupVO.group_no}-${memVO.member_no}" alt="尚無圖片" width="60px;" height="60px" 
												style="border-radius:50%;" class="clickable" />
											<a id="welcome"> ${memVO.mb_name } &nbsp</a>
											<a id="logout-btn" href="<%=request.getContextPath()%>/front-end/mem/MemLogout.jsp"> 登出 </a>
										</li>
									</c:otherwise>
								</c:choose>
								<li><a class="cd-search-trigger" href="#cd-search"> <span></span></a></li>
							</ul> <!-- cd-header-buttons -->
						</div>
						<div id="cd-search" class="cd-search">
							<form method="post" action="<%=request.getContextPath()%>/movie/movie.do" name="form1">
								<input id="search-context"  type="text" name="MOVIE_NAME" value="" placeholder="請輸入電影名稱" onkeydown="if (event.keyCode == 13) sendMessage();">
								<input type="hidden" name="action" value="listMovies_ByCompositeQuery">

								<img id="mic"src="<%=request.getContextPath()%>/images/mic.png">
								<img id="mic-using"src="<%=request.getContextPath()%>/images/MicUsing.gif" style="display:none;">
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
                <h3>魔 <span>穴</span> 電 影 </h3>
                <h4>May the Force be with you.</h4>
                <a class="w3_play_icon1" href="#small-dialog">
                   	觀 看 預 告
                </a>
            </div>
            <!--/banner-ingo-->
        </div>
    </div>
    <!--/banner-section-->
    <!--//main-header-->
    <!--/banner-bottom-->
    
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
  
<!--    訂票+文章區塊開始 -->
   <section class="booking_area">
   	<div class="container-fluid">
   		<div class="row">
   		
   		 <!-- 訂票開始-->
   			<div class="col-sm-4">
		    	<div class="booking-form">
                	<div class="form-header">
                       <h1>訂票</h1>
                    </div>
                    <form METHOD="post" ACTION="<%=request.getContextPath()%>/order/order.do" name="form1">
                    	<div class="form-group">
                        	<span class="form-label">電影</span>
                        	<select class="form-control" id="movie" name="movie_no" required>
								<option value="">請選擇電影</option>
                            </select>
                            <span class="select-arrow"></span>
                        </div>
                        <div class="form-group">
                           <span class="form-label">日期</span>
                           <select class="form-control" id="date" name="movie_date" required>
								<option value="">請選擇日期</option>
                           </select>
                           <span class="select-arrow"></span>
                        </div>
                        <div class="form-group">
                            <span class="form-label">場次</span>
                           <select class="form-control" id="showtime" name="showtime_no" required>
								<option value="">請選擇場次</option>
                           </select>
                           <span class="select-arrow"></span>
                        </div>
                        <div class="form-btn">
                        	<input type="hidden" name="action" value="sendToFT">
                           <button class="submit-btn">Book Now</button>
                        </div>
                    </form>
            	</div>
   			</div>
   			<!-- 訂票結束-->
			<!--文章開始 -->
			
   			<div class="col-sm-8">
				 <div class="container article-form">
                    <div class="article-table table-responsive">
                        <div class="table-header">
                            <h1>熱門文章<p style="display: inline-block; font-size:16px;">
                            <a href="<%=request.getContextPath()%>/front-end/article/listAllArticle.jsp" id="go-to-forum">&nbsp→前往討論區</a></p></h1>
                        </div>
                        <table class="table">
                            <thead class="thead-light">
                                <tr class="success">
                                    <th scope="col">#</th>
                                    <th scope="col" style="text-align:center;">標題</th>
<!--                                     <th scope="col">內容</th> -->
                                    <th scope="col" style="text-align:center;">發文日期</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% int article_cnt = 0; %>
                            	
	                            <c:forEach var="articleVO" items="${listTopFiveArticles}">
	                            	<tr> 
	                            		<%article_cnt++; %>
		                            		<th scope="row" class="article-link">
		                            			<a class="JQellipsis"  style="color:white;"><%=article_cnt %>
		                            			</a>
	                            			</th>
		                                    <td class="article-link">
		                                    	<div>
		                                    		<a style="color:white;" onclick="loginArticle(${articleVO.articleno})">
		                                    		${articleVO.articleheadline}
		                                    		</a>	
	                                    		</div>
                                    		</td>
	                                    
		                                    <td  class="article-link">
		                                    	<a style="color:white;">
		                                    		<fmt:formatDate value="${articleVO.crtdt}" pattern="yyyy-MM-dd" />
		                                    	</a>			
											</td>
	                            	</tr>
	                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>   				
   			</div>
   			<!-- 文章結束-->
   		</div>
   	</div>
   </section>
	<!--訂票+文章區塊結束 -->
	
<nav class="navbar navbar-light" style="background-color: #75D9B5;">
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" name="form1" class="form-inline my-2 my-lg-0 composite-query">
		<div class="form-row">
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
<!-- 				<input type="text" name="PREMIERE_DT" id="f_date1" class="form-control" placeholder="請輸入觀影日期" size="12"> -->
 		       <input type="text" name="OFF_DT" id="f_date2" class="form-control" placeholder="請輸入觀影日期" size="12"><br> 
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
	       	
<!-- 	       	<div class="form-group col-2"> -->
<!-- 	       	<select size="1" name="STATUS" class="form-control form-control-sm"> -->
<!-- 				<option value="">請選擇電影狀態</option> -->
<!-- 				<option value="0">上映中</option> -->
<!-- 				<option value="1">未上映</option> -->
<!-- 				<option value="2">已下檔</option> -->
<!--       		</select><br> -->
<!--     		</div>&ensp; -->
	       	
       		<div class="form-group col-2">
       		<select size="1" name="GRADE" class="form-control form-control-sm">
				<option value="">請選擇電影分級</option>
				<option value="0">普遍級</option>
				<option value="1">保護級</option>
				<option value="2">輔導級</option>
				<option value="3">限制級</option>
       		</select><br>
			</div>&ensp;
       		
       		<div class="form-group col-2">
       		<select size="1" name="RATING" class="form-control form-control-sm">
				<option value="">評分不低於</option>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
      		</select><br>
       		</div>&ensp;
       		
       		<div class="form-group col-2">
       		<select size="1" name="EXPECTATION" class="form-control form-control-sm">
				<option value="">期待度不低於</option>
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
		      	&ensp;<button class="btn btn-danger btn-sm" type="submit" value="送出">搜尋</button>
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
                        <li style="font-size:20px;">上映中</li>
                        <li style="font-size:20px;">即將上映</li>
                        <li style="font-size:20px;">排行榜</li>
                    </ul>
                           
                    <div class="resp-tabs-container">
                        <div class="tab1">
                            <div class="tab_movies_agileinfo">
                                <div class="w3_agile_featured_movies">
                                    
                                    <div class="col-md wthree_agile-movies_list">
                                    
                                    
                                    <c:forEach var="movieVO" items="${inTheatersMovie}" begin="0" end="9">
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
													<p style="font-size:13px;">上映日期: <fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /></p><br>
                                                <div class="mid-2 agile_mid_2_home">
													<p><font color=red>${movieVO.rating} 分</font></p>
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
																	<li >尚無評分</li>
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
                                    <c:forEach var="movieVO" items="${comingSoonMovie}" begin="0" end="9">
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
													<p style="font-size:13px;">上映日期: <fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /></p>
                                                <div class="mid-2 agile_mid_2_home">
													<p><font color=red>期待度 &nbsp;&thinsp;: &nbsp;&nbsp;&nbsp;&thinsp;
													<fmt:formatNumber type="number" value="${movieVO.expectation*100}"/>%想看</font></p>
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
						            <h3 class="agile_w3_title"> 網友評分榜 <span>現正熱映</span></h3>
						            <!--/movies-->
						            <div class="w3_agile_latest_movies">
						                <div id="owl-demo" class="owl-carousel owl-theme">
						                <% int i = 1;%>
						                <c:forEach var="movieVO" items="${allTopRatingInTheatersMovie}" begin="0" end="9">	
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
															<p>上映日期: <fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /></p>
														<div class="mid-2 agile_mid_2_home">
															<p><font color=red>${movieVO.rating} 分</font></p>
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
						                </div>
						            </div>
						            
						            <h3 class="agile_w3_title"> 網友期待榜 <span>即將上映</span></h3>
						            <!--/movies-->
						            <div class="w3_agile_latest_movies">
						                <div id="owl-demo2" class="owl-carousel owl-theme">
						                <% int j = 1;%>
						                <c:forEach var="movieVO" items="${allTopExpectationComingSoonMovie}" begin="0" end="9">	
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
															<p>上映日期: <fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /></p>
														<div class="mid-2 agile_mid_2_home">
															<p><font color=red>期待度 &nbsp;&thinsp;: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&thinsp; 
															<fmt:formatNumber type="number" value="${movieVO.expectation*100}"/> %想看</font></p>
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
										<p style="font-size:13px;">上映日期: <fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /></p>
										                                   <div class="mid-2 agile_mid_2_home">
										<p><font color=red>${movieVO.rating} 分</font></p>
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
												<li >尚無評分</li>
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
	                            	alt="" class="img-responsive" title="點擊觀賞【${bestMovie.moviename}】最新預告"/> 
 	                       		</a>
							</div>
	                        <div class="player-text">
	                            <p class="fexi_header">${bestMovie.moviename}</p>
	                            <p class="fexi_header_para">
	                            	<span>導演<label>:</label></span>${bestMovie.director}
	                            </p>
	                            <p class="fexi_header_para">
	                            	<span class="conjuring_w3">演員<label>:</label></span>${bestMovie.actor}
	                            </p>
	                            <p class="fexi_header_para">
									<span>電影類型<label>:</label></span>${bestMovie.category}
								</p>
								<p class="fexi_header_para">
									<span>上映日期<label>:</label></span>
									<fmt:formatDate value="${bestMovie.premiredate}"
										pattern="yyyy-MM-dd" />
								</p>
								<p class="fexi_header_para">
									<span>下映日期<label>:</label></span>
									<fmt:formatDate value="${bestMovie.offdate}" pattern="yyyy-MM-dd" />
								</p>
								<p class="fexi_header_para">
									<span>片長<label>:</label></span>
									<c:choose>
										<c:when test="${((bestMovie.length)/60)<1}">
											<td>${bestMovie.length}分鐘</td>
										</c:when>
										<c:when test="${(((bestMovie.length)/60)%1)==0}">
											<td><fmt:formatNumber type="number"
													value="${((bestMovie.length)-(bestMovie.length%60))/60}" />小時</td>
										</c:when>
										<c:when test="${((bestMovie.length)/60)>1}">
											<td><fmt:formatNumber type="number"
													value="${((bestMovie.length)-(bestMovie.length%60))/60}" />小時<fmt:formatNumber
													type="number" value="${bestMovie.length%60}" />分鐘</td>
										</c:when>
										<c:otherwise>
											<td>無效時間</td>
										</c:otherwise>
									</c:choose>
								</p>
								<p class="fexi_header_para">
									<span>電影分級<label>:</label></span>
									<c:choose>
										<c:when test="${bestMovie.grade.equals('0')}">
											<td>普遍級</td>
										</c:when>
										<c:when test="${bestMovie.grade.equals('1')}">
											<td>保護級</td>
										</c:when>
										<c:when test="${bestMovie.grade.equals('2')}">
											<td>輔導級</td>
										</c:when>
										<c:when test="${bestMovie.grade.equals('3')}">
											<td>限制級</td>
										</c:when>
										<c:otherwise>
											<td>尚未分級</td>
										</c:otherwise>
									</c:choose>
								</p>
								<p class="fexi_header_para">
									<span>電影狀態<label>:</label></span>
									<c:choose>
										<c:when test="${bestMovie.status.equals('0')}">
											<td>上映中</td>
										</c:when>
										<c:when test="${bestMovie.status.equals('1')}">
											<td>未上映</td>
										</c:when>
										<c:when test="${bestMovie.status.equals('2')}">
											<td>已下檔</td>
										</c:when>
										<c:otherwise>
											<td>無效狀態</td>
										</c:otherwise>
									</c:choose>
								</p>											
								
								<p class="fexi_header_para fexi_header_para1">
									<span>電影評分<label>:</label></span> 
								</p>
								<div id="ratingValue3" style="display:none;">${bestMovie.rating}</div>
								<p id="rating3" class="fexi_header_para fexi_header_para1"> </p>
								<p id="noRating3" class="fexi_header_para "></p>
				                                     
				                <p class="fexi_header_para ">
									<span>電影期待度<label>:</label></span>
								</p>
								<div id="expectationValue3">
									<p class="fexi_header_para ">
									<td><fmt:formatNumber type="number" value="${bestMovie.expectation*100}"/> % 想看</td>
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
                    <h4 class="b-log"><a><span>年</span>份</a></h4>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2021" title="Release 2021">2021</a></li>
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2020" title="Release 2020">2020</a></li>
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2019" title="Release 2019">2019</a></li>
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2018" title="Release 2018">2018</a></li>
                        <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByYear&year=2017" title="Release 2017">2017</a></li>
                    </ul>
                </div>
                <div class="col-md-2 footer-grid">
                    <h4 class="b-log"><a><span>導</span>演</a></h4>
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
                    <h4 class="b-log"><a><span>最</span>新 <span>電</span>影</a></h4>
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
                    <h4 class="b-log"><a><span>演</span>員</a></h4>
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
                    <h4 class="b-log"><a><span>精</span>選 <span></span> <span>電</span>影</a></h4>
                    <ul>
                        <c:forEach var="movieVO" items="${listTopTen}" begin="0" end ="4">
                            <li><a href="genre.html">${movieVO.moviename}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="clearfix"> </div>
            </div>

        </div>
    </div>
    <!-- 通知顯示div -->
 <div class="alert-container">
 </div>
    <div class="w3agile_footer_copy">
        <p>2021 Movies Hit. All rights reserved | Design by <a>CEA103G3</a></p>
    </div>
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
    
    <script>
	    $.ajax({
			url: "<%=request.getContextPath()%>/showtime/showtime.do",
			type: "POST",
			data:{
				action: "getMovieFromHibernate",
			},
			success: function(json){
					let jsonobj = JSON.parse(json);
					for(let i = 0; i < jsonobj['movie_no'].length; i++){
						let opt = $("<option>").val(jsonobj["movie_no"][i]).text(jsonobj["movie_name"][i]);
		   				$("#movie").append(opt);
					}
				}
		});
		
	  	$("#movie").change(function(){
	    	$.ajax({
	    		url: "<%=request.getContextPath()%>/showtime/showtime.do?action=getDateFromHibernate&movie_no=" + $("#movie>option:selected:eq(0)").val(),
	    		type: "POST",
	    		success: function(json){
						let jsonobj = JSON.parse(json);
						for(let i = 0; i < jsonobj['showtime_date'].length; i++){
							let opt = $("<option>").val(jsonobj['showtime_date'][i]).text(jsonobj['showtime_date'][i]);
	         				$("#date").append(opt);
						}
	    			}
	    	});
		});
	    	
	    	$("#date").change(function(){
	        	$.ajax({
	        		url: "<%=request.getContextPath()%>/showtime/showtime.do?action=getTimeFromHibernate",
	        		type: "POST",
	        		data: {	movie_no: $("#movie>option:selected:eq(0)").val(), 
	        			   	showtime_date: $("#date>option:selected:eq(0)").val(),
	        		},
	        		success: function(json){
							let jsonobj = JSON.parse(json);
							for(let i = 0; i < jsonobj['showtime_no'].length; i++){
								let opt = $("<option>").val(jsonobj['showtime_no'][i]).text(jsonobj['showtime_time'][i]);
		         				$("#showtime").append(opt);
							}
	        			}
	        	});
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
		$("#noRating").text("尚無評分");
	}else if($("#ratingValue").text() < 1.0){
// 		$("#rating").html("");
		$("#rating").append(				
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${oneNewestComingSoonMovie.rating} 分</td>"
			
			
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
			"<td> ${oneNewestComingSoonMovie.rating} 分</td>"
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
			"<td> ${oneNewestComingSoonMovie.rating} 分</td>"
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
			"<td> ${oneNewestComingSoonMovie.rating} 分</td>"
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
			"<td> ${oneNewestComingSoonMovie.rating} 分</td>"
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
			"<td> ${oneNewestComingSoonMovie.rating} 分</td>"
		);
	}else{
		$("#noRating").text("尚無評分");
	}
}

function initialDrawRating2() {
	if($("#ratingValue2").text() <= 0){
		$("#noRating2").text("尚無評分");
	}else if($("#ratingValue2").text() < 1.0){
// 		$("#rating").html("");
		$("#rating2").append(				
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${oneNewestComingSoonMovie.rating} 分</td>"
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
			"<td> ${oneNewestComingSoonMovie.rating} 分</td>"
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
			"<td> ${oneNewestComingSoonMovie.rating} 分</td>"
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
			"<td> ${oneNewestComingSoonMovie.rating} 分</td>"
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
			"<td> ${oneNewestComingSoonMovie.rating} 分</td>"
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
			"<td> ${oneNewestComingSoonMovie.rating} 分</td>"
		);
	}else{
		$("#noRating2").text("尚無評分");
	}
}

function initialDrawRating3() {
	if($("#ratingValue3").text() <= 0){
		$("#noRating3").text("尚無評分");
	}else if($("#ratingValue3").text() < 1.0){
// 		$("#rating").html("");
		$("#rating3").append(				
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${bestMovie.rating} 分</td>"
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
			"<td> ${bestMovie.rating} 分</td>"
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
			"<td> ${bestMovie.rating} 分</td>"
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
			"<td> ${bestMovie.rating} 分</td>"
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
			"<td> ${bestMovie.rating} 分</td>"
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
			"<td> ${bestMovie.rating} 分</td>"
		);
	}else{
		$("#noRating3").text("尚無評分");
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
		$("#expectation").html("");//先將畫面清除 再畫圖層
// 		<td><fmt:formatNumber type="number" value="${movieVO.expectation*100}"/>測試數字格式化</td>	
// 		$("#expectation").append("<td>${movieVO.expectation*100}% 想看  </td>").append(canvas);
		$("#expectation").append("<td><fmt:formatNumber type="number" value="${oneNewestinTheatersMovie.expectation*100}"/> % 想看</td>").append(canvas);
		var ctx = document.getElementById("chart").getContext('2d');
		var chart = new Chart(ctx, {
			type: 'pie',
			data: {
				labels: ["想看", "不想看"],
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
		$("#noExpectation").text("尚無期待度");
	}
}


function drawPieChart2() {
	var canvas = document.createElement('canvas');
	canvas.id     = "chart2";
	canvas.style.width  = 50;
	canvas.style.height = 50;
	canvas.style.zIndex   = 99;
	if($("#expectationValue2").text() != 0){
		$("#expectation2").html("");//先將畫面清除 再畫圖層
// 		<td><fmt:formatNumber type="number" value="${movieVO.expectation*100}"/>測試數字格式化</td>	
// 		$("#expectation").append("<td>${movieVO.expectation*100}% 想看  </td>").append(canvas);
		$("#expectation2").append("<td><fmt:formatNumber type="number" value="${oneNewestComingSoonMovie.expectation*100}"/> % 想看</td>").append(canvas);
		var ctx = document.getElementById("chart2").getContext('2d');
		var chart = new Chart(ctx, {
			type: 'pie',
			data: {
				labels: ["想看", "不想看"],
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
		$("#noExpectation2").text("尚無期待度");
	}
}
</script>
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />

<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
 	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '',              //value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
 	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '',              //value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });

</script>

<script>
		//search~
    	$("#search-context").on('input propertychange', function(){
    		$("#search-results").html('<hr class="hrhr">');
    		if(!$(this).val() == ""){
    			var result;
    			console.log("送出搜尋 = " + $(this).val());
    			let json_result_list = getResults($(this).val());
        		console.log("收回結果");
//     			console.log(json_result_list);
        		if(json_result_list != undefined ){
	        		for ( movieVO of json_result_list){

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
// 						console.log(data);
						json = JSON.parse(data).results;
					}
				});
			return json;
	}
    	
    </script>
<script>
var count=0;

	    $(document).ready(function(){
	    	var notify_head = $(".cont");
	    	var slice;
	    	var memberno = ${memVO.member_no};
	   	 $.ajax({
	   		 url:"<%=request.getContextPath()%>/NotifyServlet?action=insert_For_Ajax",
	   		 data:{
	   			 "member_no":memberno
	   		 },
	   		 type:"POST",
	   		 success:function(json){
	   			 var number = document.getElementById("number");
	   			 let jsonobj = JSON.parse(json);
				 let all_list = jsonobj.all;
				 let len = jsonobj.all.length;
				 let slice="";
			     let slice1="";

				 for(let i = 0 ; i < len ; i++){
					 let jsono = JSON.parse(all_list[i]);
					 let type=jsono.type;
					 let read=jsono.read;
					 if(read==="Y"){
						 
						 if(type==="addFriend"||type==="response"){
							 slice += `<div class = "sec">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/friend.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
							 if(type==="addGroup"||type==="createGroup"||type==="goGroup"||type==="activeDismissGroup"){
							 slice += `<div class = "sec">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/group.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
							 if(type==="buyTicket"){
							 slice += `<div class = "sec">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/ticket.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
							 if(type==="reminder"||type==="dismissGroup"||type==="kickoffGroup"||type==="kickUnpaid"){
							 slice += `<div class = "sec">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/warning.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
						
					 }else{
						 
						 if(type==="addFriend"||type==="response"){
							 slice1 += `<div class = "sec new">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/friend.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
							 if(type==="addGroup"||type==="createGroup"||type==="goGroup"||type==="activeDismissGroup"){
							 slice1 += `<div class = "sec new">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/group.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
							 if(type==="buyTicket"){
							 slice1 += `<div class = "sec new">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/ticket.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
							 if(type==="reminder"||type==="dismissGroup"||type==="kickoffGroup"||type==="kickUnpaid"){
							 slice1 += `<div class = "sec new">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/warning.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
							 
							 count++;

					 }
				 }
		   		 notify_head.append(slice1); 
				 notify_head.append(slice); 
		   		 number.innerText=count;
		   		 if(number.innerText == 0){
		   			 number.style.display="none";
		   		 }
		   		 
	   			 }
	   		 })
	    	
	    })
	    
	    $(".fa-bell").click(function(){
	    	var notify_head = $(".cont");
	    	var memberno = ${memVO.member_no};

	    	 $.ajax({
		   		 url:"<%=request.getContextPath()%>/NotifyServlet?action=readNotify",
		   		 data:{
		   			 "member_no":memberno
		   		 },
		   		 type:"POST",
		   		 success:function(json){
 				 if(json=="success"){
 			   		 number.style.display="none";
 				 }else{
 					Swal.fire({
	                      position: "center",
	                      icon: "error",
	                      title: "通知連線忙線中，請稍後再試",
	                      showConfirmButton: false,
	                      timer: 1000,
	                  });
 				 }


					 
					 }


	   			 
	   			 })
		   			
		   		 });
	    	

	    </script>
	    <script>
	var MyPoint = "/NotifyWS/${memVO.member_no}";
	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
	var friendNO;
	var groupNO;
	var movieNO;
	var groupName;
	var goGroupName;
	var kickGroupName;
	var memberNO;
	var self = '${memVO.member_no}';
	var webSocket;
	var type;
	var activeDismissGroupNO;


	$(".addFriend").click(function(){
		friendNO = $(this).find("input.friendNO").val();
		sendWebSocket($(this));
	})
	$(".addGroup").click(function(){
		groupNO = $(this).find("input.groupNO").val();
		sendWebSocket($(this));
	})
	$(".buyTicket").click(function(){
		movieNO = $(this).find("input.movieNO").val();
		sendWebSocket($(this));
	})
	$(".addfriend_check_btn").click(function(){
		friendNO = $(this).find("input.friendNO").val();
		sendWebSocket($(this));
		//這邊執行insertfriend的code
	})
	$(".createGroup").click(function(){
		groupName = document.getElementById("groupName").value;  //不可放在上面宣告，因為groupname是使用者自己打要click後才會取直，所以要放在click事件內
		sendWebSocket($(this));
	})
	$(".goGroup").click(function(){
		goGroupName = $(this).find("input.goGroupName").val();
		sendWebSocket($(this));
	})
	$(".kickoffGroup").click(function(){
		kickGroupName = $(this).find("input.kickGroupName").val();
		sendWebSocket($(this));
	})
	$(".reminder").click(function(){
		memberNO = $(this).find("input.memberNO").val();
		sendWebSocket($(this));

	})
	$(".activeDismissGroup").click(function(){
		activeDismissGroupNO = $(this).find("input.activeDismissGroupNO").val();
		sendWebSocket($(this));
	})
	
	
	function sendWebSocket(item){
		let timespan = new Date();
		let timeStr = timespan.getFullYear() + "-" + (timespan.getMonth()+1).toString().padStart(2, "0") + "-" 
					+ timespan.getDate() + " " + timespan.getHours().toString().padStart(2, "0") + ":" + timespan.getMinutes().toString().padStart(2, "0");
		if(item.hasClass("addFriend")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : friendNO,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("addGroup")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : groupNO,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("buyTicket")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : movieNO,
				"message":"",
				"time":timeStr
			};
		}
		if(item.val()==1){
			var jsonObj = {
				"type" : "response",
				"sender" : self,
				"receiver" : friendNO,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("createGroup")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : groupName,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("goGroup")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : goGroupName,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("kickoffGroup")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : kickGroupName,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("reminder")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : memberNO,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("activeDismissGroup")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : activeDismissGroupNO,
				"message":"",
				"time":timeStr
			};
		}

		webSocket.send(JSON.stringify(jsonObj));
	}
	

	function connect() {
		console.log(endPointURL);
		// create a websocket
		webSocket = new WebSocket(endPointURL);

		webSocket.onopen = function(event) {
			

		};

		webSocket.onmessage = function(event) {
			console.log(event.data);
			var jsonObj = JSON.parse(event.data);
			var text = jsonObj.message;
			var time = jsonObj.time;
			var type = jsonObj.type;
			console.log(jsonObj)
			createAlert(text,time,type);
			
		};

		webSocket.onclose = function(event) {
			console.log("Disconnected!");
		};
	}
	
	function disconnect() {
		webSocket.close();
	}
	
	
// 	產生通知block在視窗右下角
	  const alertContainer = document.querySelector('.alert-container');
	  const btnCreate = document.getElementById('create');
	  
	  
	  
	  const createAlert = (text,time,type) => {
		  
	  const newAlert = document.createElement('div');
	  const closeNewAlert = document.createElement('span');
	  const imgdiv = document.createElement('div');
	  const img = document.createElement('img');
	  const txt = document.createElement('div');
	  const time_str = document.createElement('div');
	  
	  if (type==="addFriend"||type==="response"){
		  img.src="<%=request.getContextPath()%>/images/notify_icons/friend.png"
	  }
	  if (type==="addGroup"||type==="createGroup"||type==="goGroup"||type==="activeDismissGroup"){
			img.src="<%=request.getContextPath()%>/images/notify_icons/group.png"
	  }
	  if (type==="buyTicket"){
			img.src="<%=request.getContextPath()%>/images/notify_icons/ticket.png"
	  }
	  if (type==="reminder"||type==="dismissGroup"||type==="kickoffGroup"||type==="kickUnpaid"){
			img.src="<%=request.getContextPath()%>/images/notify_icons/warning.png"
	  }
	  
		  img.classList.add("alertImg");
		  imgdiv.append(img);
		  txt.innerText = text;
		  txt.classList.add("alertTxt");
		  time_str.innerText = time;
		  time_str.classList.add("alertTime");
		  txt.append(time_str);
		  newAlert.prepend(imgdiv);
		  newAlert.append(txt)
		  closeNewAlert.innerHTML = '&times;';
		  
		  newAlert.appendChild(closeNewAlert);
		  
		  newAlert.classList.add('alert');
		  
		  alertContainer.appendChild(newAlert);
		  
		  setTimeout(()=> {
		    newAlert.classList.add('fadeOut');
		  },3000)
		  
		  setTimeout(()=> {
		    newAlert.remove();
		  },5000)
		  
		
	};


	alertContainer.addEventListener('click', (e) => {
	    if(e.target.nodeName == 'SPAN') {
	        e.target.parentNode.remove();
	    }
	})


	function loginFirst(){
		Swal.fire('請先登入').then((result)=>{
			window.location.href = "<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp";
		});
	}
	function loginArticle(e){
		if(${memVO==null || memVO.member_no == 99}){
			Swal.fire('請先登入').then((result)=>{
				window.location.href = "<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp";
			});
		} else{
			window.location.href =  
				"<%=request.getContextPath()%>/front-end/article/listOneArticle2.jsp?articleno=" + e;
		}
		
	}
	
	$("#mic").on("click", function(){
		$(this).hide();
		$("#mic-using").show();
		var sound = new Audio(); 
	    sound.src = '<%=request.getContextPath()%>/img/kiss.mp3';
// 	    sound.currentTime = 3;
		var show = document.getElementById('show');
        var recognition = new webkitSpeechRecognition();
        recognition.continuous = true;
        recognition.interimResults = true;
        recognition.lang = "cmn-Hant-TW";
        recognition.onstart = function() {
            console.log('開始辨識...');
        };
        recognition.onend = function() {
            console.log('停止辨識!');
            
        };
        recognition.onresult = function(event) {
            var i = event.resultIndex;
            var j = event.results[i].length - 1;
//             show.innerHTML = event.results[i][j].transcript;
			if(event.results[i][j].transcript.indexOf("清除")> -1 ||
					event.results[i][j].transcript.indexOf("清楚")> -1 ||
					event.results[i][j].transcript == "新竹"		
			){
				console.log(event.results[i][j].transcript);
// 				event.results[i][j].transcript="";
				$("#search-context").html("");
				$("#search-results").html("");
			} else if(event.results[i][j].transcript.indexOf("停止") > -1 ||
					event.results[i][j].transcript =="屏"
			) {
// 				event.results[i][j].transcript="";
				$("#search-context").html("");
				$("#search-results").html("");
				
				recognition.stop();
				Swal.fire({
                    position: "center",
                    icon: "success",
                    title: "停止辨識",
                    showConfirmButton: false,
                    timer: 1300,
                });
				$(this).show();
				$("#mic-using").hide();
			} else if(event.results[i][j].transcript == "親一下" ||
					event.results[i][j].transcript.indexOf("一下") > -1 ||
					event.results[i][j].transcript.indexOf("記下") > -1 ||
					event.results[i][j].transcript=="靜宜"
			){
// 				event.results[i][j].transcript == "";
// 			    sound.currentTime = 3;
			    sound.play(); 
// 			    sound.currentTime = 3;
			    $("#search-context").html("");
			    $("#search-results").html("");
			}
			else{
				$("#search-context").val(event.results[i][j].transcript);
				console.log("您說的是: " + event.results[i][j].transcript);
			
			$("#search-results").html('<hr class="hrhr">');
    		if(!($("#search-context").val() == "")){
    			var result;
    			console.log("送出搜尋 = " + $("#search-context").val());
//     			let json_result_list = getResults($("#search-context").val());
//         		console.log("收回結果");
//     			console.log(json_result_list);
        		if(json_result_list != undefined ){
	        		for ( movieVO of json_result_list){
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
		        				$("#search-results").html() + result;
		        		);
	        		}
        		}
    		}
			}
        };
        recognition.start();
	});

</script>
	    

</html>