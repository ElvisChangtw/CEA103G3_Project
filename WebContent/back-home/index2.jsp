<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.employee.model.*"%>


<!DOCTYPE html>
<html lang="en">

<%
    EmployeeVO employeeVO = (EmployeeVO) session.getAttribute("employeeVO");
%>

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
		
</style>
	


</head>

<body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <a class="navbar-brand" href="index2.jsp">MOVIESHIT��x�t��</a>
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
               	 �n�X
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
<!--                            	 �򥻸�� -->
<!--                         </a> -->
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLayouts1" aria-expanded="false" aria-controls="collapseLayouts1">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-cog"></i></div>
                           	 ���u�޲z�t��
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseLayouts1" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/employee/listAllEmployee2.jsp">���u�޲z</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                            <div class="sb-nav-link-icon"><i class="fas fa-video"></i></div>
                         	   �v���򥻸�ƨt��
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/movie/backEndlistAllMovie.jsp">�q�v��ƺ޲z</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/showtime/listAllShowtime.jsp">�����޲z</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/theater/listAllTheater.jsp"> �U�|�޲z</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/ticket_type/listAllTicket_type.jsp">���غ޲z</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/food/listAllFood.jsp">�\�I�޲z</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages2" aria-expanded="false" aria-controls="collapsePages2">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-clock"></i></div>
                            	�|���޲z�t��
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages2" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/mem/listAllMem2.jsp">�|����ƺ޲z</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages3" aria-expanded="false" aria-controls="collapsePages3">
                            <div class="sb-nav-link-icon"><i class="fas fa-ticket-alt"></i></div>
                        	    �Ⲽ�޲z
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages3" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="layout-static.html">�{������</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/order/listAllOrder.jsp">�q��޲z</a>
                            </nav>
                        </div>
           				 <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages4" aria-expanded="false" aria-controls="collapsePages4">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-alt-slash"></i></div>
                          	  ���|�޲z
                          	<div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages4" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/report_comment/listAllReportComment.jsp">�������|</a>
                            </nav>
                        </div>
                        <a class="nav-link" href="tables1.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-bullhorn"></i></div>
                           	 �޲z�̷s����
                        </a>
                        <a class="nav-link" href="tables2.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-hands-helping"></i></div>
                       	     	�^���ȪA�p����
                        </a>
                    </div>
                </div>
            </nav>
        </div>
    
    	 
<!--       ======�o��K�ۤv���ɮפ��e====== -->
        <div id="layoutSidenav_content">
             <div class="container-fluid">
<!--     			 <img style="width: inherit" -->
<%--     			  src="<%=request.getContextPath()%>/img/back-home-img.jpg" alt="" />  --%>
     			<h2><font color =white>�w��MoviesHit���u:</font><font color=yellow style="font-weight: bold">${employeeVO.empname}</font><font color=white>�n�J!</font></h2>		
     			<h2><font color =white>���I�索���\��i��ާ@!</font></h2>               

			</div> 
        </div>
	</div>
<!-- ======��o��===== -->

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

</html>