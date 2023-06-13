package chatbot;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper //@MapperScan 필요
@Repository //@ComponentScan 필요
public interface PizzaMapper {
	int insertPizza(PizzaDTO dto);
}
