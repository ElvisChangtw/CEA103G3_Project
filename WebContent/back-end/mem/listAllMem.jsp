<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
    MemService memSvc = new MemService();
    List<MemVO> list = memSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>�Ҧ��|����� - listAllMem.jsp</title>

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
  
  
  @import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');



.fadeOut {
  opacity: 0;
}

#create {
  border: none;
  padding: 8px;
  font-size:15px;
  color: #FFF;
  background-color: firebrick;
  border-radius: 8px;
}

.alert-container{
  position: fixed;
  right: 10px;
  bottom: 10px;
}

.alert {
  position: relative;
  background-color: white;
  border: 5px solid lightblue;
  height: 100px;
  width: 250px;
  border-radius: 15px;
  margin-bottom: 15px;
  color: #40bde6;
  padding: 20px 15px 0 15px;
  transition: opacity 2s;
}

.alert span {
  font-size: 1.3rem;
  position: absolute;
  top: 3px;
  right: 12px;
  cursor: pointer;

}
.alertTxt{
font-size: 1.1rem;
  position: absolute;
  top: 0px;
  right: 12px;
  cursor: pointer;
  margin-top:23px;
  width:170px;

}
.alertImg{
  width:70px;

}
</style>

</head>
<body bgcolor='white' onload="connect();" onunload="disconnection();">
<%@ include file="page1.file" %> 

<h4>�����m�߱ĥ� EL ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>�Ҧ����u��� - listAllMem.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/mem/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>�|���s��<button>XX</button></th>
		<th>�|���m�W</th>
		<th>�|���H�c</th>
		<th>�|���K�X</th>
		<th>�|���ͤ�</th>
		<th>�|���Ӥ�</th>
		<th>�|���q��</th>
		<th>�|���a�}</th>
		<th>�|�����A</th>
		<th>�|���n��</th>
		<th>�|������</th>
		<th>�|�����U��</th>
		
		
	</tr>
	
	<c:forEach var="memVO" items="${list}">
		
		<tr>
			<td>${memVO.member_no}</td>
			<td>${memVO.mb_name}</td>
			<td>${memVO.mb_email}</td>
			<td>${memVO.mb_pwd}</td>
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
			<td>${memVO.mb_point}</td>
			<td>${(memVO.mb_level=="1")? "�@��|��":"�M¾�v��"}</td>
			<td>${memVO.crt_dt}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�ק�">
			     <input type="hidden" name="member_no"  value="${memVO.member_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�R��">
			     <input type="hidden" name="member_no"  value="${memVO.member_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>

	</c:forEach>
	
	<button type="button" class="addFriend" value="addFriend">�[�n��</button>
    <input type="hidden" id="friendNO"  value="4">
	
	<button type="button" class="addGroup" value="addGroup">�[�J����</button>
	<input type="hidden" id="groupNO"  value="4">
	
	<button type="button" class="buyTicket" value="buyTicket">�T�{�ʲ�</button>
	<input type="hidden" id="movieNO"  value="4">
	
	<input type="text" id="groupName">
	<button type="button" class="createGroup" value="createGroup">�إߴ���</button>
	
	<button type="button" class="addfriend_check_btn" value=1>�T�w</button> &emsp;&emsp; <button type="button" class="addfriend_check_btn" value=0>�ڵ�</button>
	�ڬO${memVO.member_no}
	
	
</table>
 <div class="alert-container">
  </div>
<%@ include file="page2.file" %> 
</body>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>

<script>
	var MyPoint = "/NotifyWS/${memVO.member_no}";
	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
	var friendNO = document.getElementById("friendNO").value;
	var groupNO = document.getElementById("groupNO").value;
	var movieNO = document.getElementById("movieNO").value;
	var groupName;
	var self = '${memVO.member_no}';
	var webSocket;
	var type;


	$(".addFriend").click(function(){
		sendWebSocket($(this));
	})
	$(".addGroup").click(function(){
		sendWebSocket($(this));
	})
// 	$(this).find("input") �o�ˤ��椣���D��ԣ
	$(".buyTicket").click(function(){
		sendWebSocket($(this));
	})
	$(".addfriend_check_btn").click(function(){
		sendWebSocket($(this));
		//�o�����insertfriend��code
	})
	$(".createGroup").click(function(){
		groupName = document.getElementById("groupName").value;  //���i��b�W���ŧi�A�]��groupname�O�nclick��~�|�����A�ҥH�n��bclick�ƥ�
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

		webSocket.send(JSON.stringify(jsonObj));
	}
	

	function connect() {
		// create a websocket
		webSocket = new WebSocket(endPointURL);

		webSocket.onopen = function(event) {
			

		};

		webSocket.onmessage = function(event) {
			var jsonObj = JSON.parse(event.data);
			if ("addFriend" === jsonObj.type) {
				var text=jsonObj.message;
				var time=jsonObj.time;
				var type=jsonObj.type;
				console.log(jsonObj)
				createAlert(text,time,type);
			} 
			if ("addGroup" === jsonObj.type) {
				var text=jsonObj.message;
				var time=jsonObj.time;
				var type=jsonObj.type;
				createAlert(text,time,type);
			}
			if ("buyTicket" === jsonObj.type) {
				var text=jsonObj.message;
				var time=jsonObj.time;
				var type=jsonObj.type;
				createAlert(text,time,type);
			}
			if ("response" === jsonObj.type) {
				var text=jsonObj.message;
				var time=jsonObj.time;
				var type=jsonObj.type;
				createAlert(text,time,type);
			}
			if ("createGroup" === jsonObj.type) {
				var text=jsonObj.message;
				var time=jsonObj.time;
				var type=jsonObj.type;
				createAlert(text,time,type);
			}
			if ("close" === jsonObj.type) {
				
			}
			
		};

		webSocket.onclose = function(event) {
			console.log("Disconnected!");
		};
	}
	
	
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
	  if (type==="addGroup"||type==="createGroup"){
			img.src="<%=request.getContextPath()%>/images/notify_icons/group.png"
	  }
	  if (type==="buyTicket"){
			img.src="<%=request.getContextPath()%>/images/notify_icons/ticket.png"
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