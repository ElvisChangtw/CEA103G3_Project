<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page import="com.movieRating.model.*"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="ratingSvc" scope="page" class="com.movieRating.model.MovieRatingService" />
<jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />
<jsp:useBean id="articleSvc" scope="page" class="com.article.model.ArticleService" />
<jsp:useBean id="artcolSvc" scope="page" class="com.articleCollection.model.ArticleCollectionService" />
<jsp:useBean id="movcolSvc" scope="page" class="com.movieCollection.model.MovieCollectionService" />
<jsp:useBean id="commSvc" scope="page" class="com.comment.model.CommentService" />
<jsp:useBean id="orderSvc" scope="page" class="com.order.model.OrderService" />
<jsp:useBean id="showtimeSvc" scope="page" class="com.showtime.model.ShowtimeService" />
<jsp:useBean id="ordTicketTypeSvc" scope="page" class="com.ord_ticket_type.model.Ord_ticket_typeService" />
<jsp:useBean id="ticketTypeSvc" scope="page" class="com.ticket_type.model.Ticket_typeService" />
<jsp:useBean id="ordFoodTypeSvc" scope="page" class="com.ord_food.model.Ord_foodService" />
<jsp:useBean id="foodSvc" scope="page" class="com.food.model.FoodService" />
<jsp:useBean id="groupSvc" scope="page" class="com.group.model.GroupService" />
<jsp:useBean id="groupMemSvc" scope="page" class="com.group_member.model.Group_MemberService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="relationSvc" scope="page" class="com.relationship.model.RelationshipService" />
<jsp:useBean id="mapping" scope="page" class="com.mappingtool.StatusMapping" />
<%@ page import="com.mem.model.*"%>
<%@ page import="com.articleCollection.model.*"%>
<%@ page import="com.order.model.*"%>
<%@ page import="com.group.model.*"%>
<%@ page import="java.util.*"%>

<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="com.mappingtool.*"%>

<%
	MemVO memVO = (MemVO)session.getAttribute("memVO");

	ArticleCollectionVO artcolVO = (ArticleCollectionVO)request.getAttribute("artcolVO");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/front/notification.css" /> --%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/front/memberSys.css" />
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" /> -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"  -->
<!-- integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous"> -->


<title>Insert title here</title>

<style>
hr{
	border: 5px solid black;
}
.body{
	font-size:5px;
}

.order_box, .master_box, .member_box, .update_group_box{
	position:fixed;
	overflow:scroll;
	z-index: -1;
	opacity:0;
	height:100vh;
	min-width:100vw;
	backdrop-filter: blur(5px);
	top:50%;
	left:50%;
	width:fit-content;
	transform:translate(-50%, -50%);
	transition:0.3s ease-in;

}
.order_box_for_position, .master_box_for_position, .member_box_for_position , .update_group_box_for_position{
	margin-top:230px;
	text-align:center;
	margin-left:400px;
	height:40%;
	width:50%;
}

.comment_box {
	position:fixed;
	overflow:scroll;
	z-index: -1;
	opacity:0;
	height:100vh;
	min-width:100vw;
	backdrop-filter: blur(5px);
	top:50%;
	left:50%;
	width:fit-content;
	transform:translate(-50%, -50%);
	transition:0.3s ease-in;

}

.detail_box{
	height:auto; 
	padding:unset;
}

.info-content .tab-panel #movieRating-info-form, #movieCollection-info-form, #comment-info-form, #ticket-info-form, #group-info-form, #notify-info-form, #articleCollection-info-form{
	width:100%;
}
.info-content .tab-panel .noCSS{
	width:unset;
	min-height:unset;
	height:unset;
	padding:unset;
}
.comment_box_for_position{
	margin-top:230px;
	text-align:center;
	margin-left:400px;
	height:40%;
	width:50%;
}
.comment_content{
	background-color:white;
	height:80%;
	width:100%;
}
.cardBtn{
	display:inline-block;
}
.fa-minus-circle{
	color:crimson !important;
	font-size:30px;
}
.all-star{
	font-size:30px;
	margin-right:auto !important;
	margin-left:auto !important;
}
.hover_pointer{
	cursor:pointer;
}
.rating_mov_pic{
	width:320px !important;
	height:400px !important;
}
#ratingTable{
text-align:center;
}



.hover_table{
	border:unset;
	margin:auto;
}

.notification{
/*   bottom: 25px; */
bottom: 45px !important; 
/*   left: 340px; */
left: 1440px !important; 
  position: relative;
  display: inline-block;
}

/* 通知用 */
  @import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

.fadeOut {
  opacity: 0 !important;
}

#create {
  border: none !important;
  padding: 8px !important;
  font-size:15px !important;
  color: #FFF !important;
  background-color: firebrick !important;
  border-radius: 8px !important;
}

.alert-container{
  position: fixed !important;
  right: 10px !important;
  bottom: 10px !important;
  z-index:100;
}

.alert {
  position: relative !important;
  background-color: white !important;
  border: 5px solid lightblue !important;
  height: 130px !important;
  width: 290px !important;
  border-radius: 15px !important;
  margin-bottom: 15px !important;
  color: #40bde6 !important;
  padding: 20px 15px 0 15px !important;
  transition: opacity 2s !important;
}

