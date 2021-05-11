<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.group.model.*"%>
<html>
<head>

<title>IBM Group_Member: Home</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
<style>

</style>
<%
GroupVO groupVO = (GroupVO) request.getAttribute("groupVO");
%>
<jsp:useBean id="groupSvc" scope="page"	class="com.group.model.GroupService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<style>
body{
	background-image: linear-gradient(#ddd6f3,#faaca8);
}
#display {
/* 	background-color:lightgray; */
	font-size:1rem;
	width:75%;
/* 	margin: 0 auto; */
}
table#table-1 {
	width: 60%;
	background-color: #E0EAFC;
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

</style>

</head>
<body>
	<div id="display">
	<table id="table-1">
		<tr>
			<td><h3><em>IBM Group_Member: Home</em></h3>
				<h4><em>( MVC )</h4></em></td>
		</tr>
	</table>

	<p>This is the Home page for IBM Group_Member: Home</p>

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
		<li>
			<FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/group/group.do">
				<div class="form-group">
				<b>輸入揪團編號:</b> <input type="text" name="group_no"> 
				<input type="hidden" name="action" value="listMembers_ByGroupno_A"> 
				<input type="submit" class="btn btn-primary btn-sm" value="送出">
				</div>
			</FORM>
		</li>		

		<li>
			<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/group/group.do">

