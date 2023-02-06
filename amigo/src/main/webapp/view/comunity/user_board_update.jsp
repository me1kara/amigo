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
    <!-- far fa icon 불러오기 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css"></link>
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
		<form action="user_board_update.do" method="post" enctype="multipart/form-data" onSubmit="return checkResult()">
			<input name="ubd_no" type="hidden" value="${board.ubd_no}" />
			<input name="curPage" type="hidden" value="${searchVO.getCurPage()}"/>
			<input name="rowSizePerPage" type="hidden" value="${searchVO.getRowSizePerPage()}"/>
			<input name="searchType" type="hidden" value="${searchVO.getSearchType()}"/>
			<input name="searchWord" type="hidden" value="${searchVO.getSearchWord()}"/>
			<input name="cnt" type="hidden" value="${cnt}"/>

			<div class="input-group mb-3">
			<!-- 글제목 -->
  			<!--   <span class="insert-font">글제목</span>&nbsp;&nbsp; -->
  			<!-- 글제목 label로 해서 폼을 둥글게 만들어줌. -->
  			 <label for="ubd_title" class="col-md-1 control-label" style="font-size:18px; font-weight:bold;" >글제목&nbsp;</label>
  			 <div class="col">
  			 <input type="text" class="form-control" name="ubd_title" id="ubd_title" value="${ board.getUbd_title() }">
  			 </div>  			 
  			 <!-- 글제목 끝 -->
			</div>
			<div class="input-group mb-3">
			<label for="searchCategory" class="col-md-1 control-label" style="font-size:18px; font-weight:bold;" >말머리&nbsp;</label>
			 <div class="col-3">
  			 	<select class="form-select" id="searchCategory" name="ubd_cate" value="${ board.getUbd_cate() }">							
				    <option value="자랑글">자랑글</option>						
				    <option value="자유글">자유글</option>							
				    <option value="Q&A">Q&A</option>										
				</select>
			</div>
			<!--  견종  --> 
			<!--  <span class="insert-font">견종</span>&nbsp;&nbsp; -->
			  <label for="dog_kind" class="col-md-1 control-label" style="font-size:18px; font-weight:bold;">&nbsp;견종&nbsp;</label>
			   <div class="col">
			  <input type="text" class="form-control" id="dog_kind" name="dog_kind" value="${ board.getDog_kind() }"  >
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
			   <textarea class="form-control" id="ubd_cont" name="ubd_cont" rows="15" required >${ board.getUbd_cont() }</textarea>		 
			</div>	
			
			  <b>사진업로드(최대 5장/300*300)</b><br><br> 
			  
			  <button type="button" id="add_File" onClick="addFile()" class="btn btn-outline-warning btn-sm" style="text-align: center;">&nbsp;&nbsp;<i class="fa-sharp fa-solid fa-plus"></i></button>
			  <button type="button" id="remove_File" onClick="removeFile()" class="btn btn-outline-warning btn-sm" style="text-align: center;">&nbsp;&nbsp;<i class="fa-sharp fa-solid fa-minus"></i></button>
			  <br>
			  <br>
			  
			<!-- 파일 추가 & 삭제 -->
			<script type="text/javascript">
			var i = 0;
			function addFile() {
				if(i > 4) return; 
				var str = "<input type='file' class='form-control fu' onchange='previewFile("+i+")'name='uploadFile' multiple id='uploadFile"+i+"' aria-describedby='uploadFile' aria-label='Upload'><div id='msgTd"+i+"'></div>";
				$("#divFile").append(str);
				i++;
			}
			
			function removeFile() {
				$('#uploadFile'+(i-1)).remove();
				$('#msgTd'+(i-1)).remove();
				if(i < 1) return;
				i--;
			}
			</script>
			  
			<div id="divFile">

			</div>
			

				<!-- 이미지 프리뷰 -->
				<script>
				function previewFile(no) {
			        var preview = $('#msgTd'+no);
			        console.log(preview);
			        var file = document.querySelector('#uploadFile'+no).files[0];
			        var reader = new FileReader();
			      
			      
			        reader.addEventListener(
			          'load',
			              function () {
			                 preview.html("<img src="+reader.result+" width='100px' height='100px' class='preview_img_del"+no+"'/>");
			                 preview.append("<button class='btn btn-danger preview_img_del"+no+"' onclick='preview_del("+no+")'>삭제</button>");
			                },false
			         );
			      
			        if (file) {
			          reader.readAsDataURL(file);
			        }
			     }
			    function preview_del(no){
			        $('.preview_img_del'+no).remove();
			        $('#uploadFile'+no).val('');
			     }
				</script>
			
				<script>
				function checkResult() {
					for(var i=0; i<5; i++){
						if($('#uploadFile'+i).val() == ''){
							alert('사진을 모두 등록해주세요.');
							return false;
						}
					}
					return true;
				}
				</script>
			
			
			<input type="hidden" name="ubd_file" value="${board.getUbd_file()}"/>	
			<div class="row justify-content-evenly mt-5 mb-5">
				<input type="button" class="btn btn-primary col-2" value="취소" onclick="history.go(-1)"/>
				<input type="submit" class="btn btn-primary col-2" value="등록완료"/>
			</div>
		</form>			
	</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>