<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.reply.model.*"%>
<%@ page import="com.article.model.*"%>
<%@ page import="com.mem.model.*"%>

<% 
	MemVO memVO = (MemVO) session.getAttribute("memVO");
 	pageContext.setAttribute("memVO", memVO);
// 	MemVO memVO1 = (MemVO) request.getAttribute("memVO");
	
%>
<%-- �U�νƦX�d��-�i�ѫȤ��select_page.jsp�H�N�W�����Q�d�ߪ���� --%>
<%-- �����u�@���ƦX�d�߮ɤ����G�m�ߡA�i���ݭn�A�W�[�����B�e�X�ק�B�R�����\��--%>

<%-- <jsp:useBean id="listMems_ByCompositeQuery" scope="request" type="java.util.List<MemVO>" /> <!-- ��EL����i�ٲ� --> --%>
<jsp:useBean id="articleSvc" scope="page" class="com.article.model.ArticleService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="articleDAO" scope="page" class="com.article.model.ArticleDAO" />
<jsp:useBean id="relationshipSvc" scope="page" class="com.relationship.model.RelationshipService" />

<html>
<head><title>�ƦX�d�� - listMems_ByCompositeQuery.jsp</title>
<link href="https://i2.bahamut.com.tw/css/basic.css?v=1618977484" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

<style>
   body {  
     width:500px;  
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
		<div class="shadow p-3 mb-1 bg-white rounded" style="font-size:40px">
			<span class="badge badge-secondary">
				MoviesHit�n�ͱM��
			</span>
			<div class="btn-group">
		        <button type="button" class="btn btn-success">�n�ͺ޲z</button>
		        <button type="button" class="btn btn-success dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	            	<span class="sr-only">Toggle Dropdown</span>
	       		</button>
		       		<div class="dropdown-menu">
			            <a class="dropdown-item" href="<%=request.getContextPath()%>/mem/mem.do?action=listRelationships_ByMemberno_B&member_no=${memVO.member_no}">�ڪ��n��</a>
			            <a class="dropdown-item" href="<%=request.getContextPath()%>/front-end/relationship/friend_invite.jsp">�n���ܽ�</a>
		        	</div>
	      	 </div>
		</div>	
<!-- ���U�νƦX�d��  - �i�ѫȤ�� listAllArticle.jsp �H�N�W�����Q�d�ߪ����<br> -->
<!-- �������@���ƦX�d�߮ɤ����G�m�ߡA<font color=red>�w�W�[�����B�e�X�ק�B�R�����\��</font></h4> -->
<!-- <table id="table-1"> -->
<!-- 	<tr><td> -->
<!-- 		 <h3>�Ҧ����u��� - listAllArticle.jsp</h3> -->
<%-- 		 <h4><a href="<%=request.getContextPath()%>/front-end/article/listAllArticle.jsp"><img src="<%=request.getContextPath()%>/front-end/article/images/back1.gif" width="100" height="32" border="0">�^����</a></h4> --%>
<!-- 	</td></tr> -->
<!-- </table> -->

<!-- <h1 class="shadow p-3 mb-1 bg-white rounded"> -->
<!-- 	<span class="badge badge-secondary"> -->
<!-- 		MoviesHit�Q�װ� -->
<!-- 	</span> -->
<%-- 	<button type="button" class="btn btn-info" onclick="location.href='<%=request.getContextPath()%>/front-end/article/addArticle.jsp'">�s�W�峹</button> --%>
<!-- </h1> -->

	 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" name="form1">   
       <b><font color=blue>�j�M�|���[�n��:</font></b> 
<!--         <b>��J�|���s��:</b> -->
<!-- 			<input type="text" name="member_no" value="">      -->
        <b></b>
       		<input type="text" name="mb_name" value="" placeholder="�п�J�|���W��">		        
        <input type="submit" value="�e�X" class="btn btn-primary">
        <input type="hidden" name="action" value="listMems_ByCompositeQuery">
        <br>
        <%="�ثe�n�J�|��=" + memVO.getMember_no() + " " +memVO.getMb_name()%>
     </FORM>	
	
<table class="table table-hover">
	 <thead style="background-color:#F0F0F0">
		<tr>

			<th>�|���W��</th>
			<th>�[�n�ͳ� </th>
	<!-- 		<th>�ק�</th> -->
	<!-- 		<th>�R��</th> -->
		</tr>
	</thead>
	<c:forEach var="mem1VO" items="${listMems_ByCompositeQuery}">
		<c:if test="${mem1VO.member_no != sessionScope.memVO.member_no}">		
				<tbody>	
					<tr>
						<td>
							<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${mem1VO.member_no}"
								alt="�|�L�Ϥ�" width="96px;" height="108px" title="" style="border: groove;"/>
							�i<font color=orange>${mem1VO.mb_name}</font>�j
						</td>						
						
						<td style="vertical-align:middle;">
							<c:choose>
								<c:when test="${relationshipSvc.getOneRelationship(mem1VO.member_no, memVO.member_no) == null && relationshipSvc.getOneRelationship(memVO.member_no, mem1VO.member_no) == null}">
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relationship/relationship.do" name="form1">
										<input type="hidden" name="member_no" value="${memVO.member_no}">
										<input type="hidden" name="friend_no" value="${mem1VO.member_no}">												
										<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
										<input type="hidden" name="mb_name" value="${param.mb_name}">
										<input type="hidden" name="action" value="insert">			
										<input type="submit" value="�e�X�n���ܽ�" class="btn btn-info">
									</FORM>
								</c:when>
								<c:when test="${relationshipSvc.getOneRelationship(mem1VO.member_no, memVO.member_no) == null && relationshipSvc.getOneRelationship(memVO.member_no, mem1VO.member_no) != null}">
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relationship/relationship.do" style="margin-bottom: 0px;">
									    <input type="submit" value="���^�n���ܽ�" class="btn btn-warning">
									    <input type="hidden" name="member_no"   value="${memVO.member_no}">
									    <input type="hidden" name="friend_no"   value="${mem1VO.member_no}">			    
									    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
									    <input type="hidden" name="mb_name" value="${param.mb_name}">
									    <input type="hidden" name="action"     value="delete">
									</FORM>
								</c:when>
								<c:when test="${relationshipSvc.getOneRelationship(mem1VO.member_no, memVO.member_no).status == 1}">
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relationship/relationship.do" name="form2">
										<input type="hidden" name="member_no" value="${memVO.member_no}">
										<input type="hidden" name="friend_no" value="${mem1VO.member_no}">
										<input type="hidden" name="action" value="accept">			
										<input type="submit" value="�w���n��" class="btn btn-secondary" disabled>
									</FORM>
								</c:when>
								<c:when test="${relationshipSvc.getOneRelationship(mem1VO.member_no, memVO.member_no).status == 0}">
									<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relationship/relationship.do" name="form3">
										<input type="hidden" name="member_no" value="${memVO.member_no}">
										<input type="hidden" name="friend_no" value="${mem1VO.member_no}">
										<input type="hidden" name="action" value="accept">			
										<input type="submit" value="�����n���ܽ�" class="btn btn-success">
									</FORM>
								</c:when>
								<c:otherwise>
									<button class="btn btn-danger">�������󳣨S�i��!</button>
								</c:otherwise>
							</c:choose>
						</td>

	<!-- 			<td> -->
	<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reply/reply.do" style="margin-bottom: 0px;"> --%>
	<!-- 			     <input type="submit" value="�R��"> -->
	<%-- 			     <input type="hidden" name="reply_no"      value="${replyVO.reply_no}"> --%>
	<%-- 			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller--> --%>
	<%-- 			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--�e�X��e�O�ĴX����Controller--> --%>
	<!-- 			     <input type="hidden" name="action"     value="delete"></FORM> -->
	<!-- 			</td> -->
					</tr>
				</tbody>
			</c:if>
			</c:forEach>
</table>
<%-- <%@ include file="pages/page2_ByCompositeQuery.file" %> --%>

<!-- <br>�����������|:<br><b> -->
<%--    <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br> --%>
<%--    <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b> --%>

</body>

</html>