<!-- 				<b>選擇揪團編號:</b>  -->
				<label for="exampleFormControlSelect1">選擇揪團編號:</label>
				<select size="1" name="group_no" id="exampleFormControlSelect1">
					<c:forEach var="groupVO" items="${groupSvc.all}">
						<option value="${groupVO.group_no}">${groupVO.group_no}
					</c:forEach>
				</select> 
				<input type="hidden" name="action" value="listMembers_ByGroupno_A">
				<input type="submit" value="送出" class="btn btn-primary btn-sm">
			</FORM>
		</li>

		
		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group/group.do">
				<b><font color=orange>選擇揪團標題:</font></b> 
				<select size="1" name="group_no">
					<c:forEach var="groupVO" items="${groupSvc.all}">
						<option value="${groupVO.group_no}">${groupVO.group_title}
					</c:forEach>
				</select> 
				<input type="hidden" name="action" value="listMembers_ByGroupno_A">
				<input type="submit" value="送出" class="btn btn-primary btn-sm"> 
				</FORM>
		</li>

		<li>
			<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/group_member/group_member.do">
				<b>輸入會員編號:</b> <input type="text" name="member_no">
				<input type="hidden" name="action" value="GetGroupsByMember">
				<input type="submit" value="送出" class="btn btn-primary btn-sm">
				
			</FORM>
		</li>

		<li>
			<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/group_member/group_member.do">
				<b>選擇會員編號:</b> 
				<select size="1" name="member_no">
					<c:forEach var="memVO" items="${memSvc.all}">
						<option value="${memVO.member_no}">${memVO.member_no}
					</c:forEach>
				</select> 
				<input type="hidden" name="action" value="GetGroupsByMember">
				<input type="submit" value="送出" class="btn btn-primary btn-sm">
			</FORM>
		</li>

		<li>
			<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/group_member/group_member.do">
				<b>選擇會員名稱:</b> <select size="1" name="member_no">
					<c:forEach var="memVO" items="${memSvc.all}">
						<option value="${memVO.member_no}">${memVO.mb_name}
					</c:forEach>
				</select> 
				<input type="hidden" name="action" value="GetGroupsByMember">
				<input type="submit" value="送出" class="btn btn-primary btn-sm">
			</FORM>
		</li>
	</ul>


	<%-- 萬用複合查詢-以下欄位-可隨意增減 --%>
	<ul>
		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group_member/group_member.do"
				name="form1">
				<b><font color=blue>萬用複合查詢:</font></b> <br> 
				<b>選擇揪團:</b>
				<select size="1" name="group_no">
					<option value="">
						<c:forEach var="groupVO" items="${groupSvc.all}">
							<option value="${groupVO.group_no}">${groupVO.group_title}
						</c:forEach>
				</select><br>
				<b>選擇會員:</b>
				<select size="1" name="member_no">
					<option value="">
					<c:forEach var="memVO" items="${memSvc.all}">
						<option value="${memVO.member_no}">${memVO.mb_name}
					</c:forEach>
				</select><br> 
				
				<b>付款狀態:</b><font color=red></font>
				<select size="1" name="pay_status">
					<option value="">
						<option value="0">未付款</option>
						<option value="1">已付款</option>
				</select><br>
	
				<b>成員狀態:</b><font color=red></font>
				<select size="1" name="status">
					<option value="">
						<option value="0">已退出</option>
						<option value="1">已加入</option>
				</select><br>

				<b>加入日期:</b> 
				<input name="crt_dt" id="f_date1" type="text" > 
				 ~ 
				<input name="crt_dt_end" id="f_date2" type="text" > 
				<input type="hidden" name="action" value="listMembers_ByCompositeQuery">
				<br>
				<input type="submit" value="送出" class="btn btn-primary btn-sm"> 
			</FORM>
		</li>
	</ul>
	
	
	<%-- 揪團複合查詢-以下欄位-可隨意增減 --%>
	<ul>
		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/group/group.do"
				name="form1">
				<b><font color=blue>萬用複合查詢:</font></b> <br> 
				<b>選擇揪團:</b>
				<select size="1" name="group_no">
					<option value="">
						<c:forEach var="groupVO" items="${groupSvc.all}">
							<option value="${groupVO.group_no}">${groupVO.group_title}
						</c:forEach>
				</select><br>
				<input type="hidden" name="action" value="listGroups_ByCompositeQuery">
				<br>
				<input type="submit" value="送出" class="btn btn-primary btn-sm"> 
			</FORM>
		</li>
	</ul>
	
	
	
	
	<h3>揪團管理</h3>

	<ul>
		<li>
			<a href='<%=request.getContextPath()%>/front-end/group/group_front_page.jsp'>揪團首頁 </a>
		</li>
		<li>
			<a href='<%=request.getContextPath()%>/front-end/group/listAllGroup.jsp'>List </a>
			all Groups.
		</li>
		<li>
			<a href='<%=request.getContextPath()%>/front-end/group/addGroup.jsp'>Add </a>a new Group.
		</li>
	</ul>
	
	
	<h3>揪團會員管理</h3>
	<ul>
		<li><a
			href='<%=request.getContextPath()%>/front-end/group_member/listAllGroup_Member.jsp'>List</a>
			all Group_Members</li>
		<li><a
			href='<%=request.getContextPath()%>/front-end/group_member/addGroup_Member.jsp'>Add</a>
			a new Group_Member.</li>
	</ul>
	
	
	
	<h3>揪團檢舉管理</h3>
	<ul>
		<li><a
			href='<%=request.getContextPath()%>/front-end/report_group/listAllReport_Group.jsp'>List</a>
			all Report_Groups</li>
		<li><a
			href='<%=request.getContextPath()%>/front-end/report_group/addReport_Group.jsp'>Add</a>
			a new Report_Group.</li>
	</ul>
</div>
</body>

<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->
<% 
  java.sql.Timestamp crt_dt = null;
  java.sql.Timestamp crt_dt_end = null;
  final long DIFF = System.currentTimeMillis() - (1000 * 60 * 60 *24 * 14); //30天前
  
	crt_dt = new java.sql.Timestamp(DIFF);
// 	System.out.println("crt_dt = " + crt_dt);
	
	crt_dt_end = new java.sql.Timestamp(System.currentTimeMillis());
// 	System.out.println("crt_dt_end = " + crt_dt_end);


%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
 	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
		   value: ''    // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        $('#f_date2').datetimepicker({
  	       theme: '',              //theme: 'dark',
 	       timepicker:true,       //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
 		   value: ''    // value:   new Date(),
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