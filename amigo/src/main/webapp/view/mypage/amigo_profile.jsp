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
								<td><button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#dogdelete" data-dog_no="${dog.getDog_no()}">삭제</button></td>		
						 </tr>	 
					   </c:forEach>									
					</tbody>
				</table>
			</div>
			<!-- 반려동물 추가 -->	
				<div class="row-sm-3 text-center">
					<a href="amigo_profile_insert.jsp" class="col-1 btn btn-primary">반려동물 추가</a>
				</div>
		 </c:otherwise>
		</c:choose>
		</div>
	 		<!--삭제 modal form  -->
				<div id="dogdelete" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="dogdeleteLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="dogdeleteLabel">반려동물 삭제</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        반려견 정보를 정말 삭제하시겠습니까?
				      </div>
				      <div class="modal-footer">
				      	<button type="button" class="btn btn-danger" onclick="deleteDog();">삭제</button>
				       	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
				      </div>
				    </div>
				  </div>
				  
		<!--삭제 modal form script dog_no전달-->	  
		<script>
		var DOGNO="";
		$(document).ready(function() {     
	        $('#dogdelete').on('show.bs.modal', function(event) {          
	        	DOGNO = $(event.relatedTarget).data('dog_no');
	        });
	    });
		function deleteDog() {location.href='deleteDog.do?dog_no='+DOGNO;}
		</script>

	<%@include file="/includes/footer.jsp" %>

</body>
</html>