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

<script>
    document.getElementById("sitter_apply_form").addEventListener("submit", function(e) {
        var othersInput = document.getElementById("sitter_others_input");
        var othersRadio = document.getElementById("flexRadioDefault6");
        if (othersRadio.checked && othersInput.value === "") {
            alert("내용을 입력해주세요");
            e.preventDefault();
        }
    });
</script>


<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>My22_펫시터지원폼</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->	
</head>
<body>
	      <!-- not null  이면 Required 를 인풋에다가 쓰면되겠다.  세션에서 로긴한사람 회원정보만 담아서 이름이나 주소, 연락처를 뿌려주면될텐데. -->
	<%@include file="/includes/header.jsp" %>
		<div class="container">
		
			<form action="sitter_apply_form.do" method="post">
			<div class="row">
			
				<input type="hidden" name="user_name" value="${ sessionScope.user.getUser_name() }" >
				<input type="hidden" name="user_name" value="${ sessionScope.sitter.getSitter_name() }" >
			
				<h4>1. 기본정보</h4>
				<div class="sit_photo">프로필 사진</div>
					<div class="myPhoto text-center">
					<img class="profile-user-img img-fluid img-circle"
					src="${path}/dist/img/profile/${login.userImg}"
					alt="User profile picture">
				</div>
				<br>
				<div class="myPhotoUpload text-center">
					<a href="#" class="btn btn-primary btn-xs" data-toggle="modal"
					data-target="#userPhotoModal"> <i class="fa fa-photo">
					업로드</i>
					</a>
				</div>
				
				<div class="id_wrap">
					<div class="user_name">지원자 성명</div>
					<div class="id_input_box">
					<input class="id_input text-center" name="${ sessionScope.user.getUser_name }">
					</div>
				</div><br>
				
				<div class="gender_wrap">
					<div class="sit_gender">성별</div>
					<div class="id_input_box">
					<input type="radio"  class="btn-check" name="g_options" id="option1" autocomplete="off">
					<label class="btn btn-secondary" for="option1">남성</label>
					<input type="radio"  class="btn-check" name="g_options" id="option2" autocomplete="off">
					<label class="btn btn-secondary" for="option2">여성</label>
					</div>
				</div><br><br> 
				
				<div class="birth_wrap">
					<div class="sit_birth">생년월일</div>
					<div class="birth_input_box">
					<input class="birth_input text-center">
				</div>
					<span>04년생부터(만 18세 이상) 지원이 가능합니다.</span>
				</div><br>

				
				<div class="phone_wrap">
					<div class="user_phone">연락처</div>
					<div class="phone_input_box">
					<input class="phone_input text-center" value="${ sessionScope.user.getUser_phone() }">
				</div>
					<span>입력한 휴대폰 번호로 합격 여부를 알려드립니다.</span>
				</div><br>
				
				<div class="addr_wrap">
					<div class="user_addr">주소</div>
					<div class="addr_input_box">
					<input class="phone_input text-center" value="${ sessionScope.user.getUser_addr() }">
				</div>
					<span>시/군/구까지 입력해주세요.</span>
				</div><br>
				
				<div class="smoking_wrap">
					<div class="sit_smoking">흡연여부</div>
					<div class="smoking_input_box">
					<input type="radio"  class="btn-check" name="s_options" id="option3" autocomplete="off">
					<label class="btn btn-secondary" for="option3">흡연</label>
					<input type="radio"  class="btn-check" name="s_options" id="option4" autocomplete="off">
					<label class="btn btn-secondary" for="option4">비흡연</label>
					</div>
				</div><br><br>
				
				<div class="job_wrap">
					<div class="sitter_job">현재 하시는 일</div>
					
					<div class="form-check">
  						<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
 						 <label class="form-check-label" for="flexRadioDefault1">주부</label>
					</div>
					<div class="form-check">
 						 <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2">
 						 <label class="form-check-label" for="flexRadioDefault2">학생</label>
					</div>
					<div class="form-check">
 						 <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault3">
 						 <label class="form-check-label" for="flexRadioDefault3">직장인</label>
					</div>
					<div class="form-check">
 						 <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault4">
 						 <label class="form-check-label" for="flexRadioDefault4">프리랜서</label>
					</div>
					<div class="form-check">
 						 <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault5">
 						 <label class="form-check-label" for="flexRadioDefault5">구직자</label>
					</div>
					<div class="form-check">
 						 <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault6">
 						 <label class="form-check-label" for="flexRadioDefault6">직접 입력</label>
					</div>
					<input class="sitter_others_input text-center" id="sitter_others_input" placeholder="이곳에 직접 입력해주세요">
				</div><br><br>
				
				<hr />
				<h4>2. 활동 정보</h4>
				
				<div class="day_wrap">
					<div class="sitter_job">활동 가능한 일수(한 달 기준)</div>
					
					<div class="form-check2">
  						<input class="form-check-input" type="radio" name="flexRadioDefault2" id="flexRadioDefault1">
 						 <label class="form-check-label" for="flexRadioDefault1">주말 포함한 30일 모두 가능합니다.</label>
					</div>
					<div class="form-check2">
 						 <input class="form-check-input" type="radio" name="flexRadioDefault2" id="flexRadioDefault2" checked>
 						 <label class="form-check-label" for="flexRadioDefault2">평균 20일 이상 가능합니다.</label>
					</div>
					<div class="form-check2">
 						 <input class="form-check-input" type="radio" name="flexRadioDefault2" id="flexRadioDefault2" checked>
 						 <label class="form-check-label" for="flexRadioDefault2">평균 20일 이하 가능합니다.</label>
					</div>
					<div class="form-check2">
 						 <input class="form-check-input" type="radio" name="flexRadioDefault2" id="flexRadioDefault2" checked>
 						 <label class="form-check-label" for="flexRadioDefault2">
 						  주말만 가능합니다.<br>
 						  <span class="sitter_weekends">(방문 펫시터로 활동이 어려울 수 있습니다.)</span>
 						 </label>
					</div>

				</div>
				<br>
				
				<div class="job_wrap">
					<div class="sitter_job">활동 가능한 시간대</div>
					
					<div class="form-check3">
  						<input class="form-check-input" type="radio" name="flexRadioDefault3" id="flexRadioDefault1">
 						 <label class="form-check-label" for="flexRadioDefault1">모두 가능합니다.</label>
					</div>
					<div class="form-check3">
 						 <input class="form-check-input" type="radio" name="flexRadioDefault3" id="flexRadioDefault2" checked>
 						 <label class="form-check-label" for="flexRadioDefault2">오전타임(오전8:00~오후12:00)</label>
					</div>
					<div class="form-check3">
 						 <input class="form-check-input" type="radio" name="flexRadioDefault3" id="flexRadioDefault2" checked>
 						 <label class="form-check-label" for="flexRadioDefault2">오후타임(오후12:00~오후06:00)</label>
					</div>
				</div>
				
				<div class="care_wrap">
					<div class="sit_care_exp">[선택]타인의 반려동물을 돌봐준 경험</div>
					<div class="care_input_box">
					<input class="care_input text-center" name="sit_care_exp" placeholder="그 외 반려동물 관련 경력 또는 경험에 대해서 알려주세요">
				</div> 
					<span>04년생부터(만 18세 이상) 지원이 가능합니다.</span>
				</div><br>

				
				<div class="intro_wrap">
					<div class="user_intro">자기소개</div>
					<div class="intro_input_box">
					<input class="intro_input text-center" name="sit_intro">
				</div>
					<span>입력한 휴대폰 번호로 합격 여부를 알려드립니다.</span>
				</div><br>
				
				
				
				
			</div>
			
			<button type="submit" class="btn btn-primary btn-lg btn-block">보내기</button>
			
			</form>		
		</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>