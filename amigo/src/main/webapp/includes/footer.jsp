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
	  position: absolute;
	  bottom: -100px;
	  right:0px;
	  transition: transform 0.3s ease-in-out;
	}
	.notification-container.showChatMessage{
	  transform: translateY(-100px);
	}
  </style>
  <div class="notification-container" id="notification-container">
    <a ref="" id="notification_text" style="color: white;">히히</a>
  </div>

<script>
	const showNotification = (user, txt, roomIndex) =>{
		console.log(user);
		$('#notification_text').html('<span style="color:red;">new</span>'+user+' '+txt);
		
		let temp = '<%=request.getContextPath()%>/chat/chat.jsp?index='+roomIndex;
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
	
	List<Integer> room_list = (List)session.getAttribute("chat_room_list");
	if(room_list!=null){
	%>
	
	var url = "ws://localhost:8088/amigo/chatHandler.do";
	var ws = new WebSocket(url);
	
	ws.onopen = function(){
	ws.onmessage = function(evt){
		let msg = evt.data.split("#");
		let no;
		let user;
		let txt;
		let roomIndex;
		let chat_no;
		let index;
		
		if(msg.length==5){
			no = msg[0]; 
			user = msg[1];
			txt = msg[2];
			roomIndex = msg[3];
			chat_no = msg[4];
			if(no == '2'){
				<% for(Integer index:room_list){
				%>
					index = '<%=index.intValue()%>';
					if(parseInt(roomIndex)==index){
						showNotification(user, txt, roomIndex);
					}
				<%
				}%>

			}
		}
	}
	}
		
	<%
	}
}%>


</script>

	
	

