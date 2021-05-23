<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.employee.model.*"%>
<%@ page import="com.authority.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    EmployeeService employeeSvc = new EmployeeService();
    List<EmployeeVO> list = employeeSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<%
	EmployeeVO employeeVO = (EmployeeVO) request.getAttribute("employeeVO");
%>

<jsp:useBean id="authoritytSvc" scope="page" class="com.authority.model.AuthorityService" />


<!doctype html>
<html lang="en">
  <head>
  	<title>Table 08</title>
    <meta charset="Big5">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styleForListAllEmp.css" />
    
<!--     <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round"> -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<!-- 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> -->
<!-- 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->

<!-- 	<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'> -->

<!-- 	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> -->
	
	<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/employee/css/style.css">
 
	</head> 
	<body>
	
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
		</c:if>
	
	
	<section class="ftco-section">
		<div class="container">  
		<div class="col-sm-6">
						<h2><b>員工新增</b></h2>
					</div>
					<div class="col-sm-6">
						<a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Employee</span></a>
					</div>
					<br>
					<br>
			<div>
				<div class="col-sm-6">
					<h2><b>員工列表</b></h2>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
						<table class="table myaccordion table-hover" id="accordion">
						  <thead>
						    <tr>
						      <th class="th1">員工編號</th>
							  <th>員工姓名</th>
<!-- 							  <th>員工密碼</th> -->
							  <th>性別</th>
							  <th>電話</th>
							  <th>電子郵件</th>
							  <th>職稱</th>
							  <th>雇用日期</th>
							  <th>離職日期</th>
							  <th>在職狀態</th>
							  <th>權限</th>
							  <th>修改</th>
						    </tr>
						  </thead>
						  <tbody>
						  <%@ include file="page1.file" %> 
	<c:forEach var="employeeVO" varStatus="status" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" >
						    <tr data-toggle="collapse" data-target="#collapse${status.count}" aria-expanded="true" aria-controls="collapse${status.count}" class="collapsed">
								<td>${employeeVO.empno}</td>
								<td>${employeeVO.empname}</td>
