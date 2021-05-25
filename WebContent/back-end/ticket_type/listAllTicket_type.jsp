<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ticket_type.model.*"%>

<%
	Ticket_typeService ticket_typeSvc = new Ticket_typeService();
    List<Ticket_typeVO> list = ticket_typeSvc.getAll();
    pageContext.setAttribute("list",list);
%>
<!DOCTYPE html>
<html lang="en">
    <head>
    
    	<title>後台　所有票種資料</title>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <link href="<%=request.getContextPath()%>/back-home/css/styles.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
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
                <a class="nav-link dropdown-toggle1" id="userDropdown" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
            </li>
            <a class="nav-link" href="index.html">
                登出
            </a>
        </ul>
    </nav>
    
    
    
    
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <img src="<%=request.getContextPath()%>/back-home/img/logo2-1-5.png">
                        <a class="nav-link collapsed" href="tables3.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-alt"></i></div>
                            基本資料
                        </a>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLayouts1" aria-expanded="false" aria-controls="collapseLayouts1">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-cog"></i></div>
                            員工管理系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseLayouts1" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="layout-static.html">員工管理</a>
                                <a class="nav-link" href="layout-sidenav-light.html">員工權限管理</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                            <div class="sb-nav-link-icon"><i class="fas fa-video"></i></div>
                            影城基本資料系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="layout-static.html">場次管理</a>
                                <a class="nav-link" href="<%=request.getContextPath()%>/back-end/movie/backEndlistAllMovie.jsp">電影資料管理</a>
                                <a class="nav-link" href="layout-sidenav-light.html"> 廳院管理</a>
                                <a class="nav-link" href="layout-sidenav-light.html">座位管理</a>
                                <a class="nav-link" href="layout-sidenav-light.html">票種管理</a>
                                <a class="nav-link" href="layout-sidenav-light.html">餐點管理</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages2" aria-expanded="false" aria-controls="collapsePages2">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-clock"></i></div>
                            會員管理系統
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages2" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="layout-static.html">會員資料管理</a>
                                <a class="nav-link" href="layout-sidenav-light.html">會員審核</a>
                                <a class="nav-link" href="layout-sidenav-light.html"> 專業評論審核</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages3" aria-expanded="false" aria-controls="collapsePages3">
                            <div class="sb-nav-link-icon"><i class="fas fa-ticket-alt"></i></div>
                            售票管理
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapsePages3" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="layout-static.html">現場劃位</a>
                                <a class="nav-link" href="layout-sidenav-light.html">查詢線上訂單</a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="tables3.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-user-alt-slash"></i></div>
                            檢舉管理
                        </a>
                        <a class="nav-link" href="tables1.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-bullhorn"></i></div>
                            管理最新消息
                        </a>
                        <a class="nav-link" href="tables2.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-hands-helping"></i></div>
                            回應客服小幫手
                        </a>
                    </div>
                </div>
            </nav>
        </div>
            
            
            
            
            
            
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h1 class="mt-4" style="text-align:center; font-weight:bolder;">後台　所有票種資料</h1>
                        <a href="<%=request.getContextPath()%>/back-end/ticket_type/addTicket_type.jsp" class="btn btn-primary btn-lg" ><i class="material-icons">&#xE147;&ensp;</i><span>新增票種</span></a>
                            <div class="card-body">
                                <div class="table-responsive">
                                <%@ include file="pages/page1.file"%>
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="text-align:center;">
                                        <thead style="background-color:#9099AA; color:white;; white-space: nowrap;" >
                                            <tr>
                                           		<th>票種編號</th>
												<th>票種</th>
												<th>票價</th>
												<th>票種說明</th>
												<th>修改</th>
												<th>刪除</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                       	<c:forEach var="ticket_typeVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
											<tr  ${(ticket_typeVO.ticket_type_no == param.ticket_type_no) ? 'style="background-color:#C9B8DC;"':''}>
												<td>${ticket_typeVO.ticket_type_no}</td>	
										  		<td>
													<c:choose>
														<c:when test="${ticket_typeVO.ticket_type == 0 }">
															2D
														</c:when>
														<c:when test="${ticket_typeVO.ticket_type == 1 }">
															3D
														</c:when>
														<c:when test="${ticket_typeVO.ticket_type == 2 }">
															IMAX
														</c:when>
														<c:when test="${ticket_typeVO.ticket_type == 3 }">
															2D_IMAX
														</c:when>
														<c:when test="${ticket_typeVO.ticket_type == 4 }">
															3D_IMAX
														</c:when>
														<c:when test="${ticket_typeVO.ticket_type == 5 }">
															數位
														</c:when>
													</c:choose>
												</td>
												<td>${ticket_typeVO.ticket_price}
												</td>
												<td>${ticket_typeVO.ticket_desc}</td>
										
											<td>
											  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ticket_type/ticket_type.do" style="margin-bottom: 0px;">
											     <input type="submit" value="修改"
											     class="btn btn-outline-danger" style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#73BDBE; font-weight:bold; color:white;">
											     <input type="hidden" name="ticket_type_no"  value="${ticket_typeVO.ticket_type_no}">
											     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
											</td>
											
											<td>
											  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ticket_type/ticket_type.do" style="margin-bottom: 0px;">
											     <input type="submit" value="刪除"
											     class="btn btn-outline-danger" style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#FC9C9D; font-weight:bold; color:white;">
											     <input type="hidden" name="ticket_type_no"  value="${ticket_typeVO.ticket_type_no}">
											     <input type="hidden" name="action" value="delete"></FORM>
											</td>
										</tr>
									</c:forEach>
                                            <tr>
<!--                                                 <td></td> -->
<!--                                                 <td></td> -->
<!--                                                 <td></td> -->
<!--                                                 <td></td> -->
<!--                                                 <td></td> -->
<!--                                                 <td></td> -->
                                            </tr>
                                         
                                           
                                        </tbody>
                                    </table>
                                    <%@ include file="pages/page2.file"%>
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
        <script src="<%=request.getContextPath()%>/back-home/dist/assets/demo/datatables-demo.js"></script>

</body>
    

</html>
