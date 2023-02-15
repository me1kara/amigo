<%@page import="com.lec.amigo.vo.ChatRoom"%>
<%@page import="com.lec.amigo.vo.UserVO"%>
<%@page import="com.lec.amigo.vo.ChatVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<%
		UserVO user = (UserVO)session.getAttribute("user");
		List<ChatRoom> elseRoomList = (List<ChatRoom>)request.getAttribute("elseRoomList");
		List<ChatVO> chatList = null;
		ChatRoom checkRoom = null;
		if(user!=null){
			checkRoom = (ChatRoom)request.getAttribute("checkRoom");
		
			if(checkRoom!=null)chatList = (List<ChatVO>)request.getAttribute("myChatList");
		}
		
		
		
	%>
	


<script
  src="https://code.jquery.com/jquery-3.6.3.min.js"
  integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
  crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>고객센터02채팅방리스트</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
    
    <style>
    	.RL_item{
    		width:90%;
    	}
    	
    	.chat-header-title {
    		font-family: "Jalnan";
      		font-size:40px;
      		text-align: left;
      		margin-left: 10%;
    	}
    	
    </style>
    
    <script>
    	function exit_room(index){
    		if(confirm('정말로 나가시겠습니까?')){
    			$.ajax({
    				url  : '/amigo/ajax/deleteChatRoom.do',
    				type : 'POST',
    				data : {
    					'index' : index	
    				},
    				success : function(result){
    					alert('삭제에 성공했습니다!');
    					history.go(0);
    				},
    			    error : function(request, status, error) { // 결과 에러 콜백함수
    			        console.log(error);
    			        alert('삭제에 실패했습니다!');
    			        history.go(0);
    			    }
    			});
    		}
    	}
    </script>
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container" style="margin-top:60px;">
			<section>
				<article>
					<div style="text-align: center; width: 400px; margin: 0 auto;" >
				
				    <p class="chat-header-title">채팅목록</p>
						
					<c:set var="chatList" value="<%=chatList %>"/>
					<c:set var="elseRoomList" value="<%=elseRoomList %>"></c:set>
					
					<!-- 내 채팅방목록(마지막채팅), 채팅이 없으면 빈방출력-->
					<!-- 유저가 채팅방을 소유하고있는지 여부 -->
					<c:choose>
						<c:when test="<%=checkRoom==null %>">	
						<p><b>채팅방이 없습니다</b></p>
						</c:when>
						<c:when test="<%=checkRoom!=null %>">
							<ul style="list-style: none;">
							
							<!-- db에서 받아온 내 채팅방(마지막채팅담김)목록 출력 -->
							<c:forEach var="chat" items="${chatList }">
										<h6 style="height:62px; width:308.88px;margin: 0 auto; text-align: left; line-height: 62px;">
										
										<c:forEach var="room" items="${roomUserList }">
										<c:if test="${ chat.index==room.chat_index}">
											<c:forEach var="rusl" items="${userList }">
												<c:if test="${rusl.user_no==room.user_no }">
													${rusl.user_nick} 
												</c:if>
											</c:forEach>
										</c:if>
										</c:forEach>
										
										
										</h6>
										<li class="btn btn-outline-dark RL_item" onclick="location.href='/amigo/chatList.do?index=${chat.getIndex()}'">
											<table>
												<tr>
													<td>
													<!-- 채팅객체에 유저이름 필드가 없기때문에 유저리스트를 조사해서 이름 얻어오기  -->
														<c:forEach var="us" items="${userList }">
															<c:if test="${us.user_no==chat.user_no }">
																<img src="/userimg/${us.user_photo }" width="50px;" height="50px;" style="border-radius:50px;" > <!--유저이미지 --> 
															</c:if>
														</c:forEach>
													</td>
													
													
													<td>
														<ul style="list-style: none;" >
														<li style="width:250px; text-align: left;"><b>${chat.getUser_nick()}</b></li>
														<c:choose>									
															<c:when test="${chat.getContent()=='file' }">
																<li style="white-space:nowrap; overflow: hidden; text-overflow: ellipsis; text-align: left;">이미지..</li>
															</c:when>
															<c:otherwise>
																<li style="white-space:nowrap; overflow: hidden; text-overflow: ellipsis; width:250px; text-align: left;"> ${chat.getContent() }</li>
															</c:otherwise>
															
														</c:choose>
														</ul>
													</td>
<%-- 													<td>
														<button onclick="location.href='/amigo/exit_chat_room.do?room_index=${chat.getIndex()}'">채팅방나가기</button>
													</td> --%>
												</tr>
											</table>	
									<!-- 				
										<c:if test="${!chat.isRead_is() }"> 
										<td>new</td>
										</c:if>
										 -->
										</li>
										<button class="btn btn-ligth btn-outline-danger" onclick="exit_room(${ chat.index})">나가기</button>
										<hr>						
							</c:forEach>
							
							<% for(ChatRoom room :elseRoomList){
							%>
							<c:set var="room" value="<%=room %>"/>
								<h6 style="height:62px; width:308.88px;margin: 0 auto; text-align: left; line-height: 62px;">
								
                                 <c:forEach var="rooml" items="${roomUserList }">
										<c:if test="${ room.chat_index==rooml.chat_index}">
											<c:forEach var="rusl" items="${userList }">
												<c:if test="${rusl.user_no==rooml.user_no }">
													${rusl.user_nick} 
												</c:if>
											</c:forEach>
										</c:if>
								</c:forEach>
								
								</h6>
								<li class="btn btn-outline-dark" style="height:62px; width:308.88px; text-align: center; line-height: 45px;" onclick="location.href='/amigo/chatList.do?index=<%=room.getChat_index()%>'">등록된 글이 없습니다!</li>
								<button class="btn btn-ligth btn-outline-danger" onclick="exit_room(<%=room.getChat_index()%>)">나가기</button>
								<hr>
							<% 
							} %>							
						</ul>
						</c:when>
					</c:choose>
					</div>
				</article>
			</section>
		</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>