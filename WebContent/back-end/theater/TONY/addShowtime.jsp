<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.showtime.model.*"%>

<%
  ShowtimeVO showtimeVO = (ShowtimeVO) request.getAttribute("showtimeVO");
  java.util.Date date = new java.util.Date();
  pageContext.setAttribute("date", date);
%>
<jsp:useBean id="theaterSvc" scope="page" class="com.theater.model.TheaterService" />
<jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />

<!DOCTYPE html>
<html lang="en">
    <head>
    	<title>後台　新增場次</title>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <link href="<%=request.getContextPath()%>/back-home/css/styles.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>


<style>
tr td>img {
	width: 180px;
	height: 200px;
}
#th1{
	font-size:40px;
}
</style>

<!-- 以下為TONY STYLE -->

<style>
  table {
/*  	width: 450px; */
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
  .delete{
/* 		background-color: black; */
 		color: white;
		font-size: 8px;
		width: 90px;
		height: 40px;
		line-height: 20px;
		text-align: center;
		cursor: pointer;
		float: right;
		border: 2px #B7B7B7 solid;
		border-radius: 10px;
		background-color: #FF4268;
		font-weight: bold;
		}
  #table{
  text-align:center;
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
                <main>
                    <div class="container-fluid">
                        <h1 class="mt-4" style="text-align:center; font-weight:bolder;">後台　新增場次</h1>
                            <div class="card-body">
                                <div class="table-responsive">
                                   <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/showtime/showtime.do" name="form1">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="text-align:left;">
                                        <thead style="background-color:#9099AA; color:white;; white-space: nowrap;" >
                                            <tr>
                                            	<th id="th1" colspan="3" align="center"><CENTER>請輸入場次資料</CENTER></th>
                                            </tr>
                                        </thead>
                                        <tbody>
											<tr>
												<td width="110px;"><span style="font-weight:bolder;">電影</span></td>
												<td width="800px;">
													<select name="movie_no">
														<c:forEach var="movieVO" items="${movieSvc.all}" >
															<c:if test="${movieVO.offdate.compareTo(date)>(-1)}">
																<option name = "${movieVO.length}" value= "${movieVO.movieno}">${movieVO.moviename}</option>
															</c:if>
														</c:forEach>
													</select>
 												</td>
												<td>
													<font color=red><%-- 錯誤表列 --%>
														<c:if test="${not empty errorMsgs}">
															<font style="color:red">請修正以下錯誤:</font>
															<ul>
																<c:forEach var="message" items="${errorMsgs}">
																	<li style="color:red">${message}</li>
																</c:forEach>
															</ul>
														</c:if>
													</font>
												</td>
											</tr>
											<tr>
												<td><span style="font-weight:bolder;">廳院</span></td>
												<td>
													<select name="theater_no">
														<c:forEach var="theaterVO" items="${theaterSvc.all}" >
															<option value= "${theaterVO.theater_no}">${theaterVO.theater_name}</option>
														</c:forEach>
													</select>
												</td>
												<td></td> 
											</tr>
											<tr>
												<td><span style="font-weight:bolder;">日期</span></td>
												<td>
													<input name="showtime_date" class="f_date1" type="text">
												</td>
												<td></td> 
											</tr>
											<tr>
												<td><span style="font-weight:bolder;"></span></td>
												<td>
													<input name="showtime_date" class="f_date1" type="text">
												</td>
												<td></td>
											</tr>
											<tr>
<!-- 												<td><span style="font-weight:bolder;">新增時間</span></td> -->
												<td>
													<input type="button" value="新增時間" id="insert_time"
											     	class="btn btn-outline-danger" style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#AE67D8; font-weight:bold; color:white;">
												</td>
												<td>
<!-- 													<table id="table"> -->
<!-- 														<tr> -->
<!-- 															<td>編號</td> -->
<!-- 															<td>時間</td> -->
<!-- 															<td></td> -->
<!-- 														</tr> -->
<!-- 													</table> -->
												</td>
												<td></td>
 												
											</tr>
											
											<tr>
												<td></td>
												<td></td>
												<td>
													<input type="hidden" name="action" value="insert2">
													<input type="submit" value="送出新增" id="send"
													class="btn btn-outline-danger" style="float:right; border:2px #B7B7B7 solid;border-radius:10px; background-color:#FF4268; font-weight:bold; color:white;">
												</td>
											</tr>
                                            <tr>
                                            </tr>
                                        </tbody>
                                    </table>
                                    
                                    
                                    
                                    
                                    <table class="table table-bordered" id="table" width="100%" cellspacing="0" style="text-align:left;">
                                        
                                        <tbody>
											<tr>
															<td style="width:110px;">編號</td>
															<td style="width:8000px;">時間</td>
															<td></td>
														</tr>

                                        </tbody>
                                    </table>

                                    
                                    
                                    
								</FORM>
								
								
                                </div>
                            </div>
                    </div>
                </main>

            </div>
        
        
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/back-home/js/scripts.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/back-home/dist/assets/demo/datatables-demo.js"></script>
    </body>

<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
  java.sql.Timestamp showtime_time = null;
  try {
	  showtime_time = showtimeVO.getShowtime_time();
   } catch (Exception e) {
	   showtime_time = new java.sql.Timestamp(System.currentTimeMillis() + 5 * 24 * 60 * 60 * 1000);
   }
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('.f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=showtime_time%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
            minDate:               '<%=showtime_time%>', // 去除今日(不含)之前	
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
           
            onChangeDateTime:function(dp, $dom){
			   if((Date.parse($dom.parent().find("input").eq(1).val())).valueOf() 
					   < (Date.parse($dom.parent().find("input").eq(0).val())).valueOf()){
		    	   alert("錯誤:後面日期不得為前面日期之前")	
				   $dom.parent().find("input").eq(0).val($dom.parent().find("input").eq(1).val());
           		}
            }
           });
        
        
        	$("#table").hide()
        
			let option = document.getElementsByName("movie_no").item(0).children;
        	console.log(option);
		 	let length = 0;
		 	for(var x = 0; x < option.length; x++){
// 		 		if(option.item(x).selected == true){
		 			length = option.item(x).getAttribute("name");
		 			console.log(length);
// 		 		}
		 	}
        	
        	let i = 0;
			let hour = 10;
