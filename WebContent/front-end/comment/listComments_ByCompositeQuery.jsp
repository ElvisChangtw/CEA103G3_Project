<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.comment.model.*"%>
<%@ page import="com.mem.model.*"%>

<%-- 萬用複合查詢-可由客戶端select_page.jsp隨意增減任何想查詢的欄位 --%>
<%-- 此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能--%>

<jsp:useBean id="listComments_ByCompositeQuery" scope="request" type="java.util.List<CommentVO>" /> <!-- 於EL此行可省略 -->
<jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<%
	MemVO memVO = (MemVO) request.getAttribute("memVO");

%>

<html>
<head>
<title>影評評論</title>
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
<script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
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
<jsp:include page="/front_header.jsp"/>
<!--/content-inner-section-->
		<div class="w3_content_agilleinfo_inner">
				<div class="agile_featured_movies">
				<div class="inner-agile-w3l-part-head">
			            <h3 class="w3l-inner-h-title">影評評論</h3>
					</div>
		            <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
				<div id="myTabContent" class="tab-content">
					<div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
						<div class="agile-news-table">
						<%@ include file="pages/page1_ByCompositeQuery.file"%>
<!-- 									<table id="table-breakpoint"> -->
								<table>
								<thead  align="center" class="123">
								  <tr class="123">
<!-- 								  	<th align="center">影評作者</th> -->

								  	<th><img src="${pageContext.request.contextPath}/mem/mem.do?action=view_memPic&member_no=${memVO.member_no}" 
											style="border-radius:50%; width:80px; height:80px; align:center;">
										<c:forEach var="memVO" items="${memSvc.all}">	
											<c:if test="${param.MEMBER_NO==memVO.member_no}">
												<span  style="text-align:left; display:block; font-size:15px; font-weight:bold;">${memVO.mb_name}</span>
											</c:if>
										</c:forEach>
									</th>
									<th align="center">電影名稱</th>
									<th align="center">評論內容</th>
									<th align="center">建立時間</th>
									<th align="center">修改時間</th>
								  </tr>
								</thead>
								<tbody>
								<c:forEach var="commentVO" items="${listComments_ByCompositeQuery}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
								<tr>	
<!-- 									<td colspan="2"></td> -->
								  
								 	<td><c:forEach var="movieVO" items="${movieSvc.all}">
						                    <c:if test="${commentVO.movieno==movieVO.movieno}">
							                  <a href="${pageContext.request.contextPath}/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}">
													<img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}" 
													alt="尚無圖片" width="120px;" height="150px" title="${movieVO.moviename}"/></a>
						                    </c:if>
						                </c:forEach>
									</td>
									
									
									<td width="100px;">
										<c:forEach var="movieVO" items="${movieSvc.all}">
											<c:if test="${commentVO.movieno==movieVO.movieno}">
												<a href="${pageContext.request.contextPath}/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}">
												<span style="text-align:left; display:block; font-size:15px; font-weight:bold; color:#524066;">${movieVO.moviename}</span></a>
											</c:if>
									 	</c:forEach>
									</td>	
									
									<td width="450px;">
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
			if(str.length > 15){
				content.text(str.substr(0,15)+'......');
			} 
			else{
				see.hide();
			}
			see.on('click',function(){
				if(onoff){
					content.text(str.substr(0,15)+'......');
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
									</td>
									<td width="180px;"><fmt:formatDate value="${commentVO.creatdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
									<td width="180px;"><fmt:formatDate value="${commentVO.modifydate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="blog-pagenat-wthree">
					<ul>
					<%@ include file="pages/page2_ByCompositeQuery.file"%>
					</ul>
				</div>	
			</div>
		</div>
	</div>
</div>
<!--//content-inner-section-->
<jsp:include page="/front_footer.jsp"/>



</body>
</html>