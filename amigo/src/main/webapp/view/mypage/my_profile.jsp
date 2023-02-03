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
<style>
 .user-name {
 	  font-family: "Jalnan";
 	  font-size:20px;
 	  color:rgb(87, 160, 227);
  }
</style>
<title>Insert title here</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
   
   <%@include file="/includes/header.jsp" %>
       <!-- Profile nav -->
    <!-- user의 프로필 정보를 가져와야합니다. -->
    <form action="updateUser.do" method="post" enctype="multipart/form-data" onSubmit="return checkResult();">
    <div class="myProfileMainBox">
      <div class="container text-center">
          <a class="user-name"> ${ user.getUser_name() } </a> 님
        <!-- 이곳에 유저의 이름이 들어와야합니다. -->
        <h4>안녕하세요!</h4>
        </div>
        <!-- 프로필 사진 업로드 -->
        <div class="container">
          <div class="picture-container">
            <div class="picture">
            	          <c:choose>
				          	<c:when test="${user.getUser_photo()!=null and user.getUser_photo()!=''}">
				          		<img src="/img/${user.getUser_photo()}"
								 	 class="picture-src"
								 	 id="wizardPicturePreview"
								 	 title="">
				            </c:when>
				            <c:otherwise>
				            	<img src="https://lh3.googleusercontent.com/LfmMVU71g-HKXTCP_QWlDOemmWg4Dn1rJjxeEsZKMNaQprgunDTtEuzmcwUBgupKQVTuP0vczT9bH32ywaF7h68mF-osUSBAeM6MxyhvJhG6HKZMTYjgEv3WkWCfLB7czfODidNQPdja99HMb4qhCY1uFS8X0OQOVGeuhdHy8ln7eyr-6MnkCcy64wl6S_S6ep9j7aJIIopZ9wxk7Iqm-gFjmBtg6KJVkBD0IA6BnS-XlIVpbqL5LYi62elCrbDgiaD6Oe8uluucbYeL1i9kgr4c1b_NBSNe6zFwj7vrju4Zdbax-GPHmiuirf2h86eKdRl7A5h8PXGrCDNIYMID-J7_KuHKqaM-I7W5yI00QDpG9x5q5xOQMgCy1bbu3St1paqt9KHrvNS_SCx-QJgBTOIWW6T0DHVlvV_9YF5UZpN7aV5a79xvN1Gdrc7spvSs82v6gta8AJHCgzNSWQw5QUR8EN_-cTPF6S-vifLa2KtRdRAV7q-CQvhMrbBCaEYY73bQcPZFd9XE7HIbHXwXYA=s200-no"
								 	 class="picture-src"
								 	 id="wizardPicturePreview"
								 	 title="">
				            </c:otherwise>
				          </c:choose>

              <input type="file" name="uploadFile" id="wizard-picture" class="" aria-describedby="uploadFile" aria-label="Upload"/>
            </div>
            <h6 class="">사진업로드</h6>
          </div>
        </div>
        <!-- 프로필 사진 업로드 종료 -->
        <!-- profile nav end -->
      

      <!-- 프로필 상세 -->     
      <!-- 이메일 // 이메일 정보가 가져와져야합니다. -->
      <label for="userEmail" class="form-label">이메일 아이디</label>
      <div class="input-group mb-3">
        <input type="email" class="form-control" id="userEmail" name="user_email" value="${ user.getUser_email() }" disabled>
      </div>
      <!-- 이메일 end -->
      <!-- 닉네임 변경 // 유저의 닉네임을 불러와줘야합니다. -->
      <label for="userNickname" class="form-label">닉네임 변경</label>
      <div class="input-group mb-3">
        <input type="text" class="form-control" id="userNickname" name="user_nick" value="${ user.getUser_nick() }" onKeyup="checkNick();" check_nick="success">
      </div>
        <span id="confirmNick"></span><br>
      <!-- 닉네임 변경 end -->
      <!-- 비밀번호 변경 -->
      <label for="userPassword" class="form-label">비밀번호 변경</label>
      <div class="input-group mb-3">
        <input type="password" class="form-control" id="userPassword" name="user_pw" value="${ user.getUser_pw() }">
      </div>
      <!-- 비밀번호 변경 end -->
      <!-- 후대폰 번호 변경 -->
      <label for="userPhone" class="form-label">핸드폰 번호</label>
      <div class="input-group mb-3">
        <input type="tel" class="form-control" id="phone" name="user_phone" value="${ user.getUser_phone() }">
      </div>
       <!-- 후대폰 번호 변경 end -->
       <!-- 주소 변경 -->
       <!-- 다음 api 적용예정 -->

           <label for="sample4_roadAddress" class="sighup-group">내 주소</label><br>
           <div class="input-group mb-3">
               <input type="text" id="sample4_postcode" placeholder="우편번호">
               <input type="button" onclick="sample4_execDaumPostcode()" value="주소 찾기"><br>
               <input type="text" id="sample4_roadAddress" class="form-control" name="user_addr" value="${ user.getUser_addr() }">
            </div>
               <br><small>상세주소를 꼭 입력해주세요. 예약 시에 반영됩니다.</small>
                
                
            <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
            <script>
                //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
                function sample4_execDaumPostcode() {
                    new daum.Postcode({
                        oncomplete: function(data) {
                            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            
                            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                            var roadAddr = data.roadAddress; // 도로명 주소 변수
                            var extraRoadAddr = ''; // 참고 항목 변수
            
                            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                                extraRoadAddr += data.bname;
                            }
                            // 건물명이 있고, 공동주택일 경우 추가한다.
                            if(data.buildingName !== '' && data.apartment === 'Y'){
                               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                            if(extraRoadAddr !== ''){
                                extraRoadAddr = ' (' + extraRoadAddr + ')';
                            }
            
                            // 우편번호와 주소 정보를 해당 필드에 넣는다.
                            document.getElementById('sample4_postcode').value = data.zonecode;
                            document.getElementById("sample4_roadAddress").value = roadAddr;
                            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            
                            var guideTextBox = document.getElementById("guide");
                            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                            if(data.autoRoadAddress) {
                                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                                guideTextBox.style.display = 'block';
            
                            } else if(data.autoJibunAddress) {
                                var expJibunAddr = data.autoJibunAddress;
                                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                                guideTextBox.style.display = 'block';
                            } else {
                                guideTextBox.innerHTML = '';
                                guideTextBox.style.display = 'none';
                            }
                        }
                    }).open();
                }
            </script>
       
      </div>    
      
      <!-- 주소 변경 end -->
    <!-- 프로필 상세 end-->
    <div class="container text-center mb-5">
        <button class="btn btn-outline-secondary" type="submit">변경 완료</button>  
        <input type="hidden" name="user_no" value="${ user.getUser_no()}"/>
        <input type="hidden" name="user_email" value="${ user.getUser_email()}"/>
        <input type="hidden" name="user_name" value="${ user.getUser_name()}"/>
        <input type="hidden" name="user_type" value="${ user.getUser_type()}"/>
        <input type="hidden" name="user_photo" value="${ user.getUser_photo()}"/>
        

  </form>
  
			     <script type="text/javascript">
			     function checkResult() {
			     if ($('#userNickname').attr("check_nick") == "fail"){
							    alert("사용중인 닉네임입니다. 다른 닉네임을 입력하세요.");
							    $('#userNickname').focus();
							    return false;
			        } 
			     	return true;
			     }
			     </script>
			     
			     
  				<script>
				// 닉네임 중복체크
				function checkNick() {
					var user_nick = $('#userNickname').val();
					var confirmNick = document.getElementById('confirmNick');
					var correctColor = "#69abce";	//맞았을 때 출력되는 색깔.
					var wrongColor ="#ff0000";	    //틀렸을 때 출력되는 색깔
					$.ajax({
			            url:'nickCheck.do',       //Controller에서 요청 받을 주소
			            type:'post',              //POST 방식으로 전달
			            data:{user_nick:user_nick},
			            success:function(result){ //컨트롤러에서 넘어온 값을 받는다 
			                if(result != "fail"){ //result가 fail이 아니면 -> 사용 가능한 이메일
			                	confirmNick.style.color = correctColor;
			                	confirmNick.innerHTML = "사용 가능한 닉네임입니다.";
			                	$('#userNickname').attr("check_nick", "success");
			                } else { 
			                	confirmNick.style.color = wrongColor;
			                	confirmNick.innerHTML = "이미 존재하는 닉네임입니다.";
			                	$('#userNickname').attr("check_nick", "fail");
			                }
			            },
			            error:function(){
			                alert("에러입니다");
			            }
			        });
	              
				};
				</script>
    
    
    <!-- profile page 종료 -->
    <!-- Footer -->
    <footer class="bg-primary text-center text-white" style="background-color: rgb(87, 160, 227);>
      <!-- Grid container -->
      <!-- Grid container -->
      <!-- Copyright -->
      <div class="text-center p-3"">
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