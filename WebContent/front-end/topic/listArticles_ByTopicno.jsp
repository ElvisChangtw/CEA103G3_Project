<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.article.model.*"%>
<%@ page import="java.util.*"%>

<%
// 	Set<ReplyVO> listReplys_ByArticleno = (Set<ReplyVO>)request.getAttribute("listReplys_ByArticleno");
%>

<jsp:useBean id="listArticles_ByTopicno" scope="request" type="java.util.Set<ArticleVO>" /> <!-- ��EL����i�ٲ� -->
<jsp:useBean id="topicSvc" scope="page" class="com.topic.model.TopicService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />


<html>
<head><title>�峹�������峹 - listArticles_ByTopicno.jsp</title>

<style>
  table#table-2 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-2 h4 {
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

<!-- <h4>�����m�߱ĥ� EL ���g�k����:</h4> -->
<!-- <table id="table-2"> -->
<!-- 	<tr><td> -->
<!-- 		 <h3>�峹�^�� - listArticles_ByTopicno.jsp</h3> -->
<%-- 		 <h4><a href="<%=request.getContextPath()%>/reply/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4> --%>
<!-- 	</td></tr> -->
<!-- </table> -->
<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table class="table table-hover">
	<thead style="background-color:#F0F0F0">
		<tr>		
			<th>�峹�s��</th>
			<th>�o���</th>
			<th>�峹����</th>
	<!-- 	<th>�峹���e</th> -->
			<th>�峹�D�D</th>
			<th>�o��峹�ɶ�</th>
	<!-- 		<th>��s�峹�ɶ�</th> -->
			<th>�峹���A</th>
			<th>�I�g��</th>
	<!-- 		<th>�ק�</th> -->
	<!-- 		<th>�R��</th> -->
		</tr>
	</thead>
	
	<c:forEach var="articleVO" items="${listArticles_ByTopicno}" >		
			<tr>
<%-- 		<tr ${(replyVO.reply_no==param.reply_no) ? 'bgcolor = blue':''}><!--�N�ק諸���@���[�J����Ӥw--> --%>			
			<td>${articleVO.articleno}</td>		
			<td>�i<font color=orange>${memSvc.getOneMem(articleVO.memberno).mb_name}</font>�j</td>
				
			<td>
				<c:forEach var="topicVO" items="${topicSvc.all}">
                    <c:if test="${articleVO.articletype==topicVO.topicno}">
	                  	 �i<font color=orange>${topicVO.topic}</font>�j
                    </c:if>
                </c:forEach>
			</td>	
									
<%-- 		<td>${articleVO.content}</td> --%>
			<td>			
				<div class="box">
					<a class="JQellipsis" href='<%=request.getContextPath()%>/front-end/article/listOneArticle2.jsp?articleno=${articleVO.articleno}'>${articleVO.articleheadline}</a>				
				</div>	
			</td>
			<td><fmt:formatDate value="${articleVO.crtdt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
<%-- 			<td><fmt:formatDate value="${articleVO.updatedt}" pattern="yyyy-MM-dd HH:mm:ss"/></td> --%>
			<td>${articleVO.status}</td>
			<td>${articleVO.likecount}</td>

<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/article/article.do" style="margin-bottom: 0px;"> --%>
<!-- 			    <input type="submit" value="�ק�">  -->
<%-- 			    <input type="hidden" name="articleno"  value="${articleVO.articleno}"> --%>
<%-- 			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller--><!-- �ثe�|���Ψ�  --> --%>
<!-- 			    <input type="hidden" name="action"	   value="getOne_For_Update"></FORM> -->
<!-- 			</td> -->
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/article/article.do" style="margin-bottom: 0px;"> --%>
<!-- 			    <input type="submit" value="�R��"> -->
<%-- 			    <input type="hidden" name="articleno"  value="${articleVO.articleno}"> --%>
<%-- 			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller--> --%>
<!-- 			    <input type="hidden" name="action"     value="delete"></FORM> -->
<!-- 			</td> -->
		</tr>
	</c:forEach>
</table>

<!-- <br>�����������|:<br><b> -->
<%--    <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br> --%>
<%--    <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b> --%>

</body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function(){
    var len = 15; // �W�L15�Ӧr�H"..."���N
    $(".JQellipsis").each(function(i){
        if($(this).text().length>len){
            $(this).attr("title",$(this).text());
            var text=$(this).text().substring(0,len-1)+"......more";
            $(this).text(text);
        }
    });
});
</script>
</html>