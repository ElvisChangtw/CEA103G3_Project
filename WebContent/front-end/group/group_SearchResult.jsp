<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.group.model.*"%>

<jsp:useBean id="listGroups_ByCompositeQuery" scope="request" type="java.util.List<GroupVO>" /> <!-- 於EL此行可省略 -->
<jsp:useBean id="groupSvc" scope="page" class="com.group.model.GroupService" />
<jsp:useBean id="memVO" scope="session" type="com.mem.model.MemVO" />

<!--
author: W3layouts
author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE html>
<html>

<head>
    <title>MoviesHit Groups</title>
    <!-- for-mobile-apps -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=big5" />
    <script type="application/x-javascript">
        addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);

        function hideURLbar() { window.scrollTo(0, 1); }
    </script>
    <!-- //for-mobile-apps -->
    <link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    
        <link href="<%=request.getContextPath()%>/css/owl.carousel.css" rel="stylesheet" type="text/css" media="all">
    <script src="<%=request.getContextPath()%>/js/owl.carousel.js"></script>
    <!-- pop-up -->
    <link href="<%=request.getContextPath()%>/css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
    <!-- //pop-up -->
    <link href="<%=request.getContextPath()%>/css/easy-responsive-tabs.css" rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/zoomslider.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
    <link href="<%=request.getContextPath()%>/css/font-awesome.css" rel="stylesheet">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/modernizr-2.6.2.min.js"></script>
    <!--/web-fonts-->
    <link href='//fonts.googleapis.com/css?family=Tangerine:400,700' rel='stylesheet' type='text/css'>
    <link href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900" rel="stylesheet">
    <link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
    <!--//web-fonts-->
	<!--     自定義css格式 -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styleForGroup.css" />
    <!--     自定義css格式 -->
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- 	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
<!-- 	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script> -->
	
</head>

<body>
    <!--/main-header-->
    <!--/banner-section-->
    <jsp:include page="/front_header.jsp"/>
    <!--/banner-section-->
    <!--//main-header-->
    <!--/banner-bottom-->
<!--     <div class="w3_agilits_banner_bootm"> -->
<!--         <div class="w3_agilits_inner_bottom"> -->
<!--             <div class="col-md-6 wthree_agile_login"> -->
<!--                 <ul> -->
<!--                     <li><i class="fa fa-phone" aria-hidden="true"></i> (+000) 009 455 4088</li> -->
<!--                     <li><a href="#" class="login" data-toggle="modal" data-target="#myModal4">Login</a></li> -->
<!--                     <li><a href="#" class="login reg" data-toggle="modal" data-target="#myModal5">Register</a></li> -->
<!--                 </ul> -->
<!--             </div> -->
        
<!--         </div> -->
<!--     </div> -->
    
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
			<%@ include file="pages/page1_ByCompositeQuery.file"%>
<!-- 			換頁 -->

            <div class="wthree_agile-requested-movies tv-movies">
            
            <c:forEach var="groupVO" items="${listGroups_ByCompositeQuery}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">

 			<jsp:useBean id="showtimeSvc" scope="page" class="com.showtime.model.ShowtimeService" />
            <jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />
                        
<!--複合查詢揪團開始 -->
                <div class="col-md-2 w3l-movie-gride-agile requested-movies">
                    <a href="<%=request.getContextPath()%>/group/group.do?action=getOne_For_Display&group_no=${groupVO.group_no}&requestURL=<%=request.getServletPath()%>" class="hvr-sweep-to-bottom">
                    	<img src="${pageContext.request.contextPath}/movie/DBGifReader4.do?movieno=${showtimeSvc.getOneShowtime(groupVO.showtime_no).movie_no}" title="MoviesHit" class="img-responsive" alt="尚無圖片">
                        <div class="w3l-action-icon"><i class="fa fa-play-circle-o" aria-hidden="true"></i></div>
                    </a>
                    <div class="mid-1 agileits_w3layouts_mid_1_home">
                        <div class="w3l-movie-text">
                            <h6><a href="<%=request.getContextPath()%>/group/group.do?action=getOne_From06&group_no=${groupVO.group_no}&requestURL=<%=request.getServletPath()%>" class="group-title">${groupVO.group_title}</a></h6>
                        </div>
                        <div class="mid-2 agile_mid_2_home">
                       
                            <p><i class="fa fa-film" aria-hidden="true"></i> ${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(groupVO.showtime_no).movie_no).moviename}</p><br>
                            
                            <p><i class="fa fa-clock-o" aria-hidden="true"></i> <fmt:formatDate value="${groupVO.deadline_dt}" pattern="yyyy-MM-dd HH:mm" /></p><br>
                            	<p><i class="fa fa-user" aria-hidden="true"></i> ${groupVO.member_cnt}/${groupVO.required_cnt}</p><br>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
<!--複合查詢揪團結束 -->
              </c:forEach>
              <div class="clearfix"></div>
              <!-- 			換頁 -->
              <%@ include file="pages/page2_ByCompositeQuery.file"%>
<!-- 			換頁 -->

        </div>
    </div>
