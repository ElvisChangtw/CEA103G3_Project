<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ord_ticket_type.model.*"%>
<%@ page import="com.ord_food.model.*"%>
<%@ page import="com.food.model.*"%>
<%@ page import="com.ticket_type.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.order.model.*"%>
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

	java.text.DateFormat df = new java.text.SimpleDateFormat("MM-dd");
	java.text.DateFormat df1 = new java.text.SimpleDateFormat("HH:mm");
	
	List<Ord_ticket_typeVO> list = ord_ticket_typeSvc.getAll();
	for(int i = 0; i < list.size(); i++){
		if(orderVO.getOrder_no().intValue()!= list.get(i).getOrder_no().intValue()){
			list.remove(i);
			i--;
		}
	}
	
	List<Ord_foodVO> list1 = ord_foodSvc.getAll();
	for(int i = 0; i < list1.size(); i++){
		if(orderVO.getOrder_no().intValue()!= list1.get(i).getOrder_no().intValue()){
			list1.remove(i);
			i--;
		}
	}
	
	request.setAttribute("list", list);
	request.setAttribute("list1", list1);
	pageContext.setAttribute("df",df);
	pageContext.setAttribute("df1",df1);
	request.setAttribute("orderVO", orderVO);
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>絋粄璹虫</title>

<style>
body{
	box-sizing: border-box;
}
table{
	/* 	width: 750px; */
/* 	margin: 5px auto 5px auto; */
	background-color: rgb(255, 255, 255);
	border-radius: 10px;
	-webkit-box-shadow: 0px 3px 5px rgb(8, 8, 8, 0.3);
	-moz-box-shadow: 0px 3px 5px rgb(8, 8, 8, 0.3);
	box-shadow: 0px 3px 5px rgb(8, 8, 8, 0.3);
}

th, td {
	box-sizing: border-box;
	border-radius: 10px;
}

th {
	width: 200px;
	padding: 10px 0px 10px 70px;
}

td {
	width: 250px;
	padding: 10px 20px 10px 30px;
	border-bottom: 2px dotted #bb9d52;
}

.listOne-h3-pos, #a-color {
	margin-left: 50%;
}

.listOne-h3-pos {
	display: inline-block;
}

#a-color {
	font-size: 16px;
}

.detail {
	display: inline-block;
}

.detailBlock {
	position: relative;
}

.detail.price {
	position: absolute;
	right: 0%;
}

#status {
	margin-left: 180px;
}
#btn{
	border:white;
	background-color:antiquewhite;
	width:50px;
	height:30px;
}


</style>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body bgcolor='white'>
<div>
	<table>
		<tr>
			<th>璹虫篈</th>
			<td id="order_status">
				<c:choose>
					<c:when test="${orderVO.order_status == 0 }">
						ゼ蹿
					</c:when>
					<c:when test="${orderVO.order_status == 1 }">
						
					</c:when>
					<c:when test="${orderVO.order_status == 2 }">
						ゼ布
					</c:when>
					<c:when test="${orderVO.order_status == 3 }">
						布
					</c:when>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th>筿紇</th>
			<td>
				${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(orderVO.showtime_no).movie_no).moviename}
			</td>
		</tr>
		<tr>
			<th>ら戳</th>
			<td>${df.format(showtimeSvc.getOneShowtime(orderVO.showtime_no).showtime_time)}</td>
		</tr>
		<tr>
			<th>丁</th>
			<td>${df1.format(showtimeSvc.getOneShowtime(orderVO.showtime_no).showtime_time)}</td>
		</tr>
		<tr>
			<th>畒</th>
			<td>${orderVO.seat_name}</td>
		</tr>
		<tr>
			<th>坝珇</th>
			<td>
				<c:forEach var="ord_ticket_typeVO" items="${list}">
					<div class="detailBlock">
						<p class="detail">${ticket_typeSvc.getOneTicket_type(ord_ticket_typeVO.ticket_type_no).ticket_desc}</p>
						<p class="detail price">
							$<span>${ticket_typeSvc.getOneTicket_type(ord_ticket_typeVO.ticket_type_no).ticket_price}</span> X <span>${ord_ticket_typeVO.ticket_count}</span>
						</p>
					</div>
				</c:forEach> 
				<c:forEach var="ord_foodVO" items="${list1}">
					<div class="detailBlock">
						<p class="detail">${foodSvc.getOneFood(ord_foodVO.food_no).food_name}</p>
						<p class="detail price">
							$<span>${foodSvc.getOneFood(ord_foodVO.food_no).food_price}</span> ⊙ <span>${ord_foodVO.food_count}</span>
						</p>
					</div>
				</c:forEach></td>
		</tr>
		<tr>
			<th>羆基</th>
			<td>${orderVO.total_price}</td>
		</tr>
		<tr id="button">
			<th></th>
			<td>
				<button id="btn">布</button>
			</td>
		</tr>
	</table>
</div>	

<script>
	
	if(${orderVO.order_status.equals("3")}){
		$("#button").hide();
	} 
	$("#btn").click(function(){
    	$.ajax({
    		url: "<%=request.getContextPath()%>/order/order.do",
    		type: "POST",
    		data: {	action: "update_status", 
    			   	order_no: ${orderVO.order_no},
    		},
    		success: function(){
    			}
    	});
    	
		swal.fire("布Θ");
		$("#order_status").text("布")
		$("#button").hide();
	});

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>

</body>
</html>