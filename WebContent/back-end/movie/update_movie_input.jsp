<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.movie.model.*"%>

<%
	MovieVO movieVO = (MovieVO) request.getAttribute("movieVO"); //EmpServlet.java (Concroller) �s�Jreq��empVO���� (�]�A�������X��empVO, �]�]�A��J��ƿ��~�ɪ�empVO����)
%>
<%-- <%= empVO==null %>--${empVO.deptno}-- --%>
movieVO. === ${movieVO.grade} movieVO.grade.equals("0") ===
${movieVO.grade.equals("0")}
${movieVO.category.contains("�ʧ@��")}
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>�q�v��ƭק� - update_movie_input.jsp</title>

<style>
tr td>img {
	width: 150px;
	height: 150px;
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
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>�q�v��ƭק� - update_movie_input.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front-end/movie/select_movie_page.jsp">
						<img src="<%=request.getContextPath()%>/images/movie_images/back1.gif"
						width="100" height="32" border="0">�^����
					</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>��ƭק�:</h3>

	<%-- ���~��C --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post"
		ACTION="<%=request.getContextPath()%>/movie/movie.do" name="form1"
		enctype="multipart/form-data">
		<table>
			<tr>
				<td>�q�v�s��:<font color=red><b>*</b></font></td>
				<td><%=movieVO.getMovieno()%></td>
			</tr>
			<tr>
				<td>�q�v�W��:</td>
				<td><input type="TEXT" name="moviename" size="45"
					value="<%=(movieVO == null) ? "" : movieVO.getMoviename()%>" /></td>
			</tr>
			<tr>
				<td>�q�v�Ӥ�1:</td>
				<td>
				<img id="preview_img" src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}">
				<input multiple type="file" name="moviepicture1" accept="image/*" onchange="readURL(this)" targetID="preview_img"
					value="<%=(movieVO == null) ? "" : movieVO.getMoviepicture1()%>" />
					</td>
			</tr>	
			<tr>
				<td>�q�v�Ӥ�:</td>
				<td>
				<img id="preview_img2" src="${pageContext.request.contextPath}/movie/DBGifReader2.do?movieno=${movieVO.movieno}"">
				<input multiple type="file" name="moviepicture2" accept="image/*" onchange="readURL(this)" targetID="preview_img2"
					value="<%=(movieVO == null) ? "" : movieVO.getMoviepicture2()%>" />
					</td>
			</tr>	
			<tr>
				<td>�ɺt:</td>
				<td><input type="TEXT" name="director" size="45"
					value="<%=(movieVO == null) ? "" : movieVO.getDirector()%>" /></td>
			</tr>
			<tr>
				<td>�t��:</td>
				<td><input type="TEXT" name="actor" size="45"
					value="<%=(movieVO == null) ? "" : movieVO.getActor()%>" /></td>
			</tr>
			<tr>
				<td>�q�v����:</td>
				<td>
				<input type="checkbox" name="category" value="�ʧ@��" <%= movieVO.getCategory().contains("�ʧ@��") ? "checked" : "" %>>�ʧ@��
				<input type="checkbox" name="category" value="�_�I��" <%= movieVO.getCategory().contains("�_�I��") ? "checked" : "" %>>�_�I��
				<input type="checkbox" name="category" value="��ۤ�" <%= movieVO.getCategory().contains("��ۤ�") ? "checked" : "" %>>��ۤ�
				<input type="checkbox" name="category" value="�@����" <%= movieVO.getCategory().contains("�@����") ? "checked" : "" %>>�@����
				<input type="checkbox" name="category" value="�Ԫ���" <%= movieVO.getCategory().contains("�Ԫ���") ? "checked" : "" %>>�Ԫ���
				<input type="checkbox" name="category" value="�v�֤�" <%= movieVO.getCategory().contains("�v�֤�") ? "checked" : "" %>>�v�֤�
				<input type="checkbox" name="category" value="�Ǹo��" <%= movieVO.getCategory().contains("�Ǹo��") ? "checked" : "" %>>�Ǹo��
				<input type="checkbox" name="category" value="ĵ���" <%= movieVO.getCategory().contains("ĵ���") ? "checked" : "" %>>ĵ���
				<input type="checkbox" name="category" value="�_�ۤ�" <%= movieVO.getCategory().contains("�_�ۤ�") ? "checked" : "" %>>�_�ۤ�
				<input type="checkbox" name="category" value="���Ƥ�" <%= movieVO.getCategory().contains("���Ƥ�") ? "checked" : "" %>>���Ƥ�
				<input type="checkbox" name="category" value="�宪��" <%= movieVO.getCategory().contains("�宪��") ? "checked" : "" %>>�宪��
				<input type="checkbox" name="category" value="�a�ä�" <%= movieVO.getCategory().contains("�a�ä�") ? "checked" : "" %>>�a�ä�
				<input type="checkbox" name="category" value="�߼@��" <%= movieVO.getCategory().contains("�߼@��") ? "checked" : "" %>>�߼@��
				<input type="checkbox" name="category" value="�R����" <%= movieVO.getCategory().contains("�R����") ? "checked" : "" %>>�R����
				<input type="checkbox" name="category" value="������" <%= movieVO.getCategory().contains("������") ? "checked" : "" %>>������
				<input type="checkbox" name="category" value="�ʵe��" <%= movieVO.getCategory().contains("�ʵe��") ? "checked" : "" %>>�ʵe��
				<input type="checkbox" name="category" value="���֤�" <%= movieVO.getCategory().contains("���֤�") ? "checked" : "" %>>���֤�
				<input type="checkbox" name="category" value="�q�R�@" <%= movieVO.getCategory().contains("�q�R�@") ? "checked" : "" %>>�q�R�@
				</td>
			</tr>
			<tr>
				<td>�q�v����:</td>
				<td><input type="TEXT" name="length" size="45"
					value="<%=(movieVO == null) ? "" : movieVO.getLength()%>" /></td>
			</tr>
			<tr>
				<td>�q�v���A:</td>
				<td><select name="status" size="1">
						<option value="9"
							<%=(movieVO.getStatus().equals("9") ? "selected" : "")%>></option>
						<option value="0"
							<%=(movieVO.getStatus().equals("0") ? "selected" : "")%>>�W�M��</option>
						<option value="1"
							<%=(movieVO.getStatus().equals("1") ? "selected" : "")%>>���W�M</option>
						<option value="2"
							<%=(movieVO.getStatus().equals("2") ? "selected" : "")%>>�w�U��</option>
				</select></td>
			</tr>
			<tr>
				<td>�W�M���:</td>
				<td><input name="premiredate" id="f_date1" type="text" value="<%=(movieVO == null) ? "" : movieVO.getPremiredate()%>"></td>
			</tr>
			<tr>
				<td>�U�ɤ��:</td>
				<td><input name="offdate" id="f_date2" type="text"  value="<%=(movieVO == null) ? "" : movieVO.getOffdate()%>"></td>
			</tr>
			<tr>
				<td>�w�i��:</td>
				<td><input type="TEXT" name="trailor" size="45"
					value="<%=(movieVO == null) ? "" : movieVO.getTrailor()%>" /></td>
			</tr>
			<tr>
				<td>�u�w�i��:</td>
				<td><input type="TEXT" name="embed" size="45"
					value="<%=(movieVO == null) ? "" : movieVO.getEmbed()%>" /></td>
			</tr>
			<tr>
				<td>�q�v����:</td>
				<td><select name="grade" size="1">
						<option value="9"
							<%=(movieVO.getGrade().equals("9") ? "selected" : "")%>></option>
						<option value="0"
							<%=(movieVO.getGrade().equals("0") ? "selected" : "")%>>���M��</option>
						<option value="1"
							<%=(movieVO.getGrade().equals("1") ? "selected" : "")%>>�O�@��</option>
						<option value="2"
							<%=(movieVO.getGrade().equals("2") ? "selected" : "")%>>���ɯ�</option>
						<option value="3"
							<%=(movieVO.getGrade().equals("3") ? "selected" : "")%>>�����</option>

						<!-- EL�g�k				 -->
						<%-- 				<option value="0" ${movieVO.grade.equals("0")? "selected":""}>���M��</option>				 --%>
						<%-- 				<option value="1" ${movieVO.grade.equals("1")? "selected":""}>�O�@��</option> --%>
						<%-- 				<option value="2" ${movieVO.grade.equals("2")? "selected":""}>���ɯ�</option> --%>
						<%-- 				<option value="3" ${movieVO.grade.equals("3")? "selected":""}>�����</option> --%>
				</select></td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td>����:</td> -->
