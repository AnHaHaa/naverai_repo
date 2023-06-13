package chatbot;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.ai.MyNaverInform;

@Controller
public class ChatbotController {
	@Autowired
	@Qualifier("chatbotservice")
	ChatbotServiceImpl service;
	
	@Autowired
	@Qualifier("chatbotttsservice")
	ChatbotTTSServiceImpl ttsservice;
	
	@Autowired
	@Qualifier("chatbotsttservice")
	ChatbotSTTServiceImpl sttservice;
	
	@Autowired
	@Qualifier("pizzaservice")
	PizzaServiceImpl pizzaservice;
	
	
	@GetMapping("/chatbotrequest")
	public String chatbotrequest() {
		return "chatbotrequest";
	}
	
	@GetMapping("/chatbotresponse")
	public ModelAndView chatbotresponse(String request, String event) {
		String response = "";
		if(event.equals("웰컴메세지")) {
			response = service.test(request,"open");
		}else {
			response = service.test(request, "send");
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("response", response);
		mv.setViewName("chatbotresponse");
		return mv;
	}
	
	//기본답변만 분석한 뷰
	@GetMapping("/chatbotajaxstart")
	public String chatbotajaxstart() {
		return "chatbotajaxstart";
	}

	//기본+이미지+멀티링크 답변 분석한 뷰
	@GetMapping("/chatbotajax")
	public String chatbotajax() {
		return "chatbotajax";
	}
	
	@GetMapping("/chatbotajaxprocess")
	public @ResponseBody String chatbotajaxprocess(String request, String event) {
		System.out.println(request+" | "+event);
		String response = "";
		if(event.equals("웰컴메세지")) {
			response = service.test(request,"open");
		}else {
			response = service.test(request, "send");
		}
		return response;
	}
	
	@GetMapping("/chatbottts")
	public @ResponseBody String chatbottts(String text) {
		String mp3 = ttsservice.test(text); //답변텍스트를 해당경로 저장, mp3파일이름 리턴
		return "{\"mp3\" : \""+mp3+"\"}";
	}
	
	//음성 질문 서버 업로드
	@PostMapping("/mp3upload")
	public @ResponseBody String mp3upload(MultipartFile file1) throws IllegalStateException, IOException {
		String uploadFile = file1.getOriginalFilename(); //a.mp3
		String uploadPath = MyNaverInform.path;
		File saveFile = new File(uploadPath+uploadFile);
		file1.transferTo(saveFile);
		return "{\"result\":\"잘 받았습니다.\"}";
	}

	//업로드한 음성질문 mp3파일을 텍스트파일 변환
	@GetMapping("/chatbotstt")
	public @ResponseBody String chatbotstt(String mp3file){
		String text = sttservice.test(mp3file, "Kor");
		return text;
	}
	
	@GetMapping("/pizzaorder")
	public @ResponseBody int pizzaorder(PizzaDTO dto){
		return pizzaservice.insertPizza(dto);
	}
	
	
}
