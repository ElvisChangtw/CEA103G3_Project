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
	
	int count = (Integer)session.getAttribute("count");
	System.out.println(count);
%>


<jsp:useBean id="ticket_typeSvc" scope="page" class="com.ticket_type.model.Ticket_typeService" />
<jsp:useBean id="foodSvc" scope="page" class="com.food.model.FoodService" />
<jsp:useBean id="showtimeSvc" scope="page" class="com.showtime.model.ShowtimeService" />
<jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />
<jsp:useBean id="theaterSvc" scope="page" class="com.theater.model.TheaterService" />


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>訂單票種資料新增 - addOrd_ticket_type2.jsp</title>

<style>
body{
	box-sizing: border-box;
}

td {
	line-height: 30px;
	color: black;
}
#main{
	margin-left:20px;
}
#div1, #div6 {
/* 	width: 600px; */
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
		label {
			padding: 0;
			margin: 2px 2px 0px 0px;
			cursor: pointer;
/* 			background-color: lightgreen;  */
		}
		input[type=checkbox] {
			display: none;
			background-color: lightgreen;
		}
		span{
			font-size: 8px;
			font-family: Arial;
			text-align: center;
			/*  */
			line-height: 25px;
			/* background-color: lightgreen; */
		}

		input[type=checkbox]+span {
			display: inline-block;
			vertical-align:middle;
			background-color: lightgreen;
			/* 			padding: 3px ; */
			border: 1px solid; /* gray; */
			color: #444;
			user-select: none; /* 防止文字被滑鼠選取反白 */
			width: 25px;
			height: 25px;		
			margin: 2px 2px;
		}

		input[type=checkbox]:checked+span {
			/* 			color: yellow; */
			background-color: #ADD8E6;

		}

		input[type=checkbox]+span:first-child {
			visibility: hidden;
		}

		#d1{
			margin: 10px 20px;
			font-size: 27px;
		}
		input#submit{
			margin-left: 330px;
		}
		button{
			width: 25px;
			height: 25px;
		}
		#d1 > label:nth-child(2){
			visibility:  hidden;
			width: 20px;
			height: 20px;
		}
		#d2{
			border: 1px solid black;
			width: 690px;
			height: 30px;
			text-align: center;
			background: orange;
			font-size: 20px;
			line-height: 30px;
		}
		#d3, #d4, #d5{
			width:25px;
			height:25px;
			border: 1px solid black;
			display:inline-block;
		}
		#d3{
			margin-left:300px;
			background-color:lightgreen;
			
		}
		#d4{
			margin-left:20px;
			background-color: red;
		}
		#d5{
			margin-left:20px;
			background-color: #ADD8E6;
		}
		#d0{
			display:inline-block;
			display: flex;
			align-items:center;
		}

</style>
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js" integrity="sha384-slN8GvtUJGnv6ca26v8EzVaR9DC58QEwsIk9q1QXdCU8Yu8ck/tL/5szYlBbqmS+" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
</head>
<body bgcolor='white'>

