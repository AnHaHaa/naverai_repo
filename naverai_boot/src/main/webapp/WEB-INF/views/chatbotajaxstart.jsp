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
	$("input:button").on('click',function(){
		$('#response').append("질문 : "+$('#request').val()+"<br>");
		$.ajax({
			url : "chatbotajaxprocess",
			data : {"request":$('#request').val(), "event" : $(this).val()},
			type : 'get',
			dataType : 'JSON',
			success : function(server){
				$('#response').append("답변 : "+server.bubbles[0].data.description+"<br>");
			},
			error : function(e){console.log(e);}
		})//ajax end
	});//onclick
});
</script>
</head>
<body>
질문 : <input type="text" id='request'>
<input type="button" value="답변보기" id="event1">
<input type="button" value="웰컴메세지" id="event2">
<br>
대화내용
<div id='response' style='border:2px solid aqua;'></div>
</body>
</html>