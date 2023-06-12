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
</head>
<body>
<form action="chatbotresponse">
질문 : <input type="text" name=request>
<input type="submit" value="답변보기" name="event">
<input type="submit" value="웰컴메세지" name="event">
</form>
</body>
</html>