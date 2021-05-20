<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.reply.model.*"%>
<%@ page import="com.article.model.*"%>

<%-- 萬用複合查詢-可由客戶端select_page.jsp隨意增減任何想查詢的欄位 --%>
<%-- 此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能--%>

<jsp:useBean id="listArticles_ByCompositeQuery" scope="request" type="java.util.List<ArticleVO>" /> <!-- 於EL此行可省略 -->
<jsp:useBean id="articleSvc" scope="page" class="com.article.model.ArticleService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="topicSvc" scope="page" class="com.topic.model.TopicService" />
<jsp:useBean id="replyDAO"  scope="page" class="com.reply.model.ReplyDAO" />
<jsp:useBean id="articleDAO" scope="page" class="com.article.model.ArticleDAO" />

<html>
<head><title>複合查詢 - listArticles_ByCompositeQuery.jsp</title>
<link href="https://i2.bahamut.com.tw/css/basic.css?v=1618977484" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

<style>
   body {  
     width: 1200px;  
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
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<!-- <h4> -->
<!-- ☆萬用複合查詢  - 可由客戶端 listAllArticle.jsp 隨意增減任何想查詢的欄位<br> -->
<!-- ☆此頁作為複合查詢時之結果練習，<font color=red>已增加分頁、送出修改、刪除之功能</font></h4> -->
<!-- <table id="table-1"> -->
<!-- 	<tr><td> -->
<!-- 		 <h3>所有員工資料 - listAllArticle.jsp</h3> -->
<%-- 		 <h4><a href="<%=request.getContextPath()%>/front-end/article/listAllArticle.jsp"><img src="<%=request.getContextPath()%>/front-end/article/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4> --%>
<!-- 	</td></tr> -->
<!-- </table> -->
<h1 class="shadow p-3 mb-1 bg-white rounded">
	<span class="badge badge-secondary">
		MoviesHit討論區
	</span>
	<button type="button" class="btn btn-info" onclick="location.href='<%=request.getContextPath()%>/front-end/article/addArticle.jsp'">新增文章</button>
</h1>

<div class="shadow-none p-2 mb-2 bg-light rounded">
 	<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath()%>/front-end/article/listAllArticle.jsp'">HOME</button>
	<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath()%>/topic/topic.do?action=listArticles_ByTopicno_B&topicno=1'">電影情報</button>
	<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath()%>/topic/topic.do?action=listArticles_ByTopicno_B&topicno=2'">劇情討論</button>
	<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath()%>/topic/topic.do?action=listArticles_ByTopicno_B&topicno=3'">影城活動</button>   	
	<%@ include file="pages/page1_ByCompositeQuery.file" %>
</div>	
	   <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/article/article.do" name="form1">   
       <b><font color=blue>搜尋本站的作者或文章主題:</font></b> 
        <b>選擇文章作者:</b>
        <select size="1" name="member_no" >
          <option value="">
         <c:forEach var="memberVO" items="${memSvc.all}" > 
          <option value="${memberVO.member_no}">${memberVO.mb_name}
         </c:forEach>   
        </select>       
        <b>輸入文章主題:</b>
        <input type="text" name="article_headline" value="">
		        
        <input type="submit" value="送出" class="btn btn-primary">
        <input type="hidden" name="action" value="listArticles_ByCompositeQuery">
     </FORM>
	
<table class="table table-hover">
	 <thead style="background-color:#F0F0F0">
		<tr>
			<th>文章編號</th>
			<th>發文者</th>
			<th>文章類型</th>
	<!-- 		<th>文章內容</th> -->
			<th>文章主題</th>
			<th>發表文章時間</th>
	<!-- 		<th>更新回復時間</th> -->
			<th>文章狀態</th>
			<th>點讚數</th>
	<!-- 		<th>修改</th> -->
	<!-- 		<th>刪除</th> -->
		</tr>
	</thead>
	<c:forEach var="articleVO" items="${listArticles_ByCompositeQuery}">
<%-- 	 begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" --%>
<%-- 		<tr align='center' valign='middle' ${(ArticleVO.reply_no==param.reply_no) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色而已--> --%>
		<tbody>	
			<tr>	
				<td>${articleVO.articleno}</td>
<%-- 			<tr ${(articleVO.articleno==param.articleno) ? 'bgcolor = green':''}><!--將修改的那一筆加入對比色而已--> --%>
<%-- 			<td>${articleVO.articleno}</td> --%>
				<td>【<font color=orange>${memSvc.getOneMem(articleVO.memberno).mb_name}</font>】</td>			
				<td>【<font color=orange>${topicSvc.getOneTopic(articleVO.articletype).topic}</font>】</td>
<!-- 			<td> -->
<!-- 			<div class="box"> -->
<%-- 				<a class="JQellipsis" href='<%=request.getContextPath()%>/article/listOneArticle2.jsp?articleno=${articleVO.articleno}'>${articleVO.content}</a>				 --%>
<!-- 			</div>	 -->			
<!-- 			</td>	 -->
				<td>
			<div class="box">
				<a class="JQellipsis" href='<%=request.getContextPath()%>/front-end/article/listOneArticle2.jsp?articleno=${articleVO.articleno}'>${articleVO.articleheadline}</a>				
			</div>				
				</td>			
				<td><fmt:formatDate value="${articleVO.crtdt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
<%-- 			<td><fmt:formatDate value="${articleVO.updatedt}" pattern="yyyy-MM-dd HH:mm:ss"/></td> --%>
				<td>${articleVO.status}</td>
				<td>${articleVO.likecount}</td>	

<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reply/reply.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="修改">  -->
<%-- 			     <input type="hidden" name="reply_no"    value="${replyVO.reply_no}"> --%>
<%-- 			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--> --%>
<%-- 			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller--> --%>
<!-- 			     <input type="hidden" name="action"	    value="getOne_For_Update"></FORM> -->
<!-- 			</td> -->
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
	</c:forEach>
</table>
<%-- <%@ include file="pages/page2_ByCompositeQuery.file" %> --%>

<!-- <br>本網頁的路徑:<br><b> -->
<%--    <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br> --%>
<%--    <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b> --%>

</body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function(){
    var len = 15; // 超過15個字以"..."取代
    $(".JQellipsis").each(function(i){
        if($(this).text().length>len){
            $(this).attr("title",$(this).text());
            var text=$(this).text().substring(0,len-1)+"......see more...";
            $(this).text(text);
        }
    });
});
</script>
</html>