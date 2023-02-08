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
		<form action="user_review_insert.do" method="post" enctype="multipart/form-data" onSubmit="return checkResult()">
            <input name="sit_no" type="hidden" value="${svo.sit_no}" />
            <input name="user_name" type="hidden" value="${svo.user_name}" />
            <input name="user_photo" type="hidden" value="${sessionScope.user.user_photo}" />
			<input name="user_no" type="hidden" value="${sessionScope.user.user_no}" />
			<input name="user_addr" type="hidden" value="${sessionScope.user.user_addr}" />
			<div class="input-group mb-3">
			</div>
			<!-- 작성자  -->
			<div class="input-group mb-3">
			 <input type="hidden" class="col-md-1 control-label" name="user_nick" value="${ sessionScope.user.getUser_nick() }" >
			 <span class="insert-font col-md-1" style="font-size:18px; font-weight:bold;" >작성자 </span> &nbsp;<p class="insert-user-name" style="font-size:18px; font-weight:bold;">${ user.getUser_nick() }</p>&nbsp;&nbsp;&nbsp;
			 <span class="insert-font col-md-1" style="font-size:18px; font-weight:bold;" >펫시터 </span> &nbsp;<p class="insert-sitter-name" style="font-size:18px; font-weight:bold;">${ svo.getUser_name() }</p>
			</div>
			<!-- 작성자  끝 -->
	<div class="input-group mb-3">
	<fieldset>
		<span class="text-bold">별점을 선택해주세요</span>
		<input type="radio" name="star_cnt" value="5" id="rate1"><label
			for="rate1">★</label>
		<input type="radio" name="star_cnt" value="4" id="rate2"><label
			for="rate2">★</label>
		<input type="radio" name="star_cnt" value="3" id="rate3"><label
			for="rate3">★</label>
		<input type="radio" name="star_cnt" value="2" id="rate4"><label
			for="rate4">★</label>
		<input type="radio" name="star_cnt" value="1" id="rate5"><label
			for="rate5">★</label>
	</fieldset>
	</div>
			<!-- 상단 끝 -->
			
			<hr/>
			<div class="input-group mb-3">
			   <textarea class="form-control" id="rev_content" name="rev_content" rows="10" placeholder="글 내용을 입력하세요.." required ></textarea>		 
			</div>	

			
		  
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