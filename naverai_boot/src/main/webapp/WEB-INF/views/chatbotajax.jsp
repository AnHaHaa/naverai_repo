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
	$('#request').focus();
	
	const request= document.getElementById("request");
	request.addEventListener("keydown", function(event) {
	 if (event.keyCode === 13) {
	   event.preventDefault(); 
	   $("#event1").click(); 
	 }
	});//keydown
	
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
						
						$.ajax({
							url : '/chatbottts',
							data : {"text":bubbles[b].data.description},
							type : 'get',
							dataType : 'json',
							success : function(server){
								//alert(server.mp3); //chatbot_tts_answer.mp3
								$("#tts").attr('src',"/naverimages/"+server.mp3);
								$("#tts")[0].play();
							},
							error : function(e){alert(e);}
						});
						
						/////////////////////////////////////////////////////////////////////////////
						//피자주문인경우
						var order_reply = bubbles[b].data.description;
						if(order_reply.indexOf("주문하셨습니다")>=0){
							var split_result = order_reply.split(" ");
							var kind = split_result[0];
							var size = split_result[1];
							var phone = split_result[3]; //01012341234으로
							phone = phone.substring(0,phone.indexOf("으로"));
							
							var kinds = ["콤비네이션피자","소세지크림치즈피자","파인애플피자"];
							var prices = [10000,15000,12000];
							//소=기본 중=기본+2000 대=기본+5000 특대=기본+10000
							
							var price = 0;
							for(let i=0; i<kinds.length; i++){
								if(kind == kinds[i]){
									price += prices[i];
									break;
								}
							}
							
							if(size == "특대"){
								price += 10000;
							}else if(size == "대"){
								price += 5000;
							}else if(size == "중"){
								price += 2000;
							}
							$('#response').append("총 지불 가격은 "+price+"원 입니다. ");
							
							$.ajax({
								url : "pizzaorder",
								data : {
									"kind" : kind,
									"size" : size,
									"phone" : phone,
									"price" : price
								},
								type : "get",
								success : function(server){
									$('#response').append(server+"건의 주문을 등록완료하였습니다.");
								},
								error : function(e){alert(e);}
							}); //ajax
						}
						
						
						
						/////////////////////////////////////////////////////////////////////////////
						
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
							
							$.ajax({
								url : '/chatbottts',
								data : {"text":bubbles[b].data.cover.data.description},
								type : 'get',
								dataType : 'json',
								success : function(server){
									//alert(server.mp3); //chatbot_tts_answer.mp3
									$("#tts").attr('src',"/naverimages/"+server.mp3);
									$("#tts")[0].play();
								},
								error : function(e){alert(e);}
							});
							
						}//else if
					}
				}//for bubbles end
				
			},//success
			error : function(e){console.log(e);}
		})//ajax end
		
		$('#request').val("");
		$('#request').focus();
	});//onclick
});
</script>
</head>
<body>
질문 : <input type="text" id='request'>
<input type="button" value="답변보기" id="event1">
<input type="button" value="웰컴메세지" id="event2">
<button id='record'>음성질문 녹음시작</button>
<button id='stop'>음성질문 녹음종료</button>
<div id='sound'></div>

음성 답변
<audio id='tts' src="" controls="controls"></audio>
<br>
대화내용
<div id='response' style='border:2px solid aqua;'></div>

<script>
let record = document.getElementById("record");
let stop = document.getElementById("stop");
let sound = document.getElementById("sound");

//브라우저 녹음기나 카메라 사용 지원여부
if(navigator.mediaDevices){
	console.log("지원 가능");
	var constraint = {"audio":true};
}
//녹음 진행하는 동안 blob 객체 생성 - 녹음 종료시 mp3파일 생성
let chunks = [];
navigator.mediaDevices.getUserMedia(constraint).then(function(stream){
	var mediaRecorder = new MediaRecorder(stream);
	record.onclick = function(){
		mediaRecorder.start();
		record.style.backgroundColor = "blue";
		record.style.color = "red";
	}
	stop.onclick = function(){
		mediaRecorder.stop();
		record.style.backgroundColor = "";
		record.style.color = "";
		
	}
	
	//녹음 시작 상태면 chunks에 녹음 데이터 저장
	mediaRecorder.ondataavailable = function(d){
		chunks.push(d.data);
	}
	
	//녹음 정지 상태이면 mp3만들어라
	mediaRecorder.onstop = function(){
		//audio태그 추가
		var audio = document.createElement("audio");
		audio.setAttribute("controls","");
		audio.controls = true;
		
		sound.replaceChildren(audio);
		//sound.appendChild(audio);
		
		//녹음 데이터 가져와서 blob->mp3->audio 태그 재생
		var blob = new Blob(chunks, {"type":"audio/mp3"});
		var mp3url = URL.createObjectURL(blob);
		audio.src = mp3url;
		
		//다음 녹음 위해 chunks초기화
		chunks = [];
		
		var formData = new FormData();
		formData.append("file1", blob ,"a.mp3"); //blob데이터를 서버로 보내는데 a.mp3 이름으로 보내겠다.
		//<input type=file name=file1>
		$.ajax({
			url : "/mp3upload",
			data : formData,
			type : "post",
			processData : false,
			contentType	: false,
			success : function(server){
				$.ajax({
					url: "/chatbotstt",
					data: {"mp3file":"a.mp3"},
					type:'get',
					dataType:'json',
					success:function(server){
						$('#request').val(server.text);
						$('#event1').click();
					},
					error:function(){
						
					}
				}); //ajax
			},
			error : function(){
				
			}
		}); //ajax
		
	}
	
}) // then end
.catch(function(err){
	console.log("오류발생 : "+err);
});
</script>
</body>
</html>