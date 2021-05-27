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
	
	MovieVO movieVO = (MovieVO) request.getAttribute("movieVO"); //MovieServlet.java(Concroller), 存入req的movieVO物件
	RatingVO ratingCount = (RatingVO) request.getAttribute("ratingCount");
	ExpectationVO expectationCount = (ExpectationVO)request.getAttribute("expectationCount");
	
	java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
	pageContext.setAttribute("today", today);
	
// 	int memberNumber = 9; //到時要換成從session取memVO出來
// 	pageContext.setAttribute("memberNumber", memberNumber);

MemVO memVO = (MemVO) session.getAttribute("memVO");
if (memVO == null){
	memVO = new MemVO();
	memVO.setMember_no(99);
}
pageContext.setAttribute("memVO", memVO);
%>
<%-- <jsp:useBean id="memVO" scope="session" type="com.mem.model.MemVO" /> --%>
<%-- <jsp:useBean id="listComments_ByMovieno" scope="request" type="java.util.Set<CommentVO>" /> --%>
<%-- <jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" /> --%>
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
	<jsp:include page="/front_header.jsp"/>
  <!--/banner-section-->
 <!--//main-header-->

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
	                            						alt="" class="img-responsive" title="點擊觀賞【${movieVO.moviename}】最新預告" /> 
 	                       							</a>
 	                       						</div>
<!-- 										            <div class="video-grid-single-page-agileits"> -->
<%-- 														<div data-video="${movieVO.embed}" id="video"> <img src="${pageContext.request.contextPath}/movie/DBGifReader2.do?movieno=${movieVO.movieno}" alt="" > </div> --%>
<!-- 													</div> -->
													 <h4>Official Trailer | ${movieVO.actor}</h4>
													 <c:if test="${today.before(movieVO.offdate)}">
													 	<c:if test="${today.after(movieVO.premiredate)}">
													 		<tr>
																<td><span style="color:#524066; font-weight:1000; font-size:30px;">評分:&emsp;</span></td>
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
																<td><span style="color:#524066; font-weight:1000; font-size:30px;">期待度:&emsp;</span></td>
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
					<span>導演<label>:</label></span>${movieVO.director}
				</p>
				<div class="clearfix">
					<p class="fexi_header_para">
						<span class="conjuring_w3">演員<label>:</label></span>
						${movieVO.actor}
					</p>
					<p class="fexi_header_para">
						<span>電影類型<label>:</label></span>${movieVO.category}
					</p>
					<p class="fexi_header_para">
						<span>上映日期<label>:</label></span>
						<fmt:formatDate value="${movieVO.premiredate}"
							pattern="yyyy-MM-dd" />
					</p>
					<p class="fexi_header_para">
						<span>下映日期<label>:</label></span>
						<fmt:formatDate value="${movieVO.offdate}" pattern="yyyy-MM-dd" />
					</p>
					<p class="fexi_header_para">
						<span>片長<label>:</label></span>
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
					</p>
					<p class="fexi_header_para">
						<span>電影分級<label>:</label></span>
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
					</p>
					<p class="fexi_header_para">
						<span>電影狀態<label>:</label></span>
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
					</p>
					
					<p class="fexi_header_para fexi_header_para1">
						<span>電影評分<label>:</label></span> 
					</p>
					<div id="ratingValue" style="display:none;">${movieVO.rating}</div>
					<p id="rating" class="fexi_header_para fexi_header_para1"> </p>
					<p id="noRating" class="fexi_header_para "></p>

					<p class="fexi_header_para ">
						<span>電影期待度<label>:</label></span>
					</p>
					<div id="expectationValue" style="display:none;">${movieVO.expectation}</div>
					<p id="expectation" class="fexi_header_para ">
					</p>
					<p id="noExpectation" class="fexi_header_para "></p>
			</div>
			
			</div>
			<div class="clearfix">
