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
<style>
	
	.CsTitleColor {
		color:rgb(87, 160, 227);
		font-family: "Jalnan";
        font-size:40px;
	}

</style>
<title>고객센터01_고객센터메인</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		   <!-- 타이틀 -->
 <div class="container">
<div class="container text-center">
<div class="CsTitleColor">
    <h1>AM!GO입니다.</h1>
</div>
    <h5>무엇을 도와드릴까요?</h5>
</div>
<!-- 타이틀 end-->

<!-- 타이틀 메뉴 -->
<div class="container">
 <a href="#">돌봄,산책</a>
</div>
<!-- 타이틀 메뉴 end-->
<hr/>
<!-- 메뉴내용 -->
<div class="accordion accordion-flush" id="accordionFlushExample">
    <div class="accordion-item">
      <h2 class="accordion-header" id="flush-headingOne">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
          AM!GO란 무엇인가요?
        </button>
      </h2>
      <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
        <div class="accordion-body"> 아미고란 스페이언로 친구라는 뜻을 의미합니다. 그 뜻과 같이 당신의 동반자들인 반려동물들과 행복한 삶을~ </div>
      </div>
    </div>
    <div class="accordion-item">
      <h2 class="accordion-header" id="flush-headingTwo">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
          돌봄, 산책 기능을 이용하고 싶어요.
        </button>
      </h2>
      <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
        <div class="accordion-body">산책과 돌봄기능은 AM!GO의 핵심 기능들입니다. <code>돈만 있으면 가능~</code> 이용하세요 </div>
      </div>
    </div>
    <div class="accordion-item">
      <h2 class="accordion-header" id="flush-headingThree">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
            이용가능 지역은 어디인가요?
        </button>
      </h2>
      <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
        <div class="accordion-body"> 사용자의 거주지 주변에 펫시터가 있다면 어디든지 가능합니다. <code>물론 돈이 있으면 </code>이용하세요</div>
      </div>
    </div>
  </div>
  <hr/>
  </div>
<!-- 메뉴내용 end -->

<!-- 상담 -->
<div class="row justify-content-around mt-5 mb-5 text-center ">
  <button type="button" class="btn btn-secondary col-3 btn-md" onclick="#">게시판 문의</button>
  <button type="button" class="btn btn-secondary col-3 btn-md" onclick="#">채팅 문의</button>
</div>

<!-- 상담 end -->
       <!-- Footer -->
       <footer class="container text-center text-white" style="background-color: rgb(87, 160, 227);">
        <!-- Grid container -->
        <div class="container p-2">
          <!-- Section: Social media -->
          <section class="mb-5">
          <span>채팅 문의 평일 오전 10:00~오후 06:00 (상시 상담 가능)</span>
          </section>
          <!-- Section: Form -->
        </div>
        <!-- Grid container -->
        
        <!-- Copyright -->
        <div class="text-center p-3" style="background-color: rgb(87, 160, 227);">
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
  
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>