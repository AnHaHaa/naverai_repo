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
	var json = JSON.parse('${poseresult}');
	var people = json.predictions;
	
	//캔버스에 좌표 그리기
	//$('#posecanvas').get(0) 을 해야 getContext 메소드를 사용가능. jquery객체는 배열로 처리하기 때문.
	//$('#posecanvas').get(0).getContext("2d") 이렇게 써야 사용 가능
	let mycanvas = document.getElementById("posecanvas");
	let mycontext = mycanvas.getContext("2d");
	
	let myimage = new Image();
	myimage.src = "/naverimages/${param.image}";
	myimage.onload = function(){
		mycanvas.width = myimage.width;
		mycanvas.height = myimage.height;
		mycontext.drawImage(myimage,0,0,myimage.width,myimage.height);
		
		var bodyinform = ["코", "목", "오어깨", "오팔꿈치", "오손목", "왼어깨", "왼팔꿈치", "왼손목", "오엉덩이", "오무릎", "오발목", "왼엉덩이", "왼무릎", "왼발목", "오눈", "왼눈", "오귀", "왼귀"];
		
		//색상별로 다르게 출력하기
		let colors = ["red","orange","yellow","lime","green","aqua","blue","navy","purple","pink"];
		
		for(var j=0; j<json.predictions.length; j++){
			for(var i=0; i<bodyinform.length; i++){
				if(json.predictions[j][i]!=null) {
				//신체 정보 좌표
				var x = json.predictions[j][i].x * myimage.width;
				var y = json.predictions[j][i].y * myimage.height;
	
				//텍스트 쓰기 ("내용",x좌표,y좌표)
				//텍스트 색상 변경하기
				mycontext.fillStyle=colors[i%colors.length];
				mycontext.font="normal bold 12px normal";
				mycontext.fillText(bodyinform[i],x,y);
				
				mycontext.beginPath();
				mycontext.arc(x, y, 4, 0, 2*Math.PI);
				mycontext.fillStyle = colors[i%colors.length]; 
				mycontext.fill(); 
				}
			}//end for i
		}//end for j
		
	}//faceimage onload
	
});
</script>
</head>
<body>
<%-- <h3>${poseresult}</h3> 
<div id="output" style="border:2px solid orange"></div>--%>
<canvas id="posecanvas" style="border:2px solid orange" width="500" height="500"></canvas>

</body>
</html>