<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.reply.model.*"%>
<%@ page import="com.article.model.*"%>
<%@ page import="com.relationship.model.*"%>


<%-- 萬用複合查詢-可由客戶端select_page.jsp隨意增減任何想查詢的欄位 --%>
<%-- 此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能--%>

<jsp:useBean id="listRelationships_ByCompositeQuery" scope="request" type="java.util.List<RelationshipVO>" /> <!-- 於EL此行可省略 -->
<jsp:useBean id="articleSvc" scope="page" class="com.article.model.ArticleService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
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

<!-- <h1 class="shadow p-3 mb-1 bg-white rounded"> -->
<!-- 	<span class="badge badge-secondary"> -->
<!-- 		MoviesHit討論區 -->
<!-- 	</span> -->
<%-- 	<button type="button" class="btn btn-info" onclick="location.href='<%=request.getContextPath()%>/front-end/article/addArticle.jsp'">新增文章</button> --%>
<!-- </h1> -->
	
	  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relationship/relationship.do" name="form1">   
       <b><font color=blue>搜尋會員加好友:</font></b> 

        <b>輸入會員姓名:</b>
        <input type="text" name="mb_name" value="">
		        
        <input type="submit" value="送出" class="btn btn-primary">
        <input type="hidden" name="action" value="listRelationships_ByCompositeQuery">
     </FORM>
	
<table class="table table-hover">
	 <thead style="background-color:#F0F0F0">
		<tr>
			<th>會員姓名</th>
			<th>加好友</th>

		</tr>
	</thead>
<%-- 	<c:forEach var="relationshipVO" items="${listRelationships_ByCompositeQuery}"> --%>
	<c:forEach var="relationshipVO" items="${memSvc.all}">
		<tbody>	
			<tr>	
<%-- 			<td>${relationshipVO.articleno}</td> --%>
				
				<td>【<font color=orange>${memSvc.getOneMem(relationshipVO.member_no).mb_name}</font>】</td>			
<%-- 				<td>【<font color=orange>${memSvc.getOneMem(relationshipVO.friend_no).mb_name}</font>】</td>			 --%>
<%-- 			<td>${relationshipVO.status}</td> --%>
<%-- 			<td>${relationshipVO.isblock}</td>	 --%>

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

</html>