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
<title>게시판06_유저글수정폼(커뮤니티)</title>
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

	<div class="container mt-3" align="center">
		<form action="user_board_update.do" method="post" enctype="multipart/form-data">
					<input name="user_no" type="hidden" value="${user.user_no}" />
			<div class="input-group mb-3">
			<!-- 글제목 -->
  			<!--   <span class="insert-font">글제목</span>&nbsp;&nbsp; -->
  			<!-- 글제목 label로 해서 폼을 둥글게 만들어줌. -->
  			 <label for="ubd_title" class="col-md-1 control-label" style="font-size:18px; font-weight:bold;" >글제목&nbsp;</label>
  			 <div class="col">
  			 <input type="text" class="form-control" name="ubd_title" id="ubd_title" value="${ board.ubd_title }">
  			 </div>  			 
  			 <!-- 글제목 끝 -->
			</div>
			<div class="input-group mb-3">
			<label for="searchCategory" class="col-md-1 control-label" style="font-size:18px; font-weight:bold;" >말머리&nbsp;</label>
			 <div class="col-3">
  			 	<select class="form-select" id="searchCategory" name="ubd_cate" value="${ board.ubd_cate }">							
				    <option value="자랑글">자랑글</option>						
				    <option value="자유글">자유글</option>							
				    <option value="Q&A">Q&A</option>										
				</select>
			</div>
			<!--  견종  --> 
			<!--  <span class="insert-font">견종</span>&nbsp;&nbsp; -->
			  <label for="dog_kind" class="col-md-1 control-label" style="font-size:18px; font-weight:bold;">&nbsp;견종&nbsp;</label>
			   <div class="col">
			  <input type="text" class="form-control" id="dog_kind" name="dog_kind" value="${ board.dog_kind }"  >
			  </div>
			  <!--  견종  끝 --> 
			</div>
			<!-- 작성자  -->
			<div class="input-group mb-3">
			 <span class="insert-font col-md-1" style="font-size:18px; font-weight:bold;" >작성자 :</span> &nbsp;<p class="insert-user-name" style="font-size:18px; font-weight:bold;" readonly>${ user.getUser_nick() }</p>
			</div>
			<!-- 작성자  끝 -->
			<!-- 상단 끝 -->
			
			<hr/>
			
			<div class="input-group mb-3">
			   <textarea class="form-control" id="ubd_cont" name="ubd_cont" rows="15" required >${ board.ubd_cont }</textarea>		 
			</div>	
			<div class="input-group mb-3">
			 <b>사진업로드</b><input type="button" value="파일 추가(최대 5개)" id="add" onclick="fn_addFile()" /><br>
			  <input type="button" value="파일삭제" id="remove" onclick="fn_removeFile()"/><br>
			</div>	
			  <div id="d_file">
			  </div>
			<script>
		    var cnt = 1;
		    var maxAppend = 1;
		    function fn_addFile(){
		    	if(maxAppend > 5) return;
		        $("#d_file").append("<br>" + "<input type='file' name='uploadFile' multiple id='uploadFile' aria-describedby='uploadFile' aria-label='Upload'" + cnt + " />");
		        cnt++;
		    	maxAppend++;
		    }
		    
			function fn_removeFile() {
				$("#uploadFile").remove();
				maxAppend--;
				cnt--;
				if(maxAppend==1){
					$("#d_file *").remove();
				}
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