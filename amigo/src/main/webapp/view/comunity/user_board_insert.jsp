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
<title>게시판03_유저글작성(커뮤니티)</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
    
    <style>
    .insert-user-name{
    	color:#498dcc;
    	font-weight:bold;
    }
    	
    </style>
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
	<div class="container mt-5" align="center">
		<form action="user_board_insert.do" method="post" enctype="multipart/form-data" onSubmit="return checkResult()">
		
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
			<!-- 글제목 -->
  			<!--   <span class="insert-font">글제목</span>&nbsp;&nbsp; -->
  			<!-- 글제목 label로 해서 폼을 둥글게 만들어줌. -->
  			 <label for="ubd_title" class="col-md-1 control-label" style="font-size:18px; font-weight:bold;" >글제목&nbsp;</label>
  			 <div class="col">
  			 <input type="text" class="form-control" name="ubd_title" id="ubd_title" required>
  			 </div>  			 
  			 <!-- 글제목 끝 -->
			</div>
			<div class="input-group mb-3">
			<label for="searchCategory" class="col-md-1 control-label" style="font-size:18px; font-weight:bold;">말머리&nbsp;</label>
			 <div class="col-3">
  			 	<select class="form-select" id="searchCategory" name="ubd_cate">							
				    <option value="자랑글">자랑글</option>						
				    <option value="자유글">자유글</option>							
				    <option value="Q&A">Q&A</option>										
				</select>
			</div>
			<!--  견종  --> 
			<!--  <span class="insert-font">견종</span>&nbsp;&nbsp; -->
			  <label for="dog_kind" class="col-md-1 control-label" style="font-size:18px; font-weight:bold;">&nbsp;견종&nbsp;</label>
			   <div class="col">
			  <input type="text" class="form-control" id="dog_kind" name="dog_kind">
			  </div>
			  <!--  견종  끝 --> 
			</div>
			<!-- 작성자  -->
			<div class="input-group mb-3">
			 <span class="insert-font col-md-1" style="font-size:18px; font-weight:bold;" >작성자 :</span> &nbsp;<p class="insert-user-name">${ user.getUser_nick() }</p>
			</div>
			<!-- 작성자  끝 -->
			<!-- 상단 끝 -->
			
			<hr/>
			<div class="input-group mb-3">
			   <textarea class="form-control" id="ubd_cont" name="ubd_cont" rows="15" placeholder="글 내용을 입력하세요.." required ></textarea>		 
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
			<div class="row justify-content-evenly mt-5 mb-5">
				<input type="button" class="btn btn-primary col-2" value="취소" onclick="history.go(-1)"/>
				<input type="submit" class="btn btn-primary col-2" value="등록완료"/>
			</div>
		</form>			
	</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>