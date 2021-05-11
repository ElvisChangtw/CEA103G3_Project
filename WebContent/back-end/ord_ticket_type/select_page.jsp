<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ord_ticket_type.model.*"%>

<html>
<head>
<title>IBM Ord_ticket_type: Home</title>

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
   <tr><td><h3>IBM Ord_ticket_type: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Ord_ticket_type: Home</p>

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
  <li><a href='<%=request.getContextPath()%>/back-end/ord_ticket_type/listAllOrd_ticket_type.jsp'>List</a> all Ord_ticket_types.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ord_ticket_type/ord_ticket_type.do" >
        <b>輸入票種編號 (如1):</b>
        <input type="text" name="ticket_type_no">
        <br>
        <b>輸入訂單編號 (如1):</b>
        <input type="text" name="order_no">
        <br>
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="ord_ticket_typeSvc" scope="page" class="com.ord_ticket_type.model.Ord_ticket_typeService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ord_ticket_type/ord_ticket_type.do" >
       <b>選擇票種編號:</b>
       <select size="1" name="ticket_type_no">
         <c:forEach var="ord_ticket_typeVO" items="${ord_ticket_typeSvc.all}" > 
          <option value="${ord_ticket_typeVO.ticket_type_no}">${ord_ticket_typeVO.ticket_type_no}
         </c:forEach>   
       </select>
       <br>
       <b>選擇訂單編號:</b>
       <select size="1" name="order_no">
         <c:forEach var="ord_ticket_typeVO" items="${ord_ticket_typeSvc.all}" > 
          <option value="${ord_ticket_typeVO.order_no}">${ord_ticket_typeVO.order_no}
         </c:forEach>   
       </select>
       <br>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
<!--   <li> -->
<%--      <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ord_ticket_type/ord_ticket_type.do" > --%>
<!--        <b>選擇票種:</b> -->
<!--        <select size="1" name="ticket_type_no"> -->
<%--          <c:forEach var="ord_ticket_typeVO" items="${ord_ticket_typeSvc.all}" >  --%>
<%--           <option value="${ord_ticket_typeVO.ticket_type_no}">${ord_ticket_typeVO.ticket_type_no} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
<!--        <input type="hidden" name="action" value="getOne_For_Display"> -->
<!--        <input type="submit" value="送出"> -->
<!--     </FORM> -->
<!--   </li> -->
  
</ul>


<h3>票種管理</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/back-end/ord_ticket_type/addOrd_ticket_type.jsp'>Add</a> a new Ord_ticket_type.</li>
  <li><a href='<%=request.getContextPath()%>/back-end/ord_ticket_type/addOrd_ticket_type2.jsp'>Add</a> a new Ord_ticket_type.</li>
</ul>

</body>
</html>