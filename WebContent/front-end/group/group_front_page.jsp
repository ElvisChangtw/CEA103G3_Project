<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.group.model.*"%>
<%@ page import="com.mem.model.*" %>

<%
	GroupService groupSvc = new GroupService();
	List<GroupVO> list = groupSvc.getAll();
	pageContext.setAttribute("list", list);
	
	MemVO memVO = (MemVO) session.getAttribute("memVO");
	if(memVO == null){
		memVO = new MemVO();
		memVO.setMember_no(999);
	}
	
	
	pageContext.setAttribute("memVO", memVO);
%>

<!--
author: W3layouts
author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE html>
<html>

<head>
    <title>MoviesHit揪團啾啾</title>
    <!-- for-mobile-apps -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=big5" />
    <script type="application/x-javascript">
        addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);

        function hideURLbar() { window.scrollTo(0, 1); }
    </script>
    <!-- //for-mobile-apps -->
    <link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    
    <!-- pop-up -->
    <link href="<%=request.getContextPath()%>/css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
    <!-- //pop-up -->
    <link href="<%=request.getContextPath()%>/css/easy-responsive-tabs.css" rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/zoomslider.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
    <link href="<%=request.getContextPath()%>/css/font-awesome.css" rel="stylesheet">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/modernizr-2.6.2.min.js"></script>
    <!--/web-fonts-->
    <link href='https://fonts.googleapis.com/css?family=Tangerine:400,700' rel='stylesheet' type='text/css'>
    <link href="https://fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    <!--//web-fonts-->
	<!--     自定義css格式開始 -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styleForGroup.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<!--     自定義css格式結束 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- 	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
<!-- 	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script> -->
	
	
<style>
  /* 通知用 */
  @import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

.fadeOut {
  opacity: 0 !important;
}

#create {
  border: none !important;
  padding: 8px !important;
  font-size:15px !important;
  color: #FFF !important;
  background-color: firebrick !important;
  border-radius: 8px !important;
}

.alert-container{
  position: fixed !important;
  right: 10px !important;
  bottom: 10px !important;
}

.alert {
  position: relative !important;
  background-color: white !important;
  border: 5px solid lightblue !important;
  height: 130px !important;
  width: 290px !important;
  border-radius: 15px !important;
  margin-bottom: 15px !important;
  color: #40bde6 !important;
  padding: 20px 15px 0 15px !important;
  transition: opacity 2s !important;
}

.alert span {
  font-size: 1.3rem !important;
  position: absolute !important;
  top: 3px !important;
  right: 12px !important;
  cursor: pointer !important;

}
.alertTxt{
  font-size: 17px !important;
  position: absolute !important;
  top: 0px !important;
  right: 12px !important;
  cursor: pointer !important;
  margin-top:23px !important;
  width:170px !important;

}
.alertImg{
  width:80px !important;
  margin-left:-5px !important;

}

.alertTxt .alertTime{
	font-size:10px !important;
	color:gray;
}
</style>	
</head>

<body onload="connect();" onunload="disconnection();">

    <!--/main-header-->
    <!--/banner-section-->
    <jsp:include page="/front_header.jsp"/>
    <!--/banner-section-->
    <!--//main-header-->
    <!--/banner-bottom-->
    
    
    <!-- 萬用查詢navbar -->
    
<!--     <ul class="nav justify-content-end">   -->
<!--   	<li class="searchbar">    -->
  
    <nav class="navbar navbar-light" style="background-color: rgb(2, 163, 136, 0.3);">
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group/group.do" name="form1" class="form-inline my-2 my-lg-0 composite-query">
		<div class="form-row">
			搜尋揪團:
			<div class="form-group col-2">
				<input type="text" name=group_title value="" class="form-control" placeholder="請輸入揪團名" id="li1"><br>
			</div>
			<div class="form-group col-2">
				<input type="text" name="mb_name" value="" class="form-control" placeholder="請輸入主揪名"><br>
			</div>
	       <div class="form-group col-2">
				<input type="text" name="movie_name" value="" class="form-control" placeholder="請輸入電影"><br>
			</div>
	       <div class="form-group col-2">
				<input type="text" name="showtime_time" id="f_date1" class="form-control" placeholder="請輸入觀影日期">
