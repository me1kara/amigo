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
<title>펫시터01_펫시터화면</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
    
    <style>
@import url("https://fonts.googleapis.com/css?family=Muli:400,700&display=swap");

body {
  margin: 0;
  height: calc(100vh - 8em);
  font-family: "Muli", sans-serif;
  background-color: #f9f9f9;
}

h1 {
  text-align: center;
  margin: 1.5em;
}

.sit_img {
  width: 35%;
  border-radius: 50%;
}
.session_img {
  width: 35%;
  border-radius: 10px;
  margin: 5px;
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
  width: 450px;
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

    </style>
    
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container" >
			<h2>펫시터서비스(활동사진)</h2>
			<div style="display: flex;">			
	 			<img src="https://via.placeholder.com/150x100"" alt="돌봄" class="sitt_action_image session_img"/>
				<img src="https://via.placeholder.com/150x100"" alt="산책" class="sitt_action_image session_img"/>
				<img src="https://via.placeholder.com/150x100"" alt="케어" class="sitt_action_image session_img"/>		
 			</div>
 			
			<h2>대표펫시터사진들</h2>
<!-- 		  <div class="faders">
			  </div> -->
			  <div class="items">
			    <div class="entry">
			      <p class="name">시터</p>
			      <img src="https://via.placeholder.com/150x100" class="sit_img" alt="Smiling person" />
			      <p class="quote">"안녕하세요!"</p>
			    </div>
			    <div class="entry">
			      <p class="name">시터</p>
			      <img src="https://via.placeholder.com/150x100" class="sit_img" alt="Smiling person" />
			      <p class="quote">"안녕하세요!"</p>
			    </div>
			    <div class="entry">
			      <p class="name">시터</p>
			      <img src="https://via.placeholder.com/150x100" class="sit_img" alt="Smiling person" />
			      <p class="quote">"안녕하세요!"</p>
			    </div>
			    <div class="entry">
			      <p class="name">시터</p>
			      <img src="https://via.placeholder.com/150x100" class="sit_img" alt="Smiling person" />
			      <p class="quote">"안녕하세요!"</p>
			    </div>
			    <div class="entry">
			      <p class="name">시터</p>
			      <img src="https://via.placeholder.com/150x100" class="sit_img" alt="Smiling person" />
			      <p class="quote">"안녕하세요!"</p>
			    </div>
			    <div class="entry">
			      <p class="name">시터</p>
			      <img src="https://via.placeholder.com/150x100" class="sit_img" alt="Smiling person" />
			      <p class="quote">"안녕하세요!"</p>
			    </div>
			  </div>  
			  
				<button type="button" class="btn btn-primary" onclick="location.href='/amigo/view/book/book_sitter_form.jsp'" style="position:relative; left: 50%; transform:translate(-50px);">신청하기</button>
			  
		</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>