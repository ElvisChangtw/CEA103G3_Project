<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Topic: Home</title>

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
   <tr><td><h3>IBM Topic: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Topic: Home</p>

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
  <li><a href='<%=request.getContextPath()%>/front-end/topic/listAllTopic.jsp'>List</a> all Topic.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/topic/topic.do" >
        <b>輸入討論主題編號 (如1~10):</b>
        <input type="text" name="topicno">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="topicSvc" scope="page" class="com.topic.model.TopicService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/topic/topic.do" >
       <b>選擇討論主題編號:</b>
       <select size="1" name="topicno">
         <c:forEach var="topicVO" items="${topicSvc.all}" > 
          <option value="${topicVO.topicno}">${topicVO.topicno}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/topic/topic.do" >
       <b>選擇會員編號:</b>
       <select size="1" name="topicno">
         <c:forEach var="topicVO" items="${topicSvc.all}" > 
          <option value="${topicVO.topicno}">${topicVO.topicno}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>文章管理</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/topic/addTopic.jsp'>Add</a> a new Topic.</li>
</ul>

<h3><font color=orange>文章類型管理</font></h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/topic/listAllTopic.jsp'>List</a> all Topics. </li>
</ul>

</body>
</html>