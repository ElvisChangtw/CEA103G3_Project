<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ord_ticket_type.model.*"%>
<%@ page import="com.ord_food.model.*"%>
<%@ page import="com.food.model.*"%>
<%@ page import="com.ticket_type.model.*"%>
<%@ page import="java.util.*"%>

<%
	java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:00");; 
	pageContext.setAttribute("df",df);
// 	HttpSession session1 = request.getSession();
// 	String member_no = "1";
// 	session1.setAttribute("member_no", member_no);
%>


<jsp:useBean id="ticket_typeSvc" scope="page" class="com.ticket_type.model.Ticket_typeService" />
<jsp:useBean id="foodSvc" scope="page" class="com.food.model.FoodService" />
<jsp:useBean id="showtimeSvc" scope="page" class="com.showtime.model.ShowtimeService" />
<jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />
<jsp:useBean id="theaterSvc" scope="page" class="com.theater.model.TheaterService" />


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>訂單票種資料新增 - addOrd_ticket_type2.jsp</title>

<style>
body{
	box-sizing: border-box;
}
table {
	width: 100%;
	background-color: white;
	margin-top: 20px;
	/* 	margin-bottom: 1px; */
}

table, th, td {
	border: 0px;
}

th {
	background-color: #337ab7;
	text-align: left;
	color: white;
}

td {
	line-height: 30px;
	color: black;
}
#main{
	margin-left:20px;
}
#div1, #div6 {
	width: 660px;
/* 	height: 150px; */
/* 	background-color: rgba(0, 0, 0, 0.5); */
	padding-top: 10px;
	padding-bottom: 10px;
}
#div2,#div7{
	background-color: rgba(0, 0, 0, 0.5);
	padding-top: 10px;
	padding-bottom: 10px;
}

FORM {
	margin-bottom: 20px;
}

#h2, #h3 {
	text-align: center;
	margin-top: 20px;
	color: white; 
}

#p1, #p2 {
	text-align: center;
	color: white;
}
.product{
 	border-bottom:1px solid lightgray; 
	text-align:right;
	font-size:10px;
	margin-bottom:0px;
	margin-top:0px;
/* 	margin-right:10px; */
}
#total_price{
/*  	border-bottom:1px solid lightgray;  */
	text-align:right;
	font-size:10px;
	margin-bottom:0px;
	margin-top:0px;
 	margin-right: 3px;
}
.text{
/* 	border-bottom:1px solid lightgray; */
	font-size:10px;
	margin-bottom:0px;
}

 .img{ 
   	width: 115px; 
   	height: 100px; 
   	margin: 0 auto; 
   } 
 .food{
 	text-align:center;
 	background-color:aqua;
 	border: 1px solid red;
 }


