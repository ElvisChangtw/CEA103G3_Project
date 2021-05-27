<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.employee.model.*"%>
<%@ page import="com.authority.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    EmployeeService employeeSvc = new EmployeeService();
    List<EmployeeVO> list = employeeSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<%
    EmployeeVO employeeVO = (EmployeeVO) session.getAttribute("employeeVO");
	Set<AuthorityVO> authList = (Set<AuthorityVO>) session.getAttribute("authList");
%>


<%--
		Integer empno = employeeVO.getEmpno();
		AuthorityService authSvc1 = new AuthorityService(); 
 		List<AuthorityVO> list2 = authSvc1.getOneAuthorityByEmpNo(empno);  
 		for(int i = 0; i < list2.size(); i++){ 
				AuthorityVO authVO = list2.get(i); 
			if(authVO.getAuth_status().equals("N")){ 
				list2.remove(authVO); 
					i--; 
			}else{ 
				System.out.println(authVO.getFunction_no()); 
 			} 
 		}
--%>


<jsp:useBean id="authoritytSvc" scope="page" class="com.authority.model.AuthorityService" />

<!DOCTYPE html>
<html lang="en">
    <head>
    	<title>後台瀏覽所有電影</title>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <link href="<%=request.getContextPath()%>/back-home/css/styles.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
    	
    	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styleForListAllEmp.css" />
    	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    	<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/employee/css/style.css">
     	
     	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/back-home/css/back_frontpage.css" />
    
    
    	<style>
/*     	h2 {  */
/* 		    position: absolute;  */
/* 		    top: 0px;  */
/* 		    left: 10;   */
/* 		    width: 100%;  */
/* 			}  */
		span.logo {
    		color: #02a388;
   			font-size: 1em;
   			}	
    	</style>
    </head>
    <body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <a class="navbar-brand" href="index.html">MOVIESHIT後台系統</a>
        <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#"><i class="fas fa-bars"></i></button>
        <!-- Navbar Search-->
        <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
            <div class="input-group">
            </div>
        </form>
        <!-- Navbar-->
        <ul class="navbar-nav ml-auto ml-md-0">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle1" id="userDropdown" href="<%=request.getContextPath()%>/back-end/employee/empLogin.jsp" role="button"><i class="fas fa-user fa-fw"></i>${employeeVO.empname}</a>
            </li>
            <a class="nav-link" href="<%=request.getContextPath()%>/back-end/employee/empLogout.jsp">
               	 登出
            </a>
        </ul>
    </nav>
    
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <img src="<%=request.getContextPath()%>/back-home/img/logo2-1-6.png">
	                         <h1 style="text-align: center;color: white;font-weight: bold ;font-size:35px">
	                         	<span class="logo">M</span>ovies<span class="logo">H</span>it
	                         </h1>
<!--                         <a class="nav-link collapsed" href="tables3.html"> -->
<!--                             <div class="sb-nav-link-icon"><i class="fas fa-user-alt"></i></div> -->
<!--                            	 基本資料 -->
<!--                         </a> -->
                        <a id="employee_management" class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLayouts1" aria-expanded="false" aria-controls="collapseLayouts1">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-cog"></i></div>
                           	 員工管理系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseLayouts1" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/employee/listAllEmployee2.jsp">員工管理</a>
                            </nav>
                        </div>
                        <a id="movie_management" class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                            <div class="sb-nav-link-icon"><i class="fas fa-video"></i></div>
                         	   影城基本資料系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/movie/backEndlistAllMovie.jsp">電影資料管理</a>
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/showtime/listAllShowtime.jsp">場次管理</a>
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/theater/listAllTheater.jsp"> 廳院管理</a>
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/ticket_type/listAllTicket_type.jsp">票種管理</a>
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/food/listAllFood.jsp">餐點管理</a>
                            </nav>
                        </div>
                        <a id="member_management" class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages2" aria-expanded="false" aria-controls="collapsePages2">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-clock"></i></div>
                            	會員管理系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages2" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/mem/listAllMem2.jsp">會員資料管理</a>
                            </nav>
                        </div>
                        <a id="ticket_management" class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages3" aria-expanded="false" aria-controls="collapsePages3">
                            <div class="sb-nav-link-icon"><i class="fas fa-ticket-alt"></i></div>
                        	    售票管理
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages3" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link function" href="layout-static.html">現場劃位</a>
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/order/listAllOrder.jsp">訂單管理</a>
                            </nav>
                        </div>
           				 <a id="comment_management" class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages4" aria-expanded="false" aria-controls="collapsePages4">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-alt-slash"></i></div>
                          	  檢舉管理
                          	<div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages4" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/report_comment/listAllReportComment.jsp">評論檢舉</a>
                            </nav>
                        </div>
                        <a id="news_management" class="nav-link function" href="tables1.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-bullhorn"></i></div>
                           	 管理最新消息
                        </a>
                        <a id="customer_service" class="nav-link function" href="tables2.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-hands-helping"></i></div>
                       	     	回應客服小幫手
                        </a>
                    </div>
                </div>
            </nav>
        </div>
            
            
            
            
            
