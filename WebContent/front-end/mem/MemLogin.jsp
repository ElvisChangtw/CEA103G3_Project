<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>

<%
  MemVO memVO = (MemVO) request.getAttribute("memVO");
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>MemLogin</title>
<!--     自定義css格式開始 -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styleForMember.css" />
<!--引用 jQuery + Bootstrap -->
<script src='//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js'></script>
<!-- <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet"></link> -->

<!-- Bootstrap 的 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<style>
body{
	margin:0;
	color:#6a6f8c;
	background:#c8c8c8;
	font:600 16px/18px 'Open Sans',sans-serif;
}
*,:after,:before{box-sizing:border-box}
.clearfix:after,.clearfix:before{content:'';display:table}
.clearfix:after{clear:both;display:block}
a{color:inherit;text-decoration:none}

.login-wrap{
	width:100%;
	margin:auto;
	max-width:525px;
	min-height:920px;
	position:relative;
	background:url(https://raw.githubusercontent.com/khadkamhn/day-01-login-form/master/img/bg.jpg) no-repeat center;
	box-shadow:0 12px 15px 0 rgba(0,0,0,.24),0 17px 50px 0 rgba(0,0,0,.19);
}
.login-html{
	width:100%;
	height:100%;
	position:absolute;
	padding:90px 70px 50px 70px;
	background:rgba(40,57,101,.9);
}
.login-html .sign-in-htm,
.login-html .sign-up-htm{
	top:0;
	left:0;
	right:0;
	bottom:0;
	position:absolute;
	transform:rotateY(180deg);
	backface-visibility:hidden;
	transition:all .4s linear;
}
.login-html .sign-in,
.login-html .sign-up,
.login-form .group .check{
	display:none;
}
.login-html .tab,
.login-form .group .label,
.login-form .group .button{
	text-transform:uppercase;
}
.login-html .tab{
	font-size:22px;
	margin-right:15px;
	padding-bottom:5px;
	margin:0 15px 10px 0;
	display:inline-block;
	border-bottom:2px solid transparent;
}
.login-html .sign-in:checked + .tab,
.login-html .sign-up:checked + .tab{
	color:#fff;
	border-color:#1161ee;
}
.login-form{
	min-height:345px;
	position:relative;
	perspective:1000px;
	transform-style:preserve-3d;
}
.login-form .group{
	margin-bottom:15px;
}
.login-form .group .label,
.login-form .group .input,
.login-form .group .button{
	width:100%;
	color:#fff;
	display:block;
}
.login-form .group .input,
.login-form .group .button{
	border:none;
	padding:15px 20px;
	border-radius:25px;
	background:rgba(255,255,255,.1);
}
.login-form .group input[data-type="password"]{
	text-security:circle;
	-webkit-text-security:circle;
}
.login-form .group .label{
	color:#aaa;
	font-size:12px;
}
.login-form .group .button{
	background:#1161ee;
}
.login-form .group label .icon{
	width:15px;
	height:15px;
	border-radius:2px;
	position:relative;
	display:inline-block;
	background:rgba(255,255,255,.1);
}
.login-form .group label .icon:before,
.login-form .group label .icon:after{
	content:'';
	width:10px;
	height:2px;
	background:#fff;
	position:absolute;
	transition:all .2s ease-in-out 0s;
}
.login-form .group label .icon:before{
	left:3px;
	width:5px;
	bottom:6px;
	transform:scale(0) rotate(0);
}
.login-form .group label .icon:after{
	top:6px;
	right:0;
	transform:scale(0) rotate(0);
}
.login-form .group .check:checked + label{
	color:#fff;
}
.login-form .group .check:checked + label .icon{
	background:#1161ee;
}
.login-form .group .check:checked + label .icon:before{
	transform:scale(1) rotate(45deg);
}
.login-form .group .check:checked + label .icon:after{
	transform:scale(1) rotate(-45deg);
}
.login-html .sign-in:checked + .tab + .sign-up + .tab + .login-form .sign-in-htm{
	transform:rotate(0);
}
.login-html .sign-up:checked + .tab + .login-form .sign-up-htm{
	transform:rotate(0);
}

.hr{
	height:2px;
	margin:60px 0 50px 0;
	background:rgba(255,255,255,.2);
}
.foot-lnk{
	text-align:center;
}
.modal-footer {
   border-top: 0px; 
}
.errorMsgs {
	position: absolute;
	left: 71%;
	top: 15%;
}
.successMsgs {
	position: absolute;
	left: 71%;
	top: 15%;
}


</style>
</head>
<body>


<div class="errorMsgs">
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤:</font>
		<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
		</ul>
	</c:if>
</div>

<div class="successMsgs">
	<%-- 錯誤表列 --%>
	<c:if test="${not empty successMsgs}">
		<ul>
		<c:forEach var="message" items="${successMsgs}">
			<li style="color:green">${message}</li>
		</c:forEach>
		</ul>
	</c:if>
</div>


<div class="login-wrap">
	<div class="login-html">
		<input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">Sign In</label>
		<input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">Sign Up</label>
		<div class="login-form">
		
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" name="form1" data-toggle="validator">
			<div class="sign-in-htm">
				<div class="group form-group">
					<label for="user" class="label">Email</label>
					<input id="user" type="text" name="mb_email" class="input" value="<%= (memVO==null)? "" : memVO.getMb_email()%>" data-error="郵件格式錯誤" pattern="^[(a-zA-Z0-9_)]{2,20}[@][(a-zA-Z0-9)]{3,10}[.][(a-zA-Z)]{1,5}$" required="required" autocomplete="off">
				<div class="help-block with-errors"></div>
				</div>
				<div class="group form-group">
					<label for="pass" class="label">Password</label>
					<input id="pass" type="password" name="mb_pwd" class="input" data-type="password" value="<%= (memVO==null)? "" : memVO.getMb_pwd()%>" data-error="請輸入英文字母、數字 ,且長度必需在2到20之間" pattern="^[(a-zA-Z0-9_)]{2,20}$" required="required" autocomplete="off">
				<div class="help-block with-errors"></div>
				</div>
<!-- 				<div class="group"> -->
<!-- 					<input id="check" type="checkbox" class="check" checked> -->
<!-- 					<label for="check"><span class="icon"></span> Keep me Signed in</label> -->
<!-- 				</div> -->
				<br>
				<div class="group">
					<input type="hidden" name="action" value="login_check">
					<input type="submit" class="button" value="Sign In">
				</div>
				<div class="hr"></div>
				<div class="foot-lnk">
					<div class="container">
 					 <a href="#" data-target="#pwdModal" data-toggle="modal">Forgot my password</a>
					</div>
				</div>
			</div>
</FORM>
		
			
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" name="form2" enctype="multipart/form-data" data-toggle="validator">
			<div class="sign-up-htm">
				<div class="group form-group">
					<label for="name" class="label">Member Name</label>
					<input id="name" type="text"  name="mb_name" class="input" value="<%= (memVO==null)? "" : memVO.getMb_name()%>" data-error="請輸入中、英文字母、數字 ,且長度必需在2到10之間" pattern="^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$" required="required" autocomplete="off">
				<div class="help-block with-errors"></div>
				</div>
				<div class="group form-group">
					<label for="email" class="label">Email</label>
					<input id="email" type="text" name="mb_email" class="input" value="<%= (memVO==null)? "" : memVO.getMb_email()%>" data-error="郵件格式錯誤" pattern="^[(a-zA-Z0-9_)]{2,20}[@][(a-zA-Z0-9)]{3,10}[.][(a-zA-Z)]{1,5}$" required="required" autocomplete="off">
				<div class="help-block with-errors"></div>
				</div>
				<div class="group form-group">
					<label for="pass2" class="label">Password</label>
					<input id="pass2" type="password" name="mb_pwd" class="input" data-type="password" value="<%= (memVO==null)? "" : memVO.getMb_pwd()%>" data-error="請輸入英文字母、數字 ,且長度必需在2到20之間" pattern="^[(a-zA-Z0-9_)]{2,20}$" required="required" autocomplete="off">
				<div class="help-block with-errors"></div>
				</div>
				<div class="group">
					<label for="f_date1" class="label">Birthday</label>
					<input id="f_date1" type="text" name="mb_bd" class="input">
				</div>
				<div class="group form-group">
					<label for="phone" class="label">Phone</label>
					<input id="phone" type="text" name="mb_phone" class="input" value="<%= (memVO==null)? "" : memVO.getMb_phone()%>" data-error="請輸入數字且最長10位數" pattern="^[(0-9)]{2,10}$" required="required" autocomplete="off">
				<div class="help-block with-errors"></div>
				</div>
				<div class="group">
					<label for="city" class="label">City</label>
					<select id="city" name="city"></select><select id="area" name="area"></select>
				</div>
				<div class="group form-group">
					<label for="address" class="label">Address</label>
					<input id="address" type="text" name="mb_address" class="input" value="<%= (memVO==null)? "" : memVO.getMb_address()%>" data-error="請輸入中、英文、數字, 且長度必需在2到30之間" pattern="^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,30}$" required="required" autocomplete="off">
				<div class="help-block with-errors"></div>
				</div>
				<div class="group">
					<label for="photo" class="label">Photo</label>
					<input id="photo" type="file" name="mb_pic" class="input" accept="image/*">
				</div>
				<div class="group">
					<input type="hidden" name="action" value="insert">
					<input type="submit" id="btn" class="button" value="Sign Up">
				
				</div>
				<div class="hr"></div>
			</div>
		</div>
	</div>
</div>
</FORM>


<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" name="form3" enctype="multipart/form-data" data-toggle="validator">
<!--modal-->
<div id="pwdModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
  <div class="modal-content">
      <div class="modal-header">
          <h1 class="text-center">What's My Password?</h1>
      </div>
      <div class="modal-body">
          <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="text-center">
                          
                          <p>If you have forgotten your password you can reset it here.</p>
                            <div class="panel-body">
                                <fieldset>
                                        
                                        <div class="group form-group">
										<input id="email" type="text" name="mb_email" placeholder="E-mail Address" class="input form-control input-lg" value="<%= (memVO==null)? "" : memVO.getMb_email()%>" data-error="郵件格式錯誤" pattern="^[(a-zA-Z0-9_)]{2,20}[@][(a-zA-Z0-9)]{3,10}[.][(a-zA-Z)]{1,5}$" required="required" autocomplete="off">
										<div class="help-block with-errors"></div>
                                        
                                    </div>
                                    <input type="hidden" name="action" value="forgot_password">
                                    <input class="btn btn-lg btn-primary btn-block" value="Send My Password" type="submit">
                                </fieldset>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
      </div>
      <div class="modal-footer">
          <div class="col-md-12">
          <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
		  </div>	
      </div>
  </div>
  </div>
</div>
</FORM>

	<!--引用 Validator-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.9/validator.min.js"></script>

    <!-- body 結束標籤之前，載入Bootstrap 的 JS 及其相依性安裝(jQuery、Popper) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>



</body> 
<script src="<%=request.getContextPath()%>/js/city_area.js"></script>
<script type="text/javascript">
 window.onload = function () {
       AddressSeleclList.Initialize('city', 'area');
   };

</script>
<% 
  java.sql.Date mb_bd = null;
  try {
	  mb_bd = memVO.getMb_bd();
   } catch (Exception e) {
	   mb_bd = new java.sql.Date(System.currentTimeMillis());
   }
%>
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
		   value: '<%=mb_bd%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', //去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
</script> 
</html>