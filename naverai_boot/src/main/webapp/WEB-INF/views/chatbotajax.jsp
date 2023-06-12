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
				let bubbles = server.bubbles;
				for(let b in bubbles){
					//1.기본답변일때
					if(bubbles[b].type=="text"){
						$('#response').append("답변 : "+bubbles[b].data.description+"<br>");
						if(bubbles[b].data.url != null){
							$('#response').append("답변 : <a href='"+bubbles[b].data.url+"'>"+bubbles[b].data.description+"</a>"+"<br>");
						}
					}
					
					else if(bubbles[b].type=="template"){
						//2.이미지답변일때
						if(bubbles[b].data.cover.type=="image"){
							$('#response').append("<img src='"+bubbles[b].data.cover.data.imageUrl+"' width=200 height=200>"+"<br>");
							for(let c in bubbles[b].data.contentTable){
								for(let d in bubbles[b].data.contentTable[c]){
									let link = bubbles[b].data.contentTable[c][d].data.title;
									let href = bubbles[b].data.contentTable[c][d].data.data.action.data.url;
									$('#response').append("답변 : <a href='"+href+"'>"+link+"</a>"+"<br>");
								}//for d
							}//for c
						}
						//3.멀티링크답변일때
						else if(bubbles[b].data.cover.type=="text"){
							$('#response').append("멀티링크답변 : "+bubbles[b].data.cover.data.description+"<br>");
							
							for(let c in bubbles[b].data.contentTable){
								for(let d in bubbles[b].data.contentTable[c]){
									let link = bubbles[b].data.contentTable[c][d].data.title;
									let href = bubbles[b].data.contentTable[c][d].data.data.action.data.url;
									$('#response').append("답변 : <a href='"+href+"'>"+link+"</a>"+"<br>");
								}//for d
							}//for c
						}//else if
					}
				}//for bubbles end
				
			},//success
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