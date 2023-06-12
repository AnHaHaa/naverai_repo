package cfr;

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
public class FaceController {
	@Autowired
	@Qualifier("faceservice1")
	NaverService service;
	@Autowired
	@Qualifier("faceservice2")
	NaverService service2;

	// ai_images 파일리스트에서 이미지파일만 걸러서 목록에 나오도록
	@RequestMapping("/faceinput")
	public ModelAndView faceinput() {
		File f = new File(MyNaverInform.path);
		String[] filelist = f.list();

		String file_ext[] = { "jpg", "gif", "png", "jfif" };
		// file_ext배열에 존재하는 확장자만 모델에 포함

		ArrayList<String> newfilelist = new ArrayList();
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
		mv.setViewName("faceinput");
		return mv;
	}

	@RequestMapping("/faceresult")
	public ModelAndView faceresult(String image) {
		// 서비스클래스 요청 - https://naveropenapi.apigw.ntruss.com/vision/v1/celebrity -json
		String faceresult = service.test(image);
		ModelAndView mv = new ModelAndView();
		mv.addObject("faceresult", faceresult); // "{a:100}"
		mv.setViewName("faceresult");
		return mv;
	}

	//안면인식 서비스 파일리스트
	@RequestMapping("/faceinput2")
	public ModelAndView faceinput2() {
		File f = new File(MyNaverInform.path);
		String[] filelist = f.list();

		String file_ext[] = { "jpg", "gif", "png", "jfif" };
		// file_ext배열에 존재하는 확장자만 모델에 포함

		ArrayList<String> newfilelist = new ArrayList();
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
		mv.setViewName("faceinput2");
		return mv;
	}
	
	
	@RequestMapping("/faceresult2")
	public ModelAndView faceresult2(String image) {
		// 서비스클래스 요청 - https://naveropenapi.apigw.ntruss.com/vision/v1/face -json
		String faceresult2 = service2.test(image);
		ModelAndView mv = new ModelAndView();
		mv.addObject("faceresult2", faceresult2); // "{a:100}"
//		mv.setViewName("faceresult2");//텍스트뷰
		mv.setViewName("faceresult3"); //이미지뷰
		return mv;
	}

}
