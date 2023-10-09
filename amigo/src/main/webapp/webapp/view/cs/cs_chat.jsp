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
    		width:66%;
    	}
    	
    	.chat-header-title {
    		font-family: "Jalnan";
      		font-size:40px;
      		text-align: left;
    	}
    	
    </style>
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container" style="margin-top:60px;">
			<section>
				<article>
					<div style="text-align: center; width: 500px; margin: 0 auto;" >
					
						 <div class="p-5">
				         	<p class="chat-header-title">채팅</p>
				    	 </div> 
					
					<c:set var="chatList" value="<%=chatList %>"/>
					<c:set var="elseRoomList" value="<%=elseRoomList %>"></c:set>
					
					<c:choose>
						<c:when test="<%=checkRoom==null %>">	
						<p><b>채팅방이 없습니다</b></p>
					</div>
						</c:when>
						<c:when test="<%=checkRoom!=null %>">
							<ul style="list-style: none;">
							<c:forEach var="chat" items="${chatList }">
										<li class="btn btn-outline-dark RL_item" onclick="location.href='/chatList.do?index=${chat.getIndex()}'">
											<table>
												<tr>
													<td>
														<c:forEach var="us" items="${userList }">
															<c:if test="${us.user_no==chat.user_no }">
																<img src="/img/${us.user_photo }" width="50px;" height="50px;" > <!-- 파일나중에 저장할 것--> 
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
												</tr>
											</table>	
									<!-- 				
										<c:if test="${!chat.isRead_is() }"> 
										<td>new</td>
										</c:if>
										 -->
										</li>
										<hr><br>						
							</c:forEach>
							
							<% for(ChatRoom room :elseRoomList){
							%>
								<li class="btn btn-outline-dark" style="height:62px; width:308.88px; text-align: center; line-height: 45px;" onclick="location.href='/chatList.do?index=<%=room.getChat_index()%>'"><%=room.getChat_index()%>번방, 등록된 글이 없습니다!</li>
								<hr><br>
							<% 
							} %>							
						</ul>
						</c:when>
					</c:choose>
				</article>
			</section>
		</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>