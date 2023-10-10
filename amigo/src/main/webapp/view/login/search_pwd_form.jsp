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
</head>
<body>
	
<!-- header -->
	<div class="container col-md-6">
	   <div class="container text-center mt-5 mb-5">
	   <a href="home.jsp">
      <img src="resources/img/logo1.png" alt="logo" />
      </a>
    </div>
    <!-- header -->
    <!-- email seach -->
    <form action="search_pwd.do" method="post">
      <div class="form-group">
        <label for="search_pwdInput mt-5"></label>
        <input
          type="text"
          name="user_email"
          class="form-control"
          id="user_email"
          placeholder="이메일"
        />
      </div> <!-- email seach  end -->
      <!-- button -->
      <div class="d-grid">
        <button type="submit" class="btn btn-default btn-primary mt-5 mb-5" value="임시 비밀번호 발급">
          임시 비밀번호 발급
        </button>
         <!-- button end -->
      </div>
    </form>
    <br />
    <hr />
    <!-- pwd footer -->
    <div class="container text-center mt-5 mb-5">
      <div class="row justify-content-between">
        <div class="col-4"><a href="login.do">로그인</a></div>
        <div class="col-4"><a href="terms.do">회원가입</a></div>
      </div>
    </div> <!-- pwd footer end -->
    </div>
    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="js/script.js"></script>

	
</body>
</html>