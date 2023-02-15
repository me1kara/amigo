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
	width: 90%;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
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

 .sitter_service_title {
 	   font-family: "Jalnan";
       font-size:30px;
       color: rgb(87, 160, 227);
 }

.sitter_item {
	margin-top:100px;
}




.service_image {
		width:310px;
	height:290px;
	box-shadow: 5px 5px 20px rgba(0, 0, 0, 0.2);
    border-radius: 10px;

}

/* 이미지 */
figure.amigo1224 {
        font-family: "Raleway", Arial, sans-serif;
        position: relative;
        overflow: hidden;
        margin: 10px;
        min-width: 290px;
        max-width: 310px;
        width: 100%;
        color: #ffffff;
        text-align: center;
        font-size: 16px;
        background-color: #000000;
        border-radius: 10px;
      }
      figure.amigo1224 *,
      figure.amigo1224 *:before,
      figure.amigo1224 *:after {
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        -webkit-transition: all 0.55s ease;
        transition: all 0.55s ease;
      }
      figure.amigo1224 img {
        max-width: 100%;
        backface-visibility: hidden;
        vertical-align: top;
        opacity: 0.9;
      }
      figure.amigo1224 .title {
        position: absolute;
        top: 58%;
        left: 25px;
        padding: 5px 10px 10px;
      }
      figure.amigo1224 .title:before,
      figure.amigo1224 .title:after {
        height: 2px;
        width: 310px;
        position: absolute;
        content: "";
        background-color: #ffffff;
      }
      figure.amigo1224 .title:before {
        top: 0;
        left: 10px;
        -webkit-transform: translateX(100%);
        transform: translateX(100%);
      }
      figure.amigo1224 .title:after {
        bottom: 0;
        right: 10px;
        -webkit-transform: translateX(-100%);
        transform: translateX(-100%);
      }
      figure.amigo1224 .title div:before,
      figure.amigo1224 .title div:after {
        width: 2px;
        height: 300px;
        position: absolute;
        content: "";
        background-color: #ffffff;
      }
      figure.amigo1224 .title div:before {
        top: 10px;
        right: 0;
        -webkit-transform: translateY(100%);
        transform: translateY(100%);
      }
      figure.amigo1224 .title div:after {
        bottom: 10px;
        left: 0;
        -webkit-transform: translateY(-100%);
        transform: translateY(-100%);
      }
      figure.amigo1224 h2,
      figure.amigo1224 h4 {
        margin: 0;
        text-transform: uppercase;
      }
      figure.amigo1224 h2 {
        font-weight: 400;
      }
      figure.amigo1224 h4 {
        display: block;
        font-weight: 700;
        background-color: #ffffff;
        padding: 5px 10px;
        color: #000000;
      }
      figure.amigo1224 figcaption {
        position: absolute;
        bottom: 42%;
        left: 25px;
        text-align: left;
        opacity: 0;
        padding: 5px 60px 5px 10px;
        font-size: 0.8em;
        font-weight: 500;
        letter-spacing: 1.5px;
      }
      figure.amigo1224 figcaption p {
        margin: 0;
      }
      figure.amigo1224 a {
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
      }
      figure.amigo1224:hover img,
      figure.amigo1224.hover img {
        zoom: 1;
        filter: alpha(opacity=35);
        -webkit-opacity: 0.35;
        opacity: 0.35;
      }
      figure.amigo1224:hover .title:before,
      figure.amigo1224.hover .title:before,
      figure.amigo1224:hover .title:after,
      figure.amigo1224.hover .title:after,
      figure.amigo1224:hover .title div:before,
      figure.amigo1224.hover .title div:before,
      figure.amigo1224:hover .title div:after,
      figure.amigo1224.hover .title div:after {
        -webkit-transform: translate(0, 0);
        transform: translate(0, 0);
      }
      figure.amigo1224:hover .title:before,
      figure.amigo1224.hover .title:before,
      figure.amigo1224:hover .title:after,
      figure.amigo1224.hover .title:after {
        -webkit-transition-delay: 0.15s;
        transition-delay: 0.15s;
      }
      figure.amigo1224:hover figcaption,
      figure.amigo1224.hover figcaption {
        opacity: 1;
        -webkit-transition-delay: 0.2s;
        transition-delay: 0.2s;
      }




</style>
    
<title>펫시터01_펫시터화면</title>    
</head>
<body>
	<%@include file="/includes/header.jsp" %>
		<div class="container">		
			<section class="sitter_service">
				<article class="sitter_service_photo sitter_item">
					<h3 class="sitter_service_title">다양한 펫시터 서비스</h3>
					<hr>
				 <br>
				 <div class="container col">
				<div class="service_list">				
		 <figure class="amigo1224">
    	  <img
       		 src="/amigo/resources/img/service_img1.png"
       		 alt="돌봄"
       		 class="service_image"
   			   />
     		 <div class="title">
      			  <div>
       			   <h2>돌봄</h2>
        		  <h4>care</h4>
     		   </div>
    		  </div>
    		  <figcaption>  
        		<p>
        	  Amigo를 찾아주시는 여러분들에게 최고의 서비스를 제공하는 돌봄 서비스입니다.
      			  </p>
     			 </figcaption>
     		 <a href="#"></a>
   			 </figure>
   			 		 <figure class="amigo1224">
    	  <img
       		 src="/amigo/resources/img/service_img2.png"
       		 alt="산책"
       		 class="service_image"
   			   />
     		 <div class="title">
      			  <div>
       			   <h2>산책</h2>
        		  <h4>Trail</h4>
     		   </div>
    		  </div>
    		  <figcaption>  
        		<p>
        	  당신의 AM!GO와 함께 시터가 걸어드립니다.
      			  </p>
     			 </figcaption>
     		 <a href="#"></a>
   			 </figure>
   			 		 <figure class="amigo1224">
    	  <img
       		 src="/amigo/resources/img/service_img3.png"
       		 alt="케어"
       		 class="service_image"
   			   />
     		 <div class="title">
      			  <div>
       			   <h2>훈련</h2>
        		  <h4>Training</h4>
     		   </div>
    		  </div>
    		  <figcaption>  
        		<p>
        	  당신의 AM!GO에게 완벽한 교육을 선사합니다.
      			  </p>
     			 </figcaption>
     		 <a href="#"></a>
   			 </figure>
   			 
				<!-- 	
					<img src="/amigo/resources/img/service_img2.png" alt="산책" class="service_image"/>
					<img src="/amigo/resources/img/service_img3.png" alt="케어" class="service_image"/> -->
				</div> 		
				</div>		
				</article>			
				
				<!-- 시터캐러셀 자동루프 -->	

				<article class="sitter_item">
					<h3 class="sitter_service_title">대표 펫시터를 소개합니다!</h3>
					<hr>
					  <div class="items">
					<c:forEach var="sitter" items="${ mainSitterList}">					
					<div class="entry">
				      <p class="name">${ sitter.user_name}</p>
				      
				      <c:choose>
			      	<c:when test="${not empty sitter.sit_photo }">
			      		<img class="sitter_img" src="/sitterimg/${sitter.sit_photo}" />	
			      	</c:when>
	   		      <c:otherwise>	
				      	<img class="sitter_img" src="https://via.placeholder.com/150x100"  />
				      </c:otherwise>
				      </c:choose>
				      <p class="quote">${sitter.sit_intro }</p>
				    </div>
					</c:forEach>
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