<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="relationSvc" scope="page" class="com.relationship.model.RelationshipService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<%@ page import="com.mem.model.*"%>
<%
	MemVO memVO = (MemVO)session.getAttribute("memVO");

%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css1/friendchat.css" type="text/css" />
<link href="<%=request.getContextPath()%>/css1/friendchat_frontpage.css" rel="friendchat_frontpage" />

<link href="https://i2.bahamut.com.tw/css/basic.css?v=1618977484" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<link href="<%=request.getContextPath()%>/css1/friendchat_frontpage.css" rel="friendchat_frontpage" />
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<style type="text/css">
	   body {  
     width: 900px;  
     margin: 0 auto;  
     padding: 10px 20px 20px 20px;  

 	        }  

</style>

<title>最大私人聊天室</title>
</head>


<body onload="connect();" onunload="disconnect();">

		<div class="shadow p-3 mb-1 bg-white rounded" style="font-size:40px">
			<span class="badge badge-secondary">
				MoviesHit好友聊天室
			</span>
				<button type="button" class="btn btn-success" onclick="location.href='<%=request.getContextPath()%>/front-end/relationship/select_page.jsp'">回前一頁</button>
			
			<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${memVO.member_no}"
			alt="尚無圖片" class="rounded-circle" width="60px" height="60px" title="" style="float: right;"/>
<%--      	【<font color=orange>${memVO.mb_name}</font>】 --%>		      		
		</div>	

	<h3 id="statusOutput" class="statusOutput">請選擇聊天對象</h3>
		<div class="container" id="row">
			
		</div>
	<div id="messagesArea" class="panel1 message-area" ></div>
	<div class="panel input-area">
		<input id="message" class="text-field" type="text" placeholder="Message" onkeydown="if (event.keyCode == 13) sendMessage();" /> 
		<input type="submit" id="sendMessage" class="btn btn-light" value="送出" onclick="sendMessage();" /> 
		<input type="button" id="connect" class="btn btn-light" value="上線" onclick="connect();" /> 
		<input type="button" id="disconnect" class="btn btn-light" value="下線" onclick="disconnect();" />
	</div>
	
<!-- </body> -->

