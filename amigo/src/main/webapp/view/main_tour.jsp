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
		
		<br>
		<div class="container">
		
		<script>
		 function main_fail() {
     		alert("로그인 후 이용가능한 페이지입니다.");
         }
		</script>

		<a href="#" onclick="main_fail();">펫시터</a> <br>
		<a href="#" onclick="main_fail();">추천산책루트</a><br>
		<a href="#" onclick="main_fail()">병원</a><br>
		<a href="#" onclick="main_fail()">고객센터</a><br>
		<a href="#" onclick="main_fail()">커뮤니티</a><br>
	
		<!-- 메뉴바 만들기 전에 임시로 채팅연결용으로 사용 -->
		<a href="#" onclick="main_fail()">채팅목록</a><br>
		
		
		<a href="home.jsp">로그인 하러하기</a><br>
	
		</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>