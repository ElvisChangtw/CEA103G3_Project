<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.article.model.*"%>
<%@ page import="com.reply.model.*"%>
<%@ page import="com.topic.model.*"%>
<%@ page import="com.like.model.*"%>

<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
// ArticleVO articleVO = (ArticleVO) request.getAttribute("articleVO"); //ArticleServlet.java(Concroller), 存入req的ArticleVO物件 

	Integer articleno = new Integer(request.getParameter("articleno"));
	ArticleService articleSvc = new ArticleService();
	ArticleVO articleVO = articleSvc.getOneArticle(articleno);
	pageContext.setAttribute("articleVO", articleVO);

	Set<ReplyVO> set = articleSvc.getReplysByArticleno(articleno);
	pageContext.setAttribute("set",set);  //EL寫法
	
	int count = 0;
	LikeService likeSvc = new LikeService();
	
	int myNumber = 3; //到時要換成從session取memVO出來
	pageContext.setAttribute("myNumber", myNumber);
	//(為了ajax)找此文章有無此會員按讚紀錄
	
%>
<jsp:useBean id="topicSvc" scope="page" class="com.topic.model.TopicService" />	
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://unpkg.com/ionicons@5.4.0/dist/ionicons.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>


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
/*         h1 { */
/*             margin: 0; */
/*             padding: 8px 0; */
/*             color: #00000;           */
/*         } */

/* 		div.card-header{ */
/* 			padding:  5rem 5rem; */
/* 		} */


/* 		.button1 { */
/* 		  display: inline-block; */
/* 		  padding: 5px 20px; */
/* 		  font-size: 24px; */
/* 		  cursor: pointer; */
/* 		  text-align: center; */
/* 		  text-decoration: none; */
/* 		  outline: none; */
/* 		  color: #fff; */
/* 		  background-color: #FF77FF; */
/* 		  border: none; */
/* 		  border-radius: 15px; */
/* 		  box-shadow: 0 9px #999; */
/* 		} */
		
/* 		.button1:hover {background-color: #FF9797} */
		
/* 		.button1:active { */
/* 		  background-color: #FF77FF; */
/* 		  box-shadow: 0 5px #666; */
/* 		  transform: translateY(4px); */
/* 		} */

		

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
	 <div class="card-header bg-transparent border-success" > 		 	
 		 	 		 	
 		 	<div>
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/article/article.do" style="margin-bottom: 0px;" >
				<button type="button" class="btn btn-outline-success" onclick="location.href='<%=request.getContextPath()%>/front-end/article/listAllArticle.jsp'">回上一列表</button>
				<input type="submit" value="修改文章" class="btn btn-danger">
				<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">
	<!-- 			送出請求到update_article_input.jsp   -->
				<input type="hidden" name="articleno"  value="${articleVO.articleno}">
				<input type="hidden" name="action"	value="getOne_For_Update"></FORM>	
 		 	</div>		 	
 		 	<br>
 		 	
 		 	<div class="container">
 		 		<div class="row">
 		 			<div class="col-md-3" style="text-align:center;">
		 		 		<img src ="<%=request.getContextPath()%>/MemServlet?action=view_memPic&member_no=${articleVO.memberno}" height= "200px" width="200px" style="margin-bottom:8px"/>
		 		 		<h3><span class="badge badge-pill badge-success" style="font-size:1.5rem">樓主 ${memSvc.getOneMem(articleVO.memberno).mb_name}</span></h3>		 		 		
		 		 	</div>
		 		 	<div class="card-title col-md-9">
		 		 		<p style="font-size:2.50rem;"><font color=orange>【${topicSvc.getOneTopic(articleVO.articletype).topic}】</font>${articleVO.articleheadline}</p>
<%-- 			 		 	文章編號:${articleVO.articleno}  --%>
		 		 	</div>
	 		 	</div>
			</div>
 		 </div>
  			<div class="card-body ">
    		
    		<p class="card-text" style="font-size:1.45rem;  text-indent:2em;">${articleVO.content}</p>
  		</div>
  			<div class="card-footer bg-transparent border-success" style="text-align:right">
