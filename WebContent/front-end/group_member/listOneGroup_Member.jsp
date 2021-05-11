<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.group_member.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	Group_MemberVO group_memberVO = (Group_MemberVO) request.getAttribute("group_memberVO");
%>
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<html>
<head>
<title>揪團資料 - listOneGroup.jsp</title>

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
</style>

</head>
<body bgcolor='white'>


<table id="table-1">
	<tr><td>
		 <h3><strong><em>揪團資料 - ListOneGroup.jsp</em></strong></h3>
		 <h4><a href=""><img src="<%=request.getContextPath()%>/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>揪團(編號)</th>
		<th>會員(編號)</th>
		<th>付款狀態</th>
		<th>會員狀態</th>
		<th>加入時間</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
		<tr>
			<td>${group_memberVO.group_no}</td>
			<td>
				${memSvc.getOneMem(group_memberVO.member_no).mb_name}
			</td>
		<td>${group_memberVO.pay_status}</td>
			<td>${group_memberVO.status}</td>
			<td><fmt:formatDate value="${group_memberVO.crt_dt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group_member/group_member.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="group_no" value="${group_memberVO.group_no}">
			     <input type="hidden" name="member_no" value="${group_memberVO.member_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group_member/group_member.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="group_no"  value="${group_memberVO.group_no}">
			     <input type="hidden" name="member_no" value="${group_memberVO.member_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
</table>

</body>
</html>