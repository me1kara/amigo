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
    <link rel="stylesheet" type="text/css" href="./resources/css/style.css" />
    <title>Document</title>
<title>Insert title here</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<!-- 공지사항 header-->
    <div class="container">
      <h4>공지사항</h4>
    </div>
    <!-- end -->
    <hr />
    <!-- 아코디언 -->
    <div class="accordion" id="accordionExample">
      <div class="accordion-item">
        <h2 class="accordion-header" id="headingOne">
          <button
            class="accordion-button"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#collapseOne"
            aria-expanded="true"
            aria-controls="collapseOne"
          >
            코로나 19 관련 대응 공지
          </button>
        </h2>
        <div
          id="collapseOne"
          class="accordion-collapse collapse show"
          aria-labelledby="headingOne"
          data-bs-parent="#accordionExample"
        >
          <div class="accordion-body">
            신종 코로나바이러스와 관련하여 AM!GO는 안전한 펫시팅이 될수 있도록
            위생 관리에 총력을 기울이고 있으며 질병 예방대책을 아래와 같이
            실행하고 있습니다.
            <br />
            질방 예방대책 안전하고 깨끗한 돌봄 환경을 위해 위생 용품을
            사용합니다.
            <br />
            AM!GO 펫시터님들은 꺠끗한 돌봄환경을 위해 위생 장갑, 손 소독제 ,
            탈취제를 사용하고 있습니다. 고객님의 댁에 들어가기전 손 소독제로
            손을 소독하고, 반려동물의 식사 준비, 배변 처리를 할 때 위생 장갑을
            사용합니다.
          </div>
        </div>
      </div>
    </div>
    <!-- end -->
    <hr />
	<%@include file="/includes/footer.jsp" %>
<!-- 네비바 종료 -->
	<!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="./resources/js/script.js"></script>
	
</body>
</html>