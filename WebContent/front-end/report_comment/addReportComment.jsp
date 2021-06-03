<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.report_comment.model.*"%>

<%
	ReportCommentVO reportCommentVO = (ReportCommentVO) request.getAttribute("reportCommentVO");
%>
<jsp:useBean id="memVO" scope="session" type="com.mem.model.MemVO" />
<jsp:useBean id="commentSvc" scope="page" class="com.comment.model.CommentService" />
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>新增檢舉評論</title>

<style> 
    body {     
       width: 600px;     
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
   #mic{
	width: 45px;
    height: 40px;
    cursor: pointer; 
} 
</style>
<style>

.zi_box_1 {
border: 2px solid #FEA36D;/* 框線顏色 */
border-radius: 4px;
margin: 2em 0;
padding: 20px;
position: relative;

}
.zi_box_1::before {
background-color: #fff;
color: #FEA36D;
content: "評論作者 /內容"; /*標題*/
font-weight: bold;
left: 1em;
padding: 0 .5em;
position: absolute;
top: -1em;
}
</style>


</head>
<body>

<h1 class="shadow p-3 mb-1  rounded" align="center" style="background-color:#585252;" >
	<span class="badge badge-secondary" style="background-color:#585252;">
		新增檢舉評論
	</span>
</h1>

<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤 : ${errorMsgs.content}</font>
</c:if>

<%-- <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_comment/reportcomment.do" name="form1" id="add-form" onclick="return false"> --%>
<%-- <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_comment/reportcomment.do" name="form1" id="add-form"> --%>
<table id="back">
	<tr>
		<c:forEach var="commentVO" items="${commentSvc.all}">
			<c:if test="${param.commentno == commentVO.commentno}">
				<td >
					<div class="zi_box_1" style="border-width: 3px; border-style:solid ; width: 555px; border-color: #FEA36D; padding: 5px; text-align: left;">
						<img id="memberpic" src="${pageContext.request.contextPath}/mem/mem.do?action=view_memPic&member_no=${commentVO.memberno}" 
							style="border-radius:50%; width:60px; height:60px; float: left; margin-right: 20px;">
						${commentVO.content}
					</div>
				</td>
			</c:if>
		</c:forEach>
	</tr>


	<tr>
		<td>
			<span class="badge badge-danger" style="font-size:20px; background-color:#D66B75; margin:5px 5px 5px 5px">檢舉評論原因</span>
			<img id="mic"src="<%=request.getContextPath()%>/images/MicReady.png">
		</td>
	</tr>	
	<tr>
		<td><textarea id="content-1" name="content" rows="5" cols="73" maxlength="300" style="border-width: 3px; border-color: #D66B75; resize:none;" >${reportCommentVO.content}</textarea></td>
	</tr>	


</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="hidden" name="commentno" value="<%=request.getParameter("commentno")%>">
<input type="hidden" name="memberno" value="<%=request.getParameter("memberno")%>">
<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
<center><input type="submit" value="送出檢舉" class="btn btn-outline-danger" id="add-btn"></center>
<!-- </FORM> -->

</body>

<!-- <br>送出修改的來源網頁路徑:<br><b> -->
<%--    <font color=blue>request.getParameter("requestURL"):</font> <%=request.getParameter("requestURL")%><br> --%>
<%--    <font color=blue>request.getParameter("whichPage"): </font> <%=request.getParameter("whichPage")%> (此範例目前只用於:istAllComment.jsp))</b> --%>
<!-- </body> -->



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
  	       timepicker:false,       //timepicker:true,
  	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
  	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
  		   value: '', // value:   new Date(),
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

<script>
function sweet(){
	
	Swal.fire({
        position: "center",
        icon: "success",
        title: "檢舉成功",
        showConfirmButton: false,
        timer: 1500,
    });
	
	setTimeout(function(){
		document.location.href="<%=request.getContextPath()%>/movie/movie.do?action=getOne_For_Display&movieno=${param.movieno}";
	}, 1500);
}

function nosweet(){

	Swal.fire({
		  icon: 'error',
		  title: '檢舉失敗',
		  text: '檢舉原因請勿空白',
		  width: 600,
		  padding: '3em',
		  background: '#fff url(/images/trees.png)',
		  backdrop: `
		    rgba(0,0,0,0.4)
		    url("<%=request.getContextPath()%>/images/gif/1.gif")
		    left center
		    no-repeat
  		`
	})
}

function sendReport(){
	
	let content = $("#content-1").val();
	let commentno = "${param.commentno}";
	let memberno = "${memVO.member_no}";
	
	$.ajax({
		url:"<%=request.getContextPath()%>/report_comment/reportcomment.do",
		data:{
			commentno: "${param.commentno}",
			content: $('#content-1').val(),
			memberno:"${memVO.member_no}",
			action:"insert"
		},
		async: false,
		type:"POST",
		success:function(json){
			let jsonobj = JSON.parse(json);
			let problem = jsonobj.problem;
			console.log(problem);
			if (problem==0){
				sweet();
			}else{
				nosweet();
			}
		}
	});
}


$(document).ready(function(){
	$("#add-btn").click(function(){
		sendReport();
	})
})



</script>

<script>
$("#mic").on("click", function(){
	$("#mic").attr("src","<%=request.getContextPath()%>/images/MicUsing.gif");  
// 	var show = document.getElementById('show');
    var recognition = new webkitSpeechRecognition();
    recognition.continuous = true;
    recognition.interimResults = true;
    recognition.lang = "cmn-Hant-TW";
    recognition.onstart = function() {
        console.log('開始辨識...');
    };
    recognition.onend = function() {
//     	$("#mic").setAttribute("disabled", "disabled");
    	$("#mic").attr("src","<%=request.getContextPath()%>/images/MicReady.png");  
        console.log('停止辨識!');
        
    };
    recognition.onresult = function(event) {
    	
        var i = event.resultIndex;
        var j = event.results[i].length - 1;
//         show.innerHTML = event.results[i][j].transcript;

		if(event.results[i][j].transcript.indexOf("停止") > -1){
			$("#content-1").html("");
			recognition.stop();
			Swal.fire({
                position: "center",
                icon: "success",
                title: "停止辨識",
                showConfirmButton: false,
                timer: 1300,
            });
			
		} else if(event.results[i][j].transcript.indexOf("送出")> -1 
		){
			
			if(event.results[i].isFinal === true){
				var string = event.results[i][j].transcript;
				var NewArray = new Array();
				var NewArray = string.split("送");
				$("#content-1").val(NewArray[0]);
				sendReport();
			}
			
// 			$("#content-1").html("");
// 			recognition.stop();
// 			sendReport();
		}else if(event.results[i][j].transcript.indexOf("清除")> -1 ||
				event.results[i][j].transcript.indexOf("清楚")> -1
		){
			$("#content-1").html("");
		}else if(event.results[i][j].transcript.indexOf("安安")> -1 
		){
			$("#memberpic").attr("src", "<%=request.getContextPath()%>/images/大吳.jpg");
			
		}else if(event.results[i][j].transcript.indexOf("你好")> -1 
		){
			$("#mic").attr("src","<%=request.getContextPath()%>/images/小吳.jpg");
		}
		else{
			$("#content-1").val(event.results[i][j].transcript);
		}
    };
    recognition.start();
});

</script>
</html>