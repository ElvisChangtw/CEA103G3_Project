<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM listAllLike.jsp: Home</title>

<style>
  table#table-1 {
	width: 800px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>IBM listAllLike.jsp: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM listLike.jsp: Home</p>

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/like/listAllLike.jsp'>List</a> all Like.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/like/like.do" >
        <b>輸入文章編號 (如1~10):</b>
        <input type="text" name="articleno">
        <input type="text" name="memberno">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="likeSvc" scope="page" class="com.like.model.LikeService" />
   
<!--   <li> -->
<!--      <FORM METHOD="post" ACTION="like.do" > -->
<!--        <b>選擇文章編號:</b> -->
<!--        <select size="1" name="articleno"> -->
<%--          <c:forEach var="likeVO" items="${likeSvc.all}" >  --%>
<%--           <option value="${likeVO.articleno}">${likeVO.articleno} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
<!--        <input type="hidden" name="action" value="getOne_For_Display"> -->
<!--        <input type="submit" value="送出"> -->
<!--     </FORM> -->
<!--   </li> -->
  
<!--   <li> -->
<!--      <FORM METHOD="post" ACTION="like.do" > -->
<!--        <b>選擇會員編號:</b> -->
<!--        <select size="1" name="articleno"> -->
<%--          <c:forEach var="likeVO" items="${likeSvc.all}" >  --%>
<%--           <option value="${likeVO.articleno}">${likeVO.memberno} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
<!--        <input type="hidden" name="action" value="getOne_For_Display"> -->
<!--        <input type="submit" value="送出"> -->
<!--      </FORM> -->
<!--   </li> -->
</ul>


<h3>喜歡管理</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/like/addLike.jsp'>Add</a> a new Article.</li>
</ul>

</body>
</html>