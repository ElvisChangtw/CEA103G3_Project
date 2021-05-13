<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.movie.model.*"%>

<%
	MovieVO movieVO = (MovieVO) request.getAttribute("movieVO");
System.out.println(movieVO);
%>

<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
<script src="https://unpkg.com/ionicons@5.4.0/dist/ionicons.js"></script>	
<script>
	$(document).ready(function(){
		$("#s1").click(function(){
			$(".all-star").css("color","gray");
			$("#s1").css("color","yellow");
			$("#con").val("1.0");
		})
		$("#s2").click(function(){
			$(".all-star").css("color","gray");
			$("#s1,#s2").css("color","yellow");
			$("#con").val("2.0");
		})
		$("#s3").click(function(){
			$(".all-star").css("color","gray");
			$("#s1,#s2,#s3").css("color","yellow");
			$("#con").val("3.0");
		})
		$("#s4").click(function(){
			$(".all-star").css("color","gray");
			$("#s1,#s2,#s3,#s4").css("color","yellow");
			$("#con").val("4.0");
		})
		$("#s5").click(function(){
			$(".all-star").css("color","gray");
			$(".all-star").css("color","yellow");
			$("#con").val("5");
		})
	})
		$(document).ready(function(){
		$("#t1").click(function(){
			$(".thumbsup").css("color","gray");
			$("#t1").css("color","blue");
			$("#t2").css("color","gray");
			$("#con1").val("1.0");
		})
		$("#t2").click(function(){
			$(".thumbsdown").css("color","gray");
			$("#t2").css("color","blue");
			$("#t1").css("color","gray");
			$("#con1").val("0.0");
		})
	})
</script>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>�q�v��Ʒs�W - addMovie.jsp</title>


