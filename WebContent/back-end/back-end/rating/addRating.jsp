<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.movieRating.model.*"%>
<%@ page import="java.util.*"%>

<%
MovieRatingService ratingSvc = new MovieRatingService();
List<MovieRatingVO> list = ratingSvc.getAll();
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/MovieRatingServlet" name="form1">
 <table>
 <tr><th>Member_NO</th><th>Movie_NO</th><th>Rating</th></tr>

 <tr>
 <td>
 	<select name="member_no">
 		<c:forEach var="ratingVO" items="${list}">
 			<option value="${ratingVO.member_no}">${ratingVO.member_no}</option>
 		</c:forEach>
 	</select>
 </td>
  <td>
 	<select name="movie_no">
 		<c:forEach var="ratingVO" items="${list}">
 			<option value="${ratingVO.movie_no}">${ratingVO.movie_no}</option>
 		</c:forEach>
 	</select>
 </td>
 
 <td><input type="hidden" name="rating" value="" id="con"/>
    	<i class="fas fa-star all-star" id="s1"></i>
    	<i class="fas fa-star all-star" id="s2"></i>
    	<i class="fas fa-star all-star" id="s3"></i>
    	<i class="fas fa-star all-star" id="s4"></i>
    	<i class="fas fa-star all-star" id="s5"></i>
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