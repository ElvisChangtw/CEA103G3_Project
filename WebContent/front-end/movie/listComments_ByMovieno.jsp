<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.List"%>
<%@ page import="com.comment.model.*"%>
<%@ page import="com.movie.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.rating.model.*"%>
<%@ page import="com.expectation.model.*"%>




<%-- <jsp:useBean id="listComments_ByMovieno" scope="request" type="java.util.Set<CommentVO>" /> <!-- 於EL此行可省略 --> --%>

<jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />
<jsp:useBean id="commentSvc" scope="page" class="com.comment.model.CommentService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<%
	MovieVO movieVO = (MovieVO) request.getAttribute("movieVO");

	CommentVO commentVO = (CommentVO) request.getAttribute("commentVO");
	
	List<CommentVO> list = commentSvc.getOneMovieComment(movieVO.getMovieno());
	pageContext.setAttribute("list", list);
	
// MemVO memVO = (MemVO) session.getAttribute("memVO");
// if (memVO == null){
// 	memVO = new MemVO();
// 	memVO.setMember_no(999);
// 	pageContext.setAttribute("needLogin", memVO);
// }else{
// 	pageContext.setAttribute("memVO", memVO);
// }

MemVO memVO = (MemVO) session.getAttribute("memVO");
if (memVO == null){
	memVO = new MemVO();
	memVO.setMember_no(99);
	pageContext.setAttribute("needLogin", memVO);
}
	pageContext.setAttribute("memVO", memVO);


	
%>
<%-- <jsp:useBean id="memVO" scope="session" type="com.mem.model.MemVO" /> --%>

<!DOCTYPE html>
<html>
<head>
<title>MoviesHit</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=big5" />
<meta name="keywords"
	content="Movies Pro Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript">
	
	
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } 


</script>
<!-- //for-mobile-apps -->
<link href="<%=request.getContextPath()%>/css/bootstrap.css"
	rel="stylesheet" type="text/css" media="all" />
<!-- pop-up -->
<link href="<%=request.getContextPath()%>/css/popuo-box.css"
	rel="stylesheet" type="text/css" media="all" />
<!-- //pop-up -->
<link href="<%=request.getContextPath()%>/css/easy-responsive-tabs.css"
	rel='stylesheet' type='text/css' />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/zoomslider.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/style.css" />
<link href="<%=request.getContextPath()%>/css/font-awesome.css"
	rel="stylesheet">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/modernizr-2.6.2.min.js"></script>
<!--/web-fonts-->
<link href='//fonts.googleapis.com/css?family=Tangerine:400,700'
	rel='stylesheet' type='text/css'>
<link
	href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900"
	rel="stylesheet">
<link href='//fonts.googleapis.com/css?family=Montserrat:400,700'
	rel='stylesheet' type='text/css'>
<!--//web-fonts-->
<script src="https://unpkg.com/ionicons@5.4.0/dist/ionicons.js"></script>

<style>
.fa-book{
color: red;
}
.fa-times{
color: #CE184B
font-size: 20px;
}

</style>
	
</head>
<body>

	<div class="single-agile-shar-buttons">
		<h2 align="center">Movie Comment</h2>
		<div class="clearfix"> </div>
	</div>

<c:forEach var="commentVO" items="${list}">
<c:if test="${commentVO.status != 1}">
	<div class="response">
			<div class="media response-info">
				<div class="media-left response-text-left">
					<c:forEach var="memVO" items="${memSvc.all}">
						<c:if test="${commentVO.memberno==memVO.member_no}">
							<a href="${pageContext.request.contextPath}/comment/comment.do?action=listComments_ByCompositeQuery&MEMBER_NO=${memVO.member_no}">
							<img class="media-object" id="css-${commentVO.commentno}"
								src="${pageContext.request.contextPath}/mem/mem.do?action=view_memPic&member_no=${memVO.member_no}"
								width="120px" height="120px" />
							</a>
							<h5>
								<a href="${pageContext.request.contextPath}/comment/comment.do?action=listComments_ByCompositeQuery&MEMBER_NO=${memVO.member_no}">${memVO.mb_name}</a>
							</h5>
						</c:if>
					</c:forEach>
				</div>
				<div class="media-body response-text-right">
					<div class="essence">
						<div class="essence_item">
							<div class="essence_item_content" >
								<span id="content-${commentVO.commentno}" style="word-break: break-all;">${commentVO.content}</span>
								<p id="seeAbout-${commentVO.commentno}" style="cursor: pointer; color:#89bdd3;">繼續閱讀</p>
							</div>
						</div>
					</div>
