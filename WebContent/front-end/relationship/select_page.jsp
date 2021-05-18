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
   <tr><td><h3>IBM relationship: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM relationship: Home</p>

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
 		
		<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<ul>
    <li>
    	<%="現在是哪個會員=" + memVO.getMember_no()%>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" >
       <b><font color=orange>選擇會員姓名查該會員的好友(0403):</font></b>
       <select size="1" name="member_no">
         <c:forEach var="memVO" items="${memSvc.all}" > 
          	<option value="${memVO.member_no}">${memVO.mb_name}
         </c:forEach>   
       </select>
	       <input type="submit" value="送出">
	       <input type="hidden" name="action" value="listRelationships_ByMemberno_A">
     </FORM>
  </li>
  <li>
	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" name="form1">   
       <b><font color=blue>搜尋會員加好友:</font></b> 
        <b>選擇會員編號:</b>
			<input type="text" name="member_no" value="">     
        <b>輸入會員姓名加好友:</b>
       		<input type="text" name="mb_name" value="">		        
        <input type="submit" value="送出" class="btn btn-primary">
        <input type="hidden" name="action" value="listMems_ByCompositeQuery">
     </FORM>
   </li>
</ul>		
<%-- 			<c:forEach var="memVO" items="${memSvc.all}">	 --%>
<%-- 				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" style="margin-bottom: 0px;">			     --%>
<!-- 				<input type="submit" value="查詢" class="btn btn-success">  -->
<%-- 				<input type="hidden" name="member_no" value="${memVO.member_no}"> --%>
<!-- 				<input type="hidden" name="action" value="listRelationships_ByMemberno_B"></FORM> -->
<%-- 			</c:forEach>	 --%>
			
			<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath()%>/mem/mem.do?action=listRelationships_ByMemberno_B&member_no=${memVO.member_no}'">查詢</button>
	
<h3>會員好友管理:</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/relationship/addRelationship.jsp'>Add</a> a new Relationship.</li>
</ul>

<%if (request.getAttribute("listRelationships_ByMemno")!=null){%>
      <jsp:include page="/front-end/mem/listRelationships_ByMemno.jsp" />
<%} %>

</body>

</html>