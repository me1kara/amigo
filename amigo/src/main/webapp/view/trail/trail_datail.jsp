<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<%
UserVO user = (UserVO)session.getAttribute("user");
%>
<c:set var="userNo" value="<%=user.getUser_no() %>"/>
<!DOCTYPE html>
<html>
<head>
<script
  src="https://code.jquery.com/jquery-3.6.3.min.js"
  integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
  crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="test.json" type="text/javascript"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>산책04_추천산책로</title>
<style>
.rating .rate_radio {
    position: relative;
    display: inline-block;
    z-index: 20;
    opacity: 0.001;
    width: 60px;
    height: 60px;
    background-color: #fff;
    cursor: pointer;
    vertical-align: top;
    display: none;
}
.rating .rate_radio + label {
    position: relative;
    display: inline-block;
    margin-left: -4px;
    z-index: 10;
    width: 60px;
    height: 60px;
    background-image: url('../../resources/img/starrate.png');
    background-repeat: no-repeat;
    background-size: 63px 60px;
    cursor: pointer;
    background-color: #f0f0f0;
}
.rating .rate_radio:checked + label {
    background-color: #ff8;
}
</style>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container">
		       <!-- 산책로 이미지 -->
		      <img src="../../resources/walk/${route_no}.jpg" style="width:60%;height:400px;margin:auto;display:block;">
		       <!-- 산책로 정보 -->
		      <div  id="walk" style="text-align: center";></div>

			    
		 <!-- 후기  -->	    
	    <div class="container">
	      <c:choose>          
         <c:when test="${ trailReviewList.isEmpty() || trailReviewList == null }">
            <p align="center">등록된 후기 정보가 존재하지 않습니다.</p>
         </c:when>
         <c:otherwise>
          <div class="container mt-3">		
			<div class="row mt-4">
				<table class="table table-hover table-bordered">
					<thead class="table-dark text-center">
						<th scope="col" class="col-1 text-center">별점</th>
						<th scope="col" class="col-9">후기내용</th>
						<th scope="col" class="col-2 text-center">작성자</th>					
					</thead>
					<tbody>
					<c:forEach  var="trail" items="${ trailReviewList }">
						<tr>
							<td><c:choose>
								<c:when test="${trail.getWalk_star() == 1}">
								   <img src="../../resources/img/star1.png" style="width:150px;height:60px;">
								</c:when>
								<c:when test="${trail.getWalk_star() == 2}">
								   <img src="../../resources/img/star2.png" style="width:150px;height:60px;">
								</c:when>
								<c:when test="${trail.getWalk_star() == 3}">
								   <img src="../../resources/img/star3.png" style="width:150px;height:60px;">
								</c:when>
								<c:when test="${trail.getWalk_star() == 4}">
								   <img src="../../resources/img/star4.png" style="width:150px;height:60px;">
								</c:when>
								<c:when test="${trail.getWalk_star() == 5}">
								   <img src="../../resources/img/star5.png" style="width:150px;height:60px;">
								</c:when>
							</c:choose></td>
							<td>${trail.getWalk_cont()}</a></td>
							<td>${trail.getUser_nick()}<br>
								<c:if test="${userNo==trail.getUser_no()}">
									   <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#traildelete"
                                       data-walk_review_no="${trail.getWalk_review_no()}">삭제</button>	   
									   <a href="updateTrailReview.do?walk_review_no=${trail.getWalk_review_no()}" class="btn btn-primary"><i class="fas fa-trash">수정</i></a>
								</c:if>
							</td>
						</tr>
					</c:forEach>									
					</tbody>
				</table>
			</div>	
		</div> <!-- 게시판 -->
       </c:otherwise>
      </c:choose>     
      
        <!-- 페이징 -->

      <div class="row align-items-start mt-3">
         <ul class="col pagination justify-content-center">
         
            <c:set var="cp" value="${pagingVO.getCurPage()}"/>
            <c:set var="rp" value="${pagingVO.getRowSizePerPage()}"/>
            <c:set var="fp" value="${pagingVO.getFirstPage()}"/>
            <c:set var="lp" value="${pagingVO.getLastPage()}"/>
            <c:set var="ps" value="${pagingVO.getPageSize()}"/>
            <c:set var="tp" value="${pagingVO.getTotalPageCount()}"/>
                                          
            <c:if test="${ fp != 1 }">
               <li class="page-item"><a href="trail_detail.do?curPage=1&rowSizePerPage=${rp}" class="page-link"><i class="fas fa-fast-backward"></i></a></li>
               <li class="page-item"><a href="trail_detail.do?curPage=${fp-1}&rowSizePerPage=${rp}" class="page-link"><i class="fas fa-backward"></i></a></li>            
            </c:if>
         
            <c:forEach var="page" begin="${fp}" end="${lp}">
               <li class="page-item ${cp==page ? 'active' : ''}"><a href="trail_detail.do?curPage=${page}&rowSizePerPage=${rp}" class="page-link">${page}</a></li>
            </c:forEach>
            
            <c:if test="${ lp < tp }">
               <li class="page-item "><a href="trail_detail.do?curPage=${lp+1}&rowSizePerPage=${rp}" class="page-link"><i class="fas fa-forward"></i></a></li>            
               <li class="page-item"><a href="trail_detail.do?curPage=${tp}&rowSizePerPage=${rp}" class="page-link"><i class="fas fa-fast-forward"></i></a></li>            
            </c:if>
         </ul> <!-- pagination -->     
      </div> 

	
		    <div class="container" align="center">
             	<a href="insertTrailReview.do?route_no=${route_no}" class="btn btn-primary">후기 작성하기</a>
            </div>
	       
		</div>		
	<%@include file="/includes/footer.jsp" %>

	          <!--삭제 modal form  -->
            <div id="traildelete" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="traildeleteLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="traildeleteLabel">후기 삭제</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    산책 후기를 정말 삭제하시겠습니까?
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-danger" onclick="deleteTrail();">삭제</button>
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
                  </div>
                </div>
              </div>
              </div>

<script>
var testData = JSON.parse(JSON.stringify(TestFile));


for (var i = 0; i < 100; i += 1) {	
	var route_no = (testData.features[i].id).substr(14),        // 번호
		route_nm  = testData.features[i].properties.route_nm,   // 이름 
		length_km = testData.features[i].properties.length_km,  // 길이
		time2walk = testData.features[i].properties.time2walk;  // 소요시간
	if ( ${route_no}==route_no ) {
		var places    = [route_no,route_nm,length_km,time2walk];
		previewPlaces(places);
		
	}
}

function previewPlaces(places) {
	document.querySelector('div#walk').innerHTML =
		'<h3>'+places[1]+'</h3>'+
		'<p>길이(km) : '+places[2]+'</p>'+
		'<p>소요시간  : '+places[3]+'</p>';
}

<!--삭제 modal form -->     
	var TRAILREVIEWNO="";
	$(document).ready(function() {     
	     $('#traildelete').on('show.bs.modal', function(event) {          
	    	 TRAILREVIEWNO = $(event.relatedTarget).data('walk_review_no');     
	     });
	 });
	function deleteTrail() {location.href='deleteTrailReview.do?walk_review_no='+TRAILREVIEWNO;}

</script>


</body>
</html>