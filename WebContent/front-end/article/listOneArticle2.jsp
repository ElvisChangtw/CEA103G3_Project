<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.article.model.*"%>
<%@ page import="com.reply.model.*"%>
<%@ page import="com.topic.model.*"%>
<%@ page import="com.like.model.*"%>
<%@ page import="com.articleCollection.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.relationship.model.*"%>
<%@ page import="com.like.model.*"%>

<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	// ArticleVO articleVO = (ArticleVO) request.getAttribute("articleVO"); //ArticleServlet.java(Concroller), 存入req的ArticleVO物件 
	RelationshipVO relationshipVO = (RelationshipVO) request.getAttribute("relationshipVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)

	Integer articleno = new Integer(request.getParameter("articleno"));
	ArticleService articleSvc = new ArticleService();
	ArticleVO articleVO = articleSvc.getOneArticle(articleno);
	pageContext.setAttribute("articleVO", articleVO);

	Set<ReplyVO> set = articleSvc.getReplysByArticleno(articleno);
	pageContext.setAttribute("set",set);  //EL寫法
	
	Set<LikeVO> set1 = articleSvc.getLikesByArticle(articleno);
	pageContext.setAttribute("set1",set1); 
	
	int count = 0;
	LikeService likeSvc = new LikeService();
	
	int myNumber = ((MemVO) session.getAttribute("memVO")).getMember_no(); //到時要換成從session取memVO出來
	pageContext.setAttribute("myNumber", myNumber);
	//(為了ajax)找此文章有無此會員按讚紀錄
	
	MemVO memVO = (MemVO) session.getAttribute("memVO");//取用登入的session
	
	ArticleCollectionService articleCollectionSvc = new ArticleCollectionService();
	ArticleCollectionVO articleCollectionVO = articleCollectionSvc.getOneArticleCollection(articleno, myNumber);
	pageContext.setAttribute("articleCollectionVO", articleCollectionVO);
	
%>
<jsp:useBean id="topicSvc" scope="page" class="com.topic.model.TopicService" />	
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />


<html>
<head>
<link href="https://i2.bahamut.com.tw/css/basic.css?v=1618977484" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://unpkg.com/ionicons@5.4.0/dist/ionicons.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<title>文章資料 - listOneArticle2.jsp</title>

    <style type="text/css">
/*         html { */
/*             background-color: white; */
/*         } */
         body { 
              width: 950px;  
             margin: 0 auto; 
             background-color: white; 
             padding: 10px 20px 20px 20px; 
/*              border: 1px solid black;  */
	        } 
	     .alert-dark {
    		color: #1b1e21;
    		background-color: rgb(0 0 0 / 10%);
   			border-color: white;
}

    </style>

</head>

<!-- <body> -->
<body bgcolor='white'>
<!-- <h4>此頁暫練習採用 Script 的寫法取值:</h4> -->
<!-- <table id="table-2"> -->
<!-- 	<tr><td> -->
<!-- 		 <h3>員工資料 - ListOneArticle.jsp</h3> -->
<%-- 		 <h4><a href="<%=request.getContextPath()%>/reply/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4> --%>
<!-- 	</td></tr> -->
<!-- </table> -->
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>	

	<div>
<%-- 		<%="目前登入會員=" + memVO.getMember_no() + " " +memVO.getMb_name()%>      --%>
	</div>
	
	 <div class="card-header bg-transparent border-success" >
		 <div class="liked-mems" style="display:none;">
		 <c:forEach var="LikeVO" items="${set1}">
	 		<p class="liked-mem">${memSvc.getOneMem(LikeVO.memberno).mb_name}</p>
	<%-- 		 	<img src ="<%=request.getContextPath()%>/MemServlet?action=view_memPic&member_no=${LikeVO.memberno}" style="border-radius:50%" height= "30px" width="30px"/> --%>
		 </c:forEach>
		 </div>
	 
	  		 			 	 		 	
 		 	<div>		 		
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/article/article.do" style="margin-bottom: 0px;" >
					<button type="button" class="btn btn-outline-success" onclick="location.href='<%=request.getContextPath()%>/front-end/article/listAllArticle.jsp'">回上一列表</button>
					<c:if test="${articleVO.memberno == memVO.member_no}">
					<input type="submit" value="修改文章" class="btn btn-danger">
					<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">
					<!-- 送出請求到update_article_input.jsp -->				
					<input type="hidden" name="articleno"  value="${articleVO.articleno}">
					<input type="hidden" name="action"	value="getOne_For_Update">
					</c:if>
				</FORM>			 		
 		 	</div>		 		
 		 <br>
 		 	<div class="container">
 		 		<div class="row">
 		 			<div class="col-md-3" style="text-align:center;">
		 		 		<img src="<%=request.getContextPath()%>/mem/DBGifReader4.do?member_no=${articleVO.memberno}"height= "200px" width="200px" style="margin-bottom:8px"/>
		 		 		<h3><span class="badge badge-pill badge-success" style="font-size:1.5rem">樓主 ${memSvc.getOneMem(articleVO.memberno).mb_name}</span></h3>		 		 				 		 		
		 		 			<span><i class="fas fa-bookmark" id="thumb1" style="font-size: 30px" ></i></span>
							<a id="hao2">點我可以收藏文章!!</a>
		 		 	</div>
		 		 	<div class="card-title col-md-9">
		 		 		<p style="font-size:2.50rem;"><font color=orange>【${topicSvc.getOneTopic(articleVO.articletype).topic}】</font>${articleVO.articleheadline}</p>
		 		 	</div>		 		 	
	 		 	</div>
				<div  style="text-align:right">
	 		 		<c:if test="${not empty articleVO.updatedt}">
						最後編輯時間:<fmt:formatDate value="${articleVO.updatedt}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</c:if>
			 		<c:if test="${empty articleVO.updatedt}">
						發表文章時間:<fmt:formatDate value="${articleVO.crtdt}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</c:if>	
				</div>
			</div>
 		 </div>
  			<div class="card-body ">  		
    			<p class="card-text" style="font-size:1.45rem;  text-indent:2em;">${articleVO.content}</p>			
  		</div>
  		
  			<div class="card-footer bg-transparent border-success" style="text-align:right">
<%--   					新增文章時間:<fmt:formatDate value="${articleVO.crtdt}" pattern="yyyy-MM-dd HH:mm:ss"/> --%>
					<h4 id="hao" style="text-align:left;">
						文章點讚數:${articleVO.likecount}											
					</h4>	
						<font style="color:blue"><div style="text-align:left;" id="like1"></div></font>						
						<div style="text-align:left"><span><i class="fas fa-heart" id="thumb" style="font-size: 50px"></i></span></div>
						<div style="text-align:left" id="hao1">我是愛心可以點我喔!!</div>													
			</div>
			  	<div class="card-footer bg-transparent border-success">
<%-- 					文章狀態:${articleVO.status} --%>
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/like/like.do">
					<input type="hidden" name="expectation" id="con1" size="50" value=""/>						
<!-- 				<input type="submit" value="LIKE" class="button1">	 -->
					<input type="hidden" name="articleno" value="<%=articleVO.getArticleno()%>">
					<input type="hidden" name="memberno" value="<%=memVO.getMember_no()%>">
					<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">
					<input type="hidden" name="action" value="insert"></FORM>
				</div>
			
 		<jsp:useBean id="replySvc" scope="page" class="com.reply.model.ReplyService" />
 		 
		<%@ include file="pages/page1.file" %> 	
			<c:forEach var="replyVO" items="${set}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>"> 
			<div class="container">
				<div class="row alert alert-dark" style="margin-bottom:0px">					
							<%count++;%>	
						<div class="col-md-10" role="alert">
		  					<%=count%>樓
		  				</div>
		  				<div class="col-md-2">
		  					<c:if test="${replyVO.member_no == memVO.member_no}">
				  				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reply/reply.do" style="margin-bottom: 0px;">						     
							    <input type="submit" value="修改回覆" class="btn btn-outline-danger">
							    <input type="hidden" name="reply_no"  value="${replyVO.reply_no}">
							    <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">
							    <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
							</c:if>
						</div>
					</div>	
						<div class="row">
					 		<div class="col-md-7.5" >
						 		<p style="padding-top:0px; margin-top:20px; " style="width: 200%;">
						 			<img src="<%=request.getContextPath()%>/mem/DBGifReader4.do?member_no=${replyVO.member_no}" height= "100px" width="100px" style="border-radius:50%" style="margin-bottom:5px"/>
						 			【<font color=orange>${memSvc.getOneMem(replyVO.member_no).mb_name}</font>】
						 			${replyVO.content}		 		 					 					 			
						 		</p>
					 		</div>
					 	<div class="col-md-4.5" style="text-align:right; margin-top:110px;">
						 	<c:if test="${not empty replyVO.modify_dt}">
						 		最後編輯時間
						 		<fmt:formatDate value="${replyVO.modify_dt}" pattern="yyyy-MM-dd HH:mm:ss"/>
						 	</c:if>
						 	<c:if test="${empty replyVO.modify_dt}">
						 		發表時間
						 		<fmt:formatDate value="${replyVO.crt_dt}" pattern="yyyy-MM-dd HH:mm:ss"/>
						 	</c:if>
					 	</div>					
				</div>
			</div>
			</c:forEach>
<%-- 		<%@ include file="pages/page2.file" %> --%>
			<hr>
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reply/reply.do" name="form1" role="form">	
			<div class="form-group form-group-lg" style="text-align:center">
				<h5><label for="content">回覆內容:</label></h5>
				<img src="<%=request.getContextPath()%>/mem/DBGifReader4.do?member_no=${memVO.member_no}"style="vertical-align:super;border-radius:50%;margin-bottom:5px;float: left" height= "100px" width="100px" />
				<textarea id="content" cols="60" name="content" rows="5" value="${replyVO.content}" style="width:80%" placeholder="message..."></textarea>
			</div>						
				<input type="hidden" name="action" value="insert">
				<input type="hidden" name="article_no" value="<%=articleVO.getArticleno()%>">
				<input type="hidden" name="member_no" value="<%=memVO.getMember_no()%>">
			<hr>
			<div style="text-align:center">
				<input type="button" value="送出回覆" class="btn btn-info" onclick="fun1()" >
			</div>
		</FORM>
		<hr>

<script>    
	   function fun1(){
	      with(document.form1){
	         if (content.value=="") 
	             alert("請輸入回覆內容!");
	         else
	             submit();
	      }
	   }
	let likeCnt2 = ${articleVO.likecount};
	console.log("我現在是= " + ${memVO.member_no});
	
	let isLiked = <%=((likeSvc.getOneLike(articleno, myNumber)==null)? false:true)%>
	
	$(document).ready(function(){
		
		console.log("isLiked = " + isLiked);
		//第一次判斷
		if(isLiked){
// 			console.log("應該要亮");
			$("#thumb").css("color","#FF7575");		
		} else{
// 			console.log("應該要暗");
			$("#thumb").css("color","black");
		}
		// 		 $("#thumb").val("1");
	});
	
	 $("#thumb").click(function(e){
	    let likeCnt;
		if(isLiked){
			likeCnt =${articleVO.likecount};
			$("#hao").text("文章點讚數:" + (--likeCnt2));
			$("#hao1").text("按讚");
			$("#thumb").css("color","black");
			Swal.fire({
	            position: "center",
	            icon: "success",
	            title: "已收回讚",
	            showConfirmButton: false,
	            timer: 3000,
				width: 600,
				padding: '3em',
//  			background: '#fff url(/images/trees.png)',
				backdrop: `
				rgba(0,0,0,0.4)
	<%-- 		url("<%=request.getContextPath()%>/images/1.jpg") --%>
				left center
				no-repeat
				`
			});
			isLiked = !isLiked;
		} else{
			likeCnt = ${articleVO.likecount};
			$("#hao").text("文章點讚數:" + (++likeCnt2));
			$("#hao1").text("回收讚");
			$("#thumb").css("color","#FF7575");
			
			Swal.fire({
	            position: "center",
	            icon: "success",
	            title: "已按讚",
	            showConfirmButton: false,
	            timer: 3000,
				width: 600,
				padding: '3em',
// 				background: '#fff url(/images/trees.png)',
				backdrop: `
				rgba(0,0,0,0.4)
	<%-- 		url("<%=request.getContextPath()%>/images/1.jpg") --%>
				left center
				no-repeat
				`
			});
			isLiked = !isLiked;
	   }   
	   
	   let articleno = "${articleVO.articleno}";
	   let memberno = "${memVO.member_no}";
	   $.ajax({
		   url:"<%=request.getContextPath()%>/LikeServlet?action=insert_Ajax",
		   data:{
			   "articleno":articleno,
			   "memberno":memberno		   
		   },
		   type:"POST",
		   success:function(msg){
			   if(msg === "success"){
// 				   $("#thumb").css("color","#F0AD4E");
			   } else{
// 				   alert("按讚失敗");
			   }
		   }
	   });
	  });
	 
//	   --------------------以下收藏----------------------

		let isCollection = <%=((articleCollectionSvc.getOneArticleCollection(articleno, myNumber)==null)? false:true)%>	
		$(document).ready(function(){
			//第一次判斷
			if(isCollection){
// 				console.log("收藏應該要亮");
				$("#thumb1").css("color","blue");
			} else{
// 				console.log("收藏應該要暗");
				$("#thumb1").css("color","black");
			}
		});
	 
	 $("#thumb1").click(function(e){
			if(isCollection){
				$("#hao2").text("我要收藏");
				$("#thumb1").css("color","black");
				Swal.fire({
		            position: "center",
		            icon: "success",
// 		            imageUrl: "https://pic.pimg.tw/softwarecenter/1397971601-1574704654.png",
		            title: "已取消收藏",
		            showConfirmButton: false,
		            timer: 3000,
					width: 600,
					padding: '3em',
//	  				background: '#fff url(/images/trees.png)',
					backdrop: `
					rgba(0,0,0,0.4)
<%-- 					url("<%=request.getContextPath()%>/images/1.jpg") --%>
					left center
					no-repeat
					`
				});
				
				isCollection = !isCollection;
			} else{
				$("#hao2").text("取消收藏");
				$("#thumb1").css("color","blue");
				Swal.fire({
		            position: "center",
		            icon: "success",
		            title: "已收藏",
		            showConfirmButton: false,
		            timer: 3000,
					width: 600,
					padding: '3em',
//	  			background: '#fff url(/images/trees.png)',
					backdrop: `
					rgba(0,0,0,0.4)
		<%-- 		url("<%=request.getContextPath()%>/images/1.jpg") --%>
					left center
					no-repeat
					`
				});
				isCollection = !isCollection;
		   }   
		   
		   let article_no = "${articleVO.articleno}";
		   let member_no = "${memVO.member_no}";
		   $.ajax({
			   url:"<%=request.getContextPath()%>/ArticleCollectionServlet?action=insert",
			   data:{				   
				   "article_no":article_no,	
				   "member_no":member_no
			   },
			   type:"POST",
			   success:function(msg){
				   if(msg === "success"){
				   } else{
					   
				   }
			   }
		   });
		  });

		 
	 	$(document).ready(function(){

	 	var lst = [];
		 $(".liked-mems>.liked-mem").each(function(){
			 lst.push($(this).text());
		 }); //把每個人都塞進lst裡面
		sort(lst);
		var likeMems = "";
		if(lst.length == 1){
			likeMems = lst[0] + "說這個讚";
		 }else if(lst.length == 2){
			 likeMems =lst[0] + " 以及 " + lst[1] + "說這個讚";
		 }else if(lst.length == 0){
			 likeMems ="這篇文章還沒人按讚，快來按讚喔!";
		 }else{
			 likeMems =lst[0] + " 以及 " + lst[1] + "及其他"+ (${articleVO.likecount}-2) + "人說這個讚";
		 }
		
		$("#like1").text(likeMems);
			
	 	});
	 	function sort(array) {
	 		  array.sort(() => Math.random() - 0.5);
	 		}
</script>

</body>

</html>