package mymapping;

import java.util.HashMap;

import org.springframework.stereotype.Service;

import com.example.ai.NaverService;

@Service("myservice")
public class MapServiceImpl implements NaverService {
	HashMap<String, String> resultmap = new HashMap<>();

	public MapServiceImpl() {
		resultmap.put("이름이 뭐니?", "클로버야");
		resultmap.put("무슨 일을 하니?", "ai 서비스 관련 일을 해");
		resultmap.put("멋진 일을 하는구나", "고마워");
		resultmap.put("난 훌륭한 개발자가 될거야", "넌 할 수 있어");
		resultmap.put("잘 자", "내꿈꿔");
	}

	@Override
	public String test(String input) {
		if(resultmap.get(input)!=null) {
			return resultmap.get(input);
		}else {
			return "답변할 수 없는 질문입니다.";
		}
	}

}