<script type="text/javascript">
	$(function(){
		var onoff = false;
		$('.essence .essence_item').each(function(){
			var content = $(this).find('#content-${commentVO.commentno}');
			var str = content.text();
			var see =  $(this).find('#seeAbout-${commentVO.commentno}');
			if(str.length > 35){
				content.text(str.substr(0,35)+'......');
			} 
			else{
				see.hide();
			}
			see.on('click',function(){
				if(onoff){
					content.text(str.substr(0,35)+'......');
					see.text('繼續閱讀');
				}else{
					content.text(str);
					see.text("收起評論");
				}
			onoff =! onoff
			})
		})
	});
</script>				
						
						<c:if test="${commentVO.memberno==memVO.member_no}">
						<ul>
							<li><FORM METHOD="post"
									ACTION="<%=request.getContextPath()%>/comment/comment.do"
									style="margin-bottom: 0px;">
									<li><i class="fa fa-book fa-lg" aria-hidden="true" style="color:#4194CA"></i> 
									<input type="submit" value="修改"
									class="btn btn-outline-danger btn-sm" style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#4194CA; font-weight:bold; color:white;"> 
									<input type="hidden" name="commentno" value="${commentVO.commentno}"> 
									<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
									<!--送出本網頁的路徑給Controller-->
									<!-- 目前尚未用到  --> 
									<input type="hidden" name="action" value="getOne_For_Update">
								</FORM>
							</li>

							<li><FORM METHOD="post"
									ACTION="<%=request.getContextPath()%>/comment/comment.do">
									<li><i class="fa fa-times fa-lg" aria-hidden="true" style="color:#D47070"></i> 
									<input type="submit" value="刪除"
									class="btn btn-outline-danger btn-sm" style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#D47070; font-weight:bold; color:white;"> 
									<input type="hidden" name="commentno" value="${commentVO.commentno}"> 
									<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
									<!--送出本網頁的路徑給Controller--> 
									<input type="hidden" name="action" value="delete">
								</FORM>
							</li>
						</ul>
						</c:if>
					<ul>
						<li>最後發佈時間:<fmt:formatDate value="${commentVO.modifydate}"
								pattern="yyyy-MM-dd HH:mm:ss" /></li>
						<c:if test="${needLogin.member_no != 99}">
							<c:if test="${commentVO.memberno != memVO.member_no}">
								<li><a href="<%=request.getContextPath()%>/front-end/report_comment/addReportComment.jsp?commentno=${commentVO.commentno}&memberno=${memVO.member_no}&requestURL=<%=request.getServletPath()%>&movieno=${commentVO.movieno}">
								<i class="fa fa-hand-o-left" aria-hidden="true"></i> </i>檢舉</a></li>
							</c:if>
						</c:if>
					</ul>
				</div>
				<div class="clearfix"> </div>
			</div>
		</div>
</c:if>		
</c:forEach>


	<c:if test="${memVO.mb_level.equals('2')}">
		<div class="all-comments-info">
			<h5>LEAVE A COMMENT</h5>
			<div class="agile-info-wthree-box">
				<form METHOD="post"
					ACTION="<%=request.getContextPath()%>/comment/comment.do"
					name="form1">
					<div class="col-md-3 form-info">
					<img class="media-object" src="${pageContext.request.contextPath}/mem/mem.do?action=view_memPic&member_no=${memVO.member_no}"
						width="130px" height="130px" />
						<input type="hidden" name="memberno" size="45" value="${memVO.member_no}" />
						<input type="hidden" name="movieno" value="${movieVO.movieno}">
						<input type="hidden" name="status" value="0">
						<c:if test="${not empty errorMsgs}">
							<font style="color:red">請修正以下錯誤:</font>
							<ul>
								<c:forEach var="message" items="${errorMsgs}">
									<li style="color:red">${message}</li>
								</c:forEach>
							</ul>
						</c:if>
					</div>
					<div class="col-md-9 form-info">
					<textarea name="content" id="textarea" rows="5" cols="45" maxlength="500" placeholder="Message" style='overflow-y: hidden;height:135px' onpropertychange="this.style.height = this.scrollHeight + 'px';" oninput="this.style.height = this.scrollHeight + 'px';"><%=(commentVO == null) ? "" : commentVO.getContent()%></textarea>
						<input type="hidden" name="action" value="insert"> 
						<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
						<center><input type="submit" value="SEND"></center>
					</div>
					<div class="clearfix"></div>
				</form>
			</div>
		</div>
		</c:if>
 	</div> <!--include col-md-8 latest-news-agile-left-content的結尾標籤 -->

