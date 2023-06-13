<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
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
    		width: 308px;
    		height: 62px;
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
    		if(confirm('정말로 채팅방을 나가시겠습니까? 환불을 원하시면 예약취소를 해주세요!')){
    			$.ajax({
    				url  : '/ajax/deleteChatRoom.do',
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
						
					
					<!-- 내 채팅방목록(마지막채팅), 채팅이 없으면 빈방출력-->
					<!-- 유저가 채팅방을 소유하고있는지 여부 -->
					<c:choose>
						<c:when test="${empty myChatRoomList}">	
						<p><b>채팅방이 없습니다</b></p>
						</c:when>
						<c:when test="${not empty myChatRoomList}">
							<ul style="list-style: none;">
							
							<!-- db에서 받아온 내 채팅방(마지막채팅담김)목록 출력 -->
							<c:forEach var="chat" items="${myChatRoomList }">
									<h6 style="height:62px; width:308.88px;margin: 0 auto; text-align: left; line-height: 62px;">
										유저리스트:
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
										<li class="btn btn-outline-dark RL_item" id="cwarp${chat.getIndex()}" onclick="location.href='/chatList.do?index=${chat.getIndex()}'">
											<table>
												<tr>
													<td id="photoWrap">
													<!-- 채팅객체에 유저이름 필드가 없기때문에 유저리스트를 조사해서 이름 얻어오기  -->
														<c:forEach var="us" items="${userList }">
															<c:if test="${us.user_no==chat.user_no }">
																<img src="/userimg/${us.user_photo }" width="50px;" height="50px;" style="border-radius:50px;" > <!--유저이미지 --> 
															</c:if>
														</c:forEach>
													</td>

														<c:choose>
															<c:when test='${empty chat.getContent() }'>
																<span style="line-height: 45px; text-align: center;">등록된 글이 없습니다!</span>
															</c:when>
															<c:otherwise>
																<td>
																<ul style="list-style: none;" >	
									<c:choose>
															<c:when test='${chat.getContent() eq "해당유저는 나갔습니다" }'>
																<li style="line-height: 45px; text-align: center;">${chat.getUser_nick()} 이(가) 나갔습니다.</li>
																<script>
																	$('#photoWrap').remove();
																	$('#cwarp${chat.getIndex()}').attr('onclick', 'alert("상대방이 나가서 입장이 불가능합니다!")');
																</script>
															</c:when>
															<c:otherwise>
																<li style="width:250px; text-align: left;"><b>${chat.getUser_nick()}</b></li>
																<c:choose>									
																	<c:when test="${chat.getContent()=='file' }">
																		<li style="white-space:nowrap; overflow: hidden; text-overflow: ellipsis; text-align: left;">이미지..</li>
																	</c:when>
																	<c:otherwise>
																		<li style="white-space:nowrap; overflow: hidden; text-overflow: ellipsis; width:250px; text-align: left;"> ${chat.getContent() }</li>
																	</c:otherwise>
																	
																</c:choose>
															</c:otherwise>
														</c:choose>
																</ul>
															</c:otherwise>
														</c:choose>
												
													</td>
												</tr>
											</table>	
										</li>
										<button class="btn btn-ligth btn-outline-danger" onclick="exit_room(${ chat.index})" style="margin-top:10px;">나가기</button>
										<hr>						
							</c:forEach>
							
						</ul>
						</c:when>
					</c:choose>
					</div>
					<p style="position: sticky; bottom:50px; text-align: right;"><em>예약내용이 완수된 채팅방은 매주 금요일 삭제됩니다.</em></p>
				</article>
			</section>
		</div>

		<%@include file="/includes/footer.jsp" %>
	
</body>
</html>