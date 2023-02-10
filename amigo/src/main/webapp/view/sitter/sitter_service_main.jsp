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
 <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.js" integrity="sha512-gY25nC63ddE0LcLPhxUJGFxa2GoIyA5FLym4UJqHDEMHjp8RET6Zn/SHo1sltt3WuVtqfyxECP38/daUc/WVEA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
 
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
    <style>

*{
	margin: 0 auto;
}

.sitter_service{
	margin: auto 0;
	padding: 20px;
	text-align: center;
		
}
.sitter_item{
	width: 90%;
	margin: 30px auto;
	overflow: hidden;
	
}

.service_list{
	width:90%;
    margin: 0 auto;
	
}
.service_image{
	width:32%;
}


.sitter_card_list{
	width:90%;
	display:flex;
	justify-content: center;
	margin: 0 auto;
}

.sitter_card{
	width:100%;
}
.sitter_img{
	width:70%;
}

@import url("https://fonts.googleapis.com/css?family=Muli:400,700&display=swap");

h1 {
  text-align: center;
  margin: 1.5em;
}

.sitter_img {
  width: 35%;
  border-radius: 50%;
}



.container {
  width: 100%;
  overflow: hidden;
  position: relative;
}

.items {
  display: flex;
  align-items: center;
  width: fit-content;
  animation: carouselAnim 50s infinite alternate linear;
}

.entry {
  display: flex;
  align-items: center;
  flex-direction: column;
  position: relative;
  width: 300px;
  background: #fff;
  margin: 1em;
  padding: 0.5em;
  border-radius: 10px;
  box-shadow: 4px 4px 5px 0px rgba(0, 0, 0, 0.5);
}

@media only screen and (max-width: 768px) {
  .items {
    animation: carouselAnim 35s infinite alternate linear;
  }
  .service_image{
	width:100%;
	margin: 10px;
	}
  
  @keyframes carouselAnim {
    from {
      transform: translate(0, 0);
    }
    to {
      transform: translate(calc(-100% + (2 * 300px)));
    }
  }
}

.entry p {
  text-align: center;
  padding: 1em;
}

.name {
  font-weight: bold;
}

@keyframes carouselAnim {
  from {
    transform: translate(0, 0);
  }
  to {
    transform: translate(calc(-100% + (5 * 300px)));
  }
}

 h3 {
 	   font-family: "Jalnan";
       font-size:30px;
       color: rgb(87, 160, 227);
 }

.sitter_item {
	margin-top:100px;
}



</style>
    
<title>펫시터01_펫시터화면</title>    
</head>
<body>
	<%@include file="/includes/header.jsp" %>
		<div class="container">		
			<section class="sitter_service">
				<article class="sitter_service_photo sitter_item">
					<h3>다양한 펫시터 서비스</h3>
					<hr>
				 <br>
				<div class="service_list">
					<img src="https://via.placeholder.com/150x100" alt="돌봄" class="service_image"/>
					<img src="https://via.placeholder.com/150x100" alt="산책" class="service_image"/>
					<img src="https://via.placeholder.com/150x100" alt="케어" class="service_image"/>
				</div> 
				</article>			
				<article class="sitter_item">
					<h3>대표 펫시터를 소개합니다!</h3>
					<hr>
					  <div class="items">
				    <div class="entry">
				      <p class="name">한준호</p>
				      <img class="sitter_img" src="https://via.placeholder.com/150x100"  />
				      <p class="quote">공룡처럼 짜릿한 케어!</p>
				    </div>
				    <div class="entry">
				      <p class="name">이진주</p>
				      <img class="sitter_img" src="https://via.placeholder.com/150x100"  />
				      <p class="quote">최고의 강아지 전문가~</p>
				    </div>
				    <div class="entry">
				      <p class="name">최성형</p>
				      <img class="sitter_img" src="https://via.placeholder.com/150x100"  />
				      <p class="quote">엄마처럼 친근한 케어!</p>
				    </div>
				    <div class="entry">
				      <p class="name">시터</p>
				      <img class="sitter_img" src="https://via.placeholder.com/150x100"  />
				      <p class="quote">시터설명</p>
				    </div>
				    <div class="entry">
				      <p class="name">시터</p>
				      <img class="sitter_img" src="https://via.placeholder.com/150x100"  />
				      <p class="quote">시터설명</p>
				    </div>
				    <div class="entry">
				      <p class="name">시터</p>
				      <img class="sitter_img" src="https://via.placeholder.com/150x100"  />
				      <p class="quote">시터설명</p>
				    </div>
				</article>
				
				<article class="service_btn sitter_item"">	
					<button type="button" class="btn btn-primary" ><a href="/amigo/view/book/book_sitter_form.do" style="color: white;">신청하기</a></button>
				</article>
			</section>
		</div>
		
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>