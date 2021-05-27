<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.showtime.model.*"%>
<%@ page import="com.theater.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	ShowtimeVO showtimeVO = (ShowtimeVO) request.getAttribute("showtimeVO"); //TheaterServlet.java(Concroller), 存入req的theaterVO物件
%>

<% 
	java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:00");; 
	pageContext.setAttribute("df",df);
%>

<html>
<head>
<title>場次資料 - listOneShowtime.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
h2{
			margin-left: 325px;
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
			margin: 10px 0px;
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
			width: 700px;
			height: 30px;
			text-align: center;
			background: orange;
			font-size: 20px;
			line-height: 30px;
		}
		#d3, #d4{
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
		#div1{
			display:inline-block;
			display: flex;
			align-items:center;
		}
</style>

<style>
  table {
	width: 700px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<jsp:useBean id="theaterSvc" scope="page" class="com.theater.model.TheaterService" />

<jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>場次資料 - ListOneShowtime.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/showtime/select_page.jsp"><img src="/CEA103G3/back-end/theater/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>場次編號</th>
		<th>電影名稱</th>
		<th>廳院</th>
		<th>場次時間</th>
<!-- 		<th>場次座位</th> -->
	</tr>
	<tr>
		<td>${showtimeVO.showtime_no}</td>
		<td>
			${movieSvc.getOneMovie(showtimeVO.movie_no).moviename}
		</td>
		<td>
			${theaterSvc.getOneTheater(showtimeVO.theater_no).theater_name}
			
<%-- 			<c:choose> --%>
<%-- 					<c:when test="${theaterVO.theater_type == 0 }"> --%>
<!-- 					2D -->
<%-- 					</c:when> --%>
<%-- 					<c:when test="${theaterVO.theater_type == 1 }"> --%>
<!-- 					3D -->
<%-- 					</c:when> --%>
<%-- 					<c:when test="${theaterVO.theater_type == 2 }"> --%>
<!-- 					IMAX -->
<%-- 					</c:when> --%>
<%-- 					<c:when test="${theaterVO.theater_type == 3 }"> --%>
<!-- 					2D_IMAX -->
<%-- 					</c:when> --%>
<%-- 					<c:when test="${theaterVO.theater_type == 4 }"> --%>
<!-- 					3D_IMAX -->
<%-- 					</c:when> --%>
<%-- 				</c:choose> --%>
		</td>
		<td>${df.format(showtimeVO.showtime_time)}</td>
<%-- 		<td>${theaterVO.seat_name}</td> --%>
	</tr>
</table>
<br>
	<h2>座位</h2>
	<div id="div1">
		<div id="d3">
		</div>&nbsp&nbsp座位
		<div id="d4">
		</div>&nbsp&nbsp已售出
	</div>

	<div id="d1" style="width:700px;">
		<div id="d2">
			螢幕位置
		</div>
	</div>

	
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
			seat.disabled = true;
			seat.classList.add(word1);
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
			}else if(seat_no.charAt(id) == "2"){
				seat.disalbed = true;
				seat_name.style.backgroundColor = "red";
				
			}

			document.getElementById("d1").appendChild(label);
			id++;
		}
	}
</script>
</body>
</html>