<script>
	var MyPoint = "/FriendWS/${userName}";
	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;

	var statusOutput = document.getElementById("statusOutput");
	var messagesArea = document.getElementById("messagesArea");
	var self = '${userName}';
	var webSocket;

	function connect() {
		// create a websocket
		webSocket = new WebSocket(endPointURL);

		webSocket.onopen = function(event) {
			console.log("Connect Success!");
			document.getElementById('sendMessage').disabled = false;
			document.getElementById('connect').disabled = true;
			document.getElementById('disconnect').disabled = false;
		};

		webSocket.onmessage = function(event) {
			var jsonObj = JSON.parse(event.data);
			if ("open" === jsonObj.type) {
				refreshFriendList(jsonObj);
			} else if ("history" === jsonObj.type) {
				messagesArea.innerHTML = '';
				var ul = document.createElement('ul');
				ul.id = "area";
				messagesArea.appendChild(ul);
				// 這行的jsonObj.message是從redis撈出跟好友的歷史訊息，再parse成JSON格式處理
				var messages = JSON.parse(jsonObj.message);
				for (var i = 0; i < messages.length; i++) {
					var historyData = JSON.parse(messages[i]);
					var showMsg = historyData.message;
					var li = document.createElement('li');
					// 根據發送者是自己還是對方來給予不同的class名, 以達到訊息左右區分
					historyData.sender === self ? li.className += 'me' : li.className += 'friend';
					li.innerHTML = showMsg;
					ul.appendChild(li);
				}
				messagesArea.scrollTop = messagesArea.scrollHeight;
			} else if ("chat" === jsonObj.type) {
				var li = document.createElement('li');
				jsonObj.sender === self ? li.className += 'me' : li.className += 'friend';
				li.innerHTML = jsonObj.message;
				console.log(li);
				document.getElementById("area").appendChild(li);
				messagesArea.scrollTop = messagesArea.scrollHeight;
			} else if ("close" === jsonObj.type) {
				refreshFriendList(jsonObj);
			}
			
		};

		webSocket.onclose = function(event) {
			console.log("Disconnected!");
		};
	}
	
	function sendMessage() {
		var inputMessage = document.getElementById("message");
		var friend = statusOutput.textContent;
		var message = inputMessage.value.trim();

		if (message === "") {
			alert("Input a message");
			inputMessage.focus();
		} else if (friend === "") {
			alert("Choose a friend");
		} else {
			var jsonObj = {
				"type" : "chat",
				"sender" : self,
				"receiver" : friend,
				"message" : message
			};
			webSocket.send(JSON.stringify(jsonObj));
			inputMessage.value = "";
			inputMessage.focus();
		}
	}
	
	// 有好友上線或離線就更新列表
	function refreshFriendList(jsonObj) {
		var friends = jsonObj.users;
		var row = document.getElementById("row");
		row.innerHTML = '';
		let friendsName_back = [];
		let friendsId_back = [];
		<c:forEach var="relationshipVO" items="${relationSvc.getAllFriendno(memVO.member_no)}">				
// 			console.log("${memSvc.getOneMem(relationshipVO.friend_no).mb_name}");
			row.innerHTML +='<div class="row mem-block" id="${relationshipVO.friend_no}" class="column" name="friendName" ' 
			+ 'value="${memSvc.getOneMem(relationshipVO.friend_no).mb_name}" > ' 
			+ '<div style="margin: auto 0;"><img src="<%=request.getContextPath()%>/images/offline2.png" alt="" width="25px" height="25px" ></div>'
			//會員圖+這
			+ '<div><img class="rounded-circle" width="45px" height="40px" src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${relationshipVO.friend_no}"/></div>'
			+ '<h2 class="">${memSvc.getOneMem(relationshipVO.friend_no).mb_name}</h2>' 
			'</div>';
			friendsId_back.push("${relationshipVO.friend_no}");
			friendsName_back.push("${memSvc.getOneMem(relationshipVO.friend_no).mb_name}");
		</c:forEach> 
		
		for (var i = 0; i < friends.length; i++) {
			for (var j = 0 ; j < friendsName_back.length ; j++){
				if(friends[i] == friendsName_back[j]){
					console.log(friends[i] + " = = = " + friendsName_back[j]);
					console.log(friends[i] + " = = = " + friendsName_back[j]);
					$("#" + friendsId_back[j]).empty();
					var h2 = '<h2 >' +  friendsName_back[j] + '</h2>'
					var image = '<div style="margin: auto 0;"><img  src="<%=request.getContextPath()%>/images/online2.png" alt="" width="25px" height="25px"></div>';
					var memPic = '<div><img class="rounded-circle" width="45px" height="40px" src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no='+ friendsId_back[j] +'"/></div>';
					
					$("#" + friendsId_back[j]).append(image);
					$("#" + friendsId_back[j]).append(memPic);
					$("#" + friendsId_back[j]).append(h2);
					
				}
			}
		}
		addListener();
	}
	// 註冊列表點擊事件並抓取好友名字以取得歷史訊息
	function addListener() {
		var container = document.getElementById("row");
		container.addEventListener("click", function(e) {
			var friend = e.srcElement.textContent;
			updateFriendName(friend);
			var jsonObj = {
					"type" : "history",
					"sender" : self,
					"receiver" : friend,
					"message" : ""
				};
			webSocket.send(JSON.stringify(jsonObj));
		});
	}
	
	function disconnect() {
		webSocket.close();
		document.getElementById('sendMessage').disabled = true;
		document.getElementById('connect').disabled = false;
		document.getElementById('disconnect').disabled = true;
	}
	
	function updateFriendName(name) {
		statusOutput.innerHTML = name;
	}
</script>
</body>
</html>