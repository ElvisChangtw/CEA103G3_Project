<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.theater.model.*"%>

<%
  TheaterVO theaterVO = (TheaterVO) request.getAttribute("theaterVO");
%>
<%= theaterVO==null %>
<!DOCTYPE html>
<html lang="en">
    <head>
    	<title>後台　新增餐點</title>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <link href="<%=request.getContextPath()%>/back-home/css/styles.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
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
/*   table { */
/* 	width: 450px; */
/* 	background-color: white; */
/* 	margin-top: 1px; */
/* 	margin-bottom: 1px; */
/*   } */
/*   table, th, td { */
/*     border: 0px solid #CCCCFF; */
/*   } */
/*   th, td { */
/*     padding: 1px; */
/*   } */
/* 		h2{ */
/* 			margin-left: 325px; */
/* 		} */

		label {
			padding: 0;
			margin: 2px 2px 0px 0px;
			cursor: pointer;
/* 			background-color: lightgreen;  */
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
			margin: 0px 2px;
			border-radius: 5px;
		}

		input[type=checkbox]:checked+span {
			/* 			color: yellow; */
			background-color: #ADD8E6;

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
   <body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <a class="navbar-brand" href="index.html">MOVIESHIT後台系統</a>
        <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
        <!-- Navbar Search-->
        <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
            <div class="input-group">
            </div>
        </form>
        <!-- Navbar-->
        <ul class="navbar-nav ml-auto ml-md-0">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle1" id="userDropdown" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
            </li>
            <a class="nav-link" href="index.html">
                登出
            </a>
        </ul>
    </nav>
    
    
    
    
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <img src="<%=request.getContextPath()%>/back-home/img/logo2-1-5.png">
                        <a class="nav-link collapsed" href="tables3.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-alt"></i></div>
                            基本資料
                        </a>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLayouts1" aria-expanded="false" aria-controls="collapseLayouts1">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-cog"></i></div>
                            員工管理系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseLayouts1" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="layout-static.html">員工管理</a>
                                <a class="nav-link" href="layout-sidenav-light.html">員工權限管理</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                            <div class="sb-nav-link-icon"><i class="fas fa-video"></i></div>
                            影城基本資料系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="layout-static.html">場次管理</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/movie/backEndlistAllMovie.jsp">電影資料管理</a>
                                <a class="nav-link" href="layout-sidenav-light.html"> 廳院管理</a>
                                <a class="nav-link" href="layout-sidenav-light.html">座位管理</a>
                                <a class="nav-link" href="layout-sidenav-light.html">票種管理</a>
                                <a class="nav-link" href="layout-sidenav-light.html">餐點管理</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages2" aria-expanded="false" aria-controls="collapsePages2">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-clock"></i></div>
                            會員管理系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages2" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="layout-static.html">會員資料管理</a>
                                <a class="nav-link" href="layout-sidenav-light.html">會員審核</a>
                                <a class="nav-link" href="layout-sidenav-light.html"> 專業評論審核</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages3" aria-expanded="false" aria-controls="collapsePages3">
                            <div class="sb-nav-link-icon"><i class="fas fa-ticket-alt"></i></div>
                            售票管理
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages3" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="layout-static.html">現場劃位</a>
                                <a class="nav-link" href="layout-sidenav-light.html">查詢線上訂單</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="tables3.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-alt-slash"></i></div>
                            檢舉管理
                        </a>
                        <a class="nav-link" href="tables1.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-bullhorn"></i></div>
                            管理最新消息
                        </a>
                        <a class="nav-link" href="tables2.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-hands-helping"></i></div>
                            回應客服小幫手
                        </a>
                    </div>
                </div>
            </nav>
        </div>

           <div id="layoutSidenav_content">
<!--                 <main> -->
<!--                     <div class="container-fluid"> -->
                        <h1 class="mt-4" style="text-align:center; font-weight:bolder;">新增廳院</h1>
                            <div class="card-body">
                                <div class="table-responsive">
                                   <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/food/food.do" name="form1">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="text-align:left;">
                                        <thead style="background-color:#9099AA; color:white;; white-space: nowrap;" >
                                            <tr>
                                            	<th id="th1" colspan="3" align="center"><CENTER>請輸入廳院資料</CENTER></th>
                                            </tr>
                                        </thead>
                                        <tbody>
											<tr>
											<tr>
												<td><span style="font-weight:bolder;">廳院名稱</span></td>
												<td><input type="TEXT" name="theater_name" size="45" 
			 										value="<%= (theaterVO==null)? "G廳" : theaterVO.getTheater_name()%>" />
												</td>
											</tr>
											<tr>
												<td><span style="font-weight:bolder;">餐點種類</span></td>
												<td>
													<select name="theater_type">
														<option value="0" ${(theaterVO==null) ? "" : (theaterVO.theater_type==0)?"selected":""}>2D</option>
														<option value="1" ${(theaterVO==null) ? "" : (theaterVO.theater_type==1)?"selected":""} >3D</option>
														<option value="2" ${(theaterVO==null) ? "" : (theaterVO.theater_type==2)?"selected":""} >IMAX</option>
														<option value="3" ${(theaterVO==null) ? "" : (theaterVO.theater_type==3)?"selected":""} >2D_IMAX</option>
														<option value="4" ${(theaterVO==null) ? "" : (theaterVO.theater_type==4)?"selected":""} >3D_IMAX</option>
														<option value="5" ${(theaterVO==null) ? "" : (theaterVO.theater_type==5)?"selected":""} >數位</option>
													</select>
												</td>
											</tr>
											
                                            <tr>
                                            </tr>
                                        </tbody>
                                    </table>
                                    	<div id="div1">
											<div id="d3">
											</div>&nbsp&nbsp座位
											<div id="d4">
											</div>&nbsp&nbsp走道及禁位
										</div>
									
										<div id="d1">
											<div id="d2">
												螢幕位置
											</div>
										</div>
													<input type="hidden" name="action" value="insert">
													<input type="submit" value="送出新增" id="send"
													class="btn btn-outline-danger" style="float:right; border:2px #B7B7B7 solid;border-radius:10px; background-color:#FF4268; font-weight:bold; color:white;">
								</FORM>
                                </div>
                            </div>
<!--                     </div> -->
<!--                 </main> -->

            </div>
        
        
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/back-home/js/scripts.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/back-home/dist/assets/demo/datatables-demo.js"></script>
    </body>

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

		walkway.addEventListener("click", function(){
			street_Check(walkway.className);
		}	, false);
		console.log( i + walkway.className);
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
		walkway.addEventListener("click", function(){
			street_Check(walkway.className);
		}
		, false);	
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
			console.log(seat.className); 
			seat.setAttribute("value", "0");
			seat.setAttribute("name", "seat_no");
			seat.addEventListener("click", function(){
				seat_Check(seat.id)
			},false);

			let seat_name = document.createElement("span");
			seat_name.innerText = string;

			label.appendChild(seat);
			label.appendChild(seat_name);
			if(j % 20 === 0 ){
				label.appendChild(document.createElement("br"));
			}

			document.getElementById("d1").appendChild(label);
			if(seat_no != ""){
				if((seat_no.charAt(id)=="1")){
					seat.checked = true;
				}
			};
			
			id++;
		}
	}

	function seat_Check(id1){
		let whichSeat = document.getElementById(id1);

		if(whichSeat.checked === true){
			whichSeat.value = 1;
		}else if(whichSeat.checked === false){
			whichSeat.value = 0;
		}
	}

	function street_Check(cls1){ //class1
		let whichStreet = document.getElementsByClassName(cls1);

		if(whichStreet[0].checked === true){
			for(let i = 1; i < whichStreet.length; i++){
				whichStreet[i].checked = true;
				whichStreet.value = 1;
			}

		}else if(whichStreet[0].checked === false){
			for(let i = 1; i < whichStreet.length; i++){
				whichStreet[i].checked = false;
				whichStreet.value = 0;
			}
		}

	}

	let submit = document.getElementById("submit");
	submit.addEventListener("click", function(){
		for(let i = 0; i <=399; i++){
			let seat = document.getElementById(i);
			if(seat.checked === false){
				seat.checked = true;
				seat.value = 0;
			}else{
				seat.value = 1;	
			}
			// if(seat.disabled === true){
			// 	seat.disabled = false;
			// }
			console.log(seat.checked);
			console.log(seat.value);

		}
	},false);

</script>

</body>
</html>