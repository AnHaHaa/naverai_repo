package mymapping;

import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.ai.MyNaverInform;
import com.example.ai.NaverService;

@Controller
public class MapController {
	@Autowired
	@Qualifier("myservice")
	NaverService service;
	@Autowired
	@Qualifier("ttsservice")
	NaverService service_tts;
	
	@GetMapping("/myinput")
	public String myinput() {
		return "mymapping/input";
	}
	
//	@GetMapping("/myoutput")
//	public ModelAndView myoutput(String input) throws IOException {
//		//결과 txt 받기
//		String outputText = service.test(input);
//		
//		//txt파일 생성하기
//		//추가 MyInform.path경로 mp3파일이름 + 20230609_112000.txt 파일로 저장
//		String now_string =  new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
//		
////		String filename = "input__"+now_string+".txt";
////		FileWriter fw = new FileWriter(MyNaverInform.path + filename, false);
////		fw.write(outputText);
//		
//		//답변 파일 1개만 만들기 - 답변마다 리셋
//		FileWriter fw = new FileWriter(MyNaverInform.path + "input__response.txt");
//		fw.write(outputText);
//		fw.close();
//		
//		//TTS서비스 호출 및 mp3파일 리턴받기
//		String mp3file = service_tts.test("input__response.txt");
//		
//		//모델 생성 및 등록
//		ModelAndView mv = new ModelAndView();
//		mv.addObject("outputText", outputText);
//		mv.addObject("mp3file", mp3file);
//		mv.setViewName("mymapping/output");
//		return mv;
//	}
	
	//ajax 풀이
	@GetMapping("/myoutput")
	@ResponseBody
	public HashMap<String, String> myoutput(String input) throws IOException {
		//결과 txt 받기
		String outputText = service.test(input);
		
		//txt파일 생성하기 - 답변 파일 1개만 만들기 - 답변마다 해당 파일 리셋
		FileWriter fw = new FileWriter(MyNaverInform.path + "input__response.txt");
		fw.write(outputText);
		fw.close();
		
		//TTS서비스 호출 및 mp3파일 리턴받기
		String mp3file = service_tts.test("input__response.txt");
		
		//모델 생성 및 등록
		HashMap<String, String> map = new HashMap<>();
		map.put("output", outputText);
		map.put("mp3", mp3file);
		
		return map;
	}

}
