<%@page import="com.lec.amigo.vo.SitterVO"%>
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
<title>프로필01_시터 프로필 확인</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
    
    <style>
		.petsitter_name {
			font-family: "Jalnan";
			font-size:20px;
			padding-top:20px;
		}
    	
    	#profile_card {
    		margin: 0 auto;
    		width: 400px;
    		margin-top:50px;
    		margin-bottom:50px;
    		border-radius: 10px;
			box-shadow: 5px 2px 20px rgba(0,0,0,0.2);
    	}
    	
    	
    	h2 {
    		font-family: "Jalnan";
       		font-size:40px;
    	}
    	
    	section {
    		margin-top:80px;
    	}
    	
    	#petsitter_title {
    		padding-top:20px;
    		
    	}
    	
    </style>
</head>

<body>
	<%@include file="/includes/header.jsp" %>
			<div class="container text-center" >
				<section>
					<h2> 시터 프로필 정보</h2>
					<article id="profile_card">
						<div id="petsitter_title">
							<div id="img_ex" style="border:1px solid; width:200px; height:200px; margin:0 auto;">
				    		 <c:choose>
				     		 <c:when test="${not empty sitter.sit_photo}">
				     			<img src="${sitter.sit_photo}" alt="Profile Picture"/>
				     	 	 </c:when>
				     		 <c:otherwise>
				     			<span>Profile picture not available</span>
				     		 </c:otherwise>
				    		 </c:choose>
				    		 </div>
						 <p class="petsitter_name"><c:out value="${sitter.user_name}"/> 펫시터</p>
				   		</div>	
				   		<hr>
						<div>
							 	<p>펫시터 전문가 교육 수료</p>
							 	<p>전문 펫시터 자격증 보유</p>
							 	<p>펫시터 직업훈련 교육 수료</p>
						</div>
								<hr>
								<div>후기</div>
					</article>
				<article>
				<button class="btn btn-primary"><a href="/amigo/requestBook.do?sit_no=${sitter.sit_no }" style="color: white;">신청하기</a> </button>
				</article>
				</section>
			</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>