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
	$('#btn').on('click',function(){
		$.ajax({
			url : "/myoutput",
			data : {"input" : $('#input').val() },
			type : 'get',
			dataType : "json",
			success : function(res){
				$('#output').html(res.output);
				$('#mp3').attr("src","/naverimages/"+res.mp3);
				$('#mp3')[0].play();
			},
			error : function(e){
				alert(e);
			}
		});//ajaxend
	});//on end
});//ready end
</script>
<style>
@import url("https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css");
* {font-family: 'NanumSquareNeoBold';}
</style>
</head>
<body>
<h2>질문을 입력해주세요</h2>
<!-- <form action="myoutput">
<input type="text" name="input" style="height: 30px; width: 300px;">
<input type="submit" value="대화하기" style="height: 37px;">
</form> -->

<input id='input' type="text" name="input" style="height: 30px; width: 300px;">
<input id='btn' type="button" value="대화하기" style="height: 37px;">

<h2>답변 : <span id='output'></span></h2>
<audio id="mp3" src="" controls></audio>

</body>
</html>