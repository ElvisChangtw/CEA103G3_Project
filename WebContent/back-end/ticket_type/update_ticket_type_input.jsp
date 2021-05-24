<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ticket_type.model.*"%>

<%
	Ticket_typeVO ticket_typeVO = (Ticket_typeVO) request.getAttribute("ticket_typeVO");
%>

<html>
<head>
<title>後台　修改餐點</title>
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

<style>
tr td>img {
	width: 180px;
	height: 200px;
}

#th1{
	width: 150px;
	height:100px;
	align:center;

	
}
#th2{
	width: 50px;
	align:center;
}
#th3{
	width: 150px;
	align:right;
}
#send{
align:center;	
color:red;
}
</style>

</head>

<body>


<!--/content-inner-section-->
	<div class="w3_content_agilleinfo_inner">
		<div class="agile_featured_movies">
			<div class="inner-agile-w3l-part-head">
		    	<h3 class="w3l-inner-h-title">後台　修改餐點</h3>
			</div>
	        <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
				<div id="myTabContent" class="tab-content">
					<div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
						<div class="agile-news-table">
						
						<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ticket_type/ticket_type.do" name="form1">
							<table>
								<thead class="thead">
								  <tr>
								  	<th id="th1">票種編號</th>
								  	<th id="th2">${ticket_typeVO.ticket_type_no}</th>
								  	<th></th>
								  </tr>
								</thead>
								<tbody>
									<tr>
										<td>票種</td>
										<td>
											<select name="ticket_type" style="width:165px;">
												<option value="0" ${(ticket_typeVO.ticket_type == null) ? "" : ((ticket_typeVO.ticket_type==0) ? "selected" : "")} >2D</option>
												<option value="1" ${(ticket_typeVO.ticket_type == null) ? "" : ((ticket_typeVO.ticket_type==1) ? "selected" : "")} >3D</option>
												<option value="2" ${(ticket_typeVO.ticket_type == null) ? "" : ((ticket_typeVO.ticket_type==2) ? "selected" : "")} >IMAX</option>
												<option value="3" ${(ticket_typeVO.ticket_type == null) ? "" : ((ticket_typeVO.ticket_type==3) ? "selected" : "")} >2D_IMAX</option>
												<option value="4" ${(ticket_typeVO.ticket_type == null) ? "" : ((ticket_typeVO.ticket_type==4) ? "selected" : "")} >3D_IMAX</option>
												<option value="5" ${(ticket_typeVO.ticket_type == null) ? "" : ((ticket_typeVO.ticket_type==5) ? "selected" : "")} >數位</option>
											</select>
										</td>
										<td>
										<%-- 錯誤表列 --%>
											<c:if test="${not empty errorMsgs}">
												<font style="color:red">請修正以下錯誤:</font>
												<ul>
													<c:forEach var="message" items="${errorMsgs}">
														<li style="color:red">${message}</li>
													</c:forEach>
												</ul>
											</c:if>
										</td> 
									</tr>
									<tr>
										<td>票價:</td>
										<td>
											<input type="text" name="ticket_price" value="${(ticket_typeVO==null) ? '280' : ticket_typeVO.ticket_price}">
										</td>
										<td></td> 
									</tr>
									<tr>
										<td>票種說明</td>
										<td>
											<input type="text" name="ticket_desc" value="${(ticket_typeVO==null) ? '全票' : ticket_typeVO.ticket_desc}">
										</td>
										<td></td> 
									</tr>
									<tr>
										<td></td>
										<td></td>
										<td style="text-align: right;">
											<input type="hidden" name="action" value="update">
											<input type="hidden" name="ticket_type_no" value="${ticket_typeVO.ticket_type_no}">
											<input type="submit" value="送出修改" id="send"
											class="btn btn-outline-danger" style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#FF4268; font-weight:bold; color:white;">
										</td>
									</tr>
									</tbody>
								</table>
							</FORM>
						</div>
					</div>
					<div class="blog-pagenat-wthree">
				</div>	
			</div>
		</div>
	</div>
</div>
<!--//content-inner-section-->
		
		

</body>


</html>