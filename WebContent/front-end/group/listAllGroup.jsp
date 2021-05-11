<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.group.model.*"%>
<%@ page import="com.mappingtool.*"%>
<%@ page import="com.mem.model.*"%>

<%
	GroupService groupSvc = new GroupService();
	List<GroupVO> list = groupSvc.getAll();
	pageContext.setAttribute("list", list);
	
%>
<jsp:useBean id="memVO" scope="session" type="com.mem.model.MemVO" />

<jsp:useBean id="mapping" scope="page" class="com.mappingtool.StatusMapping" />
				

<html>
<head>
<title>所有揪團 - listAllGroup.jsp</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

<style>
body{
background-color: #cccccc;
}
table {
/* 	width: 90%; */
	background-color: white;
	margin: 0px auto;
	width:100%;
	border: 1px solid black;
}


table#table-1 {
	background-color: #f0ad4e;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}
h3{
	font-size: 26px;
}
h4 {
	color: blue;
	display: inline;
}


table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
	font-size: 1.6rem;
}

.content {
	width: 400px;
	text-align: left;
}

th.content {
	text-align: center;
}
</style>

</head>
<body>
	<div class="table-responsive">
	<table id="table-1" class="table">
		<tr>
			<td>
				<h3><strong><em>所有揪團 - listAllGroup.jsp</em></strong></h3>
				<h4>
					<a href="<%=request.getContextPath()%>/front-end/group/select_page.jsp" 
					class="btn btn-primary btn-lg active" role="button">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>
	</div>
	

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
<div class="table-responsive">
	<table class="table">
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
			<th>查看</th>
		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="groupVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
		
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
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/group/group.do"
						style="margin-bottom: 0px;">
						
						<input type="submit" value="查詢" class="btn btn-success"> 
						<input type="hidden" name="group_no" value="${groupVO.group_no}"> 
						<input type="hidden" name="action" value="getOne_From06">
						<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
						
					</FORM>
<%-- 					<A href="<%=request.getContextPath()%>/group/group.do?group_no=${groupVO.group_no}&action=getOne_From06"></A> --%>
				</td>
			</tr>
		</c:forEach>
	</table>
	</div>
	<%@ include file="page2.file"%>
<!-- <br>本網頁的路徑:<br><b> -->
<%--    <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br> --%>
<%--    <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b> --%>
<!-- Button to Open the Modal -->

<c:if test="${openModal_Group!=null}">

  <!-- The Modal -->
    <div class="modal" id="myModal">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
<!--                     <h4 class="modal-title">揪團成員</h4> -->
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <!-- Modal body -->
                <div class="modal-body">
<!-- =========================================以下為原listOneEmp.jsp的內容========================================== -->
               <jsp:include page="listOneGroup.jsp" />
<!-- =========================================以上為原listOneEmp.jsp的內容========================================== -->
	<!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    	</div>
    </div>
     <script>
 		 $("#myModal").modal('show');
     </script>
 </c:if>

</body>
</html>