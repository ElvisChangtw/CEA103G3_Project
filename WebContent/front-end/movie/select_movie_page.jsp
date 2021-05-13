<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">

<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Movies Pro Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- //for-mobile-apps -->
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<!-- pop-up -->
<link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
<!-- //pop-up -->
<link href="css/easy-responsive-tabs.css" rel='stylesheet' type='text/css'/>
<link rel="stylesheet" type="text/css" href="css/zoomslider.css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link href="css/font-awesome.css" rel="stylesheet"> 
<script type="text/javascript" src="js/modernizr-2.6.2.min.js"></script>
<!--/web-fonts-->
<link href='//fonts.googleapis.com/css?family=Tangerine:400,700' rel='stylesheet' type='text/css'>
<link href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900" rel="stylesheet">
<link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
<!--//web-fonts-->

<title>IBM Movie: Home</title>

<style>

li.test1{
background-color:pink;
padding-left:200px;
}
input.form-control{
margin-right:10px;
}
input#li1{
margin-left:120px;
}
select.form-control-sm{
margin-left:100px;
}

ul li{
	list-style-type:none;
}

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
   <tr><td><h3>IBM Movie: Home</h3><h4>( MVC )</h4></td></tr>
</table>


  <a href="<%=request.getContextPath()%>/front-end/comment/select_comment_page.jsp" class="navbar-brand" href="#">
    <img src="<%=request.getContextPath()%>/images/comment_images/comment1.jpg" width="30" height="30" class="d-inline-block align-top" alt="">
    前往評論首頁
  </a>


<p>This is the Home page for IBM Movie: Home</p>

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


<!-- 測試套版 -->
<nav class="navbar navbar-light" style="background-color: #e3f2fd;">
<ul class="nav justify-content-end">  
  <li class="searchbar">   
  

    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" name="form1" class="form-inline my-2 my-lg-0">
       <input type="text" name="MOVIE_NAME" value="" class="form-control" placeholder="請輸入電影" id=li1><br>
       
       <input type="text" name="DIRECTOR" value="" class="form-control" placeholder="請輸入導演"><br>
       
       <input type="text" name="ACTOR" value="" class="form-control" placeholder="請輸入演員"><br>
       
       <input type="text" name="PREMIERE_DT" id="f_date1" class="form-control" placeholder="請輸入觀影日期">~
       <input type="text" name="OFF_DT" id="f_date2" class="form-control" placeholder="請輸入觀影日期" ><br>
       
       <select  name="CATEGORY" class="form-control form-control-sm" >
			<option value="">請選擇電影類型</option>
			<option value="動作片">動作片</option>
			<option value="冒險片">冒險片</option>
			<option value="科幻片">科幻片</option>
			<option value="犯罪片">犯罪片</option>
			<option value="警匪片">警匪片</option>
			<option value="喜劇片">喜劇片</option>
			<option value="劇情片">劇情片</option>
			<option value="愛情片">愛情片</option>
       </select><br>
       
       <select size="1" name="STATUS" class="form-control form-control-sm">
			<option value="">請選擇電影狀態</option>
			<option value="0">上映中</option>
			<option value="1">未上映</option>
			<option value="2">已下檔</option>
       </select><br>
    
       <select size="1" name="GRADE" class="form-control form-control-sm">
			<option value="">請選擇電影分級</option>
			<option value="0">普遍級</option>
			<option value="1">保護級</option>
			<option value="2">輔導級</option>
			<option value="3">限制級</option>
       </select><br>
       
       <select size="1" name="RATING" class="form-control form-control-sm">
			<option value="">評分大於</option>
			<option value="2">2</option>
			<option value="4">4</option>
			<option value="6">6</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="9.5">9.5</option>
       </select><br>
       
       <select size="1" name="EXPECTATION" class="form-control form-control-sm" >
			<option value="">期待度大於</option>
			<option value="0.2">20%</option>
			<option value="0.4">40%</option>
			<option value="0.6">60%</option>
			<option value="0.8">80%</option>
			<option value="0.9">90%</option>
			<option value="0.95">95%</option>
       </select><br>
       
    
<!--        <b>選擇評論:</b> -->
<!--        <select size="1" name="commentno" > -->
<!--           <option value=""> -->
<%--          <c:forEach var="commentVO" items="${commentSvc.all}" >  --%>
<%--           <option value="${commentVO.commentno}">${commentVO.moviename} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
<!--        <br> -->
<!--         <input type="submit" value="送出"> -->
<!--         <input type="hidden" name="action" value="listMovies_ByCompositeQuery"> -->
        
       
      <button class="btn btn-secondary btn-sm" type="submit" value="送出">Search</button>
      <input type="hidden" name="action" value="listMovies_ByCompositeQuery">

     </FORM>
  </li>
</ul>
</nav>





<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/movie/listAllMovie.jsp'>List</a> all Movies.  <br><br></li>
  
  
  <li class="test1">
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" >
        <b>輸入電影編號 (如1):</b>
        <input type="text" name="movieno">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="movieSvc" scope="page" class="com.movie.model.MovieService" />
   
  <li class="list-group-item list-group-item-success">
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" >
       <b>選擇電影編號:</b>
       <select size="1" name="movieno">
         <c:forEach var="movieVO" items="${movieSvc.all}" > 
          <option value="${movieVO.movieno}">${movieVO.movieno}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li class="list-group-item list-group-item-success">
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" >
       <b>選擇電影名稱:</b>
       <select size="1" name="movieno">
         <c:forEach var="movieVO" items="${movieSvc.all}" > 
          <option value="${movieVO.movieno}">${movieVO.moviename}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>




<h3>電影管理</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/back-end/movie/addMovie.jsp'>Add</a> a new Movie.</li>
</ul>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
</body>


<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
 	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '',              //value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
 	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '',              //value:   new Date(),
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
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
</script>
</html>
</html>