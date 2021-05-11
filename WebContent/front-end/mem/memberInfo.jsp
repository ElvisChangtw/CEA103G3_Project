<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page import="com.mem.model.*"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
// MemVO memVO = (MemVO) session.getAttribute("memVO");
MemVO memVO = (MemVO) request.getAttribute("memVO");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/front/memberInfo.css" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">

<title>Insert title here</title>
</head>
<body>
	<div class="main-wrapper">
		<div class="info-div">
			<div class="info-content">
				<div class="tabset">
				<input type="radio" name="tabset" id="tab1"
						aria-controls="basic-info" checked> <label for="tab1">基本資料</label>
				<input type="radio" name="tabset" id="tab2"
						aria-controls="account-info" > <label for="tab2">帳號資訊</label>
				<input type="radio" name="tabset" id="tab3"
						aria-controls="payment-info" /> <label for="tab3">付款資訊</label>
				<div class="tab-panels">
					<section id="basic-info" class="tab-panel">
						<form method="post" id="user-info-form">
							<div class="user-pic">
								<img src="${pageContext.request.contextPath}/mem/mem.do?action=view_memPic&member_no=${memVO.member_no}" alt="">
								<div>
									<i class="fas fa-cloud-upload-alt"></i>
									<p>更換照片</p>
									<input type="file" name="mb_pic" id="update-mbpic">
								</div>
							</div>
								<div class="user-infos">
									<label for="mb_name">姓名</label> <input class="input-disabled" 
										type="text" name="mb_name" id="mb_name"
										value="<%= (memVO==null)? "" : memVO.getMb_name()%>" maxlength="10" placeholder="未填寫" 
										required disabled />
								</div>
								<div class="user-infos">
									<label for="mb_bd">生日</label> <input class="input-disabled"
										type="text" name="mb_bd" id="mb_bd" maxlength="10"
										value="<%= (memVO==null)? "" : memVO.getMb_bd()%>" placeholder="未填寫" required disabled />
								</div>
								<div class="user-infos">
									<label for="mb_phone">聯絡電話</label> <input
										class="input-disabled" type="tel" inputmode="numeric"
										name="mb_phone" id="mb_phone" maxlength="30"
										value="<%= (memVO==null)? "" : memVO.getMb_phone()%>" placeholder="未填寫"  required disabled />
								</div>
								<div class="user-infos">
									<label for="mb_city">居住縣市</label> <input class="input-disabled"
										type="text" name="mb_city" id="mb_city" maxlength="30"
										value="<%= (memVO==null)? "" : memVO.getMb_city()%>" placeholder="未填寫"  required disabled />
								</div>
								<div class="user-infos">
									<label for="mb_address">居住地址</label> <input
										class="input-disabled" type="text" name="mb_address"
										id="mb_address" value="<%= (memVO==null)? "" : memVO.getMb_address()%>" maxlength="50"
										placeholder="未填寫" required disabled />
								</div>
								<input style="display: none" value="${memVO.member_no}"
									name="mb_no">
								<div class="basic-info-buttons">
									<button type="button" class="btn btn-primary cancel-update">取消修改</button>
									<button type="submit" class="btn btn-warning update-basic-info">確認變更</button>
								</div>
						</form>
						<div class="basic-info-buttons">
								<button class="btn btn-secondary show-basic-update">變更基本資料</button>
						</div>

					</section>
					
					<section id="account-info" class="tab-panel">
							<form method="post" id="account-info-form">
								<div>
									<label for="mb_no">會員編號</label> <input class="input-disabled"
										type="text" name="mb_no"
										id="mb_no" value="${memVO.member_no}" readonly />
								</div>
								<div>
									<label for="mb_name">E-MAIL</label> <input
										class="input-disabled" type="text" name="mb_email"
										id="mb_email" value="${memVO.mb_email}"
										placeholder="guest@gmail.com" readonly />
								</div>
								<div>
									<label for="mb_point">消費積分</label> <input
										class="input-disabled" type="text" name="mb_point"
										id="mb_point" value="${memVO.mb_point}"
										placeholder="guest@gmail.com" readonly />
								</div>
								<div style="display: none" class="password_reset">
									<label for="mb_name">請輸入舊密碼</label> <input
										class="input-disabled" type="password" name="old_mb_pwd"
										id="old_mb_pwd" placeholder="Please enter old password" maxlength="40"
										required disabled />
								</div>
								<div style="display: none" class="password_reset">
									<label for="mb_name">請輸入新密碼</label> <input
										class="input-disabled" type="password" name="new_mb_pwd"
										id="new_mb_pwd" pattern="^[(a-zA-Z0-9_)]{2,20}$"
										placeholder="Please enter new password" maxlength="40"
										required disabled />
								</div>
								<div style="display: none" class="password_reset">
									<label for="mb_name">再次確認新密碼</label> <input
										class="input-disabled" type="password"
										name="confirm_new_mb_pwd" id="confirm_new_mb_pwd"
										pattern="^[(a-zA-Z0-9_)]{2,20}$"
										placeholder="Please confirm new password again" maxlength="40"
										required disabled />
								</div>
								<input style="display: none;" value="${memVO.member_no}"
									name="mb_id">
								<div class="basic-info-buttons">
									<button type="button" class="btn btn-primary cancel-update">取消修改</button>
									<button type="submit"
										class="btn btn-warning update-account-info">確認變更</button>
								</div>
							</form>
							<div class="basic-info-buttons">
								<button class="btn btn-secondary show-account-update">變更登入密碼</button>
							</div>
						</section>
						<jsp:useBean id="paymentSvc" scope="page"
							class="com.payment.model.PaymentService" />
						<section id="payment-info" class="tab-panel">
							<div class="creditcards">
								<c:forEach var="paymentVO"
									items="${paymentSvc.getAllCard(memVO.member_no)}">
									<div class="creditcard">
										<h4 class="cardnumber">${paymentVO.card_no}</h4>
										<h6>CARDHOLDER NAME</h6>
										<p class="cardholder">${paymentVO.card_name}</p>
										<div class="goodthru">Good Thru<p class="exp">${paymentVO.exp_mon}/${paymentVO.exp_year}</p></div>
										
										<i class="fas fa-minus-circle delete-creditcard"></i> <input
											name="pay_no" class="pay_no" style="display: none"
											value="${paymentVO.pay_no}">
										<div class="creditcard-logo">
											<img
												src="<%=request.getContextPath()%>/img/creditcard/master.png" />
										</div>
									</div>
								</c:forEach>
								<div class="addnewcard creditcard">
									<i class="fas fa-plus-circle add-creditcard"
										id="add-creditcard"></i>
								</div>
							</div>
						</section>
				</div>
			</div>
			</div>
		</div>
	</div>
	<div id="creditCard-input-view">
		<div id="insertCardDiv">
			<form id="insertCardForm">
			<table>
				<tr><th>Card No:</th><td><input type="text" size="12" id="cardnumber"></td></tr>
				<tr><th>Card Name:</th><td><input type="text" size="12" id="name"></td></tr>
				<tr><th>Expire Mon(MM):</th><td><input type="text" size="12" id="expMon"></td></tr>
				<tr><th>Expire Year(YY):</th><td><input type="text" size="12" id="expYear"></td></tr>
				<tr><th>CSC:</th><td><input type="text" size="12" id="csc"></td></tr>
			</table>
			</form>
			<div class="cardBtn">
				<button id="insertnewcard" type="button" class="btn btn-primary">Submit</button>