<!-- 				<div class="booking-form"> -->
<!-- 					<div class="form-header"> -->
<!-- 						<h1>訂票</h1> -->
<!-- 					</div> -->
<!-- 					<form> -->
<!-- 						<div class="form-group"> -->
<!-- 							<span class="form-label">電影</span> <select class="form-control"> -->
<%-- 							<c:forEach var="movieVO" items="${movieSvc.all}"> --%>
<%-- 								<option value="${movieVO.movieno}" ${(commentVO.movieno==movieVO.movieno)? 'selected':'' } >${movieVO.moviename}  --%>
<%--  							</c:forEach>  --%>
<!-- 							</select> <span class="select-arrow"></span> -->
<!-- 						</div> -->
<!-- 						<div class="form-group"> -->
<!-- 							<span class="form-label">場次</span> <select class="form-control"> -->
<!-- 								<option>場次一</option> -->
<!-- 								<option>場次二</option> -->
<!-- 								<option>場次三</option> -->
<!-- 								<option>場次四</option> -->
<!-- 								<option>場次五</option> -->
<!-- 							</select> <span class="select-arrow"></span> -->
<!-- 						</div> -->
<!-- 						<div class="form-group"> -->
<!-- 							<span class="form-label">放映時間</span> <input class="form-control" -->
<!-- 								type="datetime-local" required> -->
<!-- 						</div> -->
<!-- 						<div class="form-btn"> -->
<!-- 							<button class="submit-btn">Book Now</button> -->
<!-- 						</div> -->
<!-- 					</form> -->
<!-- 				</div> -->
			</div>
		</div>
		<div class="clearfix"></div>
 	</div> <!--include latest-news-agile-info 的結尾標籤-->

	</div><!--include agile_featured_movies 的結尾標籤-->
	</div><!--include w3_content_agilleinfo_inner 的結尾標籤-->
	<!--//content-inner-section-->

	<!--/footer-bottom -->
 <jsp:include page="/front_footer.jsp"/>


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
		$("#expectation").html("");//先將畫面清除 再畫圖層
		$("#expectation").append("<td><fmt:formatNumber type="number" value="${movieVO.expectation*100}"/> % 想看</td>"+"<td> (已有 <fmt:formatNumber type="number" value="  ${expectationCount.expectation}"/> 人投票)</td>").append(canvas);
		var ctx = document.getElementById("chart").getContext('2d');
		var chart = new Chart(ctx, {
			type: 'pie',
			data: {
				labels: ["想看", "不想看"],
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
		$("#noExpectation").text("尚無期待度");
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
		$("#expectation").html("");//先將畫面清除 再畫圖層
		$("#noExpectation").html("");
		$("#expectation").append("<td> "+nowExpectation+"% 想看  </td>"+"<td> (已有 "+ totalExpectation + " 人投票)</td>").append(canvas);
		var ctx = document.getElementById("chart").getContext('2d');
		var chart = new Chart(ctx, {
			type: 'pie',
			data: {
				labels: ["想看", "不想看"],
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
			$("#noExpectation").text("尚無期待度");
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
		$("#expectation").html("");//先將畫面清除 再畫圖層
		$("#noExpectation").html("");
		$("#expectation").append("<td> "+nowExpectation+"% 想看  </td>"+"<td> (已有 "+ totalExpectation + " 人投票)</td>").append(canvas);
		var ctx = document.getElementById("chart").getContext('2d');
		var chart = new Chart(ctx, {
			type: 'pie',
			data: {
				labels: ["想看", "不想看"],
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
			$("#noExpectation").text("尚無期待度");
		}
	}
	
	
$(document).ready(function(){
	$("#t1").click(function(){
		if(${memVO.member_no ==99 }){

			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: '請先登入',
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
				url:"<%=request.getContextPath()%>/expectation/expectation.do",
				data:{
					"memberno":memberno,	
					"movieno":movieno,
					"expectation":expectation,
					"action": "insertOrUpdate"
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
	            title: "我好期待RRRRR",
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
		if(${memVO.member_no}==99){
			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: '請先登入',
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
	            title: "我好失望RRRRR",
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
		$("#noRating").text("尚無評分");
	}else if($("#ratingValue").text() < 1.0){
// 		$("#rating").html("");
		$("#rating").append(				
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> ${movieVO.rating} 分</td>"+
			"<td> (已有<fmt:formatNumber type="number" value=" ${ratingCount.rating}"/> 人投票)</td>"
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
			"<td> ${movieVO.rating} 分</td>"+
			"<td> (已有<fmt:formatNumber type="number" value=" ${ratingCount.rating}"/> 人投票)</td>"
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
			"<td> ${movieVO.rating} 分</td>"+
			"<td> (已有<fmt:formatNumber type="number" value=" ${ratingCount.rating}"/> 人投票)</td>"
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
			"<td> ${movieVO.rating} 分</td>"+
			"<td> (已有<fmt:formatNumber type="number" value=" ${ratingCount.rating}"/> 人投票)</td>"
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
			"<td> ${movieVO.rating} 分</td>"+
			"<td> (已有<fmt:formatNumber type="number" value=" ${ratingCount.rating}"/> 人投票)</td>"
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
			"<td> ${movieVO.rating} 分</td>"+
			"<td> (已有<fmt:formatNumber type="number" value=" ${ratingCount.rating}"/> 人投票)</td>"
		);
	}else{
		$("#noRating").text("錯誤評分");
	}
}


// console.log("ratingValue" + $("#ratingValue").text());
function drawRating(newRating,countRating) {
	console.log("newRating="+newRating);
	console.log("countRating="+countRating);
	let nowRating = newRating;
	let totalRating = countRating;
	if(totalRating <= 0){
		$("#noRating").text("尚無評分");
	}else if(newRating < 1.0){
		$("#rating").html("");
		$("#noRating").html("");
		$("#rating").append(				
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<a><i class=\"fa fa-star-o fa-lg\" aria-hidden=\"true\"></i></a>"+
			"<td> "+nowRating+" 分</td>"+
			"<td> (已有 "+totalRating+" 人評分)</td>"
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
			"<td> "+nowRating+" 分</td>"+
			"<td> (已有 "+totalRating+" 人評分)</td>"
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
			"<td> "+nowRating+" 分</td>"+
			"<td> (已有 "+totalRating+" 人評分)</td>"
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
			"<td> "+nowRating+" 分</td>"+
			"<td> (已有 "+totalRating+" 人評分)</td>"
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
			"<td> "+nowRating+" 分</td>"+
			"<td> (已有 "+totalRating+" 人評分)</td>"
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
			"<td> "+nowRating+" 分</td>"+
			"<td> (已有 "+totalRating+" 人評分)</td>"
		);
	}else{
		$("#noRating").text("錯誤評分");
	}
}

$(document).ready(function(){
	$("#s1").click(function(){
		if(${memVO.member_no}==99){
			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: '請先登入',
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
	            title: "一星哭哭",
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
		if(${memVO.member_no}==99){
			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: '請先登入',
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
	            title: "二星呼呼",
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
		if(${memVO.member_no}==99){
			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: '請先登入',
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
	            title: "三星普普",
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
		if(${memVO.member_no}==99){
			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: '請先登入',
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
	            title: "四星推推",
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
		if(${memVO.member_no}==99){
			Swal.fire({
				  position: 'center',
				  icon: 'error',
				  title: '請先登入',
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
	            title: "五星吹捧",
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