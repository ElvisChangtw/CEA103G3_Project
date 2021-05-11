<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="movSvc" scope="page" class="com.movie.model.MovieService" />
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/MovieCollectionServlet" name="form1">
 <table>
 <tr><th>Member_NO</th><th>Movie_NO</th></tr>

 <tr>
 <td>
 	<select name="member_no">
 		<c:forEach var="memVO" items="${list}">
 			<option value="${memVO.member_no}">${memVO.mb_name}</option>
 		</c:forEach>
 	</select>
 </td>
  <td>
 	<select name="movie_no">
 		<c:forEach var="movVO" items="${movSvc.all}">
 			<option value="${movVO.movieno}">${movVO.moviename}</option>
 		</c:forEach>
 	</select>
 </td>

 </tr>

 </table>   
 <input type="hidden" name="action" value="insert">
 <input type="submit" value="Add"></FORM>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>


</script>

</body>

</html>