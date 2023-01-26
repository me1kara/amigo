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
<title>프로필01_시터 프로필 확인</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<h2> 시터 프로필 정보</h2>
			<form action="sitter_profile.do">
			<div class="form-control text-center">
				<img class="profile-user-img img-fluid img-circle"
					src="${path}/dist/img/profile/${login.userImg}"
					alt="User profile picture">
					<!-- 여기는 시터에 맞는걸로 바꿀 것.  -->
			</div>
			<div class="form-control text-center">
				<h4></h4>
			</form>			
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>