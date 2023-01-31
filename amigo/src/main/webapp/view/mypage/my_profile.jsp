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
    <link rel="stylesheet" type="text/css" href="/amigo/resources/css/style.css" />
   
<meta charset="UTF-8">
<title>Insert title here</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
   
   <%@include file="/includes/header.jsp" %>
       <!-- Profile nav -->
    <!-- user의 프로필 정보를 가져와야합니다. -->
    <form action="updateUser.do" method="post" enctype="multipart/form-data">
    <div class="myProfileMainBox">
      <div class="profileNav">
          <a href="#"> ${ user.getUser_name() } </a>
        <!-- 이곳에 유저의 이름이 들어와야합니다. -->
        <h4>안녕하세요!</h4>
        <!-- 프로필 사진 업로드 -->
        <div class="container">
          <div class="picture-container">
            <div class="picture">
              <img
                src="https://lh3.googleusercontent.com/LfmMVU71g-HKXTCP_QWlDOemmWg4Dn1rJjxeEsZKMNaQprgunDTtEuzmcwUBgupKQVTuP0vczT9bH32ywaF7h68mF-osUSBAeM6MxyhvJhG6HKZMTYjgEv3WkWCfLB7czfODidNQPdja99HMb4qhCY1uFS8X0OQOVGeuhdHy8ln7eyr-6MnkCcy64wl6S_S6ep9j7aJIIopZ9wxk7Iqm-gFjmBtg6KJVkBD0IA6BnS-XlIVpbqL5LYi62elCrbDgiaD6Oe8uluucbYeL1i9kgr4c1b_NBSNe6zFwj7vrju4Zdbax-GPHmiuirf2h86eKdRl7A5h8PXGrCDNIYMID-J7_KuHKqaM-I7W5yI00QDpG9x5q5xOQMgCy1bbu3St1paqt9KHrvNS_SCx-QJgBTOIWW6T0DHVlvV_9YF5UZpN7aV5a79xvN1Gdrc7spvSs82v6gta8AJHCgzNSWQw5QUR8EN_-cTPF6S-vifLa2KtRdRAV7q-CQvhMrbBCaEYY73bQcPZFd9XE7HIbHXwXYA=s200-no"
                class="picture-src"
                id="wizardPicturePreview"
                title=""
              />
              <input type="file" name="uploadFile" id="wizard-picture" class="" aria-describedby="uploadFile" aria-label="Upload"/>
            </div>
            <h6 class="">사진업로드</h6>
          </div>
        </div>
        <!-- 프로필 사진 업로드 종료 -->
        <!-- profile nav end -->
      </div>

      <!-- 프로필 상세 -->     
      <!-- 이메일 // 이메일 정보가 가져와져야합니다. -->
      <label for="userEmail" class="form-label">이메일 아이디</label>
      <div class="input-group mb-3">
        <input type="email" class="form-control" id="userEmail" value="${ user.getUser_email() }" disabled>
      </div>
      <!-- 이메일 end -->
      <!-- 닉네임 변경 // 유저의 닉네임을 불러와줘야합니다. -->
      <label for="userNickname" class="form-label">닉네임 변경</label>
      <div class="input-group mb-3">
        <input type="text" class="form-control" id="userNickname" value="${ user.getUser_nick() }">
      </div>
      <!-- 닉네임 변경 end -->
      <!-- 비밀번호 변경 -->
      <label for="userPassword" class="form-label">비밀번호 변경</label>
      <div class="input-group mb-3">
        <input type="password" class="form-control" id="userPassword" value="${ user.getUser_pw() }">
      </div>
      <!-- 비밀번호 변경 end -->
      <!-- 후대폰 번호 변경 -->
      <label for="userPhone" class="form-label">핸드폰 번호</label>
      <div class="input-group mb-3">
        <input type="tel" class="form-control" id="phone" value="${ user.getUser_phone() }">
      </div>
       <!-- 후대폰 번호 변경 end -->
       <!-- 주소 변경 -->
       <!-- 다음 api 적용예정 -->
       <label for="addr" class="form-label">내 주소</label>
      <div class="input-group mb-3">
        <input type="text" class="form-control" id="addr" value="${ user.getUser_addr() }">
      </div>
      </div>    
      
      <!-- 주소 변경 end -->
    <!-- 프로필 상세 end-->
        <button class="btn btn-outline-secondary" type="submit">변경 완료</button>  
        <input type="hidden" name="user_no" value="${ user.getUser_no()}">
  </form>
  
  
    <!-- profile page 종료 -->
    <!-- Footer -->
    <footer class="bg-primary text-center text-white">
      <!-- Grid container -->
      <!-- Grid container -->
      <!-- Copyright -->
      <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2)">
        © 2022 Copyright:
        <a class="text-white" href="#">amigo.com</a>
      </div>
      <!-- Copyright -->
    </footer>
    <!-- Footer 끝 -->

   
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
    <![endif]-->
    
    <!-- 이곳은 푸터가 조금 다르기 때문에 직접 적용해줬음
   <@include file="/includes/footer.jsp" %>
   -->
   
</body>
</html>