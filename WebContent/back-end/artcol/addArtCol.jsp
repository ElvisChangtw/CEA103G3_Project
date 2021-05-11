<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="artSvc" scope="page" class="com.article.model.ArticleService" />
<%
MemService memSvc = new MemService();
List<MemVO> list = memSvc.getAll();
pageContext.setAttribute("list",list);


%>

<!DOCTYPE html>

<html>

<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
<meta charset="UTF-8">

<title></title>

<style>


</style>

</head>

<body>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ArticleCollectionServlet" name="form1">
 <table>
 <tr><th>Member_NO</th><th>Article_NO</th></tr>

 <tr>
 <td>
 	<select name="member_no">
 		<c:forEach var="memVO" items="${list}">
 			<option value="${memVO.member_no}">${memVO.mb_name}</option>
 		</c:forEach>
 	</select>
 </td>
  <td>
 	<select name="article_no">
 		<c:forEach var="artVO" items="${artSvc.all}">
 			<option value="${artVO.articleno}">${artVO.articleheadline}</option>
 		</c:forEach>
 	</select>
 </td>

 </tr>

 </table>   
 <input type="hidden" name="action" value="insert">
 <input type="submit" value="Add"></FORM>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
$(document).ready(function(){
	  var n = $('i').length;
	  console.log(n);
	  var index;
	  
	  $("i").mouseenter(function(){
	  index = $(this).index();
	  console.log(index);
      for(var i = 0; i <= index+1; i++) {
          $('i:nth-child(' + i + ')').css('color', '#F0AD4E');
      }
	  })
	  
	   $("i").mouseleave(function(){
	  for(var j = index+2; j <= n+1 ; j++){
    	  $('i:nth-child(' + j + ')').css('color', 'black');
      }
	  })

	  $("#s1").click(function(e){
	   $(".all-star").css("color","black");
	   $("#s1").css("color","#F0AD4E");
	   $("#con").val("1.0");
	   console.log($("#con").val());
	   
	  })
	  $("#s2").click(function(){
	   $(".all-star").css("color","black");
	   $("#s1,#s2").css("color","#F0AD4E");
	   $("#con").val("2.0");
	   console.log($("#con").val());
	  })
	  $("#s3").click(function(){
	   $(".all-star").css("color","black");
	   $("#s1,#s2,#s3").css("color","#F0AD4E");
	   $("#con").val("3.0");
	   console.log($("#con").val());
	  })
	  $("#s4").click(function(){
	   $(".all-star").css("color","black");
	   $("#s1,#s2,#s3,#s4").css("color","#F0AD4E");
	   $("#con").val("4.0");
	   console.log($("#con").val());
	  })
	  $("#s5").click(function(){
	   $(".all-star").css("color","black");
	   $(".all-star").css("color","#F0AD4E");
	   $("#con").val("5.0");
	   console.log($("#con").val());
	  })
	 })



</script>

</body>

</html>