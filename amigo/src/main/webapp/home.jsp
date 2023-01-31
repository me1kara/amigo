<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
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
    <link rel="stylesheet" type="text/css" href="/amigo/resources/css/style.css" />
<meta charset="UTF-8">
<style></style>
<title>로그인전01_처음화면</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	<!-- 로그인 화면에서는 네비바가 필요 없을거 같습니다. --> 
	<!-- <@include file="/includes/header.jsp" %> -->
	 
	 <!--  
	     과거 코드
		<div class="container">
		
		<a href="login.do">이메일 로그인</a>
		<br>
		<a href="terms.do">이메일 가입</a>
		<br>
		
		<br><br>
		<a href="main_tour.do">둘러보기</a>
		
		</div>
		-->
		
		 <!-- 메인 화면-->
    <!-- icon -->
    <div class="contaier mt-5 text-center">
      <img
        class="img-responsive"
        src="resources/img/logo2.png"
        alt="AmigoMainLogo"
        width="450"
        height="440"
      />
    </div>
    <br/>
    <!-- icon end-->
    <hr />
    <div class="container mt-2">
    <div class="loginLogo2 text-center" width="90">
      <img src="resources/img/logo1.png" alt="logo1" />
    </div>
    </div>
    <!-- 로그인 폼 -->
    <!-- Submit button -->
    <section class="vh-100">
      <form>
        <div class="container mt-3 mb-5 py-5  h-100" align="center">
          <!-- 이메일 로그인 -->
          <button type="button" class="btn btn-primary btn-lg btn-block" onclick="location.href='login.do';">
            이메일 로그인
          </button>
          <button type="button" class="btn btn-secondary btn-lg btn-block" onclick="location.href='terms.do';">
            이메일 가입
          </button>
          <!-- 이메일 로그인 end -->
          <!-- 카카오, 지메일 
          <div class="container py-5 h-100" align="center">
            <a class="kakaoLogin" href="#" alt="kakao">
              <img src="resources/img/kakao.png" alt="kakaoButton" width="242" />
            </a>
            <a class="googleLogin" href="#" alt="google">
              <img
                src="resources/img/google.png"
                alt="googleButton"
                height="65"
                width="250"
              />
            </a>
          </div>
          카카오, 지메일 end -->
        </div>
        <hr />
        <div class="container text-center mt-2">
          <div class="row justify-content-between">
            <div class="col-5"><a href="#">가입/로그인이 안되요</a></div>
            <div class="col-4"><a href="main_tour.do">둘러보기</a></div>
          </div>
        </div>
      </form>
    </section>
    <!-- 로그인 end -->
    <!-- 하단 -->
    <!-- 메인 화면 종료 -->
  	 <!-- Footer -->
    <footer class="bg-primary text-center text-white">
      <!-- Grid container -->
      <div class="container">
        <!-- Section: Social media -->
        <section class="mb-4"></section>
        <!-- Section: Form -->
      </div>
      <!-- Grid container -->
      <!-- Copyright -->
      <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2)">
        © 2022 Copyright:
        <a class="text-white" href="#">amigo.com</a>
      </div>
      <!-- Copyright -->
    </footer>
    <!-- Footer 끝 -->
</body>
</html>