<!-- 		       <input type="text" name="OFF_DT" id="f_date2" class="form-control" placeholder="請輸入觀影日期" ><br> -->
			</div>

			<div class="form-group col-2">
	       <select  name="category" class="form-control form-control-sm" >
				<option value="">請選擇電影類型</option>
				<option value="動作片">動作片</option>
				<option value="冒險片">冒險片</option>
				<option value="科幻片">科幻片</option>
				<option value="犯罪片">犯罪片</option>
				<option value="警匪片">警匪片</option>
				<option value="喜劇片">喜劇片</option>
				<option value="劇情片">劇情片</option>
				<option value="愛情片">愛情片</option>
	       	</select><br>
	       	</div>

			<div class="form-group col-2">
				<input type="hidden" name="action" value="listGroups_ByCompositeQuery">
		      	<button class="btn btn-danger btn-md" type="submit" value="送出">搜尋</button>
	      	</div>
	      	
	      	<div class="form-group col-2">
				<a href="<%=request.getContextPath()%>/front-end/group/addGroup.jsp" 
								style="margin-bottom: 0px;" class="btn btn-info" id="add-group-btn">建立揪團</a>
	      	</div>
	      	
		</div>
     </FORM>
     </nav>
<!--   </li> -->
<!-- </ul> -->


<!-- 萬用查詢navbar -->
			        
    </div>
    <!--//banner-bottom-->
    <!-- Modal1 -->
    <div class="modal fade" id="myModal4" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4>Login</h4>
                    <div class="login-form">
                        <form action="#" method="post">
                            <input type="email" name="email" placeholder="E-mail" required="">
                            <input type="password" name="password" placeholder="Password" required="">
                            <div class="tp">
                                <input type="submit" value="LOGIN NOW">
                            </div>
                            <div class="forgot-grid">
                                <div class="log-check">
                                    <label class="checkbox"><input type="checkbox" name="checkbox">Remember me</label>
                                </div>
                                <div class="forgot">
                                    <a href="#" data-toggle="modal" data-target="#myModal2">Forgot Password?</a>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- //Modal1 -->
    <!-- Modal1 -->
    <div class="modal fade" id="myModal5" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4>Register</h4>
                    <div class="login-form">
                        <form action="#" method="post">
                            <input type="text" name="name" placeholder="Name" required="">
                            <input type="email" name="email" placeholder="E-mail" required="">
                            <input type="password" name="password" placeholder="Password" required="">
                            <input type="password" name="conform password" placeholder="Confirm Password" required="">
                            <div class="signin-rit">
                                <span class="agree-checkbox">
                                    <label class="checkbox"><input type="checkbox" name="checkbox">I agree to your <a class="w3layouts-t" href="#" target="_blank">Terms of Use</a> and <a class="w3layouts-t" href="#" target="_blank">Privacy Policy</a></label>
                                </span>
                            </div>
                            <div class="tp">
                                <input type="submit" value="REGISTER NOW">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- //Modal1 -->
    <!-- breadcrumb -->
<!--     <div class="w3_breadcrumb"> -->
<!--         <div class="breadcrumb-inner"> -->
<!--             <ul> -->
<%--                 <li><a href="<%=request.getContextPath()%>/front-end/group/select_page.jsp">Home</a><i>//</i></li> --%>
<!--                 <li>Groups</li> -->
<!--             </ul> -->
<!--         </div> -->
<!--     </div> -->

    
    <div class="list-btn">
		<ul class="nav nav-tabs">
		  <li role="presentation" class="active"><a href="<%=request.getContextPath()%>/front-end/group/group_front_page.jsp">所有揪團</a></li>
		  <c:choose>
			  <c:when test="${memVO.member_no != 999}">
				  <li role="presentation"><a href="<%=request.getContextPath()%>/group/group.do?action=listMyGroups&member_no=${memVO.member_no}&group_status=0">我的揪團(尚未出團)</a></li>
				  <li role="presentation"><a href="<%=request.getContextPath()%>/group/group.do?action=listMyGroups&member_no=${memVO.member_no}&group_status=1">我的揪團(已成行)</a></li>
				  <li role="presentation"><a href="<%=request.getContextPath()%>/group/group.do?action=listMyGroups&member_no=${memVO.member_no}&group_status=3">我的歷史揪團</a></li>
			  </c:when>
			  <c:otherwise>
			  	  <li><a href="#" onclick="loginFirst()">我的揪團(尚未出團)</a></li>
				  <li><a href="#" onclick="loginFirst()">我的揪團(已成行)</a></li>
				  <li><a href="#" onclick="loginFirst()">我的歷史揪團</a></li>
			  </c:otherwise>
		  </c:choose>
		</ul>
    </div>
    <!-- //breadcrumb -->
    <!--/content-inner-section-->
    <!--揪團列表外層div -->
    
    
    <div class="w3_content_agilleinfo_inner">
        <div class="agile_featured_movies">
            <!--/tv-movies-->
            <h3 class="agile_w3_title hor-t"><span>揪團列表</span> </h3>
<!-- 			換頁 -->
			<%@ include file="pages/page1.file"%>
<!-- 			換頁 -->

            <div class="wthree_agile-requested-movies tv-movies">
            
            <c:forEach var="groupVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">

			<jsp:useBean id="showtimeSvc" scope="page" class="com.showtime.model.ShowtimeService" />
            <jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />
                        
