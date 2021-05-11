<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Group_Member: Home</title>

<style>
  table#table-1 {
	width: 450px;
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
<body bgcolor='lightgray'>

<table id="table-1">
   <tr><td><h3>IBM Group_Member: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Group_Member: Home</p>

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

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/group_member/listAllGroup_Member.jsp'>List</a> all Group_Members <h4>(byDAO).  </h4></li>

  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group_member/group_member.do" >
        <b>查看揪團會員(輸入揪團編號):</b>
        <input type="text" name="group_no">
        <input type="hidden" name="action" value="GetMembersByGroup">
        <input type="submit" value="送出"> 
    </FORM>
  </li>

  <jsp:useBean id="groupSvc" scope="page" class="com.group.model.GroupService" />
   <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group_member/group_member.do" >
       <b>查看揪團會員(選擇揪團編號):</b>
       <select size="1" name="group_no">
         <c:forEach var="groupVO" items="${groupSvc.all}" > 
          <option value="${groupVO.group_no}">${groupVO.group_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="GetMembersByGroup">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group_member/group_member.do" >
       <b>查看揪團會員(選擇揪團標題):</b>
       <select size="1" name="group_no">
         <c:forEach var="groupVO" items="${groupSvc.all}" > 
          <option value="${groupVO.group_no}">${groupVO.group_title}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="GetMembersByGroup">
       <input type="submit" value="送出">
    </FORM>
  </li>
<!--   選擇揪團查看成員(mvc0403作法 -->
    <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group/group.do" >
       <b><font color=orange>選擇揪團(mvc0403作法):</font></b>
       <select size="1" name="group_no">
         <c:forEach var="groupVO" items="${groupSvc.all}" > 
          <option value="${groupVO.group_no}">${groupVO.group_title}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="listMembers_ByGroupno_A">
     </FORM>
  </li>
  
  
  
  
  
  <jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
    <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group_member/group_member.do" >
        <b>查看會員已加入揪團(輸入會員編號):</b>
        <input type="text" name="member_no">
        <input type="hidden" name="action" value="GetGroupsByMember">
        <input type="submit" value="送出"> 
    </FORM>
  	</li>
    
    
    <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group_member/group_member.do" >
       <b>查看會員已加入揪團(選擇會員編號):</b>
       <select size="1" name="member_no">
         <c:forEach var="memVO" items="${memSvc.all}" > 
          <option value="${memVO.member_no}">${memVO.member_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="GetGroupsByMember">
       <input type="submit" value="送出">
     </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group_member/group_member.do" >
       <b>查看會員已加入揪團(選擇會員名稱):</b>
       <select size="1" name="member_no">
         <c:forEach var="memVO" items="${memSvc.all}" > 
          <option value="${memVO.member_no}">${memVO.mb_name}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="GetGroupsByMember">
       <input type="submit" value="送出">
     </FORM>
  </li>
  
  
</ul>

<h3>揪團會員管理</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/group_member/addGroup_Member.jsp'>Add</a> a new Group_Member.</li>
</ul>

</body>
</html>