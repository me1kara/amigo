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
<title>amigo_update</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
			<div class="container col-md-6">
	  <hr>
			<form role="form" action="updateDog.do" method="post" enctype="multipart/form-data">
		     
		    <c:if test="${dog.getDog_image_file()!=null and dog.getDog_image_file()!=''}">
				<div style="text-align: center" class="before_img_del"><img src="/dogimg/${dog.getDog_image_file()}" width="400px" height="400px"></div></c:if>
				    <input type="hidden" value="${dog.getDog_image_file()}"  name="dog_image_file">
            		<div style="text-align: center" id="msgTd"></div>
             <div class="form-group" style="width:90px; margin: 0 auto;" >
			        <label class="input-group-text" for="dog_image_file">사진변경</label>
				    <input type="file" style="display:none" class="form-control" onchange="previewFile()"
				    name="uploadFile" id="dog_image_file" aria-describedby="uploadFile" aria-label="Upload">
				    
			 </div>
	  <hr>
	         <div class="page-header">
	            <h3>업데이트</h3>	            
	         </div>

				
					<div class="form-group">
						<label for="dog_name">이름</label>
						<input type="text" name="dog_name" id="dog_name" class="form-control" value="${dog.getDog_name()}" required>
					</div>
						
					
					<div class="form-group">
					   <label for="female">성별</label>
							<div>
							  <input class="form-check-input" type="radio" name="dog_gender" id="female" value="f" ${dog.getDog_gender()=="f" ? "checked" : "" }>
							  <label class="form-check-label" for="female">여자아이</label>
							  <input class="form-check-input" type="radio" name="dog_gender" id="male" value="m" ${dog.getDog_gender()=="m" ? "checked" : "" }>
							  <label class="form-check-label" for="male">남자아이</label>
						    </div>
					 </div>
						
						
					<div class="form-group">
						<label for="dog_breeds">품종</label>
						<input type="text" name="dog_breeds" id="dog_breeds" class="form-control" value="${dog.getDog_breeds()}" required>
					</div>
						
					<div class="form-group">
						<label for="dog_birth">생일</label>
						<input type="date" name="dog_birth" id="dog_birth" class="form-control" value="${dog.getDog_birth()}" required>
					</div>
						
					<div class="form-group">
						<label for="dog_weight">몸무게(kg)</label>
						<input type="text" pattern="(^\d+$)|(^\d+\.\d{0,2}$)" name="dog_weight" id="dog_weight" class="form-control" value="${dog.getDog_weight()}" required>
					</div>
						
					<div class="form-group">
					   <label for="dog_neutered_yes">중성화</label>
						<div>
							 <input class="form-check-input" type="radio" name="dog_neutered" id="dog_neutered_yes" value="1" ${dog.isDog_neutered() == true ? "checked" : "" }>
							 <label class="form-check-label" for="dog_neutered_yes">했어요</label>
							 <input class="form-check-input" type="radio" name="dog_neutered" id="dog_neutered_no" value="0" ${dog.isDog_neutered() == false ? "checked" : "" }>
							 <label class="form-check-label" for="dog_neutered_no">안했어요</label>
						</div>
					</div>
					 
					<div class="form-group">
					   <label for="dog_rabies_vacc_yes">광견병 접종여부</label>
							<div>
							  <input class="form-check-input" type="radio" name="dog_rabies_vacc" id="dog_rabies_vacc_yes" value="1" ${dog.isDog_rabies_vacc() == true ? "checked" : "" }>
							  <label class="form-check-label" for="dog_rabies_vacc_yes">했어요</label>
							  <input class="form-check-input" type="radio" name="dog_rabies_vacc" id="dog_rabies_vacc_no" value="0" ${dog.isDog_rabies_vacc() == false ? "checked" : "" }>
							  <label class="form-check-label" for="dog_rabies_vacc_no">안했어요</label>
						    </div>
					</div>
	  <hr> 
					<div class="form-group">
					  <label for="dog_notice">우리강아지(성격 및 건강상태 등..)</label>
					  <textarea class="form-control" id="dog_notice" rows="5" name="dog_notice" required>${dog.getDog_notice()}</textarea>
					</div>
 
				
			 
		<!-- dog_no 벨류값 받아서 폼에 기입해야함-->
		<input class="form-control" type="hidden" name="dog_no" value="${dog.getDog_no()}">
				    
				<div class="text-center mb-5">           
				<button type="submit" class="btn btn-primary text-center">수정완료</button>
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
        $('.before_img_del').hide();
        $('.preview_img_del').remove();
      
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
     }
    function preview_del(){
        $('.preview_img_del').remove();
        $('#dog_image_file').val('');
        $('.before_img_del').show();
     }
	</script>

	
</body>
</html>