<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.theater.model.*"%>

<%
  TheaterVO theaterVO = (TheaterVO) request.getAttribute("theaterVO");
%>
<%= theaterVO==null %>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>廳院資料新增 - addTheater.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
		h2{
			margin-left: 325px;
		}

		label {
			padding: 0;
			margin: 2px 2px 0px 0px;
			cursor: pointer;
/* 			background-color: lightgreen;  */
		}
		input[type=checkbox] {
			display: none;
			background-color: lightgreen;
		}
		span{
			font-size: 8px;
			font-family: Arial;
			text-align: center;
			/*  */
			line-height: 25px;
			/* background-color: lightgreen; */
		}

		input[type=checkbox]+span {
			display: inline-block;
			vertical-align:middle;
			background-color: lightgreen;
			/* 			padding: 3px ; */
			border: 1px solid; /* gray; */
			color: #444;
			user-select: none; /* 防止文字被滑鼠選取反白 */
			width: 25px;
			height: 25px;		
			margin: 2px 2px;
		}

		input[type=checkbox]:checked+span {
			/* 			color: yellow; */
			background-color: #ADD8E6;

		}

		input[type=checkbox]+span:first-child {
			visibility: hidden;
		}

		#d1{
			margin: 10px 20px;
			font-size: 27px;
		}
		input#submit{
			margin-left: 330px;
		}
		button{
			width: 25px;
			height: 25px;
		}
		#d1 > label:nth-child(2){
			visibility:  hidden;
			width: 20px;
			height: 20px;
		}
		#d2{
			border: 1px solid black;
			width: 690px;
			height: 30px;
			text-align: center;
			background: orange;
			font-size: 20px;
			line-height: 30px;
		}
		#d3, #d4{
			width:25px;
			height:25px;
			border: 1px solid black;
			display:inline-block;
		}
		#d3{
			margin-left:300px;
			background-color:lightgreen;
			
		}
		#d4{
			margin-left:20px;
			background-color: #ADD8E6;
		}
		#div1{
			display:inline-block;
			display: flex;
			align-items:center;
		}
		
</style>


</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>廳院資料新增 - addTheater.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back-end/theater/select_page.jsp"><img src="<%=request.getContextPath()%>/back-end/theater/images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/theater/theater.do" name="form1">
<table>
	<tr>
		<td>廳院名稱:</td>
		<td><input type="TEXT" name="theater_name" size="45" 
			 value="<%= (theaterVO==null)? "G廳" : theaterVO.getTheater_name()%>" /></td>
	</tr>
	<tr>
		<td>廳院種類:</td>
<!-- 		<td><input type="TEXT" name="theater_type" size="45" -->
<%-- 			 value="<%= (theaterVO==null)? "0" : theaterVO.getTheater_type()%>" /></td> --%>
		<td>
			<select name="theater_type">
				<option value="0" ${(theaterVO==null) ? "" : (theaterVO.theater_type==0)?"selected":""}>2D</option>
				<option value="1" ${(theaterVO==null) ? "" : (theaterVO.theater_type==1)?"selected":""} >3D</option>
				<option value="2" ${(theaterVO==null) ? "" : (theaterVO.theater_type==2)?"selected":""} >IMAX</option>
				<option value="3" ${(theaterVO==null) ? "" : (theaterVO.theater_type==3)?"selected":""} >2D_IMAX</option>
				<option value="4" ${(theaterVO==null) ? "" : (theaterVO.theater_type==4)?"selected":""} >3D_IMAX</option>
				<option value="5" ${(theaterVO==null) ? "" : (theaterVO.theater_type==5)?"selected":""} >數位</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>廳院配置:</td>
<!-- 		<td><input type="TEXT" name="seat_no" size="45" -->
<%-- 			 value="<%= (theaterVO==null)? "0000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000000010000000000100000000100000000001000000001000000000010000" : theaterVO.getSeat_no()%>" /></td> --%>
<!-- 	</tr> -->
	
	
	