<%-- 								<td>${employeeVO.emppwd}</td> --%>
								<td>${employeeVO.gender eq 1?"男":"女"}</td>
								<td>${employeeVO.tel}</td> 
								<td>${employeeVO.email}</td>
								<td>${employeeVO.title}</td>
								<td><fmt:formatDate value="${employeeVO.hiredate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								<td><fmt:formatDate value="${employeeVO.quitdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
								<td>
									 <c:choose>
   									 <c:when test= "${employeeVO.status eq 0}">已離職</c:when>
   									 <c:when test= "${employeeVO.status eq 1}">在職中</c:when>
   									 <c:when test= "${employeeVO.status eq 2}">留職停薪</c:when>
   									</c:choose>
								</td>
						      	<td>
						      		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/employee/employee.do" style="margin-bottom: 0px;">
<!-- 						      			 <i class="fa" aria-hidden="true"></i> -->
<!-- 			   							 <input type="submit" value="送出查詢">  -->
									     <input type="submit" class="btn btn-success edit" value="查看">
			  							 <input type="hidden" name="empno" value="${employeeVO.empno}">
			  							 <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			    						 <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			   							 <input type="hidden" name="action" value="listAuthority_ByEmpno">
			   						</FORM>
				        		</td>
				        		<td>
				        		 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/employee/employee.do" style="margin-bottom: 0px;">
			     <input type="hidden" name="empno"  value="${employeeVO.empno}">
			     <input type="hidden" name="action"	value="getOne_For_Update">
			     <input type="submit" class="btn btn-success edit" value="Edit">
<!-- 			      <a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a> -->
			      				</FORM>
			</td>
						    </tr>
						    <tr>
						    	<td colspan="6" id="collapse${status.count}" class="collapse acc">
						    		<%if (request.getAttribute("listAuths_ByEmpno")!=null){%>
    								   <jsp:include page="listAuths_ByEmpno.jsp" />
									<%} %>
			   					</td>
						    </tr>
   							</c:forEach>
						  </tbody>
						</table>
						  <%@ include file="page2.file" %>
					</div>
				</div>
			</div>
	</section>
	
<!-- 	新增員工modal -->
		<div id="addEmployeeModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<form METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/employee/employee.do">
				<div class="modal-header">						
					<h4 class="modal-title">Add Employee</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">	
								
					<div class="form-group">
						<label>員工姓名:</label>
						<input type="text" class="form-control" name="empname" size="45"
					value="<%=(employeeVO == null) ? "洪七公" : employeeVO.getEmpname()%>" required>
					</div>
					
					<div class="form-group">
						<label>性別:</label>
						<select size="1" class="form-control" name="gender">
							<option value="1">男
							<option value="0">女
						</select>
					</div>
					
					<div class="form-group">
						<label>電話:</label>
						<input class="form-control" type="TEXT" name="tel" size="45"
					value="<%=(employeeVO == null) ? "0905066825" : employeeVO.getTel()%>" required>
					</div>
					
					<div class="form-group">
						<label>電子郵件:</label>
						<input type="text" name="email" size="45"
					value="<%=(employeeVO == null) ? "edlevisken@gmail.com" : employeeVO.getEmail()%>" class="form-control" required>
					</div>	
					
					<div class="form-group">
						<label>職稱:</label>
						<input type="text" name="title" size="45"
					value="<%=(employeeVO == null) ? "後台管理員" : employeeVO.getTitle()%>" class="form-control" required>
					</div>	
					
					<div class="form-group">
						<label>雇用日期:</label>
						<input type="text" name="hiredate" id="f_date1" class="form-control" required>
					</div>	
					
					<div class="form-group">
						<label>離職日期:</label>
						<input type="text" name="quitdate" id="f_date2" class="form-control" required>
					</div>	
					
					<div class="form-group">
						<label>在職狀態:</label><br>
						<input type="radio" name="status" value="0" >已離職
						<input type="radio" name="status" value="1" checked>在職中
						<input type="radio" name="status" value="2" >留職停薪
					</div>	
					<hr>
					<div class="form-group">
						<label>權限:</label><br>
						<input type="checkbox" name="function_no" value="1"> 員工管理  
						 &nbsp;&nbsp;
						<input type="checkbox" name="function_no" value="2" > 員工權限管理
						 &nbsp;&nbsp;
						<input type="checkbox" name="function_no" value="3" > 場次管理
						 &nbsp;&nbsp;
						<input type="checkbox" name="function_no" value="4" > 電影資訊管理
						<br>
						<input type="checkbox" name="function_no" value="5" > 廳院管理
						 &nbsp;&nbsp;
						<input type="checkbox" name="function_no" value="6" > 座位管理
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="function_no" value="7" > 票種管理
						 &nbsp;&nbsp;
						<input type="checkbox" name="function_no" value="8" > 餐點管理
						<br>
						<input type="checkbox" name="function_no" value="9" > 會員資料管理
						 &nbsp;&nbsp;
						<input type="checkbox" name="function_no" value="10" > 會員審核
						 &nbsp;&nbsp;
						<input type="checkbox" name="function_no" value="11" > 專業評論審核
						 &nbsp;&nbsp;
						<input type="checkbox" name="function_no" value="12" > 現場劃位
						<br>
						<input type="checkbox" name="function_no" value="13" > 查詢線上訂單
						 &nbsp;&nbsp;
						<input type="checkbox" name="function_no" value="14" > 檢舉管理
						 &nbsp;&nbsp;
						<input type="checkbox" name="function_no" value="15" > 最新消息管理
						 &nbsp;&nbsp;
						<input type="checkbox" name="function_no" value="16" > 客服小幫手
					</div>	
					
					
									
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
					<input type="hidden" name="action" value="insert">
<%-- 					<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"> --%>
					<input type="submit" class="btn btn-success" value="Add">
				</div>
			</form>
		</div>
	</div>
</div>



	<script src="js/jquery.min.js"></script>
  <script src="js/popper.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>
<!--   	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> -->
<!-- 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->

	</body>
	
	<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<%
	java.sql.Date hiredate = null;
	try {
		hiredate = employeeVO.getHiredate();
	} catch (Exception e) {
		hiredate = new java.sql.Date(System.currentTimeMillis());
	}
%>

<%
	java.sql.Date quitdate = null;
	try {
		quitdate = employeeVO.getQuitdate();
	} catch (Exception e) {
		quitdate = new java.sql.Date(System.currentTimeMillis());
	}
%>


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
		   value: '<%=hiredate%>',  // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=quitdate%>',  // value:   new Date(),
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	//startDate:	            '2017/07/10',  // 起始日
	//minDate:               '-1970-01-01', // 去除今日(不含)之前
	//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});
        
</script>
</html>

