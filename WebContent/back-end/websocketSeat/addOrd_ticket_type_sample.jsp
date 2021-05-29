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
	background-color: chocolate;
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
		}
		label>span{
			font-size: 8px;
			font-family: monospace;
			text-align: center;
			/*  */
			line-height: 25px;
			/* background-color: lightgreen; */
		}

		input[type=checkbox]+span {
			display: inline-block;
			vertical-align:middle;
			background-color: antiquewhite;
			color: #444;
			user-select: none; /* 防止文字被滑鼠選取反白 */
			width: 25px;
			height: 25px;		
			margin: 3px 3px;
			border-radius: 5px;
		}
		input[type=checkbox]:checked+span {
			background-color: #ADD8E6;
		}

		input[type=checkbox]+span:first-child {
			visibility: hidden;
		}

		#d1{
			margin: 10px 10px;
			font-size: 27px;
		}
		input#submit{
			margin-left: 330px;
		}
		.button{
			width: 25px;
			height: 25px;
		}
/* 		#d1 > label:nth-child(1){ */
/* 			visibility:  hidden; */
/* 			width: 29px; */
/* 			height: 29px; */
/* 		} */
		#d2{
			margin-top:15px;
/* 			border: 1px solid black; */
/* 			width: 690px; */
			height: 30px;
			text-align: center;
			background: antiquewhite;
			font-size: 20px;
			font-family:monospace;
			line-height: 30px;
		}
		#d3, #d4, #d5{
			width:25px;
			height:25px;
			display:inline-block;
			border-radius: 5px;
		}
		#d3{
			margin-left:250px;
			background-color:antiquewhite;
			
		}
		#d4{
			margin-left:20px;
			background-color: coral;
		}
		#d5{
			margin-left:20px;
			background-color: #ADD8E6;
		}
		#d0{
			margin-top:20px;
			align-items:center;
		}
		@media (max-width: 767px){
  			#choose_seat{
  				width:800px;
  			}
		}

