<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.theater.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  TheaterVO theaterVO = (TheaterVO) request.getAttribute("theaterVO"); //TheaterServlet.java(Concroller), 存入req的theaterVO物件
%>

<html>
<head>
<title>廳院資料</title>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<link href="<%=request.getContextPath()%>/back-home/css/styles.css" rel="stylesheet" />
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>

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
</style>
<style>

label {
	padding: 0;
	margin: 2px 2px 0px 0px;
	cursor: pointer;
}
input[type=checkbox] {
	display: none;
}
span{
	font-size: 8px;
	font-family: monospace;
	text-align: center;
	/*  */
	line-height: 25px;
}

input[type=checkbox]+span {
		display: inline-block;
	vertical-align:middle;
	background-color: antiquewhite;
	color: #444;
	user-select: none; /* 防止文字被滑鼠選取反白 */
	width: 25px;
	height: 25px;		
	margin: 0px 2px;
	border-radius: 5px;
}

input[type=checkbox]:checked+span {
	/* 			color: yellow; */
	background-color: coral;

}

input[type=checkbox]+span:first-child {
	visibility: hidden;
}

#d1{
	width:660px;
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
	width: 30px;
	height: 30px;
}
#d2{
	height: 30px;
	text-align: center;
	background: antiquewhite;
	font-size: 20px;
	font-family:monospace;
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
	background-color:antiquewhite
}
#d4{
	margin-left:20px;
	background-color: coral;
}
#div1{
	display:inline-block;
	display: flex;
	align-items:center;
}
#layoutSidenav>#layoutSidenav_content{
	padding-left:0px;
}
		
</style>


</head>
</head>
          <body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
    	<a class="navbar-brand" href="<%=request.getContextPath()%>/back-home/index2.jsp">MOVIESHIT後台系統</a>
    	<button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
    	<!-- Navbar Search-->
    	<form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
        	<div class="input-group">
        	</div>
    	</form>
    	<!-- Navbar-->
      	<ul class="navbar-nav ml-auto ml-md-0">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle1" id="userDropdown" href="<%=request.getContextPath()%>/back-end/employee/empLogin.jsp" role="button"><i class="fas fa-user fa-fw"></i>${employeeVO.empname}</a>
        </li>
        <a class="nav-link" href="<%=request.getContextPath()%>/back-end/employee/empLogout.jsp">
           	 登出
        </a>
	</nav>
    
    
    
    
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <img src="<%=request.getContextPath()%>/back-home/img/logo2-1-6.png">
	                         <h1 style="text-align: center;color: white;font-weight: bold ;font-size:35px">
	                         	<span style="color: #02a388; font-size: 1em;">M</span>ovies<span style="color: #02a388; font-size: 1em;">H</span>it
	                         </h1>
<!--                         <a class="nav-link collapsed" href="tables3.html"> -->
<!--                             <div class="sb-nav-link-icon"><i class="fas fa-user-alt"></i></div> -->
<!--                            	 基本資料 -->
<!--                         </a> -->
                        <a id="employee_management"class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLayouts1" aria-expanded="false" aria-controls="collapseLayouts1">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-cog"></i></div>
                           	 員工管理系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseLayouts1" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a  class="nav-link nav-link function" href="<%=request.getContextPath()%>/back-end/employee/listAllEmployee2.jsp">員工管理</a>
                            </nav>
                        </div>
                        <a id="movie_management" class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                            <div class="sb-nav-link-icon"><i class="fas fa-video"></i></div>
                         	   影城基本資料系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/movie/backEndlistAllMovie.jsp">電影資料管理</a>
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/showtime/listAllShowtime.jsp">場次管理</a>
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/theater/listAllTheater.jsp"> 廳院管理</a>
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/ticket_type/listAllTicket_type.jsp">票種管理</a>
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/food/listAllFood.jsp">餐點管理</a>
                            </nav>
                        </div>
                        <a id="member_management" class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages2" aria-expanded="false" aria-controls="collapsePages2">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-clock"></i></div>
                            	會員管理系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages2" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/mem/listAllMem2.jsp">會員資料管理</a>
                            </nav>
                        </div>
                        <a id="ticket_management" class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages3" aria-expanded="false" aria-controls="collapsePages3">
                            <div class="sb-nav-link-icon"><i class="fas fa-ticket-alt"></i></div>
                        	    售票管理
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages3" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/order/onSite.jsp">現場劃位</a>
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/order/listAllOrder.jsp">訂單管理</a>
                            </nav>
                        </div>
           				 <a id="comment_management" class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages4" aria-expanded="false" aria-controls="collapsePages4">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-alt-slash"></i></div>
                          	  檢舉管理
                          	<div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages4" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/report_comment/listAllReportComment.jsp">評論檢舉</a>
                            </nav>
                        </div>
                        <a id="news_management" class="nav-link function" href="tables1.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-bullhorn"></i></div>
                           	 管理最新消息
                        </a>
                        <a id="customer_service" class="nav-link function" href="tables2.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-hands-helping"></i></div>
                       	     	回應客服小幫手
                        </a>
                    </div>
                </div>
            </nav>
        </div>


 <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                            <div class="card-body">
                                <div class="table-responsive">
									<div id="d1" style="width:660px; margin:auto;">
										<div id="d2">
											螢幕位置
										</div>
									</div>
	                        	</div>
	                    	</div>
	                    </div>
	                </main>
	            </div>
	
<script>
	let id = 0;
	let seat_no = "${theaterVO.seat_no}";
	
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
			}

			document.getElementById("d1").appendChild(label);
			id++;
		}
	}

</script>
</body>
</html>