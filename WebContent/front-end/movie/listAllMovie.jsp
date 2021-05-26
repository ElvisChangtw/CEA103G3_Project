<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.movie.model.*"%>
<%@ page import="com.comment.model.*"%>

<%
	MovieService movieSvc = new MovieService();
	List<MovieVO> list = movieSvc.getAll();
	if((request.getAttribute("list") == null)){
		pageContext.setAttribute("list", list);
	}
	if((request.getAttribute("list") != null)){
		list = (List)request.getAttribute("list");
	}
	List<MovieVO> listTopFive = movieSvc.getTopFive();
	pageContext.setAttribute("listTopFive", listTopFive);
	
	List<MovieVO> latestMovie = movieSvc.getLatestMovie();
	pageContext.setAttribute("latestMovie", latestMovie);
	int z = 0;
	pageContext.setAttribute("z", z);
%>
<%-- <jsp:useBean id="memVO" scope="session" type="com.mem.model.MemVO" /> --%>
<%-- <jsp:useBean id="movieSvc1" scope="page" class="com.movie.model.MovieService" /> --%>
<!DOCTYPE html>
<html>
<head>
<title>MoviesHit</title>
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
<body>
<%-- <h1>==================${memVO.mb_name}=================================</h1> --%>
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
				<div class="w3_content_agilleinfo_inner">
						<div class="agile_featured_movies">
						<div class="inner-agile-w3l-part-head">
					            <h3 class="w3l-inner-h-title">Movie List</h3>
								<p class="w3ls_head_para">Add short Description</p>
							</div>
				            <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
						<div id="myTabContent" class="tab-content">
							<div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
								<div class="agile-news-table">
								<%@ include file="pages/page1.file"%>
<!-- 									<table id="table-breakpoint"> -->
										<table>
										<thead  align="center" style="white-space: nowrap;">
										  <tr>
											<th align="center">電影名稱</th>
											<th align="center">電影長度</th>
											<th align="center">上映日期</th>
											<th align="center">下映日期</th>
											<th align="center">狀態</th>
											<th align="center">分級</th>
											<th align="center">類型</th>
											<th align="center">評分</th>
											<th align="center">期待度</th>
											<th align="center">預告片</th>
<!-- 											<th align="center">操作</th> -->
										  </tr>
										</thead>
										<tbody>
										<c:forEach var="movieVO" items="${list}" begin="<%=pageIndex%>"
											end="<%=pageIndex+rowsPerPage-1%>">

										  <tr>
											<td width="150px;"><a href="${pageContext.request.contextPath}/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}">
											<img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}" 
											alt="尚無圖片" width="180px;" height="220px" title="${movieVO.moviename}"/> 
											<span  style="text-align: center; display:block; font-size:20px; font-weight:bold;">${movieVO.moviename}</span></a></td>
											<c:choose>
												<c:when test="${movieVO.length == 0}">
													<td width="110px;">尚無時間</td>
												</c:when>
												<c:when test="${((movieVO.length)/60)<1}">
													<td width="110px;">${movieVO.length}分鐘</td>
												</c:when>
												<c:when test="${(((movieVO.length)/60)%1)==0}">
													<td width="110px;"><fmt:formatNumber type="number"
															value="${((movieVO.length)-(movieVO.length%60))/60}" />小時</td>
												</c:when>
												<c:when test="${((movieVO.length)/60)>1}">
													<td width="110px;"><fmt:formatNumber type="number"
															value="${((movieVO.length)-(movieVO.length%60))/60}" />小時<fmt:formatNumber
															type="number" value="${movieVO.length%60}" />分鐘</td>
												</c:when>
												<c:otherwise>
													<td width="110px;">無效時間</td>
												</c:otherwise>
											</c:choose>
											<td width="105px;"><fmt:formatDate value="${movieVO.premiredate}"
												pattern="yyyy-MM-dd" /></td>
											<td width="105px;"><fmt:formatDate value="${movieVO.offdate}"
												pattern="yyyy-MM-dd" /></td>
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
												<td width="80px; !important">${movieVO.category}</td>
											<c:choose>
												<c:when test="${movieVO.rating == 0.0}">
 													<td width="100px;">尚無評分</td> 
												</c:when>
												<c:when test="${movieVO.rating <= 1.0}">
												<div class="block-stars">
													<td width="100px;">
														<ul class="w3l-ratings">	
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
														</ul>
													</td> 
	 											</div>
												<div class="clearfix"></div>
												</c:when>
												<c:when test="${movieVO.rating <= 2.0}">
												<div class="block-stars">
													<td width="100px;">
														<ul class="w3l-ratings">	
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
														</ul> 
													</td>
	 											</div>
												<div class="clearfix"></div>
												</c:when>
												<c:when test="${movieVO.rating <= 3.0}">
												<div class="block-stars">
												<td width="100px;">
													<ul class="w3l-ratings">
														<li><i class="fa fa-star" aria-hidden="true"></i></li>
														<li><i class="fa fa-star" aria-hidden="true"></i></li>
														<li><i class="fa fa-star" aria-hidden="true"></i></li>
														<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
														<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
													</ul> 
												</td>
	 											</div>
												<div class="clearfix"></div>
												</c:when>
												<c:when test="${movieVO.rating <= 4.0}">
												<div class="block-stars">
													<td width="100px;">
														<ul class="w3l-ratings">
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
														</ul> 
													</td>
	 											</div>
												<div class="clearfix"></div>
												</c:when>
												<c:when test="${movieVO.rating <= 5.0}">
												<div class="block-stars">
													<td width="100px;">
														<ul class="w3l-ratings">
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
														</ul> 
													</td>
	 											</div>
												<div class="clearfix"></div>
												</c:when>
												<c:otherwise>
													<td width="100px;">尚無評分</td>
												</c:otherwise>
											</c:choose>	
											<td id="abc_${movieVO.movieno}" style="display:none; white-space: nowrap;">${movieVO.expectation}</td>
											<td width="30px;" id="expectation_${movieVO.movieno}"> 
													
											</td>
