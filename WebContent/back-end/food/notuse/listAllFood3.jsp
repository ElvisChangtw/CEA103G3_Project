<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.food.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	FoodService foodSvc = new FoodService();
    List<FoodVO> list = foodSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<html>
<head>
<title>後台 所有餐點資料</title>
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
<script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<style>

</style>
</head>
<body>
	<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

	<!--/content-inner-section-->
		<div class="w3_content_agilleinfo_inner">
				<div class="agile_featured_movies">
				<div class="inner-agile-w3l-part-head">
			            <h3 class="w3l-inner-h-title">後台 所有餐點資料</h3>
			            <li><a href='<%=request.getContextPath()%>/back-end/food/addFood.jsp'>Add Food</a></li>
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
									<th>餐點編號</th>
									<th>餐點圖片</th>
									<th>餐點名稱</th>
									<th>餐點種類</th>
									<th>場點價格</th>
									<th>餐點狀態</th>
									<th>修改</th>
									<th>上架/下架</th>
								  </tr>
								</thead>
								<tbody>
								<c:forEach var="foodVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
								  <tr>
								  	<td id="id">${foodVO.food_no}</td>
								  	<td><img src="<%=request.getContextPath()%>/food/food.do?action=getPic&food_no=${foodVO.food_no}" style="width: 150px; height: 170px;"></td>
									<td>${foodVO.food_name}</td>
									<td>
										<c:choose>
											<c:when test="${foodVO.food_type == 0 }">
												熟食類
											</c:when>
											<c:when test="${foodVO.food_type == 1 }">
												飲料
											</c:when>
											<c:when test="${foodVO.food_type == 3 }">
												爆米花類
											</c:when>
										</c:choose>
									</td>
									<td>${foodVO.food_price}</td>
									<td id="status-${foodVO.food_no}">
										${foodVO.food_status == 0 ? "下架" : "上架"}
									</td>
									<td>
									  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/food/food.do" style="margin-bottom: 0px;">
									     <input type="submit" value="修改"
									     class="btn btn-outline-danger" style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#73BDBE; font-weight:bold; color:white;">
									     <input type="hidden" name="food_no"  value="${foodVO.food_no}">
									     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
									</td>
									<td>
									     <input id="${foodVO.food_no}" type="button" value="${foodVO.food_status == 1 ? "下架" : "上架"}" 
									     class="btn btn btn-primary" style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#FC9C9D; font-weight:bold; color:white;">
									</td>
									
									
									
<!-- 									<td> -->
<%-- 										<a href="${pageContext.request.contextPath}/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}"> --%>
<%-- 										<img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}"  --%>
<%-- 										alt="尚無圖片" width="80px;" height="100px" title="${movieVO.moviename}"/>  --%>
<%-- 										<span  style="text-align: center; display:block; font-size:10px; font-weight:bold;">${movieVO.moviename}</span></a></td> --%>
<!-- 									<td> -->
<%-- 										<a href="${pageContext.request.contextPath}/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}"> --%>
<%-- 										<img src="${pageContext.request.contextPath}/movie/DBGifReader2.do?movieno=${movieVO.movieno}"  --%>
<%-- 										alt="尚無圖片" width="80px;" height="100px" title="${movieVO.moviename}"/></a></td> --%>
									
<%-- 									<td width="50px;">${movieVO.director}</td> --%>
<%-- 									<td width="50px;">${movieVO.actor}</td> --%>
<%-- 									<td width="80px;">${movieVO.category}</td> --%>
									
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${movieVO.length >0}"> --%>
<%-- 											<td width="90px;">${movieVO.length}分鐘</td> --%>
<%-- 										</c:when> --%>
<%-- 										<c:otherwise> --%>
<!-- 											<td width="90px;">尚無時間</td> -->
<%-- 										</c:otherwise> --%>
<%-- 									</c:choose> --%>
									
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${movieVO.status.equals('0')}"> --%>
<!-- 											<td width="70px;">上映中</td> -->
<%-- 										</c:when> --%>
<%-- 										<c:when test="${movieVO.status.equals('1')}"> --%>
<!-- 											<td width="70px;">未上映</td> -->
<%-- 										</c:when> --%>
<%-- 										<c:when test="${movieVO.status.equals('2')}"> --%>
<!-- 											<td width="70px;">已下檔</td> -->
<%-- 										</c:when> --%>
<%-- 										<c:otherwise> --%>
<!-- 											<td width="70px;">無效狀態</td> -->
<%-- 										</c:otherwise> --%>
<%-- 									</c:choose> --%>
									
