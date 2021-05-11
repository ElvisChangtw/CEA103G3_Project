<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.group_member.model.*"%>

<%
	Group_MemberVO group_memberVO = (Group_MemberVO) request.getAttribute("group_memberVO"); //GroupServlet.java (Concroller) 存入req的group_memberVO物件 (包括幫忙取出的group_memberVO, 也包括輸入資料錯誤時的group_memberVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>揪團會員資料修改 - update_group_member_input.jsp</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

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
	width: 100%;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3><strong><em>揪團會員資料修改 - update_group_member_input.jsp</em></strong></h3>
		 <h4><a href=""><img src="<%=request.getContextPath()%>/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group_member/group_member.do" name="form1">
<table class="table  table-bordered">
	<jsp:useBean id="groupSvc" scope="page" class="com.group.model.GroupService" />
	<tr class="active">
		<td>揪團編號:<font color=red><b>*</b></font></td>
		<td>${groupSvc.getOneGroup(group_memberVO.group_no).group_title}(${group_memberVO.group_no})</td>
	</tr>

	<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
	<tr>
		<td>成員:<font color=red><b>*</b></font></td>
		<td>${memSvc.getOneMem(group_memberVO.member_no).mb_name}(${group_memberVO.member_no})</td>
		
		<tr>
	<tr>
		<td>付款狀態:<font color=red></font></td>
		<td><select size="1" name="pay_status">
				<option value="0" ${(group_memberVO.pay_status==0)? 'selected':'' }>未付款(0)</option>
				<option value="1" ${(group_memberVO.pay_status==1)? 'selected':'' }>已付款(1)</option>
		</select></td>
	</tr>
	
	<tr>
		<td>會員狀態:<font color=red></font></td>
		<td><select size="1" name="status">
				<option value="0" ${(group_memberVO.status==0)? 'selected':'' }>已退出(0)</option>
				<option value="1" ${(group_memberVO.status==1)? 'selected':'' }>已加入(1)</option>
		</select></td>
	</tr>
	
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="group_no" value="<%=group_memberVO.getGroup_no()%>">
<input type="hidden" name="member_no" value="<%=group_memberVO.getMember_no()%>">
<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:istAllEmp.jsp-->
<input type="submit" value="送出修改" class="btn btn-info"></FORM>


<!-- <br>送出修改的來源網頁路徑:<br><b> -->
<%--    <font color=blue>request.getParameter("requestURL"):</font> <%=request.getParameter("requestURL")%><br> --%>
<%--    <font color=blue>request.getParameter("whichPage"): </font> <%=request.getParameter("whichPage")%> (此範例目前只用於:istAllEmp.jsp))</b> --%>
</body>
</html>