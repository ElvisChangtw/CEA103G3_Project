<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.employee.model.*"%>

<%
  EmployeeVO employeeVO = (EmployeeVO) request.getAttribute("employeeVO"); //EmpServlet.java (Concroller) 存入req的employeeVO物件 (包括幫忙取出的employeeVO, 也包括輸入資料錯誤時的employeeVO物件)
%>
<%-- <%= employeeVO==null %> --%>
<html lang="en" class="no-js">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>員工資料修改 - update_employee_input.jsp</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0"> 

        <meta name="description" content="Login and Registration Form with HTML5 and CSS3" />
        <meta name="keywords" content="html5, css3, form, switch, animation, :target, pseudo-class" />
        <meta name="author" content="Codrops" />
        <link rel="shortcut icon" href="../favicon.ico"> 
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/back-end/employee/css/demo.css" />
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/back-end/employee/css/stylexxx.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/back-end/employee/css/animate-custom.css" />

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

        <div class="container">
        <header>
                <h1></span></h1>
            </header>
            <section>				
                <div id="container_demo" >
                    <!-- hidden anchor to stop jump http://www.css3create.com/Astuce-Empecher-le-scroll-avec-l-utilisation-de-target#wrap4  -->
                    <a class="hiddenanchor" id="toregister"></a>
                    <div id="wrapper">
                    

                        <div id="register" class="animate form">
                            <form  METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/employee/employee.do" name="form1" autocomplete="on"> 
                                <h1> 員工修改 </h1> 
                                <p> 
                                    <label for="empno" data-icon="u">員工編號:</label>
                                    <input id="empno" name="empno" required="required" type="text" value="<%=employeeVO.getEmpno()%>" />
                                </p>
                                
                                <p> 
                                    <label for="empname" data-icon="u" >員工姓名:</label>
                                    <input id="empname" name="empname" required="required" type="text" value="<%=employeeVO.getEmpname()%>" /> 
                                </p>
                                
                                 <p> 
                                    <label for="emppwd" data-icon="p">員工密碼:</label>
                                    <input id="emppwd" name="emppwd" required="required" type="password" value="<%=employeeVO.getEmppwd()%>" />
                                </p>
                                
                                <p> 
                                    <label for="gender">性別:</label>
                                		<select size="1" name="gender">
										<option value="0">女
										<option value="1">男
									</select>
                                </p>
                                
                                <p> 
                                    <label for="tel" data-icon="u">電話:</label>
                                    <input id="tel" name="tel" required="required" type="text" value="<%=employeeVO.getTel()%>" />
                                </p>
                                
                                <p> 
                                    <label for="email" data-icon="e">電子郵件:</label>
                                    <input id="email" name="email" required="required" type="text"  value="<%=employeeVO.getEmail()%>" />
                                </p>
                                
                                <p> 
                                    <label for="title" data-icon="u">職稱:</label>
                                    <input id="title" name="title" required="required" type="text" value="<%=employeeVO.getTitle()%>" />
                                </p>
                                
                                <p> 
                                    <label for="f_date1" data-icon="u">雇用日期:</label>
                                    <input id="f_date1" name="hiredate" required="required" type="text" value="<%=employeeVO.getHiredate()%>"/>
                                </p>
                                
                                <p> 
                                    <label for="f_date2" data-icon="u">離職日期:</label>
                                    <input id="f_date2" name="quitdate" required="required" type="text" value="<%=employeeVO.getQuitdate()%>"/>
                                </p>
                                
                                <p> 
                                 	 <label for="status" data-icon="u">在職狀態:</label>
									 <input id="status" name="status" required="required" type="text" value="<%=employeeVO.getStatus()%>"/>
<!--                                   	 <input type="radio" name="status" value="0">已離職 -->
<!-- 									 <input type="radio" name="status" value="1" checked>在職中 -->
<!-- 									 <input type="radio" name="status" value="2">留職停薪 -->
                                </p>
                                
                                
                                
                                <p class="signin button"> 
									<input type="hidden" name="action" value="update">
									<input type="hidden" name="empno" value="<%=employeeVO.getEmpno()%>">
									<input type="submit" value="save">
								</p>
                            </form>
                        </div>
						
                    </div>
                </div>  
            </section>
        </div>
    </body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:false,       //timepicker:true,
 	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
 	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
 		   value: '<%=employeeVO.getHiredate()%>', // value:   new Date(),
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
 		   value: '<%=employeeVO.getQuitdate()%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        
        
        
   
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
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

        
        //      2.以下為某一天之後的日期無法選擇
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


        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
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