<%-- 											<td width="80px;"><a class="w3_play_icon1" href="#small-dialog_${movieVO.movieno}">觀看</a></td> --%>
												<td width="80px;"><a class="w3_play_icon1" href="${movieVO.trailor}">觀看</a></td>
											
<!-- 											<td width="100px;"> -->
<%-- 												<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" style="margin-bottom: 0px;"> --%>
<!-- 													<input type="submit" value="修改">  -->
<%-- 													<input type="hidden" name="movieno" value="${movieVO.movieno}">  --%>
<%-- 													<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"> --%>
<!-- 													送出本網頁的路徑給Controller -->
<%-- 													<input type="hidden" name="whichPage" value="<%=whichPage%>"> --%>
<!-- 													送出當前是第幾頁給Controller -->
<!-- 													<input type="hidden" name="action" value="getOne_For_Update"> -->
<!-- 												</FORM> -->
<%-- 												<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" style="margin-bottom: 0px;"> --%>
<!-- 													<input type="submit" value="刪除">  -->
<%-- 													<input type="hidden" name="movieno" value="${movieVO.movieno}">  --%>
<%-- 													<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"> --%>
<!-- 													送出本網頁的路徑給Controller -->
<%-- 													<input type="hidden" name="whichPage" value="<%=whichPage%>"> --%>
<!-- 													送出當前是第幾頁給Controller -->
<!-- 													<input type="hidden" name="action" value="delete"> -->
<!-- 												</FORM> -->
<!-- 											</td> -->
											</tr>
											
										</c:forEach>
										</tbody>
									</table>
<%-- 									<% if (request.getAttribute("listComments_ByMovieno") != null) { %> --%>
<%-- 										<jsp:include page="listComments_ByMovieno.jsp" /> --%>
<%-- 									<% }%> --%>
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
	<jsp:include page="/front_footer.jsp"/>
	<!--/footer-bottom-->
 
    
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
		

			<!-- pop-up-box -->  
		<script src="<%=request.getContextPath()%>/js/jquery.magnific-popup.js" type="text/javascript"></script>
	<!--//pop-up-box -->
	<c:forEach var="movieVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<div id="small-dialog_${movieVO.movieno}" class="mfp-hide">
			<iframe src="https://www.youtube.com/embed/${movieVO.embed}"></iframe>
		</div>
	</c:forEach>
	
	<div id="small-dialog1" class="mfp-hide">
		<iframe src="https://player.vimeo.com/video/165197924?color=ffffff&title=0&byline=0&portrait=0"></iframe>
	</div>
	<div id="small-dialog2" class="mfp-hide">
		<iframe src="https://player.vimeo.com/video/165197924?color=ffffff&title=0&byline=0&portrait=0"></iframe>
	</div>
	<script>
		$(document).ready(function() {
		$('.w3_play_icon,.w3_play_icon1,.w3_play_icon2').magnificPopup({
			console.log("check");
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
<!-- tables -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.basictable.min.js"></script>

 <script type="text/javascript">
    $(document).ready(function() {
      $('#table').basictable();

      $('#table-breakpoint').basictable({
        breakpoint: 768
      });
	   $('#table-breakpoint1').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint2').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint3').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint4').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint5').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint6').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint7').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint8').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint9').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint10').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint11').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint12').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint13').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint14').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint15').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint16').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint17').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint18').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint19').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint20').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint21').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint22').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint23').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint24').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint25').basictable({
        breakpoint: 768
      });
	  $('#table-breakpoint26').basictable({
        breakpoint: 768
      });
    });
  </script>
<!-- //tables -->


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
$(document).ready( function() {
	<c:forEach var="movieVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		

		var canvas = document.createElement('canvas');
		canvas.id     = "chart_${movieVO.movieno}";
		canvas.width  = 150;
		canvas.height = 150;
		canvas.style.zIndex   = 99;
		
		if($("#abc_${movieVO.movieno}").text() > 0){
			$("#expectation_${movieVO.movieno}").append(canvas);
			var ctx = document.getElementById("chart_${movieVO.movieno}").getContext('2d');
	
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
		}
		else{
		
			$("#expectation_${movieVO.movieno}").text("尚無");
		}
	</c:forEach>
	
});
</script>	


</body>
</html>