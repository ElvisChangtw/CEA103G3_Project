<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.relationship.model.*"%>
<%@ page import="java.util.*"%>

<%
// 	Set<ReplyVO> listReplys_ByArticleno = (Set<ReplyVO>)request.getAttribute("listReplys_ByArticleno");
%>

<jsp:useBean id="listRelationships_ByMemno" scope="request" type="java.util.Set<RelationshipVO>" /> <!-- 於EL此行可省略 -->
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="group_memberSvc" scope="page" class="com.group_member.model.Group_MemberService" />


<html>
<head><title>會員好友 - listRelationships_ByMemno.jsp</title>

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
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-2">
	<tr><td>
		 <h3>會員好友 - listRelationships_ByMemno.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/relationship/select_page.jsp"><img src="<%=request.getContextPath()%>/front-end/relationship/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>會員照片*</th>
		<th>會員姓名*</th>
		<th>會員好友照片*</th>
		<th>會員好友編號*</th>
		<th>好友狀態</th>
		<th>黑名單狀態</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>

	<c:forEach var="relationshipVO" items="${listRelationships_ByMemno}" >		
<%-- 		<tr ${(replyVO.reply_no==param.reply_no) ? 'bgcolor = blue':''}><!--將修改的那一筆加入對比色而已--> --%>
		<tr>
			<td>
			<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${relationshipVO.member_no}"
					alt="尚無圖片" width="96px;" height="108px" title="" style="border: groove;"/>
			</td>	
			<td><c:forEach var="memVO" items="${memSvc.all}">
                    <c:if test="${relationshipVO.member_no==memVO.member_no}">
	                   	 【<font color=orange>${memVO.mb_name}</font>】
                    </c:if>
                </c:forEach>
			</td>
			<td>
			<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${relationshipVO.friend_no}"
					alt="尚無圖片" width="96px;" height="108px" title="" style="border: groove;"/>
			</td>		
			<td><c:forEach var="memVO" items="${memSvc.all}">
                    <c:if test="${relationshipVO.friend_no==memVO.member_no}">
	                    	【<font color=orange>${memVO.mb_name}</font>】
                    </c:if>
                </c:forEach>
			</td>	
						
			<td>${relationshipVO.status}</td>
			<td>${relationshipVO.isblock}</td>

			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relationship/relationship.do" style="margin-bottom: 0px;">
			    <input type="submit" value="修改"> 
			    <input type="hidden" name="member_no"   value="${relationshipVO.member_no}">
			    <input type="hidden" name="friend_no"   value="${relationshipVO.friend_no}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--><!-- 目前尚未用到  -->
			    <input type="hidden" name="action"	   value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relationship/relationship.do" style="margin-bottom: 0px;">
			    <input type="submit" value="刪除">
			    <input type="hidden" name="member_no"   value="${relationshipVO.member_no}">
			    <input type="hidden" name="friend_no"   value="${relationshipVO.friend_no}">			    
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			    <input type="hidden" name="action"     value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>