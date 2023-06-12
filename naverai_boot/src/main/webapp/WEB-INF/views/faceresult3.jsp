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
<script>
window.onload = function(){
	let mycanvas = document.getElementById("facecanvas");
	let mycontext = mycanvas.getContext("2d");
	
	let faceimage = new Image();
	faceimage.src = "/naverimages/${param.image}";
	faceimage.onload = function(){
		mycontext.drawImage(faceimage,0,0,faceimage.width,faceimage.height);
		<% 
		String faceresult2 = (String)request.getAttribute("faceresult2");
		JSONObject total = new JSONObject(faceresult2);
		JSONArray faces = (JSONArray)total.get("faces");
		
		//성별 나이 감정 방향
		for(int i=0; i<faces.length(); i++){
			JSONObject oneperson = (JSONObject)faces.get(i);
			JSONObject roi = oneperson.getJSONObject("roi");
			int x = roi.getInt("x");
			int y = roi.getInt("y");
			int width = roi.getInt("width");
			int height = roi.getInt("height");
		%>
		mycontext.lineWidth = 3;
		mycontext.strokeStyle = "pink";
		mycontext.strokeRect(<%=x%>,<%=y%>,<%=width%>,<%=height%>); //얼굴위치인식
		
		//일부이미지만 복사
		var copyimage = mycontext.getImageData(<%=x%>,<%=y%>,<%=width%>,<%=height%>);
		mycontext.putImageData(copyimage, <%=x%>, <%=y+300%>);

		mycontext.fillStyle = "orange";
		mycontext.fillRect(<%=x%>,<%=y%>,<%=width%>,<%=height%>); //모자이크처리
		
		<%
		}//for
		%>
	}//faceimage onload
	
}//onload

</script>
</head>
<body>
<canvas id="facecanvas" width="800" height="800" style="border:2px solid pink"></canvas>


</body>
</html>