<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.movie.model.*"%>
<%@ page import="com.comment.model.*"%>
<%@ page import="com.employee.model.*"%>

<%
	MovieService movieSvc1 = new MovieService();
	List<MovieVO> list = movieSvc1.getAll();
	pageContext.setAttribute("list", list);
%>
<%
    EmployeeVO employeeVO = (EmployeeVO) session.getAttribute("employeeVO");
%>

<!DOCTYPE html>
<html>
    <head>
    	<title>MoviesHit</title>
        <meta charset="big5" />
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
    	<a class="navbar-brand" href="<%=request.getContextPath()%>/back-home/index2.jsp">MOVIESHIT後台系統</a>
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
	                         	<span style="color: #02a388; font-size: 1em;">M</span>ovies<span style="color: #02a388; font-size: 1em;">H</span>it
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
            
            
            
            
            
            
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h1 class="mt-4" style="text-align:center; font-weight:bolder;">所有電影資料</h1>
                        <a href="<%=request.getContextPath()%>/back-end/movie/addMovie.jsp" class="btn btn-primary btn-lg" ><i class="material-icons">&#xE147;&ensp;</i><span>新增電影</span></a>
<!--                         <ol class="breadcrumb mb-4"> -->
<!--                             <li class="breadcrumb-item"> -->
                            
<!--                             </li> -->
<!--                         </ol> -->
							<nav class="navbar navbar-light breadcrumb mb-4" style="background-color: #B1DFEF;">
							    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" name="form1" class="form-inline my-2 my-lg-0 composite-query">
									<br><div class="form-row" style="text-align:center; font-weight:bold">搜尋電影:&ensp;&ensp;</div>
										
										<div class="form-group col-2">
											 <input type="text" name="MOVIE_NAME" value="" class="form-control" placeholder="輸入電影名稱" size="10"><br>
										</div>&ensp;
										
<!-- 										<div class="form-group col-2"> -->
<!-- 											<input type="text" name="DIRECTOR" value="" class="form-control" placeholder="請輸入導演" size="10"><br> -->
<!-- 										</div>&ensp; -->
								       
<!-- 								       <div class="form-group col-2"> -->
<!-- 											<input type="text" name="ACTOR" value="" class="form-control" placeholder="請輸入演員" size="10"><br> -->
<!-- 										</div>&ensp; -->
								      
										<div class="form-group col-2">
								       <select  name="category" class="form-control form-control-sm" style="height:38px; font-size:16px;">
											<option value="">選擇類型</option>
											<option value="動作片">動作片</option>
											<option value="冒險片">冒險片</option>
											<option value="科幻片">科幻片</option>
											<option value="犯罪片">犯罪片</option>
											<option value="警匪片">警匪片</option>
											<option value="喜劇片">喜劇片</option>
											<option value="劇情片">劇情片</option>
											<option value="愛情片">愛情片</option>
								       	</select>
								       	</div>&ensp;
								       	
								       	<div class="form-group col-2">
								       	<select size="1" name="STATUS" class="form-control form-control-sm" style="height:38px; font-size:16px;">
											<option value="">選擇電影狀態</option>
											<option value="0">上映中</option>
											<option value="1">未上映</option>
											<option value="2">已下檔</option>
							      		</select>&ensp;
							    		</div>
							    		
							    		<div class="form-group col-2">
											<input type="text" name="PREMIERE_DT" id="f_date1" class="form-control" placeholder="輸入上映日期" size="12">&ensp;
							 		       <input type="text" name="OFF_DT" id="f_date2" class="form-control" placeholder="輸入下映日期" size="12">&ensp;
										</div>
								       	
							       		<div class="form-group col-2">
							       		<select size="1" name="GRADE" class="form-control form-control-sm" style="height:38px; font-size:16px;">
											<option value="">選擇分級</option>
											<option value="0">普遍級</option>
											<option value="1">保護級</option>
											<option value="2">輔導級</option>
											<option value="3">限制級</option>
							       		</select>&ensp;
										</div>
										
										<div class="form-group col-2">
											<input type="hidden" name="action" value="listMovies_ByCompositeQuery_back">
									      	<button class="btn btn-primary" type="submit" value="送出"
									      	style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#AE67D8; font-weight:bold; color:white;"
									      	>搜尋</button>
								      	</div>
									</div><br>
							     </FORM>
							</nav>
                           
                           
                           
                            <div class="card-body">
                                <div class="table-responsive">
                                <%@ include file="pages/page1.file"%>
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="text-align:center;">
                                        <thead style="background-color:#9099AA; color:white;; white-space: nowrap;" >
                                            <tr>
                                                <th align="center">劇照1</th>
												<th align="center">劇照2</th>
