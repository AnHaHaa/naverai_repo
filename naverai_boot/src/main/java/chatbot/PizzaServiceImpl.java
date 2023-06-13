package chatbot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("pizzaservice")
public class PizzaServiceImpl {
	@Autowired
	PizzaMapper mapper;
	
	public int insertPizza(PizzaDTO dto) {
		return mapper.insertPizza(dto);
	}
}