<!-- 				<input id="insertnewcard" type="button" value="SUBMIT"> -->
			</div>
			<div class="cardBtn">
				<button id="cancelinsert" type="button" class="btn btn-warning">Cancel</button>
<!-- 				<input id="cancelinsert" type="button" value="CANCEL"> -->
			</div>
		</div>
	</div>
	
<script src="https://cdnjs.cloudflare.com/ajax/libs/imask/3.4.0/imask.min.js"></script>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7a
bK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity=
"sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha
384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script>
$(document).ready(function () {
    $(".show-basic-update").click(function () {
        buttonShow($(this));
    });
    $(".show-account-update").click(function () {
        buttonShow($(this));
        $(".password_reset").css("display", "flex");
    });
    //按鈕出現與消失
    function buttonShow(item) {
		item.css("display", "none")
        let form = item.parent().siblings("form");
        let divs = form.children("div");
        let inputs = divs.children("input");
        inputs.prop("disabled", false);
        form.find(".cancel-update").css("display", "block");
		form.find(".cancel-update").next().css("display", "block");
        form.find(".cancel-update").click(function () {
            $(this).css("display", "none");
 			$(this).next().css("display", "none");
		    item.css("display", "block")
            inputs.prop("disabled", true);
            $(".password_reset").css("display", "none");
        });
    }
    
  //變更基本資料
    $("#user-info-form").submit(function (e) {
        e.preventDefault();
        let form = document.getElementById("user-info-form");
        let divs = $("#user-info-form").children("div");
        let inputs = divs.children("input");
        let formData = new FormData(form);
        $.ajax({
            url: "<%=request.getContextPath()%>/MemServlet?action=update_member",
            data: formData,
            type: "POST",
            contentType: false,
            processData: false,
            success: function (msg) {
                if (msg == "success") {
                    Swal.fire({
                        position: "center",
                        icon: "success",
                        title: "已成功變更您的訊息",
                        showConfirmButton: false,
                        timer: 1500,
                    });
                    $("#user-info-form").find(".cancel-update").css("display", "none");
                    $("#user-info-form").find(".update-basic-info").css("display", "none");
                    $(".show-basic-update").css("display", "block");
                    inputs.prop("disabled", true);
                    $(".password_reset").css("display", "none");
                }
            },
        });
    });
  //變更個人照片
  $("#update-mbpic").change(function(){
	  let pic = $(this).parent().siblings("img");
	  let file = this.files[0];
	  let formData = new FormData();
	  formData.append("mb_pic", file);
	  formData.append("mb_id", "${memVO.member_no}");
	  $.ajax({
		  url: "<%=request.getContextPath()%>/MemServlet?action=update_picture",
	  	  data: formData,
	  	  type:"POST",
		  contentType: false,
          processData: false,
			  success: function(msg){
				  let reader = new FileReader();
				  reader.addEventListener("load", (ex)=>{
					  pic.attr("src", ex.target.result);
				  });
				  reader.readAsDataURL(file);
			  } 
	  })
	  
  })
   //變更密碼
    $("#account-info-form").submit(function (e) {
        e.preventDefault();
        let form = document.getElementById("account-info-form");
        let divs = $("#account-info-form").children("div");
        let inputs = divs.children("input");
        let formData = new FormData(form);
        let oldpwd = $("#old_mb_pwd").val();
        let newpwd = $("#new_mb_pwd").val();
        let confirmpwd = $("#confirm_new_mb_pwd").val();
        if (newpwd != confirmpwd) {
            Swal.fire({
                position: "center",
                icon: "error",
                title: "密碼確認錯誤",
                showConfirmButton: false,
                timer: 1500,
            });
            return;
        }
        $.ajax({
            url: "<%=request.getContextPath()%>/MemServlet?action=update_password",
            data: formData,
            type: "POST",
            contentType: false,
            processData: false,
            success: function (msg) {
                if (msg == "success") {
                    Swal.fire({
                        position: "center",
                        icon: "success",
                        title: "已成功變更密碼",
                        showConfirmButton: false,
                        timer: 1500,
                    });
                    $("#old_mb_pwd").val("");
                    $("#new_mb_pwd").val("");
                    $("#confirm_new_mb_pwd").val("");
                } else if (msg == "pwd_incorrect") {
                    Swal.fire({
                        position: "center",
                        icon: "error",
                        title: "舊密碼輸入錯誤",
                        showConfirmButton: false,
                        timer: 1500,
                    });
                } else {
                    Swal.fire({
                        position: "center",
                        icon: "error",
                        title: "系統忙碌中，請洽客服人員",
                        showConfirmButton: false,
                        timer: 1500,
                    });
                }
                $("#account-info-form").find(".cancel-update").css("display", "none");
                $("#account-info-form").find(".update-account-info").css("display", "none");
                $(".show-account-update").css("display", "block");
                inputs.prop("disabled", true);
                $(".password_reset").css("display", "none");
            },
        });
    });
  $(".addnewcard").click(function(){ //新增信用卡畫面
  	$("#creditCard-input-view").css("opacity", "1");
  	$("#creditCard-input-view").css("z-index", "99");
  	$("#cancelinsert").click(()=>{
  		$("#creditCard-input-view").css("opacity", "0");
  		$("#creditCard-input-view").css("z-index", "-1");
  	})
  })
  //新增信用卡
  $("#insertnewcard").click(function(){
  	let cardname = $("#name").val();
  	let cardno = $("#cardnumber").val();
  	let expmon = $("#expMon").val();
  	let expyear = $("#expYear").val();
  	let csc = $("#csc").val();
  	let mb_no = "${memVO.member_no}"
  	$.ajax({
  		url:"<%=request.getContextPath()%>/PaymentServlet?action=insert_credit_card",
  		data:{
  			"card_name":cardname,
  			"card_no":cardno,
  			"exp_mon":expmon,
  			"exp_year":expyear,
  			"csc": csc,
  			"mb_no": mb_no
  		},
  		type:"POST",
  		success: function(msg){
  			let obj = JSON.parse(msg)
  			console.log(obj)
  			if (obj.status == "success") {
  				Swal.fire({
                      position: "center",
                      icon: "success",
                      title: "已新增付款方式",
                      showConfirmButton: false,
                      timer: 1000,
                  });
  				let fragment = document.createElement("div");
  				fragment.classList.add("creditcard");
  				fragment.innerHTML = `
                          <h4 class="cardnumber">` + cardno + `</h4>
                          <h6>CARDHOLDER NAME</h6>
                          <p class="cardholder">` + cardname + `</p>
                          <div class="goodthru">Good Thru<p class="exp">` + expmon + `/` + expyear + `</p>
                          <i class="fas fa-minus-circle delete-creditcard"></i>
                          <input name="pay_no" class="pay_no" style="display:none" value=`+ obj.payno +`>
                          <div class="creditcard-logo">
                              <img src="<%=request.getContextPath()%>/img/creditcard/master.png">
                          </div>
  						`
  				$(".creditcards").eq(0).prepend(fragment);
  				setTimeout(function(){
  					$("#creditCard-input-view").css("opacity", "0");
  	        		$("#creditCard-input-view").css("z-index", "-1");
  				}, 1000);
  			} else {
  				Swal.fire({
                      position: "center",
                      icon: "error",
                      title: "伺服器忙線中，請稍後再試",
                      showConfirmButton: false,
                      timer: 1000,
                  });
  			}
  		}
  	})
  })
  //刪除信用卡
  $(document.body).on("click", ".delete-creditcard",function () { 
  	let thisCard = $(this).parent();
  	console.log(thisCard);
      Swal.fire({
          title: "確認刪除嗎?",
          text: "刪除後將無法返回資料",
          icon: "warning",
          showCancelButton: true,
          confirmButtonColor: "#3085d6",
          cancelButtonColor: "#d33",
          confirmButtonText: "確認",
          cancelButtonText: "取消",
      }).then((result) => {
          if (result.isConfirmed) {
          	let pay_no = thisCard.find("input").val();
          	console.log(pay_no);
              $.ajax({
                  url: "<%=request.getContextPath()%>/PaymentServlet?action=delete_credit_card",
                  data: { "pay_no": pay_no },
                  type: "POST",
                  success: function (msg) {
                  	if(msg == "success") {
                  		Swal.fire({
                            position: "center",
                            icon: "success",
                            title: "已移除付款訊息",
                            showConfirmButton: false,
                            timer: 1000,
                        });
                  		thisCard.closest('.creditcard').remove();
                  	} 
                  },
                  failure: function(data){
                	  console.log(data);
                  }
              });
          }
      });
  });
});
</script>
</body>

</html>