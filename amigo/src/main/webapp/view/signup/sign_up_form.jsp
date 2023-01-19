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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" type="text/css" href="../resources/css/style.css" />
    <title>main</title>
  </head>
  <body>
    <!-- header -->
    <div class="container text-center">
      <img alt="AmigoLogo" src="img/logo1.png" />
    </div>
    <!-- header end  -->

    <article class="container">
        <div class="page-header">
            <div class="col-md-6 col-md-offset-3">
            <h3>이메일과 비밀번호를 입력하세요</h3>
            </div>
        </div>
        <div class="col-sm-6 col-md-offset-3">
            <form role="form" action="signup.do" method="post" onSubmit="return checkResult();">
                <div class="form-group">
                    <label for="inputName">이메일주소*</label>
                    <input type="email" class="form-control" id="user_email" name="user_email" placeholder="이메일 주소" onchange="checkEmail();" check_email="fail" required>
                    <span id="confirmEmail"></span>
                </div>
                <div class="form-group">
                    <label for="InputEmail">비밀번호*</label>
                    <input type="password" class="form-control" id="password" name="user_pw" placeholder="비밀번호" required>
                </div>
                <div class="form-group">
                    <label for="inputPasswordCheck">비밀번호 확인*</label>
                    <input type="password" class="form-control" id="passwordCheck" placeholder="비밀번호 확인을 위해 다시 한 번 입력 해 주세요" onkeyup="passConfirm();" check_pw="fail">
                     <span id="confirmMsg"></span>

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
					}
				};
				</script>
				
				<script>
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
			                if(result != "fail"){ //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 이메일
			                	confirmEmail.style.color = correctColor;
			                	confirmEmail.innerHTML = "사용 가능한 이메일입니다.";
			                	$('#user_email').attr("check_email", "success");
			                } else { // cnt가 1일 경우 -> 이미 존재하는 이메일
			                	confirmEmail.style.color = wrongColor;
			                	confirmEmail.innerHTML = "이미 존재하는 이메일입니다.";
			                }
			            },
			            error:function(){
			                alert("에러입니다");
			            }
			        });
	              
				};
				</script>

                <div class="col-md-6 col-md-offset-3">
                    <h3>기본정보</h3>
                    </div>
                <div class="form-group">
                    <label for="inputName">이름*</label>
                    <input type="text" class="form-control" id="inputName" name="user_name" placeholder="이름" required>
                </div>
                <div class="form-group">
                    <label for="inputName">닉네임*</label>
                    <input type="text" class="form-control" id="inputName" name="user_nick" placeholder="닉네임" required>
                </div>
                <div class="form-group">
                    <label for="inputAddr">주소*</label>
                    <input type="text" class="form-control" id="inputAddr" name="user_addr" placeholder="거주지주소" required>
                    <span>시/군/구까지 입력해주세요.</span>
                </div>
                <div class="form-group">
                    <label for="inputMobile">전화번호*</label>
                    <input type="tel" class="form-control" id="inputMobile" name="user_phone" placeholder="휴대폰번호" required>
                </div>
                </div>
                <br/>
                <div class="form-group text-center">
                    <input type="submit" id="join-submit" class="btn btn-primary"  value="다음으로" >
                </div>
                <script>
                function checkResult() {
                	
                if ($('#user_email').attr("check_email") == "fail"){
				    alert("이메일 중복체크를 해주시기 바랍니다.");
				    $('#user_email').focus();
				    return false;
                } 
                if ($('#passwordCheck').attr("check_pw") == "fail"){
				    alert("비밀번호를 확인해주시기 바랍니다.");
				    $('#passwordCheck').focus();
				    return false;
                } 
                	return true;
                
                }
          
                </script>
                
		</form>
        </div>
 
    </article>
</body>
</html>

    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="resources/js/script.js"></script>

    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
    <![endif]-->
  </body>
</html>
