<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.reply.model.*"%>
<%@ page import="com.article.model.*"%>
<%@ page import="com.topic.model.*"%>
<%@ page import="com.mem.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>
	
	
<%-- <% --%>
<!-- ArticleService articleSvc = new ArticleService(); -->
<!-- List<ArticleVO> list = ArticleSvc.getAll(); -->
<!-- pageContext.setAttribute("list",list); -->
<%-- %> --%>
	<jsp:useBean id="articleSvc" scope="page" class="com.article.model.ArticleService" />
	<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
	<jsp:useBean id="topicSvc" scope="page" class="com.topic.model.TopicService" />
	<jsp:useBean id="replyDAO"  scope="page" class="com.reply.model.ReplyDAO" />
	<jsp:useBean id="articleDAO" scope="page" class="com.article.model.ArticleDAO" />	
	
<%-- 	<jsp:useBean id="memVO" scope="session" class="com.mem.model.MemVO" /> --%>
<html>
<head>
<!-- <link href="https://i2.bahamut.com.tw/css/basic.css?v=1618977484" rel="stylesheet"> -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous"> -->

<title>所有文章資料 - listAllArticle.jsp</title>

<style>
   body {  
/*      width: 1200px;   */
     margin: 0 auto;  
     padding: 10px 20px 20px 20px;   
	font-family: "Helvetica Neue", Helvetica, Roboto, Arial, "Lucida Grande", "PingFang TC", "蘋果儷中黑", "Apple LiGothic Medium", sans-serif;
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
	margin-top: 0px;
	margin-bottom: 5px;
	
  }
  table, th, td {
/*     border: 1px solid #CCCCFF; */
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
  .forum-body{
  	margin:0px 5px; 
  	padding:0;
}
.forum-nav{
/* 	background-color:#126E7D; */
}
.search-form{
	float:right;
}

.forum-body>.row{
	margin-top:10px;
}
.forum-body #forum>thead>tr>th{
	color:white;
	text-align:center;
}
.forum-body #forum>thead>tr>th,
.forum-body #forum>tbody>tr>td{
	font-size:small;
}
ul.nav-pills > li.active > a.toggle{
	background-color: #51A1B4;
}
table#forum.table>tbody>tr>td{
	padding-top:3px !important;
	padding-bottom:3px! important;
	color:#6c6760;
}
table#forum.table>tbody>tr:hover
{
	background-color:#FFFFDD !important;
}
table#forum.table>tbody>tr>td>a
{
	font-weight:bold;
	color:black;
}
 table#forum.table>tbody>tr>td>a.notJQellipsis
 { 
 	font-weight:bold; 
 } 
table#forum.table>tbody>tr>td>a.JQellipsis
{
	font-weight:200;
	color:#6c6760;
	font-size:small;
}


</style>

</head>
<body bgcolor='white'>
<jsp:include page="/front_header.jsp"/>

<!-- <table id="table-1"> -->
<!-- 	<tr><td> -->
<!-- 		 <h3>所有文章資料 - listAllArticle.jsp</h3> -->
<%-- 		 <h4><a href="<%=request.getContextPath()%>/reply/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4> --%>
<!-- 	</td></tr> -->
<!-- </table> -->

<%-- 錯誤表列 --%>
<div class="container-fluid forum-body" style="min-height:450px;">
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<div class="row"  style="margin:5px 0;">
	<h1 class="shadow p-3 mb-1 bg-white rounded" style="background-color:#C7C1EA; display:inline-block;">
			MoviesHit論壇
	</h1>

