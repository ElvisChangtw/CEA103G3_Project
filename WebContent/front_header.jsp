<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.movie.model.*"%>
<%@ page import="com.comment.model.*"%>
<%@ page import="com.expectation.model.*"%>
<%@ page import="com.mem.model.*"%>
<%
	MemVO memVO = (MemVO) session.getAttribute("memVO");
	if(memVO == null){
	//		memVO = (new MemService()).getOneMem(99);
		memVO = new MemVO();
		memVO.setMember_no(99);
	}
	pageContext.setAttribute("memVO", memVO);
%>


<!DOCTYPE html>
<html>

<head>
    <title>MoviesHit</title>
    <!-- for-mobile-apps -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=big5" />
    <meta name="keywords" content="Movies Pro Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
    <script type="application/x-javascript">
        addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);

        function hideURLbar() { window.scrollTo(0, 1); }
    </script>
    <link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <!-- pop-up -->
    <link href="<%=request.getContextPath()%>/css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
    <!-- //pop-up -->
    <link href="<%=request.getContextPath()%>/css/easy-responsive-tabs.css" rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/zoomslider.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styleForMH.css" />
    <link href="<%=request.getContextPath()%>/css/font-awesome.css" rel="stylesheet">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/modernizr-2.6.2.min.js"></script>
    <!--/web-fonts-->
    <link href='//fonts.googleapis.com/css?family=Tangerine:400,700' rel='stylesheet' type='text/css'>
    <link href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900" rel="stylesheet">
    <link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    <!--//web-fonts-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styleForGroup.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <style>
        div.form-group>button.btn {
border-radius: 3px;
}
.chart .chart2{
width:50px;
height:50px;
}
</style>

<style>
    .icons{
  display: inline;
  float: right
}
.notification{
/*   bottom: 25px; */
bottom: 58px; 
/*   left: 340px; */
left: 1095px; 
  position: relative;
  display: inline-block;
}

.number{
  font-size:3px;
  height: 22px;
  width:  22px;
  background-color: #21d207;
  border-radius: 20px;
  color: white;
  text-align: center;
  position: absolute;
  top: -7px;
  left: 65px;
  padding: 3px;
  border-style: solid;
  border-width: 2px;
}

.number:empty {
   display: none;
}

.notBtn{
  transition: 0.5s;
  cursor: pointer
}

.fas{
  font-size: 25pt;
  padding-bottom: 10px;
  color: white;
  margin-right: 40px;
  margin-left: 40px;
}

.box{
  width: 400px;
  height: 0px;
  border-radius: 10px;
  transition: 0.5s;
  position: absolute;
  overflow-y: scroll;
  padding: 0px;
  left: -300px;
  margin-top: 5px;
  background-color: #F4F4F4;
  -webkit-box-shadow: 10px 10px 23px 0px rgba(0,0,0,0.2);
  -moz-box-shadow: 10px 10px 23px 0px rgba(0,0,0,0.1);
  box-shadow: 10px 10px 23px 0px rgba(0,0,0,0.1);
  cursor: context-menu;
}

.fas:hover {
  color: #d63031;
}

.notBtn:hover > .box{
  height: 60vh
}

.content{
  padding: 20px;
  color: black;
  vertical-align: middle;
  text-align: left;
}

.gry{
  background-color: #F4F4F4;
}

.top{
  color: black;
  padding: 10px
}

.display{
  position: relative;
  z-index:99;
}

.cont{
  position: absolute;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: #F4F4F4;
}

.cont:empty{
  display: none;
}

.stick{
  text-align: center;  
  display: block;
  font-size: 50pt;
  padding-top: 70px;
  padding-left: 80px
}

.stick:hover{
  color: black;
}

.cent{
  text-align: center;
  display: block;
}

.sec{
  padding: 25px 10px;
  background-color: #F4F4F4;
  transition: 0.5s;
}

.profCont{
  padding-left: 15px;
}

.profile{
  -webkit-clip-path: circle(50% at 50% 50%);
  clip-path: circle(50% at 50% 50%);
  width: 75px;
  float: left;
}

.txt{
  vertical-align: top;
  font-size: 1.25rem;
  padding: 5px 10px 0px 115px;
}