<script>
var textarea=document.getElementById('textarea');
textarea.style.height = textarea.scrollHeight + 'px';
</script>

	
	<!--//content-inner-section -->





	<!-- Dropdown-Menu-JavaScript -->
	<script>
		$(document).ready(function() {
			$(".dropdown").hover(function() {
				$('.dropdown-menu', this).stop(true, true).slideDown("fast");
				$(this).toggleClass('open');
			}, function() {
				$('.dropdown-menu', this).stop(true, true).slideUp("fast");
				$(this).toggleClass('open');
			});
		});
	</script>
	<!-- //Dropdown-Menu-JavaScript -->
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
	<script src="<%=request.getContextPath()%>/js/jquery.magnific-popup.js"
		type="text/javascript"></script>
	<!--//pop-up-box -->

	<div id="small-dialog1" class="mfp-hide">
		<iframe
			src="https://player.vimeo.com/video/165197924?color=ffffff&title=0&byline=0&portrait=0"></iframe>
	</div>
	<div id="small-dialog2" class="mfp-hide">
		<iframe
			src="https://player.vimeo.com/video/165197924?color=ffffff&title=0&byline=0&portrait=0"></iframe>
	</div>
	<script>
		$(document).ready(function() {
			$('.w3_play_icon,.w3_play_icon1,.w3_play_icon2').magnificPopup({
				type : 'inline',
				fixedContentPos : false,
				fixedBgPos : true,
				overflowY : 'auto',
				closeBtnInside : true,
				preloader : false,
				midClick : true,
				removalDelay : 300,
				mainClass : 'my-mfp-zoom-in'
			});

		});
	</script>
	<script src="<%=request.getContextPath()%>/js/easy-responsive-tabs.js"></script>
	<script>
		$(document).ready(function() {
			$('#horizontalTab').easyResponsiveTabs({
				type : 'default', //Types: default, vertical, accordion           
				width : 'auto', //auto or any width like 600px
				fit : true, // 100% fit in a container
				closed : 'accordion', // Start closed if in accordion view
				activate : function(event) { // Callback function if tab is switched
					var $tab = $(this);
					var $info = $('#tabInfo');
					var $name = $('span', $info);
					$name.text($tab.text());
					$info.show();
				}
			});
			$('#verticalTab').easyResponsiveTabs({
				type : 'vertical',
				width : 'auto',
				fit : true
			});
		});
	</script>
	<link href="<%=request.getContextPath()%>/css/owl.carousel.css"
		rel="stylesheet" type="text/css" media="all">
	<script src="<%=request.getContextPath()%>/js/owl.carousel.js"></script>
	<script>
		$(document).ready(function() {
			$("#owl-demo").owlCarousel({

				autoPlay : 3000, //Set AutoPlay to 3 seconds
				autoPlay : true,
				navigation : true,

				items : 5,
				itemsDesktop : [ 640, 4 ],
				itemsDesktopSmall : [ 414, 3 ]

			});

		});
	</script>

	<!--/script-->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/move-top.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/easing.js"></script>

	<script type="text/javascript">
		jQuery(document).ready(function($) {
			$(".scroll").click(function(event) {
				event.preventDefault();
				$('html,body').animate({
					scrollTop : $(this.hash).offset().top
				}, 900);
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

			$().UItoTop({
				easingType : 'easeOutQuart'
			});

		});
	</script>
	<!--end-smooth-scrolling-->
	<script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
	


</body>
</html>