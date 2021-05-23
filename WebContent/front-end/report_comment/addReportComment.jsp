<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.report_comment.model.*"%>

<%
	ReportCommentVO reportCommentVO = (ReportCommentVO) request.getAttribute("reportCommentVO");
%>
<jsp:useBean id="memVO" scope="session" type="com.mem.model.MemVO" />
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<title>�s�W���|����</title>

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
</style>


</head>
<body>

<h1 class="shadow p-3 mb-1  rounded" align="center" style="background-color:#7d4627;" >
	<span class="badge badge-secondary" style="background-color:#7d4627;">
		�s�W���|����
	</span>
</h1>

<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~ : ${errorMsgs.content}</font>
</c:if>

<%-- <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_comment/reportcomment.do" name="form1" id="add-form" onclick="return false"> --%>
<%-- <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_comment/reportcomment.do" name="form1" id="add-form"> --%>
<table>

	<tr>
		<td><span class="badge badge-danger" style="font-size:20px; background-color:#729f98; margin:5px 5px 5px 5px">���|���׭�]</span></td>
	</tr>	
	<tr>
		<td><textarea id="content-1" name="content" rows="5" cols="73" maxlength="300">${reportCommentVO.content}</textarea></td>
	</tr>	


</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="hidden" name="commentno" value="<%=request.getParameter("commentno")%>">
<input type="hidden" name="memberno" value="<%=request.getParameter("memberno")%>">
<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--������e�X�ק諸�ӷ��������|��,�A�e��Controller�ǳ���椧��-->
<center><input type="submit" value="�e�X�s�W" class="btn btn-outline-danger" id="add-btn"></center>
<!-- </FORM> -->
</body>

<!-- <br>�e�X�ק諸�ӷ��������|:<br><b> -->
<%--    <font color=blue>request.getParameter("requestURL"):</font> <%=request.getParameter("requestURL")%><br> --%>
<%--    <font color=blue>request.getParameter("whichPage"): </font> <%=request.getParameter("whichPage")%> (���d�ҥثe�u�Ω�:istAllComment.jsp))</b> --%>
<!-- </body> -->



<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

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
  	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
  	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
  		   value: '', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           //minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });
        
        
   
        // ----------------------------------------------------------�H�U�ΨӱƩw�L�k��ܪ����-----------------------------------------------------------

        //      1.�H�U���Y�@�Ѥ��e������L�k���
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

        
        //      2.�H�U���Y�@�Ѥ��᪺����L�k���
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


        //      3.�H�U����Ӥ�����~������L�k��� (�]�i���ݭn������L���)
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
        title: "���|���\",
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
		  title: '���|����',
		  text: '���|��]�ФŪť�',
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
	
$(document).ready(function(){
	$("#add-btn").click(function(){
		
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
	})
})



</script>
</html>