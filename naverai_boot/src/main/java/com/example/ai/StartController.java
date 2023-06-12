package com.example.ai;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class StartController {
	
	@GetMapping("/")
	public String start() {
		return "start";
	}
}
