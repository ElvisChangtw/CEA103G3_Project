<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="org.json.JSONObject"%>

<%
  MemVO memVO = (MemVO) request.getAttribute("memVO");
%>

<%= memVO==null%> 
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>會員資料修改 - update_mem.jsp</title>

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
  tr td img {
  	width:150px;
  	height:150px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>會員資料修改 - update_mem.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/mem/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>會員編號:<font color=red><b>*</b></font></td>
		<td><%=memVO.getMember_no()%></td>
	</tr>
	<tr>
		<td>會員姓名:</td>
		<td><input type="TEXT" name="mb_name" size="45" 
			 value="<%= (memVO==null)? "" : memVO.getMb_name()%>" /></td>
	</tr>
	<tr>
		<td>會員信箱:</td>
		<td><input type="TEXT" name="mb_email" size="45"
			 value="<%= (memVO==null)? "" : memVO.getMb_email()%>" /></td>
	</tr>
	<tr>
		<td>會員密碼:</td>
		<td><input type="password" name="mb_pwd" size="45"
			 value="<%= (memVO==null)? "" : memVO.getMb_pwd()%>" /></td>
	</tr>
	<tr>
		<td>會員生日:</td>
		<td><input type="TEXT" name="mb_bd" id="f_date1"></td>
	</tr>
	<tr>
		<td>會員電話:</td>
		<td><input type="TEXT" name="mb_phone" size="45"
			 value="<%= (memVO==null)? "" : memVO.getMb_phone()%>" /></td>
	</tr>
	<tr>
		<td>居住縣市:</td>
		<td><select id="city" name="city"></select><select id="area" name="area"></select></td>
	</tr>
	<tr>
		<td>會員地址:</td>
		<td><input type="TEXT" name="mb_address" size="45"
			 value="<%= (memVO==null)? "" : memVO.getMb_address()%>" /></td>
	</tr>
	<tr>
		<td>會員照片:</td>
		<td><img src="${pageContext.request.contextPath}/mem/mem.do?action=view_memPic&member_no=${memVO.member_no}"><br>
		<input type="FILE" name="mb_pic" accept="image/*"/></td>
	</tr>
	<tr>
		<td>會員狀態:</td>
		<td>
			<select name="status">
				<option value="0" <%= (memVO.getStatus().equals("0")? "selected":"")%>>審核中</option>
				<option value="1" <%= (memVO.getStatus().equals("1")? "selected":"")%>>已通過審核</option>
				<option value="2" <%= (memVO.getStatus().equals("2")? "selected":"")%>>已停權</option>
				<option value="3" <%= (memVO.getStatus().equals("3")? "selected":"")%>>已停用</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<td>會員積分:</td>
		<td><input type="TEXT" name="mb_point" size="45"
			 value="<%= (memVO==null)? "" : memVO.getMb_point()%>" /></td>
	</tr>
	
	<tr>
		<td>會員身分:</td>
		<td>
			<select name="mb_level">
				<option value="1" <%= (memVO.getMb_level().equals("1")? "selected":"")%>>一般會員</option>
				<option value="2" <%= (memVO.getMb_level().equals("2")? "selected":"")%>>專職影評</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<td>會員註冊日:</td>
		<td><input type="TEXT" name="crt_dt" id="f_date2"></td>
	</tr>
	

</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" id="member_no" name="member_no" value="<%=memVO.getMember_no()%>">
<input type="submit" id="btn" value="送出修改" ></FORM>
</body>
<script src="<%=request.getContextPath()%>/js/city_area.js"></script>
<script type="text/javascript">

window.onload= function(){
	var xhr = new XMLHttpRequest();
	 xhr.onreadystatechange = function(){
		 if(xhr.readyState==4){
			 if(xhr.status==200){
				 getCityArea(xhr.responseText);
			 }else{
				 alert(xhr.status);
			 }
		 }
	 }
    var url ="/CEA103G3/mem/mem.do";
	 xhr.open("POST", url, true);
	 xhr.setRequestHeader("content-type","application/x-www-form-urlencoded");
	 let data_info ="action=ajaxGetCityArea&member_no="+document.getElementById("member_no").value;
	 xhr.send(data_info);
}
    function getCityArea(json){
       var cityArea = JSON.parse(json);
       AddressSeleclList.Initialize('city', 'area',cityArea.city,cityArea.city,cityArea.area,cityArea.area);
    };

    
    
	 
</script>
<% 
  java.sql.Date mb_bd = null;
  try {
	  mb_bd = memVO.getMb_bd();
   } catch (Exception e) {
	   mb_bd = new java.sql.Date(System.currentTimeMillis());
   }
%>
<% 
  java.sql.Date crt_dt = null;
  try {
	  crt_dt = memVO.getCrt_dt();
   } catch (Exception e) {
	   mb_bd = new java.sql.Date(System.currentTimeMillis());
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
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=mb_bd%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
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
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
</script>
</html>