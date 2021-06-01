<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.employee.model.*"%>
<%@ page import="com.authority.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
    EmployeeVO employeeVO = (EmployeeVO) session.getAttribute("employeeVO");
	Set<AuthorityVO> authList = (Set<AuthorityVO>) session.getAttribute("authList");
	
	if (employeeVO == null){
		employeeVO = new EmployeeVO();
		employeeVO.setEmpno(99);
	}
	pageContext.setAttribute("employeeVO", employeeVO);
%>


<!DOCTYPE html>
<html lang="en">


<head>
    <meta charset="big5" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>MOVIESHIT</title>
    <link href="<%=request.getContextPath()%>/back-home/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>

	<style>
		#layoutSidenav_content{
			background-image: url('<%=request.getContextPath()%>/img/back-home-img.jpg');
			background-size: 100% 100%;
  			background-size: cover;
    		opacity: 0.85;  
  			
		}
/* 		.image {  */
/* 		    position: relative;  */
/* 		    width: 100%; /* for IE 6 */  */
/* 			}  */
	
		h2 { 
		    position: absolute; 
		    top: 0px; 
		    left: 10;  
		    width: 100%; 
			} 
		span {
    		color: #02a388;
   			font-size: 1em;
   			}	
   		#welcome{
   			position: fixed;
			left: 50%;
			top: 50%;
   		}	
   		#welcome1{
   			position: fixed;
			left: 45%;
			top: 40%;
   		}
   		#welcome2{
   			position: fixed;
			left: 45%;
			top: 50%;
   		}	
   		#welcome3{
   			position: fixed;
			left: 62%;
			top: 50%;
   		}	
   		#welcome4{
   			position: fixed;
			left: 43%;
			top: 60%;
   		}
   		
		
</style>
	


</head>

<body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <a class="navbar-brand" href="index2.jsp">MOVIESHIT後台系統</a>
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
    	</nav>
    
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <img src="<%=request.getContextPath()%>/back-home/img/logo2-1-6.png">
	                         <h1 style="text-align: center;color: white;font-weight: bold ;font-size:35px">
	                         	<span>M</span>ovies<span>H</span>it
	                         </h1>
<!--                         <a class="nav-link collapsed" href="tables3.html"> -->
<!--                             <div class="sb-nav-link-icon"><i class="fas fa-user-alt"></i></div> -->
<!--                            	 基本資料 -->
<!--                         </a> -->
                        <a id="employee_management"class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLayouts1" aria-expanded="false" aria-controls="collapseLayouts1">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-cog"></i></div>
                           	 員工管理系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseLayouts1" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a  class="nav-link nav-link function" href="<%=request.getContextPath()%>/back-end/employee/listAllEmployee2.jsp">員工管理</a>
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
                                <a class="nav-link function" href="<%=request.getContextPath()%>/back-end/order/onSite.jsp">現場劃位</a>
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
             <div class="container-fluid">
<!--     			 <img style="width: inherit" -->
<%--     			  src="<%=request.getContextPath()%>/img/back-home-img.jpg" alt="" />  --%>
     			<h2>
     				<c:if test="${employeeVO.empno == 99}">
     					<font id="welcome" color=red style="font-weight:bold">請先登入</font>
     				</c:if>
     				<c:if test="${employeeVO.empno != 99}">
     					<font id="welcome1" color=white>歡迎MoviesHit員工:</font>
     					<font id="welcome2" color=yellow style="font-weight:bold">${employeeVO.empname}</font>
     					<font id="welcome3" color=white>登入!</font>
     					<font id="welcome4" color=white>請點選左側功能進行操作!</font>
     				</c:if>
     			</h2>		
			</div> 
        </div>
	</div>
<!-- ======到這邊===== -->

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
    <script src="assets/demo/chart-area-demo.js"></script>
    <script src="assets/demo/chart-bar-demo.js"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
    <script src="assets/demo/datatables-demo.js"></script>
</body>

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