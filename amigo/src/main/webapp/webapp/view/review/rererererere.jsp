<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
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
    	
    </style>
<title>후기01_실시간 후기</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->	
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container">
		  <section class="main-content">
      <br />
      <div class="container">
        <h1 class="text-uppercase">고객님들의 실시간 후기</h1>
        <br />
        <br />
        <div class="row">
          <div
            class="col-sm-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3 col-xl-4 offset-xl-4"
          >
            <div class="rating-card">
              <div class="text-center m-b-30">
                <!-- 몇마리의 표현은 정보를 가져와줘야함 -->
                <div class="review-member">
                  <a href="#">10000</a>마리의 친구들이 AM!GO와 함께했어요!
                </div>
                <br />
                <!-- 점수 -->
                <h1 class="rating-number">4.3<small>/5</small></h1>
                <div class="rating-stars d-inline-block position-relative mr-2">
                  <!-- 별 이미지 일뿐 구동은 백엔드쪽에서 만들어 줘야할거 같습니다. -->
                  <img src="amigo/resources/img/grey-star.svg" alt="" />
                  <div class="filled-star" style="width: 86%"></div>
                </div>
                <!-- 총 레이팅 -->
                <div class="text-muted">2,145 ratings</div>
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
                  <span class="rating-value">1,985</span>
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
                  <span class="rating-value">356</span>
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
                  <span class="rating-value">130</span>
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
                  <span class="rating-value">90</span>
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
                  <span class="rating-value">33</span>
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
        <div
          class="col-sm-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3 col-xl-4 offset-xl-4"
        >
          <div class="review-user-card">
            <div class="review-divided">
              <div class="row">
                <div class="col-sm-3">
                  <div class="review-img">
                    <img
                      src="/resources/img/reviewProfile.jpg"
                      class="review-user-profile"
                      alt="profileImg"
                    />
                  </div>
                  <!-- 별 -->
                  <!-- 
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
                      <div class="star-rating">
                        <span style="width: 100%"></span>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- 별 end -->
              </div>
              <br />
              <div class="reviewMain text-center">
                <div class="review-user-addr">
                  <a href="#">서울 강남구</a>
                </div>
                <br />
                <br />
                <div class="review-main">
                  <a href="#"></a>늘 믿고 맡기는 시터분이에요 항상 감사드려요!
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- 두번째 리뷰 -->
    <div class="container">
      <div class="row">
        <div
          class="col-sm-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3 col-xl-4 offset-xl-4"
        >
          <div class="review-user-card">
            <div class="review-divided">
              <div class="row">
                <div class="col-sm-3">
                  <div class="review-img">
                    <img
                      src="/resources/img/reviewProfile.jpg"
                      class="review-user-profile"
                      alt="profileImg"
                    />
                  </div>
                  <!-- 별 -->
                  <!-- 
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
                      <!-- 100가 아닐시 별이 깨짐;-->
                      <div class="star-rating">
                        <span style="width: 100%"></span>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- 별 end -->
              </div>
              <br />
              <div class="reviewMain text-center">
                <div class="review-user-addr">
                  <a href="#">인천 송도동</a>
                </div>
                <br />
                <br />
                <div class="review-main">
                  <a href="#"></a>너무 친절하고 좋아요!! 미쳤나봐 진쨔~~ 최공
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
		</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>