<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Comment: Home</title>

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
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td><h3>IBM Comment: Home</h3>
				<h4>
					( MVC ) <img
						src="<%=request.getContextPath()%>/images/comment_images/comment1.jpg"
						width="80" height="80" border="0">
				</h4> <a
				href="<%=request.getContextPath()%>/front-end/movie/select_movie_page.jsp"><img
					src="<%=request.getContextPath()%>/images/movie_images/movie.jpg"
					width="80" height="80" border="0">前往電影首頁</a></td>
		</tr>
	</table>

	<p>This is the Home page for IBM Comment: Home</p>

	<h3>資料查詢:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<ul>
		<li><a
			href='<%=request.getContextPath()%>/front-end/comment/listAllComment.jsp'>List</a>
			all Comments. <br> <br></li>


		<li>
			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/comment/comment.do">
				<b>輸入評論編號 (如1):</b> 
				<input type="text" name="commentno"> 
				<input type="hidden" name="action" value="getOne_For_Display"> 
				<input type="submit" value="送出">
			</FORM>
		</li>

		<jsp:useBean id="commentSvc" scope="page" class="com.comment.model.CommentService" />
			
		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/comment/comment.do">
				<b>選擇會員編號:</b> 
				<select size="1" name="commentno">
					<c:forEach var="commentVO" items="${commentSvc.all}">
						<option value="${commentVO.commentno}">${commentVO.memberno}
					</c:forEach>
				</select> 
				<input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>

		<li>
			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/comment/comment.do">
				<b>選擇評論狀態:</b> <select size="1" name="commentno">
					<c:forEach var="commentVO" items="${commentSvc.all}">
						<option value="${commentVO.commentno}">${commentVO.status}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>
		
	   <jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />

	  <li>
	     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" >
	       <b><font color=orange>選擇電影:</font></b>
	       <select size="1" name="movieno">
	         <c:forEach var="movieVO" items="${movieSvc.all}" > 
	          <option value="${movieVO.movieno}">${movieVO.moviename}
	         </c:forEach>   
	       </select>
	       <input type="submit" value="送出">
	       <input type="hidden" name="action" value="listComments_ByMovieno_A">
	     </FORM>
	  </li>
	</ul>

	<%-- 萬用複合查詢-以下欄位-可隨意增減 --%>
	<ul>
		<li>
			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/comment/comment.do" name="form1">
				<b><font color=blue>萬用複合查詢:</font></b> <br> 
				<b>選擇評論編號:</b>
				<select size="1" name="COMMENT_NO">
					<option value="">
						<c:forEach var="commentVO" items="${commentSvc.all}">
							<option value="${commentVO.commentno}">${commentVO.commentno}
						</c:forEach>
				</select><br> 
				<b>輸入會員編號:</b>
				<input type="text" name="MEMBER_NO" value=""><br> 
				<b>選擇電影:</b>
				<select size="1" name="MOVIE_NO">
					<option value="">
						<c:forEach var="movieVO" items="${movieSvc.all}">
							<option value="${movieVO.movieno}">${movieVO.moviename}
						</c:forEach>
				</select><br> 
				<b>輸入評論內容:</b>
				<input type="text" name="CONTENT" value=""><br> 
				<b>輸入發文日期:</b>
				<input type="text" name="CRT_DT" id="f_date1"><br> 
				<b>輸入評論狀態:</b>
				<select size="1" name="STATUS" size="1">
					<option></option>
					<option value="0">正常發佈</option>
					<option value="1">暫存評論</option>
       			</select><br>

			
				<input type="submit" value="送出"> 
				<input type="hidden" name="action" value="listComments_ByCompositeQuery">
			</FORM>
		</li>
	</ul>


	<h3>評論管理</h3>

	<ul>
		<li><a
			href='<%=request.getContextPath()%>/front-end/comment/addComment.jsp'>Add</a> a new Comment.</li>
	</ul>
	
	<h3><font color=orange>電影管理</font></h3>

	<ul>
  		<li><a href='<%=request.getContextPath()%>/front-end/movie/listAllMovie.jsp'>List</a> all Movies. </li>
	</ul>

</body>


<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script
	src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<script>
	$.datetimepicker.setLocale('zh');
	$('#f_date1').datetimepicker({
		theme : '', //theme: 'dark',
		timepicker : false, //timepicker:true,
		step : 1, //step: 60 (這是timepicker的預設間隔60分鐘)
		format : 'Y-m-d', //format:'Y-m-d H:i:s',
		value : '', // value:   new Date(),
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	//startDate:	            '2017/07/10',  // 起始日
	//minDate:               '-1970-01-01', // 去除今日(不含)之前
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