.alert span {
  font-size: 1.3rem !important;
  position: absolute !important;
  top: 3px !important;
  right: 12px !important;
  cursor: pointer !important;

}
.alertTxt{
  font-size: 17px !important;
  position: absolute !important;
  top: 0px !important;
  right: 12px !important;
  cursor: pointer !important;
  margin-top:23px !important;
  width:170px !important;

}
.alertImg{
  width:80px !important;
  margin-left:-5px !important;

}
.alertTxt .alertTime{
	position:fixed;
	bottom:40px;
	right:40px;
	font-size:10px !important;
	color:gray;
}
</style>
</head>
<body onload="connect();starbling();" onunload="disconnection();">
<jsp:include page="/front_header.jsp"/>
	<div class="main-wrapper">
		<div class="info-div">
			<div class="info-content">
				<div class="tabset">
				<input type="radio" name="tabset" id="tab1"
						aria-controls="ticket" checked> <label for="tab1">票券管理</label>
				<input type="radio" name="tabset" id="tab2"
						aria-controls="group" > <label for="tab2">揪團管理</label>
				<input type="radio" name="tabset" id="tab3"
						aria-controls="notify" /> <label for="tab3">通知管理</label>
				<input type="radio" name="tabset" id="tab4"
						aria-controls="comment" /> <label for="tab4">評論管理</label>
				<input type="radio" name="tabset" id="tab5"
						aria-controls="movieCollection" /> <label for="tab5">已收藏電影</label>
				<input type="radio" name="tabset" id="tab6"
						aria-controls="articleCollection" /> <label for="tab6">已收藏文章</label>
				<input type="radio" name="tabset" id="tab7"
						aria-controls="movieRating" /> <label for="tab7">已評分電影</label>
					<div class="tab-panels">
						<section id="ticket" class="tab-panel">
						<div class="container-fluid">
								<div class="row">
							<form method="post" id="ticket-info-form">
								<h1 class="table-order">已預訂</h1>
								<table class="table table-hover table-order table-bordered">								
									 <tr class="table-order table-success" style="display:none;"><th>購票日期</th><th>電影名稱</th><th>狀態</th><th>付款方式</th><th>金額</th><th>退票</th><th>詳細資訊</th></tr>
									 <center id="orderticket_switch"><div>您目前沒有預訂任何電影票，快按<a href=<%=request.getContextPath()%>/index.jsp>這裡</a>來訂票!</div></center>
								</table>
								<br>
								<hr class="table-order"/>
								<h1 class="table-history">購票紀錄</h1>
								<table class="table table-hover table-history table-bordered">								
									 <tr class="table-history" style="display:none;"><th>購票日期</th><th>電影名稱</th><th>狀態</th><th>付款方式</th><th>金額</th><th>詳細資訊</th></tr>
									 <center id="orderhistory_switch"><div>您沒有任何訂票紀錄</div></center>
								</table>
							</form>
						</div>
					</div>
					
						</section>

						<section id="group" class="tab-panel">
						<div class="container-fluid">
								<div class="row">
							<form method="post" id="group-info-form">
							
								<h1 class="table-group-master">目前主辦的團</h1>
								<table class="table table-hover table-group-master table-bordered">								
									 <tr class="table-group-master" style="display:none;"><th>揪團名稱</th><th>電影名稱</th><th>開演時間</th><th>揪團狀態</th><th>預計參加人數</th><th>目前參加人數</th><th>詳細資訊</th><th>修改揪團</th></tr>
									 <center id="group_master_switch"><div>您目前沒有發起任何揪團，快按<a href=<%=request.getContextPath()%>/front-end/group/group_front_page.jsp>這裡</a>來發起揪團!</div></center>
								</table>
								<br>
								<hr class="table-group-master"/>
								
								<h1 class="table-group-member">目前參加的團</h1>
								<table class="table table-hover table-group-member table-bordered">								
									 <tr class="table-group-member" style="display:none;"><th>揪團名稱</th><th>團主</th><th>電影名稱</th><th>開演時間</th><th>揪團狀態</th><th>付款狀態</th><th>預計參加人數</th><th>目前參加人數</th><th>詳細資訊</th><th>退出揪團</th></tr>
									 <center id="group_member_switch"><div>您目前沒有任何揪團，快按<a href=<%=request.getContextPath()%>/front-end/group/group_front_page.jsp>這裡</a>來參加揪團!</div></center>
								</table>
								<br>
								<hr class="table-group-member"/>
								
								<h1 class="table-group-history">揪團歷史紀錄</h1>
								<table class="table table-hover table-group-history table-bordered">								
									 <tr class="table-group-history" style="display:none;"><th>揪團名稱</th><th>團主</th><th>電影名稱</th><th>開演時間</th><th>揪團狀態</th><th>參與狀態</th><th>詳細資訊</th></tr>
									 <center id="group_history"><div>您目前沒有任何揪團歷史紀錄</div></center>
								</table>
							</form>
						</div>
					</div>
						</section>

						<section id="notify" class="tab-panel">
							<div id="show_notify" class="container-fluid">
								<div class="row">
									<form method="post" id="notify-info-form">
									<h1 class="table-friend">好友通知</h1>
										<table class="table table-hover">
									 		<tr class="table-friend"><th>通知時間</th><th>通知內容</th></tr>
									 	</table>
									<h1 class="table-group">揪團通知</h1>
										<table class="table table-hover">
									 		<tr class="table-group"><th>通知時間</th><th>通知內容</th></tr>
									 	</table>
									<h1 class="table-ticket">訂票通知</h1>
										<table class="table table-hover">
									 		<tr class="table-ticket"><th>通知時間</th><th>通知內容</th></tr>
									 	</table>
									 	
									</form>
								</div>
							</div>
						</section>

						<section id="comment" class="tab-panel">
							<div id="show_comment" class="container-fluid" style="display:none">
								<div class="row">
									<form method="post" id="comment-info-form">
									 	<table class="table table-hover table-bordered">
									 	<tr><th>發表日期</th><th>電影名稱</th><th>詳細資訊</th><th>移除評論</th></tr>
										 	<c:forEach var="commVO" items="${commSvc.getComments(memVO.member_no)}">
												<tr class="hover_comm hover_pointer"><td style="display:none">${commVO.movieno}</td><td><fmt:formatDate value="${commVO.creatdate}" pattern="yyyy-MM-dd HH:mm" /></td>
											<td>${movieSvc.getOneMovie(commVO.movieno).moviename}</td>
											<td><button type="button" class="btn btn-primary" id="show_commBox_${commVO.commentno}">查看</button></td>
												<td><i class="fas fa-minus-circle delete-comm"></i>
													<input name="movie_no" style="display: none" value="${commVO.movieno}">
													<input name="comm_no" style="display: none" value="${commVO.commentno}">
 												</td>
											</tr>
											<div class="comment_box" id="comment_box_${commVO.commentno}">
												<div class="comment_box_for_position">
													<textarea class="comment_content" id="comment_content_${commVO.commentno}" name="comment" disabled>${commVO.content}</textarea>
													<div class="cardBtn">
														<button type="button" class="btn btn-primary enterComment">修改</button>
													</div>
													<div class="cardBtn">
														<button type="button" class="btn btn-warning leaveComment">取消</button>
													</div>
													<div class="cardBtn">
														<button type="button" class="btn btn-primary updateComment" id="updateComment_${commVO.commentno}" style="display:none;">確定</button>
													</div>
													<div class="cardBtn">
														<button type="button" class="btn btn-warning cancelUpdate" style="display:none;">取消</button>
													</div>
												</div>
											</div>
											</c:forEach>
									 	</table>
									</form>
								</div>
							</div>
						</section>
						<section id="movieCollection" class="tab-panel">
						<div class="container-fluid">
							<div class="row">
								<form method="post" class="col" id="movieCollection-info-form">
								<table class="table table-hover table-bordered">
										<tr><th>電影名稱</th><th>收藏時間</th><th>電影資訊</th><th>移除收藏</th></tr>
										<c:forEach var="movcolVO" items="${movcolSvc.getAllMovieCollection(memVO.member_no)}">
											<tr class="hover_movCol hover_pointer"><td style="display:none">${movcolVO.movie_no}</td><td>${movieSvc.getOneMovie(movcolVO.movie_no).moviename}</td>
											<td><fmt:formatDate value="${movcolVO.crt_dt}" pattern="yyyy-MM-dd HH:mm" /></td>
											<td><a href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=${movcolVO.movie_no}">電影頁面</a></td>
												<td><i class="fas fa-minus-circle delete-movcol"></i>
													<input name="movie_no" style="display: none" value="${movcolVO.movie_no}">
 												</td>
											</tr>
										</c:forEach>
									</table>
								</form>

							</div>			
						</div>	
						</section>
						<section id="articleCollection" class="tab-panel">
						<div class="container-fluid">
							<div class="row">
								<form method="post" class="col" id="articleCollection-info-form">
									<table class="table table-hover table-bordered">
										<tr><th>文章名稱</th><th>收藏時間</th><th>文章資訊</th><th>移除收藏</th></tr>
										<c:forEach var="artcolVO" items="${artcolSvc.getAllArticleCollection(memVO.member_no)}">
											<tr class="hover_artCol hover_pointer"><td style="display:none">${artcolVO.article_no}</td><td>${articleSvc.getOneArticle(artcolVO.article_no).articleheadline}</td>
											<td><fmt:formatDate value="${artcolVO.crt_dt}" pattern="yyyy-MM-dd HH:mm" /></td>
											<td><a href="<%=request.getContextPath()%>/front-end/article/listOneArticle2.jsp?articleno=${artcolVO.article_no}">文章頁面</a></td>
												<td><i class="fas fa-minus-circle delete-artcol"></i>
													<input name="article_no" style="display: none" value="${artcolVO.article_no}">
 												</td>
											</tr>
										</c:forEach>
									</table>
								</form>
<!-- 							<div class="col artcol_articleinfo"> -->

<!-- 							</div> -->
							</div>			
						</div>
							
						</section>
						<section id="movieRating" class="tab-panel">
						<div class="container-fluid">
							<div class="row">
							<form class="col" method="post" id="movieRating-info-form">
								<table id="ratingTable" class="table table-hover table-bordered">
									<tr><th>電影名稱</th><th>評分</th><th>移除收藏</th></tr>
										<c:forEach var="ratingVO" items="${ratingSvc.getAllRating(memVO.member_no)}">
										<tr class="hover_rating hover_pointer" id="show_movinfo_${ratingVO.movie_no}"><td style="display:none">${ratingVO.movie_no}</td>
										<td>${movieSvc.getOneMovie(ratingVO.movie_no).moviename}</td>
										<td>
										    	<i class="fas fa-star all-star" id="s1_${ratingVO.movie_no}"></i>
										    	<i class="fas fa-star all-star" id="s2_${ratingVO.movie_no}"></i>
										    	<i class="fas fa-star all-star" id="s3_${ratingVO.movie_no}"></i>
										    	<i class="fas fa-star all-star" id="s4_${ratingVO.movie_no}"></i>
										    	<i class="fas fa-star all-star" id="s5_${ratingVO.movie_no}"></i>
 										</td>
 										<td><i class="fas fa-minus-circle delete-rating"></i>
										<input name="movie_no" style="display: none" value="${ratingVO.movie_no}">
 										</td>
 										</tr>
										</c:forEach>
										
								</table>
							</form>

							</div>
						</div>
						</section>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="/front_footer_copy.jsp"/>
	</div>

 <div class="alert-container">
  </div>


<script src="https://cdnjs.cloudflare.com/ajax/libs/imask/3.4.0/imask.min.js"></script>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7a
<!-- bK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity=
"sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha
<!-- 384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.qrcode/1.0/jquery.qrcode.min.js"></script>


