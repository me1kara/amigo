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
	footer{
		width:100%;
	}
  </style>
 </head>
 <body> 
  <script>
	const showNotification = (user, txt, roomIndex) =>{
		console.log(user);
		$('#notification_text').html('<span style="color:red;">new</span>'+user+' '+txt);
		
		let temp = '/chatList.do?index='+roomIndex;
		$('#notification_text').attr("href", temp);
		$('#notification-container').addClass('showChatMessage');
		
		//<a href="/
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
	
	var url = "ws://www.amigoo.store/chatHandler.do";
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
<script type="text/javascript">
// 화면 크기가 변경될 때마다 푸터 위치 조정
  function adjustFooterPosition() {
    const footer = document.querySelector("footer");
    const windowHeight = window.innerHeight;
    const bodyHeight = document.body.offsetHeight;

    // 페이지 내용이 화면보다 작을 때만 푸터를 아래로 이동
    if (bodyHeight < windowHeight) {
      footer.style.position = "absolute";
      footer.style.bottom = "0";
    } 
  }

  // 페이지 로드 시 및 화면 크기 변경 시 푸터 위치 조정
  window.addEventListener("load", adjustFooterPosition);
  window.addEventListener("resize", adjustFooterPosition);
</script>
  
  <!-- 실시간알림용 -->
  <div class="notification-container" id="notification-container">
    <a ref="" id="notification_text" style="color: white;"></a>
  </div>
  
    <!-- Footer -->
    <footer class="text-center text-white mt-3">
      <!-- Copyright -->
      <div class="text-center p-3" style="background-color:rgb(87, 160, 227);">
        © 2023 Copyright:
        <a class="text-white" href="#">amigoo.store</a>
      </div>
      <!-- Copyright -->
    </footer>
    <!-- Footer 끝 -->


</body>
</html>
	
	

