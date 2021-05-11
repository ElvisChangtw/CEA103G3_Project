<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.showtime.model.*"%>

<%
	ShowtimeVO showtimeVO = (ShowtimeVO) request.getAttribute("showtimeVO"); //TheaterServlet.java (Concroller) 存入req的theaeterVO物件 (包括幫忙取出的theaterVO, 也包括輸入資料錯誤時的theaterVO物件)
%>

<jsp:useBean id="theaterSvc" scope="page" class="com.theater.model.TheaterService" />
<jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />

<%= showtimeVO==null %>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>場次資料修改 - update_showtime_input.jsp</title>

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
  
  		h2{
			margin-left: 325px;
		}

		label {
			padding: 0;
			margin: 2px 2px 0px 0px;
			cursor: pointer;
/* 			background-color: lightgreen;  */
		}
		input[type=checkbox] {
			display: none;
			background-color: lightgreen;
		}
		span{
			font-size: 8px;
			font-family: Arial;
			text-align: center;
			/*  */
			line-height: 25px;
			/* background-color: lightgreen; */
		}

		input[type=checkbox]+span {
			display: inline-block;
			vertical-align:middle;
			background-color: lightgreen;
			/* 			padding: 3px ; */
			border: 1px solid; /* gray; */
			color: #444;
			user-select: none; /* 防止文字被滑鼠選取反白 */
			width: 25px;
			height: 25px;		
			margin: 2px 2px;
		}

		input[type=checkbox]:checked+span {
			/* 			color: yellow; */
			background-color: #ADD8E6;

		}

		input[type=checkbox]+span:first-child {
			visibility: hidden;
		}

		#d1{
			margin: 10px 20px;
			font-size: 27px;
		}
		input#submit{
			margin-left: 330px;
		}
		button{
			width: 25px;
			height: 25px;
		}
		#d1 > label:nth-child(2){
			visibility:  hidden;
			width: 20px;
			height: 20px;
		}
		#d2{
			border: 1px solid black;
			width: 690px;
			height: 30px;
			text-align: center;
			background: orange;
			font-size: 20px;
			line-height: 30px;
		}
		#d3, #d4{
			width:25px;
			height:25px;
			border: 1px solid black;
			display:inline-block;
		}
		#d3{
			margin-left:300px;
			background-color:lightgreen;
			
		}
		#d4{
			margin-left:20px;
			background-color: #ADD8E6;
		}
		#div1{
			display:inline-block;
			display: flex;
			align-items:center;
		}
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>場次資料修改 - update_showtime_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/showtime/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/theater/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/showtime/showtime.do" name="form1">
<table>
	<tr>
		<td>場次編號:<font color=red><b>*</b></font></td>
		<td>${showtimeVO.showtime_no}</td>
	</tr>
	<tr>
		<td>電影</td>
		<td>
			<select name="movie_no">
					<c:forEach var="movieVO" items="${movieSvc.all}" >
						<option value= "${movieVO.movieno}" ${(showtimeVO.movie_no == movieVO.movieno) ? "selected" : ""}>${movieVO.moviename}</option>
					</c:forEach>
				</select>
		</td>
	</tr>
	<tr>
		<td>廳院</td>
		
		<td>
			<select name="theater_no">
				<c:forEach var="theaterVO" items="${theaterSvc.all}" >
					<option value= "${theaterVO.theater_no}" ${(showtimeVO.theater_no == theaterVO.theater_no)? "selectd" : "" }>${theaterVO.theater_name}</option>
				</c:forEach>
			</select>
		</td>
	</tr>
		<tr>
		<td>場次時間</td>
		<td>
			<input name="showtime_time" id="f_date1" type="text">
		</td>
	</tr>

</table>
<br>


<input type="hidden" name="seat_no" value="${showtimeVO.seat_no}" />
<input type="hidden" name="action" value="update">
<input type="hidden" name="showtime_no" value="${showtimeVO.showtime_no}">
<input type="submit" id="submit" value="送出修改"></FORM>

</body>
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
  java.sql.Timestamp showtime_time = null;
  try {
	  showtime_time = showtimeVO.getShowtime_time();
   } catch (Exception e) {
	   showtime_time = new java.sql.Timestamp(System.currentTimeMillis());
   }
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i:00',         //format:'Y-m-d H:i:s',
		   value: '<%=showtime_time%>', // value:   new Date(),
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
		//         		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
</script>

</html>