.sub{
  font-size: 1rem;
  color: grey;
}

.new{
  border-style: none none solid none;
  background-color: rgb(252, 255, 229);
}

.sec:hover{
  background-color: #BFBFBF;
}
    </style>
</head>

<body>
    <%-- 錯誤表列 --%>
    <c:if test="${not empty errorMsgs}">
        <font color='red'>請修正以下錯誤:</font>
        <ul>
            <c:forEach var="message" items="${errorMsgs}">
                <li style="color:red">${message}</li>
            </c:forEach>
        </ul>
    </c:if>
    <div class="front_header">
        <div class="header-w3-agileits" id="home">
            <div class="inner-header-agile">
                <nav class="navbar navbar-default">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <h1><a href="<%=request.getContextPath()%>/index.jsp"><span>M</span>ovies<span>H</span>it
                                <img src="<%=request.getContextPath()%>/images/logo.png" width=40 height=40></a></h1>
                    </div>
                    <!-- navbar-header -->
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">電影介紹<b class="caret"></b></a>
                                <ul class="dropdown-menu multi-column columns-3">
                                    <li>
                                        <div class="col-sm-4">
                                            <ul class="multi-column-dropdown">
                                                <li><a href="<%=request.getContextPath()%>/front-end/movie/listAllMovie.jsp">所有電影</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=冒險片">冒險片</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=戰爭片">戰爭片</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=警匪片">警匪片</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=驚悚片">驚悚片</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=愛情片">愛情片</a></li>
                                            </ul>
                                        </div>
                                        <div class="col-sm-4">
                                            <ul class="multi-column-dropdown">
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=動作片">動作片</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=劇情片">劇情片</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=犯罪片">犯罪片</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=恐怖片">恐怖片</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=喜劇片">喜劇片</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=動畫片">動畫片</a></li>
                                            </ul>
                                        </div>
                                        <div class="col-sm-4">
                                            <ul class="multi-column-dropdown">
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=科幻片">科幻片</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=史詩片">史詩片</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=音樂片">音樂片</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=懸疑片">懸疑片</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=文藝片">文藝片</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=歌舞劇">歌舞劇</a></li>
                                            </ul>
                                        </div>
                                        <div class="clearfix"></div>
                                    </li>
                                </ul>
                            </li>
                            <li><a href="<%=request.getContextPath()%>/front-end/article/listAllArticle.jsp">魔穴論壇</a></li>
                            <li><a href="<%=request.getContextPath()%>/front-end/group/group_front_page.jsp">揪團啾啾</a></li>
                            <li><a href="<%=request.getContextPath()%>/front-end/news/listAllNews.jsp">最新消息</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">會員專區<b class="caret"></b></a>
                                <ul class="dropdown-menu multi-column columns-1">
                                   <c:choose>
                                     <c:when test="${memVO==null || memVO.member_no==99 }">
                                     	<li><a href="#" onclick="loginFirst()" >會員中心</a></li>
                                     	<li><a href="#" onclick="loginFirst()" >會員資訊</a></li>
                                     	<li><a href="#" onclick="loginFirst()" >好友管理</a></li>
                                     </c:when>
                                     <c:otherwise>
                                     	<li><a href="<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">會員中心</a></li>
                                     	<li><a href="<%=request.getContextPath()%>/front-end/mem/memberInfo.jsp">會員資訊</a></li>
                                     	<li><a href="<%=request.getContextPath()%>/front-end/relationship/select_page.jsp">好友管理</a></li>
                                     </c:otherwise>
                                   </c:choose>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <div class="clearfix"> </div>
                </nav>
                <div class="w3ls_search">
						<div class="cd-main-header">
								<div class = "notification">
								  <a href = "#">
								  <div class = "notBtn" href = "#">
								    <div id="number" class = "number"></div>
								    <i class="fas fa-bell"></i>
								      <div class = "box">
								        <div class = "display">
								          <div class = "nothing"> 
								            <i class="fas fa-child stick"></i> 
								            <div class = "cent"></div>
								          </div>
								          <div class = "cont"><!-- Fold this div and try deleting evrything inbetween -->
				
								         </div>
								        </div>
								     </div>
								  </div>
								    </a>
								</div>
							<ul class="cd-header-buttons">
								<c:choose>
									<c:when test="${memVO.member_no == 99}">
										<li class="active rhs"><a id="login-btn"  href="<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp">登入</a></li>
									</c:when>
									<c:otherwise>
										<li class="active rhs">
												<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${memVO.member_no}" 
												id="${groupVO.group_no}-${memVO.member_no}" alt="尚無圖片" width="60px;" height="60px" 
												style="border-radius:50%;" class="clickable" />
											<a id="welcome"> ${memVO.mb_name } &nbsp</a>
											<a id="logout-btn" href="<%=request.getContextPath()%>/front-end/mem/MemLogout.jsp"> 登出 </a>
										</li>
									</c:otherwise>
								</c:choose>
								<li><a class="cd-search-trigger" href="#cd-search"> <span></span></a></li>
							</ul> <!-- cd-header-buttons -->
						</div>
						<div id="cd-search" class="cd-search">
							<form method="post" action="<%=request.getContextPath()%>/movie/movie.do" name="form1">
								<input id="search-context"  type="text" name="MOVIE_NAME" value="" placeholder="請輸入電影名稱" onkeydown="if (event.keyCode == 13) sendMessage();">
								<input type="hidden" name="action" value="listMovies_ByCompositeQuery">
							</form>
							<div id="search-results"class="container" >
							</div>
						</div>
						
					</div>
            </div>
        </div>
    </div>
