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
    
    
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container"  align="center">
		<div class="mt-4 p-5 bg-primary text-white rounded">
			<h3>게시글 등록</h3>		
		</div>
	</div>		

	<div class="container mt-3" align="center">
		<form action="user_board_insert.do" method="post" enctype="multipart/form-data">
			<input name="user_no" type="hidden" value="${user.user_no}" />
			<div class="input-group mb-3">
  			 <b>글제목</b> <input type="text" class="form-control" name="ubd_title" required>
			</div>
			<div class="input-group mb-3">
  			 <b>말머리</b> 
  			 	<select class="form-select" id="searchCategory" name="ubd_cate">							
				    <option value="자랑글">자랑글</option>						
				    <option value="자유글">자유글</option>							
				    <option value="Q&A">Q&A</option>										
				</select>
			</div>
			<div class="input-group mb-3">
			 <b>견종</b> <input type="text" class="form-control" name="dog_kind">
			</div>
			<div class="input-group mb-3">
			 <b>작성자</b> <input type="text" class="form-control"  name="user_nick" value="${ user.getUser_nick() }" readonly> 
			</div>
			<div class="input-group mb-3">
			  <b>글내용</b> <textarea class="form-control"  name="ubd_cont" rows="15" required></textarea>
			</div>	
			<div class="input-group mb-3">
			  <b>사진업로드</b>
			  <input type="button" value="파일 추가(최대 5개)" id="add" onclick="fn_addFile()" /><br>
			  <input type="button" value="파일삭제" id="remove" onclick="fn_removeFile()"/><br>
			</div>	
				<input type="file" name="uploadFile" multiple id="uploadFile" aria-describedby="uploadFile" aria-label="Upload"/>
			  <div id="d_file">
			  </div>
		    <script>
		    var cnt = 1;
		    var maxAppend = 1;
		    function fn_addFile(){
		    	if(maxAppend > 4) return;
		        $("#d_file").append("<br>" + "<input type='file' name='uploadFile' multiple id='uploadFile' aria-describedby='uploadFile' aria-label='Upload'" + cnt + " />");
		        cnt++;
		    	maxAppend++;
		    }
		    
			function fn_removeFile() {
				$("#uploadFile").remove();
				maxAppend--;
				cnt--;
				if(maxAppend==0){
					$("#d_file *").remove();
				}
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