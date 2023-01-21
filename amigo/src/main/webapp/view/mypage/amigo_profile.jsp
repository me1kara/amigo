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
<title>Insert title here</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container mt-3">
		
		
		<c:choose>
		    <c:when test="${ dogList.isEmpty() || dogList == null }">
		        <div class="text-center">
				<h5><p class="bg-danger">반려동물이 없습니다.</p></h5>
				    <p>반려동물 프로필을 등록하세요!</p>
				    <a href="amigo_profile_insert.jsp" class="col-1 btn btn-primary">등록하기</a>
				</div>
			</c:when>
		
	   <c:otherwise>
		<p>반려동물 프로필</p>
			<div class="row mt-4">
				<table class="table table-hover table-bordered">
					<thead class="table-dark text-center">					
						<th scope="col" class="col-1 text-center">사진경로</th>
						<th scope="col" class="col-1 text-center">이름</th>
						<th scope="col" class="col-1 text-center">성별</th>
						<th scope="col" class="col-1 text-center">품종</th>
						<th scope="col" class="col-1 text-center">생일</th>
						<th scope="col" class="col-1 text-center">몸무게</th>
						<th scope="col" class="col-1 text-center">중성화여부</th>			
						<th scope="col" class="col-1 text-center">광견병 접종여부</th>			
						<th scope="col" class="col-2 text-center">기타사항</th>			
						<th scope="col" class="col-0.5 text-center">약관동의</th>							
						<th scope="col" class="col-0.5 text-center">수정</th>							
						<th scope="col" class="col-0.5 text-center">삭제</th>							
					</thead>
					 <tbody>
						<c:forEach var="dog" items="${ dogList }">
						 <tr>
								<td align="center">${ dog.getDog_image_url()}</td>
								<td>${dog.getDog_name()}</td>
				    			<td><c:choose><c:when test="${ dog.getDog_gender()=='f' }">여자아이</c:when>
										      <c:when test="${ dog.getDog_gender()=='m' }">남자아이</c:when></c:choose></td>
								<td>${ dog.getDog_breeds()}</td>
								<td>${ dog.getDog_birth() }</td>
								<td>${ dog.getDog_weight() }kg</td>
				<!-- 				<td>${ dog.isDog_neutered() }</td>   -->
				    			<td><c:choose><c:when test="${ dog.isDog_neutered() }">예</c:when>
										      <c:when test="${ !dog.isDog_neutered() }">아니오</c:when></c:choose></td>
				    			<td><c:choose><c:when test="${ dog.isDog_rabies_vacc() }">예</c:when>
										      <c:when test="${ !dog.isDog_rabies_vacc() }">아니오</c:when></c:choose></td>
								<td>${ dog.getDog_notice() }</td>
				    			<td><c:choose><c:when test="${ dog.isDog_terms() }">예</c:when>
										      <c:when test="${ !dog.isDog_terms() }">아니오</c:when></c:choose></td>
								<td><a href="updateDog.do?dog_no=${dog.getDog_no()}" class="btn btn-primary">수정</a></td>
								<td><a href="deleteDog.do" class="btn btn-danger">삭제</a></td>
						 </tr>
					   </c:forEach>									
					</tbody>
				</table>
			</div>	 <!-- 반려견리스트 -->
				
				<div class="row-sm-3 text-center">
					<a href="amigo_profile_insert.jsp" class="col-1 btn btn-primary">반려동물 추가</a>
				</div>
		 </c:otherwise>
		</c:choose>
		</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>