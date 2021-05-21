<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.report_group.model.*"%>
<%@ page import="com.group.model.*"%>
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
	request.setAttribute("group_no", group_no);
%>
<jsp:useBean id="groupSvc" scope="page" class="com.group.model.GroupService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<%
	GroupVO groupVO= groupSvc.getOneGroup(group_no);

%>
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
<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
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
			 <h1><strong><em>揪團檢舉表單</em></strong></h1>
					 <h4><a href="<%=request.getContextPath()%>/front-end/group/group_front_page.jsp"><img src="<%=request.getContextPath()%>/images/back.gif" width="100" height="32" border="0"></a></h4>
			</td>
		</tr>
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
	
	<FORM id="report-form" class="alpha card p-2" METHOD="post" ACTION="<%=request.getContextPath()%>/report_group/report_group.do" name="form1" onclick="return false">
		<div class="form-group font-weight-bold">
			<label for="group_no">揪團編號:</label>
			
			<%=group_no %>
		</div>
	
		<div class="form-group font-weight-bold">
			<label class="font-weight-bold">揪團名稱:</label>
			<%= groupVO.getGroup_title() %>
		</div>
	
		<div class="form-group font-weight-bold">
			<label class="font-weight-bold">揪團內容:</label>
				 <%= groupVO.getDesc() %>
		</div>
		
		<div class="form-group">
			<label for="unknown" class="font-weight-bold">檢舉會員:</label>
				<select id="unknown" size="1" name="member_no" class="input-md form-control">
					<c:forEach var="group_memberVO" items="${groupSvc.getMembersByGroupno(group_no)}">
						<option value="${group_memberVO.member_no}">
						${group_memberVO.member_no}: ${memSvc.getOneMem(group_memberVO.member_no).mb_name}
					</c:forEach>
				</select>
		</div>
		
		<div class="form-group">
			<label for="content" class="font-weight-bold">說明:</label>
			<textarea id="content" name="content"  placeholder="請輸入說明" class="input-md form-control"></textarea>
		</div>
	
	<input type="hidden" name="action" value="insert">
	<input type="hidden" name="group_no" value="<%=group_no %>">
	
	<input id="submit-btn" type="submit" value="送出檢舉" class="btn btn-info"></FORM>
</div>
</body>
</html>

<script>

$("#submit-btn").click(function(){
	
	Swal.fire({
		  title: '您確定要送出檢舉嗎?',
		  text: "此動作無法復原!",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  confirmButtonText: 'Yes, delete it!'
		}).then((result) => {
		  if (result.isConfirmed) {
		    $("#report-form").submit();
		  }
		});
});


</script>