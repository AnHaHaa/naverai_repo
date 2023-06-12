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
</head>
<body>
<h3>${faceresult2}</h3>

<% 
String faceresult2 = (String)request.getAttribute("faceresult2");
JSONObject total = new JSONObject(faceresult2);
JSONObject info = (JSONObject)total.get("info");
int faceCount = (Integer)info.get("faceCount");

JSONArray faces = (JSONArray)total.get("faces");

//성별 나이 감정 방향
for(int i=0; i<faces.length(); i++){
	JSONObject oneperson = (JSONObject)faces.get(i);
	//성별
	String gender = oneperson.getJSONObject("gender").getString("value");
	BigDecimal confidence = (BigDecimal)oneperson.getJSONObject("gender").get("confidence");
	double gender_confi = confidence.doubleValue();
	
	//나이
	String age = oneperson.getJSONObject("age").getString("value");

	//감정
	String emotion = oneperson.getJSONObject("emotion").getString("value");
	
	//얼굴방향
	String pose = oneperson.getJSONObject("pose").getString("value");
	
	out.println("<h3>"+(i+1)+"번째 얼굴의 성별 ="+gender+", 정확도 = "+gender_confi+"</h3>");
	out.println("<h3>"+(i+1)+"번째 얼굴의 나이 ="+age+"</h3>");
	out.println("<h3>"+(i+1)+"번째 얼굴의 감정 ="+emotion+"</h3>");
	out.println("<h3>"+(i+1)+"번째 얼굴의 얼굴방향 ="+pose+"</h3>");
	
	//랜드마크
	if(!oneperson.get("landmark").equals(null)){
		JSONObject landmark = (JSONObject)oneperson.get("landmark");
		JSONObject nose = landmark.getJSONObject("nose");
		out.println("<h3>코의 x좌표 :"+nose.get("x")+"</h3>");
		out.println("<h3>코의 y좌표 :"+nose.get("y")+"</h3>");
	}else{
		out.println("<h3>눈코입을 파악할 수 없습니다.</h3>");
	}
	out.println("<hr>");
	
}


%>

<h3> 총 <%=faceCount%> 명의 얼굴을 찾았습니다.</h3>


</body>
</html>