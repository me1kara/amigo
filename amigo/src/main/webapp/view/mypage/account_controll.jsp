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
    <link rel="stylesheet" type="text/css" href="css/style.css" />
<title>Insert title here</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
	
		<!--  My18_계정관리~My19 -->
	 <div class="container">
      <!-- myAccount header -->
      <h4>계정관리</h4>
      <!-- end -->
      <br />
      <!-- Menu -->
      <div>
        <!-- 회원 로그아웃 버튼-->
        <button
          type="button"
          class="btn btn-primary"
          data-bs-toggle="modal"
          data-bs-target="#staticBackdrop"
        >
          로그아웃
        </button>
        <!-- end -->
        <!-- 회원 로그아웃 모달 -->
        <div
          class="modal fade"
          id="staticBackdrop"
          data-bs-backdrop="static"
          data-bs-keyboard="false"
          tabindex="-1"
          aria-labelledby="staticBackdropLabel"
          aria-hidden="true"
        >
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">
                  로그아웃
                </h1>
                <button
                  type="button"
                  onclick="location.href='';" 
                  class="btn-close"
                  data-bs-dismiss="modal"
                  aria-label="Close"              
                ></button>
              </div>
              <div class="modal-body">
                로그아웃을 하여도 데이터는 보존되며 로그인 할 시 <br />다시
                접속할 수 있습니다. 정말 로그아웃 하시겠습니까?
              </div>
              <div class="modal-footer">
                <button
                  type="button"
                  onclick="location.href='';"
                  class="btn btn-secondary"
                  data-bs-dismiss="modal"
                >
                  취소
                </button>
                <button type="button" onclick="location.href='../../logout.do';"  class="btn btn-primary">로그아웃</button>
              </div>
            </div>
          </div>
        </div>
        <!-- 회원 로그아웃 모달 end -->
      </div>
      <hr />
      <br />
      <div>
        <!-- 회원 탈퇴 버튼-->
        <button
          type="button"
          onclick="location.href=';" 
          class="btn btn-primary"
          data-bs-toggle="modal"
          data-bs-target="#staticBackdrop1"
        >
          탈퇴하기
        </button>
        <!-- end -->
        <!-- 회원 탈퇴 모달 -->
        <div
          class="modal fade"
          id="staticBackdrop1"
          data-bs-backdrop="static"
          data-bs-keyboard="false"
          tabindex="-1"
          aria-labelledby="staticBackdropLabel1"
          aria-hidden="true"
        >
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel1">
                  이별 준비중
                </h1>
                <button
                  type="button"
                  class="btn-close"
                  onclick="location.href='';" 
                  data-bs-dismiss="modal"
                  aria-label="Close"
                ></button>
              </div>
              <div class="modal-body">
                정말 당신의 AM!GO와 이별하시겠습니까?
              </div>
              <div class="modal-footer">
                <button
                  type="button"                  
                  class="btn btn-secondary"
                  onclick="location.href='';" 
                  data-bs-dismiss="modal"
                >
                  머물기
                </button>
                <button type="button" class="btn btn-primary" onclick="location.href='../../revoke.do?user_no=${user.getUser_no()}&user_photo=${user.getUser_photo()}';" >이별하기</button>
              </div>
            </div>
          </div>
        </div>
        <!-- 회원 로그아웃 탈퇴 end -->
      </div>
      <!-- end -->
      <hr />
    </div>
    <%@include file="/includes/footer.jsp" %>
    
     <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="js/script.js"></script>
</body>
</html>