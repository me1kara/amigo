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
<title>Insert title here</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
			<div class="container col-md-6">
	  <hr>
			<!-- insert폼 -->
			<form action="insertDog.do" method="post">
			
		    <!-- 사진등록 -->
			 <div class="form-group">
					<label for="dog_image_url">사진등록</label>
					<input type="file" name="dog_image_url" id="dog_image_url">
             </div>
			
	  <hr>
			<!-- 기본사항 : 이름,성별,품종,생일,몸무게,중성화,광견병,기타,동의 -->
			
	        <div class="page-header">
	            <h3>기본사항</h3>	            
	        </div>

			
					<div class="form-group">
						<label for="dog_name">이름</label>
						<input type="text" name="dog_name" id="dog_name" class="form-control" value="푸쿠" required placeholder="예) 댕댕이">
					</div>
						
					
					<div class="form-group">
					   <label for="female">성별</label>
							<div>
							  <input class="form-check-input" type="radio" name="dog_gender" id="female" value="f" checked>
							  <label class="form-check-label" for="female">여자아이</label>
							  <input class="form-check-input" type="radio" name="dog_gender" id="male" value="m" >
							  <label class="form-check-label" for="male">남자아이</label>
						    </div>
					 </div>
						
						
					<div class="form-group">
						<label for="dog_breeds">품종</label>
						<input type="text" name="dog_breeds" id="dog_breeds" class="form-control" value="시바" required placeholder="예) 말티즈">
					</div>
						
					<div class="form-group">
						<label for="dog_birth">생일</label>
						<input type="text" name="dog_birth" id="dog_birth" class="form-control" value="2023.01.17" required>  <!-- 나중에 타입 date로 바꿀것 -->
					</div>
						
					<div class="form-group">
						<label for="dog_weight">몸무게(kg)</label>
						<input type="text" name="dog_weight" id="dog_weight" class="form-control" value="6.25" required placeholder="소수점 두자리까지 입력하세요..">
					</div>
						
					<div class="form-group">
					   <label for="dog_neutered_yes">중성화</label>
						<div>
							 <input class="form-check-input" type="radio" name="dog_neutered" id="dog_neutered_yes" value="1" checked>
							 <label class="form-check-label" for="dog_neutered_yes">했어요</label>
							 <input class="form-check-input" type="radio" name="dog_neutered" id="dog_neutered_no" value="0">
							 <label class="form-check-label" for="dog_neutered_no">안했어요</label>
						</div>
					</div>
					 
					<div class="form-group">
					   <label for="dog_rabies_vacc_yes">광견병 접종여부</label>
							<div>
							  <input class="form-check-input" type="radio" name="dog_rabies_vacc" id="dog_rabies_vacc_yes" value="1" checked>
							  <label class="form-check-label" for="dog_rabies_vacc_yes">했어요</label>
							  <input class="form-check-input" type="radio" name="dog_rabies_vacc" id="dog_rabies_vacc_no" value="0">
							  <label class="form-check-label" for="dog_rabies_vacc_no">안했어요</label>
						    </div>
					</div>
	  <hr>
					<div class="form-group">
					  <label for="notice">우리강아지(성격 및 건강상태 등..)</label>
					  <textarea class="form-control" id="notice" rows="5" name="dog_notice" 
					   placeholder="펫시터에게 알려줘야할 사항들을 나열해주세요. 성격 및 건상상태를 알려주시면 됩니다.">임의입력 나중에 지울것.</textarea>                                                                       <!-- textarea내용 나중에 지울것 -->
					</div>
      <hr>
				
					<div class="form-check">
					  <input class="form-check-input" type="checkbox" name="dog_terms" id="terms" value="1" required checked>   <!--  check 나중에 지울것 -->
					  <label class="form-check-label" for="terms">아래 내용을 확인하였습니다.</label>
					  <p>위 내용(예. 몸무게, 마킹 등)을 사실과 다르게 기재한 경우, 약관에 따라 서비스 이용이 거부될 수 있습니다.</p>
					</div>
					
					 
		<!-- user_no 벨류값 받아서 폼에 기입해야함 (현재 임의로 1 넣음)-->
		<input class="form-control" type="hidden" name="user_no" value="1">
				    
				<div class="col-md-6 text-center">
				<button type="submit" class="btn btn-primary text-center">등록완료</button>
			    </div>
		</form>
	 </div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>