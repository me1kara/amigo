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
<title>펫시터05_펫시터신청완료</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
    
<style>
		#book_seccess {
		    margin: 0 auto;
    		width: 400px;
    		height: 400px;
    		margin-top:50px;
    		margin-bottom:50px;
    		border-radius: 10px;
			box-shadow: 5px 2px 20px rgba(0,0,0,0.2);
			display: flex;
        	justify-content: center;
        	align-items: center;
		
		}

	   	.book_title {
    		font-family: "Jalnan";
       		font-size:25px;
       		margin-bottom: 20px;
    	}
    	
    	.img_dog {
    		 width : 250px;
    		 height : 200px;
    		 border-radius: 20px;
    		 box-shadow: 5px 2px 20px rgba(0, 0, 0, 0.2);
    		 margin-bottom: 20px;
    	}
    	
    	.book_request_title {
    		font-family: "Jalnan";
       		font-size:30px;
       		margin-bottom: 20px;
       		margin-top:80px;
       		text-align: center;
       		color: rgb(87, 160, 227);
    	}
		

</style>

</head>
<body>
	<%@include file="/includes/header.jsp" %>
	
		<div class="container" align="center">
			<h2 class="book_request_title">예약 완료</h2><hr>
			<section id ="book_seccess">
				<article>
					<img
            			src="/resources/img/MainPageImg.png"
            			class="img_dog"
            			alt="amigoPet"
         			 />
					<h1 class="book_title">예약이 완료됐습니다!</h1>
					<button class="btn btn-primary" onclick="location.href='/book_check.do'">예약 확인</button>
				</article>
			</section>
		</div>
		
	<%@include file="/includes/footer.jsp" %>
</body>
</html>