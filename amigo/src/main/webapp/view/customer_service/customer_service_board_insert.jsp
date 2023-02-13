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
<title>질문02_질문작성</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
			<div class="container"  align="center">
		<div class="mt-4 p-5 bg-primary text-white rounded">
			<h3>질문글 등록</h3>		
		</div>
	</div>		

	<div class="container mt-3" align="center">
		<form action="customer_service_board_insert.do" method="post" enctype="multipart/form-data" onSubmit="return checkResult()">
		
			<script>
			function checkResult() {
            	
			if($('#uploadFile1').val() == ""){
        			alert("파일을 모두 업로드해주세요.");
        			return false;
        		}
			if($('#uploadFile2').val() == ""){
    			alert("파일을 모두 업로드해주세요.");
    			return false;
    		}
			if($('#uploadFile3').val() == ""){
    			alert("파일을 모두 업로드해주세요.");
    			return false;
    		}
			if($('#uploadFile4').val() == ""){
    			alert("파일을 모두 업로드해주세요.");
    			return false;
    		}
			if($('#uploadFile5').val() == ""){
    			alert("파일을 모두 업로드해주세요.");
    			return false;
    		}
                	return true;
			}
          	</script>
			<input name="user_no" type="hidden" value="${user.user_no}" />
			<div class="input-group mb-3">
  			 <b>글제목</b> <input type="text" class="form-control" name="ubd_title" required>
			</div>
			<div class="input-group mb-3">
			 <b>작성자</b> <input type="text" class="form-control"  name="user_nick" value="${ user.getUser_nick() }" readonly> 
			</div>
			<div class="input-group mb-3">
			  <b>글내용</b> <textarea class="form-control"  name="ubd_cont" rows="15" required></textarea>
			</div>	
			
			  <b>사진업로드(최대 5장)</b><br>
			  <div id = "div1">
			  <input type="file" name="uploadFile" multiple id="uploadFile1" aria-describedby="uploadFile" aria-label="Upload"/><input type="button" value="제거" id="uf1" onclick="remove1()"><br>
			  </div>
			  <div id = "div2">
			  <input type="file" name="uploadFile" multiple id="uploadFile2" aria-describedby="uploadFile" aria-label="Upload"/><input type="button" value="제거" id="uf2" onclick="remove2()"><br>
			  </div>
			  <div id = "div3">
			  <input type="file" name="uploadFile" multiple id="uploadFile3" aria-describedby="uploadFile" aria-label="Upload"/><input type="button" value="제거" id="uf3" onclick="remove3()"><br>
			  </div>
			  <div id = "div4">
			  <input type="file" name="uploadFile" multiple id="uploadFile4" aria-describedby="uploadFile" aria-label="Upload"/><input type="button" value="제거" id="uf4" onclick="remove4()"><br>
			  </div>
			  <div id = "div5">
			  <input type="file" name="uploadFile" multiple id="uploadFile5" aria-describedby="uploadFile" aria-label="Upload"/><input type="button" value="제거" id="uf5" onclick="remove5()"><br>
			  </div>	
			  <script type="text/javascript">
			  // <input type="button" name="fileAdd" value="파일추가" onclick="add();"/>
			  // var inputfile = "<input type="file" name="uploadFile" multiple id="uploadFile1" aria-describedby="uploadFile" aria-label="Upload"/><input type="button" value="제거" id="uf1" onclick="remove1()"><br><input type="file" name="uploadFile" multiple id="uploadFile2" aria-describedby="uploadFile" aria-label="Upload"/><input type="button" value="제거" id="uf2" onclick="remove2()"><br><input type="file" name="uploadFile" multiple id="uploadFile3" aria-describedby="uploadFile" aria-label="Upload"/><input type="button" value="제거" id="uf3" onclick="remove3()"><br><input type="file" name="uploadFile" multiple id="uploadFile4" aria-describedby="uploadFile" aria-label="Upload"/><input type="button" value="제거" id="uf4" onclick="remove4()"><br><input type="file" name="uploadFile" multiple id="uploadFile5" aria-describedby="uploadFile" aria-label="Upload"/><input type="button" value="제거" id="uf5" onclick="remove5()"><br>";
			  //function add() {
			  //		$('#d_file').append("<input type='file' name='uploadFile' multiple id='uploadFile1' aria-describedby='uploadFile' aria-label='Upload'/><input type='button' value='제거' id='uf1' onclick='remove1()''><br><input type='file' name='uploadFile' multiple id='uploadFile2' aria-describedby='uploadFile' aria-label='Upload'/><input type='button' value='제거' id='uf2' onclick='remove2()''><br><input type='file' name='uploadFile' multiple id='uploadFile3' aria-describedby='uploadFile' aria-label='Upload'/><input type='button' value='제거' id='uf3' onclick='remove3()''><br><input type='file' name='uploadFile' multiple id='uploadFile4' aria-describedby='uploadFile' aria-label='Upload'/><input type='button' value='제거' id='uf4' onclick='remove4()''><br><input type='file' name='uploadFile' multiple id='uploadFile5' aria-describedby='uploadFile' aria-label='Upload'/><input type='button' value='제거' id='uf5' onclick='remove5()''><br>");
			  //	}
			  </script>
			<script type="text/javascript">
			
			function remove1() {
				$('#div1').remove();
				$('#uf1').remove();
			}
			function remove2() {
				$('#div2').remove();
				$('#uf2').remove();
			}
			function remove3() {
				$('#div3').remove();
				$('#uf3').remove();
			}
			function remove4() {
				$('#div4').remove();
				$('#uf4').remove();
			}
			function remove5() {
				$('#div5').remove();
				$('#uf5').remove();
			}
			</script>
		  
			<input type="hidden" name="ubd_file" value=""/>	
			<div class="container" align="center">
				<input type="submit" class="btn btn-primary mt-3" value="등록완료"/>
				<input type="button" class="btn btn-primary mt-3" value="취소" onclick="history.go(-1)"/>
			</div>
		</form>			
	</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>