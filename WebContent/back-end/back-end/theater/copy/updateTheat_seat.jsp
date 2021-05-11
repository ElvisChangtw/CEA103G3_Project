<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta name="viewport" content="width=	, initial-scale=1.0">
	<title>Document</title>
	<style>
/* 		body{ */
/* 			background-color: white; */
/* 		} */

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
			margin-left: 1000px;
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
<body>
	<h2>座位管理</h2>
	
	<div id="div1">
		<div id="d3">
		</div>&nbsp&nbsp座位
		<div id="d4">
		</div>&nbsp&nbsp走道及禁位
	</div>

	<div id="d1" style="width:800px;">
		<div id="d2">
			螢幕位置
		</div>

	</div>
	<input type="submit" id="submit" value="送出">
</body>
<script>
	let id = 0;
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
</html>