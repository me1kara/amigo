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
<style>
   /* aimgo 메인 사진들 css */
	.img-fluid{
		border-radius: 20px;
		border:2px outset rgba(44, 134, 204, 0.67);
		cursor:pointer;
		
	}
	
	
	.img-fluid needYou {
		
		
	}
	
	/* 폰트 적용(여기어때 폰트)*/
	h4 {
	
  font-family: "Roboto", sans-serif;
  text-decoration: none;
  color: black;
  font-family: "Jalnan";
  font-size: 90%;
  
	}

</style>
<title>메인홈</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container">
		<!--   
		<a href="sitter/sitter_service_main.jsp">펫시터</a>
		<a href="#">추천산책루트</a>
		<a href="#">병원</a>
		<a href="#">고객센터</a>
		<a href="#">커뮤니티</a>
			-->
			
		<!-- 메뉴바 만들기 전에 임시로 채팅연결용으로 사용 
		<a href="view/customer_service/customer_service_chat.jsp">채팅목록</a>	
		-->
		
		
	    <!-- Am!go 소개 -->
    <div class="container text-center" id="AmigoTop">
      <div class="amigoMainImg">
        <img
          src="/amigo/resources/img/amigoLoginImg.png"
          class="img-fluid"
          alt="amigoPet"
        />
      </div>
    </div>
    <!--소개 종료-->

    <!-- AM!GO 서비스 -->
    <!-- 차후에 아이콘으로 대체할것임.-->
    <div class="container overflow-hidden">
      <div>
        <h4>AM!GO서비스</h4>
      </div>
      <div class="row gy-5">
      <!-- 펫시터 -->
        <div class="col-6">
          <div class="p-3">
          <a href="sitter/sitter_service_main.jsp">
            <img
              src="/amigo/resources/img/petsitter.png"
              class="img-fluid"
              alt="..."
            />
            </a>
          </div>
        </div> <!-- 펫시터 end -->
        <!-- 추천산책루트  -->
        <div class="col-6">
          <div class="p-3">
             <a href="#">
            <img
              src="/amigo/resources/img/walking.png"
              class="img-fluid"
              alt="..."
            />
            </a>
          </div>
        </div> <!-- 추천산책루트 end -->
        <!-- 병원 -->
        <div class="col-6">
          <div class="p-3">
            <a href="#">
            <img
              src="/amigo/resources/img/hp.png"
              class="img-fluid"
              alt="..."
            />
            </a>
          </div>
        </div> <!-- 병원 end -->
        <!-- 고객센터 -->
        <div class="col-6">
          <div class="p-3">
            <a href="<%=request.getContextPath() %>/view/customer_service/customer_service_main.jsp">
            <img
              src="/amigo/resources/img/cs.png"
              class="img-fluid"
              alt="..."
            />
            </a>
          </div>
        </div> <!-- 고객센터 end -->
      </div>
    </div>
    <hr />
    <!-- 커뮤니티 -->
    <div class="container">
      <div>
        <h4>커뮤니티</h4>
        <a href="#">전체보기</a>
      </div>
      <div class="row text-center">
        <a href="#">
          <img
            src="/amigo/resources/img/community.png"
            class="img-fluid"
            alt="community"
          />
        </a>
      </div>
      <br />
      <div class="row text-center">
        <a href="#">
          <img
            src="/amigo/resources/img/needYou.png"
            class="img-fluid"
            alt="needYou"
           
          />
        </a>
      </div>
    </div>
    <!-- 커뮤니티 종료-->
    <br />
    <!-- 실시간 후기 -->
    <div>
      <h4>실시간 후기</h4>
      <a href="#">전체보기</a>
    </div>
    <div id="carouselExampleDark" class="carousel carousel-dark slide">
      <div class="carousel-indicators">
        <button
          type="button"
          data-bs-target="#carouselExampleDark"
          data-bs-slide-to="0"
          class="active"
          aria-current="true"
          aria-label="Slide 1"
        ></button>
        <button
          type="button"
          data-bs-target="#carouselExampleDark"
          data-bs-slide-to="1"
          aria-label="Slide 2"
        ></button>
        <button
          type="button"
          data-bs-target="#carouselExampleDark"
          data-bs-slide-to="2"
          aria-label="Slide 3"
        ></button>
      </div>
      <div class="carousel-inner">
        <div class="carousel-item active" data-bs-interval="10000">
          <img
            src="https://via.placeholder.com/400x100"
            class="d-block w-100"
            alt="..."
          />
          <div class="carousel-caption d-none d-md-block">
            <h5>First slide label</h5>
            <p>Some representative placeholder content for the first slide.</p>
          </div>
        </div>
        <div class="carousel-item" data-bs-interval="2000">
          <img
            src="https://via.placeholder.com/400x100"
            class="d-block w-100"
            alt="..."
          />
          <div class="carousel-caption d-none d-md-block">
            <h5>Second slide label</h5>
            <p>Some representative placeholder content for the second slide.</p>
          </div>
        </div>
        <div class="carousel-item">
          <img
            src="https://via.placeholder.com/400x100"
            class="d-block w-100"
            alt="..."
          />
          <div class="carousel-caption d-none d-md-block">
            <h5>Third slide label</h5>
            <p>Some representative placeholder content for the third slide.</p>
          </div>
        </div>
      </div>
      <button
        class="carousel-control-prev"
        type="button"
        data-bs-target="#carouselExampleDark"
        data-bs-slide="prev"
      >
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button
        class="carousel-control-next"
        type="button"
        data-bs-target="#carouselExampleDark"
        data-bs-slide="next"
      >
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>
    <!-- 후기 종료 -->
    <br />
    <!-- Q&A -->
    <div>
      <h4>Q&A</h4>
      <a href="#">전체보기</a>
    </div>
    <div class="card text-center" style="width: 18rem">
      <img class="card-img-top" src="" alt="Card image cap" />
      <div class="card-body">
        <p class="card-text">
          Some quick example text to build on the card title and make up the
          bulk of the card's content.
        </p>
      </div>
    </div>
    <br />
    <!-- Q&A 종료 -->

	
		</div>
	<%@include file="/includes/footer.jsp" %>

	    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>