<!-- 									<td width="105px;"> -->
<%-- 										<fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /><br> --%>
<%-- 										<fmt:formatDate value="${movieVO.offdate}" pattern="yyyy-MM-dd" /> --%>
<!-- 									</td> -->
									
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${movieVO.grade.equals('0')}"> --%>
<!-- 											<td width="70px;">普遍級</td> -->
<%-- 										</c:when> --%>
<%-- 										<c:when test="${movieVO.grade.equals('1')}"> --%>
<!-- 											<td width="70px;">保護級</td> -->
<%-- 										</c:when> --%>
<%-- 										<c:when test="${movieVO.grade.equals('2')}"> --%>
<!-- 											<td width="70px;">輔導級</td> -->
<%-- 										</c:when> --%>
<%-- 										<c:when test="${movieVO.grade.equals('3')}"> --%>
<!-- 											<td width="70px;">限制級</td> -->
<%-- 										</c:when> --%>
<%-- 										<c:otherwise> --%>
<!-- 											<td width="70px;">尚未分級</td> -->
<%-- 										</c:otherwise> --%>
<%-- 									</c:choose> --%>
										
<%-- 									<td width="50px;"><a class="w3_play_icon1" href="${movieVO.trailor}">觀看</a></td> --%>
									
<!-- 									<td width="50px;"> -->
<%-- 										<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" style="margin-bottom: 0px;"> --%>
<!-- 											<input type="submit" value="修改">  -->
<%-- 											<input type="hidden" name="movieno" value="${movieVO.movieno}">  --%>
<%-- 											<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"> --%>
<!-- 											送出本網頁的路徑給Controller -->
<%-- 											<input type="hidden" name="whichPage" value="<%=whichPage%>"> --%>
<!-- 											送出當前是第幾頁給Controller -->
<!-- 											<input type="hidden" name="action" value="getOne_For_Update"> -->
<!-- 										</FORM> -->
<!-- 									</td> -->
									
<!-- 									<td width="50px;"> -->
<%-- 										<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" style="margin-bottom: 0px;"> --%>
<!-- 											<input type="submit" value="刪除">  -->
<%-- 											<input type="hidden" name="movieno" value="${movieVO.movieno}">  --%>
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


<script>
console.log(${foodVO.food_no});
		
// function changeStatus(){
// 	$(this).click(function(){

// 		console.log("${foodVO.food_no}")
// 		let food_no = $(this).attr('id');
		
// 		$.ajax({
<%-- 			url:"<%=request.getContextPath()%>/food/food.do?action=updateStatus", --%>
// 			data:{
// 				food_no:food_no
// 			},
// 			type:"POST",
			
// // 			$("#status").html("");
// // 			$("#status").append("OK");
// 			success:function(json){
// 				let jsonobj = JSON.parse(json);
// 				let newStatus = jsonobj.newStatus;
// 				$('#status-${foodVO.food_no}').text(newStatus);

// 			}
// 		 });
// 	})
// };		
	
	$("input[type=button]").click(function(){
		console.log("123")
		console.log("${foodVO.food_no}")
		let food_no = $(this).attr('id');
		console.log(food_no);
		$.ajax({
			url:"<%=request.getContextPath()%>/food/food.do?action=updateStatus",
			data:{
				food_no:food_no
			},
			type:"POST",
			
// 			$("#status").html("");
// 			$("#status").append("OK");
			success:function(json){
				let jsonobj = JSON.parse(json);
				let newStatus = jsonobj.newStatus;
				let s;
				let t;
				if(newStatus == "1"){
					s = "上架";
					t = "下架";
					
				}else{
					s = "下架";
					t = "上架";
				}
				$("#"+ food_no).parent().prev().prev().text(s);
				$("#"+ food_no).val(t);
				

			}
		 });
	});
		
		
</script>

</body>
</html>