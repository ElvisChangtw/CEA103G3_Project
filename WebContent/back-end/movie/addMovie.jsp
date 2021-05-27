<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.movie.model.*"%>
<%@ page import="com.employee.model.*"%>

<%
	MovieVO movieVO = (MovieVO) request.getAttribute("movieVO");
%>
<%
    EmployeeVO employeeVO = (EmployeeVO) session.getAttribute("employeeVO");
%>
<!DOCTYPE html>
<html>
    <head>
    	<title>MoviesHit</title>
        <meta charset="big5" />
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
tr td>img {
	width: 180px;
	height: 200px;
}
#th1{
	font-size:40px;
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
                                <a class="nav-link function" href="layout-static.html">現場劃位</a>
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
                        <h1 class="mt-4" style="text-align:center; font-weight:bolder;">新增電影</h1>
                            <div class="card-body">
                                <div class="table-responsive">
                                   <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" name="form1" enctype="multipart/form-data">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="text-align:left;">
                                        <thead style="background-color:#9099AA; color:white;; white-space: nowrap;" >
                                            <tr>
                                            	<th id="th1" colspan="3" align="center"><CENTER>請輸入電影資料</CENTER></th>
                                            </tr>
                                        </thead>
                                        <tbody>
											<tr>
												<td width="110px;"><span style="font-weight:bolder;">電影名稱:</span></td>
												<td width="620px;"><input type="TEXT" name="moviename" size="70" placeholder="請輸入電影名稱" value="<%=(movieVO == null) ? "" : movieVO.getMoviename()%>" /></td>
												<td><font color=red>${errorMsgs.moviename}</font></td>
											</tr>
											<tr>
												<td><span style="font-weight:bolder;">電影照片1:</span></td>
												<td><img id="preview_img" src="<%=request.getContextPath()%>/images/NoData/none2.jpg" /><br>
												<input type="file" name="moviepicture1" size="45" accept="image/*" onchange="readURL(this)" targetID="preview_img"
													value="<%=(movieVO == null) ? "" : movieVO.getMoviepicture1()%>" /></td>
												<td><font color=red>${errorMsgs.moviepicture1}</font></td> 
											</tr>
											<tr>
												<td><span style="font-weight:bolder;">電影照片2:</span></td>
												<td><img id="preview_img2" src="<%=request.getContextPath()%>/images/NoData/none2.jpg" /><br>
												<input type="file" name="moviepicture2" size="45" accept="image/*" onchange="readURL(this)" targetID="preview_img2"
													value="<%=(movieVO == null) ? "QAQ" : movieVO.getMoviepicture2()%>" /></td>
												<td><font color=red>${errorMsgs.moviepicture2}</font></td> 
											</tr>
											<tr>
												<td><span style="font-weight:bolder;">導演:</span></td>
												<td><input type="TEXT" name="director" size="70" placeholder="請輸入導演名字,若有多位導演請用逗號分隔"
													value="<%=(movieVO == null) ? "" : movieVO.getDirector()%>" /></td>
												<td><font color=red>${errorMsgs.director}</font></td>
											</tr>
											<tr>
												<td><span style="font-weight:bolder;">演員:</span></td>
												<td><textarea name="actor" rows="5" cols="73" maxlength="300" placeholder="請輸入演員名字,若有多位演員請用逗號分隔"><%=(movieVO == null) ? "" : movieVO.getActor()%></textarea></td>
		<!-- 										<td><input type="TEXT" name="actor" size="70" -->
		<%-- 											value="<%=(movieVO == null) ? "" : movieVO.getActor()%>" /></td> --%>
												<td><font color=red>${errorMsgs.actor}</font></td>
											</tr>
											<tr>
												<td><span style="font-weight:bolder;">電影類型:</span></td>
												<td>
												<input type="checkbox" name="category" value="動作片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("動作片") ? "checked" : "" %>>動作片
												<input type="checkbox" name="category" value="冒險片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("冒險片") ? "checked" : "" %>>冒險片
												<input type="checkbox" name="category" value="科幻片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("科幻片") ? "checked" : "" %>>科幻片
												<input type="checkbox" name="category" value="劇情片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("劇情片") ? "checked" : "" %>>劇情片
												<input type="checkbox" name="category" value="戰爭片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("戰爭片") ? "checked" : "" %>>戰爭片
												<input type="checkbox" name="category" value="史詩片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("史詩片") ? "checked" : "" %>>史詩片
												<input type="checkbox" name="category" value="犯罪片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("犯罪片") ? "checked" : "" %>>犯罪片
												<input type="checkbox" name="category" value="警匪片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("警匪片") ? "checked" : "" %>>警匪片
												<input type="checkbox" name="category" value="奇幻片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("奇幻片") ? "checked" : "" %>>奇幻片
												<br>
												<input type="checkbox" name="category" value="恐怖片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("恐怖片") ? "checked" : "" %>>恐怖片
												<input type="checkbox" name="category" value="驚悚片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("驚悚片") ? "checked" : "" %>>驚悚片
												<input type="checkbox" name="category" value="懸疑片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("懸疑片") ? "checked" : "" %>>懸疑片
												<input type="checkbox" name="category" value="喜劇片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("喜劇片") ? "checked" : "" %>>喜劇片
												<input type="checkbox" name="category" value="愛情片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("愛情片") ? "checked" : "" %>>愛情片
												<input type="checkbox" name="category" value="文藝片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("文藝片") ? "checked" : "" %>>文藝片
												<input type="checkbox" name="category" value="動畫片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("動畫片") ? "checked" : "" %>>動畫片
												<input type="checkbox" name="category" value="音樂片" <%=(movieVO == null)? "" : movieVO.getCategory().contains("音樂片") ? "checked" : "" %>>音樂片
												<input type="checkbox" name="category" value="歌舞劇" <%=(movieVO == null)? "" : movieVO.getCategory().contains("歌舞劇") ? "checked" : "" %>>歌舞劇
												</td>
												<td><font color=red>${errorMsgs.category}</font></td>
											</tr>
											<tr>
												<td><span style="font-weight:bolder;">電影長度:</span></td>
												<td><input type="TEXT" name="length" size="70" placeholder="請輸入幾分鐘"
													value="<%=(movieVO == null) ? "" : movieVO.getLength()%>" /></td>
												<td><font color=red>${errorMsgs.length}</font></td>
											</tr>
											<tr>
												<td><span style="font-weight:bolder;">電影狀態:</span></td>
												<td><select name="status" size="1" style="width:555px;"> 
													<option value="9" <%= ((movieVO == null) ? "" : (movieVO.getStatus().equals("9") ? "selected" : ""))%>>請選擇</option>
													<option value="0" <%= ((movieVO == null) ? "" : (movieVO.getStatus().equals("0") ? "selected" : ""))%>>上映中</option>
													<option value="1" <%= ((movieVO == null) ? "" : (movieVO.getStatus().equals("1") ? "selected" : ""))%>>未上映</option>
													<option value="2" <%= ((movieVO == null) ? "" : (movieVO.getStatus().equals("2") ? "selected" : ""))%>>已下檔</option>
												</select></td>
												<td><font color=red>${errorMsgs.status}</font></td>
											</tr>
											<tr>
												<td><span style="font-weight:bolder;">上映日期:</span></td>
												<td><input name="premiredate" id="f_date1" type="text" size="70" 
												value="<%=(movieVO == null) ? "" : movieVO.getPremiredate()%>"></td>
												<td><font color=red>${errorMsgs.premiredate}</font></td>
											</tr>
											<tr>
												<td><span style="font-weight:bolder;">下檔日期:</span></td>
												<td><input name="offdate" id="f_date2" type="text" size="70" 
												value="<%=(movieVO == null) ? "" : movieVO.getOffdate()%>"></td>
												<td><font color=red>${errorMsgs.offdate}</font></td> 
											</tr>
											<tr>
												<td><span style="font-weight:bolder;">預告片:</span></td>
												<td><input type="TEXT" name="trailor" size="70" placeholder="請輸入Youtube網址,若尚無預告片保持空白即可"
													value="<%=(movieVO == null) ? "" : movieVO.getTrailor()%>" /></td>
												<td><font color=red>${errorMsgs.trailor}</font></td>
											</tr>
