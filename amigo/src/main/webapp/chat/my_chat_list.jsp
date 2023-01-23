<%@page import="com.lec.amigo.vo.ChatVO"%>
<%@page import="java.util.List"%>
<%@page import="com.lec.amigo.dao.ChatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
	<%	
	ChatDAO dao = new ChatDAO();
	List<ChatVO> chatList = dao.getMyChatList(1);	
	%>
<head>
<script
  src="https://code.jquery.com/jquery-3.6.3.min.js"
  integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
  crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>내 채팅방 목록</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	<%@include file="/includes/header.jsp" %>
		<div class="container">		
		<table>		
			<c:forEach var="chat" items="<%=chatList %>">
			<tr>
				<td><a href="chat.jsp?index=${chat.getIndex()}&name=${chat.getUser()}&user_no=5">방번호:${chat.getIndex() }</a></td>
				<td>마지막작성자:${chat.getUser()}</td>
				<td>내용:${chat.getContent() }</td>				
				<c:if test="${!chat.isRead_is() }"> <!--  -->
					<td>안 읽었음!</td>
				</c:if>
			</tr>
			</c:forEach>
			
		</table>
			
		</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>