</div>
<!-- <ul> -->
<%--   <li><a href='<%=request.getContextPath()%>/article/listAllArticle.jsp'>查看全部文章</a></li> --%>
<!-- </ul> -->
<div class="row"  style="margin:5px 0;">
<div class="col col-md-4 shadow-none p-2 mb-2 forum-nav" style="padding:0; margin-top:5px;">	
	<ul class="nav nav-pills">
		<li role="presentation" class="active"><a role="button" class="toggle" onclick="location.href='<%=request.getContextPath()%>/front-end/article/listAllArticle.jsp'">HOME</a></li>
		<li role="presentation"><a role="button" class="toggle" onclick="location.href='<%=request.getContextPath()%>/topic/topic.do?action=listArticles_ByTopicno_B&topicno=1'">電影情報</a></li>
		<li role="presentation"><a role="button" class="toggle" onclick="location.href='<%=request.getContextPath()%>/topic/topic.do?action=listArticles_ByTopicno_B&topicno=2'">劇情討論</a></li>
		<li role="presentation"><a role="button" class="toggle" onclick="location.href='<%=request.getContextPath()%>/topic/topic.do?action=listArticles_ByTopicno_B&topicno=3'">影城活動</a> </li>
	</ul>

 	<%-- 萬用複合查詢-以下欄位-可隨意增減 --%>   
<%--     <button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath()%>/front-end/article/listAllArticle.jsp'">HOME</button> --%>
<%-- 	<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath()%>/topic/topic.do?action=listArticles_ByTopicno_B&topicno=1'">電影情報</button> --%>
<%-- 	<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath()%>/topic/topic.do?action=listArticles_ByTopicno_B&topicno=2'">劇情討論</button> --%>
<%-- 	<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath()%>/topic/topic.do?action=listArticles_ByTopicno_B&topicno=3'">影城活動</button>    --%>
<!--  	<b>●符 合 查 詢 條 件 如 下 所 示:</b> -->
</div>
<div class="col col-md-8" style="padding:0; margin-top:5px;">
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/article/article.do" name="form1" style="position: absolute; right: 0; top: 10px;">   
       <b><font color=blue>搜尋文章:</font></b> 
        <b>選擇作者:</b>
        <select size="1" name="member_no" >
          <option value="">請選擇作者</option>
         <c:forEach var="memberVO" items="${memSvc.all}" > 
          <option value="${memberVO.member_no}">${memberVO.mb_name}</option>
         </c:forEach>   
        </select>       
        <b>輸入主題:</b>
        <input type="text" name="article_headline" value="" placeholder="請輸入主題  ">   
        <input type="submit" value="送出" class="btn btn-primary" style="border-radius:5px;">
        <input type="hidden" name="action" value="listArticles_ByCompositeQuery">
        <button type="button" class="btn btn-info" onclick="location.href='addArticle.jsp'" style="border-radius:5px;"><i class="fa fa-plus" aria-hidden="true"></i>新增文章</button>
     </FORM>


</div>
</div>
   	
<!-- <table> -->
<!-- 	<tr> -->
<!-- 		<th>討論主題編號</th> -->
<!-- 		<th>討論主題</th>		 -->
<!-- <!-- 		<th>修改</th>	 --> 
<!-- <!-- 		<th>刪除</th>	 --> 
<!-- 		<th>送出查詢</th>	 -->
		
<!-- 	</tr> -->
<%-- 	<c:forEach var="topicVO" items="${topicSvc.all}"> --%>
		
<!-- 		<tr> -->
<%-- 			<td>${topicVO.topicno}</td> --%>
<%-- 			<td>${topicVO.topic}</td> --%>
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/topic/topic.do" style="margin-bottom: 0px;"> --%>
<!-- 			    <input type="submit" value="送出查詢">  -->
<%-- 			    <input type="hidden" name="topicno" value="${topicVO.topicno}"> --%>
<!-- 			    <input type="hidden" name="action" value="listArticles_ByTopicno_B"></FORM> -->
<!-- 			</td> -->
			
			
<!-- 		</tr> -->
<%-- 	</c:forEach> --%>
<!-- </table> -->
<table id="forum" class="table table-hover">
	 <thead style="background-color:#126E7D">
		<tr>		
			<th>編號</th>
			<th>主題</th>
			<th>作者</th>
			<th>發表時間</th>
	<!-- 		<th>更新文章時間</th> -->
<!-- 			<th>文章狀態</th> -->
			<th>讚數</th>
	<!-- 		<th>修改</th> -->
	<!-- 		<th>刪除</th> -->
	<!-- 	<th>查詢回覆</th> -->
		</tr>
	</thead>
