<%@page import="com.lec.amigo.vo.ChatRoom"%>
<%@page import="com.lec.amigo.vo.ChatVO"%>
<%@page import="com.lec.amigo.vo.UserVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/amigo/resources/css/style.css" />
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
 </head>
 <body> 
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
	
	var url = "ws://localhost:80/amigo/chatHandler.do";
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
  
    <!-- Footer -->
    <footer class="bg-primary text-center text-white mt-5">
      <!-- Copyright -->
      <div class="text-center p-3 mt-5" style="background-color:rgb(87, 160, 227);">
        © 2022 Copyright:
        <a class="text-white" href="#">amigo.com</a>
      </div>
      <!-- Copyright -->
    </footer>
    <!-- Footer 끝 -->


</body>
</html>
	
	