<!-- 												<th align="center">導演</th> -->
<!-- 												<th align="center">演員</th> -->
												<th align="center">類型</th>
												<th align="center">長度</th>
												<th align="center">狀態</th>
												<th align="center">上映/下映</th>
												<th align="center">分級</th>
												<th align="center">預告片</th>
												<th align="center">修改</th>
												<th align="center">刪除</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="movieVO" items="${list}" begin="<%=pageIndex%>"
									end="<%=pageIndex+rowsPerPage-1%>">

										  <tr  ${(movieVO.movieno == param.movieno) ? 'style="background-color:#C9B8DC;"':''}>
											<td>
												<a href="${pageContext.request.contextPath}/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}">
												<img src="${pageContext.request.contextPath}/movie/DBGifReader1.do?movieno=${movieVO.movieno}" 
												alt="尚無圖片" width="100px;" height="120px" title="${movieVO.moviename}"/> 
												<span  style="text-align: center; display:block; font-size:12px; font-weight:bold;">${movieVO.moviename}</span></a></td>
											<td>
												<a href="${pageContext.request.contextPath}/movie/movie.do?action=getOne_For_Display&movieno=${movieVO.movieno}">
												<img src="${pageContext.request.contextPath}/movie/DBGifReader2.do?movieno=${movieVO.movieno}" 
												alt="尚無圖片" width="100px;" height="120px" title="${movieVO.moviename}"/></a></td>
											
<%-- 											<td width="50px;">${movieVO.director}</td> --%>
<%-- 											<td width="50px;">${movieVO.actor}</td> --%>
											<td width="90px;">${movieVO.category}</td>
											
											<c:choose>
												<c:when test="${movieVO.length >0}">
													<td width="90px">${movieVO.length}分鐘</td>
												</c:when>
												<c:otherwise>
													<td width="90px;">尚無時間</td>
												</c:otherwise>
											</c:choose>
											
											<c:choose>
												<c:when test="${movieVO.status.equals('0')}">
													<td width="90px;">上映中</td>
												</c:when>
												<c:when test="${movieVO.status.equals('1')}">
													<td width="90px;">未上映</td>
												</c:when>
												<c:when test="${movieVO.status.equals('2')}">
													<td width="90px;">已下檔</td>
												</c:when>
												<c:otherwise>
													<td width="90px;">無效狀態</td>
												</c:otherwise>
											</c:choose>
											
											<td width="125px;">
												<fmt:formatDate value="${movieVO.premiredate}" pattern="yyyy-MM-dd" /><br>
												<fmt:formatDate value="${movieVO.offdate}" pattern="yyyy-MM-dd" />
											</td>
											
											<c:choose>
												<c:when test="${movieVO.grade.equals('0')}">
													<td width="90px;">普遍級</td>
												</c:when>
												<c:when test="${movieVO.grade.equals('1')}">
													<td width="90px;">保護級</td>
												</c:when>
												<c:when test="${movieVO.grade.equals('2')}">
													<td width="90px;">輔導級</td>
												</c:when>
												<c:when test="${movieVO.grade.equals('3')}">
													<td width="90px;">限制級</td>
												</c:when>
												<c:otherwise>
													<td width="90px;">尚未分級</td>
												</c:otherwise>
											</c:choose>
												
											<td width="90px;"><a href="${movieVO.trailor}" class="btn btn-outline-danger"
											style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#F5CA5E; font-weight:bold; color:white;">觀賞</a></td>
		<!-- 									<td> -->
		<!-- 										<div id="coverImg" onclick="onPlayerReady()">  -->
		<!-- 										<a class="w3_play_icon1" >觀賞</a></div>  -->
		<!-- 										<div id="ytplayer" style="display:none"></div> -->
		<!-- 									</td> -->
											
											<td width="50px;">
												<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" style="margin-bottom: 0px;">
													<input type="submit" value="修改"
													 class="btn btn-outline-danger" style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#73BDBE; font-weight:bold; color:white;"> 
													<input type="hidden" name="movieno" value="${movieVO.movieno}"> 
													<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
													<!--送出本網頁的路徑給Controller-->
													<input type="hidden" name="whichPage" value="<%=whichPage%>">
													<!--送出當前是第幾頁給Controller-->
													<input type="hidden" name="action" value="getOne_For_Update">
												</FORM>
											</td>
											
											<td width="50px;">
												<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/movie/movie.do" style="margin-bottom: 0px;">
													<input type="submit" value="刪除"
													class="btn btn-outline-danger" style="border:2px #B7B7B7 solid;border-radius:10px; background-color:#FC9C9D; font-weight:bold; color:white;"> 
													<input type="hidden" name="movieno" value="${movieVO.movieno}"> 
													<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
													<!--送出本網頁的路徑給Controller-->
													<input type="hidden" name="whichPage" value="<%=whichPage%>">
													<!--送出當前是第幾頁給Controller-->
													<input type="hidden" name="action" value="delete">
												</FORM>
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
