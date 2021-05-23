<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.report_comment.model.*"%>
<%@ page import="com.comment.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	ReportCommentService reportCommentSvc = new ReportCommentService();
	List<ReportCommentVO> list = reportCommentSvc.getAll();
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="commentSvc" scope="page" class="com.comment.model.CommentService" />
<html>
<head>
<title>後台 瀏覽所有檢舉評論</title>
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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/table-style-back.css" />
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

<style>

</style>
</head>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<!--/content-inner-section-->
		<div class="w3_content_agilleinfo_inner">
				<div class="agile_featured_movies">
				<div class="inner-agile-w3l-part-head">
			            <h3 class="w3l-inner-h-title">後台瀏覽所有檢舉評論</h3>
					</div>
		            <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
				<div id="myTabContent" class="tab-content">
					<div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
						<div class="agile-news-table">
						<%@ include file="pages/page1.file"%>
<!-- 									<table id="table-breakpoint"> -->
								<table>
								<thead  align="center" class="123">
								  <tr class="123">
<%-- 									<th align="center"><a href="${pageContext.request.contextPath}/report_comment/reportcomment.do?action=getAllOrderByReportno"> --%>
<!-- 									檢舉編號</a></th> -->
									<th align="center">檢舉編號</th>
									<th align="center">檢舉會員</th>
									<th align="center">檢舉原因</th>	
									<th align="center">評論作者</th>
									<th align="center">評論編號</th>								
									<th align="center">檢舉時間</th>
									<th align="center">處理時間</th>
									<th align="center">處理狀態</th>
									<th align="center">備註</th>
									<th align="center">修改</th>
<!-- 									<th align="center">刪除</th> -->
								  </tr>
								</thead>
								<tbody>
								<c:forEach var="reportCommentVO" items="${list}" begin="<%=pageIndex%>"
									end="<%=pageIndex+rowsPerPage-1%>">

								  <tr>
									<td width="10px;">${reportCommentVO.reportno}</td>
									<td><img src="${pageContext.request.contextPath}/mem/mem.do?action=view_memPic&member_no=${reportCommentVO.memberno}" 
											style="border-radius:50%; width:80px; height:80px;"></td>
									<td width="150px;" style= "word-break: break-all;">${reportCommentVO.content}</td>
									<c:forEach var="commentVO" items="${commentSvc.all}">
										<c:if test="${reportCommentVO.commentno == commentVO.commentno}">
											<td><img src="${pageContext.request.contextPath}/mem/mem.do?action=view_memPic&member_no=${commentVO.memberno}" 
											style="border-radius:50%; width:80px; height:80px;"></td>
										</c:if>
									</c:forEach>
									<td width="10px;">${reportCommentVO.commentno}</td>
									<td width="105px;">
										<fmt:formatDate value="${reportCommentVO.creatdate}" pattern="yyyy-MM-dd" />
									</td>
									<td width="105px;">
										<fmt:formatDate value="${reportCommentVO.executedate}" pattern="yyyy-MM-dd" />
									</td>
									<c:choose>
										<c:when test="${reportCommentVO.status.equals('0')}">
											<td width="80px;">未審核</td>
										</c:when>
										<c:when test="${reportCommentVO.status.equals('1')}">
											<td width="80px;">審核通過</td>
										</c:when>
										<c:when test="${reportCommentVO.status.equals('2')}">
											<td width="80px;">審核未通過</td>
										</c:when>
										<c:otherwise>
											<td width="80px;">無效狀態</td>
										</c:otherwise>
									</c:choose>
									<td width="80px;" style= "word-break: break-all;">${reportCommentVO.desc}</td>
									
									<td width="50px;">
										<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_comment/reportcomment.do" style="margin-bottom: 0px;">
											<input type="submit" value="修改"
											 class="btn btn-outline-danger" style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#73BDBE; font-weight:bold; color:white;"> 
											<input type="hidden" name="reportno" value="${reportCommentVO.reportno}"> 
											<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
											<!--送出本網頁的路徑給Controller-->
											<input type="hidden" name="whichPage" value="<%=whichPage%>">
											<!--送出當前是第幾頁給Controller-->
											<input type="hidden" name="action" value="getOne_For_Update">
										</FORM>
									</td>
									
<!-- 									<td width="50px;"> -->
<%-- 										<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_comment/reportcomment.do" style="margin-bottom: 0px;"> --%>
<!-- 											<input type="submit" value="刪除">  -->
<%-- 											<input type="hidden" name="reportno" value="${reportCommentVO.reportno}">  --%>
<%-- 											<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"> --%>
<!-- 											送出本網頁的路徑給Controller -->
<%-- 											<input type="hidden" name="whichPage" value="<%=whichPage%>"> --%>
<!-- 											送出當前是第幾頁給Controller -->
<!-- 											<input type="hidden" name="action" value="delete"> -->
<!-- 										</FORM> -->
<!-- 									</td> -->
								</tr>
								</c:forEach>
								</tbody>
							</table>
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


</body>
</html>