<!--單一揪團開始 -->
                <div class="col-md-2 w3l-movie-gride-agile requested-movies">
                    <a href="<%=request.getContextPath()%>/group/group.do?action=getOne_For_Display&group_no=${groupVO.group_no}&requestURL=<%=request.getServletPath()%>" class="hvr-sweep-to-bottom">
                    	<img src="<%=request.getContextPath()%>/movie/DBGifReader4.do?movieno=${showtimeSvc.getOneShowtime(groupVO.showtime_no).movie_no}" title="MoviesHit" class="img-responsive" alt="尚無圖片"
                    	 ${(groupVO.group_no==param.group_no) ? 'style="background-color:rgb(2, 163, 136, 0.3);"':''}>
                        <div class="w3l-action-icon"><i class="fa fa-play-circle-o" aria-hidden="true"></i></div>
                    </a>
                    <div class="mid-1 agileits_w3layouts_mid_1_home" ${(groupVO.group_no==param.group_no) ? 'style="background-color:rgb(2, 163, 136, 0.3);"':''}>
                        <div class="w3l-movie-text">
                            <h6><a href="<%=request.getContextPath()%>/group/group.do?action=getOne_For_Display&group_no=${groupVO.group_no}&requestURL=<%=request.getServletPath()%>" class="group-title">${groupVO.group_title}</a></h6>
                        </div>
                        
                        <div class="mid-2 agile_mid_2_home">
                            <p><i class="fa fa-film" aria-hidden="true"></i> ${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(groupVO.showtime_no).movie_no).moviename}</p><br>
                            
                            <p><i class="fa fa-clock-o" aria-hidden="true"></i> <fmt:formatDate value="${groupVO.deadline_dt}" pattern="yyyy-MM-dd HH:mm" /></p><br>
                            	<p><i class="fa fa-user" aria-hidden="true"></i> ${groupVO.member_cnt}/${groupVO.required_cnt}</p><br>
                            <div class="clearfix"></div>
                        </div>
                    </div>
<!--                     <div class="ribben one"> -->
<!--                         <p>熱映中</p> -->
<!--                     </div> -->
                </div>
<!--單一揪團結束 -->
              </c:forEach>
              <div class="clearfix"></div>
              <!-- 			換頁 -->
              <%@ include file="pages/page2.file"%>
<!-- 			換頁 -->

        </div>
    </div>
