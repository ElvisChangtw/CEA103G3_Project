<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.message.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	MessageService messageSvc = new MessageService();
    List<MessageVO> list = messageSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有訊息資料 - listAllMessage.jsp</title>

<style>
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
	width: 1200px;
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
  .content{
  	width: 400px;
  	text-align:left;
  }
  th.content{
	text-align:center;  
  }
</style>

</head>
<body bgcolor='white'>


<table id="table-1">
	<tr><td>
		 <h3>所有訊息資料 - listAllMessage.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/message/select_page.jsp"><img src="<%=request.getContextPath()%>/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
		<th>訊息編號</th>
		<th>FROM</th>
		<th>TO</th>
		<th class="content">訊息內容</th>
		<th>訊息時間</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="messageVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${messageVO.message_no}</td>
<%-- 			<td>${messageVO.from_member_no}</td> --%>
			
			<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
			<td><c:forEach var="memVO" items="${memSvc.all}">
                    <c:if test="${messageVO.from_member_no==memVO.member_no}">${memVO.mb_name}
                    </c:if>
                </c:forEach>
			</td>
			
			
			<td>
				${memSvc.getOneMem(messageVO.to_member_no).mb_name}
			</td>
<%-- 			<td>${messageVO.to_member_no}</td> --%>
			<td class="content">${messageVO.message_content}</td>
<%-- 			<td>${messageVO.message_time}</td> --%>
			<td><fmt:formatDate value="${messageVO.message_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/message/message.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="message_no" value="${messageVO.message_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/message/message.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="message_no"  value="${messageVO.message_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>