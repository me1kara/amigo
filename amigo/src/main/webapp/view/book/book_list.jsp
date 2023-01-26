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
<title>My12_찜,예약 없을때 ~ MY13_찜,예약 있을때</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container">
		
			
			<h4>찜 목록 및 예약확인</h4>
			<p>펫시터</p>
			<hr>
			<div style="text-align: center">
			
			<c:set var="chatList" value="<%=chatList %>"></c:set>
			
			<c:choose>
			<c:when test="<%=checkRoom==null %>">	
			<p><b>선호 및 예약 펫시터가 없습니다</b></p>
				<button type="button" class="btn btn-secondary">펫시터보기</button>
			</div>
			</c:when>
			
			<c:when test="<%=checkRoom!=null %>">
				<table>
					<c:choose>	
					<c:when test="${!chatList.isEmpty() }">		
						<c:forEach var="chat" items="${chatList }">
						<tr>
						<td><a href="/amigo/chat/chat.jsp?index=${chat.getIndex()}&name=${chat.getUser_nick()}">방번호:${chat.getIndex() }</a></td>
						<td>마지막작성자:${chat.getUser_nick()}</td>
						<td>내용:${chat.getContent() }</td>				
						<c:if test="${!chat.isRead_is() }"> <!--  -->
						<td>new</td>
						</c:if>
						</tr>
						</c:forEach>
					</c:when>
					<c:when test="${chatList.isEmpty() }">
						<tr>
							<td><a href="/amigo/chat/chat.jsp?index=<%=checkRoom.getUser_no() %>&name=${user.getUser_nick()}">방번호:<%=checkRoom.getChat_index() %></a></td>
						</tr>
					</c:when>
					</c:choose>
					</table>
				</c:when>
			</c:choose>
			
			
	
		</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>