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
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
    <style>
		.sitter_service{
			margin: auto 0;
			padding: 20px;
			display: flex;
			flex-direction: column;
			align-items: center;	
		}
		.sitter_item{
			width: 70%;
			margin-top: 30px;
			
		}
		
    </style>
<title>펫시터01_펫시터화면</title>    
</head>
<body>
	<%@include file="/includes/header.jsp" %>
		<div class="container">		
			<section class="sitter_service">
				<article class="sitter_service_photo sitter_item">
					<h3>펫시터서비스(활동사진)</h3>
<br>
					<img src="https://via.placeholder.com/150x100"" alt="돌봄" class="sitt_action_image"/>
					<img src="https://via.placeholder.com/150x100"" alt="산책" class="sitt_action_image"/>
					<img src="https://via.placeholder.com/150x100"" alt="케어" class="sitt_action_image"/>
				</article>
			
				<article class="sitter_card sitter_item"">
					<h3>대표펫시터사진들</h3>
					<div id="demo" class="carousel slide" data-bs-ride="carousel">
					  <!-- Indicators/dots -->
					  <div class="carousel-indicators">
					    <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
					    <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
					    <button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
					    <button type="button" data-bs-target="#demo" data-bs-slide-to="3"></button>
					  </div>
					
					  <!-- The slideshow/carousel -->
					  <div class="carousel-inner">
					    <div class="carousel-item active">
					      <img src="https://via.placeholder.com/250x100" alt="시터1" >
					      <img src="https://via.placeholder.com/250x100" alt="시터2" >
					    </div>
					    <div class="carousel-item">
					      <img src="https://via.placeholder.com/250x100" alt="시터3">
					      <img src="https://via.placeholder.com/250x100" alt="시터4">
					    </div>
					    <div class="carousel-item">
					      <img src="https://via.placeholder.com/250x100" alt="시터5">
					      <img src="https://via.placeholder.com/250x100" alt="시터6">
					    </div>
					     <div class="carousel-item">
					      <img src="https://via.placeholder.com/250x100" alt="시터7">
					      <img src="https://via.placeholder.com/250x100" alt="시터8">
					    </div>
					  </div>
					
					  <!-- Left and right controls/icons -->
					  <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
					    <span class="carousel-control-prev-icon"></span>
					  </button>
					  <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
					    <span class="carousel-control-next-icon"></span>
					  </button>
					</div>
				</article>
				
				<article class="service_btn sitter_item"">	
					<button type="button" class="btn btn-primary" ><a href="/amigo/view/book/book_sitter_form.jsp" style="color: white;">신청하기</a></button>
				</article>
			</section>
		</div>
		
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>