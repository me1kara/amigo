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
	<meta charset="UTF-8">
<style>
    footer {
         margin-top: auto;
         position: fixed;
    	 bottom: 0;
    	 width: 100%;
     }


/* 버튼 css */
     #holder {
        -moz-user-select: -moz-none;
        -khtml-user-select: none;
        -webkit-user-select: none;
        padding: 10px;
        width: 250px;
        margin: 0 auto;
        position: relative;
        top: 50%;
        transform: translateY(-65%);
        border-radius: 2px;
        top:120px;
      }
      .button-main1 {
        background: rgb(87, 160, 227);
        
        margin: 20px auto;
        width: 200px;
        height: 50px;
        overflow: hidden;
        text-align: center;
        transition: 0.2s;
        cursor: pointer;
        border-radius: 3px;
        box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.2);
      }
      .btnTwo {
        position: relative;
        width: 200px;
        height: 100px;
        margin-top: -86px;
        padding-top: 2px;
        background: #ffffff;
        left: -250px;
        transition: 0.3s;
      }
      .btnText {
      
      	margin-top:13px;
        color: white;
        transition: 0.3s;
      }
      .btnText2 {
        margin-top: 50px;
        margin-right: -130px;
        color: rgb(87, 160, 227);
      }
      .button-main1:hover .btnTwo {
        /*When hovering over .button change .btnTwo*/
        left: -130px;
      }
      .button-main1:hover .btnText {
        /*When hovering over .button change .btnText*/
        margin-left: 65px;
      }
      .button-main1:active {
        /*Clicked and held*/
        box-shadow: 0px 5px 6px rgba(0, 0, 0, 0.3);
      }

</style>
<title>로그인전01_처음화면</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
    <!-- icon -->
    <div class="container col-md-6 mb-5">
    <div class="contaier mt-5 text-center">
      <img
        class="img-responsive"
        src="resources/img/logo2.png"
        alt="AmigoMainLogo"
        width="380"
        height="350"
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
    
      <form>
      <!-- 새로운 버튼을 만듦 -->
       <div id="holder">
      <div class="button-main1"  onclick="location.href='login.do';" >
        <p class="btnText">이메일 로그인</p>   
        <div class="btnTwo">
          <p class="btnText2">GO!</p>
        </div>
      </div>

      <div class="button-main1" onclick="location.href='terms.do';">
        <p class="btnText">이메일 가입</p>
        <div class="btnTwo">
          <p class="btnText2">AM!GO</p>
        </div>
      </div>
    </div>
        <hr />
        <div class="container text-center mt-2">
          <div class="row justify-content-center">
            <div class="col-4"><a href="main_tour.do?ubd_no=5">둘러보기</a></div>
          </div>
        </div>
      </form>
    </div>
    </div>
    <!-- 로그인 end -->
    <!-- 하단 -->
    <!-- 메인 화면 종료 -->
  	 <!-- Footer -->
    <footer class="bg-primary text-center text-white">
      <!-- Copyright -->
      <div class="text-center p-3" style="background-color: rgb(87, 160, 227);">
        © 2023 Copyright:
        <a class="text-white" href="#">amigo.com</a>
      </div>
      <!-- Copyright -->
    </footer>
    <!-- Footer 끝 -->
</body>


</html>