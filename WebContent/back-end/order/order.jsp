<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ord_ticket_type.model.*"%>
<%@ page import="com.ord_food.model.*"%>
<%@ page import="com.food.model.*"%>
<%@ page import="com.ticket_type.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.order.model.*"%>
<%-- <%@ page import="com.ord_ticket_type.model.*"%> --%>
<%@ page import="java.util.*"%>

<jsp:useBean id="ticket_typeSvc" scope="page" class="com.ticket_type.model.Ticket_typeService" />
<jsp:useBean id="foodSvc" scope="page" class="com.food.model.FoodService" />
<jsp:useBean id="showtimeSvc" scope="page" class="com.showtime.model.ShowtimeService" />
<jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />
<jsp:useBean id="theaterSvc" scope="page" class="com.theater.model.TheaterService" />
<jsp:useBean id="ord_ticket_typeSvc" scope="page" class="com.ord_ticket_type.model.Ord_ticket_typeService" />
<jsp:useBean id="ord_foodSvc" scope="page" class="com.ord_food.model.Ord_foodService" />

<%
	OrderVO orderVO = (OrderVO) request.getAttribute("orderVO");
	System.out.println(orderVO);
	if(orderVO == null){
		OrderService ordSvc = new OrderService();
		orderVO = ordSvc.getOneOrder(new Integer(request.getParameter("order_no")));
	}
	System.out.println(orderVO.getOrder_no());
	System.out.println(orderVO.getShowtime_no());

	java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:00");
	
	List<Ord_ticket_typeVO> list = ord_ticket_typeSvc.getAll();
	for(int i = 0; i < list.size(); i++){
		if(orderVO.getOrder_no().intValue() != list.get(i).getOrder_no().intValue()){
			list.remove(i);
			i--;
		}
	}
	
	List<Ord_foodVO> list1 = ord_foodSvc.getAll();
	for(int i = 0; i < list1.size(); i++){
		if(orderVO.getOrder_no().intValue() != list1.get(i).getOrder_no().intValue()){
			list1.remove(i);
			i--;
		}
	}
	request.setAttribute("list", list);
	request.setAttribute("list1", list1);
	pageContext.setAttribute("df",df);
	request.setAttribute("orderVO", orderVO);
	
%>




<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>確認訂單</title>

<style>
body{
	box-sizing: border-box;
}
table {
	width: 600px;
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

#div1, #div6 {
	width: 600px;
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

img{
  	width: 115px;
  	height: 100px;
  	margin: 0 auto;
  }

</style>
	<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="/CEA103G3_Project/js/qrcode.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js" integrity="sha384-slN8GvtUJGnv6ca26v8EzVaR9DC58QEwsIk9q1QXdCU8Yu8ck/tL/5szYlBbqmS+" crossorigin="anonymous"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">

</head>
<body bgcolor='white'>
	<div id="main" class="container-fluid">
	  <div class="row">
		<div id="div1" class="col-6">
		  <FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/order/order.do" name="form1">
			<div style="margin-bottom:5px; padding: 10px 0px;">
				<c:choose>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(orderVO.showtime_no)
					.movie_no).grade == 0}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/0.jpg" style="width:100px; height: 120px;">
					</c:when>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(orderVO.showtime_no)
					.movie_no).grade == 1}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/1.jpg" style="width:100px; height: 120px;">
					</c:when>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(orderVO.showtime_no)
					.movie_no).grade == 2}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/2.jpg" style="width:100px; height: 120px;">
					</c:when>
					<c:when test="${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(orderVO.showtime_no)
					.movie_no).grade == 3}">
						<img src="<%=request.getContextPath()%>/back-end/theater/images/3.jpg" style="width:100px; height: 120px;">
					</c:when>
				</c:choose>
				<h2 style="display: inline-block; margin-top: -7px; margin-left: 65px; vertical-align:top; width:170px;">
					<c:choose>
						<c:when test="${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(orderVO.showtime_no)
						.theater_no).theater_type == 0}">
							(2D)
						</c:when>
						<c:when test="${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(orderVO.showtime_no)
						.theater_no).theater_type == 1}">
							(3D)
						</c:when>
						<c:when test="${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(orderVO.showtime_no)
						.theater_no).theater_type == 2}">
							(IMAX)
						</c:when>
						<c:when test="${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(orderVO.showtime_no)
						.theater_no).theater_type == 3}">
							(2D,IMAX)
						</c:when>
						<c:when test="${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(orderVO.showtime_no)
						.theater_no).theater_type == 4}">
							(3D,IMAX)
						</c:when>
						<c:when test="${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(orderVO.showtime_no)
						.theater_no).theater_type == 5}">
							(數位)
						</c:when>
					</c:choose>
					
					${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(orderVO.showtime_no)
						.movie_no).moviename}
				</h2>
				<p style="display: inline-block; margin-top: 0px; margin-left: 66px; vertical-align:top; width: 190px;"  >
					<i class="fas fa-clock" style="margin-right:5px; color:#008080;"></i> ${df.format(showtimeSvc.getOneShowtime(orderVO.showtime_no).showtime_time)}
					<br>
					<br>
					<i class="fas fa-video" style="margin-right:5px; color:#008080;"></i> ${theaterSvc.getOneTheater(showtimeSvc.getOneShowtime(orderVO.showtime_no)
						.theater_no).theater_name}
					<br>
					<br>
					<i class="fas fa-couch" style="margin-right:5px; color:#008080;"></i>${orderVO.seat_name}
				</p>
			</div>
			<div id="div2">
				<h2 id="h2">商品明細</h2>
			</div>
			<table>
				<tr>
					<th>商品</th>
					<th>價格</th>
					<th>數量</th>
					<th>合計</th>
				</tr>
				<c:forEach var="ord_ticketVO" items="${list}">
						<tr>
							<td>${ticket_typeSvc.getOneTicket_type(ord_ticketVO.ticket_type_no).ticket_desc}</td>
							<td>${ticket_typeSvc.getOneTicket_type(ord_ticketVO.ticket_type_no).ticket_price}</td>
							<td>${ord_ticketVO.ticket_count}</td>
							<td>${ord_ticketVO.price}</td>
						</tr>
				</c:forEach>
				<c:forEach var="ord_foodVO" items="${list1}">
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
							<td colspan="1">${orderVO.total_price}</td>
						</tr>
			</table>
			<input id="submit" type="button" value="購票管理"  style="margin-top: 20px; background-color: #337ab7; 
			color: white; border: white; width:100px; height:50px; margin-left: 83%;">
		    </FORM>
		  </div>
		  <div class="col-3" style="margin-top:160px;">
		  				<div style="margin-bottom:10px;">取票二維碼</div>
							<html lang="en">
							<head>
								<meta charset="UTF-8">
								<meta name="viewport" content="width=device-width, initial-scale=1.0">
								<title>Document</title>
								<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
								<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.qrcode/1.0/jquery.qrcode.min.js"></script>
							</head>
							<body>
								<div id="qrcode"></div>
							<script>
							$('#qrcode').qrcode({width: 200,height: 200,text: "<%=request.getRequestURL()%>?order_no=${orderVO.order_no}"});      
							</script>
							</body>
							</html>
		  </div>
	  	</div>
	</div>
		
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
</body>
</html>