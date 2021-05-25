<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.group.model.*"%>

<%-- 萬用複合查詢-可由客戶端select_page.jsp隨意增減任何想查詢的欄位 --%>
<%-- 此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能--%>

<jsp:useBean id="listGroups_ByCompositeQuery" scope="request" type="java.util.List<GroupVO>" /> <!-- 於EL此行可省略 -->
<jsp:useBean id="groupSvc" scope="page" class="com.group.model.GroupService" />


<html>
<head>
<title>複合查詢 - listGroups_ByCompositeQuery.jsp</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>


<style>
  table#table-4 {
	background-color: #5bc0de;
    border: 2px solid black;
    text-align: center;
  }
  table#table-4 h4 {
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
<body>

<h4>
☆萬用複合查詢  - 可由客戶端 select_page.jsp 隨意增減任何想查詢的欄位<br>
☆此頁作為複合查詢時之結果練習，<font color=red>已增加分頁、送出修改、刪除之功能</font></h4>
<table id="table-4">
	<tr><td>
		 <h3><strong><em>複合查詢 - listGroups_ByCompositeQuery.jsp</em></strong></h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/group/select_page.jsp"><img src="<%=request.getContextPath()%>/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>


<table class="table  table-bordered">
	<tr class="active">
		<th>揪團 </th>
			<th>場次編號</th>
			<th>電影編號</th>
			<th>電影海報</th>
			<th>主揪</th>
			<th>人數(需求人數)</th>
			<th>狀態</th>
			<th>截止時間</th>
			<th>修改</th>
			<th>刪除</th>
	</tr>
	<%@ include file="pages/page1_ByCompositeQuery.file" %>
	<c:forEach var="groupVO" items="${listGroups_ByCompositeQuery}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr ${(groupVO.group_no==param.group_no) ? 'bgcolor=#CCCCFF':''}>
				<td>${groupVO.group_title}</td>
				<td>${groupVO.showtime_no}</td>
				<td>${groupVO.showtime_no}</td>
				<td><img src="${pageContext.request.contextPath}/movie/DBGifReader4.do?movieno=${groupVO.showtime_no}" 
											alt="尚無圖片" width="64px;" height="72px" title="${groupVO.showtime_no}"/> </td>
				<jsp:useBean id="memSvc" scope="page"
					class="com.mem.model.MemService" />
				<td><img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${groupVO.member_no}" 
					alt="尚無圖片" width="64px;" height="72px" title="${groupVO.member_no}"/>
					${memSvc.getOneMem(groupVO.member_no).mb_name} </td>

				<td>${groupVO.member_cnt}(${groupVO.required_cnt})</td>
				<td>${mapping.dboGroup_GroupStatus(groupVO.group_status)}</td>
				<td><fmt:formatDate value="${groupVO.deadline_dt}"
						pattern="yyyy-MM-dd HH:mm:ss" /></td>

				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/group/group.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="修改" class="btn btn-info"> 
						<input type="hidden" name="group_no" value="${groupVO.group_no}"> 
						<input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/group/group.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="刪除" class="btn btn-danger"> 
						<input type="hidden" name="group_no" value="${groupVO.group_no}"> 
						<input type="hidden" name="action" value="delete">
					</FORM>
				</td>
				
		</tr>
	</c:forEach>
</table>
<%@ include file="pages/page2_ByCompositeQuery.file" %>

<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>