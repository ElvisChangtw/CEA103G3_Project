<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.showtime.model.*"%>

<%
  ShowtimeVO showtimeVO = (ShowtimeVO) request.getAttribute("showtimeVO");
  java.util.Date date = new java.util.Date();
  pageContext.setAttribute("date", date);
%>
<%= showtimeVO==null %>

<jsp:useBean id="theaterSvc" scope="page" class="com.theater.model.TheaterService" />
<jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>場次資料新增 - addTheater.jsp</title>

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
  .delete{
			background-color: black;
			color: white;
			font-size: 8px;
			width: 40px;
			height: 20px;
			line-height: 20px;
			text-align: center;
			cursor: pointer;
		}
  #table{
  text-align:center;
  }
		
</style>


</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>場次資料新增 - addShowtime.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/showtime/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/theater/images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

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
		<td>電影</td>
		<td>
			<select name="movie_no">
				<c:forEach var="movieVO" items="${movieSvc.all}" >
					<c:if test="${movieVO.offdate.compareTo(date)>(-1)}">
						<option value= "${movieVO.movieno}">${movieVO.moviename}</option>
					</c:if>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		
		<td>廳院</td>
		
		<td>
			<select name="theater_no">
				<c:forEach var="theaterVO" items="${theaterSvc.all}" >
					<option value= "${theaterVO.theater_no}">${theaterVO.theater_name}</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<td>日期</td>
		<td>
			<input name="showtime_date" class="f_date1" type="text">
			<p style="display:inline-block">~</p>
			<input name="showtime_date" class="f_date1" type="text">
		</td>
	</tr>
	<tr>
		<td>
			<div id="insert_time"
			style="background-color: lightslategray; border: 1px solid lightslategray; 
			border-radius: 5px; color:white; width: 60px; height: 30px; font-size: 8px;
			line-height: 30px; text-align: center; cursor: pointer;">
				新增時間
			</div>
		</td>
	</tr>
</table>

<table id="table">
	<tr>
		<td>編號</td>
		<td>時間</td>
		<td></td>
	</tr>
</table>
<br>
<input type="hidden" name="action" value="insert2">
<input type="submit" value="送出新增">
</FORM>


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
        $('.f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           minDate:               '-1970-01-01', // 去除今日(不含)之前	
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
        
        	let i = 0;
			let hour = 10;
			let insert_time = document.getElementById("insert_time");
			insert_time.addEventListener("click",function(){
				let table = document.getElementById("table");
				let tr = document.createElement("tr");
				let no = document.createElement("td")
				let time = document.createElement("td");
				let input = document.createElement("input");
				let div = document.createElement("div");
				
		
				input.setAttribute("type", "text");
				input.setAttribute("class", "time");
				input.setAttribute("name", "showtime");
		
				no.innerText = i + 1;
				div.innerText = "刪除";
				div.setAttribute("class", "delete");
				div.addEventListener("click", function(){
					this.parentElement.remove();
				})
				
				time.appendChild(input);
				time.appendChild(input);
				tr.appendChild(no);
				tr.appendChild(time);
				tr.appendChild(div);
				table.appendChild(tr);
				if( i === 0){
					input.value = hour + ":00:00";
				}else{
					let time = ${}
					
					
					
					
					
					input.value = (hour + i * 2) + ":00:00"
				}
				i++;
				
				$('.time').datetimepicker({
				       theme: '',              //theme: 'dark',
				       datepicker:false,
				       timepicker:true,       //timepicker:true,
				       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
				       format:'H:i:s',         //format:'Y-m-d H:i:s',
					   value: '', // value:   new Date(),
			           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
			           //startDate:	            '2017/07/10',  // 起始日
//			            minDate:               '-1970-01-01', // 去除今日(不含)之前
			           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
			        });
	});
        
        
</script>

</html>