</style>
<!-- <script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js" integrity="sha384-slN8GvtUJGnv6ca26v8EzVaR9DC58QEwsIk9q1QXdCU8Yu8ck/tL/5szYlBbqmS+" crossorigin="anonymous"></script> -->
<!-- <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"> -->
<!-- <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script> -->
</head>
<body bgcolor='white' onload="connect();" onunload="disconnect();">
<jsp:include page="/front_header.jsp"/>
<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/order/order.do" name="form1">
	<div id="main" class="container" >
	  <div class="row">
		<div id="div1" style="display:inline-block" class="col-md-8">
			<div style="margin-bottom:5px; padding: 10px 0;">
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
					<i class="fas fa-video" style="margin-right:5px; color:#008080; font-size:14px;"></i>${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(param.showtime_no)
						.theater_no).theater_name}
				</p>
			</div>
			<div id="div2" >
				<h2 id="h2">選擇座位</h2>
				<p id="p1">選擇您希望購買的電影票張數和類型.請注意系統將自動為您保留可訂的最佳座位, 每筆交易最多可購買10張電影票</p>
			</div>
			<div id="choose_seat"style="border:1px solid chocolate; margin-top:20px; padding:30px;">
				<div id="d0">
					<div id="d3">
					</div>&nbsp&nbsp可選擇
					<div id="d4">
					</div>&nbsp&nbsp已售出
					<div id="d5">
					</div>&nbsp&nbsp您的座位
				</div>
			
				<div style="margin:10px 20px; font-size:27px;">
					<div id="d2">
						螢幕
					</div>
					<div id="d1" ></div>
				</div>
			</div>
			<input type="hidden" name="action" value="checkOrd">
			<input type="hidden" name="showtime_no" value="${param.showtime_no}">
			<input type="button"  id="submit" value="繼續   →"  style="margin-top: 20px; background-color: #337ab7; 
			color: white; border: white; width:100px; height:50px; margin-left: 80%;">
			
		</div>
		<div class="col-md-2" style="margin-top:119px;"  >
			<div class="row" >
				<div class="col-md-12" style="padding:0; margin-bottom: 20px;">
					<div style="height:40px;background-color: #337ab7; border: 1px solid black;">
						<div style="margin-top: 7px; margin-left:40px; color:white;">
							時間剩餘<span id="timeOut">1:00</span> 
						</div>
					</div>
				</div>
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
							<c:forEach var="ord_ticketVO" items="${ordTicket_list}">
								<tr>
									<td>	
										<p class="text">${ticket_typeSvc.getOneTicket_type(ord_ticketVO.ticket_type_no).ticket_desc}</p>
										<p class="product"><span style="margin:3px;"> ${ticket_typeSvc.getOneTicket_type(ord_ticketVO.ticket_type_no).ticket_price} X</span>
										<span style="margin:3px;">${ord_ticketVO.ticket_count} =</span>
										<span class="subtotal" style="margin:3px;">${ord_ticketVO.price}</span></p>
									</td>
								</tr>
							</c:forEach>
							<c:forEach var="ord_foodVO" items="${ordFood_list}">
								<tr>
									<td>	
										<p class="text">${foodSvc.getOneFood(ord_foodVO.food_no).food_name}</p>
										<p class="product"><span style="margin:3px;"> ${foodSvc.getOneFood(ord_foodVO.food_no).food_price} X</span>
										<span style="margin:3px;">${ord_foodVO.food_count} =</span>
										<span class="subtotal" style="margin:3px;">${ord_foodVO.price}</span></p>
									</td>
								</tr>
							</c:forEach>
							<tr id="total">
								<td>
									<p id="total_price">合計:${total_price}</p>
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
	let seat_no = "${showtimeSvc.getOneShowtime(param.showtime_no).seat_no}";
	
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
		if(i==0){
			label.style.visibility = "hidden";
		}
		
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
			
			if((seat_no.charAt(id) == "1")){
				label.style.visibility = "hidden";
				seat.value = 1;
				seat.disabled = true;
			}else if(seat_no.charAt(id) == "2"){
				seat.value = "2";
				label.style.cursor= "not-allowed";
				seat_name.style.backgroundColor = "coral";
				seat.addEventListener("click", function(){
					swal.fire({
						icon:'error',
						text:'提醒您，此座位不能點選'
					});
					seat.checked = false;
				},false);
				
			}
	
			document.getElementById("d1").appendChild(label);
			id++;
			if(j % 20 === 0 ){
				document.getElementById("d1").appendChild(document.createElement("br"));
			}
			
			//註冊事件for websocket
			seat.addEventListener("click", function(e) {
				let id = seat.id;
				if(seat.checked == true){ //點擊時會先把checked狀態改成true才進此區塊
					seat.value = 2;
				}else{
					seat.value = 0;
				}
				console.log(id);
				console.log(seat.value);
				var jsonObj = {
						"seat_id" : id,
						"seat_value" : seat.value
				};
				webSocket.send(JSON.stringify(jsonObj));
				
			});
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
			}
		}
		if(count != countSeat){
			swal.fire({
				icon:'error',
				text:"您還有" + (count-countSeat + "個座位未選擇")
			}); 
			countSeat = 0;
			return false;
		}
		
		for(let i = 0; i <=399; i++){
			let seat = document.getElementById(i);
			if(seat.checked == false){
				if(seat.value == 0 ){
					seat.checked = true;
					seat.nextSibling.style.backgroundColor = "antiquewhite";
				}else{
					seat.checked = true;
				}
			}else if(seat.checked === true && seat.disabled === false){
				seat.value = 2;
				let seatName = document.createElement("input");
				seatName.setAttribute("type", "hidden");
				seatName.setAttribute("name", "seat_name");
				seatName.setAttribute("value", seat.className.slice(-3));
				let seat_id = document.createElement("input");
				seat_id.setAttribute("type", "hidden");
				seat_id.setAttribute("name", "seat_id");
				seat_id.setAttribute("value", seat.id);
				document.getElementById("d1").appendChild(seatName);
				document.getElementById("d1").appendChild(seat_id);
			}
			
			if(seat.disabled == true){
				seat.disabled = false;
				seat.cheacked = true;
			}
			submit.setAttribute("type", "submit")
		}
		
	},false);
