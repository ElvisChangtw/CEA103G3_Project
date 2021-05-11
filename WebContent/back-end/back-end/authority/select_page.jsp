<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Authority: Home</title>

<style>
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
   <tr><td><h3>IBM Authority: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Authority: Home</p>

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
  <li><a href='listAllAuthority.jsp'>List</a> all Authorities.  <br><br></li> <br>
  
  
  <li>
    <FORM METHOD="post" ACTION="authority.do" >
        <b>輸入員工編號 :</b>
        <input type="text" name="empno"><br>
        <b>輸入功能編號 :</b>
        <input type="text" name="function_no">
        <input type="hidden" name="action" value="getOneEmp_For_Display"><br>
        <input type="submit" value="送出">
    </FORM>
    <br>
  </li>

  <jsp:useBean id="authoritySvc" scope="page" class="com.authority.model.AuthorityService" />
   
<!--   <li> -->
<!--      <FORM METHOD="post" ACTION="authority.do" > -->
<!--        <b>選擇員工編號:</b> -->
<!--        <select size="1" name="empno"> -->
<%--          <c:forEach var="authorityVO" items="${authoritySvc.all}" >  --%>
<%--           <option value="${authorityVO.empno}">${authorityVO.empno} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
<!--        <input type="hidden" name="action" value="getOne_For_Display"> -->
<!--        <input type="submit" value="送出"> -->
<!--     </FORM> -->
<!--   </li> -->
  
<!--   <li> -->
<!--      <FORM METHOD="post" ACTION="authority.do" > -->
<!--        <b>選擇功能編號:</b> -->
<!--        <select size="1" name="function_no"> -->
<%--          <c:forEach var="authorityVO" items="${authoritySvc.all}" >  --%>
<%--           <option value="${authorityVO.function_no}">${authorityVO.function_no} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
<!--        <input type="hidden" name="action" value="getOne_For_Display"> -->
<!--        <input type="submit" value="送出"> -->
<!--      </FORM> -->
<!--   </li> -->
</ul>


<h3>員工管理</h3>

<ul>
  <li><a href='addAuthority.jsp'>Add</a> a new Authority.</li>
</ul>

</body>
</html>