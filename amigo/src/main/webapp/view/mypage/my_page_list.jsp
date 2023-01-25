<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script
      src="https://code.jquery.com/jquery-3.6.3.min.js"
      integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
      crossorigin="anonymous"
    ></script>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" type="text/css" href="css/style.css" />
    <title>main</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
	 <!-- 마이페이지 시작 -->
    <div class="container" align="center" id="myPageTop">
      <ul class="list-group list-group-flush" align="left">
        <li class="list-group-item">
          <a href="user_Profil.jsp" class="mypage_link">내 프로필 관리</a>
          <img src="../images/codeit.png" alt="코드잇 이미지" /><!-- 프로필 넣어주는게 가능? -->
        </li>
        <li class="list-group-item">
          <a href="dog_Profil.jsp" class="mypage_link">반려동물 프로필</a>
        </li>
        <li class="list-group-item">
          <a href="#" class="mypage_link">찜 목록 & 예약 확인</a>
        </li>
        <li class="list-group-item">
          <a href="#" class="mypage_link">고객센터</a>
        </li>
        <li class="list-group-item">
          <a href="#" class="mypage_link">공지사항</a>
        </li>
        <li class="list-group-item">
          <a href="account_controll.jsp" class="mypage_link">계정관리</a>
        </li>
        <li class="list-group-item">
          <a href="#" class="mypage_link">펫시터 지원하기</a>
        </li>
        <li class="list-group-item">
          <a href="#" class="mypage_link">펫시터모드로 전환</a>
        </li>
      </ul>
    </div>
    
	<%@include file="/includes/footer.jsp" %>
 <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="../resources/js/script.js"></script>
	
</body>
</html>