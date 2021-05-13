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
<title>電影資料新增 - addMovie.jsp</title>


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
				<h3>電影資料新增 - addMovie.jsp</h3>
			</td>
			<td>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front-end/movie/select_movie_page.jsp"><img
						src="<%=request.getContextPath()%>/images/movie_images/movie.jpg" width="100" height="100" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料新增:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
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
				<td>電影名稱:</td>
				<td><input type="TEXT" name="moviename" size="45"
					value="<%=(movieVO == null) ? "天竺鼠車車" : movieVO.getMoviename()%>" /></td>
			</tr>
			<tr>
				<td>電影照片1:</td>
				<td><input type="file" name="moviepicture1" size="45" accept="image/*" onchange="readURL(this)" targetID="preview_img"
					value="<%=(movieVO == null) ? "QAQ" : movieVO.getMoviepicture1()%>" />
					<img id="preview_img" src="<%=request.getContextPath()%>/images/NoData/none2.jpg" /></td>
<%-- 					<img id="preview_img" src="<%=(movieVO == null) ? "QAQ" : movieVO.getMoviepicture1()%>" /></td> --%>
			</tr>
			<tr>
				<td>電影照片2:</td>
				<td><input type="file" name="moviepicture2" size="45" accept="image/*" onchange="readURL(this)" targetID="preview_img2"
					value="<%=(movieVO == null) ? "QAQ" : movieVO.getMoviepicture2()%>" />
					<img id="preview_img2" src="<%=request.getContextPath()%>/images/NoData/none2.jpg" /></td>
			</tr>
			<tr>
				<td>導演:</td>
				<td><input type="TEXT" name="director" size="45"
					value="<%=(movieVO == null) ? "吳永志" : movieVO.getDirector()%>" /></td>
			</tr>
			<tr>
				<td>演員:</td>
				<td><input type="TEXT" name="actor" size="45"
					value="<%=(movieVO == null) ? "吳冠宏" : movieVO.getActor()%>" /></td>
			</tr>
			<tr>
				<td>電影類型:</td>
				<td>
				<input type="checkbox" name="category" value="動作片">動作片
				<input type="checkbox" name="category" value="冒險片">冒險片
				<input type="checkbox" name="category" value="科幻片">科幻片
				<input type="checkbox" name="category" value="劇情片">劇情片
				<input type="checkbox" name="category" value="戰爭片">戰爭片
				<input type="checkbox" name="category" value="史詩片">史詩片
				<input type="checkbox" name="category" value="犯罪片">犯罪片
				<input type="checkbox" name="category" value="警匪片">警匪片
				<input type="checkbox" name="category" value="奇幻片">奇幻片
				<input type="checkbox" name="category" value="恐怖片">恐怖片
				<input type="checkbox" name="category" value="驚悚片">驚悚片
				<input type="checkbox" name="category" value="懸疑片">懸疑片
				<input type="checkbox" name="category" value="喜劇片">喜劇片
				<input type="checkbox" name="category" value="愛情片">愛情片
				<input type="checkbox" name="category" value="文藝片">文藝片
				<input type="checkbox" name="category" value="動畫片">動畫片
				<input type="checkbox" name="category" value="音樂片">音樂片
				<input type="checkbox" name="category" value="歌舞劇">歌舞劇
				</td>
			</tr>
			<tr>
				<td>電影長度:</td>
				<td><input type="TEXT" name="length" size="45"
					value="<%=(movieVO == null) ? "90" : movieVO.getLength()%>" /></td>
			</tr>
			<tr>
				<td>電影狀態:</td>
				<td><select name="status" size="1"> 
				<option value="9" <%= ((movieVO == null) ? "" : (movieVO.getStatus().equals("9") ? "selected" : ""))%>></option>
				<option value="0" <%= ((movieVO == null) ? "" : (movieVO.getStatus().equals("0") ? "selected" : ""))%>>上映中</option>
				<option value="1" <%= ((movieVO == null) ? "" : (movieVO.getStatus().equals("1") ? "selected" : ""))%>>未上映</option>
				<option value="2" <%= ((movieVO == null) ? "" : (movieVO.getStatus().equals("2") ? "selected" : ""))%>>已下檔</option>
				</select></td>
			</tr>
			<tr>
				<td>上映日期:</td>
				<td><input name="premiredate" id="f_date1" type="text" value="<%=(movieVO == null) ? "" : movieVO.getPremiredate()%>"></td>
			</tr>
			<tr>
				<td>下檔日期:</td>
				<td><input name="offdate" id="f_date2" type="text" value="<%=(movieVO == null) ? "" : movieVO.getOffdate()%>"></td>
			</tr>
			<tr>
				<td>預告片:</td>
				<td><input type="TEXT" name="trailor" size="45"
					value="<%=(movieVO == null) ? "https://www.youtube.com/" : movieVO.getTrailor()%>" /></td>
			</tr>
			<tr>
				<td>短預告片:</td>
				<td><input type="TEXT" name="embed" size="45"
					value="<%=(movieVO == null) ? "https://www.youtube.com/" : movieVO.getEmbed()%>" /></td>
			</tr>
			<tr>
				<td>電影分級:</td>
				<td><select name="grade" size="1"> 
				<option value="9"<%= ((movieVO == null) ? "" : (movieVO.getGrade().equals("9") ? "selected" : ""))%>></option>
				<option value="0"<%= ((movieVO == null) ? "" : (movieVO.getGrade().equals("0") ? "selected" : ""))%>>普遍級</option>
				<option value="1"<%= ((movieVO == null) ? "" : (movieVO.getGrade().equals("1") ? "selected" : ""))%>>保護級</option>
				<option value="2"<%= ((movieVO == null) ? "" : (movieVO.getGrade().equals("2") ? "selected" : ""))%>>輔導級</option>
				<option value="3"<%= ((movieVO == null) ? "" : (movieVO.getGrade().equals("3") ? "selected" : ""))%>>限制級</option>				
				</select></td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td>評分:</td> -->
