<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.group.model.*"%>

<%
  GroupVO groupVO = (GroupVO) request.getAttribute("groupVO"); //GroupServlet.java (Concroller) 存入req的groupVO物件 (包括幫忙取出的groupVO, 也包括輸入資料錯誤時的groupVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>揪團資料修改 - update_group_input.jsp</title>
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
	width: 100%;
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
<div class="container div-update">
	<table id="table-1" class="table table-bordered">
		
		<tr class="active">
			<td>
				 <h3><strong><em>揪團資料修改 - update_group_input.jsp</em></strong></h3>
				 <h4><a href="<%=request.getContextPath()%>/front-end/group/group_front_page.jsp"><img src="<%=request.getContextPath()%>/images/back.gif" width="100" height="32" border="0"></a></h4>
			</td>
		</tr>
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
	
	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group/group.do" name="form1">
	<table class="table  table-bordered">
		<tr class="active">
			<td>揪團編號:<font color=red><b>*</b></font></td>
			<td><%=groupVO.getGroup_no()%></td>
		</tr>
		
		<tr>
			<td>場次編號:</td>
			<td><input type="TEXT" name="showtime_no" size="45"
				 value="<%= (groupVO==null)? "1" : groupVO.getShowtime_no()%>" /></td>
		</tr>
	
		<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
		<tr>
			<td>主揪會員:<font color=red></font></td>
			<td><select size="1" name="member_no">
				<c:forEach var="memVO" items="${memSvc.all}">
					<option value="${memVO.member_no}" ${(groupVO.member_no==memVO.member_no)? 'selected':'' } >${memVO.mb_name}
				</c:forEach>
			</select></td>
			
		<tr>
			<td>揪團標題:</td>
			<td><input type="TEXT" name="group_title" size="45"
				 value="<%= (groupVO==null)? "" : groupVO.getGroup_title() %>" /></td>
		</tr>
			
			
		<tr>
			<td>需求人數:</td>
			<td><input type="text" name="required_cnt" size="45"
				 value="<%= (groupVO==null) ? "1" : groupVO.getRequired_cnt() %>" /></td>
		</tr>
		
		<tr>
			<td>揪團狀態:<font color=red></font></td>
			<td><select size="1" name="group_status">
					<option value="0" ${(groupVO.group_status==0)?'selected':''} >揪團中(0)</option>
					<option value="1" ${(groupVO.group_status==1)?'selected':''}>等待團員付款中(1)</option>
					<option value="2" ${(groupVO.group_status==2)?'selected':''}>正常出團，結束(2)</option>
					<option value="3" ${(groupVO.group_status==3)?'selected':''}>條件失敗，結束(3)</option>
			</select></td>
		</tr>
		
		<tr>
			<td>揪團說明:</td>
			<td>
			<textarea name="desc" cols="42" rows="4"><%= (groupVO==null)? "" : groupVO.getDesc() %></textarea>
			</td>
		</tr>
		
		<tr>
		<td>截止時間</td>
			<td><input name="deadline_dt" id="f_date1" type="text" ></td>
		</tr>
	</table>
	<input type="hidden" name="action" value="update">
	<input type="hidden" name="group_no" value="<%=groupVO.getGroup_no()%>">
	<input type="submit" value="送出修改" class="btn btn-info"></FORM>
	
	<!-- <br>送出修改的來源網頁路徑:<br><b> -->
	<%--    <font color=blue>request.getParameter("requestURL"):</font> <%=request.getParameter("requestURL")%><br> --%>
	<%--    <font color=blue>request.getParameter("whichPage"): </font> <%=request.getParameter("whichPage")%> (此範例目前只用於:istAllEmp.jsp))</b> --%>

</div>
</body>





<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
  java.sql.Timestamp deadline_dt = null;
  try {
	  deadline_dt = groupVO.getDeadline_dt();
 } catch (Exception e) {
	 deadline_dt = new java.sql.Timestamp(System.currentTimeMillis());
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
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value: '<%=deadline_dt%>', // value:   new Timestamp(),
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