<!-- 				<td><input type="TEXT" name="rating" size="45" -->
<%-- 					value="<%=(movieVO == null) ? "" : movieVO.getRating()%>" /></td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>���ݫ�:</td> -->
<!-- 				<td><input type="TEXT" name="expectation" size="45" -->
<%-- 					value="<%=(movieVO == null) ? "" : movieVO.getExpectation()%>" /></td> --%>
<!-- 			</tr> -->
		</table>
		<br> <input type="hidden" name="action" value="update"> 
		<input type="hidden" name="movieno" value="<%=movieVO.getMovieno()%>">
		<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--������e�X�ק諸�ӷ��������|��,�A�e��Controller�ǳ���椧��-->
		<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--�u�Ω�:istAllEmp.jsp-->
		<input type="submit" value="�e�X�ק�">
	</FORM>
</body>



<!-- =========================================�H�U�� datetimepicker �������]�w========================================== -->

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
 	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
 	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
 		   value: '<%=movieVO.getPremiredate()%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
           //startDate:	            '2017/07/10',  // �_�l��
           minDate:               '-1970-01-01', // �h������(���t)���e
           //maxDate:               '+1970-01-01'  // �h������(���t)����
        });
        
        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:false,       //timepicker:true,
 	       step: 1,                //step: 60 (�o�Otimepicker���w�]���j60����)
 	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
 		   value: '<%=movieVO.getOffdate()%>', // value:   new Date(),
		//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // �h���S�w���t
		//startDate:	            '2017/07/10',  // �_�l��
		minDate : '-1970-01-01', // �h������(���t)���e
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
</html>