<!-- 				<td><input type="TEXT" name="rating" size="45" -->
<%-- 					value="<%=(movieVO == null) ? "8.8" : movieVO.getRating()%>" /></td> --%>
<!-- 			</tr> -->
			<tr>
<!-- 				<td>評分:</td> -->
<!-- 				<td><input type="hidden" name="rating" value="" id="con"/> -->
<!-- 					<ion-icon name="star" class="all-star" id="s1"></ion-icon> -->
<!-- 					<ion-icon name="star" class="all-star" id="s2"></ion-icon> -->
<!-- 					<ion-icon name="star" class="all-star" id="s3"></ion-icon> -->
<!-- 					<ion-icon name="star" class="all-star" id="s4"></ion-icon> -->
<!-- 					<ion-icon name="star" class="all-star" id="s5"></ion-icon></td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>期待度:</td> -->
<!-- 				<td><input type="TEXT" name="expectation" size="45" -->
<%-- 					value="<%=(movieVO == null) ? "0.8" : movieVO.getExpectation()%>" /></td> --%>
<!-- 			</tr> -->
			
<!-- 			<tr> -->
<!-- 				<td>期待度:</td> -->
<!-- 				<td><input type="hidden" name="expectation" id="con1" size="50" -->
<%-- 					value="<%=(movieVO == null) ? "0.8" : movieVO.getExpectation()%>"/> --%>
<!-- 					<ion-icon name="thumbs-up-outline" class="thumbsup" id="t1"></ion-icon> -->
<!-- 					<ion-icon name="thumbs-down-outline" class="thumbsdown" id="t2"></ion-icon></td> -->
<!-- 			</tr> -->
			
		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>
</body>

<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

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
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=premiredate%>', // value:   new Date(),
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	//startDate:	            '2017/07/10',  // 起始日
	minDate:               '-1970-01-01', // 去除今日(不含)之前
	//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});

        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=offdate%>', // value:   new Date(),
		//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
		//startDate:	            '2017/07/10',  // 起始日
		minDate : '-1970-01-01', // 去除今日(不含)之前
	//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});
	// ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

	//      1.以下為某一天之前的日期無法選擇
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

	//      2.以下為某一天之後的日期無法選擇
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

	//      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
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