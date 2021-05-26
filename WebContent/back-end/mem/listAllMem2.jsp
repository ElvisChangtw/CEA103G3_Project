<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>

<%
    MemService memSvc = new MemService();
    List<MemVO> list = memSvc.getAll();
    pageContext.setAttribute("list",list);
	MemVO memVO = (MemVO)session.getAttribute("memVO");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
    	<title>後台瀏覽所有會員</title>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/front/notification.css" /> --%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css">
        
        <link href="<%=request.getContextPath()%>/back-home/css/styles.css" rel="stylesheet" />
<!--         <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" /> -->
        
	
        
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
	
	  table {
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
	
	  tr td img{
	  	width:150px;
	  	height:150px;
	  }
	  img {  
		max-width:600px;
		myimg:expression(onload=function(){
		this.style.width=(this.offsetWidth > 600)?"600px":"auto"});
	  }
	  .table th, .table td{
	  	vertical-align: 0px;
	  }
	  
	  th{
	 background-color: #4aa42a;
	  }

</style>
<style>
		h2 { 
		    position: absolute; 
		    top: 0px; 
		    left: 10;  
			} 
		span {
    		color: #02a388;
   			font-size: 1em;
   			}	
   		.bootstrap-table .fixed-table-container .fixed-table-body {	
   			overflow-x: unset; 
			overflow-y: unset;
   		}
   		.bootstrap-table bootstrap4{
   			padding:50px !important;
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
                <a class="nav-link dropdown-toggle1" id="userDropdown" href="index2.jsp" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
            </li>
            <a class="nav-link" href="index2.jsp">
               	 登出
            </a>
        </ul>
    </nav>
    
    
    
    
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
		<img src="<%=request.getContextPath()%>/back-home/img/logo2-1-6.png">
                         <h1 style="text-align: center;color: white;font-weight: bold ;font-size:35px">
                         	<span>M</span>ovies<span>H</span>it
                         </h1>

                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLayouts1" aria-expanded="false" aria-controls="collapseLayouts1">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-cog"></i></div>
                           	 員工管理系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseLayouts1" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/employee/listAllEmployee2.jsp">員工管理</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                            <div class="sb-nav-link-icon"><i class="fas fa-video"></i></div>
                         	   影城基本資料系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/movie/backEndlistAllMovie.jsp">電影資料管理</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/showtime/listAllShowtime.jsp">場次管理</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/theater/listAllTheater.jsp"> 廳院管理</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/ticket_type/listAllTicket_type.jsp">票種管理</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/food/listAllFood.jsp">餐點管理</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages2" aria-expanded="false" aria-controls="collapsePages2">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-clock"></i></div>
                            	會員管理系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages2" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/mem/listAllMem2.jsp">會員資料管理</a>
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
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/order/listAllOrder.jsp">訂單管理</a>
                            </nav>
                        </div>
           				 <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages4" aria-expanded="false" aria-controls="collapsePages4">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-alt-slash"></i></div>
                          	  檢舉管理
                          	<div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages4" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/report_comment/listAllReportComment.jsp">評論檢舉</a>
                            </nav>
                        </div>
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
            
            
            
            
<!--       ======這邊貼自己的檔案內容====== -->
            <div id="layoutSidenav_content">
            <%@ include file="page1.file" %> 
                  <table class="table table-hover" data-toggle="table">
<thead>
	<tr>
		<th data-field="member_no" data-sortable="true">會員編號</th>
		<th data-field="member_name" data-sortable="true">會員姓名</th>
		<th data-field="member_email" data-sortable="false">會員信箱</th>
		<th data-field="member_bd" data-sortable="true">會員生日</th>
		<th data-field="member_pic" data-sortable="false">會員照片</th>
		<th data-field="member_phone" data-sortable="false">會員電話</th>
		<th data-field="member_address" data-sortable="false">會員地址</th>
		<th data-field="member_status" data-sortable="true">會員狀態</th>
		<th data-field="member_level" data-sortable="true">會員身分</th>
		<th data-field="member_rgDate" data-sortable="true">會員註冊日</th>
		<th data-field="member_edit" data-sortable="false">資料更新</th>
	</tr>
</thead>	
<tbody>
	<c:forEach var="memVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr>
			<td>${memVO.member_no}</td>
			<td>${memVO.mb_name}</td>
			<td>${memVO.mb_email}</td>
			<td>${memVO.mb_bd}</td>
			<td><img src="${pageContext.request.contextPath}/mem/mem.do?action=view_memPic&member_no=${memVO.member_no}"></td>
			<td>${memVO.mb_phone}</td>
			<td>${memVO.mb_city}${memVO.mb_address}</td> 
			<td>
			<select class="status" disabled>
				<option value="0" ${(memVO.status=="0")? 'selected':''}>審核中</option>
				<option value="1" ${(memVO.status=="1")? 'selected':''}>通過審核</option>
				<option value="2" ${(memVO.status=="2")? 'selected':''}>已停權</option>
				<option value="3" ${(memVO.status=="3")? 'selected':''}>已停用</option>

			</select>
			</td>
			<td>
			<select class="level" disabled>
				<option value="1" ${(memVO.mb_level=="1")? 'selected':''}>一般會員</option>
				<option value="2" ${(memVO.mb_level=="2")? 'selected':''}>專職影評</option>
			</select>
			</td>
			<td>${memVO.crt_dt}</td>
			
			<td>
				 <input type="hidden" class="memNO" value="${memVO.member_no}">
			     <button type="button" class="btn-primary update">修改</button>
			     <button type="button" class="btn-info check" style="display:none;">確認</button>
			     <button type="button" class="btn-warning cancel" style="display:none;">取消</button>	     
			</td>
		</tr>
	</c:forEach>
</tbody>
</table>
<div class="alert-container">
    <%@ include file="pages/page2.file"%>
 </div>
</div>
</div>
<!-- 							======到這邊===== -->


        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/back-home/js/scripts.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/css/demo/datatables-demo.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/imask/3.4.0/imask.min.js"></script>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>


</body>
<script>
$(document).ready(function(){

	$(document).on('click', '.update', function(){
		$(this).css("display","none");
		$(this).next().css("display","");
		$(this).next().next().css("display","");
		$(this).parent().prevAll().eq(2).children().prop("disabled",false);
		$(this).parent().prevAll().eq(1).children().prop("disabled",false);
	})
	
	$(document).on('click', '.cancel', function(){
		$(this).css("display","none");
		$(this).prevAll().eq(0).css("display","none");
		$(this).prevAll().eq(1).css("display","");
		$(this).parent().prevAll().eq(2).children().prop("disabled",true);
		$(this).parent().prevAll().eq(1).children().prop("disabled",true);
	})

	$(document).on('click', '.check', function(){
		var mb_status = $(this).parent().prevAll().eq(2).children().val();
		var mb_level = $(this).parent().prevAll().eq(1).children().val();
		var member_no = $(this).prevAll().eq(1).val();
		var check = $(this);

		$.ajax({
             url: "<%=request.getContextPath()%>/MemServlet?",
//	             data: JSON.stringify({
//	            	 action: 'update_for_Ajax',
//	            	 status: mb_status,
//	            	 mb_level,
//	            	 member_no
//	             }),
			 data: { "action": 'update_for_Ajax',
				 	 "mb_status": mb_status,
				     "mb_level": mb_level,
				     "member_no": member_no,
              },
             type: "POST",
//	             contentType: 'application/json',
//	             processData: false,
             success: function (msg){
            	  if(msg=="success"){
            		 Swal.fire({
                         position: "center",
                         icon: "success",
                         title: "修改成功",
                         showConfirmButton: false,
                         timer: 1000,
                     });
            		 check.prev().css("display","");
            		 check.css("display","none");
            		 check.next().css("display","none");
            		 check.parent().prevAll().eq(2).children().prop("disabled",true);
            		 check.parent().prevAll().eq(1).children().prop("disabled",true);
            		 
            	 }else{
            		 Swal.fire({
                         position: "center",
                         icon: "error",
                         title: "修改失敗請洽管理員",
                         showConfirmButton: false,
                         timer: 1000,
                     });
            		 check.prev().css("display","");
            		 check.css("display","none");
            		 check.next().css("display","none");
            		 check.parent().prevAll().eq(2).children().prop("disabled",true);
            		 check.parent().prevAll().eq(1).children().prop("disabled",true);
            		 
            	 }
            	 
            	 
             }
		
		
		})
		
	})

})
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
	$(".goGroup").click(function(){
		goGroupName = $(this).find("input.goGroupName").val();
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
	
	
	function sendWebSocket(item){
		let timespan = new Date();
		let timeStr = timespan.getFullYear() + "-" + (timespan.getMonth()+1).toString().padStart(2, "0") + "-" 
					+ timespan.getDate() + " " + timespan.getHours().toString().padStart(2, "0") + ":" + timespan.getMinutes().toString().padStart(2, "0");
		if(item.val()=="addFriend"){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : friendNO,
				"message":"",
				"time":timeStr
			};
		}
		if(item.val()=="addGroup"){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : groupNO,
				"message":"",
				"time":timeStr
			};
		}
		if(item.val()=="buyTicket"){
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
		if(item.val()=="createGroup"){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : groupName,
				"message":"",
				"time":timeStr
			};
		}
		if(item.val()=="goGroup"){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : goGroupName,
				"message":"",
				"time":timeStr
			};
		}
		if(item.val()=="kickoffGroup"){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : kickGroupName,
				"message":"",
				"time":timeStr
			};
		}
		if(item.val()=="reminder"){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : memberNO,
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
		document.getElementById('sendMessage').disabled = true;
		document.getElementById('connect').disabled = false;
		document.getElementById('disconnect').disabled = true;
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
	  if (type==="addGroup"||type==="createGroup"||type==="dismissGroup"||type==="goGroup"||type==="kickoffGroup"||type==="kickUnpaid"){
			img.src="<%=request.getContextPath()%>/images/notify_icons/group.png"
	  }
	  if (type==="buyTicket"){
			img.src="<%=request.getContextPath()%>/images/notify_icons/ticket.png"
	  }
	  if (type==="reminder"){
			img.src="<%=request.getContextPath()%>/images/notify_icons/warning.png"
	  }
	  
		  img.classList.add("alertImg");
		  imgdiv.append(img);
		  txt.innerText = text;
		  txt.classList.add("alertTxt");
		  time_str.innerText = time;
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