<script>





//訂單刪除紐
$(document.body).on("click", ".delete-order",function () { 
  	let thisOrder = $(this).parent().parent();
//   	console.log(thisOrder); //tr

      Swal.fire({
          title: "確認退票嗎?",
          text: "確定後將無法回復",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#d33",
          confirmButtonText: "確認",
          cancelButtonText: "取消",
      }).then((result) => {
          if (result.isConfirmed) {
        	let order_no = $(thisOrder.find("input")).val();
// 			console.log(order_no);
              $.ajax({
                  url: "<%=request.getContextPath()%>/order/order.do?action=delete_for_Ajax",
                  data: { "order_no": order_no
                  },
                  type: "POST",
                  success: function (msg) {
                  	if(msg == "success") {
                  		Swal.fire({
                              position: "center",
                              icon: "success",
                              title: "已退票",
                              showConfirmButton: false,
                              timer: 1000,
                          });
                  		thisOrder.remove();
                  	} else{
                  		Swal.fire({
                            position: "center",
                            icon: "fail",
                            title: "退票失敗請洽客服",
                            showConfirmButton: false,
                            timer: 1000,
                        });
                  	}
                  },
              });
          }
      });
  });

//移到歷史訂單
var switcher = "close";  //控制顯示"來訂票"
<c:forEach var="orderVO" items="${orderSvc.getAllOrderByMemno(memVO.member_no)}">
var showTime = parseInt((new Date('${showtimeSvc.getOneShowtime(orderVO.showtime_no).showtime_time}').getTime() / 1000).toFixed(0))
var now = Math.round(new Date()/1000);
var undue = $("tr.table-order");
var due = $("tr.table-history");
var fragment;
if(now>showTime||"${orderVO.order_status}"=="1"){
// 	if(switcher=="close"){
// 		undue.after(`<center><div>您目前沒有預訂任何電影票，快按<a href=/xxxxx>這裡</a>來訂票!</div></center>`)
// 		switcher="open";
// 	}
	$("#orderhistory_switch").css("display","none");
	due.css("display","");
	fragment = `<tr><td><fmt:formatDate value="${orderVO.crt_dt}" pattern="yyyy-MM-dd HH:mm" /> 
			    </td><td>` + "${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(orderVO.showtime_no).movie_no).moviename}" + 
			   `</td><td>` +  "${mapping.dboOrderStatus(orderVO.order_status)}" + `</td><td>` + "${mapping.dboOrderType(orderVO.payment_type)}" + 
			   `</td><td>`+ "${orderVO.total_price}" +
			   `</td><td><button type="button" class="btn btn-primary" id="show_orderBox_${orderVO.order_no}" >查看</button></td></tr>`
	due.after(fragment);
	
}else{
	$("#orderticket_switch").css("display","none");
	undue.css("display","");
	fragment = `<tr><td><fmt:formatDate value="${orderVO.crt_dt}" pattern="yyyy-MM-dd HH:mm" />
			    </td><td>` + "${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(orderVO.showtime_no).movie_no).moviename}" + 
			   `</td><td>` +  "${mapping.dboOrderStatus(orderVO.order_status)}" + `</td><td>` + "${mapping.dboOrderType(orderVO.payment_type)}" + 
			   `</td><td>`+ "${orderVO.total_price}" +
			   `</td><td><i class="fas fa-minus-circle delete-order"></i><input name="order_no" style="display: none" value=`+"${orderVO.order_no}"+
			   `></td><td><button type="button" class="btn btn-primary" id="show_orderBox_${orderVO.order_no}">查看</button></td></tr>`
	undue.after(fragment);
	switcher="open";
}

$("#show_orderBox_${orderVO.order_no}").click(function(){
	undue.before(fragment_${orderVO.order_no});
	$('#qrcode').qrcode({width: 200,height: 200,text: "www.google.com"});
	$(".cancelShow").click(function(){
		$("#order_box_${orderVO.order_no}").css("opacity", "0");
		$("#order_box_${orderVO.order_no}").css("z-index", "-1");
		setTimeout(function(){
  	  		$("#order_box_${orderVO.order_no}").remove();
  		}, 1000);
	})
})


var movie_name = "${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(orderVO.showtime_no).movie_no).moviename}";
var show_time = "${showtimeSvc.getOneShowtime(orderVO.showtime_no).showtime_time}";
var seat = "${orderVO.seat_name}";
var total_cost="${orderVO.total_price}";
var fragment_${orderVO.order_no}=
	`<div class="order_box" id="order_box_${orderVO.order_no}" style="opacity:1; z-index:99;">
	<div class="order_box_for_position">
		<table class="table table-hover table-bordered table-success border border-primary" style="text-align:center;">
		<button type="button" class="btn-close cancelShow" style="position:absolute; right:420px;"></button>
			<h1>訂單明細</h1>
			<tr><th>QR-Code: </th><td><div id="qrcode"></div></td></tr>
			<tr><th>電影名稱 : </th><td>`+ movie_name +`</td></tr>
			<tr><th>播映時間 : </th><td><fmt:formatDate value="${showtimeSvc.getOneShowtime(orderVO.showtime_no).showtime_time}" pattern="yyyy-MM-dd HH:mm" /></td></tr>
			<tr><th>票種 : </th><td>
				<table class="innerTable table-striped table-bordered">
				<c:forEach var="ordTicketTypeVO" items="${ordTicketTypeSvc.getAllTicketByOrderno(orderVO.order_no)}">
					<tr>
						<th>`+"${ticketTypeSvc.getOneTicket_type(ordTicketTypeVO.ticket_type_no).ticket_desc}"+`</th>
						<td>&ensp;X&ensp;`+"${ordTicketTypeVO.ticket_count}"+` 張 </td>
						<td> &emsp;共 `+"${ordTicketTypeVO.price}"+` 元 </td>
					</tr>
				</c:forEach>
				</table></td></tr>
			<tr><th>座位 : </th><td>`+seat+`</td></tr>
			<tr><th>餐點 : </th><td>
			<table class="innerTable table-striped table-bordered">
			<c:forEach var="ordFoodTypeVO" items="${ordFoodTypeSvc.getAllFoodByOrderno(orderVO.order_no)}">
				<tr>
					<th>`+"${foodSvc.getOneFood(ordFoodTypeVO.food_no).food_name}"+`</th>
					<td>&ensp;X&ensp;`+"${ordFoodTypeVO.food_count}"+` 份 </td>
					<td> &emsp;共 `+"${ordFoodTypeVO.price}"+` 元 </td>
				</tr>
			</c:forEach>
			</table></td></tr>
			<tr><th>總金額 : </th><td>`+total_cost+`</td></tr>
		</table>
	</div>
</div>`;

</c:forEach>
//------------------------------------------------------------------------------------------------------------------------
//列出主揪揪團資訊
<c:forEach var="groupVO" items="${groupSvc.getAllGroupByMemno(memVO.member_no)}">
var showTime = parseInt((new Date('${showtimeSvc.getOneShowtime(groupVO.showtime_no).showtime_time}').getTime() / 1000).toFixed(0))
var now = Math.round(new Date()/1000);
var master = $("tr.table-group-master");
var group_history = $("tr.table-group-history");
var master_switch = $("#group_master_switch");
var history_switch = $("#group_history");
var master_segment;

if(showTime>now&&("${groupVO.group_status}"=="0"||"${groupVO.group_status}"=="1")){
		master_switch.css("display","none");
		master.css("display","");
		master_segment= `<tr><td>` + "${groupVO.group_title}" + 
						`</td><td>` + "${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(groupVO.showtime_no).movie_no).moviename}" + 
						`</td><td><fmt:formatDate value="${showtimeSvc.getOneShowtime(groupVO.showtime_no).showtime_time}" pattern="yyyy-MM-dd HH:mm" />
						 </td><td>` + "${mapping.dboGroup_GroupStatus(groupVO.group_status)}" + 
						`</td><td>`+ "${groupVO.required_cnt}" +
						`</td><td>`+ "${groupVO.member_cnt}" +
						`</td><td><button type="button" class="btn btn-primary" id="show_masterBox_${groupVO.group_no}" >查看</button>
						 </td><td>
						 <form class="noCSS" METHOD="post" ACTION="<%=request.getContextPath()%>/GroupServlet">
						 <button type="submit" class="btn btn-primary">修改</button>
					     <input type="hidden" name="group_no"  value="${groupVO.group_no}">
					     <input type="hidden" name="action"	value="getOne_For_Update">
					     </form>
					     </td></tr>`
					     
		master.after(master_segment);
}else{
	    history_switch.css("display","none");
	    group_history.css("display","");
		master_segment= `<tr><td>` + "${groupVO.group_title}" + 
						`</td><td>` + "${memSvc.getOneMem(groupVO.member_no).mb_name}" + 
						`</td><td>` + "${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(groupVO.showtime_no).movie_no).moviename}" + 
						`</td><td><fmt:formatDate value="${showtimeSvc.getOneShowtime(groupVO.showtime_no).showtime_time}" pattern="yyyy-MM-dd HH:mm" />
						 </td><td>` + "${mapping.dboGroup_GroupStatus(groupVO.group_status)}" + 
						`</td><td>`+ "${mapping.dboGroup_Member_Status(groupMemSvc.getOneGroup_Member(groupVO.group_no,groupVO.member_no).status)}" +
						`</td><td><button type="button" class="btn btn-primary" id="show_masterBox_${groupVO.group_no}" >查看</button></td></tr>`
		group_history.after(master_segment);
}


