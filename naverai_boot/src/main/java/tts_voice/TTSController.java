package tts_voice;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.ai.MyNaverInform;
import com.example.ai.NaverService;

@Controller
public class TTSController {
	@Autowired
	@Qualifier("ttsservice")
	NaverService service;

	// ai_images 파일리스트에서 음성파일만 걸러서 목록에 나오도록
	@RequestMapping("/ttsinput")
	public ModelAndView ttsinput() {
		File f = new File(MyNaverInform.path);
		String[] filelist = f.list();

		String file_ext[] = {"txt"};
		// file_ext배열에 존재하는 확장자만 모델에 포함

		ArrayList<String> newfilelist = new ArrayList<String>();
		for (String onefile : filelist) {
			// bangtan.1.2.jpg 파일 이름이 이런식이라면 마지막 점을 찾아야함. 마지막 점이 있는 위치 : lastIndexOf(".")
			String myext = onefile.substring(onefile.lastIndexOf(".") + 1); // 마지막점의 위치+1에서부터 끝까지 출력 -> 결과 : jpg
			for (String imgext : file_ext) {
				if (myext.equals(imgext)) { // 위에서 뽑아낸 확장자가 file_ext배열에 있는 애랑 같은지 비교
					newfilelist.add(onefile); // 같으면 newfilelist에 추가
					break; // 같은거 찾았으면 다른 확장자들과 비교할 필요 없으니까 반복문 멈추기.
				}
			}
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("filelist", newfilelist);
		mv.setViewName("ttsinput");
		return mv;
	}

	@RequestMapping("/ttsresult")
	public ModelAndView sttresult(String text,String speaker) throws IOException {
		String ttsresult = null;
		if(speaker==null) {
			ttsresult = service.test(text);
		}else {
			ttsresult = ((TTSServiceImpl)service).test(text,speaker);
		}
		ModelAndView mv = new ModelAndView();
		mv.addObject("ttsresult", ttsresult); // mp3파일
		mv.setViewName("ttsresult");
		return mv;
	}

}
