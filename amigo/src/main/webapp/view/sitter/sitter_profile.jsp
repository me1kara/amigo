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
    	ul{
    		list-style: none;
    	}
    </style>
</head>

<body>
	<%@include file="/includes/header.jsp" %>
			<div class="container text-center">
				<section>
					<h2> 시터 프로필 정보</h2>
					<article>
							<ul>
								<li>
				    			    <c:choose>
				     			     <c:when test="${not empty sitter.sit_photo}">
				     			       <img src="${sitter.sit_photo}" alt="Profile Picture"/>
				     			     </c:when>
				     			     <c:otherwise>
				     			       <span>Profile picture not available</span>
				     			     </c:otherwise>
				    			    </c:choose>
				   				</li>
						 		<li><c:out value="${sitter.user_name}"/> 펫시터</li>
						 		<li>
							 		<ul>
							 			<li>펫시터 전문가 교육 수료</li>
							 			<li>전문 펫시터 자격증 보유</li>
							 			<li>펫시터 직업훈련 교육 수료</li>
							 		</ul>
								</li>
								<li>
									<span>신원인증</span><span>인성검사</span><span>촬영동의</span>
								</li>
								<li style="border-top: 1px solid black;">
									<div><span>후기</span></div>
								</li>
							</ul>
					</article>
				<article>
				<button class="btn btn-primary"><a href="/amigo/requestBook.do?sit_no=${sitter.sit_no }" style="color: white;">신청하기</a> </button>
				</article>
				</section>
			</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>