package com.example.ai;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan //현재 패키지 대상
@ComponentScan(basePackages = {"cfr","pose","stt_csr","tts_voice","mymapping","ocr","chatbot"})
@ComponentScan(basePackages = "objectdetection")
@MapperScan(basePackages = {"chatbot"})
public class NaveraiBootApplication {

	public static void main(String[] args) {
		SpringApplication.run(NaveraiBootApplication.class, args);
	}

}