<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/order/order.do" name="form1">
	<div id="main" class="container" >
	  <div class="row">
		<div id="div1" style="display:inline-block" class="col-8">
			<div style="margin-bottom:5px; padding: 10px 0;">
				<c:choose>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(param.showtime_no)
					.movie_no).grade == 0}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/0.jpg" style="width:100px; height: 70px;">
					</c:when>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(param.showtime_no)
					.movie_no).grade == 1}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/1.jpg" style="width:100px; height: 70px;">
					</c:when>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(param.showtime_no)
					.movie_no).grade == 2}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/2.jpg" style="width:100px; height: 70px;">
					</c:when>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(param.showtime_no)
					.movie_no).grade == 3}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/3.jpg" style="width:100px; height: 70px;">
					</c:when>
				</c:choose>
				<h2 style="display: inline-block; margin-top: -7px; margin-left: 65px; vertical-align:top; width:200px;">
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
				<p style="display: inline-block; margin-top: 0px; margin-left: 64px; vertical-align:top; width: 161px;" >
					<i class="fas fa-clock" style="margin-right:5px; color:#008080;"></i> ${df.format(showtimeSvc.getOneShowtime(param.showtime_no).showtime_time)}
					<br>
					<br>
					<i class="fas fa-video" style="margin-right:5px; color:#008080;"></i>${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(param.showtime_no)
						.theater_no).theater_name}
				</p>
			</div>
			<div id="div2" >
				<h2 id="h2">選擇座位</h2>
				<p id="p1">選擇您希望購買的電影票張數和類型.請注意系統將自動為您保留可訂的最佳座位, 每筆交易最多可購買10張電影票</p>
			</div>
			
			<div id="d0">
				<div id="d3">
				</div>&nbsp&nbsp可選擇
				<div id="d4">
				</div>&nbsp&nbsp已售出
				<div id="d5">
				</div>&nbsp&nbsp您的座位
			</div>
		
			<div id="d1" style="width:700px;">
				<div id="d2">
					螢幕位置
				</div>
			</div>
			
			<input type="hidden" name="action" value="checkOrd">
			<input type="button"  id="btn" value="繼續   →"  style="margin-top: 20px; background-color: #337ab7; 
			color: white; border: white; width:100px; height:50px; margin-left: 80%;">
			
		</div>
		<div class="col-0.5"></div>
		<div class="col-2" style="margin-top:150px;"  >
			<div class="row" >
				<div class="col-12" style="padding:0;border: 1px solid black;">
					<div style="height:40px;background-color: #337ab7; border: 1px solid black;">
						<div style="margin-top: 7px; margin-left:40px; color:white;">會員專區</div>
					</div>
					<div style="height:50px; margin-top:10px; font-size:10px; color:#777777; padding-left:10px;">
						${sessionScope.member_no == null ? "尚未登入" : '嗨!TONY 您好'}
					</div>
				</div>
				
				<div class="col-12" style="padding:0; border: 1px solid black; margin-top:20px;">
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
	
	let id = 0;
	let seat_no = "${showtimeVO.seat_no}";
	
	for(let i = 0; i <= 20; i++){
		let num = 64 + i;
		let word = String.fromCharCode(num);
		let label = document.createElement("label");
		let walkway = document.createElement("input");
		walkway.setAttribute("type", "checkbox");
	
		let span = document.createElement("span");
		span.style.border = " 1px solid white";
		span.style.backgroundColor = "white";
		span.style.color = 'black';
		span.innerText = i;
		label.appendChild(walkway);
		label.appendChild(span);
		document.getElementById("d1").appendChild(label);
		
		walkway.setAttribute("class",word);
	}
	document.getElementById("d1").appendChild(document.createElement("br"));
	
	for(let i = 1; i <= 20; i++){
		let num1 = 64 + i;
		let word2 = String.fromCharCode(num1);
		let label1 = document.createElement("label");
		let walkway = document.createElement("input");
		let span1 = document.createElement("span");
		span1.innerText = word2;
		span1.style.border="1px solid white";
		span1.style.backgroundColor = "white";
		span1.style.color = "black";
		walkway.setAttribute("type", "checkbox");
		walkway.setAttribute("class", i);
		label1.appendChild(walkway);
		label1.appendChild(span1);
		document.getElementById("d1").appendChild(label1);
		for(let j = 1; j<= 20; j++){
			let num = 64 + i;
			let word = String.fromCharCode(num);
			let word1 = String.fromCharCode(64+j);
			let string = "";
	
			if(j < 10) {
				string = word + "0" + j;
			}
			else {
				string = word + "" + j;
			}
			let label = document.createElement("label");
			let seat = document.createElement("input");
			seat.setAttribute("type", "checkbox");
			seat.setAttribute("id", id);
			seat.setAttribute("class", i);
			seat.classList.add(word1);
			seat.classList.add(string);
			seat.setAttribute("value", "0");
			seat.setAttribute("name", "seat_no");
	
			let seat_name = document.createElement("span");
			seat_name.innerText = string;
	
			label.appendChild(seat);
			label.appendChild(seat_name);
			if(j % 20 === 0 ){
				label.appendChild(document.createElement("br"));
			}
			
			if((seat_no.charAt(id) == "1")){
				label.style.visibility = "hidden";
				seat.value = 1;
	//				seat.checked = true;
				seat.disabled = true;
			}else if(seat_no.charAt(id) == "2"){
	//				seat.disabled = true;
				seat.value = "2";
				label.style.cursor= "not-allowed";
	//				seat.checked = true;
				seat_name.style.backgroundColor = "red";
				seat.addEventListener("click", function(){
					alert("提醒您，此座位不能點選");
					seat.cheacked = false;
					console.log(seat.cheacked == true);
				},false);
				
			}
	
			document.getElementById("d1").appendChild(label);
			id++;
		}
	}
	
	let submit = document.getElementById("submit");
	let count = <%=count%>;
	let countSeat = 0;
	console.log(count);
	submit.addEventListener("click", function(){
		// 確認選擇座位數量要等於購買的電影票張數
		for(let i = 0; i < 400; i++){
			let seat = document.getElementById(i);
			if(seat.checked==true){
				countSeat++;
				console.log(i);
			}
		}
		console.log(countSeat);
		console.log(count==countSeat);
		if(count != countSeat){
			countSeat = 0;
			return false;
		}
		
		for(let i = 0; i <=399; i++){
			let seat = document.getElementById(i);
			if(seat.checked == false){
				if(seat.value == 0 ){
					seat.checked = true;
	//					$("#").next("span").css("background-color", "lightgreen");
					seat.nextSibling.style.backgroundColor = "lightgreen";
				}else{
					seat.checked = true;
				}
	//				seat.checked = true;
			}else if(seat.checked === true && seat.disabled === false){
				seat.value = 2;
				let seatName = document.createElement("input");
				seatName.setAttribute("type", "hidden");
				seatName.setAttribute("name", "seat_name");
				seatName.setAttribute("value", seat.className.slice(-3));
				document.getElementById("d1").appendChild(seatName);
			}
			
			if(seat.disabled == true){
				seat.disabled = false;
				seat.cheacked = true;
			}
			submit.setAttribute("type", "submit")
		}
		
	},false);
	
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

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
</body>
</html>