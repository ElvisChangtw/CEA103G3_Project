<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.movie.model.*"%>

<%
	MovieVO movieVO = (MovieVO) request.getAttribute("movieVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>
<%-- <%= empVO==null %>--${empVO.deptno}-- --%>
movieVO. === ${movieVO.grade} movieVO.grade.equals("0") ===
${movieVO.grade.equals("0")}
${movieVO.category.contains("動作片")}
<html>
<head>
<title>後台 修改電影</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Movies Pro Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- //for-mobile-apps -->
<link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<!-- pop-up -->
<link href="<%=request.getContextPath()%>/css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
<!-- //pop-up -->
<link href="<%=request.getContextPath()%>/css/easy-responsive-tabs.css" rel='stylesheet' type='text/css'/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/zoomslider.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/table-style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/basictable.css" />
<!-- list-css -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/list.css" type="text/css" media="all" />
<!-- //list-css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
<link href="<%=request.getContextPath()%>/css/font-awesome.css" rel="stylesheet"> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/modernizr-2.6.2.min.js"></script>
<!--/web-fonts-->
<link href='//fonts.googleapis.com/css?family=Tangerine:400,700' rel='stylesheet' type='text/css'>
<link href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900" rel="stylesheet">
<link href='//fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
<!--//web-fonts-->
<script src="https://unpkg.com/ionicons@5.4.0/dist/ionicons.js"></script>	
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>

<style>
tr td>img {
	width: 180px;
	height: 200px;
}

#th1{
	width: 150px;
	height:100px;
	align:center;
}
#th2{
	width: 50px;
	align:center;
}
#th3{
	width: 150px;
	align:right;
}
#send{
align:center;	
color:red;
}
</style>

<script>
function readURL(input){
  if(input.files && input.files[0]){
    var imageTagID = input.getAttribute("targetID");
    var reader = new FileReader();
    reader.onload = function (e) {
       var img = document.getElementById(imageTagID);
       img.setAttribute("src", e.target.result)
    }
    reader.readAsDataURL(input.files[0]);
  }
}
</script>


</head>
<body>
	
<!--/content-inner-section-->
	<div class="w3_content_agilleinfo_inner">
		<div class="agile_featured_movies">
			<div class="inner-agile-w3l-part-head">
		    	<h3 class="w3l-inner-h-title">後台 修改電影</h3>
			</div>
	        <div class="bs-example bs-example-tabs" role="tabpanel" data-example-id="togglable-tabs">
				<div id="myTabContent" class="tab-content">
					<div role="tabpanel" class="tab-pane fade in active" id="home" aria-labelledby="home-tab">
						<div class="agile-news-table">
							
							<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" name="form1" enctype="multipart/form-data">
							<table>
								<thead class="thead">
								  <tr>
								  	<th id="th1">電影編號</th>
								  	<th id="th2"><%=movieVO.getMovieno()%></th>
<!-- 								  	<th id="th3">&emsp;&emsp;&emsp;&emsp;&emsp;<input type="submit" value="送出修改" class="btn btn-outline-primary" id="send"></th> -->
								  	<th></th>
								  </tr>
								</thead>
								<tbody>
									<tr>
										<td>電影名稱:</td>
										<td ><input type="TEXT" name="moviename" size="70"
											value="<%=(movieVO.getMoviename() == null) ? "" : movieVO.getMoviename()%>" /></td>
<!-- 										<td colspan="1" rowspan="3" style="vertical-align:text-top; bgcolor=white"> -->
<%-- 											<c:if test="${not empty errorMsgs}"> --%>
<!-- 												<font style="color: red">請修正以下錯誤:</font> -->
<!-- 												<ul> -->
<%-- 													<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 														<li style="color: red">${message}</li> --%>
<%-- 													</c:forEach> --%>
<!-- 												</ul> -->
<%-- 											</c:if> --%>
<!-- 										</td> -->
										<td >${errorMsgs.moviename}</td>
									</tr>
									<tr>
										<td>電影照片1:</td>
										<td>
										<img id="preview_img" src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}">
										<input multiple type="file" name="moviepicture1" accept="image/*" onchange="readURL(this)" targetID="preview_img"
										value="<%=(movieVO.getMoviepicture1() == null) ? "" : movieVO.getMoviepicture1()%>" /></td>
