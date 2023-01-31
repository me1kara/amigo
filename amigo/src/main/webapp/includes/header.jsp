<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" type="text/css" href="/amigo/resources/css/style.css" />
    <style>
    	body {
  padding-top: 50px;
  /* 생략 */
}
    	
    	.nav-link {
	
  font-family: "Roboto", sans-serif;
  text-decoration: none;
  color: black;
  font-family: "Jalnan";
  font-size: 90%;
  
}
    </style>
</head>
<body>
	<!-- css를 적용하지 않았기 때문에 차후에 적용해줘야합니다. -->
	<div class="container">
	<nav
      class="navbar navbar fixed-top navbar-light bg-light navbar-expand-custom navbar-mainbg"
    >	
      <button
        class="navbar-toggler"
        type="button"
        aria-controls="navbarSupportedContent"
        aria-expanded="false"
        aria-label="Toggle navigation">
        <!-- 햄버거 -->
        <span class="navbar-toggler-icon"></span>
        <!-- 햄버거/ -->
      </button>
      <a class="logo" href="<%=request.getContextPath() %>/view/main.jsp"><img alt="AmigoLogo" src="/amigo/resources/img/logo1.png"
      /></a>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ml-auto">
          <div class="hori-selector">
            <div class="left"></div>
            <div class="right"></div>
          </div>
          <hr/>
          <li class="nav-nickName">
          	<a class="nav-link" hraf="#" onclick="return false;">회원님</a>
          </li>
          <hr/>
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath() %>/view/mypage/my_page_list.jsp"><i class="fas fa-tachometer-alt"></i>마이페이지</a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="#"
              ><i class="address-book"></i>예약확인</a
            >
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/amigo/myChatList.do"><i class="amigo-chating"></i>채팅</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath() %>/user_board_list.do"><i class="far fa-calendar-alt"></i>커뮤니티</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#"
              ><i class="far fa-chart-bar"></i>아미고 파트너 모집</a
            >
          </li>
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath() %>/view/customer_service/customer_service_main.jsp"><i class="aimgo-cs"></i>고객센터</a>
          </li>
        </ul>
      </div>
    </nav>
    </div>
    <!-- 네비바 종료 -->
	<!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="/amigo/resources/js/script.js"></script>
	
</body>
</html>