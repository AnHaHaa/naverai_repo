package objectdetection;

import java.io.File;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.ai.MyNaverInform;
import com.example.ai.NaverService;

@Controller
public class ObjectDetectionController {
	@Autowired
	@Qualifier("objectDetectionService")
	NaverService service;
	
	@RequestMapping("/objectinput")
	public ModelAndView objectinput() {
		File f = new File(MyNaverInform.path);
		String[] filelist = f.list();

		String file_ext[] = { "jpg", "gif", "png", "jfif" };
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
		mv.setViewName("objectinput");
		return mv;
	}
	
	@RequestMapping("/objectresult")
	public ModelAndView objectresult(String image) {
		// 서비스클래스 요청 - https://naveropenapi.apigw.ntruss.com/vision/v1/celebrity -json
		String objectresult = service.test(image);
		ModelAndView mv = new ModelAndView();
		mv.addObject("objectresult", objectresult); // "{a:100}"
		mv.setViewName("objectresult");
		return mv;
	}
	
}
