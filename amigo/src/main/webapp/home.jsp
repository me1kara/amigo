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
<title>로그인전01_처음화면</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
<<<<<<< HEAD
	
	<%@include file="/includes/header.jsp" %>
=======
	<!-- 로그인 화면에서는 네비바가 필요 없을거 같습니다. --> 
	<!-- <@include file="/includes/header.jsp" %> -->
	 
	 <!--  
	     과거 코드
>>>>>>> 7182dc0c26565c61f75e4f1e4dabb7c44bb62434
		<div class="container">
		
		<br>
		<a href="login.do">이메일 로그인</a>
		<br>
		<a href="terms.do">이메일 가입</a>
<<<<<<< HEAD

		</div>
	<%@include file="/includes/footer.jsp" %>
=======
		<br>
		
		<br><br>
		<a href="main_tour.do">둘러보기</a>
		
		</div>
		-->
		
		 <!-- 메인 화면-->
    <!-- icon -->
    <div class="text-center">
      <img
        class="img-responsive"
        src="resources/img/logo2.png"
        alt="AmigoMainLogo"
        width="450"
        height="440"
      />
    </div>
    <!-- icon end-->
    <hr />
    <div class="loginLogo2 text-center" width="90">
      <img src="resources/img/logo1.png" alt="logo1" />
    </div>
    <!-- 로그인 폼 -->
    <!-- Submit button -->
    <section class="vh-100">
      <form>
        <div class="container py-5 h-100" align="center">
          <!-- 이메일 로그인 -->
          <button type="button" class="btn btn-primary btn-lg btn-block" onclick="location.href='login.do';">
            이메일 로그인
          </button>
          <button type="button" class="btn btn-secondary btn-lg btn-block" onclick="location.href='terms.do';">
            이메일 가입
          </button>
          <!-- 이메일 로그인 end -->
          <!-- 카카오, 지메일 -->
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
          <!-- 카카오, 지메일 end -->
        </div>
        <div class="container text-center">
          <div class="row justify-content-between">
            <div class="col-4"><a href="#">가입/로그인이 안되요</a></div>
            <div class="col-4"><a href="main_tour.do">둘러보기</a></div>
          </div>
        </div>
      </form>
    </section>
    
    
    <!-- 로그인 end -->
    <!-- 하단 -->
    <!-- 메인 화면 종료 -->
  </body>
	
  	<!--  	<@include file="/includes/footer.jsp" %> -->
>>>>>>> 7182dc0c26565c61f75e4f1e4dabb7c44bb62434

	
</body>
</html>