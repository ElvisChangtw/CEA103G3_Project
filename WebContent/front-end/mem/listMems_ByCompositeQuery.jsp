<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.reply.model.*"%>
<%@ page import="com.article.model.*"%>
<%@ page import="com.mem.model.*"%>

<% 
// 	MemVO memVO = (MemVO) session.getAttribute("memVO");
//  	pageContext.setAttribute("memVO", memVO);
// 	MemVO memVO1 = (MemVO) request.getAttribute("memVO");
	
%>
<%-- 萬用複合查詢-可由客戶端select_page.jsp隨意增減任何想查詢的欄位 --%>
<%-- 此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能--%>

<%-- <jsp:useBean id="listMems_ByCompositeQuery" scope="request" type="java.util.List<MemVO>" /> <!-- 於EL此行可省略 --> --%>
<jsp:useBean id="articleSvc" scope="page" class="com.article.model.ArticleService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="articleDAO" scope="page" class="com.article.model.ArticleDAO" />
<jsp:useBean id="relationshipSvc" scope="page" class="com.relationship.model.RelationshipService" />

<html>
<head><title>複合查詢 - listMems_ByCompositeQuery.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/front/notification.css" />
<!-- <link href="https://i2.bahamut.com.tw/css/basic.css?v=1618977484" rel="stylesheet"> -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous"> -->
<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script> -->

