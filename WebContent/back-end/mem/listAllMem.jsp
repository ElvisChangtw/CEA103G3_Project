<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%-- �����m�߱ĥ� EL ���g�k���� --%>

<%
    MemService memSvc = new MemService();
    List<MemVO> list = memSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>�Ҧ��|����� - listAllMem.jsp</title>

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

  table {
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

  tr td img{
  	width:150px;
  	height:150px;
  }
  img {  
	max-width:600px;
	myimg:expression(onload=function(){
	this.style.width=(this.offsetWidth > 600)?"600px":"auto"});
  }
</style>

</head>
<body bgcolor='white'>
<%@ include file="page1.file" %> 

<h4>�����m�߱ĥ� EL ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>�Ҧ����u��� - listAllMem.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/mem/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>�|���s��<button>XX</button></th>
		<th>�|���m�W</th>
		<th>�|���H�c</th>
		<th>�|���K�X</th>
		<th>�|���ͤ�</th>
		<th>�|���Ӥ�</th>
		<th>�|���q��</th>
		<th>�|���a�}</th>
		<th>�|�����A</th>
		<th>�|���n��</th>
		<th>�|������</th>
		<th>�|�����U��</th>
		
		
	</tr>
	
	<c:forEach var="memVO" items="${list}">
		
		<tr>
			<td>${memVO.member_no}</td>
			<td>${memVO.mb_name}</td>
			<td>${memVO.mb_email}</td>
			<td>${memVO.mb_pwd}</td>
			<td>${memVO.mb_bd}</td>
			<td><img src="${pageContext.request.contextPath}/mem/mem.do?action=view_memPic&member_no=${memVO.member_no}"></td>
			<td>${memVO.mb_phone}</td>
			<td>${memVO.mb_city}${memVO.mb_address}</td> 
<%-- 			<td>${memVO.status}</td> --%>
			<c:choose>
				<c:when test="${memVO.status=='0'}">
				<td>�f�֤�</td>
				</c:when>
				<c:when test="${memVO.status=='1'}">
				<td>�w�q�L�f��</td>
				</c:when>
				<c:when test="${memVO.status=='2'}">
				<td>�w���v</td>
				</c:when>
				<c:when test="${memVO.status=='3'}">
				<td>�w����</td>
				</c:when>
				<c:otherwise>
				<td>�L�Ī��A</td>
				</c:otherwise>
			</c:choose>
			<td>${memVO.mb_point}</td>
			<td>${(memVO.mb_level=="1")? "�@��|��":"�M¾�v��"}</td>
			<td>${memVO.crt_dt}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�ק�">
			     <input type="hidden" name="member_no"  value="${memVO.member_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�R��">
			     <input type="hidden" name="member_no"  value="${memVO.member_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>

	</c:forEach>
	
	
</table>

<%@ include file="page2.file" %> 
</body>
</html>