<%-- 	<%@ include file="page1.file" %>  --%>
	<c:forEach var="articleVO" items="${articleSvc.all}">		
		<tbody>
			<tr>
				<td>${articleVO.articleno}<br>
				${topicSvc.getOneTopic(articleVO.articletype).topic}</td>
<%-- 			<tr ${(articleVO.articleno==param.articleno) ? 'bgcolor = green':''}><!--將修改的那一筆加入對比色而已--> --%>
<%-- 			<td>${articleVO.articleno}</td> --%>
						
				

				<td style="text-align:left; font-size:large;">
					<a class="notJQellipsis" href='<%=request.getContextPath()%>/front-end/article/listOneArticle2.jsp?articleno=${articleVO.articleno}'>${articleVO.articleheadline}</a>
					<br><a class="JQellipsis" href='<%=request.getContextPath()%>/front-end/article/listOneArticle2.jsp?articleno=${articleVO.articleno}'>${articleVO.content}</a>
									
				</td>		
				
				<td style="text-align:left;"><img src ="<%=request.getContextPath()%>/MemServlet?action=view_memPic&member_no=${articleVO.memberno}" height= "30px" width="30px" style="margin-bottom:8px; border-radius:10px;"/>
				${memSvc.getOneMem(articleVO.memberno).mb_name}</td>		
				<td><fmt:formatDate value="${articleVO.crtdt}" pattern="yyyy-MM-dd HH:mm"/></td>
<%-- 			<td><fmt:formatDate value="${articleVO.updatedt}" pattern="yyyy-MM-dd HH:mm:ss"/></td> --%>
<%-- 				<td>${articleVO.status}</td> --%>
				<td>${articleVO.likecount}</td>
				
				
			
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/article/article.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="修改"> -->
<%-- 			     <input type="hidden" name="articleno"  value="${articleVO.articleno}"> --%>
<!-- 			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM> -->
<!-- 			</td> -->
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/article/article.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="刪除"> -->
<%-- 			     <input type="hidden" name="articleno"  value="${articleVO.articleno}"> --%>
<!-- 			     <input type="hidden" name="action" value="delete"></FORM> -->
<!-- 			</td> -->
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/article/article.do" style="margin-bottom: 0px;">			     --%>
<!-- 			    <input type="submit" value="查詢" class="btn btn-success">  -->
<%-- 			    <input type="hidden" name="articleno" value="${articleVO.articleno}"> --%>
<!-- 			    <input type="hidden" name="action" value="listReplys_ByArticleno_B"></FORM> -->
<!-- 			</td>			 -->
			</tr>
		</tbody>			
	</c:forEach>
</table>

<%-- <%@ include file="page2.file" %> --%>

<%-- <%if (request.getAttribute("listReplys_ByArticleno")!=null){%> --%>
<%--       <jsp:include page="listReplys_ByArticleno.jsp" /> --%>
<%-- <%} %> --%>

<%-- <% --%>
<%--  if (request.getAttribute("listArticles_ByTopicno")!=null){%> --%>
<%--       <jsp:include page="/topic/listArticles_ByTopicno.jsp" /> --%>
<%-- <%} %> --%>
</div>
<jsp:include page="/front_footer_copy.jsp"/>
</body>
<!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->
<script>
$(function(){
    var len = 50; // 超過15個字以"..."取代
    $(".JQellipsis").each(function(i){
        if($(this).text().length>len){
            $(this).attr("title",$(this).text());
            var text=$(this).text().substring(0,len-1)+"<a href=" + $(this).attr('href') + ">......see more...<a>";
            
            $(this).html(text);
        }
    });
});

$("#forum>tbody>tr>td").mouseover(function(){

		$(this).find(".notJQellipsis").css("color", "#126E7D");
});

$("#forum>tbody>tr>td").mouseleave(function(){
	$(this).find(".notJQellipsis").css("color", "black");
});
	
	
	
	
	
// 	$(this).mouseenter(function(){
// 		$(this).css("color", "#126E7D");
// 		$(this).css("font-weight", "bold");
// 		$(this).find(".notJQellipsis").css("color", "#126E7D");
// 		$(this).find(".notJQellipsis").css("font-weight", "bold");
// 	});





</script>
</html>