<style>
   body {  
/*      width: 565px;   */
     margin: 0 auto;  
     padding: 10px 20px 20px 20px;  

 	        }  
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
  table {
	width: 100%;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
	
  }
  table, th, td {
/*     border: 1px solid #CCCCFF; */
		font-size:25px;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
  
</style>

</head>
<body bgcolor='white' onload="connect();" onunload="disconnection();">
		<jsp:include page="/front_header.jsp"/>
		<div class="container"  style="min-height: 465px;" >
<div class="row"  style="margin:5px 0;">
	<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${memVO.member_no}"
				alt="尚無圖片" class="rounded-circle" width="60px" height="60px" title=""/>
<%--      		【<font color=orange>${memVO.mb_name}</font>】 --%>
	<h1 class="shadow p-3 mb-1 bg-white rounded" style="background-color:#02a388; display:inline-block;color: white;">
			${memVO.mb_name} 的好友專區
	</h1>

</div>
<div class="row">

		<div class="col col-md-8">
	 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" name="form1">   
       <b><font color=blue>搜尋會員加好友:</font></b> 
       		<input type="text" name="mb_name" value="" placeholder="請輸入會員名稱">		        
        <input type="submit" value="送出" class="btn btn-primary">
        <input type="hidden" name="action" value="listMems_ByCompositeQuery">
     	<br>
     </FORM>
    </div>
	<div class="col col-md-4 btn-group" style="font-size:40px">
	  <button type="button" class="btn btn-success" style="border-radius: 5px 0 0 5px;right:128px;">好友管理</button>
	  <button type="button" class="btn btn-success dropdown-toggle" style="border-radius: 0 5px 5px 0;right:128px;" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	    <span class="caret"></span>&nbsp</button>
	  	<ul class="dropdown-menu">
		    <li><a class="dropdown-item" href="<%=request.getContextPath()%>/mem/mem.do?action=listRelationships_ByMemberno_B&member_no=${memVO.member_no}">我的好友</a></li>
			<li><a class="dropdown-item" href="<%=request.getContextPath()%>/front-end/relationship/friend_invite.jsp">好友邀請</a></li>
			<li><a class="dropdown-item" href="<%=request.getContextPath()%>/chat.do?action=ueser&userName=${memVO.mb_name}">開啟聊天室</a></li>
		</ul>
	</div>

	
<!--     <li> -->

<%--      <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" > --%>
<!--        <b><font color=orange>選擇會員姓名查該會員的好友(0403):</font></b> -->
<!--        <select size="1" name="member_no"> -->
<%--          <c:forEach var="memVO" items="${memSvc.all}" >  --%>
<%--           	<option value="${memVO.member_no}">${memVO.mb_name} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
<!-- 	       <input type="submit" value="送出"> -->
<!-- 	       <input type="hidden" name="action" value="listRelationships_ByMemberno_A"> -->
<!--      </FORM> -->
<!--   </li> -->

   </div>
	
     <table class="table table-hover" style="background: #c3c2c2";>
	 <thead style="background-color:black">		
	 	<tr>
			<th style="text-align: center">會員名稱</th>
			<th style="text-align: center">加好友喔 </th>
	<!-- 		<th>修改</th> -->
	<!-- 		<th>刪除</th> -->
		</tr>
	</thead>
	<c:forEach var="mem1VO" items="${listMems_ByCompositeQuery}">
		<c:if test="${mem1VO.member_no != sessionScope.memVO.member_no}">		
				<tbody>	
					<tr>
						<td>
							<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${mem1VO.member_no}"
								alt="尚無圖片" width="96px;" height="108px" title="" style="border: groove;"/>
							<font color=orange>${mem1VO.mb_name}</font>
						</td>						
						
						<td style="vertical-align:middle;">
							<c:choose>
								<c:when test="${relationshipSvc.getOneRelationship(mem1VO.member_no, memVO.member_no) == null && relationshipSvc.getOneRelationship(memVO.member_no, mem1VO.member_no) == null}">
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relationship/relationship.do" name="form1">
										<input type="hidden" name="member_no" value="${memVO.member_no}">
										<input type="hidden" name="friend_no" value="${mem1VO.member_no}">												
										<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
										<input type="hidden" name="mb_name" value="${param.mb_name}">
										<input type="hidden" name="action" value="insert">			
										<button type="submit" value="addFriend" class="btn btn-info addFriend">送出好友邀請</button>
									</FORM>
								</c:when>
								<c:when test="${relationshipSvc.getOneRelationship(mem1VO.member_no, memVO.member_no) == null && relationshipSvc.getOneRelationship(memVO.member_no, mem1VO.member_no) != null}">
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relationship/relationship.do" style="margin-bottom: 0px;">
									    <input type="submit" value="收回好友邀請" class="btn btn-danger">
									    <input type="hidden" name="member_no"   value="${memVO.member_no}">
									    <input type="hidden" name="friend_no"   value="${mem1VO.member_no}">			    
									    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
									    <input type="hidden" name="mb_name" value="${param.mb_name}">
									    <input type="hidden" name="action"     value="delete">
									</FORM>
								</c:when>
								<c:when test="${relationshipSvc.getOneRelationship(mem1VO.member_no, memVO.member_no).status == 1}">
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relationship/relationship.do" name="form2">
										<input type="hidden" name="member_no" value="${memVO.member_no}">
										<input type="hidden" name="friend_no" value="${mem1VO.member_no}">
										<input type="hidden" name="action" value="accept">			
										<input type="submit" value="已為好友" class="btn btn-default" disabled>
									</FORM>
								</c:when>
								<c:when test="${relationshipSvc.getOneRelationship(mem1VO.member_no, memVO.member_no).status == 0}">
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relationship/relationship.do" name="form3">
										<input type="hidden" name="member_no" value="${memVO.member_no}">
										<input type="hidden" name="friend_no" value="${mem1VO.member_no}">
										<input type="hidden" name="action" value="accept">			
										<input type="submit" value="接受好友邀請" class="btn btn-success">
									</FORM>
								</c:when>
								<c:otherwise>
									<button class="btn btn-danger">全部條件都沒進啊!</button>
								</c:otherwise>
							</c:choose>
						</td>

	<!-- 			<td> -->
	<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reply/reply.do" style="margin-bottom: 0px;"> --%>
	<!-- 			     <input type="submit" value="刪除"> -->
	<%-- 			     <input type="hidden" name="reply_no"      value="${replyVO.reply_no}"> --%>
	<%-- 			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--> --%>
	<%-- 			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller--> --%>
	<!-- 			     <input type="hidden" name="action"     value="delete"></FORM> -->
	<!-- 			</td> -->
					</tr>
				</tbody>
			</c:if>
		</c:forEach>
</table>
 <div class="alert-container">
  </div>
<%-- <%@ include file="pages/page2_ByCompositeQuery.file" %> --%>
</div>
<!-- <br>本網頁的路徑:<br><b> -->
<%--    <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br> --%>
<%--    <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b> --%>
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
		friendNO = $(this).prev().prev().prev().prev().val();
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
     <div class="w3agile_footer_copy">
        <p>2021 MoviesHit. All rights reserved</p>
    </div>
    <a href="#home" id="toTop" class="scroll" style="display: block;"> <span id="toTopHover" style="opacity: 1;"> </span></a>

</body>

</html>