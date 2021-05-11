<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.order.model.*"%>

<%
  OrderVO orderVO = (OrderVO) request.getAttribute("orderVO");
%>
<%= orderVO==null %>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>訂單資料新增 - addTheater.jsp</title>

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
</style>


</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>訂單資料新增 - addOrder.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/order/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/theater/images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/order/order.do" name="form1">
<table>
<!-- 	<tr> -->
<!-- 		<td>訂單編號</td> -->
<!-- 		<td> -->
<%-- 			<td>${orderVO.order_no}</td> --%>
<!-- 		</td> -->
<!-- 	</tr> -->
	<tr>
		<td>會員編號</td>
		
		<td>
			<input type="text" name="member_no" value="${orderVO==null ? '' : orderVO.member_no}">
<!-- 			<select name="theater_no"> -->
<%-- 				<c:forEach var="theaterVO" items="${theaterSvc.all}" > --%>
<%-- 					<option value= "${theaterVO.theater_no}">${theaterVO.theater_name}</option> --%>
<%-- 				</c:forEach> --%>
<!-- 			</select> -->
		</td>
	</tr>
	
	<tr>
		<td>場次編號</td>
		<td>
			<input type="text" name="showtime_no" value="${orderVO==null ? '' : orderVO.showtime_no}">
		</td>
	</tr>
	
	<tr>
		<td>創建時間</td>
		<td>
			<input name="crt_dt" id="f_date1" type="text" value="${orderVO==null ? '' : orderVO.crt_dt}">
		</td>
	</tr>
	
	<tr>
		<td>訂單狀態</td>
		
		<td>
			<select name="order_status">
					<option value= "0" ${orderVO.order_status == 0 ? "selected" : ""}>未付款</option>
					<option value= "1" ${orderVO.order_status == 1 ? "selected" : ""}>已付款</option>
					<option value= "2" ${orderVO.order_status == 2 ? "selected" : ""}>已取消</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<td>會員編號</td>
		
		<td>
			<select name="order_type">
					<option value= "0" ${orderVO.order_type == 0 ? "selected" : ""}>現場購票</option>
					<option value= "1" ${orderVO.order_type == 1 ? "selected" : ""}>線上購票</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<td>會員編號</td>
		
		<td>
			<select name="payment_type">
					<option value= "0" ${orderVO.payment_type == 0 ? "selected" : ""}>信用卡</option>
					<option value= "1" ${orderVO.payment_type == 1 ? "selected" : ""}>現金</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<td>訂單總價</td>
		<td>
			<input type="number"  min="0" name="total_price" value="${orderVO==null ? '' : orderVO.total_price}">
		</td>
	</tr>
	
	<tr>
		<td>座位</td>
		<td>
			<input type="text" name="seat_name" value="${orderVO==null ? '' : orderVO.seat_name}">
		</td>
	</tr>
	
	
	
</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增">
</FORM>


</body>

<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
  java.sql.Timestamp crt_dt = null;
  try {
	  crt_dt = orderVO.getCrt_dt();
   } catch (Exception e) {
	   crt_dt = new java.sql.Timestamp(System.currentTimeMillis());
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
		   value: '<%=crt_dt%>', // value:   new Date(),
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