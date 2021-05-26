<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    MemService memSvc = new MemService();
    List<MemVO> list = memSvc.getAll();
    pageContext.setAttribute("list",list);
	MemVO memVO = (MemVO)session.getAttribute("memVO");
%>


<html>
<head>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/front/notification.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.css">
	
<title>所有會員資料 - listAllMem.jsp</title>

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

</style>

</head>
<body bgcolor='white'>
<%@ include file="page1.file" %> 


<table class="table table-secondary table-hover" data-toggle="table">
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
		<th data-field="member_edit" data-sortable="false"></th>
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
<%@ include file="page2.file" %> 
 <div class="alert-container">
 </div>
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

	$(".update").click(function(){
		$(this).css("display","none");
		$(this).next().css("display","");
		$(this).next().next().css("display","");
		$(this).parent().prevAll().eq(2).children().prop("disabled",false);
		$(this).parent().prevAll().eq(1).children().prop("disabled",false);

	})
	
	$(".cancel").click(function(){
		$(this).css("display","none");
		$(this).prevAll().eq(0).css("display","none");
		$(this).prevAll().eq(1).css("display","");
		$(this).parent().prevAll().eq(2).children().prop("disabled",true);
		$(this).parent().prevAll().eq(1).children().prop("disabled",true);

	})
	
	
	
	$(".check").click(function(){
			var mb_status = $(this).parent().prevAll().eq(2).children().val();
			var mb_level = $(this).parent().prevAll().eq(1).children().val();
			var member_no = $(this).prevAll().eq(1).val();
			var check = $(this);

			$.ajax({
	             url: "<%=request.getContextPath()%>/MemServlet?",
// 	             data: JSON.stringify({
// 	            	 action: 'update_for_Ajax',
// 	            	 status: mb_status,
// 	            	 mb_level,
// 	            	 member_no
// 	             }),
				 data: { "action": 'update_for_Ajax',
					 	 "mb_status": mb_status,
					     "mb_level": mb_level,
					     "member_no": member_no,
                  },
	             type: "POST",
// 	             contentType: 'application/json',
// 	             processData: false,
	             success: function (msg){
	            	  if(msg=="success"){
	            		 Swal.fire({
	                         position: "center",
	                         icon: "success",
	                         title: "修改成功",
	                         showConfirmButton: false,
	                         timer: 10000000,
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