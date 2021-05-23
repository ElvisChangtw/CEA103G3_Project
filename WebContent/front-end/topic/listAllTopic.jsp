<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.topic.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
// 	TopicService TopicSvc = new TopicService();
//  List<TopicVO> list = TopicSvc.getAll();
//  pageContext.setAttribute("list",list);
%>
<jsp:useBean id="topicSvc" scope="page" class="com.topic.model.TopicService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<html>
<head>
<link href="https://i2.bahamut.com.tw/css/basic.css?v=1618977484" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<title>所有文章類型資料 - listAllTopic.jsp</title>

<style>
   body {  
     width: 1200px;  
     margin: 0 auto;  
     padding: 10px 20px 20px 15px;  
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
<!-- 		 <h3>所有文章類型資料 - listAllTopic.jsp</h3> -->
<!-- 		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4> -->
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
	<button type="button" class="btn btn-info" onclick="location.href='<%=request.getContextPath()%>/front-end/article/addArticle.jsp'">新增文章</button>
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

<%if (request.getAttribute("listArticles_ByTopicno")!=null){%>
      <jsp:include page="listArticles_ByTopicno.jsp" />
<%} %>

</body>
</html>