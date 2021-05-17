<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.group.model.*"%>
<%@ page import="java.util.*"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.mappingtool.*"%>
<%@ page import="com.mappingtool.StatusMapping"%>


<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	GroupVO groupVO = (GroupVO) request.getAttribute("groupVO");
%>
<jsp:useBean id="memVO" scope="session" type="com.mem.model.MemVO" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="groupSvc" scope="page"	class="com.group.model.GroupService" />
<jsp:useBean id="movieSvc" scope="page"	class="com.movie.model.MovieService" />
<jsp:useBean id="showtimeSvc" scope="page"	class="com.showtime.model.ShowtimeService" />
<jsp:useBean id="mapping" scope="page" class="com.mappingtool.StatusMapping" />

<html>
<head>
<title>揪團資料 - listOneGroup.jsp</title>
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

<style>

body {
	background-image: linear-gradient(#ddd6f3,#faaca8);
}

table#table-2 {
	background-color: #5bc0de;
	border: 2px solid black;
	text-align: center;
	margin: 0px auto;
}

table#table-2 h4 {
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
	background-color: white;
	width: 100%
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>

</head>
<body>
	<div id="display" class="container">
<!-- 			<div class="row"> -->
<!-- 			<table id="table-2"> -->
<!-- 				<tr> -->
<!-- 					<td> -->
<!-- 						<h1> -->
<!-- 							<strong><em>揪團資料</em></strong> -->
<%-- 						</h1> 		 <h4><a href="<%=request.getContextPath()%>/front-end/group/select_page.jsp"  --%>
<!-- 											class="btn btn-primary btn-lg active" role="button">回上頁</a></h4> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 			</table> -->
<!-- 		</div> -->
		
		<div class="row">
			<div class="jumbotron">
			  <h1 class="display-4">${groupVO.group_title}(${groupVO.group_no})</h1>
			  <hr class="my-4">
			  <div class="row">
				  <div class="col-md-2 lead div-th">
				   電影(場次編號):
				  </div>
			      <div class="col-md-2 lead">
			      ${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(groupVO.showtime_no).movie_no).moviename}
			  		(${groupVO.showtime_no})
			      </div>
			  </div>
			  <div class="row">
				  <div class="col-md-2 lead div-th">
				   目前狀態:
				  </div>
			      <div class="col-md-10 lead" id="group_status">
			      ${mapping.dboGroup_GroupStatus(groupVO.group_status)}
			      </div>
			  </div>
			  <div class="row">
			    <div class="col-md-2 lead div-th">
			    	人數 / 最大人數:
			    </div>
			    <div class="col-md-2 lead" id="groupCnt">
			    ${groupVO.member_cnt} / ${groupVO.required_cnt}
			    </div>
			  </div>
			  <c:choose>
			  	
			  	<c:when test="${groupVO.group_status == 0}">
			  		<div class="row">
					  	<div class="col-md-2 lead div-th">
					  	成員:
			  			</div>
					  	<div class="col-md-10 lead" id="member"> 
						  	<c:forEach var="group_memberVO" items="${groupSvc.getMembersByGroupno(groupVO.getGroup_no())}">
								<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${group_memberVO.member_no}"  id="${groupVO.group_no}-${group_memberVO.member_no}"
								alt="尚無圖片" width="90px;" height="90px" title=" ${memSvc.getOneMem(group_memberVO.member_no).mb_name}" style="border: groove;"/>
							</c:forEach>
					  	</div>
				  	 </div>
		  		</c:when>
		  		<c:otherwise>
		  			<div class="row">
			  			<div class="col-md-2 lead div-th">
					  	已付款成員:
			  			</div>
			  			<div class="col-md-10 lead" id="member"> 
						  	<c:forEach var="group_memberVO" items="${groupSvc.getMembersByGroupno(groupVO.getGroup_no())}">
						  		<c:if test="${group_memberVO.pay_status==1 }">
									<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${group_memberVO.member_no}"  id="${groupVO.group_no}-${group_memberVO.member_no}"
									alt="尚無圖片" width="90px;" height="90px" title=" ${memSvc.getOneMem(group_memberVO.member_no).mb_name}" style="border: groove;"/>
								</c:if>
							</c:forEach>
				  		</div>
		  			</div>
		  			<div class="row">
			  			<div class="col-md-2 lead div-th">
					  	未付款成員:
			  			</div>
			  			<div class="col-md-10 lead" id="member"> 
						  	<c:forEach var="group_memberVO" items="${groupSvc.getMembersByGroupno(groupVO.getGroup_no())}">
						  		<c:if test="${group_memberVO.pay_status==0 }">
									<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${group_memberVO.member_no}"  id="${groupVO.group_no}-${group_memberVO.member_no}"
									alt="尚無圖片" width="90px;" height="90px" title=" ${memSvc.getOneMem(group_memberVO.member_no).mb_name}" style="border: groove;"/>
								</c:if>
							</c:forEach>
				  		</div>
		  			</div>
		  		</c:otherwise>
			</c:choose>
			 <div class="row">
			    <div class="col-md-2 lead div-th">
			    內容:
			    </div>
			    <div class="col-md-10 lead">
			    ${groupVO.desc}
			    </div>
			  </div>

				 <div class="row">
			    <div class="col-md-2 lead div-th">
			    截止時間:
			    </div>
			    <div class="col-md-10 lead" id="dd-cntDown">
			    </div>
			  </div>
			<hr class="my-4">
			
			   <div class="row">
			    <div class="col-md lead">
					<a id="backBtn" href="<%=request.getContextPath()%>/front-end/group/group_front_page.jsp" 
					style="margin-bottom: 0px;" class="btn btn-lg">回首頁</a>
					<button id="joinBtn" class="btn btn-lg btn-primary" ${(groupVO.member_cnt < groupVO.required_cnt) ?  '' : 'disabled'}>
						${(groupVO.member_cnt < groupVO.required_cnt) ?  '現在加入' : '人數已滿'}
						</button> 
					<button id="leaveBtn" class="btn btn-lg btn-danger" style="display:none">退出揪團</button> 
					<a id="modifyBtn" href="<%=request.getContextPath()%>/group/group.do?group_no=${groupVO.group_no}&action=getOne_For_Update" 
					style="margin-bottom: 0px;" class="btn btn-lg btn-success">修改揪團</a>
					<a id="reportBtn" href="<%=request.getContextPath()%>/front-end/report_group/addReport_Group.jsp?group_no=${groupVO.group_no}" 
					style="margin-bottom: 0px;" class="btn btn-lg btn-warning">檢舉揪團</a>
					<a id="dismissBtn" href="<%=request.getContextPath()%>/group/group.do?group_no=${groupVO.group_no}&action=delete" 
					style="margin-bottom: 0px;" class="btn btn-lg btn-danger">解散揪團</a>
