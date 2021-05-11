<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.article.model.*"%>
<%@ page import="java.util.*"%>

<%
// 	Set<ReplyVO> listReplys_ByArticleno = (Set<ReplyVO>)request.getAttribute("listReplys_ByArticleno");
%>

<jsp:useBean id="listArticles_ByTopicno" scope="request" type="java.util.Set<ArticleVO>" /> <!-- 於EL此行可省略 -->
<jsp:useBean id="topicSvc" scope="page" class="com.topic.model.TopicService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />


<html>
<head><title>文章類型的文章 - listArticles_ByTopicno.jsp</title>

<style>
  table#table-2 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-2 h4 {
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

<!-- <h4>此頁練習採用 EL 的寫法取值:</h4> -->
<!-- <table id="table-2"> -->
<!-- 	<tr><td> -->
<!-- 		 <h3>文章回覆 - listArticles_ByTopicno.jsp</h3> -->
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
			<th>文章狀態</th>
			<th>點讚數</th>
	<!-- 		<th>修改</th> -->
	<!-- 		<th>刪除</th> -->
		</tr>
	</thead>
	
	<c:forEach var="articleVO" items="${listArticles_ByTopicno}" >		
			<tr>
<%-- 		<tr ${(replyVO.reply_no==param.reply_no) ? 'bgcolor = blue':''}><!--將修改的那一筆加入對比色而已--> --%>			
			<td>${articleVO.articleno}</td>		
			<td>【<font color=orange>${memSvc.getOneMem(articleVO.memberno).mb_name}</font>】</td>
				
			<td>
				<c:forEach var="topicVO" items="${topicSvc.all}">
                    <c:if test="${articleVO.articletype==topicVO.topicno}">
	                  	 【<font color=orange>${topicVO.topic}</font>】
                    </c:if>
                </c:forEach>
			</td>	
									
<%-- 		<td>${articleVO.content}</td> --%>
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
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/article/article.do" style="margin-bottom: 0px;"> --%>
<!-- 			    <input type="submit" value="修改">  -->
<%-- 			    <input type="hidden" name="articleno"  value="${articleVO.articleno}"> --%>
<%-- 			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--><!-- 目前尚未用到  --> --%>
<!-- 			    <input type="hidden" name="action"	   value="getOne_For_Update"></FORM> -->
<!-- 			</td> -->
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/article/article.do" style="margin-bottom: 0px;"> --%>
<!-- 			    <input type="submit" value="刪除"> -->
<%-- 			    <input type="hidden" name="articleno"  value="${articleVO.articleno}"> --%>
<%-- 			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--> --%>
<!-- 			    <input type="hidden" name="action"     value="delete"></FORM> -->
<!-- 			</td> -->
		</tr>
	</c:forEach>
</table>

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
            var text=$(this).text().substring(0,len-1)+"......more";
            $(this).text(text);
        }
    });
});
</script>
</html>