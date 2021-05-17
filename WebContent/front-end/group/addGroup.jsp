<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.group.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.util.Calendar"%>


<%
	GroupVO groupVO = (GroupVO) request.getAttribute("groupVO");
//   上一行為groupVO為null(req.getAttribute取不到會取null)
//   Returns the value of the named attribute as an Object, 
//   or null if no attribute of the given name exists.
%>
<jsp:useBean id="memVO" scope="session" type="com.mem.model.MemVO" />

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>揪團資料新增 - addGroup.jsp</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
<!--     自定義css格式開始 -->
   <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styleForGroup.css">
<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<!--     自定義css格式結束 -->
<style>
  body{
	background-image: linear-gradient(#ddd6f3,#faaca8);
  }
  table#table-1 {
	background-color: rgb(209, 245, 193);
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
	width: 750px;
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

</head>
<body bgcolor='white'>
<div class="container div-add">
	<table id="table-1" class="table table-bordered">
		<tr class="active">
			<td>
				 <h1><strong><em>揪團資料新增</em></strong></h1>
				 <h4><a href="<%=request.getContextPath()%>/front-end/group/group_front_page.jsp"><img src="<%=request.getContextPath()%>/images/back.gif" width="100" height="32" border="0"></a></h4>
			</td>
		</tr>
	</table>
	
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<jsp:useBean id="showtimeSvc" scope="page" class="com.showtime.model.ShowtimeService" />
	<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
	<jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />
	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group/group.do" id="add-form" name="form1" class="card p-2" onclick="return false">
		<div class="form-group font-weight-bold">
			<label for="member_no">主揪:</label>
			<input id="member_no" type="hidden" name="member_no" value="${memVO.member_no}" class="input-md form-control">
			${memVO.mb_name}
		</div>
		<div class="form-group">
			<label for="group_title" class="font-weight-bold">揪團標題:</label>
			<input id="group_title" type="TEXT" name="group_title" size="45" placeholder="請輸入揪團標題"
				 class="input-md form-control" />
		</div>
		
		<div class="form-group">
			<label for="movie_selection" class="font-weight-bold">請選擇電影:</label>
				<select id="movie_selection" size="1" name="movie_no" class="input-md form-control">
					<c:forEach var="movieVO" items="${movieSvc.all}"><option value="${movieVO.movieno}">電影${movieVO.movieno}: ${movieVO.moviename}
					</c:forEach>
				</select>
		</div>
		<div class="form-group">
			<label for="showtime_no" class="font-weight-bold">場次時間:</label>
				<select size="1" name="showtime_no" id="showtime_selection" class="input-md form-control">
				</select>
		</div>
		<div class="form-group">
			<label for="required_no" class="font-weight-bold">需求人數:</label>
			<select id="required_no" size="1" name="required_cnt" class="input-md form-control">
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
				<option value="6">6</option>
				<option value="7">7</option>
				<option value="8">8</option>
				<option value="9">9</option>
				<option value="10">10</option>
			</select>
		</div>
		<div class="form-group">
			<label for="desc" class="font-weight-bold">揪團說明:</label>
			<textarea id="desc" name="desc"  placeholder="請輸入揪團說明" class="input-md form-control"></textarea>
		</div>
		<div class="form-group">
			<label for="f_date1" class="font-weight-bold">截止時間(最早為24小時後, 最晚為場次前一天)</label>
			<input name="deadline_dt" id="f_date1" type="text" class="input-md form-control">
		</div>
		
		<input type="hidden" name="action" value="insert">
		<input id="add-btn" type="submit" value="新增揪團" class="btn btn-info" style="width:100%;font-weight: bold;">
	</FORM>
</div>

</body>

<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
  java.sql.Timestamp deadline_dt = null;

  try {
	  deadline_dt = groupVO.getDeadline_dt();
 } catch (Exception e) {
	//預設+24小時又五分鐘
	
	Timestamp original = new Timestamp(System.currentTimeMillis());
    Calendar cal = Calendar.getInstance();
    cal.setTimeInMillis(original.getTime());
    cal.add(Calendar.DATE, 1);
    cal.add(Calendar.MINUTE, 5);
    deadline_dt = new Timestamp(cal.getTime().getTime());
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

$(document).ready(function(){
	getInitValue();	//除連動之showtime_no外之初始值
	getOption();    //連動表單showtime_no之初始值
	

});



//電影變動時、場次跟著變動
$("#movie_selection").change(getOption);
$("#add-btn").click(function(){
	Swal.fire({
        position: "center",
        icon: "success",
        title: "新增揪團成功",
        showConfirmButton: false,
        timer: 1500,
    });
	setTimeout(function(){
		$("#add-form").submit();
	}, 1500);
});
$("#showtime_selection").change(
		function(){
			console.log("現在能選最晚時間: " + $("#showtime_selection").children("option:selected").text());
			restrictBeforeShow($("#showtime_selection").children("option:selected").text())
		});

// console.log("測試截止時間: " + $("#showtime_selection").children("option:selected").text());

//設定除連動之showtime_no外之初始值
function getInitValue(){
	$('#movie_selection').val(<%= (groupVO==null)? "90" : showtimeSvc.getOneShowtime(groupVO.getShowtime_no()).getMovie_no()%>);
	$('#required_no').val(<%= (groupVO==null)? 2 : groupVO.getRequired_cnt()%>);
	$('#group_title').val("<%= (groupVO==null)? "" : groupVO.getGroup_title()%>");
	$("#desc").val("<%= (groupVO==null)? "" : groupVO.getDesc()%>");
}

function getOption() {
	$('#showtime_selection').text("");
	$.ajax({
		url: "<%=request.getContextPath()%>/group/group.do",
		type:"POST",
		data: {
			movie_no:$("#movie_selection").val(),
			action:"getAllShowtimeByMovie_no"
		},
		success: function(json){
			let jsonobj = JSON.parse(json);
			var lstShowtime = jsonobj.showtimeByMovie_no;
			for(let i = 0 ; i < lstShowtime.length; i++){
				console.log("showtime_no = " + lstShowtime[i].showtime_no);	
				console.log("showtime_time = " + lstShowtime[i].showtime_time);
				let showtime = new Date(lstShowtime[i].showtime_time);
				let twentyFourHoursLater = new Date();
				twentyFourHoursLater.setDate(twentyFourHoursLater.getDate() + 1);
				if (twentyFourHoursLater < showtime){

					//append showtime to <select>
					var option = $('<option/>');
					option.attr('value', lstShowtime[i].showtime_no);
					
//	 				option.text("場次" + lstShowtime[i].showtime_no + ": "+ timeFormat(lstShowtime[i].showtime_time));
					option.text(timeFormat(lstShowtime[i].showtime_time));
					$('#showtime_selection').append(option);  
				} else{
					alert("24小時內場次:" + lstShowtime[i].showtime_no + "未顯示!");
				}
 			}
			
			let hasTmpData = <%=!(groupVO==null) %>;
			let selectValue = <%= (groupVO==null)? "0" : groupVO.getShowtime_no()%>;
			//append showtime to <select>
// 			console.log("selectValue= " + selectValue);
			//改變預設值
			if (hasTmpData){
				$('#showtime_selection').val(selectValue);
// 				console.log("val() = " + selectValue );
			} else{
				$('#showtime_selection')[0].selectedIndex =selectValue;
// 				console.log("selectedIndex = " + selectValue );
			}
			
			restrictBeforeShow($("#showtime_selection").children("option:selected").text());
// 			console.log("測試截止時間: " + $("#showtime_selection").children("option:selected").text());
			//改變預設值
			} 
	});
}

function timeFormat(timeStamp){
	let time = new Date(timeStamp);
	var year = time.getFullYear();
	var month = (time.getMonth()<10)? '0'+ (time.getMonth()+1) : time.getMonth();
	var date = (time.getDate()<10)? '0'+time.getDate(): time.getDate();
	var hour = (time.getHours()<10)? '0'+time.getHours(): time.getHours();
	var min = (time.getMinutes()<10)? '0'+time.getMinutes(): time.getMinutes();
	
	return year + '-' + month + '-' + date + ' ' + hour + ':' + min;
}

$.datetimepicker.setLocale('zh');
	$('#f_date1').datetimepicker({
	theme: '',              //theme: 'dark',
	timepicker:true,       //timepicker:true,
	step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	format:'Y-m-d H:i',         //format:'Y-m-d H:i:s',
	value: '<%=deadline_dt%>', // value:   new Timestamp(),
   //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
   //startDate:	            '2017/07/10',  // 起始日
   //minDate:               '-1970-01-01', // 去除今日(不含)之前
   //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
});

        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------
function restrictBeforeShow(dt){
    //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
//          var somedate1 = new Date('2017-06-15');
    	 var a = new Date();
    	 var somedate1 = new Date(a.setDate(a.getDate()+1));
         var somedate2 = new Date(dt);
         $('#f_date1').datetimepicker({
             beforeShowDay: function(date) {
           	  if (  date.getYear() <  somedate1.getYear() || 
    		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
    		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate()) ||
    		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() == somedate2.getDate()+1  && date.getHours() < somedate1.getHours())
    		             ||
    		            date.getYear() >  somedate2.getYear() || 
    		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
    		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate()-1)
                 ) {
                      return [false, ""]
                 }
                 return [true, ""];
         }});
}
       
        
</script>


</html>