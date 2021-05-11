<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page import="com.movieRating.model.*"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<%@ page import="com.mem.model.*"%>
<%@ page import="com.articleCollection.model.*"%>
<%
	MemVO memVO = (MemVO)session.getAttribute("memVO");
	ArticleCollectionVO artcolVO = (ArticleCollectionVO)request.getAttribute("artcolVO");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/front/memberSys.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<title>Insert title here</title>
<style>
hr{
	border: 5px solid black;
}
.body{
	font-size:5px;
}

.order_box {
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
.order_box_for_position{
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
.info-content .tab-panel #comment-info-form, #ticket-info-form, #group-info-form{
	width:100%;
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
</style>
</head>
<body>
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
								<table class="table table-hover table-order">								
									 <tr class="table-order" style="display:none;"><th>購票日期</th><th>電影名稱</th><th>狀態</th><th>付款方式</th><th>金額</th><th>退票</th><th>詳細資訊</th></tr>
								</table>
								<br>
								<hr class="table-order"/>
								<h1 class="table-history">購票紀錄</h1>
								<table class="table table-hover table-history">								
									 <tr class="table-history" style="display:none;"><th>購票日期</th><th>電影名稱</th><th>狀態</th><th>付款方式</th><th>金額</th><th>詳細資訊</th></tr>
									 
								</table>
							</form>
						</div>
					</div>
						</section>

						<section id="group" class="tab-panel">
						22222
							<form method="post" id="group-info-form">
							
							</form>
						</section>

						<section id="notify" class="tab-panel">
						33333
							<form method="post" id="notify-info-form">
							</form>
						</section>

						<section id="comment" class="tab-panel">
							<div id="show_comment" class="container-fluid" style="display:none">
								<div class="row">
									<form method="post" id="comment-info-form">
									 	<table class="table table-hover">
									 	<tr><th>發表日期</th><th>電影名稱</th><th></th><th></th></tr>
										 	<c:forEach var="commVO" items="${commSvc.getComments(memVO.member_no)}">
												<tr class="hover_comm hover_pointer"><td style="display:none">${commVO.movieno}</td><td>${commVO.creatdate}</td>
											<td>${movieSvc.getOneMovie(commVO.movieno).moviename}</td>
											<td><button type="button" class="btn btn-info" id="show_commBox_${commVO.commentno}">查看</button></td>
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
								<table class="table table-hover">
										<tr><th>電影名稱</th><th>收藏時間</th><th></th><th></th></tr>
										<c:forEach var="movcolVO" items="${movcolSvc.getAllMovieCollection(memVO.member_no)}">
											<tr class="hover_movCol hover_pointer"><td style="display:none">${movcolVO.movie_no}</td><td>${movieSvc.getOneMovie(movcolVO.movie_no).moviename}</td>
											<td>${movcolVO.crt_dt}</td>
											<td><a href="xxxx">電影資訊</a></td>
												<td><i class="fas fa-minus-circle delete-movcol"></i>
													<input name="movie_no" style="display: none" value="${movcolVO.movie_no}">
 												</td>
											</tr>
										</c:forEach>
									</table>
								</form>
								<div class="col movcol_movieinfo">

								</div>
							</div>			
						</div>	
						</section>
						<section id="articleCollection" class="tab-panel">
						<div class="container-fluid">
							<div class="row">
								<form method="post" class="col" id="articleCollection-info-form">
									<table class="table table-hover">
										<tr><th>文章名稱</th><th>收藏時間</th><th></th><th></th></tr>
										<c:forEach var="artcolVO" items="${artcolSvc.getAllArticleCollection(memVO.member_no)}">
											<tr class="hover_artCol hover_pointer"><td style="display:none">${artcolVO.article_no}</td><td>${articleSvc.getOneArticle(artcolVO.article_no).articleheadline}</td>
											<td>${artcolVO.crt_dt}</td>
											<td><a href="xxxx">文章</a></td>
												<td><i class="fas fa-minus-circle delete-artcol"></i>
													<input name="article_no" style="display: none" value="${artcolVO.article_no}">
 												</td>
											</tr>
										</c:forEach>
									</table>
								</form>
							<div class="col artcol_articleinfo">

							</div>
							</div>			
						</div>
							
						</section>
						<section id="movieRating" class="tab-panel">
						<div class="container-fluid">
							<div class="row">
							<form class="col" method="post" id="movieRating-info-form">
								<table id="ratingTable" class="table table-hover">
									<tr><th>電影名稱</th><th>評分</th><th></th></tr>
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
							<div class="col rating_movinfo">

							</div>
							</div>
						</div>
						</section>
					</div>
				</div>
			</div>
		</div>
	</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/imask/3.4.0/imask.min.js"></script>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7a
bK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity=
"sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha
384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script>

		
//訂單刪除紐
$(document.body).on("click", ".delete-order",function () { 
  	let thisOrder = $(this).parent().parent();
//   	console.log(thisOrder); //tr

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
        	let order_no = $(thisOrder.find("input")).val();
// 			console.log(order_no);
              $.ajax({
                  url: "<%=request.getContextPath()%>/OrderServlet?action=delete_for_Ajax",
                  data: { "order_no": order_no
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
                  		thisOrder.remove();
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
//移到歷史訂單
var switcher = "close";  //控制顯示"來訂票"
<c:forEach var="orderVO" items="${orderSvc.getAllOrderByMemno(memVO.member_no)}">
var showTime = parseInt((new Date('${showtimeSvc.getOneShowtime(orderVO.showtime_no).showtime_time}').getTime() / 1000).toFixed(0))
var now = Math.round(new Date()/1000);
var undue = $("tr.table-order");
var due = $("tr.table-history");
var fragment;
if(now>showTime||"${orderVO.order_status}"=="2"){
	if(switcher=="close"){
		undue.after(`<center><div>您目前沒有預訂任何電影票，快按<a href=/xxxxx>這裡</a>來訂票!</div></center>`)
		switcher="open";
	}
	due.css("display","");
	fragment = `<tr><td>` + "${orderVO.crt_dt}" + 
			   `</td><td>` + "${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(orderVO.showtime_no).movie_no).moviename}" + 
			   `</td><td>` +  "${orderVO.order_status}" + `</td><td>` + "${orderVO.payment_type}" + 
			   `</td><td>`+ "${orderVO.total_price}" +
			   `</td><td><button type="button" class="btn btn-primary" id="show_orderBox_${orderVO.order_no}" >查看</button></td></tr>`
	due.after(fragment);
	
}else{
	undue.css("display","");
	fragment = `<tr><td>` + "${orderVO.crt_dt}" + 
			   `</td><td>` + "${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(orderVO.showtime_no).movie_no).moviename}" + 
			   `</td><td>` +  "${orderVO.order_status}" + `</td><td>` + "${orderVO.payment_type}" + 
			   `</td><td>`+ "${orderVO.total_price}" +
			   `</td><td><i class="fas fa-minus-circle delete-order"></i><input name="order_no" style="display: none" value=`+"${orderVO.order_no}"+
			   `></td><td><button type="button" class="btn btn-info" id="show_orderBox_${orderVO.order_no}">查看</button></td></tr>`
	undue.after(fragment);
	switcher="open";
}

$("#show_orderBox_${orderVO.order_no}").click(function(){
	undue.before(fragment_${orderVO.order_no});
})

$(".cancelShow").click(function(){
	console.log("1");
	$("#order_box_${orderVO.order_no}").css("opacity", "0");
	$("#order_box_${orderVO.order_no}").css("z-index", "-1");
})

var movie_name = "${movieSvc.getOneMovie(showtimeSvc.getOneShowtime(orderVO.showtime_no).movie_no).moviename}";
var show_time = "${showtimeSvc.getOneShowtime(orderVO.showtime_no).showtime_time}";
var seat = "${orderVO.seat_name}";
var total_cost="${orderVO.total_price}";
var fragment_${orderVO.order_no}=
	`<div class="order_box" id="order_box_${orderVO.order_no}" style="opacity:1; z-index:99;">
	<div class="order_box_for_position">
		<table class="table table-secondary table-hover" style="text-align:center;">
		<button type="button" class="btn-close cancelShow" style="position:absolute; right:420px;"></button>
			<h1>訂單明細</h1>
			<tr><th>電影名稱 : </th><td>`+ movie_name +`</td></tr>
			<tr><th>播映時間 : </th><td>`+ show_time +`</td></tr>
			<tr><th>票種 : </th><td>
				<table>
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
			<table>
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
		row.innerHTML=`<div style="">您尚未是專職評論，可點擊<a href=/xxxxx>這裡</a>申請成為專職評論</div>`;
		contain.append(row);
		$("#comment").append(contain);
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
			 url:"<%=request.getContextPath()%>/CommentServlet?action=getOne_For_Display_Ajax",
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
                  url: "<%=request.getContextPath()%>/CommentServlet?action=delete_for_Ajax",
                  data: { "comment_no": comment_no
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
                  		thisComm.remove();
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
                              title: "已移除評分",
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
  
$(".hover_movCol").hover(function(){
	let movie_no = $($(this).find('td')[0]).text(); //$(this).find('td')[0]是DOM物件不能用jquery的text()，因此要再加上$()轉乘jquery物件
	console.log(movie_no);
	$.ajax({
		url: "<%=request.getContextPath()%>/MovieServlet?action=getOne_For_Display_Ajax",
		data:{"movieno":movie_no},
		type:"POST",
		success:function(json){
			let jsonobj = JSON.parse(json);
			let allRating = jsonobj.allRating;
			let allComment = jsonobj.allComment;
// 			console.log(allRating);
// 			console.log(allComment[0].content);
			let fragment = document.createElement("div");
				fragment.classList.add("movie_info");
				fragment.innerHTML = `
					<div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
					  <div class="carousel-inner">
					    <div class="carousel-item active">
					      <img src="<%=request.getContextPath()%>/DBGifReader1?movieno=`+movie_no+`"class="d-block w-100 rating_mov_pic" alt="...">
					    </div>
// 					    <div class="carousel-item active">
<%-- 					      <img src="<%=request.getContextPath()%>/DBGifReader2?movieno=`+movie_no+`"class="d-block w-100 rating_mov_pic" alt="..."> --%>
// 					    </div>
					  </div>
					</div>
                    <table class="table-primary" style="font-size:20px;"><tr><th> 評分 </th><td>` + allRating + `</td></tr> 
                    <tr><th> 影評 </th><td>` + allComment[0].content+`</td></tr></table>`
            $(".movcol_movieinfo").append(fragment);
			
		}
	})
},function(){
 $(this).closest('form').siblings().children().remove();

})

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
                              title: "已移除評分",
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
  
$(".hover_artCol").hover(function(){
	let article_no = $($(this).find('td')[0]).text(); //$(this).find('td')[0]是DOM物件不能用jquery的text()，因此要再加上$()轉乘jquery物件
	console.log(article_no);
	$.ajax({
		url: "<%=request.getContextPath()%>/ArticleServlet?action=getOne_For_Display_Ajax",
		data:{"article_no":article_no},
		type:"POST",
		success:function(json){
			let jsonobj = JSON.parse(json);
			let content = jsonobj.content;
			let author = jsonobj.author;
			let title = jsonobj.title;
			let likecount = jsonobj.likecount;
			let fragment = document.createElement("div");
			fragment.classList.add("article_info");
			fragment.innerHTML = `
                <table class="table-primary" style="font-size:15px;"><tr><th>文章</th><td>` 
                + title + `</td></tr><tr><th>作者</th><td>` 
                + author + `</td></tr><tr><th>內文 </th><td>` 
                + content+`</td></tr><tr><th>讚數</th><td>` 
                + likecount + `</td></tr></table>`
        $(".artcol_articleinfo").append(fragment);

		}
	})
},function(){
 $(this).closest('form').siblings().children().remove();

})
  
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
window.onload=function(){
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


//移到星星出現電影資訊

$(".hover_rating").hover(function(){
	let movie_no = $($(this).find('td')[0]).text(); //$(this).find('td')[0]是DOM物件不能用jquery的text()，因此要再加上$()轉乘jquery物件
	$.ajax({
		url: "<%=request.getContextPath()%>/MovieServlet?action=getOne_For_Display_Ajax",
		data:{"movieno":movie_no},
		type:"POST",
		success:function(json){
			let jsonobj = JSON.parse(json);
			let allRating = jsonobj.allRating;
			let allComment = jsonobj.allComment;
			let fragment = document.createElement("div");
				fragment.classList.add("movie_info");
			let slice = `
					<div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
					  <div class="carousel-inner">
					    <div class="carousel-item active">
					      <img src="<%=request.getContextPath()%>/DBGifReader1?movieno=`+movie_no+`"class="d-block w-100 rating_mov_pic" alt="...">
					    </div>
// 					    <div class="carousel-item active">
<%-- 					      <img src="<%=request.getContextPath()%>/DBGifReader2?movieno=`+movie_no+`"class="d-block w-100 rating_mov_pic" alt="..."> --%>
// 					    </div>
					  </div>
					</div>
                    <table class="table-primary" style="font-size:20px;"><tr><th> 評分 </th><td>` + allRating + `</td></tr>
                    <tr><th> 影評 </th></tr>`;
        
                    slice += allComment.map(comment => `<tr><td>` + comment.content + `</td></tr>`).join("");
                    slice += `</table>`;
                    fragment.innerHTML = slice;
            $(".rating_movinfo").append(fragment);
			
		}
	})
},function(){
 $(this).closest('form').siblings().children().remove();

})

// $(".hover_pointer").mouseleave() why 不能用mouseenter/mouseleave




</script>
</body>


</html>