<!--       ======這邊貼自己的檔案內容====== -->
            <div id="layoutSidenav_content">
                <main>
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
   							</c:forEach>
						  </tbody>
						</table>
						  <%@ include file="page2.file" %>
					</div>
						<td colspan="6" id="collapse${status.count}" class="collapse acc">
						   <%if (request.getAttribute("listAuths_ByEmpno")!=null){%>
    						 <jsp:include page="listAuths_ByEmpno.jsp" />
							<%} %>
			   			</td>
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
						<input type="text" class="form-control" name="empname" size="45" value="石破天" required>
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
					value= "0900123321" required>
					</div>
					
					<div class="form-group">
						<label>電子郵件:</label>
						<input type="text" name="email" size="45"
					value="edlevisken@gmail.com" class="form-control" required>
					</div>	
					
					<div class="form-group">
						<label>職稱:</label>
						<input type="text" name="title" size="45"
					value= "後台管理員" class="form-control" required>
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
						<input type="checkbox"> 員工管理  
						<input type="hidden" name="function_no" value="1">
						<input type="hidden" name="auth_status" value="N">
						 &nbsp;&nbsp;
						<input type="checkbox" > 電影資訊管理
						<input type="hidden" name="function_no" value="2" >
						<input type="hidden" name="auth_status" value="N">
						 &nbsp;&nbsp;
						<input type="checkbox" > 場次管理
						<input type="hidden" name="function_no" value="3" >
						<input type="hidden" name="auth_status" value="N">
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" > 廳院管理
						<input type="hidden" name="function_no" value="4" > 
						<input type="hidden" name="auth_status" value="N">
						<br>
						<input type="checkbox"> 票種管理
						<input type="hidden" name="function_no" value="5" > 
						<input type="hidden" name="auth_status" value="N">
						 &nbsp;&nbsp;
						<input type="checkbox"> 餐點管理
						<input type="hidden" name="function_no" value="6" > 
						<input type="hidden" name="auth_status" value="N">
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox"> 會員資料管理
						<input type="hidden" name="function_no" value="7" > 
						<input type="hidden" name="auth_status" value="N">
						 &nbsp;&nbsp;
						<input type="checkbox"> 現場劃位
						<input type="hidden" name="function_no" value="8" >
						<input type="hidden" name="auth_status" value="N">
						<br>
						<input type="checkbox"> 訂單管理
						<input type="hidden" name="function_no" value="9" > 
						<input type="hidden" name="auth_status" value="N">
						 &nbsp;&nbsp;
						<input type="checkbox"> 檢舉管理
						<input type="hidden" name="function_no" value="10" > 
						<input type="hidden" name="auth_status" value="N">
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox"> 最新消息管理
						<input type="hidden" name="function_no" value="11" >
						<input type="hidden" name="auth_status" value="N">
						 &nbsp;&nbsp;
						<input type="checkbox"> 客服小幫手
						<input type="hidden" name="function_no" value="12" > 
						<input type="hidden" name="auth_status" value="N">
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

                </main>

            </div>
     
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/back-home/js/scripts.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/css/demo/datatables-demo.js"></script>
    	
<script src="js/jquery.min.js"></script>
<script src="js/popper.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
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
		   value: '<%=quitdate%>',   // value:   new Date(),
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	//startDate:	            '2017/07/10',  // 起始日
	//minDate:               '-1970-01-01', // 去除今日(不含)之前
	//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});
        
    $("input[type=checkbox]").click(function(){
       	if($(this).prop("checked")==true){
	       	$(this).next().next().val("Y");
       	}else{
       		$(this).next().next().val("N");
       	}
    })
        
</script>   

<script>

<c:forEach var="authList" varStatus="status" items="${sessionScope.authList}">
var index = ${authList.getFunction_no()} -1;
var tree = document.getElementsByClassName("nav-link function")[index]
	if(`${authList.getAuth_status()}`=='N'){
		tree.style.display="none";
	}
	
	if(${authList.function_no} == ${status.count}){
		if(${authList.auth_status == "Y"}){
			funno${status.count}= true;
		}else { 
			funno${status.count} = false;
		} 
	}
	
</c:forEach>


if(funno1 == false){
	$("#employee_management").hide();
}

if(funno2 == false && funno3 == false && funno4 == false && funno5 == false && funno6 == false){
	$("#movie_management").hide();
}

if(funno7 == false){
	$("#member_management").hide();
}

if(funno8 == false && funno9 == false){
	$("#ticket_management").hide();
}

if(funno10 == false){
	$("#comment_management").hide();
}

if(funno11 == false){
	$("#news_management").hide();
}

if(funno12 == false){
	$("#customer_service").hide();
}

// var tree = document.getElementsByClassName("nav-link function")
//  document.getElementById("demo").innerHTML = tree.length;

</script>
     
    
</html>
