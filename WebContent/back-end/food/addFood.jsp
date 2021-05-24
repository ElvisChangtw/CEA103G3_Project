<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.food.model.*"%>

<%
  FoodVO foodVO = (FoodVO) request.getAttribute("foodVO");
%>

<html>
<head>
<title>��x�@�s�W�\�I</title>
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
	font-size:40px;
	
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

<script> 
 function readURL(input){
   if(input.files && input.files[0]){
     var imageTagID = input.getAttribute("targetID");
     var reader = new FileReader();
     reader.onload = function (e) {
        var img = document.getElementById(imageTagID);
        img.setAttribute("src", e.target.result)
     }
     reader.readAsDataURL(input.files[0]);
   }
 }
</script> 

</head>

<body>


<!--/content-inner-section-->
	<div class="w3_content_agilleinfo_inner">
		<div class="agile_featured_movies">
			<div class="inner-agile-w3l-part-head">
		    	<h3 class="w3l-inner-h-title">��x�@�s�W�\�I</h3>
			</div>
	        <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
				<div id="myTabContent" class="tab-content">
					<div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
						<div class="agile-news-table">
						
						<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/food/food.do" name="form1" enctype="multipart/form-data">
							<table>
								<thead class="thead">
								  <tr>
								  	<th id="th1" colspan="4" align="center"><CENTER>�п�J�\�I���</CENTER></th>
								  </tr>
								</thead>
								<tbody>
									<tr>
										<td>�\�I�Ϥ�</td>
										<td>
											<img id="preview_img" src="<%=request.getContextPath()%>/images/NoData/none2.jpg" /> 
 											<input type="file" name="food_pic" size="45" accept="image/*" onchange="readURL(this)" targetID="preview_img" 
 											value="<%=(foodVO == null) ? "" : foodVO.getFood_pic()%>" />
										</td>
										<td>
										<%-- ���~��C --%>
											<c:if test="${not empty errorMsgs}">
												<font style="color:red">�Эץ��H�U���~:</font>
												<ul>
													<c:forEach var="message" items="${errorMsgs}">
														<li style="color:red">${message}</li>
													</c:forEach>
												</ul>
											</c:if>
										</td> 
									</tr>
									<tr>
										<td>�\�I�W��</td>
										<td>
											<input name="food_name" type="text" size="22"
											value="<%=(foodVO == null) ? "" : foodVO.getFood_name()%>" />
										</td>
										<td></td> 
									</tr>
									<tr>
										<td>�\�I���� </td>
										<td>
											<select name="food_type" style="width:180px;">
													<option value= "0" <%= ((foodVO == null) ? "" : (foodVO.getFood_type().equals("0") ? "selected" : ""))%>>������</option>
													<option value= "1" <%= ((foodVO == null) ? "" : (foodVO.getFood_type().equals("1") ? "selected" : ""))%>>������</option>
													<option value= "2" <%= ((foodVO == null) ? "" : (foodVO.getFood_type().equals("2") ? "selected" : ""))%>>�z�̪���</option>
											</select>
										</td>
										<td></td> 
									</tr>
									<tr>
										<td>�\�I����</td>
										<td>
											<input name="food_price"  type="number" max="2000" min="0" style="width:180px;"
											value="<%=(foodVO == null) ? "" : foodVO.getFood_price()%>" />
										</td>
										<td></td> 
									</tr>
									<tr>
										<td>�\�I���A</td>
										<td>
											<select name="food_status" style="width:180px;">
												<option value="0" <%= ((foodVO == null) ? "" : (foodVO.getFood_status().equals("0") ? "selected" : ""))%>>�U�[</option>
												<option value="1" <%= ((foodVO == null) ? "" : (foodVO.getFood_status().equals("1") ? "selected" : ""))%>>�W�[</option>
											</select>
										</td>
										<td></td> 
									</tr>
									<tr>
										<td></td>
										<td></td>
										<td style="text-align: right;">
											<input type="hidden" name="action" value="insert">
											<input type="submit" value="�e�X�s�W" id="send"
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