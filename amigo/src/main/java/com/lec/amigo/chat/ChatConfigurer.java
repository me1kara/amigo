package com.lec.amigo.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.standard.ServletServerContainerFactoryBean;

//웹소켓핸들러의 설정에 관한 클래스
@Configuration
@EnableWebSocket
@PropertySource("classpath:config/chat/chat.properties")
public class ChatConfigurer implements WebSocketConfigurer {
    
    
    private final int MAX_TEXT_BUFFER_SIZE;
    private final int MAX_BINARY_BUFFER_SIZE;
    
    private ChatHandler socketHandler;
    
    public ChatConfigurer(@Value("${CHAT_MAX_TEXT_BUFFER_SIZE}") int maxTextBufferSize,
                          @Value("${CHAT_MAX_BINARY_BUFFER_SIZE}") int maxBinaryBufferSize,
                          ChatHandler socketHandler) {
        this.MAX_TEXT_BUFFER_SIZE = maxTextBufferSize;
        this.MAX_BINARY_BUFFER_SIZE = maxBinaryBufferSize;
        this.socketHandler = socketHandler;
    } 
	

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		
	}
	
	@Bean
	public ServletServerContainerFactoryBean createWebSocketContainer() {
		ServletServerContainerFactoryBean container = new ServletServerContainerFactoryBean();
		container.setMaxTextMessageBufferSize(MAX_TEXT_BUFFER_SIZE);
		container.setMaxBinaryMessageBufferSize(MAX_BINARY_BUFFER_SIZE); //이미지파일 사이즈제한
	return container;
	}	

}
