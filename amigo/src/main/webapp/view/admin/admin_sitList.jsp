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
<title>관리자03 파트너신청관리</title>
	<!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container mt-3">
		
		
		<c:choose>
		    <c:when test="${ sitList.isEmpty() || sitList == null }">
		        <div class="text-center">
				<h5><p class="bg-danger">펫시터 신청이 접수되지 않았습니다</p></h5>
				    <a href="admin_main.jsp" class="col-1 btn btn-primary">관리자메인으로</a>
				</div>
			</c:when>
		
	   <c:otherwise>
		<p>파트너 신청 관리</p>
			<div class="row mt-4">
				<table class="table table-hover table-bordered">
					<thead class="table-dark text-center">					
						<th scope="col" class="col-1 text-center">사진</th>
						<th scope="col" class="col-1 text-center">이름</th><!-- 유저테이블의 이름. -->
						<th scope="col" class="col-1 text-center">성별</th>
						<th scope="col" class="col-1 text-center">흡연여부</th>
						<th scope="col" class="col-1 text-center">직업</th>
						<th scope="col" class="col-1 text-center">가능일자</th>
						<th scope="col" class="col-1 text-center">가능시간</th>			
						<th scope="col" class="col-1 text-center">경력여부</th>			
						<th scope="col" class="col-2 text-center">시터경험</th>			
						<th scope="col" class="col-0.5 text-center">자기소개</th>							
						<th scope="col" class="col-0.5 text-center">승인</th>							
						<th scope="col" class="col-0.5 text-center">실격</th><!-- 시터에서 delete하면될듯. -->							
					</thead>
					 <tbody>
						<c:forEach var="sitList" items="${ sitList }">
						 <tr>
								<td align="center">${ sitList.getSit_photo()}</td>
								<td>${user.getUser_no()}</td>
				    			<td><c:choose><c:when test="${ sitList.getSit_gender()=='m' }">남성</c:when>
										      <c:when test="${ sitList.getSit_gender()=='f' }">여성</c:when></c:choose></td>
								<td><c:choose><c:when test="${ sitList.isSit_smoking() }">예</c:when>
										      <c:when test="${ !sitList.isSit_smoking() }">아니오</c:when></c:choose></td>
								<td>${ sitList.getSit_job() }</td>
								<td>${ sitList.getSit_days() }</td>
								<td>${ sitList.getSit_time() }</td>
				    			<td><c:choose><c:when test="${ sitList.isSit_exp() }">유경력</c:when>
										      <c:when test="${ !sitList.isSit_exp() }">무경력</c:when></c:choose></td>
				    			<td>${ sitList.getSit_care_exp() }</td>
				    			<td>${ sitList.getSit_intro() }</td>
				    	
								<td><a href="updateSitter.do?sit_auth_is=${sitList.setSit_auth_is(1)}" class="btn btn-primary">승인</a></td>
								<td><button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#sitterdelete" data-sit_no="${sitList.getSit_no()}">실격(또는 자격해제)</button></td>		
						 </tr>	 
					   </c:forEach>									
					</tbody>
				</table>
			</div>
			<!-- 시터 승인하기 -->	
				<div class="row-sm-3 text-center">
					<a href="amigo_profile_insert.jsp" class="col-1 btn btn-primary">시터</a>
				</div>
		 </c:otherwise>
		</c:choose>
		</div>
				<div id="sitterdelete" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="dogdeleteLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="sitterdeleteLabel">펫시터 자격해제</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        반려견 정보를 정말 삭제하시겠습니까?
				      </div>
				      <div class="modal-footer">
				      	<button type="button" class="btn btn-danger" onclick="deleteSitter();">삭제</button>
				       	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
				      </div>
				    </div>
				  </div>
				  </div>
			<script>
			var userno ="";
			$(doument).ready(function() {
				$('#sitterdelete').on('show.bs.modal', function(event) {
					userno = $(event.relatedTarget).data('user_no');	
				});			
			});
			function deleteSitter() {location.href='deleteSitter.do?user_no'+userno;}
			</script>
	<!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="js/script.js"></script>	
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>
<!-- 여기서 시터 신청정보를 받고(간략한 정보만 리스트로 받되
 상세한 부분은 회원리스트처럼 테이블로 받아 관리자만 볼 수 있게끔 하면 될듯   -->
<!-- 그러면 관리자가 보고 승인여부를 결정해서 승인을 하면 petsitter테이블의
 sit_auth_is 를 true (1) 로 바꾸고 유저는 파트너 페이지를 이용가능하게끔  -->