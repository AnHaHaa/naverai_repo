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
});
</script>
<style>
@import url("https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css");
* {font-family: 'NanumSquareNeoBold';} 
</style>
</head>
<body>
<h2>답변 : ${outputText}</h2>
<audio id="mp3" src="/naverimages/${mp3file}" controls="controls"></audio>
</body>
</html>