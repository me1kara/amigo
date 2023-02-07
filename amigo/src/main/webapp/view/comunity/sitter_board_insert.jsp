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
<title>게시판03_펫시터글작성(커뮤니티)</title>
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
	
	<!-- far fa icon 불러오기 -->
	<link rel="stylesheet" href=
	"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css">
	</link>
	
	<%@include file="/includes/header.jsp" %>
	<div class="container mt-5" align="center">
	
	<form action="sitter_board_insert.do" method="post" >
          
			<input name="user_no" type="hidden" value="${user.user_no}" />
			
		<div class="input-group mb-3">
		<!-- 글제목 -->
	  	<!--   <span class="insert-font">글제목</span>&nbsp;&nbsp; -->
	  	<!-- 글제목 label로 해서 폼을 둥글게 만들어줌. -->
	  		<label for="sbd_title" class="col-md-1 control-label" style="font-size:18px; font-weight:bold;" >글제목&nbsp;</label>
	  		<div class="col">
	  		<input type="text" class="form-control" name="sbd_title" id="sbd_title" required>
	  		</div>  			 
	  	<!-- 글제목 끝 -->
		</div>
		
		<!-- 작성자  -->
		<div class="input-group mb-3">
			 <span class="insert-font col-md-1" style="font-size:18px; font-weight:bold;" >작성자 :</span> &nbsp;<p class="insert-user-name" style="font-size:18px; font-weight:bold;">${ user.getUser_nick() }</p>
		</div>
		<!-- 작성자  끝 -->
		<!-- 상단 끝 -->
			
			<hr/>
		<div class="input-group mb-3">
			   <textarea class="form-control" id="sbd_cont" name="sbd_cont" rows="15" placeholder="글 내용을 입력하세요.." required ></textarea>		 
		</div>	
			

			
		<div class="row justify-content-evenly mt-5 mb-5">
				<input type="button" class="btn btn-primary col-2" value="취소" onclick="history.go(-1)"/>
				<input type="submit" class="btn btn-primary col-2" value="등록완료"/>
		</div>
	</form>			
	</div>
	
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>