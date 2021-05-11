<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Reply: Home</title>

<style>
  table#table-1 {
	width: 800px;
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
   <tr><td><h3>IBM Reply: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Reply: Home</p>

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/reply/listAllReply.jsp'>List</a> all Reply.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reply/reply.do" >
        <b>輸入回復編號 (如1~10):</b>
        <input type="text" name="reply_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="replySvc" scope="page" class="com.reply.model.ReplyService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reply/reply.do" >
       <b>選擇回復編號:</b>
       <select size="1" name="reply_no">
         <c:forEach var="replyVO" items="${replySvc.all}" > 
          <option value="${replyVO.reply_no}">${replyVO.reply_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reply/reply.do" >
       <b>選擇文章編號:</b>
       <select size="1" name="reply_no">
         <c:forEach var="replyVO" items="${replySvc.all}" > 
          <option value="${replyVO.reply_no}">${replyVO.article_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
 		
 		<jsp:useBean id="articleSvc" scope="page" class="com.article.model.ArticleService" />

    <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/article/article.do" >
       <b><font color=orange>選擇文章標題(0403):</font></b>
       <select size="1" name="articleno">
         <c:forEach var="articleVO" items="${articleSvc.all}" > 
          <option value="${articleVO.articleno}">${articleVO.articleheadline}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="listReplys_ByArticleno_A">
     </FORM>
  </li>
</ul>

<%-- 萬用複合查詢-以下欄位-可隨意增減 --%>
<ul>  
  <li>   
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/reply/reply.do" name="form1">
        <b><font color=blue>萬用複合查詢:</font></b> <br>
        <b>輸入回復編號:</b>
        <input type="text" name="reply_no" value=""><br>
        
        <b>選擇文章標題:</b>
        <select size="1" name="article_no" >
          <option value="">
         <c:forEach var="articleVO" items="${articleSvc.all}" > 
          <option value="${articleVO.articleno}">${articleVO.articleheadline}
         </c:forEach>   
        </select><br>
      
       <b>輸入會員編號:</b>
       <input type="text" name="member_no" value=""><br>
       
       <b>輸入回復內容:</b>
       <input type="text" name="content" value=""><br>
          
       <b>新增回復日期:</b>
	   <input name="crt_dt" id="f_date1" type="text"><br>
	   
	   <b>更新回復日期:</b>
	   <input name="modify_dt" id="f_date2" type="text"><br>
	   
	   <b>輸入回復狀態:</b>
       <input type="text" name="status" value=""><br>
		        
        <input type="submit" value="送出">
        <input type="hidden" name="action" value="listReplys_ByCompositeQuery">
     </FORM>
  </li>
</ul>


<h3>回復管理:</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/reply/addReply.jsp'>Add</a> a new Reply.</li>
</ul>

<h3><font color=orange>文章管理(0403):</font></h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/article/listAllArticle.jsp'>List</a> all Articles. </li>
</ul>

</body>

<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

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
		   value: '',              // value:   new Date(),
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
		   value: '',              // value:   new Date(),
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