<%--   						新增文章時間:<fmt:formatDate value="${articleVO.crtdt}" pattern="yyyy-MM-dd HH:mm:ss"/> --%>
					<h4 id="hao" style="text-align:left;">
						文章點讚數:${articleVO.likecount}											
					</h4>
						<div style="text-align:left"><span><i class="fas fa-heart" id="thumb" style="font-size: 50px"></i></span></div>
						<div style="text-align:left" id="hao1">我是愛心可以點我喔!!</div>
					<c:if test="${not empty articleVO.updatedt}">
						最後編輯時間:<fmt:formatDate value="${articleVO.updatedt}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</c:if>
			 		<c:if test="${empty articleVO.updatedt}">
						發表文章時間:<fmt:formatDate value="${articleVO.crtdt}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</c:if>					
			</div>
			  	<div class="card-footer bg-transparent border-success">
<%-- 					文章狀態:${articleVO.status} --%>
										
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/like/like.do">
					<input type="hidden" name="expectation" id="con1" size="50" value=""/>						
<!-- 					<input type="submit" value="LIKE" class="button1">	 -->
					<input type="hidden" name="articleno" value="<%=articleVO.getArticleno()%>">
					<input type="hidden" name="memberno" value="<%=myNumber%>">
					<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">
					<input type="hidden" name="action" value="insert"></FORM>

			</div>
 		<jsp:useBean id="replySvc" scope="page" class="com.reply.model.ReplyService" /> 
<!-- 			<hr> -->
		<%@ include file="pages/page1.file" %> 	
			<c:forEach var="replyVO" items="${set}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>"> 
			<div class="container">
				<div class="row alert alert-dark" style="margin-bottom:0px">
					
						<%count++;%>	
						<div class="col-md-10" role="alert">
		  					<%=count%>樓
		  				</div>
		  				<div class="col-md-2">
			  				 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reply/reply.do" style="margin-bottom: 0px;">
						     <input type="submit" value="修改回覆" class="btn btn-outline-danger">
						     <input type="hidden" name="reply_no"  value="${replyVO.reply_no}">
						     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">
						     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
						</div>
					</div>	
						<div class="row">
					 		<div class="col-md-6">
						 		<p class="alert alert-light" role="alert" style="padding-top:0px; margin-top:20px; ">
						 			【<font color=orange>${memSvc.getOneMem(replyVO.member_no).mb_name}</font>】
						 			${replyVO.content}		 		 					 					 			
						 		</p>
					 		</div>
					 	<div class="col-md-6" style="text-align:right; margin-top:20px;">
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
				<textarea id="content" cols="60" name="content" rows="5" value="${replyVO.content}" style="width:80%" placeholder="message..."></textarea>
			</div>
	
						
				<input type="hidden" name="action" value="insert">
				<input type="hidden" name="article_no" value="<%=articleVO.getArticleno()%>">
			<hr>
			<div style="text-align:center">
				<input type="button" value="送出回覆" class="btn btn-info" onclick="fun1()" >
			</div>
		</FORM>




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
	console.log("我現在是= " + ${myNumber});
	
	let isLiked = <%=((likeSvc.getOneLike(articleno, myNumber)==null)? false:true)%>
	
	$(document).ready(function(){
		console.log("isLiked = " + isLiked);
		//第一次判斷
		if(isLiked){
			console.log("應該要亮");
			$("#thumb").css("color","#FF7575");
		} else{
			console.log("應該要暗");
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
			isLiked = !isLiked;
		} else{
			likeCnt = ${articleVO.likecount};
			$("#hao").text("文章點讚數:" + (++likeCnt2));
			$("#hao1").text("回收讚");
			$("#thumb").css("color","#FF7575");
			isLiked = !isLiked;
	   }   
	   
	   let articleno = "${articleVO.articleno}";
	   let memberno = "${myNumber}";
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
				   alert("按讚失敗");
			   }
		   }
	   });
	  });
	
	
</script>

</body>

</html>