<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html lang="kr">
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
        <link
      rel="stylesheet"
      type="text/css"
      href="/resources/css/style.css"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>main</title>

    <!-- a href컬러 조절 -->
    <style>
      .mypage_link:link {
        color: black;
      }
      .mypage_link:visited {
        color: black;
      }
      .mypage_link:hover {
        color: #189cc4;
      }
      /* 글자색 */
      .mypage_link {
        font-family: "Jalnan";
      }
    </style>
  </head>
  <body>
    <%@include file="/includes/header.jsp" %>

    <!-- 마이페이지 시작 -->
    <div class="container col-md-6 " align="center" id="myPageTop">
      <ul class="list-group list-group-flush" align="left">
        <c:if test="${ sessionScope.user.getUser_type() == 'A' }">
          <li class="list-group-item">
            <a style="font-size:16px; color:gray;">* 관리자  <span style="font-weight:bold; font-size:18px; color: #189cc4;">${ user.getUser_name() }</span>  입니다.</a>
          </li>
        </c:if>
        <li class="list-group-item">
          <a
            href="<%=request.getContextPath() %>/my_profile.do"
            class="mypage_link"
            >내 프로필 관리</a
          >
          <c:choose>
          	<c:when test="${user.getUser_photo()!=null and user.getUser_photo()!=''}">
          	<img src="/userimg/${user.getUser_photo()}" alt="userphoto" width="20px" height="20px" style="border-radius:10px" />
            </c:when>
            <c:otherwise>
            <img src="../../resources/img/logo2.png" alt="logo2" width="20px" height="20px"/>
            </c:otherwise>
          </c:choose>
        </li>
        <li class="list-group-item">
          <a href="getDogList.do" class="mypage_link">반려동물 프로필</a>
        </li>
        <li class="list-group-item">
          <a href="../../book_check.do" class="mypage_link">예약 확인</a>
        </li>
        <li class="list-group-item">
          <a
            href="<%=request.getContextPath() %>/cs_main.do"
            class="mypage_link"
            >고객센터</a
          >
        </li>
        <li class="list-group-item">
          <a
            href="<%=request.getContextPath() %>/view/mypage/notice.jsp"
            class="mypage_link"
            >공지사항</a
          >
        </li>
        <li class="list-group-item">
          <a href="account_controll.jsp" class="mypage_link">계정관리</a>
        </li>
        <c:if test="${ sessionScope.user.getUser_type() == 'A' }">
       		<li class="list-group-item">
       		   <a href="<%=request.getContextPath() %>/view/admin/getSitList.do" class="mypage_link">펫시터 회원관리</a>
     	    </li>
     	    
        </c:if>
        <c:if test="${ sessionScope.user.getUser_type() == 'U' }">
        <li class="list-group-item">
          <a href="apply/sitter_join.do" class="mypage_link">펫시터 지원하기</a>
        </li>
        </c:if>
        <!--
        <c:if test="${ sessionScope.user.getUser_type() == 'S' }">
          <li class="list-group-item">
          <a href="#" class="mypage_link">펫시터모드로 전환</a>
        </li>
        </c:if>-->
      </ul>
    </div>
    <%@include file="/includes/footer.jsp" %>

    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="js/script.js"></script>

    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
    <![endif]-->
  </body>
</html>