$("#show_masterBox_${groupVO.group_no}").click(function(){
	master.before(master_segment_${groupVO.group_no});
	var memberNO;
	$(".reminder").click(function(){
		memberNO = $(this).find("input.memberNO").val();
		sendWebSocket($(this));
		console.log(memberNO)
		
		function sendWebSocket(item){
			let timespan = new Date();
			let timeStr = timespan.getFullYear() + "-" + (timespan.getMonth()+1).toString().padStart(2, "0") + "-" 
						+ timespan.getDate() + " " + timespan.getHours().toString().padStart(2, "0") + ":" + timespan.getMinutes().toString().padStart(2, "0");
			
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
	})
	$(".leaveUpdate").click(function(){
  		$("#master_box_${groupVO.group_no}").css("opacity", "0");
  		$("#master_box_${groupVO.group_no}").css("z-index", "-1");
  		setTimeout(function(){
  	  		$("#master_box_${groupVO.group_no}").remove();
  		}, 1000);
	})	
})

//列出主揪揪團詳細資訊
var master_segment_${groupVO.group_no}=
	`<div class="master_box" id="master_box_${groupVO.group_no}" style="opacity:1; z-index:99;">
	<div class="master_box_for_position detail_box">
		<table class="table table-hover table-bordered" style="text-align:center;">
		<button type="button" class="btn-close leaveUpdate" style="position:absolute; right:450px; top:250px;"></button>
			<h1>揪團明細</h1>
			<tr><th>揪團名稱 : </th><td>`+ "${groupVO.group_title}" +`</td></tr>
			<tr><th>電影名稱 : </th><td>`+ "${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(groupVO.showtime_no).movie_no).moviename}" +`</td></tr>
			<tr><th>播映時間 : </th><td><fmt:formatDate value="${showtimeSvc.getOneShowtime(groupVO.showtime_no).showtime_time}" pattern="yyyy-MM-dd HH:mm" /></td></tr>
			<tr><th>參加團員 : </th><td>
			<table class="innerTable">
				<c:forEach var="groupMemVO" items="${groupSvc.getMembersByGroupno(groupVO.group_no)}">
					<tr><td>`+"${memSvc.getOneMem(groupMemVO.member_no).mb_name}"+`</td><td>(`+"${mapping.dboGroup_Member_Pay_Status(groupMemVO.pay_status)}"+`)</td>
						<c:if test="${groupMemVO.pay_status == '0'}">
		            		<td><button type="button" class="btn-primary reminder" value="reminder">提醒<input type="hidden" class="memberNO"  value="${groupMemVO.member_no}"></button></td>
		        		</c:if>
					</tr>
				</c:forEach>
			</table>
				</td></tr>
			<tr><th>揪團說明 : </th><td>`+"${groupVO.desc}"+`</td></tr>
			<tr><th>創立揪團時間 : </th><td><fmt:formatDate value="${groupVO.crt_dt}" pattern="yyyy-MM-dd HH:mm" /></td></tr>
			<tr><th>揪團截止時間 : </th><td><fmt:formatDate value="${groupVO.deadline_dt}" pattern="yyyy-MM-dd HH:mm" /></td></tr>
			<tr><th>最後修改時間 : </th><td><fmt:formatDate value="${groupVO.modify_dt}" pattern="yyyy-MM-dd HH:mm" /></td></tr>
		</table>
	</div>
</div>`;

</c:forEach>
//列出揪團參與資訊
var switcher = true;
<c:forEach var="groupMemVO" items="${groupMemSvc.getGroups(memVO.member_no)}">
var showTime = parseInt((new Date('${showtimeSvc.getOneShowtime(groupSvc.getOneGroup(groupMemVO.group_no).showtime_no).showtime_time}').getTime() / 1000).toFixed(0))
var now = Math.round(new Date()/1000);
var group_history = $("tr.table-group-history");
var member = $("tr.table-group-member");
var member_switch = $("#group_member_switch");
var history_switch = $("#group_history");
var member_segment;

//先做判斷要把自己是團主的也濾掉因為在上面主揪資訊已經把過期的放到history理了這邊要濾掉才不會重複
//之後只有狀態是參加跟還未到開演時間會顯示在參加的團
//最後顯示已經過期跟曾經參加但又離開的團

if("${groupSvc.getOneGroup(groupMemVO.group_no).member_no}"=="${groupMemVO.member_no}"){

} else if("${groupMemVO.status}"=="1"&&showTime>now){
member_switch.css("display","none");
member.css("display","");
member_segment= `<tr><td>` + "${groupSvc.getOneGroup(groupMemVO.group_no).group_title}" + 
			    `</td><td>` + "${memSvc.getOneMem(groupSvc.getOneGroup(groupMemVO.group_no).member_no).mb_name}" + 
				`</td><td>` + "${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(groupSvc.getOneGroup(groupMemVO.group_no).showtime_no).movie_no).moviename}" + 
				`</td><td><fmt:formatDate value="${showtimeSvc.getOneShowtime(groupSvc.getOneGroup(groupMemVO.group_no).showtime_no).showtime_time}" pattern="yyyy-MM-dd HH:mm" /> 
				 </td><td>` + "${mapping.dboGroup_GroupStatus(groupSvc.getOneGroup(groupMemVO.group_no).group_status)}" + 
				`</td><td>` + "${mapping.dboGroup_Member_Pay_Status(groupMemVO.pay_status)}" + 
				`</td><td>`+ "${groupSvc.getOneGroup(groupMemVO.group_no).required_cnt}" +
				`</td><td>`+ "${groupSvc.getOneGroup(groupMemVO.group_no).member_cnt}" +
				`</td><td><button type="button" class="btn btn-primary" id="show_memberBox_${groupSvc.getOneGroup(groupMemVO.group_no).group_no}" >查看</button>
				 </td><td><i class="fas fa-minus-circle leave-group"></i>
				 <input name="group_no" style="display: none" value=`+"${groupMemVO.group_no}"+`>
				 <input name="deadline_dt" style="display: none" value=`+"${groupSvc.getOneGroup(groupMemVO.group_no).deadline_dt}"+`>
				 </td></tr>`

				 member.after(member_segment);
}else{

history_switch.css("display","none");
group_history.css("display","");
member_segment= `<tr><td>` + "${groupSvc.getOneGroup(groupMemVO.group_no).group_title}" + 
				`</td><td>` + "${memSvc.getOneMem(groupSvc.getOneGroup(groupMemVO.group_no).member_no).mb_name}" + 
				`</td><td>` + "${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(groupSvc.getOneGroup(groupMemVO.group_no).showtime_no).movie_no).moviename}" + 
				`</td><td><fmt:formatDate value="${showtimeSvc.getOneShowtime(groupSvc.getOneGroup(groupMemVO.group_no).showtime_no).showtime_time}" pattern="yyyy-MM-dd HH:mm" /> 
				 </td><td>` + "${mapping.dboGroup_GroupStatus(groupSvc.getOneGroup(groupMemVO.group_no).group_status)}" + 
				`</td><td>`+ "${mapping.dboGroup_Member_Status(groupMemSvc.getOneGroup_Member(groupSvc.getOneGroup(groupMemVO.group_no).group_no,groupSvc.getOneGroup(groupMemVO.group_no).member_no).status)}" +
				`</td><td><button type="button" class="btn btn-primary" id="show_memberBox_${groupSvc.getOneGroup(groupMemVO.group_no).group_no}" >查看</button></td></tr>`
group_history.after(member_segment);
	
}

//列出揪團詳細資訊
				$("#show_memberBox_${groupSvc.getOneGroup(groupMemVO.group_no).group_no}").click(function(){
					member.before(member_segment_${groupSvc.getOneGroup(groupMemVO.group_no).group_no});
					$(".leaveUpdate").click(function(){
				  		$("#member_box_${groupSvc.getOneGroup(groupMemVO.group_no).group_no}").css("opacity", "0");
				  		$("#member_box_${groupSvc.getOneGroup(groupMemVO.group_no).group_no}").css("z-index", "-1");
				  		setTimeout(function(){
				  	  		$("#member_box_${groupSvc.getOneGroup(groupMemVO.group_no).group_no}").remove();
				  		}, 1000);
					})	
				})
				var member_segment_${groupSvc.getOneGroup(groupMemVO.group_no).group_no}=
					`<div class="member_box" id="member_box_${groupSvc.getOneGroup(groupMemVO.group_no).group_no}" style="opacity:1; z-index:99;">
					<div class="member_box_for_position detail_box">
						<table class="table table-bordered table-hover" style="text-align:center;">
						<button type="button" class="btn-close leaveUpdate" style="position:absolute; right:420px;"></button>
							<h1>揪團明細</h1>
							<tr><th>揪團名稱 : </th><td>`+ "${groupSvc.getOneGroup(groupMemVO.group_no).group_title}" +`</td></tr>
							<tr><th>電影名稱 : </th><td>`+ "${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(groupSvc.getOneGroup(groupMemVO.group_no).showtime_no).movie_no).moviename}" +`</td></tr>
							<tr><th>播映時間 : </th><td><fmt:formatDate value="${showtimeSvc.getOneShowtime(groupSvc.getOneGroup(groupMemVO.group_no).showtime_no).showtime_time}" pattern="yyyy-MM-dd HH:mm" /> </td></tr>
							<tr><th>團主 : </th><td>`+ "${memSvc.getOneMem(groupSvc.getOneGroup(groupMemVO.group_no).member_no).mb_name}"+`</td></tr>
							<tr><th>參加團員 : </th><td>
								<table class="innerTable">
									<c:forEach var="groupMembersVO" items="${groupSvc.getMembersByGroupno(groupMemVO.group_no)}">
										<tr><td>`+"${memSvc.getOneMem(groupMembersVO.member_no).mb_name}"+`</td></tr>
									</c:forEach>
								</table>
							</td></tr> 
							<tr><th>揪團說明 : </th><td>`+"${groupSvc.getOneGroup(groupMemVO.group_no).desc}"+`</td></tr>
							<tr><th>創立揪團時間 : </th><td><fmt:formatDate value="${groupSvc.getOneGroup(groupMemVO.group_no).crt_dt}" pattern="yyyy-MM-dd HH:mm" /> </td></tr>
							<tr><th>揪團截止時間 : </th><td><fmt:formatDate value="${groupSvc.getOneGroup(groupMemVO.group_no).deadline_dt}" pattern="yyyy-MM-dd HH:mm" /> </td></tr>
							<tr><th>最後修改時間 : </th><td><fmt:formatDate value="${groupSvc.getOneGroup(groupMemVO.group_no).modify_dt}" pattern="yyyy-MM-dd HH:mm" /></td></tr>
						</table>
					</div>
				</div>`;
				
</c:forEach>

//團員退出揪團紐
$(document.body).on("click", ".leave-group",function () { 
  	let thisGroup = $(this).parent().parent();
  	var deadline_dt = parseInt((new Date($(thisGroup.find("input")[1]).val()).getTime() / 1000).toFixed(0));
  	var now = Math.round(new Date()/1000);
  	console.log(deadline_dt); //tr
  	console.log(now)
    if(deadline_dt>now){     //若過了deadline時間無法退出
      Swal.fire({
          title: "確認退出嗎?",
          text: "退出後將無法查看該揪團資訊",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#d33",
          confirmButtonText: "確認",
          cancelButtonText: "取消",
      }).then((result) => {
          if (result.isConfirmed) {
        	let group_no = $(thisGroup.find("input")[0]).val();
        	let member_no = "${memVO.member_no}";
// 			console.log(group_no);
              $.ajax({
                  url: "<%=request.getContextPath()%>/Group_MemberServlet?action=leave_group_for_Ajax",
                  data: { "group_no": group_no,
                	  	  "member_no":member_no
                  },
                  type: "POST",
                  success: function (msg) {
                  	if(msg == "success") {
                  		Swal.fire({
                              position: "center",
                              icon: "success",
                              title: "已退出揪團",
                              showConfirmButton: false,
                              timer: 1000,
                          });
                  		thisGroup.remove();
                  	} else{
                  		Swal.fire({
                            position: "center",
                            icon: "fail",
                            title: "退出失敗請洽客服",
                            showConfirmButton: false,
                            timer: 1000,
                        });
                  	}
                  },
              });
          }
      });
    }else{
    	Swal.fire({
            position: "center",
            icon: "fail",
            title: "已過揪團截止時間無法退出",
            showConfirmButton: false,
            timer: 1000,
        });
    }
      
  });
//------------------------------------------------------------------------------------------------------------------------
//通知

$(document).ready(function(){
	var notify_friend = $("tr.table-friend");
	var notify_group = $("tr.table-group");
	var notify_ticket = $("tr.table-ticket");
	var memberno = ${memVO.member_no};
	var slice_addFriend;
	var slice_response;
	var slice_addGroup;
	var slice_createGroup;
	var slice_dismissGroup;
	var slice_kickUnpaid;
	var slice_kickoffGroup;
	var slice_buyTicket;
	var slice_reminder;
	 $.ajax({
		 url:"<%=request.getContextPath()%>/NotifyServlet?action=insert_For_Ajax",
		 data:{
			 "member_no":memberno
		 },
		 type:"POST",
		 success:function(json){
			 let jsonobj = JSON.parse(json);
			 let all_list = jsonobj.all;
			 let len = jsonobj.all.length;
			 for(let i = 0 ; i < len ; i++){
				 let jsono = JSON.parse(all_list[i]);
				 
				 if(jsono.type==="addFriend"){
					 if(jsono.sender=="${memVO.member_no}"){
						 slice_addFriend += `<tr><td>`+jsono.time+`</td><td>` + jsono.message + `</td></tr>`;
					 }else{
						 <c:forEach var="relationVO" items="${memSvc.getRelationshipsByMemberno(memVO.member_no)}">
						 if(jsono.sender=="${relationVO.friend_no}"){
							 slice_addFriend += `<tr><td>`+jsono.time+`</td><td>` + jsono.message + `</td></tr>`;  
							 //設定如果已經是好友就不會出現下面的按鈕訊息，而是出現純受邀請的訊息(未測試)
						 }
						 </c:forEach>
						 else{
							 slice_addFriend += `<tr><td>`+jsono.time+`</td><td>` + jsono.message + `</td><td><button type="button" class="addfriend_check_btn_Yes btn-primary" value=1>確定</button> &emsp;&emsp; <button type="button" class="addfriend_check_btn_No btn-primary" value=0>拒絕</button></td><td class="friendNO" style="display:none;">`+jsono.sender+`</td></tr>`;
						 }	
						
					 }	
				 }
				 if(jsono.type==="response"){
					 slice_response += `<tr><td>`+jsono.time+`</td><td>` + jsono.message + `</td></tr>`;
				 }
				 if(jsono.type==="addGroup"){
					 slice_addGroup += `<tr><td>`+jsono.time+`</td><td>` + jsono.message + `</td></tr>`;
				 }
				 if(jsono.type==="createGroup"){
					 slice_createGroup += `<tr><td>`+jsono.time+`</td><td>` + jsono.message + `</td></tr>`;
				 }
				 if(jsono.type==="dismissGroup"){
					 slice_dismissGroup += `<tr><td>`+jsono.time+`</td><td>` + jsono.message + `</td></tr>`;
				 }
				 if(jsono.type==="kickUnpaid"){
					 slice_kickUnpaid += `<tr><td>`+jsono.time+`</td><td>` + jsono.message + `</td></tr>`;
				 }
				 if(jsono.type==="kickoffGroup"){
					 slice_kickoffGroup += `<tr><td>`+jsono.time+`</td><td>` + jsono.message + `</td></tr>`;
				 }
				 if(jsono.type==="buyTicket"){
					 slice_buyTicket += `<tr><td>`+jsono.time+`</td><td>` + jsono.message + `</td></tr>`;
				 }
				 if(jsono.type==="reminder"){
					 slice_reminder += `<tr><td>`+jsono.time+`</td><td>` + jsono.message + `</td></tr>`;
				 }
				 
				 		    
			 }
			 notify_friend.after(slice_addFriend); 
			 $(".addfriend_check_btn_Yes").click(function(){ //記得要slice這行生成後註冊btn才有用		
				$(this).parent().parent().remove();
				Swal.fire({
                    position: "center",
                    icon: "success",
                    title: "已加入好友",
                    showConfirmButton: false,
                    timer: 1000,
                });
				friendNO = $(this).parent().next().text();
				sendWebSocket($(this));
				function sendWebSocket(item){
					let timespan = new Date();
					let timeStr = timespan.getFullYear() + "-" + (timespan.getMonth()+1).toString().padStart(2, "0") + "-" 
								+ timespan.getDate() + " " + timespan.getHours().toString().padStart(2, "0") + ":" + timespan.getMinutes().toString().padStart(2, "0");
					if(item.val()==1){
						var jsonObj = {
							"type" : "response",
							"sender" : self,
							"receiver" : friendNO,
							"message":"",
							"time":timeStr
						};
					}
					webSocket.send(JSON.stringify(jsonObj));
				}			
				//這邊放入insertFriend的ajax
			})
			$(".addfriend_check_btn_No").click(function(){ //記得要slice這行生成後註冊btn才有用		
				$(this).parent().parent().remove();	
			})
			
			 notify_friend.after(slice_response); 
			 notify_group.after(slice_addGroup); 
			 notify_group.after(slice_createGroup); 
			 notify_group.after(slice_dismissGroup); 
			 notify_group.after(slice_kickUnpaid); 
			 notify_group.after(slice_kickoffGroup); 
			 notify_ticket.after(slice_buyTicket); 
			 notify_ticket.after(slice_reminder); 
		 }
	
	
		})

});


  
//-------------------------------------------------------------------------------------------------------------------------
//評論顯示視窗
$(document).ready(function(){
	if("2"==="${memVO.mb_level}"){
		let contain = document.getElementById("show_comment");
		contain.style.display="";
	}else{
		let contain = document.createElement("div");
		contain.classList.add("container-fluid");
		contain.style.position="absolute";
		contain.style.top="50%";
		contain.style.left="33%";
		let row = document.createElement("div");
		row.classList.add("row");
		row.innerHTML=`<div style="">您尚未是專職影評，可點擊<a class="apply_commenter">這裡</a>申請成為專職影評</div>`;
		contain.append(row);
		$("#comment").append(contain);
		
		$(".apply_commenter").click(function(){
			Swal.fire({
	            position: "center",
	            icon: "success",
	            title: "已將申請送出，管理者會依您在本網站的活躍程度來評斷您是否可成為專職影評，請靜候通知，謝謝!",
	            showConfirmButton: false,
	            timer: 3000,
	        });
			
			row.innerHTML=`<div style="">已申請專職影評請靜候回復，謝謝</div>`;
			
		})
	
	
	}
	
	
});

//評論秀出修改box
<c:forEach var="commVO" items="${commSvc.getComments(memVO.member_no)}">
$("#show_commBox_${commVO.commentno}").click(function(){
	$("#comment_box_${commVO.commentno}").css("opacity", "1");
  	$("#comment_box_${commVO.commentno}").css("z-index", "99");
  	$(".leaveComment").click(()=>{
  		$("#comment_box_${commVO.commentno}").css("opacity", "0");
  		$("#comment_box_${commVO.commentno}").css("z-index", "-1");
  	})
  	$(".cancelUpdate").click(()=>{
  		$("#comment_box_${commVO.commentno}").css("opacity", "0");
  		$("#comment_box_${commVO.commentno}").css("z-index", "-1");
  		$(".enterComment").css("display","");
  		$(".leaveComment").css("display","");
  		$(".updateComment").css("display","none");
  		$(".cancelUpdate").css("display","none");
  		$("textarea").prop("disabled", true);
  	})
})
</c:forEach>

//評論按鈕出現/消失
$(document).ready(function(){
	$(".enterComment").click(function(){
		showButton($(this));
	});
})

//評論視窗修改
function showButton(target){
	target.css("display","none");
	target.parent().siblings().find(".leaveComment").css("display","none");
	$(target.parent().siblings(".cardBtn")[1]).find(".updateComment").css("display","");
	$(target.parent().siblings(".cardBtn")[2]).find(".cancelUpdate").css("display","");
	target.parent().prev().prop("disabled",false);
	
	<c:forEach var="commVO" items="${commSvc.getComments(memVO.member_no)}">
	$("#updateComment_${commVO.commentno}").click(function(){
// 		e.preventDefault();
		var textarea;
		var comment_no = "${commVO.commentno}";
		 textarea=$("#comment_content_${commVO.commentno}").val();
		 console.log(textarea);
		 $.ajax({
			 url:"<%=request.getContextPath()%>/comment/comment.do?action=getOne_For_Display_Ajax",
			 data:{
				 "comment_no":comment_no,
				 "comment_content":textarea	
			 },
			 type:"POST",
			 success:function(msg){
				 if(msg=="success"){
					 Swal.fire({
	                      position: "center",
	                      icon: "success",
	                      title: "已更新評論",
	                      showConfirmButton: false,
	                      timer: 1000,
	                  }); 
					 $("#comment_box_${commVO.commentno}").css("opacity", "0");
				  	 $("#comment_box_${commVO.commentno}").css("z-index", "-1");
					 $(".enterComment").css("display","");
				  	 $(".leaveComment").css("display","");
				  	 $(".updateComment").css("display","none");
				  	 $(".cancelUpdate").css("display","none");
				  	 $("textarea").prop("disabled", true);

				 }else{
					 Swal.fire({
	                      position: "center",
	                      icon: "error",
	                      title: "更新失敗，請稍後再試",
	                      showConfirmButton: false,
	                      timer: 1000,
	                  });
					 $("#comment_box_${commVO.commentno}").css("opacity", "0");
				  	 $("#comment_box_${commVO.commentno}").css("z-index", "-1");
					 $(".enterComment").css("display","");
				  	 $(".leaveComment").css("display","");
				  	 $(".updateComment").css("display","none");
				  	 $(".cancelUpdate").css("display","none");
				  	 $("textarea").prop("disabled", true);
					 
				 }
				 
				 
			 }
		 })

	})
	</c:forEach>
}

//評論刪除紐
$(document.body).on("click", ".delete-comm",function () { 
  	let thisComm = $(this).parent().parent();
//   	console.log(thisComm); //tr

      Swal.fire({
          title: "確認刪除嗎?",
          text: "刪除後將無法返回資料",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#d33",
          confirmButtonText: "確認",
          cancelButtonText: "取消",
      }).then((result) => {
          if (result.isConfirmed) {
        	let comment_no = $(thisComm.find("input")[1]).val();
// 			console.log(comment_no);
              $.ajax({
                  url: "<%=request.getContextPath()%>/comment/comment.do?action=delete_for_Ajax",
                  data: { "comment_no": comment_no
                  },
                  type: "POST",
                  success: function (msg) {
                  	if(msg == "success") {
                  		Swal.fire({
                              position: "center",
                              icon: "success",
                              title: "已移除評論",
                              showConfirmButton: false,
                              timer: 1000,
                          });
                  		thisComm.remove();
                  	} else{
                  		Swal.fire({
                            position: "center",
                            icon: "error",
                            title: "刪除失敗請洽客服",
                            showConfirmButton: false,
                            timer: 1000,
                        });
                  	}
                  },
              });
          }
      });
  });

//--------------------------------------------------------------------------------------------------------
//電影收藏刪除紐
$(document.body).on("click", ".delete-movcol",function () { 
  	let thisMovCol = $(this).parent().parent();
//   	console.log(thisMovCol); //tr

      Swal.fire({
          title: "確認刪除嗎?",
          text: "刪除後將無法返回資料",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#d33",
          confirmButtonText: "確認",
          cancelButtonText: "取消",
      }).then((result) => {
          if (result.isConfirmed) {
        	let movie_no = thisMovCol.find("input").val();
        	let member_no = "${memVO.member_no}"; 
			console.log(member_no);
              $.ajax({
                  url: "<%=request.getContextPath()%>/MovieCollectionServlet?action=delete",
                  data: { "member_no": member_no,
                		  "movie_no" : movie_no 
                  },
                  type: "POST",
                  success: function (msg) {
                  	if(msg == "success") {
                  		Swal.fire({
                              position: "center",
                              icon: "success",
                              title: "已移除收藏",
                              showConfirmButton: false,
                              timer: 1000,
                          });
                  		thisMovCol.remove();
                  	} else{
                  		Swal.fire({
                            position: "center",
                            icon: "fail",
                            title: "刪除失敗請洽客服",
                            showConfirmButton: false,
                            timer: 1000,
                        });
                  	}
                  },
              });
          }
      });
  });
  


//---------------------------------------------------------------------------------------------------------
//文章收藏刪除紐
$(document.body).on("click", ".delete-artcol",function () { 
  	let thisArtCol = $(this).parent().parent();
//   	console.log(thisArtCol); //tr

      Swal.fire({
          title: "確認刪除嗎?",
          text: "刪除後將無法返回資料",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#d33",
          confirmButtonText: "確認",
          cancelButtonText: "取消",
      }).then((result) => {
          if (result.isConfirmed) {
        	let article_no = thisArtCol.find("input").val();
        	let member_no = "${memVO.member_no}"; 
              $.ajax({
                  url: "<%=request.getContextPath()%>/ArticleCollectionServlet?action=delete",
                  data: { "member_no": member_no,
                		  "article_no" : article_no 
                  },
                  type: "POST",
                  success: function (msg) {
                  	if(msg == "success") {
                  		Swal.fire({
                              position: "center",
                              icon: "success",
                              title: "已移除收藏",
                              showConfirmButton: false,
                              timer: 1000,
                          });
                  		thisArtCol.remove();
                  	} else{
                  		Swal.fire({
                            position: "center",
                            icon: "fail",
                            title: "刪除失敗請洽客服",
                            showConfirmButton: false,
                            timer: 1000,
                        });
                  	}
                  },
              });
          }
      });
  });
  
// $(".hover_artCol").hover(function(){
// 	let article_no = $($(this).find('td')[0]).text(); //$(this).find('td')[0]是DOM物件不能用jquery的text()，因此要再加上$()轉乘jquery物件
// 	console.log(article_no);
// 	$.ajax({
<%-- 		url: "<%=request.getContextPath()%>/ArticleServlet?action=getOne_For_Display_Ajax", --%>
// 		data:{"article_no":article_no},
// 		type:"POST",
// 		success:function(json){
// 			let jsonobj = JSON.parse(json);
// 			let content = jsonobj.content;
// 			let author = jsonobj.author;
// 			let title = jsonobj.title;
// 			let likecount = jsonobj.likecount;
// 			let fragment = document.createElement("div");
// 			fragment.classList.add("article_info");
// 			fragment.innerHTML = `
//                 <table class="table-primary" style="font-size:15px;"><tr><th>文章</th><td>` 
//                 + title + `</td></tr><tr><th>作者</th><td>` 
//                 + author + `</td></tr><tr><th>內文 </th><td>` 
//                 + content+`</td></tr><tr><th>讚數</th><td>` 
//                 + likecount + `</td></tr></table>`
//         $(".artcol_articleinfo").append(fragment);
// 		$(".artcol_articleinfo").css("background-color","aliceblue");
//         $(".artcol_articleinfo").css("border-radius","50px");

// 		}
// 	})
// },function(){
//  $(this).closest('form').siblings().children().remove();
//  $(".artcol_articleinfo").css("background-color","");
//  $(".artcol_articleinfo").css("border-radius","");

// })
  
//-------------------------------------------------------------------------------------------------------
//星星刪除紐
$(document.body).on("click", ".delete-rating",function () { 
  	let thisRating = $(this).parent().parent();
//   	console.log(thisRating);//tr

      Swal.fire({
          title: "確認刪除嗎?",
          text: "刪除後將無法返回資料",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#d33",
          confirmButtonText: "確認",
          cancelButtonText: "取消",
      }).then((result) => {
          if (result.isConfirmed) {
        	let movie_no = thisRating.find("input").val();
        	let member_no = "${memVO.member_no}";

              $.ajax({
                  url: "<%=request.getContextPath()%>/MovieRatingServlet?action=delete_rating",
                  data: { "member_no": member_no,
                		  "movie_no" : movie_no 
                  },
                  type: "POST",
                  success: function (msg) {
                  	if(msg == "success") {
                  		Swal.fire({
                              position: "center",
                              icon: "success",
                              title: "已移除評分",
                              showConfirmButton: false,
                              timer: 1000,
                          });
                  		thisRating.remove();
                  	} else{
                  		Swal.fire({
                            position: "center",
                            icon: "fail",
                            title: "刪除失敗請洽客服",
                            showConfirmButton: false,
                            timer: 1000,
                        });
                  	}
                  },
              });
          }
      });
  });
  
//星星取值  
$(document).ready(function(){
//滑鼠掃過會亮，但現在卡在會亮一整排	
// 	  var n = $('i').length;
// 	  var index;
// 	  $("i").mouseenter(function(){
// 	  index = $(this).index();
//       for(var i = 0; i <= index+1; i++) {
//         $('i:nth-child(' + i + ')').css('color', '#F0AD4E');
//     }
// 	  })
	  
// 	   $("i").mouseleave(function(){
// 	  for(var j = index+2; j <= n+1 ; j++){
//   	  $('i:nth-child(' + j + ')').css('color', 'black');
//     }
// 	  })
	  
	  
	<c:forEach var="ratingVO" items="${ratingSvc.getAllRating(memVO.member_no)}">
	  $("#s1_${ratingVO.movie_no}").click(function(e){
	   $("#s1_${ratingVO.movie_no},#s2_${ratingVO.movie_no},#s3_${ratingVO.movie_no},#s4_${ratingVO.movie_no},#s5_${ratingVO.movie_no}").css("color","black");
	   $("#s1_${ratingVO.movie_no}").css("color","#F0AD4E");
	   $("#s1_${ratingVO.movie_no}").val("1.0");
	   
	   let member_no = "${memVO.member_no}";
	   let movie_no = "${ratingVO.movie_no}";
	   let rating = $("#s1_${ratingVO.movie_no}").val();
	   $.ajax({
		   url:"<%=request.getContextPath()%>/MovieRatingServlet?action=update",
		   data:{
			   "member_no":member_no,
			   "movie_no":movie_no,
			   "rating":rating
		   },
		   type:"POST",
		   success:function(msg){
			   updateRating(msg);
		   }
	   })
	  })
	  $("#s2_${ratingVO.movie_no}").click(function(){
	   $("#s1_${ratingVO.movie_no},#s2_${ratingVO.movie_no},#s3_${ratingVO.movie_no},#s4_${ratingVO.movie_no},#s5_${ratingVO.movie_no}").css("color","black");
	   $("#s1_${ratingVO.movie_no},#s2_${ratingVO.movie_no}").css("color","#F0AD4E");
	   $("#s2_${ratingVO.movie_no}").val("2.0");
	   let member_no = "${memVO.member_no}";
	   let movie_no = "${ratingVO.movie_no}";
	   let rating = $("#s2_${ratingVO.movie_no}").val();
	   $.ajax({
		   url:"<%=request.getContextPath()%>/MovieRatingServlet?action=update",
		   data:{
			   "member_no":member_no,
			   "movie_no":movie_no,
			   "rating":rating
		   },
		   type:"POST",
		   success:function(msg){
			   updateRating(msg);
		   }
		   
	   })
	  })
	  $("#s3_${ratingVO.movie_no}").click(function(){
	   $("#s1_${ratingVO.movie_no},#s2_${ratingVO.movie_no},#s3_${ratingVO.movie_no},#s4_${ratingVO.movie_no},#s5_${ratingVO.movie_no}").css("color","black");
	   $("#s1_${ratingVO.movie_no},#s2_${ratingVO.movie_no},#s3_${ratingVO.movie_no}").css("color","#F0AD4E");
	   $("#s3_${ratingVO.movie_no}").val("3.0");
	   let member_no = "${memVO.member_no}";
	   let movie_no = "${ratingVO.movie_no}";
	   let rating = $("#s3_${ratingVO.movie_no}").val();
	   $.ajax({
		   url:"<%=request.getContextPath()%>/MovieRatingServlet?action=update",
		   data:{
			   "member_no":member_no,
			   "movie_no":movie_no,
			   "rating":rating
		   },
		   type:"POST",
		   success:function(msg){
			   updateRating(msg);
		   }
		   
	   })
	  })
	  $("#s4_${ratingVO.movie_no}").click(function(){
	   $("#s1_${ratingVO.movie_no},#s2_${ratingVO.movie_no},#s3_${ratingVO.movie_no},#s4_${ratingVO.movie_no},#s5_${ratingVO.movie_no}").css("color","black");
	   $("#s1_${ratingVO.movie_no},#s2_${ratingVO.movie_no},#s3_${ratingVO.movie_no},#s4_${ratingVO.movie_no}").css("color","#F0AD4E");
	   $("#s4_${ratingVO.movie_no}").val("4.0");
	   let member_no = "${memVO.member_no}";
	   let movie_no = "${ratingVO.movie_no}";
	   let rating = $("#s4_${ratingVO.movie_no}").val();
	   $.ajax({
		   url:"<%=request.getContextPath()%>/MovieRatingServlet?action=update",
		   data:{
			   "member_no":member_no,
			   "movie_no":movie_no,
			   "rating":rating
		   },
		   type:"POST",
		   success:function(msg){
			   updateRating(msg);
		   }
		   
	   })
	  })
	  $("#s5_${ratingVO.movie_no}").click(function(){
	   $("#s1_${ratingVO.movie_no},#s2_${ratingVO.movie_no},#s3_${ratingVO.movie_no},#s4_${ratingVO.movie_no},#s5_${ratingVO.movie_no}").css("color","black");
	   $("#s1_${ratingVO.movie_no},#s2_${ratingVO.movie_no},#s3_${ratingVO.movie_no},#s4_${ratingVO.movie_no},#s5_${ratingVO.movie_no}").css("color","#F0AD4E");
	   $("#s5_${ratingVO.movie_no}").val("5.0");
	   let member_no = "${memVO.member_no}";
	   let movie_no = "${ratingVO.movie_no}";
	   let rating = $("#s5_${ratingVO.movie_no}").val();
	   $.ajax({
		   url:"<%=request.getContextPath()%>/MovieRatingServlet?action=update",
		   data:{
			   "member_no":member_no,
			   "movie_no":movie_no,
			   "rating":rating
		   },
		   type:"POST",
		   success:function(msg){
			   updateRating(msg);
		   }
		   
	   })
	  })
	  </c:forEach>
	  
	  function updateRating(msg){

		  if(msg == "success") {
        		Swal.fire({
                    position: "center",
                    icon: "success",
                    title: "已更新評分",
                    showConfirmButton: false,
                    timer: 1000,
                });
        	}else{
        		Swal.fire({
                    position: "center",
                    icon: "fail",
                    title: "評分更新失敗",
                    showConfirmButton: false,
                    timer: 1000,
                });

        	}
	  }
	  
	 })
  
  

//一開始讓星星亮
function starbling(){
	var rating;
	<c:forEach var="ratingVO" items="${ratingSvc.getAllRating(memVO.member_no)}">
		rating=${ratingVO.rating};
		var s1 = document.getElementById('s1_${ratingVO.movie_no}');
		var s2 = document.getElementById('s2_${ratingVO.movie_no}');
		var s3 = document.getElementById('s3_${ratingVO.movie_no}');
		var s4 = document.getElementById('s4_${ratingVO.movie_no}');
		var s5 = document.getElementById('s5_${ratingVO.movie_no}');

		switch(rating){
			case 1.0:
				s1.style['color']="#F0AD4E";
				break;
			case 2.0:
				s1.style['color']="#F0AD4E";s2.style['color']="#F0AD4E";
				break;
			case 3.0:
				s1.style['color']="#F0AD4E";s2.style['color']="#F0AD4E";s3.style['color']="#F0AD4E";
				break;
			case 4.0:
				s1.style['color']="#F0AD4E";s2.style['color']="#F0AD4E";s3.style['color']="#F0AD4E";s4.style['color']="#F0AD4E";
				break;
			case 5.0:
				s1.style['color']="#F0AD4E";s2.style['color']="#F0AD4E";s3.style['color']="#F0AD4E";s4.style['color']="#F0AD4E";s5.style['color']="#F0AD4E";
				break;
			default:
				s1.style['color']="black";s2.style['color']="black";s3.style['color']="black";s4.style['color']="black";s5.style['color']="black";
		}
	</c:forEach>
}


// //移到星星出現電影資訊

// $(".hover_rating").hover(function(){
// 	let movie_no = $($(this).find('td')[0]).text(); //$(this).find('td')[0]是DOM物件不能用jquery的text()，因此要再加上$()轉乘jquery物件
// 	$.ajax({
<%-- 		url: "<%=request.getContextPath()%>/MovieServlet?action=getOne_For_Display_Ajax", --%>
// 		data:{"movieno":movie_no},
// 		type:"POST",
// 		success:function(json){
// 			let jsonobj = JSON.parse(json);
// 			let allRating = jsonobj.allRating;
// 			let allComment = jsonobj.allComment;
// 			let fragment = document.createElement("div");
// 				fragment.classList.add("movie_info");
// 			let slice = `
// 					<div class="hover_box">
// 					  <div>
// 					    <div>
<%-- 					      <img src="<%=request.getContextPath()%>/DBGifReader1?movieno=`+movie_no+`"style="margin:auto; display:block;"class="rating_mov_pic" alt="..."> --%>
// 					    </div>
// 					  </div>
// 					</div>
//                     <table class="hover_table table-info" cellpadding="10" border='1'><tr><th style="width:60px;"> 評分 </th><td>` + allRating + `</td></tr>
//                     <tr><th> 影評 </th></tr>`;
//                     slice += allComment.map(comment => `<tr><th>`+comment.mb_name+`</th><td>` + comment.content + `</td></tr>`).join("");
//                     slice += `</table>`;
//                     fragment.innerHTML = slice;
//             $(".rating_movinfo").append(fragment);
//             $(".rating_movinfo").css("background-color","aliceblue");
//             $(".rating_movinfo").css("border-radius","50px");
			
// 		}
// 	})
// },function(){

// 	 $(this).closest('form').siblings().children().remove();
// 	 $(".rating_movinfo").css("background-color","");
//      $(".rating_movinfo").css("border-radius","");

// })

// $(".hover_pointer").mouseleave() why 不能用mouseenter/mouseleave


</script>
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
	var activeDismissGroupNO;


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
	$(".activeDissmissGroup").click(function(){
		dismissGroupNO = $(this).find("input.dismissGroupNO").val();
		sendWebSocket($(this));
	})
	$(".Group").click(function(){
		kickGroupName = $(this).find("input.kickGroupName").val();
		sendWebSocket($(this));
	})
	$(".reminder").click(function(){
		memberNO = $(this).find("input.memberNO").val();
		sendWebSocket($(this));

	})
	$(".activeDismissGroup").click(function(){
		activeDismissGroupNO = $(this).find("input.activeDismissGroupNO").val();
		sendWebSocket($(this));
	})
	
	
	function sendWebSocket(item){
		let timespan = new Date();
		let timeStr = timespan.getFullYear() + "-" + (timespan.getMonth()+1).toString().padStart(2, "0") + "-" 
					+ timespan.getDate() + " " + timespan.getHours().toString().padStart(2, "0") + ":" + timespan.getMinutes().toString().padStart(2, "0");
		if(item.hasClass("addFriend")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : friendNO,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("addGroup")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : groupNO,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("buyTicket")){
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
		if(item.hasClass("createGroup")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : groupName,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("goGroup")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : goGroupName,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("kickoffGroup")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : kickGroupName,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("reminder")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : memberNO,
				"message":"",
				"time":timeStr
			};
		}
		if(item.hasClass("activeDismissGroup")){
			type = item.val();
			var jsonObj = {
				"type" : type,
				"sender" : self,
				"receiver" : activeDismissGroupNO,
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
	  if (type==="addGroup"||type==="createGroup"||type==="goGroup"||type==="activeDismissGroup"){
			img.src="<%=request.getContextPath()%>/images/notify_icons/group.png"
	  }
	  if (type==="buyTicket"){
			img.src="<%=request.getContextPath()%>/images/notify_icons/ticket.png"
	  }
	  if (type==="reminder"||type==="dismissGroup"||type==="kickoffGroup"||type==="kickUnpaid"){
			img.src="<%=request.getContextPath()%>/images/notify_icons/warning.png"
	  }
	  
		  img.classList.add("alertImg");
		  imgdiv.append(img);
		  txt.innerText = text;
		  txt.classList.add("alertTxt");
		  time_str.innerText = time;
		  time_str.classList.add("alertTime");
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