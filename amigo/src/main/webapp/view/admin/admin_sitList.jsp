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
						<th scope="col" class="col-0.5 text-center">회원no</th>
						<th scope="col" class="col-1 text-center">성명</th>
						<th scope="col" class="col-0.5 text-center">성별</th>
						<th scope="col" class="col-1 text-center">직업</th>
						<th scope="col" class="col-0.5 text-center">일수</th>
						<th scope="col" class="col-0.5 text-center">시간대</th>			
						<th scope="col" class="col-0.5 text-center">경력</th>			
						<th scope="col" class="col-2 text-center">경험</th>			
						<th scope="col" class="col-2 text-center">소개</th>
						<th scope="col" class="col-0.5 text-center">여부</th>						
						<th scope="col" class="col-0.5 text-center">승인</th>													
						<th scope="col" class="col-0.5 text-center">실격</th>						
					</thead>
					 <tbody>
						<c:forEach var="sit" items="${ sitList }">
						 <tr>
								<td align="center"><c:if test="${sit.getSit_photo()!=null and sit.getSit_photo()!=''}">
                           <img class="sit-photo" src="/img/${sit.getSit_photo()}" width="60px" height="40px"></c:if> 
                           </div></td>
								<td>${sit.getUser_no()}</td>
								<td>${sit.getUser_name()}</td>
				    			<td><c:choose><c:when test="${ sit.getSit_gender()=='m' }">M</c:when>
										      <c:when test="${ sit.getSit_gender()=='f' }">F</c:when></c:choose></td>
								<td>${ sit.getSit_job() }</td>
								<td>${ sit.getSit_days() }</td>
								<td>${ sit.getSit_time() }</td>
				    			<td><c:choose><c:when test="${ sit.isSit_exp() }">유</c:when>
										      <c:when test="${ !sit.isSit_exp() }">무</c:when></c:choose></td>
				    			<td>${ sit.getSit_care_exp() }</td>
				    			<td>${ sit.getSit_intro() }</td>
				    			<td><c:choose><c:when test="${ sit.isSit_auth_is() }">O</c:when>
										      <c:when test="${ !sit.isSit_auth_is() }">X</c:when></c:choose></td>
								
								<td><a href="updateSitter.do?sit_auth_is=true&user_no=${sit.getUser_no() }" class="btn btn-primary">승인</a></td>
								<td><a href="deleteSitter.do?user_no=${sit.getUser_no() }" class="btn btn-primary">실격</a></td>		
						 </tr>	 
					   </c:forEach>									
					</tbody>
				</table>                                <!-- 처음에 do?sit_auth_is= "달러 중괄 s i t . set유저authIs (트루) 중괄" 로 놓고 업뎃이 가능한 것으로 착각...  -->
			</div>                                      <!-- 승인 -> forEach문의 a태그 :  매서드.do?불리언세팅값=true&유저넘버(쿼리의 where)=달러 중괄 리스트의.유저넘버 얻어오기 중괄호  -->
		 </c:otherwise>
		</c:choose>
		
		<div class="row align-items-start mt-3">
			<ul class="col pagination justify-content-center">
			
				<c:set var="cp" value="${searchVO.getCurPage()}"/>
				<c:set var="rp" value="${searchVO.getRowSizePerPage()}"/>
				<c:set var="fp" value="${searchVO.getFirstPage()}"/>
				<c:set var="lp" value="${searchVO.getLastPage()}"/>
				<c:set var="ps" value="${searchVO.getPageSize()}"/>
				<c:set var="tp" value="${searchVO.getTotalPageCount()}"/>
				<c:set var="sc" value="${searchVO.getSearchCategory()}"/>
				<c:set var="st" value="${searchVO.getSearchType()}"/>
				<c:set var="sw" value="${searchVO.getSearchWord()}"/>
																
				<c:if test="${ fp != 1 }">
					<li class="page-item"><a href="getSitList.do?curPage=1&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-fast-backward"></i></a></li>
					<li class="page-item"><a href="getSitList.do?curPage=${fp-1}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-backward"></i></a></li>				
				</c:if>
			
				<c:forEach var="page" begin="${fp}" end="${lp}">
					<li class="page-item ${cp==page ? 'active' : ''}"><a href="getSitList.do?curPage=${page}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link">${page}</a></li>
				</c:forEach>
				
				<c:if test="${ lp < tp }">
					<li class="page-item "><a href="getSitList.do?curPage=${lp+ps}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-forward"></i></a></li>				
					<li class="page-item"><a href="getSitList.do?curPage=${tp}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-fast-forward"></i></a></li>				
				</c:if>
			</ul> <!-- pagination -->	
	
		</div> <!-- 페이징 -->
		
	
		<!-- 하단 검색 시스템 -->
		<form action="getSitList.do" method="get" id="sitForm">   
				    	<div class="col-3 me-1">
					<select class="form-select" id="searchType" name="searchType">
				    	<option value="">검색</option>							
				    	<option value="user_name" ${searchVO.getSearchType()=="user_name" ? "selected" : "" }>성명</option>							
				    	<option value="sit_auth_is" ${searchVO.getSearchType()=="sit_auth_is" ? "selected" : ""}>승인여부</option>						
				    	<option value="sit_gender" ${searchVO.getSearchType()=="sit_gender" ? "selected" : ""}>성별</option>						
					</select>
				</div>
				<div class="col-3 me-1">			
					<input class="form-control me-2" name="searchWord" type="text" placeholder="내용을 입력하세요." />
				</div>
				<div class="col-2 btn-group">
			    	<input type="submit" class="col-1 btn btn-primary me-2" value="검색">
	        	</div>

	     </form>	
		
		
		</div>

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