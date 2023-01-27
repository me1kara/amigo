<%@page import="com.lec.amigo.vo.SitterVO"%>
<%@page import="com.lec.amigo.vo.UserVO"%>
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


<%
	UserVO user = new UserVO();
	user.setUser_name(user.getUser_name());  // 일단 이곳은 유저 VO를 가져오도록 동작->유저네임 임의 세팅 후 동작 시켜봄, 즉 더미
	user.setUser_phone(user.getUser_phone());
	user.setUser_addr(user.getUser_addr());
	session.setAttribute("user", user);
	System.out.println("안녕?"); // 일단 데이

%><!-- 스크립트는 중간에 작성하였습니다 230127 현재 흡연여부, 현재직종만 적용. -->




<title>My22_펫시터지원폼</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->	
</head>
<body>
	      <!-- input : 테이블의 not null 부분에 Required 작성, 유저가 시터 지원정보를 입력하면 관리자에게 전송하는 폼 -->
	        <!-- sit_auth_is 는 boolean이고, false인 0을 디폴트값으로 넘기고, 관리자가 승인하면 올리도록 처리하려 함 -->
	      <!-- 아래 폼에서 입력받지 않을 정보(유저명, 유저주소, 연락처)는 disabled 처리 + submit을 위해 hidden도 같이쓸것.  -->
	      <!-- 흡연  을 체크하면 '흡연자는 신청이 불가능합니다' 가 뜨게 하고, 직접 입력을 입력하면 Textarea에 현재직종 입력하고 
	            생년월일은 "YYYYMMDD"  타입으로만 받도록 할 것임 23/01/23-->
	      
	      
	<%@include file="/includes/header.jsp" %>
		<div class="container">
		
			<form action="sitter_apply_form.do" method="post" onSubmit="return checkData();">
			<div class="row">
			
				<input type="hidden" class="form-control" name="user_no" value="1">
				<input type="hidden" class="form-control" name="user_name" value="${ sessionScope.user.getUser_name() }" >
				<input type="hidden" class="form-control" name="user_phone" value="${ sessionScope.user.getUser_phone() }">
				<input type="hidden" class="form-control" name="user_addr" value="${ sessionScope.user.getUser_addr() }" >
				<input type="hidden" class="form-control" name="sit_auth_is" value="0">
				<!-- 히든타입. disabled는 값 전달이 안돼서 히든을 사용하여 세션에서 값을 받은 것. -->
				<!-- sit_auth_is 는 승인여부로 기본값은 0, 즉 false 로 관리자에게 넘길 것. -->
			
				<div class="form-group">
				<h4>1. 기본정보</h4>
					<h4>프로필사진*</h4>
				</div>
				<!-- 프로필 사진 업로드 -->
				<div class="form-group text-center">
					<div class="picture">
						<img class="profile-user-img img-fluid img-circle"
						src="https://lh3.googleusercontent.com/LfmMVU71g-HKXTCP_QWlDOemmWg4Dn1rJjxeEsZKMNaQprgunDTtEuzmcwUBgupKQVTuP0vczT9bH32ywaF7h68mF-osUSBAeM6MxyhvJhG6HKZMTYjgEv3WkWCfLB7czfODidNQPdja99HMb4qhCY1uFS8X0OQOVGeuhdHy8ln7eyr-6MnkCcy64wl6S_S6ep9j7aJIIopZ9wxk7Iqm-gFjmBtg6KJVkBD0IA6BnS-XlIVpbqL5LYi62elCrbDgiaD6Oe8uluucbYeL1i9kgr4c1b_NBSNe6zFwj7vrju4Zdbax-GPHmiuirf2h86eKdRl7A5h8PXGrCDNIYMID-J7_KuHKqaM-I7W5yI00QDpG9x5q5xOQMgCy1bbu3St1paqt9KHrvNS_SCx-QJgBTOIWW6T0DHVlvV_9YF5UZpN7aV5a79xvN1Gdrc7spvSs82v6gta8AJHCgzNSWQw5QUR8EN_-cTPF6S-vifLa2KtRdRAV7q-CQvhMrbBCaEYY73bQcPZFd9XE7HIbHXwXYA=s200-no"
               			class="picture-src"
           	    		id="wizardPicturePreview"
                	    title=""
                	    name="sit_photo"
						alt="User profile picture">
					<input type="file" class="form-control" name="sit_photo" value="이미지없어" required> 
					</div>
				</div>
				<br>
				
				<div class="form-group">
					<label for="user_name">지원자 성명</label> <!-- 사용자 편의를 위해 자동으로 뜨게 하나 disabled은 값이 안넘어가니 상단에 hidden처리. -->
					<div class="name_input_box">
					<input class="form-control" name="user_name" value="${ sessionScope.user.getUser_name() }" disabled>
					</div>
				</div><br>
				
				<div class="form-group">
					<label for="sit_gender">성별*</label>
					<div class="gender_input_box">
					<input type="radio"  class="btn-check" name="sit_gender" id="male" value="m" autocomplete="off">
					<label class="btn btn-secondary" for="male">남성</label>
					<input type="radio"  class="btn-check" name="sit_gender" id="female" value="f" autocomplete="off" required>
					<label class="btn btn-secondary" for="female">여성</label>
					</div>             <!-- 밸류값은 m 과 f 로 넘길 것 -->
				</div><br><br> 

				<script type="text/javascript">
				
				function checkData(){
					var smokingYes = document.getElementById('sit_smoking_yes');
					if (smokingYes.checked){
						alert("흡연자는 반려동물에게 피해를 줄 수 있어 가입이 제한됩니다");  // 흡연자의 펫시터 신청을 차단함.
						return false;   // alert 기능 확인함(230125) 단, 다른 JS 함수가 들어가면 안먹힘.
					}
					
					var othersInput = document.getElementById("sitter_others_input");   //id가 sitter~~와 같은 인풋 받고
			        var othersRadio = document.getElementById("flexRadioDefault6");     // 6번 라디오박스 받고
			        if (othersRadio.checked && othersInput.value === "") {              // 6번박스가 체크됐는데 인풋이 공백이면, 경고창이 뜨도록함.
			            alert("현재 하시는 일을 입력해주세요");								// 현재 하는일에서 직접 입력을 체크하면 input을 꼭 쓰도록 함.
			        	return false;   // alert 기능 확인함(230125)
			        }
			        return true;
				}
				</script>
				
		
				
				
				<div class="form-group">
					<label for="sit_birth">생년월일*</label>
					<div class="birth_input_box">
					<input class="form-control" name="sit_birth" id="sit_birth_8digit" type="date" required>
					</div>
					<span>04년생부터(만 18세 이상) 지원이 가능합니다.</span>
				</div><br>

				
				<div class="form-group">
					<label for="user_phone">연락처</label>
					<div class="phone_input_box">
					<input class="form-control" name="user_phone" value="${ sessionScope.user.getUser_phone() }" disabled>  <!-- 유저테이블에서 그냥 받아버리기 -->
					</div>
					<span>등록된 휴대폰 번호로 합격 여부를 알려드립니다.</span>
				</div><br>
				
				<div class="form-group">
					<label for="user_addr">주소</label>
					<div class="addr_input_box">
					<input class="form-control" name="user_addr" value="${ sessionScope.user.getUser_addr() }" disabled>
					</div>
					<span>시/군/구까지 입력해주세요.</span>
				</div><br>
				
				<div class="form-group">
					<label for="sit_smoking">흡연여부*</label>
					<div class="smoking_input_box">
					<input type="radio"  class="btn-check" name="sit_smoking" id="sit_smoking_yes" value="1">
					<label class="btn btn-secondary" for="sit_smoking_yes">흡연</label>
					<input type="radio"  class="btn-check" name="sit_smoking" id="sit_smoking_no" value="0" required>
					<label class="btn btn-secondary" for="sit_smoking_no">비흡연</label>
					</div>
				</div>  <br><br>    
				<div class="form-group">
					<label for="sit_exp">시터 경험여부*</label>
					<div class="exp_input_box">
					<input type="radio"  class="btn-check" name="sit_exp" id="sit_exp_yes" value="1" required>
					<label class="btn btn-secondary" for="sit_exp_yes">경험자</label>
					<input type="radio"  class="btn-check" name="sit_exp" id="sit_exp_no" value="0">
					<label class="btn btn-secondary" for="sit_exp_no">비경험자</label>
					</div>
				</div> 
				
				
				
				<div class="form-group">
					<label for="sit_job">현재 하시는 일*</label>
					
					<div class="form-check">
  						<input class="form-check-input" type="radio" name="sit_job" id="flexRadioDefault1" value="주부">
 						 <label class="form-check-label" for="sit_job">주부</label>
					</div>
					<div class="form-check">
 						 <input class="form-check-input" type="radio" name="sit_job" id="flexRadioDefault2" value="학생">
 						 <label class="form-check-label" for="sit_job">학생</label>
					</div>
					<div class="form-check">
 						 <input class="form-check-input" type="radio" name="sit_job" id="flexRadioDefault3" value="직장인">
 						 <label class="form-check-label" for="sit_job">직장인</label>
					</div>
					<div class="form-check">
 						 <input class="form-check-input" type="radio" name="sit_job" id="flexRadioDefault4" value="프리랜서">
 						 <label class="form-check-label" for="sit_job">프리랜서</label>
					</div>
					<div class="form-check">
 						 <input class="form-check-input" type="radio" name="sit_job" id="flexRadioDefault5" value="구직자">
 						 <label class="form-check-label" for="sit_job">구직자</label>
					</div>
					<div class="form-check">
 						 <input class="form-check-input" type="radio" name="sit_job" id="flexRadioDefault6" value="" required>
 						 <label class="form-check-label" for="sit_job">직접 입력</label>
					</div>
					<input class="form-control" name="sit_job" id="sitter_others_input" placeholder="이곳에 직접 입력해주세요">
				</div>  <br><br>
				
				<hr />
				<h4>2. 활동 정보</h4>
				
				<div class="form-group">
					<label for="sit_days">활동 가능한 일수(한 달 기준)*</label>
					
					<div class="form-check2">
  						<input class="form-check-input" type="radio" name="sit_days" id="sitter_days1" value="주말 포함한 30일 모두 가능합니다." required>
 						 <label class="form-check-label" for="sit_days">주말 포함한 30일 모두 가능합니다.</label>
					</div>
					<div class="form-check2">
 						 <input class="form-check-input" type="radio" name="sit_days" id="sitter_days2" value="평균 20일 이상 가능합니다.">
 						 <label class="form-check-label" for="sit_days">평균 20일 이상 가능합니다.</label>
					</div>
					<div class="form-check2">
 						 <input class="form-check-input" type="radio" name="sit_days" id="sitter_days3" value="평균 20일 이하 가능합니다.">
 						 <label class="form-check-label" for="sit_days">평균 20일 이하 가능합니다.</label>
					</div>
					<div class="form-check2">
 						 <input class="form-check-input" type="radio" name="sit_days" id="sitter_days4" value="주말만 가능합니다.">
 						 <label class="form-check-label" for="sit_days">주말만 가능합니다.</label>  
 						  <br>
 						  <span class="sit_weekends">(방문 펫시터로 활동이 어려울 수 있습니다.)</span>						         
					</div>
				</div><br>
				
				<div class="form-group">
					<label for="sit_time">활동 가능한 시간대*</label>
					
					<div class="form-check3">
  						<input class="form-check-input" type="radio" name="sit_time" id="sitter_times1" value="모두 가능합니다" required>
 						 <label class="form-check-label" for="sit_time">모두 가능합니다.</label>
					</div>
					<div class="form-check3">
 						 <input class="form-check-input" type="radio" name="sit_time" id="sitter_times2" value="오전타임(오전8:00~오후12:00)">
 						 <label class="form-check-label" for="sit_time">오전타임(오전8:00~오후12:00)</label>
					</div>
					<div class="form-check3">
 						 <input class="form-check-input" type="radio" name="sit_time" id="sitter_times3" value="오후타임(오후12:00~오후06:00)">
 						 <label class="form-check-label" for="sit_time">오후타임(오후12:00~오후06:00)</label>
					</div>
				</div>
				
				<div class="form-group">
					<label for="sit_care_exp">[선택]타인의 반려동물을 돌봐준 경험</label>
					<textarea class="form-control" name="sit_care_exp" placeholder="그 외 반려동물 관련 경력 또는 경험에 대해서 알려주세요">더미</textarea>
					<p>04년생부터(만 18세 이상) 지원이 가능합니다.</p>
				</div> 
				


				<div class="form-group">
					<label for="sit_intro">자기소개*</label>
					<textarea class="form-control" name="sit_intro" placeholder="자기소개를 작성해주세요" required>더미2</textarea>
					<p>등록된 휴대폰 번호로 합격 여부를 알려드립니다..</p>
				</div> 
				
				<button type="submit" class="btn btn-primary btn-lg btn-block">보내기</button>
				
			</div>
		</form>
	</div>					
			
			
		
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>