</body>
<script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
<script>
        $(document).ready(function() {
            $(".dropdown").hover(
                function() {
                    $('.dropdown-menu', this).stop(true, true).slideDown("fast");
                    $(this).toggleClass('open');
                },
                function() {
                    $('.dropdown-menu', this).stop(true, true).slideUp("fast");
                    $(this).toggleClass('open');
                }
            );
        });
    </script>
    <!-- //Dropdown-Menu-JavaScript -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.zoomslider.min.js"></script>
    <!-- search-jQuery -->
    <script src="<%=request.getContextPath()%>/js/main.js"></script>
    <script src="<%=request.getContextPath()%>/js/simplePlayer.js"></script>
<script>
		$(document).ready(function(){
			$("#logout-btn").click(function(){
				window.location.href = '<%=request.getContextPath()%>/index.jsp';
			});
			
			
			let hasLoggedIn = <%= memVO.getMember_no() %>;
			if(hasLoggedIn != 99){
				$("#welcome").show();
				$("#login-btn").hide();
				$("#logout-btn").show();
			} else{
				$("#welcome").hide();
				$("#login-btn").show();
				$("#logout-btn").hide();
			}
			
		});
    	$("#search-context").on('input propertychange', function(){
    		$("#search-results").html('<hr class="hrhr">');
    		if(!$(this).val() == ""){
    			var result;
    			console.log("送出搜尋 = " + $(this).val());
    			let json_result_list = getResults($(this).val());
        		console.log("收回結果");
    			console.log(json_result_list);
        		if(json_result_list != undefined ){
	        		for ( movieVO of json_result_list){
	        			console.log(movieVO.moviename);
	        			console.log(movieVO.actor);
	        			console.log(movieVO.premiredate);
	        			console.log(movieVO.movieno);
	        			let link = '<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=' + movieVO.movieno  + '' ;
	        			var dt = new Date(movieVO.premiredate);
	        			var yr = 1900 + dt.getYear();
	        			result = 
		    				'<div class="rslt row" onclick="location.href=\'' + link+ '\'" > ' +
		    				'	<div class="col-md-3"> ' +
		    		   		'			<img src="<%=request.getContextPath()%>/movie/DBGifReader2.do?movieno=' + movieVO.movieno + '" title=" " width="260px" height="120px"> ' +
		    		  		'		</div> ' +
		    		  		'		<div class="col-md-9">' +
		    				'		<p class="mov-name">'+ movieVO.moviename +  '</p>' +
		    				'		<p class="non-mov-name">'+ movieVO.actor +  '</p> ' +
		    				'		<p class="non-mov-name">'+ yr +  '</p> ' +
		    	  			'	</div>' +
		    				'</div>' +
		    				'<hr class="hrhr">';
		    			
		        		$("#search-results").html(
		        				$("#search-results").html() + result
		        		);
	        		}
        		}
    		}
    	});

    	function getResults(words){
    		let json;
			$.ajax({
					url: "<%=request.getContextPath()%>/movie/movie.do",
					type:"POST",
					data: {
						MOVIE_NAME: words,
						action:"search_Ajax"
					},
					async: false,
					success: function(data){
						console.log(data);
						json = JSON.parse(data).results;
					}
				});
			return json;
	}
