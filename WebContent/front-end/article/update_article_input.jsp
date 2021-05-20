<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.article.model.*"%>

<%
	ArticleVO articleVO = (ArticleVO) request.getAttribute("articleVO"); //ArticleArticleServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>
<%-- <%= articleVO==null %> --%>
<html>
<head>
<link href="https://i2.bahamut.com.tw/css/basic.css?v=1618977484" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>文章資料修改 - update_article_input.jsp</title>

<style>
  body {   
      width: 640px;   
      margin: 0 auto;   
      padding: 20px 20px 20px 20px;   
     
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
/*     color: blue; */
    display: inline;
  }
</style>

<style>
  table {
	width: 600px;
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

<!-- <table id="table-1"> -->
<!-- 	<tr><td> -->
<!-- 		 <h3>員工資料修改 - update_article_input.jsp</h3> -->
<!-- 		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4> -->
<!-- 	</td></tr> -->
<!-- </table> -->

<h1 class="shadow p-3 mb-2 bg-white rounded">
	<span class="badge badge-secondary">
		修改文章
	</span>
</h1>	

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/article/article.do" name="form1">
<table>
	<tr>
		<td><h4>文章編號:</h4><font color=red><b>*</b></font></td>
		<td><h4><%=articleVO.getArticleno()%></h4></td>	
	</tr>
<!-- 	<tr> -->
<!-- 		<td>會員編號:</td> -->
<%-- 		<input type="hidden" name="memberno" size="45" value="<%=articleVO.getMemberno()%>" /> --%>
<!-- 	</tr> -->
	
	<jsp:useBean id="topicSvc" scope="page" class="com.topic.model.TopicService" />
	
	<tr>
		<td><h4>文章標題:</h4></td>
		<td><textarea type="hidden" name="articleheadline" cols="60"  rows="2"><%=articleVO.getArticleheadline()%></textarea></td>
	</tr>	
		
	<tr>
		<td><h4>文章內容:</h4></td>
		<td><textarea type="hidden" name="content" cols="60"  rows="15"><%=articleVO.getContent()%></textarea></td>
	</tr>	
			 				
	<tr>
		<td><h4>文章類型:</h4><font color=red><b>*</b></font></td>
		<td><select size="1" name="articletype">
			<c:forEach var="topicVO" items="${topicSvc.all}">
				<option value="${topicVO.topicno}" ${(articleVO.articletype==topicVO.topicno)? 'selected':'' } >${topicVO.topic}
			</c:forEach>
		</select></td>
	</tr>
				
<!-- 	<tr> -->
<!-- 		<td>新增文章時間:</td> -->
<!-- 			<td><input name="crtdt" id="f_date1" type="text" ></td> -->
<%-- <%-- 		<td><input type="TEXT" name="crtdt" size="45"	value="<%=articleVO.getCrtdt()%>" /></td> --%>
<!-- 	</tr> -->
	
<!-- 	<tr> -->
<!-- 		<td>更新文章時間:</td> -->
<!-- 			<td><input name="updatedt" id="f_date2" type="text" ></td> -->
<%-- <%-- 		<td><input type="TEXT" name="updatedt" size="45"	value="<%=articleVO.getUpdatedt()%>" /></td> --%>
<!-- 	</tr>	 -->
	
<!-- 	<tr> -->
<!-- 		<td>文章狀態:</td> -->
<%-- 		<td><input type="TEXT" name="status" size="45"	value="<%=articleVO.getStatus()%>" /></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>點讚數:</td> -->
<%-- 		<td><input type="TEXT" name="likecount" size="45" value="<%=articleVO.getLikecount()%>" /></td> --%>
<!-- 	</tr>	 -->
	
	
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="memberno" value="<%=articleVO.getMemberno()%>" />
<input type="hidden" name="articleno" value="<%=articleVO.getArticleno()%>">
<input type="hidden" name="requestURL"	value="${param.requestURL}"> 
<!-- 接到listOneArticle2.jsp傳到ArticleServlet -->
 <center><input type="submit" value="送出修改" class="btn btn-danger"></center></FORM>
</body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

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
			value: '<%=articleVO.getCrtdt()%>', 
			//value:   new Date(),
		   //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
		   //startDate:	            '2017/07/10',  // 起始日
		   //minDate:               '-1970-01-01', // 去除今日(不含)之前
		   //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
		});
				
		$.datetimepicker.setLocale('zh');
		$('#f_date2').datetimepicker({
		   theme: '',              //theme: 'dark',
		    timepicker:true,       //timepicker:true,
		    step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
		    format:'Y-m-d H:i:s',         //format:'Y-m-d H:i:s',
			value: '<%=articleVO.getUpdatedt()%>', 
			//value:   new Date(),
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