<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.order.model.*"%>
<%@ page import="com.ord_ticket_type.model.*"%>
<%@ page import="com.ord_food.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.employee.model.*"%>

<%
	OrderVO orderVO = (OrderVO) request.getAttribute("orderVO");
%>

<% 
	java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:00");; 
	pageContext.setAttribute("df",df);
%>
<%
    EmployeeVO employeeVO = (EmployeeVO) session.getAttribute("employeeVO");
%>


<jsp:useBean id="ord_ticket_typeSvc" scope="page" class="com.ord_ticket_type.model.Ord_ticket_typeService"></jsp:useBean>
<jsp:useBean id="ord_foodSvc" scope="page" class="com.ord_food.model.Ord_foodService"></jsp:useBean>
<jsp:useBean id="foodSvc" scope="page" class="com.food.model.FoodService"></jsp:useBean>
<jsp:useBean id="ticket_typeSvc" scope="page" class="com.ticket_type.model.Ticket_typeService"></jsp:useBean>

<%
	List<Ord_ticket_typeVO> list = ord_ticket_typeSvc.getAll();
	for(int i = 0; i < list.size(); i++){
		if(orderVO.getOrder_no().intValue() != list.get(i).getOrder_no().intValue()){
			list.remove(i);
			i--;
		}
	}
	
	List<Ord_foodVO> list1 = ord_foodSvc.getAll();
	for(int i = 0; i < list1.size(); i++){
		if(orderVO.getOrder_no().intValue() != list1.get(i).getOrder_no().intValue()){
			list1.remove(i);
			i--;
		}
	}
	
	request.setAttribute("list", list);
	request.setAttribute("list1", list1);

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
    <body>
            
<!--             <div id="layoutSidenav_content"> -->
<!--                 <main> -->
                    <div class="container-fluid">
                        <h1 class="mt-4" style="text-align:center; font-weight:bolder;">後台　單一訂單資料</h1>
<%--                         <a href="<%=request.getContextPath()%>/back-end/order/addOrder.jsp" class="btn btn-primary btn-lg" ><i class="material-icons">&#xE147;&ensp;</i><span>新增訂單</span></a> --%>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="text-align:center;">
                                        <thead style="background-color:#575058; color:white;; white-space: nowrap;" >
                                            <tr>
                                           		<th>訂單<br>編號</th>
												<th>會員<br>編號</th>
												<th>場次<br>編號</th>
												<th>成立<br>時間</th>
												<th>訂單<br>狀態</th>
												<th>訂單<br>種類</th>
												<th>付款<br>方式</th>
												<th>訂單<br>總價</th>
												<th>座位</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<tr>
												<td>${orderVO.order_no}</td>
												<td>${orderVO.member_no}</td>
												<td>${orderVO.showtime_no}</td>
												<td>${df.format(orderVO.crt_dt)}</td>
												<td>
													<c:choose>
														<c:when test="${orderVO.order_status == 0 }">
															未付款
														</c:when>
														<c:when test="${orderVO.order_status == 1 }">
															已付款
														</c:when>
														<c:when test="${theaterVO.theater_type == 2 }">
															已取消
														</c:when>
													</c:choose>
												</td>
												<td>${orderVO.order_type == 0 ? "現場" : "線上"}</td>
												<td>
													<c:choose>
														<c:when test="${orderVO.payment_type == 0 }">
															信用卡
														</c:when>
														<c:when test="${orderVO.payment_type == 1 }">
															現金
														</c:when>
														<c:when test="${orderVO.payment_type == 2 }">
															現場付款
														</c:when>
													</c:choose>
												</td>
												<td>${orderVO.total_price }</td>
												<td>${orderVO.seat_name }</td>
											</tr>
											<tr>
											</tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                    </div>
                    
                    
                   <div class="container-fluid">
                        <h1 class="mt-4" style="text-align:center; font-weight:bolder;">訂單票種資料</h1>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="text-align:center;">
                                        <thead style="background-color:#707070; color:white;; white-space: nowrap;" >
                                            <tr>
                                           		<th>訂單<br>編號</th>
												<th>票種<br>編號</th>
												<th>票種<br>數量</th>
												<th>票種<br>價格</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="ord_ticket_typeVO" items="${list}">
											<c:forEach var="ticket_typeVO" items="${ticket_typeSvc.all}">
												<c:if test="${ord_ticket_typeVO.ticket_type_no == ticket_typeVO.ticket_type_no}">
		                                        	<tr>
														<td>${ord_ticket_typeVO.order_no}</td>
														<td>${ticket_typeVO.ticket_desc}</td>
														<td>${ord_ticket_typeVO.ticket_count}</td>
														<td>${ord_ticket_typeVO.price}</td>
													</tr>
											 	</c:if>
											</c:forEach>
										</c:forEach>
<!-- 										<tr> -->
<!-- 										</tr> -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                    </div>
                    
                    
                    
                   <div class="container-fluid">
                        <h1 class="mt-4" style="text-align:center; font-weight:bolder;">後台　訂單餐點資料</h1>
<%--                         <a href="<%=request.getContextPath()%>/back-end/order/addOrder.jsp" class="btn btn-primary btn-lg" ><i class="material-icons">&#xE147;&ensp;</i><span>新增訂單</span></a> --%>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="text-align:center;">
                                        <thead style="background-color:#9099AA; color:white;; white-space: nowrap;" >
                                            <tr>
                                           		<th>訂單<br>編號</th>
												<th>餐點<br>編號</th>
												<th>餐點<br>數量</th>
												<th>餐點<br>價格</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="ord_foodVO" items="${list1}">
											<c:forEach var="foodVO" items="${foodSvc.all}">
												<c:if test="${ord_foodVO.food_no == foodVO.food_no}">
		                                        	<tr>
														<td>${ord_foodVO.order_no}</td>
														<td>${foodVO.food_name}</td>
														<td>${ord_foodVO.food_count}</td>
														<td>${ord_foodVO.price}</td>
													</tr>
												</c:if>
											</c:forEach>
										</c:forEach>
<!-- 										<tr> -->
<!-- 										</tr> -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                    </div>
                    
<!--                 </main> -->
<!--             </div> -->
        
        
        </div>
 		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/back-home/js/scripts.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script src="<%=request.getContextPath()%>/back-home/dist/assets/demo/datatables-demo.js"></script>

</body>
    

</html>
