<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.theater.model.*"%>

<%
  TheaterVO theaterVO = (TheaterVO) request.getAttribute("theaterVO"); //TheaterServlet.java (Concroller) 存入req的theaeterVO物件 (包括幫忙取出的theaterVO, 也包括輸入資料錯誤時的theaterVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<link href="<%=request.getContextPath()%>/back-home/css/styles.css" rel="stylesheet" />
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>

<title>廳院資料修改</title>
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
        
        
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/theater/theater.do" name="form1">
	<div id="layoutSidenav_content">
	                <main>
	                    <div class="container-fluid">
	                            <div class="card-body">
	                                <div class="table-responsive">
	                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="text-align:left;">
	                                        <thead style="background-color:#9099AA; color:white;; white-space: nowrap;" >
 											<tr>
												<td>廳院編號:</td>
												<td><%=theaterVO.getTheater_no()%></td>
											</tr>
											</thead>
											<tr>
												<td>廳院名稱:</td>
												<td><input type="TEXT" name="theater_name" style="width:90px;" value="<%=theaterVO.getTheater_name()%>" /></td>
											</tr>
											<tr>
												<td>廳院種類:</td>
												<td>
													<select name="theater_type">
														<option value="0" ${(theaterVO==null) ? "" : (theaterVO.theater_type==0)?"selected":""}>2D</option>
														<option value="1" ${(theaterVO==null) ? "" : (theaterVO.theater_type==1)?"selected":""} >3D</option>
														<option value="2" ${(theaterVO==null) ? "" : (theaterVO.theater_type==2)?"selected":""} >IMAX</option>
													</select>
												</td>
											</tr>
										
										</table>
										<br>
											<div id="div1">
												<div id="d3">
												</div>&nbsp&nbsp座位
												<div id="d4">
												</div>&nbsp&nbsp走道及禁位
											</div>
										
											<div id="d1" style="">
												<div id="d2">
													螢幕位置
												</div>
											</div>
<input type="hidden" name="seat_name" value="<%= (theaterVO==null)? "A01A02A03A04A05A06A07A08A09A10A11A12A13A14A15A16A17A18A19A20B01B02B03B04B05B06B07B08B09B10B11B12B13B14B15B16B17B18B19B20C01C02C03C04C05C06C07C08C09C10C11C12C13C14C15C16C17C18C19C20D01D02D03D04D05D06D07D08D09D10D11D12D13D14D15D16D17D18D19D20E01E02E03E04E05E06E07E08E09E10E11E12E13E14E15E16E17E18E19E20F01F02F03F04F05F06F07F08F09F10F11F12F13F14F15F16F17F18F19F20G01G02G03G04G05G06G07G08G09G10G11G12G13G14G15G16G17G18G19G20H01H02H03H04H05H06H07H08H09H10H11H12H13H14H15H16H17H18H19H20I01I02I03I04I05I06I07I08I09I10I11I12I13I14I15I16I17I18I19I20J01J02J03J04J05J06J07J08J09J10J11J12J13J14J15J16J17J18J19J20K01K02K03K04K05K06K07K08K09K10K11K12K13K14K15K16K17K18K19K20L01L02L03L04L05L06L07L08L09L10L11L12L13L14L15L16L17L18L19L20M01M02M03M04M05M06M07M08M09M10M11M12M13M14M15M16M17M18M19M20N01N02N03N04N05N06N07N08N09N10N11N12N13N14N15N16N17N18N19N20O01O02O03O04O05O06O07O08O09O10O11O12O13O14O15O16O17O18O19O20P01P02P03P04P05P06P07P08P09P10P11P12P13P14P15P16P17P18P19P20Q01Q02Q03Q04Q05Q06Q07Q08Q09Q10Q11Q12Q13Q14Q15Q16Q17Q18Q19Q20R01R02R03R04R05R06R07R08R09R10R11R12R13R14R15R16R17R18R19R20S01S02S03S04S05S06S07S08S09S10S11S12S13S14S15S16S17S18S19S20T01T02T03T04T05T06T07T08T09T10T11T12T13T14T15T16T17T18T19T20" : theaterVO.getSeat_name()%>" />
<input type="hidden" name="action" value="update">
<input type="hidden" name="theater_no" value="<%=theaterVO.getTheater_no()%>">
<input type="submit" id="submit" value="送出修改">
			                        	</div>
			                    	</div>
			                    </div>
			                </main>
			            </div>
</FORM>

<script>
	let id = 0;
	let seat_no = "${theaterVO.seat_no}";
	console.log(seat_no);
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
// 		console.log( i + walkway.className);
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
			
			if((seat_no.charAt(id) == "1")){
				seat.checked = true;
			}
			console.log((seat_no.charAt(id) == "1"));
			console.log(seat.checked);
			

			document.getElementById("d1").appendChild(label);
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
				seat.nextSibling.style.backgroundColor = "antiquewhite";
			}else{
				seat.value = 1;	
			}
		}
	},false);

</script>

</body>
</html>