<!-- 	<tr > -->
<!-- 		<td>座位名稱:</td> -->
<!-- 		<td><input type="TEXT" name="seat_name" size="45" -->
<%-- 			 value="<%= (theaterVO==null)? "A01A02A03A04A05A06A07A08A09A10A11A12A13A14A15A16A17A18A19A20B01B02B03B04B05B06B07B08B09B10B11B12B13B14B15B16B17B18B19B20C01C02C03C04C05C06C07C08C09C10C11C12C13C14C15C16C17C18C19C20D01D02D03D04D05D06D07D08D09D10D11D12D13D14D15D16D17D18D19D20E01E02E03E04E05E06E07E08E09E10E11E12E13E14E15E16E17E18E19E20F01F02F03F04F05F06F07F08F09F10F11F12F13F14F15F16F17F18F19F20G01G02G03G04G05G06G07G08G09G10G11G12G13G14G15G16G17G18G19G20H01H02H03H04H05H06H07H08H09H10H11H12H13H14H15H16H17H18H19H20I01I02I03I04I05I06I07I08I09I10I11I12I13I14I15I16I17I18I19I20J01J02J03J04J05J06J07J08J09J10J11J12J13J14J15J16J17J18J19J20K01K02K03K04K05K06K07K08K09K10K11K12K13K14K15K16K17K18K19K20L01L02L03L04L05L06L07L08L09L10L11L12L13L14L15L16L17L18L19L20M01M02M03M04M05M06M07M08M09M10M11M12M13M14M15M16M17M18M19M20N01N02N03N04N05N06N07N08N09N10N11N12N13N14N15N16N17N18N19N20O01O02O03O04O05O06O07O08O09O10O11O12O13O14O15O16O17O18O19O20P01P02P03P04P05P06P07P08P09P10P11P12P13P14P15P16P17P18P19P20Q01Q02Q03Q04Q05Q06Q07Q08Q09Q10Q11Q12Q13Q14Q15Q16Q17Q18Q19Q20R01R02R03R04R05R06R07R08R09R10R11R12R13R14R15R16R17R18R19R20S01S02S03S04S05S06S07S08S09S10S11S12S13S14S15S16S17S18S19S20T01T02T03T04T05T06T07T08T09T10T11T12T13T14T15T16T17T18T19T20" : theaterVO.getSeat_name()%>" /></td> --%>
<!-- 	</tr> -->
</table>
<br>
<!-- 	<h2>座位管理</h2> -->
	
	<div id="div1">
		<div id="d3">
		</div>&nbsp&nbsp座位
		<div id="d4">
		</div>&nbsp&nbsp走道及禁位
	</div>

	<div id="d1" style="width:700px;">
		<div id="d2">
			螢幕位置
		</div>
	</div>
<!-- 	<input type="submit" id="submit" value="送出"> -->
<br>

<input type="hidden" name="seat_name" value="<%= (theaterVO==null)? "A01A02A03A04A05A06A07A08A09A10A11A12A13A14A15A16A17A18A19A20B01B02B03B04B05B06B07B08B09B10B11B12B13B14B15B16B17B18B19B20C01C02C03C04C05C06C07C08C09C10C11C12C13C14C15C16C17C18C19C20D01D02D03D04D05D06D07D08D09D10D11D12D13D14D15D16D17D18D19D20E01E02E03E04E05E06E07E08E09E10E11E12E13E14E15E16E17E18E19E20F01F02F03F04F05F06F07F08F09F10F11F12F13F14F15F16F17F18F19F20G01G02G03G04G05G06G07G08G09G10G11G12G13G14G15G16G17G18G19G20H01H02H03H04H05H06H07H08H09H10H11H12H13H14H15H16H17H18H19H20I01I02I03I04I05I06I07I08I09I10I11I12I13I14I15I16I17I18I19I20J01J02J03J04J05J06J07J08J09J10J11J12J13J14J15J16J17J18J19J20K01K02K03K04K05K06K07K08K09K10K11K12K13K14K15K16K17K18K19K20L01L02L03L04L05L06L07L08L09L10L11L12L13L14L15L16L17L18L19L20M01M02M03M04M05M06M07M08M09M10M11M12M13M14M15M16M17M18M19M20N01N02N03N04N05N06N07N08N09N10N11N12N13N14N15N16N17N18N19N20O01O02O03O04O05O06O07O08O09O10O11O12O13O14O15O16O17O18O19O20P01P02P03P04P05P06P07P08P09P10P11P12P13P14P15P16P17P18P19P20Q01Q02Q03Q04Q05Q06Q07Q08Q09Q10Q11Q12Q13Q14Q15Q16Q17Q18Q19Q20R01R02R03R04R05R06R07R08R09R10R11R12R13R14R15R16R17R18R19R20S01S02S03S04S05S06S07S08S09S10S11S12S13S14S15S16S17S18S19S20T01T02T03T04T05T06T07T08T09T10T11T12T13T14T15T16T17T18T19T20" : theaterVO.getSeat_name()%>" />
<input type="hidden" name="action" value="insert">
<input type="submit" id="submit" value="送出新增">
</FORM>

