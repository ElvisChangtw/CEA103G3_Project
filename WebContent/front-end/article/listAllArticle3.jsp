<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.reply.model.*"%>
<%@ page import="com.article.model.*"%>
<%@ page import="com.topic.model.*"%>
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
<link href="https://i2.bahamut.com.tw/css/basic.css?v=1618977484" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

<title>所有文章資料 - listAllArticle.jsp</title>

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


<!-- <table id="table-1"> -->
<!-- 	<tr><td> -->
<!-- 		 <h3>所有文章資料 - listAllArticle.jsp</h3> -->
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
<h1 class="shadow p-3 mb-1 bg-white rounded">
	<span class="badge badge-secondary">
		MoviesHit討論區
	</span>
	<button type="button" class="btn btn-success" onclick="location.href='<%=request.getContextPath()%>/index.jsp'">回首頁</button>
	<button type="button" class="btn btn-info" onclick="location.href='addArticle.jsp'">新增文章</button>
</h1>

<!-- <ul> -->
<%--   <li><a href='<%=request.getContextPath()%>/article/listAllArticle.jsp'>查看全部文章</a></li> --%>
<!-- </ul> -->
<div class="shadow-none p-2 mb-2 bg-light rounded">	
 	<%-- 萬用複合查詢-以下欄位-可隨意增減 --%>   
    <button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath()%>/front-end/article/listAllArticle.jsp'">HOME</button>
	<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath()%>/topic/topic.do?action=listArticles_ByTopicno_B&topicno=1'">電影情報</button>
	<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath()%>/topic/topic.do?action=listArticles_ByTopicno_B&topicno=2'">劇情討論</button>
	<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath()%>/topic/topic.do?action=listArticles_ByTopicno_B&topicno=3'">影城活動</button>   
 	<b>●符 合 查 詢 條 件 如 下 所 示:</b>
</div>
   <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/article/article.do" name="form1">   
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
<table class="table table-hover">
	 <thead style="background-color:#F0F0F0">
		<tr>		
			<th>文章編號</th>
			<th>發文者</th>
			<th>文章類型</th>
	<!-- 	<th>文章內容</th> -->
			<th>文章主題</th>
			<th>發表文章時間</th>
	<!-- 		<th>更新文章時間</th> -->
<!-- 			<th>文章狀態</th> -->
			<th>點讚數</th>
	<!-- 		<th>修改</th> -->
	<!-- 		<th>刪除</th> -->
	<!-- 	<th>查詢回覆</th> -->
		</tr>
	</thead>
<%-- 	<%@ include file="page1.file" %>  --%>
	<c:forEach var="articleVO" items="${articleSvc.all}">		
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