</div>
    <!--//content-inner-section-->
    <!--揪團列表外層div -->
    
    <jsp:include page="/front_footer_copy.jsp"/>
    <!--/footer-bottom-->
   
<%--     <script src="<%=request.getContextPath()%>/js/jquery-1.11.1.min.js"></script> --%>
    <!-- Dropdown-Menu-JavaScript -->
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
    <!-- search-jQuery -->
    <script src="<%=request.getContextPath()%>/js/main.js"></script>
    <!-- //search-jQuery -->
    <script src="<%=request.getContextPath()%>/js/simplePlayer.js"></script>
    <script>
        $("document").ready(function() {
            $("#video").simplePlayer();
        });
    </script>
    <script>
        $("document").ready(function() {
            $("#video1").simplePlayer();
        });
    </script>
    <script>
        $("document").ready(function() {
            $("#video2").simplePlayer();
        });
    </script>
    <script>
        $("document").ready(function() {
            $("#video3").simplePlayer();
        });
    </script>
    <script>
        $("document").ready(function() {
            $("#video4").simplePlayer();
        });
    </script>
    <script>
        $("document").ready(function() {
            $("#video5").simplePlayer();
        });
    </script>
    <script>
        $("document").ready(function() {
            $("#video6").simplePlayer();
        });
    </script>
    <!-- pop-up-box -->
    <script src="<%=request.getContextPath()%>/js/jquery.magnific-popup.js" type="text/javascript"></script>
    <!--//pop-up-box -->
    <div id="small-dialog1" class="mfp-hide">
        <iframe src="https://player.vimeo.com/video/165197924?color=ffffff&title=0&byline=0&portrait=0"></iframe>
    </div>
    <div id="small-dialog2" class="mfp-hide">
        <iframe src="https://player.vimeo.com/video/165197924?color=ffffff&title=0&byline=0&portrait=0"></iframe>
    </div>
    <script>
        $(document).ready(function() {
		$('.w3_play_icon,.w3_play_icon1,.w3_play_icon2').magnificPopup({
			type: 'inline',
			fixedContentPos: false,
			fixedBgPos: true,
			overflowY: 'auto',
			closeBtnInside: true,
			preloader: false,
			midClick: true,
			removalDelay: 300,
			mainClass: 'my-mfp-zoom-in'
		});
																		
		});
	</script>
    <script src="<%=request.getContextPath()%>/js/easy-responsive-tabs.js"></script>
    <script>
        $(document).ready(function () {
$('#horizontalTab').easyResponsiveTabs({
type: 'default', //Types: default, vertical, accordion           
width: 'auto', //auto or any width like 600px
fit: true,   // 100% fit in a container
closed: 'accordion', // Start closed if in accordion view
activate: function(event) { // Callback function if tab is switched
var $tab = $(this);
var $info = $('#tabInfo');
var $name = $('span', $info);
$name.text($tab.text());
$info.show();
}
});
$('#verticalTab').easyResponsiveTabs({
type: 'vertical',
width: 'auto',
fit: true
});
});
</script>		

    <script>
        $(document).ready(function() {
            $("#owl-demo").owlCarousel({

                autoPlay: 3000, //Set AutoPlay to 3 seconds
                autoPlay: true,
                navigation: true,

                items: 5,
                itemsDesktop: [640, 4],
                itemsDesktopSmall: [414, 3]

            });

        });
    </script>
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
            /*
							var defaults = {
					  			containerID: 'toTop', // fading element id
								containerHoverID: 'toTopHover', // fading element hover id
								scrollSpeed: 1200,
								easingType: 'linear' 
					 		};
							*/

            $().UItoTop({ easingType: 'easeOutQuart' });

        });
    </script>
    <!--end-smooth-scrolling-->
    <script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>

<c:if test="${openModal_Group!=null}">
  <!-- The Modal -->
  <div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
<!--                 <h3 class="modal-title" id="myModalLabel">揪團成員</h3> -->
            </div>
			
			<div class="modal-body">
<!-- =========================================以下為原listOneEmp.jsp的內容========================================== -->
               <jsp:include page="listOneGroup.jsp" />
<!-- =========================================以上為原listOneEmp.jsp的內容========================================== -->
	<!-- Modal footer -->
          </div>
			<div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>
		</div>
	</div>
</div>
        <script>
    		 $("#basicModal").modal({show: true});
        </script>
 </c:if>
  <!-- The Modal -->
  
</body>
	<script>
// 	 jQuery(document).ready(function($) {
//          $("#testswal").click(function(event) {
//         	 Swal.fire(
//         			  'Good job!',
//         			  'You clicked the button!',
//         			  'success'
//         			)
//          });
//      });
	</script>
	
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
	       timepicker:true,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
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
   
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
        //      var somedate1 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});

        
        //      2.以下為某一天之後的日期無法選擇
        //      var somedate2 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});


        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
          function loginFirst(){
        	alert("請先登入");
        	window.location.href = "<%=request.getContextPath()%>/front-end/mem/MemLogin.jsp";
        }
</script>

	
</html>