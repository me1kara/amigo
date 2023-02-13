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
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css" href="../resources/css/style.css" />
<title>amigo_insert</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
    
<style>
	.form-group {
		margin-top:20px;
	}

	.Dtitle {
		margin-bottom:5px;
		font-family: "Jalnan";
	}

</style>    
   
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
			<div class="container mt-5">
	  <hr>
			<form role="form" action="insertDog.do" method="post" enctype="multipart/form-data">
		     
             		<div style="text-align: center" id="msgTd"></div>
             <div class="form-group" style="width:90px; margin: 0 auto;" >             		
			        <label class="input-group-text" for="dog_image_file">사진등록</label>
				    <input type="file" style="display:none" class="form-control" onchange="previewFile()"
				     name="uploadFile" id="dog_image_file" aria-describedby="uploadFile" aria-label="Upload">
			 </div>
	  <hr>
	         <div class="page-header">
	            <h3 style="font-family: 'Jalnan';">기본사항</h3>	            
	         </div>

			
					<div class="form-group">
						<label for="dog_name" class="Dtitle">이름</label>
						<input type="text" name="dog_name" id="dog_name" class="form-control" required placeholder="예) 댕댕이">
					</div>
						
					
					<div class="form-group">
					   <label class="Dtitle">성별</label>
							<div>
							  <input class="form-check-input" type="radio" name="dog_gender" id="female" value="f" checked>
							  <label class="form-check-label" for="female">여자아이</label>
							  <input class="form-check-input" type="radio" name="dog_gender" id="male" value="m" >
							  <label class="form-check-label" for="male">남자아이</label>
						    </div>
					 </div>
						
						
					<div class="form-group">
						<label for="dog_breeds" class="Dtitle">품종</label>
						<input type="text" name="dog_breeds" id="dog_breeds" class="form-control" required>
					</div>
						
					<div class="form-group">
						<label for="dog_birth" class="Dtitle">생일</label>
						<input type="date" name="dog_birth" id="dog_birth" class="form-control" required>
					</div>
						
					<div class="form-group">
						<label for="dog_weight" class="Dtitle">몸무게(kg)</label>
						<input type="text" pattern="(^\d+$)|(^\d+\.\d{0,2}$)" name="dog_weight" id="dog_weight" class="form-control" placeholder="소수점두자리 숫자로 입력해주세요. 예) 6.01 / 7 / 3.4 등 " required>
					</div>
						
					<div class="form-group">
					   <label class="Dtitle">중성화</label>
						<div>
							 <input class="form-check-input" type="radio" name="dog_neutered" id="dog_neutered_yes" value="1" checked>
							 <label class="form-check-label" for="dog_neutered_yes">했어요</label>
							 <input class="form-check-input" type="radio" name="dog_neutered" id="dog_neutered_no" value="0">
							 <label class="form-check-label" for="dog_neutered_no">안했어요</label>
						</div>
					</div>
					 
					<div class="form-group">
					   <label class="Dtitle">광견병 접종여부</label>
							<div>
							  <input class="form-check-input" type="radio" name="dog_rabies_vacc" id="dog_rabies_vacc_yes" value="1" checked>
							  <label class="form-check-label" for="dog_rabies_vacc_yes">했어요</label>
							  <input class="form-check-input" type="radio" name="dog_rabies_vacc" id="dog_rabies_vacc_no" value="0">
							  <label class="form-check-label" for="dog_rabies_vacc_no">안했어요</label>
						    </div>
					</div>
	  <hr> 
					<div class="form-group">
					  <label for="dog_notice" class="Dtitle">우리강아지(성격 및 건강상태 등..)</label>
					  <textarea class="form-control" id="dog_notice" rows="5" name="dog_notice" 
					   placeholder="펫시터에게 알려줘야할 사항들을 나열해주세요. 성격 및 건상상태를 알려주시면 됩니다." required></textarea>
					</div>
      <hr>
				
					<div class="form-check">
					  <input class="form-check-input" type="checkbox" name="dog_terms" id="terms" value="1" required>
					  <label class="form-check-label" for="terms">아래 내용을 확인하였습니다.</label>
					  <p>위 내용(예. 몸무게, 마킹 등)을 사실과 다르게 기재한 경우, 약관에 따라 서비스 이용이 거부될 수 있습니다.</p>
					</div>
					
					 
		<!-- user_no 벨류값 받아서 폼에 기입-->
		<input class="form-control" type="hidden" name="user_no" value="${ sessionScope.user.getUser_no()}">
				    
				<div class="col-md-6 text-center" style="width:100px; margin: 0 auto; margin-top:50px;">           
				<button type="submit" class="btn btn-primary text-center">등록완료</button>
			    </div>
		</form>
	 </div>
	<%@include file="/includes/footer.jsp" %>
	
	<!-- 이미지 프리뷰 -->
	<script>
	function previewFile() {
        var preview = $('#msgTd');
        var file = document.querySelector('input[type=file]').files[0];
        var reader = new FileReader();
        preview_del();
        reader.addEventListener(
          'load',
              function () {
                 preview.append("<img src="+reader.result+" width='400px' height='400px' class='preview_img_del'/><br>");
                 preview.append("<button class='btn btn-danger preview_img_del' onclick='preview_del()'>이미지삭제</button>");
                },false
         );
      
        if (file) {
          reader.readAsDataURL(file);
        }
        console.log(previewFile(this));
     }
    function preview_del(){
        $('.preview_img_del').remove();
        $('#dog_image_file').val('');
     }
	</script>
	
</body>
</html>