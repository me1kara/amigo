<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script
      src="https://code.jquery.com/jquery-3.6.3.min.js"
      integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
      crossorigin="anonymous"
    ></script>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" type="text/css" href="/resources/css/style.css" />
    <style>
    	
    	.star-rating {
    		width:100%;
    		text-align: center;
    	}
    	.text-uppercase {
    	 font-family: "Jalnan";
      	 font-size:40px; 
    	}
    	.review-main {
    	 font-weight: bold;
    	}
    </style>
<title>후기01_실시간 후기</title>

</head>
<%

%>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="title text-center">
        <h1 class="text-uppercase">${param.user_name} 펫시터 리뷰</h1>
        </div><input type="hidden" value="${param.sit_no}" >
        <br />
        
 
              <div class="text-center m-b-30">
                <!-- 몇마리의 표현은 정보를 가져와줘야함. 02/09 백단에서 가져옴 -->
                <div class="review-member">
                  <a href="#">${param.user_name}  </a>펫시터 후기
                  <a href="/view/review/user_review_insert.do?sit_no=${param.sit_no}&user_name=${param.user_name}" class="btn btn-primary">리뷰작성</a>
    			  
 

 
    <!-- 유저 실시간 리뷰 -->
 <div class="container">
      <div class="row">
      <c:choose>
         <c:when test="${ rev.isEmpty() || rev == null }">
            <h6>등록된 게시판 정보가 존재하지 않습니다. 다시 확인해주세요.</h6>
         </c:when>
      <c:otherwise>
     	 <c:forEach var="r" items="${ rev }">
        <div
          class="col-sm-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3 col-xl-4 offset-xl-4"
        >
          <div class="review-user-card">
            <div class="review-divided">
              <div class="row">
                <div class="col-sm-3">
                  <div class="review-img">
                  <!-- 유저 프로필 -->																		<!--  유저 프로필은 서버단에서 GET -->
                  	<c:choose>
                  	<c:when test="${r.getUser_photo()!=null and r.getUser_photo()!=''}">
                    <img
                      src="../resources/img/${r.getUser_photo() }"
                      class="review-user-photo"
                      alt="userProfile"
                      width="50px"
                      class="mr-3 rounded-circle"
                    />
                    </c:when>
                    <c:otherwise>
                    <img src="resources/img/logo2.png" alt="logo2" width="50px" class="mr-3 rounded-circle" alt="logo2"/>
                    </c:otherwise>
                    </c:choose>
                    <br>
                    <span class="nickName" style="color:#498dcc; font-weight:bold">${ r.getUser_nick() }</span>&nbsp;
                    <!-- 유저 프로필 end -->
                  </div>

                  <div class="text-center">
                    <div class="wrap-star">
                      <!-- 100 % -->
                      <div class="ratingStars">             							<!-- 리뷰테이블 VO -->
                      
                      	<c:choose>
                      	<c:when test="${r.getStar_cnt() == 1}">
                      		<img src="../resources/img/star1.png" style="width:150px;height:60px;">
                      	</c:when>
                      	<c:when test="${r.getStar_cnt() == 2}">
                      		<img src="../resources/img/star2.png" style="width:150px;height:60px;">
                      	</c:when>
                      	<c:when test="${r.getStar_cnt() == 3}">
                      		<img src="../resources/img/star3.png" style="width:150px;height:60px;">
                      	</c:when>
                      	<c:when test="${r.getStar_cnt() == 4}">
                      		<img src="../resources/img/star4.png" style="width:150px;height:60px;">
                      	</c:when>
                      	<c:when test="${r.getStar_cnt() == 5}">
                      		<img src="../resources/img/star5.png" style="width:150px;height:60px;">
                      	</c:when>
                        </c:choose>
                        <input type="hidden" class="form-control" name="sit_no" value="${ r.getSit_no() }">
                        <input type="hidden" class="form-control" name="user_no" value="${ sessionScope.user.getUser_no() }">
                        <input type="hidden" class="form-control" name="user_no" value="${ r.getUser_no() }">
                        <input type="hidden" class="form-control" name="star_cnt" value="${ r.getStar_cnt() }">
                        <input type="hidden" class="form-control" name="rev_content" value="${ r.getRev_content() }">
                        <input type="hidden" class="form-control" name="rev_date" value="${ r.getRev_date() }">
                        <input type="hidden" class="form-control" name="user_addr" value="${ r.getUser_addr() }">
                        <input type="hidden" class="form-control" name="user_nick" value="${ r.getUser_nick() }">
                        <input type="hidden" class="form-control" name="user_name" value="${ r.getUser_name() }">
                        <input type="hidden" class="form-control" name="user_photo" value="${ r.getUser_photo() }"> 
                        
                      </div>
                    </div>
                  </div>
                </div>
                <!-- 별 end -->
              </div>
              <br />
              <div class="reviewMain text-center">
                <div class="review-user-addr">
                  <a href="#">${ r.getUser_addr() }</a>
                </div>
                <br />
                <br />
                <div class="review-main">
                  <a href="#"></a>${ r.getRev_content() }
                </div>
              </div>
            </div>
          </div>
        </div>
         </c:forEach>
       </c:otherwise>
       </c:choose>
      </div>
    </div>
	</div>
	</div>
	
	
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>