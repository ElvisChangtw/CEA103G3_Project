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
    <style>
        div.form-group>button.btn {
border-radius: 3px;
}
.chart .chart2{
width:50px;
height:50px;
}
</style>
</head>

<body>
    <%-- ���~��C --%>
    <c:if test="${not empty errorMsgs}">
        <font color='red'>�Эץ��H�U���~:</font>
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
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">�q�v����<b class="caret"></b></a>
                                <ul class="dropdown-menu multi-column columns-3">
                                    <li>
                                        <div class="col-sm-4">
                                            <ul class="multi-column-dropdown">
                                                <li><a href="<%=request.getContextPath()%>/front-end/movie/listAllMovie.jsp">�Ҧ��q�v</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�_�I��">�_�I��</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�Ԫ���">�Ԫ���</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=ĵ���">ĵ���</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�宪��">�宪��</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�R����">�R����</a></li>
                                            </ul>
                                        </div>
                                        <div class="col-sm-4">
                                            <ul class="multi-column-dropdown">
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�ʧ@��">�ʧ@��</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�@����">�@����</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�Ǹo��">�Ǹo��</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=���Ƥ�">���Ƥ�</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�߼@��">�߼@��</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�ʵe��">�ʵe��</a></li>
                                            </ul>
                                        </div>
                                        <div class="col-sm-4">
                                            <ul class="multi-column-dropdown">
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=��ۤ�">��ۤ�</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�v�֤�">�v�֤�</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=���֤�">���֤�</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�a�ä�">�a�ä�</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=������">������</a></li>
                                                <li><a href="${pageContext.request.contextPath}/movie/movie.do?action=listMovies_ByCompositeQuery&CATEGORY=�q�R�@">�q�R�@</a></li>
                                            </ul>
                                        </div>
                                        <div class="clearfix"></div>
                                    </li>
                                </ul>
                            </li>
                            <li><a href="<%=request.getContextPath()%>/front-end/article/listAllArticle.jsp">�]�޽׾�</a></li>
                            <li><a href="<%=request.getContextPath()%>/front-end/group/group_front_page.jsp">���γ��</a></li>
                            <li><a href="<%=request.getContextPath()%>/front-end/news/listAllNews.jsp">�̷s����</a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">�|���M��<b class="caret"></b></a>
                                <ul class="dropdown-menu multi-column columns-1">
                                    <li><a href="<%=request.getContextPath()%>/front-end/mem/memberSys.jsp">�|������</a></li>
                                    <li><a href="<%=request.getContextPath()%>/front-end/mem/memberInfo.jsp">�|����T</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <div class="clearfix"> </div>
                </nav>
                <div class="w3ls_search">
						<div class="cd-main-header">
							<ul class="cd-header-buttons">
								<c:choose>
									<c:when test="${memVO.member_no == 99}">
										<li class="active rhs"><a id="login-btn"  href="<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp">�n�J</a></li>
									</c:when>
									<c:otherwise>
										<li class="active rhs">
												<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${memVO.member_no}" 
												id="${groupVO.group_no}-${memVO.member_no}" alt="�|�L�Ϥ�" width="60px;" height="60px" 
												style="border-radius:50%;" class="clickable" />
											<a id="welcome"> ${memVO.mb_name } &nbsp</a>
											<a id="logout-btn" href="#"> �n�X </a>
										</li>
									</c:otherwise>
								</c:choose>
								<li><a class="cd-search-trigger" href="#cd-search"> <span></span></a></li>
							</ul> <!-- cd-header-buttons -->
						</div>
						<div id="cd-search" class="cd-search">
							<form method="post" action="<%=request.getContextPath()%>/movie/movie.do" name="form1">
								<input id="search-context"  type="text" name="MOVIE_NAME" value="" placeholder="�п�J�q�v�W��" onkeydown="if (event.keyCode == 13) sendMessage();">
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
				<% session.removeAttribute("memVO"); %>
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
    			console.log("�e�X�j�M = " + $(this).val());
    			let json_result_list = getResults($(this).val());
        		console.log("���^���G");
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
</html>