<script>
	let id = 0;
	let seat_no = "${theaterVO.seat_no}";
	for(let i = 0; i <= 20; i++){
		let num = 64 + i;
		let word = String.fromCharCode(num);
		let label = document.createElement("label");
		let walkway = document.createElement("input");
		walkway.setAttribute("type", "checkbox");

		let span = document.createElement("span");
		span.style.border = " 1px solid red";
		span.style.backgroundColor = "red";
		span.style.color = 'white';
		span.innerText = i;
		label.appendChild(walkway);
		label.appendChild(span);
		document.getElementById("d1").appendChild(label);
		
		walkway.setAttribute("class",word);

		walkway.addEventListener("click", function(){
			street_Check(walkway.className);
		}	, false);
		console.log( i + walkway.className);
	}
	document.getElementById("d1").appendChild(document.createElement("br"));

	for(let i = 1; i <= 20; i++){
		let num1 = 64 + i;
		let word2 = String.fromCharCode(num1);
		let label1 = document.createElement("label");
		let walkway = document.createElement("input");
		let span1 = document.createElement("span");
		span1.innerText = word2;
		span1.style.border="1px solid red";
		span1.style.backgroundColor = "red";
		span1.style.color = "white";
		walkway.setAttribute("type", "checkbox");
		walkway.setAttribute("class", i);
		label1.appendChild(walkway);
		label1.appendChild(span1);
		document.getElementById("d1").appendChild(label1);
		walkway.addEventListener("click", function(){
			street_Check(walkway.className);
		}
		, false);	
		for(let j = 1; j<= 20; j++){
			let num = 64 + i;
			let word = String.fromCharCode(num);
			let word1 = String.fromCharCode(64+j);
			let string = "";

			if(j < 10) {
				string = word + "0" + j;
			}
			else {
				string = word + "" + j;
			}
			let label = document.createElement("label");
			let seat = document.createElement("input");
			seat.setAttribute("type", "checkbox");
			seat.setAttribute("id", id);
			seat.setAttribute("class", i);
			seat.classList.add(word1);
			console.log(seat.className); 
			seat.setAttribute("value", "0");
			seat.setAttribute("name", "seat_no");
			seat.addEventListener("click", function(){
				seat_Check(seat.id)
			},false);

			let seat_name = document.createElement("span");
			seat_name.innerText = string;

			label.appendChild(seat);
			label.appendChild(seat_name);
			if(j % 20 === 0 ){
				label.appendChild(document.createElement("br"));
			}

			document.getElementById("d1").appendChild(label);
			if(seat_no != ""){
				if((seat_no.charAt(id)=="1")){
					seat.checked = true;
				}
			};
			
			id++;
		}
	}

	function seat_Check(id1){
		let whichSeat = document.getElementById(id1);

		if(whichSeat.checked === true){
			whichSeat.value = 1;
		}else if(whichSeat.checked === false){
			whichSeat.value = 0;
		}
	}

	function street_Check(cls1){ //class1
		let whichStreet = document.getElementsByClassName(cls1);

		if(whichStreet[0].checked === true){
			for(let i = 1; i < whichStreet.length; i++){
				whichStreet[i].checked = true;
				whichStreet.value = 1;
			}

		}else if(whichStreet[0].checked === false){
			for(let i = 1; i < whichStreet.length; i++){
				whichStreet[i].checked = false;
				whichStreet.value = 0;
			}
		}

	}

	let submit = document.getElementById("submit");
	submit.addEventListener("click", function(){
		for(let i = 0; i <=399; i++){
			let seat = document.getElementById(i);
			if(seat.checked === false){
				seat.checked = true;
				seat.value = 0;
			}else{
				seat.value = 1;	
			}
			// if(seat.disabled === true){
			// 	seat.disabled = false;
			// }
			console.log(seat.checked);
			console.log(seat.value);

		}
	},false);

</script>

</body>
</html>