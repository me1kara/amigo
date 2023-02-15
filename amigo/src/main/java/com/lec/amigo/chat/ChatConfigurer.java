package com.lec.amigo.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.standard.ServletServerContainerFactoryBean;

@Configuration
@EnableWebSocket
public class ChatConfigurer implements WebSocketConfigurer{
	
	@Autowired
	ChatHandler socketHandler;
	
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		
	}
	
	@Bean
	public ServletServerContainerFactoryBean createWebSocketContainer() {
	ServletServerContainerFactoryBean container = new ServletServerContainerFactoryBean();
	container.setMaxTextMessageBufferSize(500000);
	container.setMaxBinaryMessageBufferSize(500000000);
	return container;
	}	

}
