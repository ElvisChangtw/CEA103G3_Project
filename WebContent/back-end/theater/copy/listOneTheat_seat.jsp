<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta name="viewport" content="width=	, initial-scale=1.0">
	<title>Document</title>
	<style>
		body{
		}
		
		h2{
			text-align: center;
		}
		label {
			padding: 0;
			margin: 2px 2px 0px 0px;
			cursor: pointer;
		}
		input[type=checkbox] {
			display: none;
			background-color: lightgreen;
		}
		span{
			font-size: 8px;
			font-family: Arial;
			text-align: center;
			line-height: 25px;
		}

		input[type=checkbox]+span {
			display: inline-block;
			vertical-align:middle;
			background-color: lightgreen;
			border: 1px solid; /* gray; */
			color: #444;
			user-select: none; /* 防止文字被滑鼠選取反白 */
			width: 25px;
			height: 25px;		
			margin: 2px 2px;
		}
/* 		input[type=checkbox]:checked+span { */
/* 			background-color: #ADD8E6; */
/* 		} */
		#d1{
			font-size: 27px;
		}
		#d2{
			border: 1px solid black;
			width: 660px;
			height: 30px;
			text-align: center;
			background: orange;
			font-size: 20px;
			line-height: 30px;
		}

</style>
</head>
<body>
	<div id="d1" style="width:800px;">
		<div id="d2">
			螢幕位置
		</div>
	</div>
</body>
<script>

	for(let i = 1; i <= 20; i++){
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
			seat.disabled = true;
			seat.classList.add(word1);

			let seat_name = document.createElement("span");
			seat_name.innerText = string;

			label.appendChild(seat);
			label.appendChild(seat_name);
			if(j % 20 === 0 ){
				label.appendChild(document.createElement("br"));
			}
			document.getElementById("d1").appendChild(label);
		}
	}

</script>
</html>