<%@page import="com.lec.amigo.vo.ChatRoom"%>
<%@page import="com.lec.amigo.vo.ChatVO"%>
<%@page import="com.lec.amigo.vo.UserVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script type="text/javascript">
const footer = document.querySelector("footer");
const header = document.querySelector("header");
const body = document.querySelector("body");
const windowHeight = window.innerHeight;
// 화면 크기가 변경될 때마다 푸터 위치 조정
	function adjustFooterPosition() {    
	  //header크기가 바디에 포함 안 돼서 
	  let bodyHeight = body.offsetHeight + header.offsetHeight;
	  //바디가 모니터 화면보다 작은 경우,중간에 푸터가 위치하는걸 방지
	  if (bodyHeight< windowHeight) {
	    //모바일과 윈도우의 height 값의 차이를 상정
	    if(window.innerWidth>=700){
	footer.style.position = "absolute";
	    }
	    footer.style.bottom = "0";
	  }else {
	      footer.style.position = "static"; // 푸터를 기본 위치로 돌림
	  }
	}

// 페이지 로드 시 푸터 위치 조정
window.addEventListener("load", adjustFooterPosition);
window.addEventListener("resize", adjustFooterPosition);

</script>
	
<script>
	const showNotification = (user, msg, roomIndex) =>{
		console.log(user);
		$('#notification_text').html('<span style="color:red;">new</span>'+user+' '+msg);
		
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
		if(jd.order=='send'){
			let user = jd.userName;
			type= jd.type;
			let roomIndex = jd.roomIndex;			
			let chat_no = jd.chatNo;
			msg = jd.msg;
			
			<% for(ChatRoom room:room_list){
			%>
				let index = '<%=room.getChat_index()%>';
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



	
	