</div>
    <!--//content-inner-section-->
    <!--揪團列表外層div -->
    <!--/footer-bottom-->
    <jsp:include page="/front_footer_copy.jsp"/>
    <!--/footer-bottom-->

    <!-- pop-up-box -->
   

    <script src="<%=request.getContextPath()%>/js/easy-responsive-tabs.js"></script>
    <!--/script-->
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/move-top.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/easing.js"></script>
    <script type="text/javascript">
        jQuery(document).ready(function($) {
            $(".scroll").click(function(event) {
                event.preventDefault();
                $('html,body').animate({ scrollTop: $(this.hash).offset().top }, 900);
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function() {
        $().UItoTop({ easingType: 'easeOutQuart' });

        });
    </script>
    <!--end-smooth-scrolling-->
    <script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>


</body>
	
<% 
  java.sql.Timestamp crt_dt = null;
  java.sql.Timestamp crt_dt_end = null;
  final long DIFF = System.currentTimeMillis() - (1000 * 60 * 60 *24 * 14); //30天前
  
	crt_dt = new java.sql.Timestamp(DIFF);	
	crt_dt_end = new java.sql.Timestamp(System.currentTimeMillis());


%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
 	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: ''    // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        $('#f_date2').datetimepicker({
  	       theme: '',              //theme: 'dark',
 	       timepicker:false,       //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
 		   value: ''    // value:   new Date(),
            //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
            //startDate:	            '2017/07/10',  // 起始日
            //minDate:               '-1970-01-01', // 去除今日(不含)之前
            //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
         });
        function loginFirst(){
        	alert("請先登入");
        	window.location.href = "<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp";
        }

</script>
<script>
var MyPoint = "/NotifyWS/${memVO.member_no}";
	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
	var friendNO;
	var groupNO;
	var movieNO;
	var groupName;
	var goGroupName;
	var kickGroupName;
	var memberNO;
	var self = '${memVO.member_no}';
	var webSocket;
	var type;
	var activeDismissGroupNO;


	$(".addFriend").click(function(){
		friendNO = $(this).find("input.friendNO").val();
		sendWebSocket($(this));
	})
	$(".addGroup").click(function(){
		groupNO = $(this).find("input.groupNO").val();
		sendWebSocket($(this));
	})
	$(".buyTicket").click(function(){
		movieNO = $(this).find("input.movieNO").val();
		sendWebSocket($(this));
	})
	$(".addfriend_check_btn").click(function(){
		friendNO = $(this).find("input.friendNO").val();
		sendWebSocket($(this));
		//這邊執行insertfriend的code
	})
	$(".createGroup").click(function(){
		groupName = document.getElementById("groupName").value;  //不可放在上面宣告，因為groupname是使用者自己打要click後才會取直，所以要放在click事件內
		sendWebSocket($(this));
	})
	$(".kickoffGroup").click(function(){
		kickGroupName = $(this).find("input.kickGroupName").val();
		sendWebSocket($(this));
	})
	$(".reminder").click(function(){
		memberNO = $(this).find("input.memberNO").val();
		sendWebSocket($(this));

	})
	$(".activeDismissGroup").click(function(){
		activeDismissGroupNO = $(this).find("input.activeDismissGroupNO").val();
		sendWebSocket($(this));
	})
	
	
	function sendWebSocket(item){
		let timespan = new Date();
		let timeStr = timespan.getFullYear() + "-" + (timespan.getMonth()+1).toString().padStart(2, "0") + "-" 
					+ timespan.getDate() + " " + timespan.getHours().toString().padStart(2, "0") + ":" + timespan.getMinutes().toString().padStart(2, "0");
		if(item.hasClass("addFriend")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : friendNO,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("addGroup")){
			type = "addGroup";
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : groupNO,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("buyTicket")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : movieNO,
				"message":"",
				"time":timeStr
			};
		}
		if(item.val()==1){
			var jsonObj = {
				"type" : "response",
				"sender" : self,
				"receiver" : friendNO,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("createGroup")){
			type = "createGroup";
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : groupName,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("goGroup")){
			type = "goGroup";
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : goGroupName,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("kickoffGroup")){
			type = "kickoffGroup";
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : kickGroupName,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("reminder")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : memberNO,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("activeDismissGroup")){
			type = "activeDismissGroup";
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : activeDismissGroupNO,
				"message":"",
				"time":timeStr
			};
		}

		webSocket.send(JSON.stringify(jsonObj));
	}
	

	function connect() {
		console.log(endPointURL);
		// create a websocket
		webSocket = new WebSocket(endPointURL);

		webSocket.onopen = function(event) {
			

		};

		webSocket.onmessage = function(event) {
			console.log(event.data);
			var jsonObj = JSON.parse(event.data);
			var text = jsonObj.message;
			var time = jsonObj.time;
			var type = jsonObj.type;
			console.log(jsonObj)
			createAlert(text,time,type);
			
		};

		webSocket.onclose = function(event) {
			console.log("Disconnected!");
		};
	}
	
	function disconnect() {
		webSocket.close();
	}
	
	
// 	產生通知block在視窗右下角
	  const alertContainer = document.querySelector('.alert-container');
	  const btnCreate = document.getElementById('create');
	  const createAlert = (text,time,type) => {
		  
	  const newAlert = document.createElement('div');
	  const closeNewAlert = document.createElement('span');
	  const imgdiv = document.createElement('div');
	  const img = document.createElement('img');
	  const txt = document.createElement('div');
	  const time_str = document.createElement('div');
	  
	  if (type==="addFriend"||type==="response"){
		  img.src="<%=request.getContextPath()%>/images/notify_icons/friend.png"
	  }
	  if (type==="addGroup"||type==="createGroup"||type==="goGroup"||type==="activeDismissGroup"){
			img.src="<%=request.getContextPath()%>/images/notify_icons/group.png"
	  }
	  if (type==="buyTicket"){
			img.src="<%=request.getContextPath()%>/images/notify_icons/ticket.png"
	  }
	  if (type==="reminder"||type==="dismissGroup"||type==="kickoffGroup"||type==="kickUnpaid"){
			img.src="<%=request.getContextPath()%>/images/notify_icons/warning.png"
	  }
	  
		  img.classList.add("alertImg");
		  imgdiv.append(img);
		  txt.innerText = text;
		  txt.classList.add("alertTxt");
		  time_str.innerText = time;
		  time_str.classList.add("alertTime");
		  txt.append(time_str);
		  newAlert.prepend(imgdiv);
		  newAlert.append(txt)
		  closeNewAlert.innerHTML = '&times;';
		  
		  newAlert.appendChild(closeNewAlert);
		  
		  newAlert.classList.add('alert');
		  
		  alertContainer.appendChild(newAlert);
		  
		  setTimeout(()=> {
		    newAlert.classList.add('fadeOut');
		  },3000)
		  
		  setTimeout(()=> {
		    newAlert.remove();
		  },5000)
		  
		
	};

	alertContainer.addEventListener('click', (e) => {
	    if(e.target.nodeName == 'SPAN') {
	        e.target.parentNode.remove();
	    }
	})

</script>
	
</html>