<%@page import="com.lec.amigo.vo.ChatRoom"%>
<%@page import="com.lec.amigo.vo.ChatVO"%>
<%@page import="com.lec.amigo.vo.UserVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
    <style>
  	.notification-container {
	  background: rgba(0,0,0,.3);
	  border-radius: 10px 10px 0 0 ;
	  padding: 15px 20px;
	  position: fixed;
	  bottom: -150px;
	  right:0px;
	  transition: transform 0.3s ease-in-out;
	}
	.notification-container.showChatMessage{
	  transform: translateY(-150px);
	}
  </style>
  <script>
	const showNotification = (user, txt, roomIndex) =>{
		console.log(user);
		$('#notification_text').html('<span style="color:red;">new</span>'+user+' '+txt);
		
		let temp = '/amigo/chatList.do?index='+roomIndex;
		$('#notification_text').attr("href", temp);
		$('#notification-container').addClass('showChatMessage');
		
		//<a href="/amigo/
		setTimeout(()=>{
			$('#notification-container').removeClass('showChatMessage');
		},5000)
	}
</script>

<script>
<% if(session.getAttribute("user")!=null){
	
	List<ChatRoom> room_list = (List)session.getAttribute("chat_room_list");
	if(room_list!=null){
	%>
	
	var url = "ws://localhost:8088/amigo/chatHandler.do";
	var ws = new WebSocket(url);
	
	ws.onopen = function(){
	ws.onmessage = function(evt){
		
		let msg = evt.data;
		var jd = JSON.parse(msg);
		
		let no;
		let user;
		let txt;
		let roomIndex;
		let chat_no;
		let index;
		
		if(jd.no=='2'){
			no = jd.no;
			user = jd.userName;
			type= jd.type;
			roomIndex = jd.roomIndex;			
			chat_no = jd.chatNo;
			msg = jd.msg;
			
			<% for(ChatRoom room:room_list){
			%>
				index = '<%=room.getChat_index()%>';
				if(parseInt(roomIndex)==index){
					if(msg!=null){
						showNotification(user, msg, roomIndex);
					}else{
						showNotification(user, "이미지가 도착했습니다!", roomIndex);
					}
			
					
				}
				<%
				}%>

			
		}
	}
	}
		
	<%
	}
}%>
</script>
 
  <div class="notification-container" id="notification-container">
    <a ref="" id="notification_text" style="color: white;"></a>
  </div>


	
	