<!-- 										<td colspan="1"></td> -->
										<td >${errorMsgs.moviepicture1}</td> 
									</tr>	
									<tr>
										<td>電影照片2:</td>
										<td>
										<img id="preview_img2" src="${pageContext.request.contextPath}/movie/DBGifReader2.do?movieno=${movieVO.movieno}"">
										<input multiple type="file" name="moviepicture2" accept="image/*" onchange="readURL(this)" targetID="preview_img2"
										value="<%=(movieVO.getMoviepicture2() == null) ? "" : movieVO.getMoviepicture2()%>" /></td>
<!-- 										<td colspan="1"></td> -->
										<td >${errorMsgs.moviepicture2}</td> 
									</tr>	
									<tr>
										<td>導演:</td>
										<td><input type="TEXT" name="director" size="70"
											value="<%=(movieVO.getDirector() == null) ? "" : movieVO.getDirector()%>" /></td>
<!-- 										<td colspan="1"></td> -->
										<td >${errorMsgs.director}</td>
									</tr>
									<tr>
										<td>演員:</td>
										<td><textarea name="actor" rows="5" cols="70" maxlength="300"><%=(movieVO.getActor() == null) ? "" : movieVO.getActor()%></textarea></td>
<!-- 										<td><input type="TEXT" name="actor" size="70" -->
<%-- 											value="<%=(movieVO == null) ? "" : movieVO.getActor()%>" /></td> --%>
<!-- 										<td colspan="1"></td> -->
										<td >${errorMsgs.actor}</td>
									</tr>
									<tr>
										<td>電影類型:</td>
										<td>
										<input type="checkbox" name="category" value="動作片" <%= movieVO.getCategory().contains("動作片") ? "checked" : "" %>>動作片
										<input type="checkbox" name="category" value="冒險片" <%= movieVO.getCategory().contains("冒險片") ? "checked" : "" %>>冒險片
										<input type="checkbox" name="category" value="科幻片" <%= movieVO.getCategory().contains("科幻片") ? "checked" : "" %>>科幻片
										<input type="checkbox" name="category" value="劇情片" <%= movieVO.getCategory().contains("劇情片") ? "checked" : "" %>>劇情片
										<input type="checkbox" name="category" value="戰爭片" <%= movieVO.getCategory().contains("戰爭片") ? "checked" : "" %>>戰爭片
										<input type="checkbox" name="category" value="史詩片" <%= movieVO.getCategory().contains("史詩片") ? "checked" : "" %>>史詩片
										<input type="checkbox" name="category" value="犯罪片" <%= movieVO.getCategory().contains("犯罪片") ? "checked" : "" %>>犯罪片
										<input type="checkbox" name="category" value="警匪片" <%= movieVO.getCategory().contains("警匪片") ? "checked" : "" %>>警匪片
										<input type="checkbox" name="category" value="奇幻片" <%= movieVO.getCategory().contains("奇幻片") ? "checked" : "" %>>奇幻片
										<br>
										<input type="checkbox" name="category" value="恐怖片" <%= movieVO.getCategory().contains("恐怖片") ? "checked" : "" %>>恐怖片
										<input type="checkbox" name="category" value="驚悚片" <%= movieVO.getCategory().contains("驚悚片") ? "checked" : "" %>>驚悚片
										<input type="checkbox" name="category" value="懸疑片" <%= movieVO.getCategory().contains("懸疑片") ? "checked" : "" %>>懸疑片
										<input type="checkbox" name="category" value="喜劇片" <%= movieVO.getCategory().contains("喜劇片") ? "checked" : "" %>>喜劇片
										<input type="checkbox" name="category" value="愛情片" <%= movieVO.getCategory().contains("愛情片") ? "checked" : "" %>>愛情片
										<input type="checkbox" name="category" value="文藝片" <%= movieVO.getCategory().contains("文藝片") ? "checked" : "" %>>文藝片
										<input type="checkbox" name="category" value="動畫片" <%= movieVO.getCategory().contains("動畫片") ? "checked" : "" %>>動畫片
										<input type="checkbox" name="category" value="音樂片" <%= movieVO.getCategory().contains("音樂片") ? "checked" : "" %>>音樂片
										<input type="checkbox" name="category" value="歌舞劇" <%= movieVO.getCategory().contains("歌舞劇") ? "checked" : "" %>>歌舞劇
										</td>