</style>
<!-- <script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js" integrity="sha384-slN8GvtUJGnv6ca26v8EzVaR9DC58QEwsIk9q1QXdCU8Yu8ck/tL/5szYlBbqmS+" crossorigin="anonymous"></script> -->
<!-- <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"> -->
</head>
<body bgcolor='white'>

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
<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/order/order.do" name="form1">

	<div id="main" class="container" >
	
	  <div class="row">
		<div id="div1" style="display:inline-block" class="col-md-8">
			<div style="margin-bottom:5px; padding: 10px 0; background-color:white;" class="col-md-12" >
				<c:choose>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(param.showtime_no)
					.movie_no).grade == 0}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/0.jpg" style="width:120px; height: 84px;">
					</c:when>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(param.showtime_no)
					.movie_no).grade == 1}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/1.jpg" style="width:120px; height: 84px;">
					</c:when>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(param.showtime_no)
					.movie_no).grade == 2}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/2.jpg" style="width:120px; height: 84px;">
					</c:when>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(param.showtime_no)
					.movie_no).grade == 3}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/3.jpg" style="width:120px; height: 84px;">
					</c:when>
				</c:choose>
				<h2 style="display: inline-block; margin-top: -7px; margin-left: 20px; margin-top:10px; vertical-align:top; width:200px;">
					<c:choose>
						<c:when test="${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(param.showtime_no)
						.theater_no).theater_type == 0}">
							(2D)
						</c:when>
						<c:when test="${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(param.showtime_no)
						.theater_no).theater_type == 1}">
							(3D)
						</c:when>
						<c:when test="${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(param.showtime_no)
						.theater_no).theater_type == 2}">
							(IMAX)
						</c:when>
						<c:when test="${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(param.showtime_no)
						.theater_no).theater_type == 3}">
							(2D,IMAX)
						</c:when>
						<c:when test="${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(param.showtime_no)
						.theater_no).theater_type == 4}">
							(3D,IMAX)
						</c:when>
						<c:when test="${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(param.showtime_no)
						.theater_no).theater_type == 5}">
							(數位)
						</c:when>
					</c:choose>
					
					${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(param.showtime_no)
						.movie_no).moviename}
				</h2>
				<p style="display: inline-block; margin-top: 35px; margin-left: 3px; vertical-align:top; float:right; line-height:0;" >
					<i class="fas fa-clock" style="margin-right:5px; color:#008080; font-size:14px;"></i> ${df.format(showtimeSvc.getOneShowtime(param.showtime_no).showtime_time)}
					<br>
					<br>
					<i class="fas fa-video" style="margin-right:5px; color:#008080;  font-size:14px;"></i>${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(param.showtime_no)
						.theater_no).theater_name}
				</p>
			</div>
			<div id="div2" >
				<h2 id="h2">選擇電影票</h2>
				<p id="p1" style=" width: 400px; margin: auto;">
				&nbsp選擇您希望購買的電影票張數和類型.請注意系統將自動為您保留可訂的最佳座位, 每筆交易最多可購買10張電影票</p>
			</div>
			<table>
				<tr>
					<th>票種</th>
					<th>價格</th>
					<th>數量</th>
				</tr>
				<c:forEach var="ticket_typeVO" items="${ticket_typeSvc.all}">
					<c:if test="${theaterSvc.getOneTheater(showtimeSvc.
					getOneShowtime(param.showtime_no).theater_no).theater_type == ticket_typeVO.ticket_type}">
						<tr>
							<td>${ticket_typeVO.ticket_desc}</td>
							<td>$ ${ticket_typeVO.ticket_price}</td>
							<td><select name="ticket_count">
									<option value="0">0</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
							</select>
						</tr>
						<input type="hidden" name="ticket_type_no"
							value="${ticket_typeVO.ticket_type_no}">
						<input type="hidden" name="ticket_price"
							value="${ticket_typeVO.ticket_price}">
					</c:if>
				</c:forEach>
			
			</table>
			
			<div id="div7" style="margin-top:20px;">
				<h2 id="h3">選擇餐飲</h2>
				<p id="p2">請選擇販賣部商品並結帳</p>
			</div>
			<div class="col-md-12" style="padding:0px;">
				<div class="row">
					<c:forEach var="foodVO" items = "${foodSvc.all}">
						<div class="food${foodVO.food_type} col-sm-3"style="padding:0px;display: inline-block; margin-top: 20px; text-align:center;">
							<img class="img" src="<%=request.getContextPath()%>/food/food.do?action=getPic&food_no=${foodVO.food_no}" >
							<p>${foodVO.food_name}</p>
							<p>$ ${foodVO.food_price}</p>
							<select name="food_count">
								<option value="0">0</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
							</select>
							<input type="hidden" name="food_no"  value="${foodVO.food_no}">
							<input type="hidden" name="food_price"  value="${foodVO.food_price}">
						</div>
					</c:forEach>
				</div>
			</div>
			<input type="hidden" name="action" value="sendToST">
			<input type="hidden" name="showtime_no" value="${param.showtime_no}">
			<input type="button"  id="btn" value="繼續   →"  style="margin-top: 20px; background-color: #337ab7; 
			color: white; border: white; width:100px; height:50px; margin-left: 80%;">
			
		</div>

		<div class="col-md-2" style="margin-top:114px; over"  >
			<div class="row" >
				<div class="col-md-12" style="padding:0;border: 1px solid black;">
					<div style="height:40px;background-color: #337ab7; border: 1px solid black;">
						<div style="margin-top: 7px; margin-left:40px; color:white;">會員專區</div>
					</div>
					<div style="height:50px; margin-top:10px; font-size:10px; color:#777777; padding-left:10px;">
						<c:if test="${sessionScope.memVO==null}">
							尚未登入
						</c:if>
						<c:if test="${sessionScope.memVO!=null}">
							嗨 ${sessionScope.memVO.mb_name} 您好
						</c:if>
					</div>
				</div>
				
				<div class="col-md-12" style="padding:0; border: 1px solid black; margin-top:20px;">
					<div style="height:40px; background-color: #337ab7; padding:7px;">
						<div style=" margin-left:40px; color:white;">購物清單</div>
					</div>
					<div style="font-size:10px; color:#777777; padding-left:10px; margin-top: 0px;">
						<table style="width:100%; padding:0; margin-top: 0;">
							<tr id="total">
								<td>
									<p id="total_price">合計:0</p>
								</td>
							</tr>
						
						</table>
					</div>
				</div>
			</div>
		</div>

	  </div>
	</div>