<style>
tr td>img {
	width: 150px;
	height: 150px;
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
	width: 450px;
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

<script> 
 function readURL(input){
   if(input.files && input.files[0]){
     var imageTagID = input.getAttribute("targetID");
     var reader = new FileReader();
     reader.onload = function (e) {
        var img = document.getElementById(imageTagID);
        img.setAttribute("src", e.target.result)
     }
     reader.readAsDataURL(input.files[0]);
   }
 }
</script> 

</head>
<body bgcolor='white'>

	<table id="table-1">	
		<tr>
			<td>
				<h3>�q�v��Ʒs�W - addMovie.jsp</h3>
			</td>
			<td>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front-end/movie/select_movie_page.jsp"><img
						src="<%=request.getContextPath()%>/images/movie_images/movie.jpg" width="100" height="100" border="0">�^����</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>��Ʒs�W:</h3>

	<%-- ���~��C --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" name="form1"
		enctype="multipart/form-data">
		<table>
			<tr>
				<td>�q�v�W��:</td>
				<td><input type="TEXT" name="moviename" size="45"
					value="<%=(movieVO == null) ? "�Ѫǹ�����" : movieVO.getMoviename()%>" /></td>
			</tr>
			<tr>
				<td>�q�v�Ӥ�1:</td>
				<td><input type="file" name="moviepicture1" size="45" accept="image/*" onchange="readURL(this)" targetID="preview_img"
					value="<%=(movieVO == null) ? "QAQ" : movieVO.getMoviepicture1()%>" />
					<img id="preview_img" src="<%=request.getContextPath()%>/images/NoData/none2.jpg" /></td>
<%-- 					<img id="preview_img" src="<%=(movieVO == null) ? "QAQ" : movieVO.getMoviepicture1()%>" /></td> --%>
			</tr>
			<tr>
				<td>�q�v�Ӥ�2:</td>
				<td><input type="file" name="moviepicture2" size="45" accept="image/*" onchange="readURL(this)" targetID="preview_img2"
					value="<%=(movieVO == null) ? "QAQ" : movieVO.getMoviepicture2()%>" />
					<img id="preview_img2" src="<%=request.getContextPath()%>/images/NoData/none2.jpg" /></td>
			</tr>
			<tr>
				<td>�ɺt:</td>
				<td><input type="TEXT" name="director" size="45"
					value="<%=(movieVO == null) ? "�d�ç�" : movieVO.getDirector()%>" /></td>
			</tr>
			<tr>
				<td>�t��:</td>
				<td><input type="TEXT" name="actor" size="45"
					value="<%=(movieVO == null) ? "�d�a��" : movieVO.getActor()%>" /></td>
			</tr>
			<tr>
				<td>�q�v����:</td>
				<td>
				<input type="checkbox" name="category" value="�ʧ@��">�ʧ@��
				<input type="checkbox" name="category" value="�_�I��">�_�I��
				<input type="checkbox" name="category" value="��ۤ�">��ۤ�
				<input type="checkbox" name="category" value="�@����">�@����
				<input type="checkbox" name="category" value="�Ԫ���">�Ԫ���
				<input type="checkbox" name="category" value="�v�֤�">�v�֤�
				<input type="checkbox" name="category" value="�Ǹo��">�Ǹo��
				<input type="checkbox" name="category" value="ĵ���">ĵ���
				<input type="checkbox" name="category" value="�_�ۤ�">�_�ۤ�
				<input type="checkbox" name="category" value="���Ƥ�">���Ƥ�
				<input type="checkbox" name="category" value="�宪��">�宪��
				<input type="checkbox" name="category" value="�a�ä�">�a�ä�
				<input type="checkbox" name="category" value="�߼@��">�߼@��
				<input type="checkbox" name="category" value="�R����">�R����
				<input type="checkbox" name="category" value="������">������
				<input type="checkbox" name="category" value="�ʵe��">�ʵe��
				<input type="checkbox" name="category" value="���֤�">���֤�
				<input type="checkbox" name="category" value="�q�R�@">�q�R�@
				</td>
			</tr>
			<tr>
				<td>�q�v����:</td>
				<td><input type="TEXT" name="length" size="45"
					value="<%=(movieVO == null) ? "90" : movieVO.getLength()%>" /></td>
			</tr>
			<tr>
				<td>�q�v���A:</td>
				<td><select name="status" size="1"> 
				<option value="9" <%= ((movieVO == null) ? "" : (movieVO.getStatus().equals("9") ? "selected" : ""))%>></option>
				<option value="0" <%= ((movieVO == null) ? "" : (movieVO.getStatus().equals("0") ? "selected" : ""))%>>�W�M��</option>
				<option value="1" <%= ((movieVO == null) ? "" : (movieVO.getStatus().equals("1") ? "selected" : ""))%>>���W�M</option>
				<option value="2" <%= ((movieVO == null) ? "" : (movieVO.getStatus().equals("2") ? "selected" : ""))%>>�w�U��</option>
				</select></td>
			</tr>
			<tr>
				<td>�W�M���:</td>
				<td><input name="premiredate" id="f_date1" type="text" value="<%=(movieVO == null) ? "" : movieVO.getPremiredate()%>"></td>
			</tr>
			<tr>
				<td>�U�ɤ��:</td>
				<td><input name="offdate" id="f_date2" type="text" value="<%=(movieVO == null) ? "" : movieVO.getOffdate()%>"></td>
			</tr>
			<tr>
				<td>�w�i��:</td>
				<td><input type="TEXT" name="trailor" size="45"
					value="<%=(movieVO == null) ? "https://www.youtube.com/" : movieVO.getTrailor()%>" /></td>
			</tr>
			<tr>
				<td>�u�w�i��:</td>
				<td><input type="TEXT" name="embed" size="45"
					value="<%=(movieVO == null) ? "https://www.youtube.com/" : movieVO.getEmbed()%>" /></td>
			</tr>
			<tr>
				<td>�q�v����:</td>
				<td><select name="grade" size="1"> 
				<option value="9"<%= ((movieVO == null) ? "" : (movieVO.getGrade().equals("9") ? "selected" : ""))%>></option>
				<option value="0"<%= ((movieVO == null) ? "" : (movieVO.getGrade().equals("0") ? "selected" : ""))%>>���M��</option>
				<option value="1"<%= ((movieVO == null) ? "" : (movieVO.getGrade().equals("1") ? "selected" : ""))%>>�O�@��</option>
				<option value="2"<%= ((movieVO == null) ? "" : (movieVO.getGrade().equals("2") ? "selected" : ""))%>>���ɯ�</option>
				<option value="3"<%= ((movieVO == null) ? "" : (movieVO.getGrade().equals("3") ? "selected" : ""))%>>�����</option>				
				</select></td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td>����:</td> -->
<!-- 				<td><input type="TEXT" name="rating" size="45" -->
<%-- 					value="<%=(movieVO == null) ? "8.8" : movieVO.getRating()%>" /></td> --%>
<!-- 			</tr> -->
			<tr>
<!-- 				<td>����:</td> -->
<!-- 				<td><input type="hidden" name="rating" value="" id="con"/> -->
<!-- 					<ion-icon name="star" class="all-star" id="s1"></ion-icon> -->
<!-- 					<ion-icon name="star" class="all-star" id="s2"></ion-icon> -->
<!-- 					<ion-icon name="star" class="all-star" id="s3"></ion-icon> -->
<!-- 					<ion-icon name="star" class="all-star" id="s4"></ion-icon> -->
<!-- 					<ion-icon name="star" class="all-star" id="s5"></ion-icon></td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>���ݫ�:</td> -->
<!-- 				<td><input type="TEXT" name="expectation" size="45" -->
<%-- 					value="<%=(movieVO == null) ? "0.8" : movieVO.getExpectation()%>" /></td> --%>
<!-- 			</tr> -->
			
<!-- 			<tr> -->
<!-- 				<td>���ݫ�:</td> -->
<!-- 				<td><input type="hidden" name="expectation" id="con1" size="50" -->
<%-- 					value="<%=(movieVO == null) ? "0.8" : movieVO.getExpectation()%>"/> --%>
<!-- 					<ion-icon name="thumbs-up-outline" class="thumbsup" id="t1"></ion-icon> -->
<!-- 					<ion-icon name="thumbs-down-outline" class="thumbsdown" id="t2"></ion-icon></td> -->
<!-- 			</tr> -->
			
		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="�e�X�s�W">
	</FORM>
</body>

<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

<%
	java.sql.Date premiredate = null;
	try {
		premiredate = movieVO.getPremiredate();
	} catch (Exception e) {
		premiredate = new java.sql.Date(System.currentTimeMillis());
	}

	java.sql.Date offdate = null;
	try {
		offdate = movieVO.getOffdate();
	} catch (Exception e) {
		offdate = new java.sql.Date(System.currentTimeMillis());
	}
%>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script
	src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=premiredate%>', // value:   new Date(),
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
	//startDate:	            '2017/07/10',  // �_�l��
	minDate:               '-1970-01-01', // �h������(���t)���e
	//maxDate:               '+1970-01-01'  // �h������(���t)����
	});

        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=offdate%>', // value:   new Date(),
		//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
		//startDate:	            '2017/07/10',  // �_�l��
		minDate : '-1970-01-01', // �h������(���t)���e
	//maxDate:               '+1970-01-01'  // �h������(���t)����
	});
	// ----------------------------------------------------------�H�U�ΨӱƩw�L�k��ܪ����-----------------------------------------------------------

	//      1.�H�U���Y�@�Ѥ��e������L�k���
	//      var somedate1 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      2.�H�U���Y�@�Ѥ��᪺����L�k���
	//      var somedate2 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      3.�H�U����Ӥ�����~������L�k��� (�]�i���ݭn������L���)
	//      var somedate1 = new Date('2017-06-15');
	//      var somedate2 = new Date('2017-06-25');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//		             ||
	//		            date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});
</script>
</html>