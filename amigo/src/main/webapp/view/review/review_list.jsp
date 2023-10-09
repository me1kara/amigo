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
    <style>
    	
    	
    	.star-rating {
    		width:100%;
    		text-align: center;
    	}
    	.text-uppercase {
    	 font-family: "Jalnan";
      	 font-size:40px; 
    	}
    	
    	.main-content{
    		border-bottom: 1px solid black;
    	}
        	
    	
    </style>
<title>후기01_실시간 후기</title>

</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container">
		  <section class="main-content" style="padding-bottom: 0px; margin-bottom: 0px;">
      <br />
      <div class="container" style="position: relative; top: -100px;">
        <h1 class="text-uppercase">고객님들의 실시간 후기</h1>
        <br />
        <br />
        <div class="row">
          <div
            class="col-sm-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3 col-xl-4 offset-xl-4"
          >
            <div class="rating-card" style="background: white;">
              <div class="text-center m-b-30">
                																<!-- $ {도그카운트} 로 강아지 테이블의 마릿수를 가져옴 -->
                <div class="review-member">
                  <a href="#">${dogCount}</a>마리의 친구들이 AM!GO와 함께했어요!
                </div>
                <br />
                <!-- 점수 -->
                <h1 class="rating-number">${starsAverage}<small>/5</small></h1>
                <div class="rating-stars d-inline-block position-relative mr-2">
                  <!--  -->
                  <img src="resources/img/grey-star.svg" alt="" />
                  <div class="filled-star" style="width: 86%"></div>
                </div>
             																	   <!-- 총 레이팅 : 별 갯수를 서버단에서 직접 가져옴. -->
                <div class="text-muted">${starsTotalCount } ratings</div>
              </div>
              <div class="rating-divided">
                <div class="rating-progress">
                  <span class="rating-grade"
                    >5 <img src="/resources/img/star.svg" alt=""
                  /></span>
                  <div class="progress">
                    <div
                      class="progress-bar bg-warning"
                      role="progressbar"
                      style="width: 75%"
                      aria-valuenow="75"
                      aria-valuemin="0"
                      aria-valuemax="100"
                    ></div>
                  </div>
                  <span class="rating-value">${ssrc5}</span>
                </div>
                <div class="rating-progress">
                  <span class="rating-grade"
                    >4 <img src="/resources/img/star.svg" alt=""
                  /></span>
                  <div class="progress">
                    <div
                      class="progress-bar bg-warning"
                      role="progressbar"
                      style="width: 10%"
                      aria-valuenow="10"
                      aria-valuemin="0"
                      aria-valuemax="100"
                    ></div>
                  </div>
                  <span class="rating-value">${ssrc4}</span>
                </div>
                <div class="rating-progress">
                  <span class="rating-grade"
                    >3 <img src="/resources/img/star.svg" alt=""
                  /></span>
                  <div class="progress">
                    <div
                      class="progress-bar bg-warning"
                      role="progressbar"
                      style="width: 8%"
                      aria-valuenow="8"
                      aria-valuemin="0"
                      aria-valuemax="100"
                    ></div>
                  </div>
                  <span class="rating-value">${ssrc3}</span>
                </div>
                <div class="rating-progress">
                  <span class="rating-grade"
                    >2 <img src="/resources/img/star.svg" alt=""
                  /></span>
                  <div class="progress">
                    <div
                      class="progress-bar bg-warning"
                      role="progressbar"
                      style="width: 6%"
                      aria-valuenow="6"
                      aria-valuemin="0"
                      aria-valuemax="100"
                    ></div>
                  </div>
                  <span class="rating-value">${ssrc2}</span>
                </div>
                <div class="rating-progress">
                  <span class="rating-grade"
                    >1 <img src="/resources/img/star.svg" alt=""
                  /></span>
                  <div class="progress">
                    <div
                      class="progress-bar bg-warning"
                      role="progressbar"
                      style="width: 3%"
                      aria-valuenow="3"
                      aria-valuemin="0"
                      aria-valuemax="100"
                    ></div>
                  </div>
                  <span class="rating-value">${ssrc1}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- 리뷰 종합 end -->
    <!-- 유저 실시간 리뷰 -->
    <div class="container">
      <div class="row">
      <c:choose>
         <c:when test="${ revList.isEmpty() || revList == null }">
            <h6>등록된 게시판 정보가 존재하지 않습니다. 다시 확인해주세요.</h6>
         </c:when>
      <c:otherwise>
     	 <c:forEach var="rev" items="${ revList }">
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
                  	<c:when test="${rev.getUser_photo()!=null and rev.getUser_photo()!=''}">
                    <img
                      src="/userimg/${rev.getUser_photo() }"
                      class="review-user-photo"
                      alt="userProfile"
                      width="50px"
                      class="mr-3 rounded-circle"
                      style="border-radius:50px;"
                    />
                    </c:when>
                    <c:otherwise>
                    <img src="resources/img/logo2.png" alt="logo2" width="50px" class="mr-3 rounded-circle" alt="logo2"/>
                    </c:otherwise>
                    </c:choose>
                    <br>
                    <span class="nickName" style="color:#498dcc; font-weight:bold">${ rev.getUser_nick() }</span>&nbsp;
                    <!-- 유저 프로필 end -->
                  </div>
                  
                  <!-- 별 
                 
                  <div class="star-ratings">
                    <div 
                      class="star-ratings-fill space-x-2 text-lg"
                      :style="{ width: ratingToPercent + '%' }"
                    >
                      <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                    </div>
                    <div class="star-ratings-base space-x-2 text-lg">
                      <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                    </div>
                  -->
                  <div class="text-center">
                    <div class="wrap-star">
                      <!-- 100 % -->
                      <div class="ratingStars">             							<!-- 리뷰테이블 VO -->
                      
                      	<c:choose>
                      	<c:when test="${rev.getStar_cnt() == 1}">
                      		<img src="../resources/img/star1.png" style="width:150px;height:60px;">
                      	</c:when>
                      	<c:when test="${rev.getStar_cnt() == 2}">
                      		<img src="../resources/img/star2.png" style="width:150px;height:60px;">
                      	</c:when>
                      	<c:when test="${rev.getStar_cnt() == 3}">
                      		<img src="../resources/img/star3.png" style="width:150px;height:60px;">
                      	</c:when>
                      	<c:when test="${rev.getStar_cnt() == 4}">
                      		<img src="../resources/img/star4.png" style="width:150px;height:60px;">
                      	</c:when>
                      	<c:when test="${rev.getStar_cnt() == 5}">
                      		<img src="../resources/img/star5.png" style="width:150px;height:60px;">
                      	</c:when>
                        </c:choose>
                        <input type="hidden" class="form-control" name="sit_no" value="${ rev.getSit_no() }">
                        <input type="hidden" class="form-control" name="user_no" value="${ sessionScope.user.getUser_no() }">
                        <input type="hidden" class="form-control" name="user_no" value="${ rev.getUser_no() }">
                        <input type="hidden" class="form-control" name="star_cnt" value="${ rev.getStar_cnt() }">
                        <input type="hidden" class="form-control" name="rev_content" value="${ rev.getRev_content() }">
                        <input type="hidden" class="form-control" name="rev_date" value="${ rev.getRev_date() }">
                        <input type="hidden" class="form-control" name="user_addr" value="${ rev.getUser_addr() }">
                        <input type="hidden" class="form-control" name="user_nick" value="${ rev.getUser_nick() }">
                        <input type="hidden" class="form-control" name="user_name" value="${ rev.getUser_name() }">
                        <input type="hidden" class="form-control" name="user_photo" value="${ rev.getUser_photo() }"> 
                        
                      </div>
                    </div>
                  </div>
                </div>
                <!-- 별 end -->
              </div>
              <br />
              <div class="reviewMain text-center">
                <div class="review-user-addr">
                  <a href="#">${ rev.getUser_addr() }</a>
                </div>
                <br />
                <br />
                <div class="review-main">
                  <a href="#"></a>${ rev.getRev_content() }
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
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>