</FORM>
<script>
	$("#btn").click(test);
	
	$("select[name=ticket_count]").change(function(){
		let productPrice = $(this).parent().prev().text().substr(1);
		let productCount = parseInt($(this).val());
		let productName = $(this).parent().prev().prev().text();
		console.log(productPrice);
		console.log(productCount);
		console.log(productName);
		let tableStructure = "";
		
		let target = $(this).attr("name");
		let idName = "#" + productName;
		if (productCount !== 0) {
			if ($(idName)) {
				$(idName).remove();
			}
		
			tableStructure += "<tr id='"+productName +"'><td>";
			tableStructure += "<p class='text'>" + productName + "</p>";
			tableStructure += "<p class='product'>";
			tableStructure += "<span style='margin:3px;'>"
					+ productPrice + "</span>X";
			tableStructure += "<span style='margin:3px;'>"
					+ productCount + "</span>=";
			tableStructure += "<span class='subtotal' style='margin:3px;'>"
					+ (productPrice * productCount)
					+ "</span>";
			tableStructure += "</p></td></tr>";
		
		} else {
			$(idName).remove();
		}
		$("#total").before(tableStructure);
		
		let orderList = $(".subtotal");
		let totalPrice = 0;

		for (let i = 0; i < orderList.length; i++) {
			totalPrice += parseInt($(orderList[i]).text());
		}
		$("#total_price").text("合計: " + totalPrice);
		
	});
	
	$("select[name=food_count]").change(function(){
		let productPrice = $(this).prev().text().substr(1);
		let productCount = parseInt($(this).val());
		let productName = $(this).prev().prev().text();
		console.log(productPrice);
		console.log(productCount);
		console.log(productName);
		let tableStructure = "";
		
		let target = $(this).attr("name");
		let idName = "#" + productName;
		if (productCount !== 0) {
			if ($(idName)) {
				$(idName).remove();
			}
		
			tableStructure += "<tr id='"+productName +"'><td>";
			tableStructure += "<p class='text'>" + productName + "</p>";
			tableStructure += "<p class='product'>";
			tableStructure += "<span style='margin:3px;'>"
					+ productPrice + "</span>X";
			tableStructure += "<span style='margin:3px;'>"
					+ productCount + "</span>=";
			tableStructure += "<span class='subtotal' style='margin:3px;'>"
					+ (productPrice * productCount)
					+ "</span>";
			tableStructure += "</p></td></tr>";
		
		} else {
			$(idName).remove();
		}
		$("#total").before(tableStructure);
		
		let orderList = $(".subtotal");
		let totalPrice = 0;

		for (let i = 0; i < orderList.length; i++) {
			totalPrice += parseInt($(orderList[i]).text());
		}
		$("#total_price").text("合計: " + totalPrice);
		
	});
	
	
	
	
	
	
	function test(){
		
		let option = $("[name='ticket_count']").children("option");
// 		alert(option.length);
		tmp = true;
		let count = 0;
		for(let a = 0; a < option.length; a++){
// 			alert(option.eq(a).prop("selected"));
			if(option.eq(a).prop("selected") == true){
				count += parseInt(option.eq(a).val(),10);
				
			}
		}
// 		alert("count = " + count);
		if(count==0){
			swal.fire({
				icon:'error',
				text: '請至少選一張票'
			});
		}else{
				$(this).attr("type", "submit");
		}
		
	}

</script>
<jsp:include page="/front_footer_copy.jsp"/>
</body>
</html>