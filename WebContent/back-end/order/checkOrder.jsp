<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ord_ticket_type.model.*"%>
<%@ page import="com.ord_food.model.*"%>
<%@ page import="com.food.model.*"%>
<%@ page import="com.ticket_type.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="java.util.*"%>

<%
	java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:00");; 
	pageContext.setAttribute("df",df);
%>

<jsp:useBean id="ticket_typeSvc" scope="page" class="com.ticket_type.model.Ticket_typeService" />
<jsp:useBean id="foodSvc" scope="page" class="com.food.model.FoodService" />
<jsp:useBean id="showtimeSvc" scope="page" class="com.showtime.model.ShowtimeService" />
<jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />
<jsp:useBean id="theaterSvc" scope="page" class="com.theater.model.TheaterService" />

<jsp:include page="/front_header.jsp"/>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>確認訂單</title>

<style>
body{
	box-sizing: border-box;
}
table {
	width: 660px;
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

div.front_header, div.container-fluid, div.row{
	width:100%; 
}

#div1, #div6 {
	width: 660px;
/* 	height: 150px; */
/* 	background-color: rgba(0, 0, 0, 0.5); */
	padding-top: 10px;
	padding-bottom: 10px;
}
#div2,#div7{
	width:660px;
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

/* img{ */
/*   	width: 115px; */
/*   	height: 100px; */
/*   	margin: 0 auto; */
/*   } */

</style>
<!-- <script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js" integrity="sha384-slN8GvtUJGnv6ca26v8EzVaR9DC58QEwsIk9q1QXdCU8Yu8ck/tL/5szYlBbqmS+" crossorigin="anonymous"></script> -->
<!-- <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"> -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body bgcolor='white' onload="connect();" onunload="disconnect();">

	<div id="main" class="container-fluid">
	  <div class="row">
		<div id="div1" class="col-md-6">
		  <FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/order/order.do" name="form1">
			<div style="margin-bottom:5px; padding: 10px 0px;">
				<c:choose>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(param.showtime_no)
					.movie_no).grade == 0}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/0.jpg" style="width:100px; height: 120px;">
					</c:when>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(param.showtime_no)
					.movie_no).grade == 1}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/1.jpg" style="width:100px; height: 120px;">
					</c:when>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(param.showtime_no)
					.movie_no).grade == 2}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/2.jpg" style="width:100px; height: 120px;">
					</c:when>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(param.showtime_no)
					.movie_no).grade == 3}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/3.jpg" style="width:100px; height: 120px;">
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
					<i class="fas fa-video" style="margin-right:5px; color:#008080; font-size:14px;"></i> ${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(param.showtime_no)
						.theater_no).theater_name}
					<br>
					<br>
					<i class="fas fa-couch" style="margin-right:5px; color:#008080; font-size:14px;"></i>${seat_name}
				</p>
			</div>
			<div id="div2">
				<h2 id="h2">確認訂單內容</h2>
				<p id="p1">請再次確認所選座位及以下商品名稱、價格、數量</p>
			</div>
			<table>
				<tr>
					<th>商品</th>
					<th>價格</th>
					<th>數量</th>
					<th>合計</th>
				</tr>
				<c:forEach var="ord_ticketVO" items="${ordTicket_list}">
						<tr>
							<td>${ticket_typeSvc.getOneTicket_type(ord_ticketVO.ticket_type_no).ticket_desc}</td>
							<td>${ticket_typeSvc.getOneTicket_type(ord_ticketVO.ticket_type_no).ticket_price}</td>
							<td>${ord_ticketVO.ticket_count}</td>
							<td>${ord_ticketVO.price}</td>
						</tr>
				</c:forEach>
				<c:forEach var="ord_foodVO" items="${ordFood_list}">
						<tr>
							<td>${foodSvc.getOneFood(ord_foodVO.food_no).food_name}</td>
							<td>${foodSvc.getOneFood(ord_foodVO.food_no).food_price}</td>
							<td>${ord_foodVO.food_count}</td>
							<td>${ord_foodVO.price}</td>
						</tr>
				</c:forEach>
						<tr>
							<td colspan="4" style="border-top: 1px solid lightgrey;"></td>
						</tr>
						<tr>
							<td colspan="1">總計</td>
							<td colspan="2"></td>
							<td colspan="1">${total_price}</td>
						</tr>
			</table>
			<div>
			<br>
				付款方式:<br>
				<input id="payByCredit"style="width:20px;" type="radio" name="payment_type" value="0">信用卡
				<input id="payAtCounter"style="width:20px;" type="radio" name="payment_type" value="2">現場付款
			</div>
			<div id="creditCard">
			<%@ include file="creditcard.jsp" %>
			</div>	
			<input type="hidden" name="action" value="insertOrd">
			<input type="hidden" name="order_type" value="1">
			<input type="hidden" name="seat_no" value="${seat_no}">
			<input type="hidden" name="seat_name" value="${seat_name}">
			<input type="hidden" name="showtime_no" value="${param.showtime_no}">
			<input id="submit" type="button" value="結帳"  style="margin-top: 20px; background-color: #337ab7; 
			color: white; border: white; width:100px; height:50px; margin-left: 83%;">
		    </FORM>
		  </div>
			  <div class="col-md-2" style="margin-top:155px; margin-left:45px;"  >
				<div class="row" >
					<div class="col-md-12" style="padding:0; margin-bottom: 20px;">
						<div style="height:40px;background-color: #337ab7; border: 1px solid black;">
							<div style="margin-top: 7px; margin-left:40px; color:white;">
								時間剩餘<span id="timeOut">5:00</span> 
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
				</div>
			</div>
	  	</div>
	</div>
		
	
	
	<script>
		$("#creditCard").hide();
		$("#payByCredit").click(function(){
			$("#creditCard").show();
		})
		$("#payAtCounter").click(function(){
			$("#creditCard").hide();
		})
		$("#submit").click(function(){
			if($("#payByCredit").prop("checked") == false && $("#payAtCounter").prop("checked") == false){
				swal.fire({
					icon:'error',
					text:"請選擇付款方式",
				});
			}else{
				$("#submit").attr("type","submit")
			}
		});
	</script>
	
<!-- 	websocket -->
	<script>
	var MyPoint = "/SeatWS/${param.showtime_no}";
	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
	console.log(host);
	console.log(path);
	console.log(webCtx);
	console.log(endPointURL);
	var showtime_no = "${param.showtime_no}";
	var webSocket;
	
	window.onload = connect();
	function connect(){
		webSocket = new WebSocket(endPointURL);
		
		webSocket.onopen = function(event) {
			console.log("Connect Success!");
			let seat_id = "${seat_id}"
			console.log(seat_id);
			var jsonObj = {
					"type": "checkOrder",
					"seat_id":seat_id
			}
			webSocket.send(JSON.stringify(jsonObj));
		};
	
		webSocket.onmessage = function(event) {
				
		};
		
		webSocket.onclose = function(event) {
			console.log("Disconnected!");
		};
	}
	
	function disconnect() {
		webSocket.close();
	}
	
	//計時器
	let sec = 300;
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
<!-- 	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script> -->
</body>
</html>