</script>
<script>
// 	----------------------websocket-------------------------------
	var MyPoint = "/SeatWS/${param.showtime_no}";
	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
	console.log(host);
	console.log(path);
	console.log(webCtx);
	console.log(endPointURL);
	var showtime_no = '${param.showtime_No}';
	var webSocket;
	
	function connect(){
		// create a websocket
		webSocket = new WebSocket(endPointURL);
		
		webSocket.onopen = function(event) {
			console.log("Connect Success!");
			
		};
	
		webSocket.onmessage = function(event) {
			var jsonObj = JSON.parse(event.data);
			console.log(jsonObj);
			console.log(jsonObj.type);
			console.log(typeof jsonObj.type);
			if("open" === jsonObj.type){
				let seat_list = jsonObj.seat_list;
				for(let i = 0; i < seat_list.length; i++){
					let id = seat_list[i];
					let seat = document.getElementById(id);
					seat.value = 2;
					seat.disabled = true;
					seat.parentNode.style.cursor= "not-allowed";
					seat.nextElementSibling.style.backgroundColor = "coral";
					seat.parentNode.addEventListener("click", disabled,false);
				}
				return;
			}
			if("close" === jsonObj.type){
				let seat_list = jsonObj.seat_list;
				for(let i = 0; i < seat_list.length; i++){
					let id = seat_list[i];
					let seat = document.getElementById(id);
					seat.value = 0;
					seat.disabled = false;
					seat.parentNode.removeEventListener("click", disabled ,false);
					seat.nextElementSibling.style.backgroundColor = "";
					seat.parentNode.style.cursor= "pointer";
				}
				return;
			}
			if("checkOrder" === jsonObj.type){
				console.log(jsonObj.seat_id);
				let string = jsonObj.seat_id;
				let first = string.indexOf("[") + 1;
				let last = string.lastIndexOf("]");
				console.log(first);
				console.log(last);
				
				
				let seat_list = string.substring(first,last).split(",");
				console.log(seat_list);
				console.log(typeof seat_list);
				for(let i = 0; i < seat_list.length; i++){
					let id = seat_list[i].trim();
					console.log(id);
					let seat = document.getElementById(id);
					console.log(seat);
					seat.value = 2;
					seat.disabled = true;
					seat.parentNode.style.cursor= "not-allowed";
					seat.nextElementSibling.style.backgroundColor = "coral";
					seat.parentNode.addEventListener("click", disabled,false);
				}
				return;
			}
			
			let id = jsonObj.seat_id;
			let value = jsonObj.seat_value;
			let seat = document.getElementById(id);
			
			if(value === "2"){
				seat.value = value;
				seat.disabled = true;
				seat.parentNode.style.cursor= "not-allowed";
				seat.nextElementSibling.style.backgroundColor = "coral";
				seat.parentNode.addEventListener("click", disabled,false);
			}else{
				seat.value = value;
				seat.disabled = false;
				seat.parentNode.removeEventListener("click", disabled ,false);
				seat.nextElementSibling.style.backgroundColor = "";
				seat.parentNode.style.cursor= "pointer";
			}
				
		};
		
		webSocket.onclose = function(event) {
			console.log("Disconnected!");
		};
	}
// 	window.onbeforeunload = function(e){
// // 		console.log("111");
// // 		webSocket.send("onbeforeunload");
// // 		console.log("222");
// // 		disconnect();
// 	};

	
// 	function release(){
// 		alert("準備結束連線");
// 		for(let i = 0; i < 399; i++){
// 			let seat = document.getELementById(i);
// 			if(seat.checked == true && seat.disalbed == false){
// 				let list = [];
// 				list.push(seat.id);
// 			}
// 		}
		
// 		var jsonObj = {
// 				"type" : "close",
// 				"seat_id" : list
// 		};
// 		console.log("關閉連線")
// 		webSocket.send("123");
// 		alert("準備結束連線");
// 		disconnect();
		
// 	}
		
	function disconnect() {
		webSocket.close();
	}
	
	function disabled(seat){
		swal.fire('提醒您，此座位不能點選');
		seat.checked = false;
	}
	
	//計時器
	let sec = 59;
		setInterval(function() {
			$("#timeOut").text(timeFormat(sec));
			sec -= 1;
		}, 1000)
		setTimeout(
			function() {
				window.location.replace("${pageContext.request.contextPath}/index.jsp");
			}, sec * 1000);
		function timeFormat(second) {
			let minute = parseInt(second / 60);
			second %= 60;
			(second < 10) ? second = '0' + second : second;
			return minute + ":" + second;
		}

</script>
<jsp:include page="/front_footer_copy.jsp"/>
</body>
</html>