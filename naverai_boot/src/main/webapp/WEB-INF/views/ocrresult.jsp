<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function(){
	var json = JSON.parse('${ocrresult}');
	//$("#output").html(JSON.stringify(json)); //json -> string
	
	//캔버스에 좌표 그리기
	let mycanvas = document.getElementById("ocrcanvas");
	let mycontext = mycanvas.getContext("2d");
	
	let myimage = new Image();
	myimage.src = "/naverimages/${param.image}";
	myimage.onload = function(){
		mycanvas.width = myimage.width;
		mycanvas.height = myimage.height;
		mycontext.drawImage(myimage,0,0,myimage.width,myimage.height);
		
		//글씨 박스화
		let fieldslist = json.images[0].fields;
		for(let i in fieldslist){
			if(fieldslist[i].lineBreak == true){
				$("#output2").append(fieldslist[i].inferText+"<br>");
			}else{
				$("#output2").append(fieldslist[i].inferText+"&nbsp;");
			}
			
			let x = fieldslist[i].boundingPoly.vertices[0].x //단어시작점 x좌표
			let y = fieldslist[i].boundingPoly.vertices[0].y //단어시작점 y좌표
			let width = fieldslist[i].boundingPoly.vertices[2].x - x;
			let height = fieldslist[i].boundingPoly.vertices[2].y - y;
			
			mycontext.strokeStyle="blue";
			mycontext.lineWidth=2;
			mycontext.strokeRect(x,y,width,height);
		}
		
		
		
	}//faceimage onload
	
});
</script>
</head>
<body>
<%-- <h3>${ocrresult}</h3>  --%>
<div id="output" style="border:2px solid orange"></div>
<div id="output2" style="border:2px solid lime"></div>
<canvas id="ocrcanvas" style="border:2px solid aqua" width="500" height="500"></canvas>

</body>
</html>