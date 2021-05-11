<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.report_group.model.*"%>

<%
	Report_GroupVO report_groupVO = (Report_GroupVO) request.getAttribute("report_groupVO");
//   上一行為report_groupVO為null(req.getAttribute取不到會取null)
//   Returns the value of the named attribute as an Object, 
//   or null if no attribute of the given name exists.
	String str = request.getParameter("group_no");
	Integer group_no = null;
	if(str != null){
		group_no = new Integer(str);
	}
	
%>
<jsp:useBean id="groupSvc" scope="page" class="com.group.model.GroupService" />

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>揪團檢舉 - addReport_Group.jsp</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
<!--     自定義css格式開始 -->
   <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styleForGroup.css">
<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<!--     自定義css格式結束 -->

<style>
  body{
	background-image: linear-gradient(#ddd6f3,#faaca8);
  }
  table#table-1 {
	background-color: rgb(209, 245, 193);
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
	width: 750px;
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
<div class="container div-addReport">
	<table id="table-1" class="table table-bordered">
		<tr>
			<td>
			 <h3><strong><em>揪團檢舉 - addReport_Group.jsp</em></strong></h3>
					 <h4><a href="<%=request.getContextPath()%>/front-end/group/group_front_page.jsp"><img src="<%=request.getContextPath()%>/images/back.gif" width="100" height="32" border="0"></a></h4>
			</td>
		</tr>
	</table>
	
	<h3>資料新增:</h3>
	
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<FORM class="alpha" METHOD="post" ACTION="<%=request.getContextPath()%>/report_group/report_group.do" name="form1">
	<table class="table  table-bordered">
	
		<tr>
			<td>揪團編號:</td>
			<td>
				<% Integer group_no1 = 1;
				   if(group_no != null){
					   group_no1 = group_no;
				   } else{
					   if(report_groupVO==null){
						   group_no1 = 1;
					   } else{
						   group_no1 = report_groupVO.getGroup_no();
					   }
				   }
				%>
				<%= group_no1 %>
			</td>
		</tr>
		
		<tr>
			<td>揪團名稱</td>
			<td>
				<%= groupSvc.getOneGroup(group_no1).getGroup_title() %>
			</td>
		</tr>
	
		<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
		<tr>
			<td>檢舉會員:<font color=red><b>*</b></font></td>
			<td><select size="1" name="member_no">
				<c:forEach var="memVO" items="${memSvc.all}">
					<option value="${memVO.member_no}" ${(report_groupVO.member_no==memVO.member_no)? 'selected':'' } >${memVO.mb_name}
				</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td>檢舉內容:</td>
			<td><input type="TEXT" name="content" size="45"
				 value="<%= (report_groupVO==null)? "" : report_groupVO.getContent() %>" /></td>
		</tr>
		
		
	
	</table>
	<input type="hidden" name="action" value="insert">
	<input type="submit" value="送出新增" class="btn btn-info"></FORM>
</div>
</body>


</html>