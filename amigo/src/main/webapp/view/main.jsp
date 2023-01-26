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
<meta charset="UTF-8">
<title>메인홈</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container">
		
		<a href="sitter/sitter_service_main.jsp">펫시터</a>
		<a href="#">추천산책루트</a>
		<a href="#">병원</a>
		<a href="#">고객센터</a>
	
		<!-- 메뉴바 만들기 전에 임시로 채팅연결용으로 사용 -->
		<a href="view/book/book_list.jsp">채팅목록</a>	
	
		</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>