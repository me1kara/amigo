<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
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
    <link rel="stylesheet" type="text/css" href="/resources/css/style.css" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
<meta charset="UTF-8">
<title>Insert title here</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
<style>
	#idpwcheck {
		color: red;
	}

</style>
</head>
<body>
		<div class="container col-md-6">
		  <!-- header -->
  	  <div class="container text-center mt-5 mb-5">
      <a class="logo" href="/home.jsp"
        ><img alt="AmigoLogo1" src="resources/img/logo1.png"
      /></a>
  	  </div>
    <!-- header end  -->
		<form action="login.do" method="post">
		
        <input type="text" name="user_email" class="form-control" id="user_email" placeholder="아이디(이메일)" value="hjh@gmail.com">
       	<br>
        
        <input type="password" name="user_pw" class="form-control" id="user_pw" placeholder="비밀번호" autoComplete="off" value="12345"> 
		<br>
       	<c:if test="${ !sessionScope.isLoginSuccess and sessionScope.isLoginSuccess != null || sessionScope.matchedPassword != null and !sessionScope.matchedPassword}">
         	<h6 id ="idpwcheck">&nbsp;&nbsp;* 아이디와 비밀번호를 확인해주세요.</h6>
        </c:if>
        <div class="text-end">
		<a href="search_pwd.do">비밀번호를 잊으셨나요?</a>
		</div>
		<br>
		<br>
		
       <!-- button -->
      <div class="d-grid">
        <button type="submit" class="btn btn-default mt-5 mb-5" value="로그인" style="background: rgb(87, 160, 227); color: white;">
          로그인
        </button>
         <!-- button end -->
      </div>
        
        <hr>
        <br>
        
        <!--  <a href="#">다른 방식으로 로그인 할게요.</a>-->
		<input type="hidden" name="ubd_no" value="5"/>
		
		</form>
		</div>
		
		
		
         
</body>
</html>