<%-- 					<a id="TimerdismissBtn" href="<%=request.getContextPath()%>/group/group.do?group_no=${groupVO.group_no}&action=SetDeleteTimerTask"  --%>
<!-- 					style="margin-bottom: 0px;" class="btn btn-lg btn-danger">測試排程刪除</a> -->
					<a id="gogoBtn" style="margin-bottom: 0px;" class="btn btn-lg btn-primary">出團(團長)</a>
			    </div>
			  </div>

<!-- 			  <hr class="my-4"> -->
			  
<!-- 			  <p>It uses utility classes for typography and spacing to space content out within the larger container.</p> -->
<!-- 			  <p class="lead"> -->
<!-- 			    <a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a> -->
<!-- 			  </p> -->
			</div>
		</div>

		</div>
	</div>
	
	<script>
	
	//起始動作
	//1. 印出揪團截止時間(每秒更新)
	//2. 發出ajax 請求確認會員是否已在揪團內, 依此更改加入/退出按鈕顯示
	let memberCnt = ${groupVO.member_cnt};
	let group_status = ${groupVO.group_status};
	
	let timer = null;
	$(function() {
		//確認會員是否為團長, 決定顯示條件
		if(${memVO.member_no == groupVO.member_no}){
			console.log("團長!");
			$("#joinBtn").hide();
			$("#leaveBtn").hide();
			$("#reportBtn").show();
			if ( group_status === 0){
				$("#gogoBtn")	.show();
				$("#dismissBtn").show();
				$("#modifyBtn").show();
			} else{
				$("#gogoBtn").hide();
				$("#modifyBtn").hide();
				$("#dismissBtn").hide();
			}
		}
		else{
			console.log("不是團長");
			$("#modifyBtn").hide();
			$("#reportBtn").show();
			$("#dismissBtn").hide();
			$("#gogoBtn").hide();
		}
		
		
		//揪團截止倒數計時
		$("#dd-cntDown").html(
    			'<fmt:formatDate value="${groupVO.deadline_dt}" pattern="yyyy-MM-dd HH:mm" />'
    			+ ' <font color="red"> (remaining: '+ timeFormat(timeLeft())+ ') </font>' );
		timer = setInterval(function() {
            let left = timeLeft(); 
            if (left >= 1000) {
//             	$("#dd-cntDown").html(
//             			'<fmt:formatDate value="${groupVO.deadline_dt}" pattern="yyyy-MM-dd HH:mm" />'
//             			+ '<br><p class="counter">(' + timeFormat(left)  + ')</p>');
            	$("#dd-cntDown").html(
            			'<fmt:formatDate value="${groupVO.deadline_dt}" pattern="yyyy-MM-dd HH:mm" />'
            			+ ' <font color="red"> (remaining: '+ timeFormat(timeLeft())+ ') </font>' );
            	
            	if(left <= 1000 * 60 *5 ){
            		$("#dd-cntDown").toggleClass("counter", false);
            		$("#dd-cntDown").toggleClass("urgentCounter", true);
            	}
            }
            else {
                console.log('揪團已截止！');
                clearInterval(timer); 
            }
        }, 1000);
		//揪團截止倒數計時
		
		//判斷瀏覽此頁面之會員是否已加入揪團
		$.ajax({
			url: "<%=request.getContextPath()%>/group_member/group_member.do",
			type:"POST",
			data: {
				group_no:"${groupVO.group_no}",
				member_no:"${memVO.member_no}",
				action:"checkMemIfExist"
			},
			success: function(msg){
				if(!${memVO.member_no == groupVO.member_no}){
					if(msg==="success"){
						$("#leaveBtn").show();
						$("#joinBtn").hide();
					}else{
						$("#joinBtn").show();
						$("#leaveBtn").hide();
					}
					if (group_status === 1){
						$("#joinBtn").hide();
						$("#leaveBtn").hide();
					}
				}
			}
		});
		var host = $("#${groupVO.group_no}-${groupVO.member_no}");
		
		$("#${groupVO.group_no}-${groupVO.member_no}").parent().prepend(host);
		host.height("120px");
		host.width("120px");

	});
	//起始動作結束
		
		$("#joinBtn").click(function(){
			$.ajax({
				url: "<%=request.getContextPath()%>/group_member/group_member.do",
				type:"POST",
				data: {
					group_no:"${groupVO.group_no}",
					member_no:"${memVO.member_no}",
					pay_status:"0",
					status:"1",
					action:"insert",
					requestURL:"<%=request.getServletPath()%>"
					
				},
				success: function(data){
					$("#joinBtn").hide();
					$("#member").append(

						 '<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${memVO.member_no}" id="${groupVO.group_no}-${memVO.member_no}" '
						+ 'alt="尚無圖片" width="90px;" height="90px" title=" ${memVO.mb_name}"'
						+ 'style="border: groove;"/>'
						);
					 Swal.fire({
	                        position: "center",
	                        icon: "success",
	                        title: "已成功加入揪團",
	                        showConfirmButton: false,
	                        timer: 1500,
	                    });
					 $("#leaveBtn").show();
				}
			}).done(function(){
				//結束後才做的, 拉最新的時間
				$.ajax({
					url: "<%=request.getContextPath()%>/group_member/group_member.do",
					type:"POST",
					data: {
						group_no:"${groupVO.group_no}",
						action:"getGroupCount_Ajax",
						requestURL:"<%=request.getServletPath()%>"
					},
					success: function(data){
						 $("#groupCnt").text('' +data + " / ${groupVO.required_cnt}");
					}
				});
			});
		});
		
		$("#leaveBtn").click(function(){
			$.ajax({
				url: "<%=request.getContextPath()%>/group_member/group_member.do",
				type:"POST",
				data: {
					group_no:"${groupVO.group_no}",
					member_no:"${memVO.member_no}",
					action:"delete",
					requestURL:"<%=request.getServletPath()%>"
				},
				success: function(data){
					Swal.fire({
                        position: "center",
                        icon: "success",
                        title: "已成功退出揪團",
                        showConfirmButton: false,
                        timer: 1500,
                    });
					$("#leaveBtn").hide();
					$("#${groupVO.group_no}-${memVO.member_no}").remove();
					 $('#joinBtn').removeAttr('disabled','disabled');
					 $("#joinBtn").show();
				}
			}).done(function(){
				$.ajax({
					url: "<%=request.getContextPath()%>/group_member/group_member.do",
					type:"POST",
					data: {
						group_no:"${groupVO.group_no}",
						action:"getGroupCount_Ajax",
						requestURL:"<%=request.getServletPath()%>"
					},
					success: function(data){
						 $("#groupCnt").text('' +data + " / ${groupVO.required_cnt}");
						 let joinBtnTxt = (data < ${groupVO.required_cnt}) ? '現在加入' : '人數已滿';
						 $("#joinBtn").text(joinBtnTxt);
					}
				});
			});
		});
		
		$("#gogoBtn").click(function(){

			Swal.fire({
				  title: '你確定嗎?',
				  text: "出團後無法反悔",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: '確定出團!'
				}).then((result) => {
				  if (result.isConfirmed) {
					  Swal.fire({
		                   position: "center",
		                   icon: "success",
		                   title: "將導向付款頁面",
		                   showConfirmButton: false,
		                   timer: 1500,
		               });
					  setTimeout(function() {
							 $(location).attr('href', '<%=request.getContextPath()%>/group/group.do?action=gogogo&group_no=${groupVO.group_no}&requestURL=<%=request.getServletPath()%>');
						    }, 1500);
				  }
				})
		});


		
		
		//倒數計時
        function timeLeft() {
            // 取得現在時間
            let now = new Date();
            // 個別取得毫秒數 距離1970/1/1的毫秒數
            let nowTime = now.getTime();
            let deadTime = Date.parse("${groupVO.deadline_dt}");
            // 回傳相差的毫秒數
            return deadTime - nowTime;
        }
		
		function timeLeft1(time) {
            // 取得現在時間
            let now = new Date();
            // 個別取得毫秒數 距離1970/1/1的毫秒數
            let nowTime = now.getTime();
            let deadTime = Date.parse(time);
            // 回傳相差的毫秒數
            return deadTime - nowTime;
        }
        // 3. 寫一個函式，回傳格式化剩餘的時間，格式：'距離結標日，還剩下 23天5小時23分3秒。'
        function timeFormat(leftTimes) { // 傳入毫秒數
        	const DAY = 24 * 60 * 60;
            const HOUR = 60 * 60;
            const MINUTE = 60;
            var secondLeft = Math.floor(leftTimes / 1000);
            var dayLeft = Math.floor(secondLeft / DAY);
            var secondLeft = secondLeft % DAY;
            var hourLeft = Math.floor(secondLeft / HOUR);
            var secondLeft = secondLeft % HOUR;
            var minuteLeft = Math.floor(secondLeft / MINUTE);
            var secondLeft = secondLeft % MINUTE;
            return   + dayLeft + 'day' + hourLeft + 'hr' + minuteLeft + 'min' + secondLeft + 'sec';
        }

 	</script> 
</body>
</html>