package chatbot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChatbotController {
	@Autowired
	@Qualifier("chatbotservice")
	ChatbotServiceImpl service;
	
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
}
