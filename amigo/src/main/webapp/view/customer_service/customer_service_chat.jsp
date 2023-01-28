<%@page import="com.lec.amigo.vo.ChatRoom"%>
<%@page import="com.lec.amigo.vo.UserVO"%>
<%@page import="com.lec.amigo.dao.UserDAO"%>
<%@page import="com.lec.amigo.vo.ChatVO"%>
<%@page import="java.util.List"%>
<%@page import="com.lec.amigo.dao.ChatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<%
		ChatDAO dao = new ChatDAO();
		UserVO user = (UserVO)session.getAttribute("user");
		
		List<ChatRoom> roomList = dao.getRoomList(user.getUser_no());
		
		List<ChatVO> chatList = null;
		ChatRoom checkRoom = null;
		if(user!=null){
			checkRoom = dao.getRoom(user.getUser_no());
		
			if(checkRoom!=null)chatList = dao.getMyChatList(user.getUser_no());
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
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container">
		
			<hr>
			<div style="text-align: center">
			
			<c:set var="chatList" value="<%=chatList %>"></c:set>
			<c:set var="roomList" value="<%=roomList %>"></c:set>
			
			<c:choose>
			<c:when test="<%=checkRoom==null %>">	
			<p><b>채팅방이 없습니다</b></p>
			</div>
			</c:when>
			
			<c:when test="<%=checkRoom!=null %>">
				<table>
					<!-- 
					<c:choose>	
					<c:when test="${!chatList.isEmpty() }">			
						<c:forEach var="chat" items="${chatList }">
							<tr class="btn btn-outline-dark" onclick="location.href='/amigo/chatList.do?index=${chat.getIndex()}'">
							<td><b>이름 ${chat.getUser_nick()}</b></td>
							<td style="white-space:nowrap; overflow: hidden; text-overflow: ellipsis;">${chat.getContent() }</td>				
							<c:if test="${!chat.isRead_is() }"> 
							<td>new</td>
							</c:if>
							</tr>
							<br/>						
						</c:forEach>
					</c:when>
					<c:when test="${chatList.isEmpty() }">
						<tr>
							<td><a href="/amigo/chatList.do?index=<%=checkRoom.getChat_index() %>">방번호:<%=checkRoom.getChat_index() %></a></td>
						</tr>
					</c:when>
					</c:choose>
					 -->
					 
					 
			<c:forEach var="room"  items="${roomList }">
				<c:forEach var="chat" items="${chatList }">
					<c:choose>
						<c:when test="${chat.getIndex()==room.getChat_index() }">
							<tr class="btn btn-outline-dark" onclick="location.href='/amigo/chatList.do?index=${chat.getIndex()}'">
							<td><b>마지막글 ${chat.getUser_nick()}</b></td>
							<td style="white-space:nowrap; overflow: hidden; text-overflow: ellipsis;">${chat.getContent() }</td>
							
							<!-- 				
							<c:if test="${!chat.isRead_is() }"> 
							<td>new</td>
							</c:if>
							 -->
							</tr>
							<br/>
						</c:when>
						<c:otherwise>
							<br/>
							<tr>
								<td class="btn btn-outline-dark" onclick="location.href='/amigo/chatList.do?index=${room.getChat_index() }'">${room.getChat_index() }번방, 등록된 글이 없습니다!</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>		
			</c:forEach>
					</table>
				</c:when>
			</c:choose>
			
			

			
			
			
	
		</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>