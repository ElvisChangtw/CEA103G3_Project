<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.group.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.mappingtool.*"%>

<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%
// 	GroupVO groupVO = (GroupVO) request.getAttribute("groupVO");

%>
<jsp:useBean id="memVO" scope="session" type="com.mem.model.MemVO" />

<jsp:useBean id="mapping" scope="page" class="com.mappingtool.StatusMapping" />

<html>
<head>
<title>���θ�� - listOneGroup.jsp</title>
<!--     �۩w�qcss�榡�}�l -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styleForGroup.css" />
<!--     �۩w�qcss�榡���� -->

<style>
body {
	background-color: #cccccc;
}

table#table-2 {
	background-color: #5bc0de;
	border: 2px solid black;
	text-align: center;
	margin: 0px auto;
}

table#table-2 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>

<style>
table {
	background-color: white;
	width: 100%
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>

</head>
<body>
	<table id="table-2">
		<tr>
			<td>
				<h3>
					<strong><em>���θ��</em></strong>
				</h3> <%-- 		 <h4><a href="<%=request.getContextPath()%>/front-end/group/select_page.jsp"  --%>
				<!-- 					class="btn btn-primary btn-lg active" role="button">�^�W��</a></h4> -->
			</td>
		</tr>
	</table>

	<table id="table-listOne" class="table  table-bordered">
		<tr class="active">
			<th>����(�s��)</th>
			<th>����(�s��)</th>
			<th>����</th>
			<th>�H��<br>(�ݨD�H��)
			</th>
<!-- 			<th>���A</th> -->
			<th>����</th>
			<th>�I��ɶ�</th>
			<th>Action</th>
			<!-- 		<th>�̫�ק�ɶ�</th> -->
			<!-- 		<th>�I��ɶ�</th> -->
			<!-- 		<th>�ק�</th> -->
<!-- 					<th>�R��</th> -->
		</tr>

		<tr>
			<td>${groupVO.group_title}(${groupVO.group_no})</td>
			<td>(${groupVO.showtime_no})</td>
			<%-- 			<td>${groupVO.member_no}</td> --%>
			<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
			<jsp:useBean id="groupSvc" scope="page"	class="com.group.model.GroupService" />
				
			<td id="member" style="text-align:left;">
				<c:forEach var="group_memberVO" items="${groupSvc.getMembersByGroupno(groupVO.group_no)}">
					<div id="${groupVO.group_no}-${group_memberVO.member_no}">
						<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${group_memberVO.member_no}" 
						alt="�|�L�Ϥ�" width="96px;" height="108px" title=" ${memSvc.getOneMem(group_memberVO.member_no).mb_name}" style="border: groove;"/>
						${memSvc.getOneMem(group_memberVO.member_no).mb_name}
						<c:if test="${groupSvc.getOneGroup(group_memberVO.group_no).member_no== group_memberVO.member_no}"> 
		                    <font color="red"><b>*</b></font>
	            		</c:if>
            		</div>
				</c:forEach>
			</td>
			<td id="groupCnt">${groupVO.member_cnt}(${groupVO.required_cnt})</td>
<%-- 			<td>${mapping.dboGroup_GroupStatus(groupVO.group_status)}</td> --%>
			<td>${groupVO.desc}</td>
			<td id="dd-cntDown"><fmt:formatDate value="${groupVO.deadline_dt}"
					pattern="yyyy-MM-dd HH:mm" /></td>
			<td>
				<div class="container">
					<div class="row">
						<button id="joinBtn" class="btn btn-primary" ${(groupVO.member_cnt < groupVO.required_cnt) ?  '' : 'disabled'}>
							${(groupVO.member_cnt < groupVO.required_cnt) ?  '�{�b�[�J' : '�H�Ƥw��'}
							</button> 
					</div>
					<div class="row">
						<button id="leaveBtn" class="btn btn-danger" style="display:none">
							�h�X����
						</button> 
					</div>
					<div class="row" id="modifyBtn">
								<a href="<%=request.getContextPath()%>/group/group.do?group_no=${groupVO.group_no}&action=getOne_For_Update" 
								style="margin-bottom: 0px;" class="btn btn-success">�קﴪ��</a>
					</div>
					
					<div class="row" id="reportBtn">
								<a href="<%=request.getContextPath()%>/front-end/report_group/addReport_Group.jsp?group_no=${groupVO.group_no}" 
								style="margin-bottom: 0px;" class="btn">���|����</a>
					</div>
					<div class="row" id="dismissBtn">
								<a href="<%=request.getContextPath()%>/group/group.do?group_no=${groupVO.group_no}&action=delete" 
								style="margin-bottom: 0px;" class="btn btn-danger">�Ѵ�����</a>
					</div>
				</div>
			</td>
		</tr>
	</table>
	
	
	<script>
	
	//�_�l�ʧ@
	//1. �L�X���κI��ɶ�(�C���s)
	//2. �o�Xajax �ШD�T�{�|���O�_�w�b���Τ�, �̦����[�J/�h�X���s���
	console.log("dsfsdf");	
	let memberCnt = ${groupVO.member_cnt};
	
	$(function() {
		//�T�{�|���O�_���Ϊ�, �M�w��ܱ���
		if(${memVO.member_no == groupVO.member_no}){
			console.log("�Ϊ�!");
			$("#joinBtn").hide();
			$("#leaveBtn").hide();
			$("#modifyBtn").show();
			$("#reportBtn").show();
			$("#dismissBtn").show();
		}
		else{
			console.log("���O�Ϊ�!");
			$("#modifyBtn").hide();
			$("#reportBtn").show();
			$("#dismissBtn").hide();
		}
		
		
		//�T�{�|���O�_���Ϊ�, �M�w��ܱ���
		
		
		//���κI��˼ƭp��
		$("#dd-cntDown").html(
    			'<fmt:formatDate value="${groupVO.deadline_dt}" pattern="yyyy-MM-dd HH:mm" />'
    			+ '<br><p class="counter">(' + timeFormat(timeLeft())  + ')</p>');
		let timer = setInterval(function() {
            let left = timeLeft(); 
            if (left >= 1000) {
            	$("#dd-cntDown").html(
            			'<fmt:formatDate value="${groupVO.deadline_dt}" pattern="yyyy-MM-dd HH:mm" />'
            			+ '<br><p class="counter">(' + timeFormat(left)  + ')</p>');
            	if(left <= 1000 * 60 *5 ){
            		$("#dd-cntDown>p").toggleClass("counter", false);
            		$("#dd-cntDown>p").toggleClass("urgentCounter", true);
            	}
            }
            else {
                console.log('���Τw�I��I');
                clearInterval(timer); 
            }
        }, 1000);
		//���κI��˼ƭp��
		
		$.ajax({
			url: "<%=request.getContextPath()%>/group_member/group_member.do",
			type:"POST",
			data: {
				group_no:"${groupVO.group_no}",
				member_no:"${memVO.member_no}",
				action:"checkMemIfExist"
			},
			success: function(msg){
				if(!${memVO.member_no == groupVO.member_no}){
					if(msg==="success"){
						
						$("#leaveBtn").show();
						$("#joinBtn").hide();
					}else{

						$("#joinBtn").show();
					}
				}
			}
		});
		
	});
	//�_�l�ʧ@
		
		$("#joinBtn").click(function(){
			$.ajax({
				url: "<%=request.getContextPath()%>/group_member/group_member.do",
				type:"POST",
				data: {
					group_no:"${groupVO.group_no}",
					member_no:"${memVO.member_no}",
					pay_status:"0",
					status:"1",
					action:"insert",
					requestURL:"<%=request.getServletPath()%>"
					
				},
				success: function(data){
					$("#joinBtn").hide();
					$("#member").append(
						  '<div id="${groupVO.group_no}-${memVO.member_no}">'
						+ '<img src="${pageContext.request.contextPath}/mem/DBGifReader4.do?member_no=${memVO.member_no}" '
						+ 'alt="�|�L�Ϥ�" width="96px;" height="108px" title=" ${memVO.mb_name}"'
						+ 'style="border: groove;"/>'
						+ '${memVO.mb_name}'
						+ '<br>'
						);
					memberCnt ++;
					$("#groupCnt").text('(' +memberCnt + ")${groupVO.required_cnt}");
					 Swal.fire({
	                        position: "center",
	                        icon: "success",
	                        title: "�w���\�[�J����",
	                        showConfirmButton: false,
	                        timer: 1500,
	                    });
					 $("#leaveBtn").show();
				}
			});
		});
		
		$("#leaveBtn").click(function(){
			$.ajax({
				url: "<%=request.getContextPath()%>/group_member/group_member.do",
				type:"POST",
				data: {
					group_no:"${groupVO.group_no}",
					member_no:"${memVO.member_no}",
					action:"delete",
					requestURL:"<%=request.getServletPath()%>"
				},
				success: function(data){
					$("#leaveBtn").hide();
					$("#${groupVO.group_no}-${memVO.member_no}").remove();
					memberCnt--;
					$("#groupCnt").text('(' +memberCnt + ")${groupVO.required_cnt}");
					
					 Swal.fire({
	                        position: "center",
	                        icon: "success",
	                        title: "�w���\�h�X����",
	                        showConfirmButton: false,
	                        timer: 1500,
	                    });
					 $('#joinBtn').removeAttr('disabled','disabled');
					 let joinBtnTxt = (memberCnt < ${groupVO.required_cnt}) ? '�{�b�[�J' : '�H�Ƥw��';
					 $("#joinBtn").text(joinBtnTxt);
					 $("#joinBtn").show();
				}
			});
		});
		
		
		
		
		//�˼ƭp��
        function timeLeft() {
            // ���o�{�b�ɶ�
            let now = new Date();
            // �ӧO���o�@��� �Z��1970/1/1���@���
            let nowTime = now.getTime();
            let deadTime = Date.parse("${groupVO.deadline_dt}");
            // �^�Ǭۮt���@���
            return deadTime - nowTime;
        }
        // 3. �g�@�Ө禡�A�^�Ǯ榡�ƳѾl���ɶ��A�榡�G'�Z�����Ф�A�ٳѤU 23��5�p��23��3��C'
        function timeFormat(leftTimes) { // �ǤJ�@���
        	const DAY = 24 * 60 * 60;
            const HOUR = 60 * 60;
            const MINUTE = 60;
            var secondLeft = Math.floor(leftTimes / 1000);
            var dayLeft = Math.floor(secondLeft / DAY);
            var secondLeft = secondLeft % DAY;
            var hourLeft = Math.floor(secondLeft / HOUR);
            var secondLeft = secondLeft % HOUR;
            var minuteLeft = Math.floor(secondLeft / MINUTE);
            var secondLeft = secondLeft % MINUTE;
            return   + dayLeft + 'day' + hourLeft + 'hr' + minuteLeft + 'min' + secondLeft + 'sec';
        }

 	</script> 
</body>
</html>