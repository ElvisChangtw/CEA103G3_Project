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
    	<title>��x�s���Ҧ��|��</title>
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

</style>
    
   </head>
    <body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/back-home/index2.jsp">MOVIESHIT��x�t��</a>
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
               	 �n�X
            </a>
        </ul>
    </nav>
    
    
    
    
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <img src="<%=request.getContextPath()%>/back-home/img/logo2-1-5.png">
<!--                         <a class="nav-link collapsed" href="tables3.html"> -->
<!--                             <div class="sb-nav-link-icon"><i class="fas fa-user-alt"></i></div> -->
<!--                            	 �򥻸�� -->
<!--                         </a> -->
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLayouts1" aria-expanded="false" aria-controls="collapseLayouts1">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-cog"></i></div>
                           	 ���u�޲z�t��
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseLayouts1" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/employee/listAllEmployee2.jsp">���u�޲z</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                            <div class="sb-nav-link-icon"><i class="fas fa-video"></i></div>
                         	   �v���򥻸�ƨt��
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/movie/backEndlistAllMovie.jsp">�q�v��ƺ޲z</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/showtime/listAllShowtime.jsp">�����޲z</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/theater/listAllTheater.jsp"> �U�|�޲z</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/ticket_type/listAllTicket_type.jsp">���غ޲z</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/food/listAllFood.jsp">�\�I�޲z</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages2" aria-expanded="false" aria-controls="collapsePages2">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-clock"></i></div>
                            	�|���޲z�t��
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages2" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/mem/listAllMem2.jsp">�|����ƺ޲z</a>
<!--                                 <a class="nav-link" href="layout-sidenav-light.html">�|���f��</a> -->
<!--                                 <a class="nav-link" href="layout-sidenav-light.html"> �M�~���׼f��</a> -->
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages3" aria-expanded="false" aria-controls="collapsePages3">
                            <div class="sb-nav-link-icon"><i class="fas fa-ticket-alt"></i></div>
                        	    �Ⲽ�޲z
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages3" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="layout-static.html">�{������</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/order/listAllOrder.jsp">�q��޲z</a>
                            </nav>
                        </div>
           				 <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages4" aria-expanded="false" aria-controls="collapsePages4">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-alt-slash"></i></div>
                          	  ���|�޲z
                          	<div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages4" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/report_comment/listAllReportComment.jsp">�������|</a>
                            </nav>
                        </div>
                        <a class="nav-link" href="tables1.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-bullhorn"></i></div>
                           	 �޲z�̷s����
                        </a>
                        <a class="nav-link" href="tables2.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-hands-helping"></i></div>
                       	     	�^���ȪA�p����
                        </a>
                    </div>
                </div>
            </nav>
        </div>
            
            
            
            
<!--       ======�o��K�ۤv���ɮפ��e====== -->
            <div id="layoutSidenav_content">
            <%@ include file="page1.file" %> 
                  <table class="table table-secondary table-hover" data-toggle="table"  style="white-space:nowrap">
					<thead>
						<tr>
							<th data-field="member_no" data-sortable="true">�|���s��</th>
							<th data-field="member_name" data-sortable="true">�|���m�W</th>
							<th data-field="member_email" data-sortable="false">�|���H�c</th>
							<th data-field="member_bd" data-sortable="true">�|���ͤ�</th>
							<th data-field="member_pic" data-sortable="false">�|���Ӥ�</th>
							<th data-field="member_phone" data-sortable="false">�|���q��</th>
							<th data-field="member_address" data-sortable="false">�|���a�}</th>
							<th data-field="member_status" data-sortable="true">�|�����A</th>
							<th data-field="member_level" data-sortable="true">�|������</th>
							<th data-field="member_rgDate" data-sortable="true">�|�����U��</th>
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
<%-- 			<td>${memVO.status}</td> --%>
			<c:choose>
				<c:when test="${memVO.status=='0'}">
				<td>�f�֤�</td>
				</c:when>
				<c:when test="${memVO.status=='1'}">
				<td>�w�q�L�f��</td>
				</c:when>
				<c:when test="${memVO.status=='2'}">
				<td>�w���v</td>
				</c:when>
				<c:when test="${memVO.status=='3'}">
				<td>�w����</td>
				</c:when>
				<c:otherwise>
				<td>�L�Ī��A</td>
				</c:otherwise>
			</c:choose>
			<td>${(memVO.mb_level=="1")? "�@��|��":"�M¾�v��"}</td>
			<td>${memVO.crt_dt}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" style="margin-bottom: 0px;">
			     <button type="submit" class="btn-primary">�ק�</button>
			     <input type="hidden" name="member_no"  value="${memVO.member_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
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
<!-- 							======��o��===== -->


        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/back-home/js/scripts.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/css/demo/datatables-demo.js"></script>

<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="https://unpkg.com/bootstrap-table@1.18.3/dist/bootstrap-table.min.js"></script>
<%-- <script src="<%=request.getContextPath()%>/js/bootstrap-table.js"></script> --%>


</body>
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
		//�o�����insertfriend��code
	})
	$(".createGroup").click(function(){
		groupName = document.getElementById("groupName").value;  //���i��b�W���ŧi�A�]��groupname�O�ϥΪ̦ۤv���nclick��~�|�����A�ҥH�n��bclick�ƥ�
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
	
	
// 	���ͳq��block�b�����k�U��
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
