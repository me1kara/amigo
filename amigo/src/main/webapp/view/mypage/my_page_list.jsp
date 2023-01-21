<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html lang="kr">
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
  </head>
  <body>
    <!-- css를 적용하지 않았기 때문에 차후에 적용해줘야합니다. -->
    <nav
      class="navbar navbar fixed-top navbar-light bg-light navbar-expand-custom navbar-mainbg"
    >
      <button
        class="navbar-toggler"
        type="button"
        aria-controls="navbarSupportedContent"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <i class="fas fa-bars text-white"></i>
        <span class="navbar-toggler-icon"></span>
      </button>
      <a class="logo" href="#home.jsp"
        ><img alt="AmigoLogo" src="img/logo1.png"
      /></a>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ml-auto">
          <div class="hori-selector">
            <div class="left"></div>
            <div class="right"></div>
          </div>
          <li class="nav-item">
            <a class="nav-link" href="#"
              ><i class="fas fa-tachometer-alt"></i>마이페이지</a
            >
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="#"
              ><i class="far fa-address-book"></i>예약확인</a
            >
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#"><i class="far fa-clone"></i>채팅</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#"
              ><i class="far fa-calendar-alt"></i>커뮤니티</a
            >
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#"
              ><i class="far fa-chart-bar"></i>아미고 파트너 모집</a
            >
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#"><i class="far fa-copy"></i>고객센터</a>
          </li>
        </ul>
      </div>
    </nav>
    <!-- 네비바 종료 -->

    <!-- 마이페이지 시작 -->
    <div class="container" align="center" id="myPageTop">
      <ul class="list-group list-group-flush" align="left">
        <li class="list-group-item">
          <a href="user_Profil.jsp" class="mypage_link">내 프로필 관리</a>
          <img src="../images/codeit.png" alt="코드잇 이미지" />
        </li>
        <li class="list-group-item">
          <a href="getDogList.do" class="mypage_link">반려동물 프로필</a>
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
          <a href="#" class="mypage_link">환경설정</a>
        </li>
        <li class="list-group-item">
          <a href="#" class="mypage_link">펫시터 지원하기</a>
        </li>
        <li class="list-group-item">
          <a href="#" class="mypage_link">펫시터모드로 전환</a>
        </li>
      </ul>
    </div>
    <!-- Footer -->
    <footer class="bg-primary text-center text-white">
      <!-- Copyright -->
      <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2)">
        © 2022 Copyright:
        <a class="text-white" href="#">amigo.com</a>
      </div>
      <!-- Copyright -->
    </footer>
    <!-- Footer 끝 -->
    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="js/script.js"></script>

    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
    <![endif]-->
  </body>
</html>
