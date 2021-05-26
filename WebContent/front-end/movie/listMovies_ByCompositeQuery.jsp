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
<title>MoviesHit</title>
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
	<jsp:include page="/front_header.jsp"/>
  <!--/banner-section-->
 <!--//main-header-->
	         <!--/banner-bottom-->
			  
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
				
			<!-- //breadcrumb -->

			<!--/content-inner-section-->
<!-- 				<div class="w3_content_agilleinfo_inner"> -->
<!-- 					<div class="agile_featured_movies"> -->
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
 
   <jsp:include page="/front_footer_copy.jsp"/>
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