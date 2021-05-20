<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.relationship.model.*"%>
<%@ page import="com.mem.model.*"%>

<% 
	MemVO memVO = (MemVO) session.getAttribute("memVO");
%>
	
<html>
<head>
<title>IBM relationship: Home</title>
<link href="https://i2.bahamut.com.tw/css/basic.css?v=1618977484" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>


<style>
   body {  
     width: 500px;  
     margin: 0 auto;  
     padding: 10px 20px 20px 20px;  

 	        }  
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
	margin-top: 5px;
	margin-bottom: 5px;
	
  }
  table, th, td {
/*     border: 1px solid #CCCCFF; */
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
		<div class="shadow p-3 mb-1 bg-white rounded" style="font-size:40px">
			<span class="badge badge-secondary">
				MoviesHit好友專區
			</span>
			<div class="btn-group">
		        <button type="button" class="btn btn-success">好友管理</button>
		        <button type="button" class="btn btn-success dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	            	<span class="sr-only">Toggle Dropdown</span>
	       		</button>
		       		<div class="dropdown-menu">
			            <a class="dropdown-item" href="<%=request.getContextPath()%>/mem/mem.do?action=listRelationships_ByMemberno_B&member_no=${memVO.member_no}">我的好友</a>
			            <a class="dropdown-item" href="<%=request.getContextPath()%>/front-end/relationship/friend_invite.jsp">好友邀請</a>
		        	</div>
	      	 </div>
		</div>		

 		
		<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
		<jsp:useBean id="relationshipSvc" scope="page" class="com.relationship.model.RelationshipService" />
		
<!--     <li> -->

<%--      <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" > --%>
<!--        <b><font color=orange>選擇會員姓名查該會員的好友(0403):</font></b> -->
<!--        <select size="1" name="member_no"> -->
<%--          <c:forEach var="memVO" items="${memSvc.all}" >  --%>
<%--           	<option value="${memVO.member_no}">${memVO.mb_name} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
<!-- 	       <input type="submit" value="送出"> -->
<!-- 	       <input type="hidden" name="action" value="listRelationships_ByMemberno_A"> -->
<!--      </FORM> -->
<!--   </li> -->

	 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" name="form1">   
       <b><font color=blue>搜尋會員加好友:</font></b> 
<!--         <b>輸入會員編號:</b> -->
<!-- 			<input type="text" name="member_no" value="">      -->
        <b></b>
       		<input type="text" name="mb_name" value="" placeholder="請輸入會員名稱">		        
        <input type="submit" value="送出" class="btn btn-primary">
        <input type="hidden" name="action" value="listMems_ByCompositeQuery">
     	<br>
     	<%="目前登入會員=" + memVO.getMember_no() + " " +memVO.getMb_name()%>     
     </FORM>
     
     <table class="table table-hover">
	 <thead style="background-color:#F0F0F0">
		<tr>
			<th>會員名稱</th>
			<th>好友的邀請</th>
		</tr>
	</thead>
			<c:forEach var="mem1VO" items="${memSvc.all}">
			<c:if test="${relationshipSvc.getOneRelationship(mem1VO.member_no, memVO.member_no).status == 0}">
     	<tbody>	
     		<tr>
     			<td>
     				【<font color=orange>${mem1VO.mb_name}</font>】
     			</td>    			
     			<td>
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relationship/relationship.do" name="form3">
						<input type="hidden" name="member_no" value="${memVO.member_no}">
						<input type="hidden" name="friend_no" value="${mem1VO.member_no}">
						<input type="hidden" name="action" value="accept">			
						<input type="submit" value="接受好友邀請" class="btn btn-success">
					</FORM>
     			</td>   		
     		</tr>
     	</tbody>
     	</c:if>
     	</c:forEach>
	</table>
	
<%if (request.getAttribute("listRelationships_ByMemno")!=null){%>
      <jsp:include page="/front-end/mem/listRelationships_ByMemno.jsp" />
<%} %>

</body>

</html>