<!-- 										<td colspan="1"></td> -->
										<td >${errorMsgs.category}</td>
									</tr>
									<tr>
										<td>電影長度:</td>
										<td><input type="TEXT" name="length" size="70"
											value="<%=(movieVO.getLength() == null) ? "" : movieVO.getLength()%>" /></td>
<!-- 										<td colspan="1"></td> -->
										<td >${errorMsgs.length}</td>
									</tr>
									<tr>
										<td>電影狀態:</td>
										<td><select name="status" size="1">
												<option value="9"
													<%=(movieVO.getStatus().equals("9") ? "selected" : "")%>></option>
												<option value="0"
													<%=(movieVO.getStatus().equals("0") ? "selected" : "")%>>上映中</option>
												<option value="1"
													<%=(movieVO.getStatus().equals("1") ? "selected" : "")%>>未上映</option>
												<option value="2"
													<%=(movieVO.getStatus().equals("2") ? "selected" : "")%>>已下檔</option>
										</select></td>
<!-- 										<td colspan="1"></td> -->
										<td >${errorMsgs.status}</td>
									</tr>
									<tr>
										<td>上映日期:</td>
										<td><input name="premiredate" id="f_date1" type="text" value="<%=(movieVO.getPremiredate() == null) ? " " : movieVO.getPremiredate()%>"></td>
<!-- 										<td colspan="1"></td> -->
										<td >${errorMsgs.premiredate}</td>
									</tr>
									<tr>
										<td>下檔日期:</td>
										<td><input name="offdate" id="f_date2" type="text"  value="<%=(movieVO.getOffdate() == null) ? " " : movieVO.getOffdate()%>"></td>
<!-- 										<td colspan="1"></td> -->
										<td >${errorMsgs.offdate}</td> 

									</tr>
									<tr>
										<td>預告片:</td>
										<td><input type="TEXT" name="trailor" size="70" value="<%=(movieVO.getTrailor() == null) ? " " : movieVO.getTrailor()%>" /></td>
<!-- 										<td colspan="1"></td> -->
										<td >${errorMsgs.trailor}</td>
									</tr>
									<tr>
										<td>短預告片:</td> 
										<td><input type="TEXT" name="embed" size="70" value="<%=(movieVO.getEmbed() == null) ? " " : movieVO.getEmbed()%>" /></td>
<!-- 										<td colspan="1"></td> -->
										<td >${errorMsgs.embed}</td>
									</tr>
									<tr>
										<td>電影分級:</td>
										<td><select name="grade" size="1">
												<option value="9"
													<%=(movieVO.getGrade().equals("9") ? "selected" : "")%>></option>
												<option value="0"
													<%=(movieVO.getGrade().equals("0") ? "selected" : "")%>>普遍級</option>
												<option value="1"
													<%=(movieVO.getGrade().equals("1") ? "selected" : "")%>>保護級</option>
												<option value="2"
													<%=(movieVO.getGrade().equals("2") ? "selected" : "")%>>輔導級</option>
												<option value="3"
													<%=(movieVO.getGrade().equals("3") ? "selected" : "")%>>限制級</option>
										</select></td>
<!-- 										<td colspan="1"></td> -->
										<td >${errorMsgs.grade}</td>
									</tr>
									<tr>
										<td></td>
										<td></td>
										<td>
											&emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; 
											<input type="submit" value="送出修改" id="send" 
											class="btn btn-outline-danger" style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#FF4268; font-weight:bold; color:white;">
										</td>
									</tr>
								</tbody>
							</table>
							<input type="hidden" name="action" value="update"> 
							<input type="hidden" name="movieno" value="<%=movieVO.getMovieno()%>">
							<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
							<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">
						</FORM>
						</div>
					</div>
					<div class="blog-pagenat-wthree">
				</div>	
			</div>
		</div>
	</div>
</div>
<!--//content-inner-section-->




</body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script
	src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:false,       //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
 		   value: '<%=movieVO.getPremiredate()%>', // value:   new Date(),
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
 		   value: '<%=movieVO.getOffdate()%>', // value:   new Date(),
		//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
		//startDate:	            '2017/07/10',  // 起始日
		minDate : '-1970-01-01', // 去除今日(不含)之前
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