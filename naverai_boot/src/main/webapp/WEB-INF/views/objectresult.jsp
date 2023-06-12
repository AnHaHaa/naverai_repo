<%@page import="java.math.BigDecimal"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
</head>
<body>
<h3>${objectresult}</h3>

<script>
$(document).ready(function(){
	var json = JSON.parse('${objectresult}');
	$("#count").html("<h3>"+json.predictions[0].num_detections+"개의 사물 탐지</h3>");
	for(var i=0; i<json.predictions[0].num_detections; i++){
		$("#names").append(json.predictions[0].detection_names[i]+" - " + (json.predictions[0].detection_scores[i]*100)+"% <br>");
		
		//좌표 출력
		/* 
		var x1 = json.predictions[0].detection_boxes[i][0];
		var y1 = json.predictions[0].detection_boxes[i][1];
		var x2 = json.predictions[0].detection_boxes[i][2];
		var y2 = json.predictions[0].detection_boxes[i][3];
		$("#boxes").append(	i+"번째 사물 좌표 : "+x1 + " , "+ y1 + " : "+ x2 + " , "+ y2 + "<br>" );
		 */
	}//for
	
	//캔버스에 좌표 그리기
	let mycanvas = document.getElementById("objectcanvas");
	let mycontext = mycanvas.getContext("2d");
	
	let faceimage = new Image();
	faceimage.src = "/naverimages/${param.image}";
	faceimage.onload = function(){
		mycontext.drawImage(faceimage,0,0,faceimage.width,faceimage.height);
		
		var boxes = json.predictions[0].detection_boxes;

		//색상별로 다르게 출력하기
		let colors = ["red","orange","yellow","lime","green","aqua","blue","navy","purple","pink"];
		
		for(var i=0; i<boxes.length; i++){
			/* var x1 = boxes[i][0]*faceimage.width;
			var y1 = boxes[i][1]*faceimage.height;
			var x2 = boxes[i][2]*faceimage.width;
			var y2 = boxes[i][3]*faceimage.height; */
			
			var y1 = boxes[i][0]*faceimage.height;
			var x1 = boxes[i][1]*faceimage.width;
			var y2 = boxes[i][2]*faceimage.height;
			var x2 = boxes[i][3]*faceimage.width;
			
			//박스그리기
			mycontext.lineWidth = 2;
			mycontext.strokeStyle = colors[i%colors.length];
			mycontext.strokeRect(x1,y1,(x2-x1),(y2-y1)); //객체위치인식
			
			//텍스트 쓰기 ("내용",x좌표,y좌표)
			mycontext.fillStyle=colors[i%colors.length];
			mycontext.font="normal bold 15px normal";
			mycontext.fillText(json.predictions[0].detection_names[i],x1,y1);
		}//for
		
	}//faceimage onload
})//ready
</script>

<div id="count" style="border:2px solid aqua"></div>
<div id="names" style="border:2px solid lime"></div>
<div id="boxes" style="border:2px solid yellow"></div>
<canvas id="objectcanvas" width="800" height="800" style="border:2px solid pink"></canvas>

</body>
</html>