// 			let date = "2016-11-25T";
			let insert_time = document.getElementById("insert_time");
			insert_time.addEventListener("click",function(){
				$("#table").show();
				let table = document.getElementById("table");
				let tr = document.createElement("tr");
				let no = document.createElement("td")
				let time = document.createElement("td");
				let input = document.createElement("input");
				let btn = document.createElement("div");
				
		
				input.setAttribute("type", "text");
				input.setAttribute("class", "time");
				input.setAttribute("name", "showtime");
		
				no.innerText = i + 1;
				btn.innerText = "刪除";
				btn.setAttribute("class", "delete");
// 				btn.setAttribute("type", "button");
				btn.addEventListener("click", function(){
					this.parentElement.remove();
				})
				
			 	for(var x = 0; x < option.length; x++){
			 		if(option.item(x).selected == true){
			 			length = parseInt(option.item(x).getAttribute("name"),10) + 30 +  5 - (parseInt(option.item(x).getAttribute("name"),10) % 5);
			 			console.log(length);
			 			break;
			 		}
			 	}
				
				time.appendChild(input);
				tr.appendChild(no);
				tr.appendChild(time);
				tr.appendChild(btn);
				table.appendChild(tr);
				console.log(i);
				if( i === 0){
					input.value = hour + ":00:00";
				}else{
					let time = $("#table").find("input").eq(i-1).val();
					console.log(time);
				 	let date = "2016-11-25T";
				 	let date_time = date + time;
				 	
				 	let s = Date.parse(date_time) + length * 60 * 1000;
				 	let new_time = new Date(s);
				 	console.log(new_time);
				 	let newTime = "";
				 	let hours = "";
				 	let minutes = "";
				 	if(new_time.getHours() < 10){
				 		hours = "0" + new_time.getHours();
				 	}else{
				 		hours = new_time.getHours();
				 	}

				 	if(new_time.getMinutes() < 10){
				 		minutes = "0" + new_time.getMinutes();
				 	}else{
				 		minutes = new_time.getMinutes();
				 	}
					 	newTime = hours + ":" + minutes + ":00";
						input.value = newTime;
				}
					i++;
				
				$('.time').datetimepicker({
				       theme: '',              //theme: 'dark',
				       datepicker:false,
				       timepicker:true,       //timepicker:true,
				       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
				       format:'H:i:s',         //format:'Y-m-d H:i:s',
					   value: '', // value:   new Date(),
			           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
			           //startDate:	            '2017/07/10',  // 起始日
//			            minDate:               '-1970-01-01', // 去除今日(不含)之前
			           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
			           
					   onChangeDateTime:function(dp, $dom){
// 					       console.log(dp)
// 					       console.log($dom.val())
// 						let prevtime = $dom.parent().parent().prev().find("input").get(0).value;
// 						let nextTime = $dom.parent().parent().next().find("input").get(0).value;
					    let time = $dom.val();
// 					    let prevdatetime = date + prevtime;
// 					    let nextdatetime = date + nextTime;
					    let datetime = date + time;
					    
					    if($dom.parent().parent().prev().find("input").get(0) != undefined){
					    	let prevtime = $dom.parent().parent().prev().find("input").get(0).value;
					    	let prevdatetime = date + prevtime;
						    if((Date.parse(datetime) - Date.parse(prevdatetime)) / (2 * 60 * 60 * 1000) < 1){
						    	alert("間距不得少於2小時");
							 	let s = Date.parse(prevdatetime) + 120 * 60 * 1000;
							 	let new_time = new Date(s);
							 	let newTime = "";
							 	let hours = "";
							 	let minutes = "";
							 	if(new_time.getHours() < 10){
							 		hours = "0" + new_time.getHours();
							 	}else{
							 		hours = new_time.getHours();
							 	}
	
							 	if(new_time.getMinutes() < 10){
							 		minutes = "0" + new_time.getMinutes();
							 	}else{
							 		minutes = new_time.getMinutes();
							 	}
	
							 	newTime = hours + ":" + minutes + ":00";
								$dom.val(newTime);
						    }
					    }
					    if($dom.parent().parent().next().find("input").get(0) != undefined){
					    	let nextTime = $dom.parent().parent().next().find("input").get(0).value;
					    	let nextdatetime = date + nextTime;
						    if((Date.parse(nextdatetime) - Date.parse(datetime)) / (2 * 60 * 60 * 1000) < 1){
						    	alert("間距不得少於2小時");
						    	let s = Date.parse(nextdatetime) - 120 * 60 * 1000;
							 	let new_time = new Date(s);
							 	let newTime = "";
							 	let hours = "";
							 	let minutes = "";
							 	if(new_time.getHours() < 10){
							 		hours = "0" + new_time.getHours();
							 	}else{
							 		hours = new_time.getHours();
							 	}
	
							 	if(new_time.getMinutes() < 10){
							 		minutes = "0" + new_time.getMinutes();
							 	}else{
							 		minutes = new_time.getMinutes();
							 	}
	
							 	newTime = hours + ":" + minutes + ":00";
								$dom.val(newTime);
					    	}
					    }
					   }
			        });
	});
        
        
</script>

 
</html>