</script>
<script>
var count_header=0;

	    $(document).ready(function(){
	    	var notify_head = $(".cont");
	    	var slice;
	    	var memberno = ${memVO.member_no};
	   	 $.ajax({
	   		 url:"<%=request.getContextPath()%>/NotifyServlet?action=insert_For_Ajax",
	   		 data:{
	   			 "member_no":memberno
	   		 },
	   		 type:"POST",
	   		 success:function(json){
	   			 var number = document.getElementById("number");
	   			 let jsonobj = JSON.parse(json);
				 let all_list = jsonobj.all;
				 let len = jsonobj.all.length;
				 let slice="";
			     let slice1="";

				 for(let i = 0 ; i < len ; i++){
					 let jsono = JSON.parse(all_list[i]);
					 let type=jsono.type;
					 let read=jsono.read;
					 if(read==="Y"){
						 
						 if(type==="addFriend"||type==="response"){
							 slice += `<div class = "sec">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/friend.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
							 if(type==="addGroup"||type==="createGroup"||type==="goGroup"||type==="activeDismissGroup"){
							 slice += `<div class = "sec">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/group.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
							 if(type==="buyTicket"){
							 slice += `<div class = "sec">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/ticket.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
							 if(type==="reminder"||type==="dismissGroup"||type==="kickoffGroup"||type==="kickUnpaid"){
							 slice += `<div class = "sec">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/warning.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
						
					 }else{
						 
						 if(type==="addFriend"||type==="response"){
							 slice1 += `<div class = "sec new">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/friend.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
							 if(type==="addGroup"||type==="createGroup"||type==="goGroup"||type==="activeDismissGroup"){
							 slice1 += `<div class = "sec new">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/group.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
							 if(type==="buyTicket"){
							 slice1 += `<div class = "sec new">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/ticket.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
							 if(type==="reminder"||type==="dismissGroup"||type==="kickoffGroup"||type==="kickUnpaid"){
							 slice1 += `<div class = "sec new">
					          <a href = "<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">
					          <div class = "profCont">
					            <img class = "profile" src = "<%=request.getContextPath()%>/images/notify_icons/warning.png">
					          </div>
					          <div class = "txt">`+jsono.message+`</div>
					         <div class = "txt sub">`+jsono.time+`</div>
					          </a>
					       </div>`;
					       	}
							 
							 count_header++;

					 }
				 }
		   		 notify_head.append(slice1); 
				 notify_head.append(slice); 
		   		 number.innerText=count_header;
		   		 if(number.innerText == 0){
		   			 number.style.display="none";
		   		 }
		   		 
	   			 }
	   		 })
	    	
	    })
	    
	    $(".fa-bell").click(function(){
	    	var notify_head = $(".cont");
	    	var memberno = ${memVO.member_no};

	    	 $.ajax({
		   		 url:"<%=request.getContextPath()%>/NotifyServlet?action=readNotify",
		   		 data:{
		   			 "member_no":memberno
		   		 },
		   		 type:"POST",
		   		 success:function(json){
 				 if(json=="success"){
 			   		 number.style.display="none";
 				 }else{
 					Swal.fire({
	                      position: "center",
	                      icon: "error",
	                      title: "通知連線忙線中，請稍後再試",
	                      showConfirmButton: false,
	                      timer: 1000,
	                  });
 				 }	 
					 }	 
	   			 })
		   			
		   		 });
	    function loginFirst(){
			Swal.fire('請先登入').then((result)=>{
				window.location.href = "<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp";
			});
		}	
	    </script>
</html>