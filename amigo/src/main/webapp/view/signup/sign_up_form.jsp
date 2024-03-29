<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html lang="en">
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
    <link rel="stylesheet" type="text/css" href="/resources/css/style.css" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>main</title>
    <style>
    .page-header{
    	margin-bottom:20px;
    }
    
    /* 환영합니다 글씨 조절 */
   	.page-header {
   		text-align:center;
   		margin-bottom:30px;
   	}
   	
   	.signup-header{
   		color:rgb(89, 139, 198);
   		margin-bottom:10px;
   		font-family: 'Jalnan';
   		font-size:25px;
   	}
   	
   	.sighup-group {
   		font-family: 'Jalnan';
   	}
   	
   	  .form-group {
  	  margin-top: 20px;
  }
  
    #sample4_postcode, #sample4_find {
  	margin: 5px 0;	
  	font-size:12pt;
  	border : 1px solid #CED4DA; 
  	border-radius: 5px;
  	height : 30px;
  }
  
  	#email_auth_btn, #email_auth_key {
  	margin: 5px 0;	
  	font-size:12pt;
  	border : 1px solid #CED4DA; 
  	border-radius: 5px;
  	height : 30px;
  	}
   	
   	
   	
   	
   	/* 인증번호 버튼,폼 */
  	
  	#email_auth_btn{

  	}
    
    </style>
  </head>
  <body>
    <!-- header -->
    <div class="container text-center mb-5">
    <a href="/home.jsp">
      <img alt="AmigoLogo" src="/resources/img/logo1.png"/>
    </a>
    </div>
    
    <!-- header end  -->

    <article class="container">
        <div class="page-header">
            <div>
            <h4 class="signup-header">AM!GO에 오신걸 환영합니다!</h4>
            <h4>회원님의 정보를 입력해주세요.</h4>
            </div>
        </div>
        <div class="container col-md-6">
            <form role="form" action="signup.do" method="post" onSubmit="return checkResult();">
                <div class="form-group">
                    <label for="user_email" class="sighup-group">이메일주소*</label>
                    <input type="email" class="form-control" id="user_email" name="user_email" placeholder="이메일 주소" onchange="checkEmail();" check_email="fail" required>
                    <span id="confirmEmail"></span>
               	 </div>
                    <!-- 인증 시스템 -->
                    <button type="button" id="email_auth_btn" class="email_auth_btn" style="width: 130px;">인증번호 받기</button>
                    <input type="text" placeholder="인증번호 입력" id="email_auth_key" style="padding-left: 10px;" onchange="email_auth_Confirm();" disabled>
                	<!-- 인증 시스템/ -->
                <div class="form-group">
                    <label for="password" class="sighup-group">비밀번호*</label>
                    <input type="password" class="form-control" id="password" name="user_pw" placeholder="비밀번호" required>
                </div>
                <div class="form-group">
                    <label for="passwordCheck" class="sighup-group">비밀번호 확인*</label>
                    <input type="password" class="form-control" id="passwordCheck" placeholder="비밀번호 확인을 위해 다시 한 번 입력 해 주세요" onkeyup="passConfirm();" check_pw="fail">
                     <span id="confirmMsg"></span>

                     
         			<script type="text/javascript">  
    				/* 자바 스크립트 함수 선언(이메일 중복 확인) */
					  		 $("#email_auth_btn").click(function(){	 
					  		 $("#email_auth_key").attr("disabled", false);
					    	 var user_email = $('#user_email').val();
					    	 
					    	 if(user_email == ''){
					    	 	alert("이메일을 입력해주세요.");
					    	 	return false;
					    	 }
					    	 
					    	 $.ajax({
								type : "post",
								url : "emailAuth.do",
								data : {user_email : user_email},
								success: function(data){
									alert("인증번호가 발송되었습니다.");
									email_auth_cd = data;
								},
								error: function(data){
									alert("메일 발송에 실패했습니다.");
								}
							}); 
						});
  				</script>
  				
                <script>
                    function email_auth_Confirm() {
                    if($('#email_auth_key').val() != email_auth_cd){
            				alert("인증번호가 일치하지 않습니다.");
            			} else {
            				alert("인증번호 확인완료");
            			}
                    }
                </script>                  
  				
				<script type="text/javascript">
				/* 자바 스크립트 함수 선언(비밀번호 확인) */
				
				function passConfirm() {
				/* 비밀번호, 비밀번호 확인 입력창에 입력된 값을 비교해서 같다면 비밀번호 일치, 그렇지 않으면 불일치 라는 텍스트 출력.*/
				/* document : 현재 문서를 의미함. 작성되고 있는 문서를 뜻함. */
				/* getElementByID('아이디') : 아이디에 적힌 값을 가진 id의 value를 get을 해서 password 변수 넣기 */
					var password = document.getElementById('password');					//비밀번호 
					var passwordConfirm = document.getElementById('passwordCheck');	//비밀번호 확인 값
					var confrimMsg = document.getElementById('confirmMsg');				//확인 메세지
					var correctColor = "#69abce";	//맞았을 때 출력되는 색깔.
					var wrongColor ="#ff0000";	//틀렸을 때 출력되는 색깔
					
					if(password.value == passwordConfirm.value){//password 변수의 값과 passwordConfirm 변수의 값과 동일하다.
						confirmMsg.style.color = correctColor;/* span 태그의 ID(confirmMsg) 사용  */
						confirmMsg.innerHTML ="비밀번호가 일치합니다.";/* innerHTML : HTML 내부에 추가적인 내용을 넣을 때 사용하는 것. */
						$('#passwordCheck').attr("check_pw", "success");
					}else{
						confirmMsg.style.color = wrongColor;
						confirmMsg.innerHTML ="비밀번호가 일치하지 않습니다.";
						$('#passwordCheck').attr("check_pw", "fail");
					}
				};
				</script>
				
				<script>
				// 이메일 중복체크
				function checkEmail() {
					var user_email = $('#user_email').val();
					var confirmEmail = document.getElementById('confirmEmail');
					var correctColor = "#69abce";	//맞았을 때 출력되는 색깔.
					var wrongColor ="#ff0000";	//틀렸을 때 출력되는 색깔
					$.ajax({
			            url:'emailCheck.do', //Controller에서 요청 받을 주소
			            type:'post', //POST 방식으로 전달
			            data:{user_email:user_email},
			            success:function(result){ //컨트롤러에서 넘어온 값을 받는다 
			                if(result != "fail"){ //result가 'fail'이 아니면 -> 사용 가능한 이메일
			                	confirmEmail.style.color = correctColor;
			                	confirmEmail.innerHTML = "사용 가능한 이메일입니다.";
			                	$('#user_email').attr("check_email", "success");
			                } else { // fail리면 -> 이미 존재하는 이메일
			                	confirmEmail.style.color = wrongColor;
			                	confirmEmail.innerHTML = "이미 존재하는 이메일입니다.";
			                	$('#user_email').attr("check_email", "fail");
			                }
			            },
			            error:function(){
			                alert("에러입니다");
			            }
			        });
	              
				};
				</script>
				
				<script>
				// 닉네임 중복체크
				function checkNick() {
					var user_nick = $('#user_nick').val();
					var confirmNick = document.getElementById('confirmNick');
					var correctColor = "#69abce";	//맞았을 때 출력되는 색깔.
					var wrongColor ="#ff0000";	//틀렸을 때 출력되는 색깔
					$.ajax({
			            url:'nickCheck.do', //Controller에서 요청 받을 주소
			            type:'post', //POST 방식으로 전달
			            data:{user_nick:user_nick},
			            success:function(result){ //컨트롤러에서 넘어온 값을 받는다 
			                if(result != "fail"){ //result가 fail이 아니면 -> 사용 가능한 이메일
			                	confirmNick.style.color = correctColor;
			                	confirmNick.innerHTML = "사용 가능한 닉네임입니다.";
			                	$('#user_nick').attr("check_nick", "success");
			                } else { 
			                	confirmNick.style.color = wrongColor;
			                	confirmNick.innerHTML = "이미 존재하는 닉네임입니다.";
			                	$('#user_nick').attr("check_nick", "fail");
			                }
			            },
			            error:function(){
			                alert("에러입니다");
			            }
			        });
	              
				};
				</script>
                <div class="form-group">
                    <label for="user_name" class="sighup-group">이름*</label>
                    <input type="text" class="form-control" id="user_name" name="user_name" placeholder="이름" required>
                </div>
                <div class="form-group">
                    <label for="user_nick" class="sighup-group">닉네임*</label>
                    <input type="text" class="form-control" id="user_nick" name="user_nick" placeholder="닉네임" check_nick="fail" onchange="checkNick();" required>
                    <span id="confirmNick"></span>
                </div>    
                    
                 <div class="form-group">
                 <label for="sample4_roadAddress" class="sighup-group">주소*</label><br>
               <input type="text" id="sample4_postcode" style="padding-left: 10px;" placeholder="우편번호" disabled>
               <input type="button" onclick="sample4_execDaumPostcode()" id="sample4_find" style="width: 100px;" value="주소 찾기"><br>
               <input type="text" id="sample4_roadAddress" class="form-control" name="user_addr" placeholder="도로명주소" disabled>
               <input type="hidden" id="sample4_jibunAddress" class="form-control" placeholder="지번주소" required>
               <span id="guide" style="color:#999;display:none"></span>
               <input type="text" id="sample4_detailAddress" class="form-control" name="user_addr2" placeholder="상세주소" required>
                </div>
                
                
            <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
            <script>
                //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
                function sample4_execDaumPostcode() {
                	$("#sample4_postcode").attr("disabled", false);
                	$("#sample4_roadAddress").attr("disabled", false);
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
            
                <div class="form-group">
                    <label for="inputMobile" class="sighup-group">전화번호*</label>
                    <input type="tel" class="form-control" id="inputMobile" name="user_phone" placeholder="휴대폰번호" required>
                </div>
                </div>
                <br/>
                <div class="form-group text-center">
                    <input type="submit" id="join-submit" class="btn btn-primary"  value="다음으로" >
                </div>
                
                
                <!-- 폼 전송 전 유효성 검사 -->
                <script>
                function checkResult() {
                	
                if ($('#user_email').attr("check_email") == "fail"){
				    alert("사용중인 이메일입니다. 다른 이메일을 입력하세요.");
				    $('#user_email').focus();
				    return false;
                } 
                
                if ($('#user_nick').attr("check_nick") == "fail"){
				    alert("사용중인 닉네임입니다. 다른 닉네임을 입력하세요.");
				    $('#user_nick').focus();
				    return false;
                } 
                
                if ($('#passwordCheck').attr("check_pw") == "fail"){
				    alert("비밀번호를 확인해주시기 바랍니다.");
				    $('#passwordCheck').focus();
				    return false;
                }
                
                if($('#email_auth_key').val() == '' || $('#email_auth_key').val() != email_auth_cd ){
        			alert("이메일 인증을 해주시기 바랍니다.");
        			$('#email_auth_key').focus();
        			return false;
                }       
                
                if($("#sample4_postcode").val() == '' || $("#sample4_roadAddress").val() == ''){
                	alert("주소 찾기를 통해 주소를 입력해주시기 바랍니다.");
                	return false;
                }
                
                	return true;
                }
                </script>                
		</form>
        </div>
    </article>
    
    <%@include file="/includes/footer.jsp" %>
</body>
</html>
    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    

    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
    <![endif]-->
  </body>
</html>
