<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html lang="en">
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
    <link rel="stylesheet" type="text/css" href="/amigo/resources/css/style.css" />
    <title>main</title>
    <style>
    a { text-decoration:none }
    
    .img-fluid {
    	margin-top:20px;
    	border-radius: 50px;
    	height: 326px;
    	weith:352px;
    
    }
    
    .welcome h2{
  font-family: "Roboto", sans-serif;
  text-decoration: none;
  color:rgb(89, 139, 198);
  font-family: "Jalnan";
  font-size: 40px;
  margin-botton:20px;
  }
  
   .welcome h4{
  font-family: "Roboto", sans-serif;
  text-decoration: none;
  color:black;
  font-family: "Jalnan";
  font-size: 35px;
  margin-botton:20px;
   }
    
   .check-box { 
   	font-family: "Roboto", sans-serif;
  text-decoration: none;
  color:black;
  font-family: "Jalnan";
  font-size: 15px;
  padding :10px;
   } 
   .check-box a {
   	margin-botton:20px;
   }
    </style>
  </head>
  <body>
 <!-- header -->
 <div class="container text-center mb-5">
 <a class="logo" href="#home.jsp"
 ><img alt="AmigoLogo" src="/amigo/resources/img/logo1.png"
/></a>
<!-- 제거해도 될거라고 판단 --> 
 <!-- <div class="text-end ">
<button type="button" class="btn-close" aria-label="Close"></button>
</div> -->
</div>
 <!-- header end  -->

 <!-- 약관 동의문서 -->
<form action="signup.do">
<div class="container col-md-6">
    <div class="welcome">
        <h2>어서오세요</h2>
        <h4>약관동의가 필요해요</h4>
    </div>
    <div class="check-box">
       <input type='checkbox'
       name='amigoTAC' 
       value='selectall'
       onclick='selectAll(this)'/> <b>전체동의</b>
       <hr/>
<br />
<input type='checkbox'
       name='amigoTAC' 
       value='check1'
       required/> <a href="#">AM!GO약관동의</a>
<br />
<input type='checkbox' 
       name='amigoTAC' 
       value='check2' 
       required/> <a href="#">개인 정보 처리 방침 동의</a>
<br />
<input type='checkbox' 
       name='amigoTAC' 
       value='check3'
       required/> <a href="#">안전보상 프로그램 약관동의</a>
<br />
	<input type='checkbox' 
       name='amigoTAC' 
       value='check4'
       required /> <a href="#">펫시터약관동의</a>
    </div>
    	<div class="container text-center" id="terms-photo">
        <img
              src="/amigo/resources/img/amigoLoginImg.png"
              class="img-fluid"
              alt="amigoTermsLogo"
            />
   	 	</div>
    <br/>
    <div class="container text-center">
        <button type="submit" class="btn btn-primary btn-lg" >다음으로</button>
    </div>
</div>
</form>

 <!-- 약관 동의문서 end -->
 
 <!-- Footer -->
 <footer class="bg-primary  text-center text-white">
    <!-- Grid container -->
    <div class="container p-4">
      <!-- Section: Social media -->
      <section class="mb-4">   
      <!-- Section: Form -->
      <section class="">
        <form action="">
          <!--Grid row-->
          <div class="row d-flex justify-content-center">
            <!--Grid column-->
            <div class="col-auto">
            </div>
            <!--Grid column-->
            <div class="col-md-5 col-12">
              <!-- Email input -->
              <div class="form-outline form-white mb-4">
              </div>
            </div>
            <!--Grid column-->
            <div class="col-auto">
              <!-- Submit button -->   
            </div>
            <!--Grid column-->
          </div>
          <!--Grid row-->
        </form>
      </section>
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
    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="/amigo/resources/js/script.js"></script>

    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
    <![endif]-->
  </body>
</html>
