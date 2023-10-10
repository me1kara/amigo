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
    <link rel="stylesheet" type="text/css" href="/resources/css/style.css" />
    
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <style>
      .nav-link {
        font-family: "Roboto", sans-serif;
        text-decoration: none;
        color: black;
        font-family: "Jalnan";
        font-size: 90%;
        border-bottom:20px;
      }

      .navbar-toggler {
        margin-left: 20px;
        width: 30px;
        display: contents;
      }

      .menu-trigger,
      .menu-trigger span {
        display: inline-block;
        transition: all 0.4s;
        box-sizing: border-box;
      }

      .menu-trigger {
        position: relative;
        width: 40px;
        height: 34px;
        margin-left: 30px;
      }

      .menu-trigger span {
        position: absolute;
        left: 0;
        width: 100%;
        height: 4px;
        background-color: gray;
        border-radius: 4px;
      }

      .menu-trigger span:nth-of-type(1) {
        top: 0;
      }

      .menu-trigger span:nth-of-type(2) {
        top: 15px;
      }

      .menu-trigger span:nth-of-type(3) {
        bottom: 0;
      }

      /* type-01 */
      /* 중앙 라인이 고정된 자리에서 투명하게 사라지며 상하라인 회전하며 엑스자 만들기 */
      .menu-trigger.active-1 span:nth-of-type(1) {
        -webkit-transform: translateY (15px) rotate (-45deg);
        transform: translateY(15px) rotate(-45deg);
      }

      .menu-trigger.active-1 span:nth-of-type(2) {
        opacity: 0;
      }

      .menu-trigger.active-1 span:nth-of-type(3) {
        -webkit-transform: translateY(-15px) rotate(45deg);
        transform: translateY(-15px) rotate(45deg);
      }
    </style>
  </head>
  <body>
    <!-- css를 적용하지 않았기 때문에 차후에 적용해줘야합니다. -->
    <div class="container" style="margin-bottom: 150px;">
      <nav
        class="navbar navbar fixed-top navbar-light bg-light navbar-expand-custom navbar-mainbg"
      >
        <button
          class="navbar-toggler"
          type="button"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <!-- 햄버거 -->
          <a class="menu-trigger" href="#">
            <span></span>
            <span></span>
            <span></span>
          </a>
          <!-- 햄버거/ -->
        </button>
        <a
          class="logo"
          href="<%=request.getContextPath()%>/main_home.do?ubd_no=5"
          ><img alt="AmigoLogo" src="/resources/img/logo1.png"
        /></a>
         <c:choose>
          	<c:when test="${user.getUser_photo()!=null and user.getUser_photo()!=''}">
          	<img src="/userimg/${user.getUser_photo()}" style="border-radius:50px; margin-right:20px;" alt="userphoto" width="50px" height="50px" style="border-radius:10px" />
            </c:when>
            <c:otherwise>
            <img src="/resources/img/logo2.png" style="border-radius:50px; margin-right:20px;" alt="logo2" width="50px" height="50px"/>
            </c:otherwise>
        </c:choose>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav ml-auto">
            <div class="hori-selector">
              <div class="left"></div>
              <div class="right"></div>
            </div>
            <hr/>
            <li class="nav-item">
              <a
                class="nav-link"
                href="<%=request.getContextPath() %>/view/mypage/my_page_list.jsp"
                >마이페이지</a
              >
            </li>
            <li class="nav-item active">
              <a class="nav-link" href="/book_check.do">예약확인</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/myChatList.do">채팅</a>
            </li>
            <li class="nav-item">
              <a
                class="nav-link"
                href="<%=request.getContextPath() %>/user_board_list.do"
                >커뮤니티</a
              >
            </li>
            <li class="nav-item">
           <c:choose>
       		 <c:when test="${ sessionScope.user.getUser_type() == 'U' }">
              <a class="nav-link" href="/view/mypage/apply/sitter_join.do">아미고 펫시터 모집</a>
             </c:when>
             <c:when test="${ sessionScope.user.getUser_type() == 'A' || sessionScope.user.getUser_type() == 'S'}">
             <a class="nav-link" href="#" onclick="alert('일반 회원만 신청 가능합니다')">아미고 펫시터 모집</a>
             </c:when>
           </c:choose>
            </li>
            <li class="nav-item">
              <a
                class="nav-link"
                href="<%=request.getContextPath() %>/cs_main.do"
                >고객센터</a
              >
            </li>
          </ul>
        </div>
      </nav>
    </div>
    <!-- 네비바 종료 -->
    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="/resources/js/script.js"></script>
    <script>
      var burger = $(".menu-trigger");

      burger.each(function (index) {
        var $this = $(this);

        $this.on("click", function (e) {
          e.preventDefault();
          $(this).toggleClass("active-" + (index + 1));
        });
      });
    </script>
  </body>
</html>