<!-- 											<tr> -->
<!-- 												<td><span style="font-weight:bolder;">短預告片:</span></td> -->
<!-- 												<td><input type="TEXT" name="embed" size="70" -->
<%-- 													value="<%=(movieVO == null) ? "" : movieVO.getEmbed()%>" /></td> --%>
<!-- 											</tr> -->
											<tr>
												<td><span style="font-weight:bolder;">電影分級:</td>
												<td><select name="grade" size="1" style="width:555px;"> 
													<option value="9"<%= ((movieVO == null) ? "" : (movieVO.getGrade().equals("9") ? "selected" : ""))%>>請選擇</option>
													<option value="0"<%= ((movieVO == null) ? "" : (movieVO.getGrade().equals("0") ? "selected" : ""))%>>普遍級</option>
													<option value="1"<%= ((movieVO == null) ? "" : (movieVO.getGrade().equals("1") ? "selected" : ""))%>>保護級</option>
													<option value="2"<%= ((movieVO == null) ? "" : (movieVO.getGrade().equals("2") ? "selected" : ""))%>>輔導級</option>
													<option value="3"<%= ((movieVO == null) ? "" : (movieVO.getGrade().equals("3") ? "selected" : ""))%>>限制級</option>				
												</select></td>
												<td><font color=red>${errorMsgs.grade}</font></td>
											</tr>
											
											
											<tr>
												<td></td>
												<td></td>
												<td>
													<input type="hidden" name="action" value="insert">
													<input type="submit" value="新增" id="send"
													class="btn btn-outline-danger" style="float:right; border:2px #B7B7B7 solid;border-radius:10px; background-color:#FF4268; font-weight:bold; color:white;">
											</tr>
                                            <tr>
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
	java.sql.Date premiredate = null;
	try {
		premiredate = movieVO.getPremiredate();
	} catch (Exception e) {
		premiredate = new java.sql.Date(System.currentTimeMillis());
	}

	java.sql.Date offdate = null;
	try {
		offdate = movieVO.getOffdate();
	} catch (Exception e) {
		offdate = new java.sql.Date(System.currentTimeMillis());
	}
%>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script
	src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=premiredate%>', // value:   new Date(),
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	//startDate:	            '2017/07/10',  // 起始日
	minDate:               '-1970-01-01', // 去除今日(不含)之前
	//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});

        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=offdate%>', // value:   new Date(),
		//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
		//startDate:	            '2017/07/10',  // 起始日
		minDate : '-1970-01-01', // 去除今日(不含)之前
	//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});
	// ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

	//      1.以下為某一天之前的日期無法選擇
	//      var somedate1 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      2.以下為某一天之後的日期無法選擇
	//      var somedate2 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
	//      var somedate1 = new Date('2017-06-15');
	//      var somedate2 = new Date('2017-06-25');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//		             ||
	//		            date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});
</script>
</html>
