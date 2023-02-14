<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
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
    <link
      rel="stylesheet"
      type="text/css"
      href="/amigo/resources/css/style.css"
    />
    <meta charset="UTF-8" />
    <style>
      /* aimgo 메인 사진들 css */
      .img-fluid {
        border-radius: 20px;
        cursor: pointer;
        /* 그림자 */
        box-shadow: 5px 2px 20px rgba(0, 0, 0, 0.2);
      }
      
      .img-fluid:hover{
       box-shadow: 5px 2px 20px #69abce;
      }
      
      #card-last{
      box-shadow: 5px 2px 20px rgba(0, 0, 0, 0.2);
      }
      
      #card-last:hover{
       box-shadow: 5px 2px 20px #69abce;
      }

      /* 폰트 적용(여기어때 폰트)*/
      h4 {
        font-family: "Roboto", sans-serif;
        text-decoration: none;
        color: black;
        font-family: "Jalnan";
        font-size: 90%;
      }
      .all-view {
        font-family: "Roboto", sans-serif;
        text-decoration: none;
        color: gray;
        font-family: "Jalnan";
        font-size: 90%;
      }
      /* 폰트 적용 end */

      @import url(https://fonts.googleapis.com/css?family=Raleway:400,200,300,800);
      figure.snip0015 {
        font-family: "Roboto", sans-serif;
        color: #fff;
        position: relative;
        overflow: hidden;
        width: 100%;
        background: #000000;
        text-align: center;
        border-radius: 20px;
        box-shadow: 5px 2px 20px rgba(0, 0, 0, 0.2);
      }
      figure.snip0015 * {
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
      }
      figure.snip0015 img {
        opacity: 1;
        width: 100%;
        -webkit-transition: opacity 0.35s;
        transition: opacity 0.35s;
      }
      figure.snip0015 figcaption {
        position: absolute;
        bottom: 0;
        left: 0;
        padding: 3em 3em;
        width: 100%;
        height: 100%;
      }
      figure.snip0015 figcaption::before {
        position: absolute;
        top: 50%;
        right: 30px;
        bottom: 50%;
        left: 30px;
        border-top: 1px solid rgba(255, 255, 255, 0.8);
        border-bottom: 1px solid rgba(255, 255, 255, 0.8);
        content: "";
        opacity: 0;
        background-color: #ffffff;
        -webkit-transition: all 0.4s;
        transition: all 0.4s;
        -webkit-transition-delay: 0.6s;
        transition-delay: 0.6s;
      }
      figure.snip0015 h2,
      figure.snip0015 p {
        margin: 0 0 5px;
        opacity: 0;
        -webkit-transition: opacity 0.35s, -webkit-transform 0.35s;
        transition: opacity 0.35s, -webkit-transform 0.35s, -moz-transform 0.35s,
          -o-transform 0.35s, transform 0.35s;
      }
      figure.snip0015 h2 {
        word-spacing: -0.15em;
        font-weight: 300;
        text-transform: uppercase;
        -webkit-transform: translate3d(0%, 50%, 0);
        transform: translate3d(0%, 50%, 0);
        -webkit-transition-delay: 0.3s;
        transition-delay: 0.3s;
      }
      figure.snip0015 h2 span {
        font-weight: 800;
      }
      figure.snip0015 p {
        font-weight: 200;
        -webkit-transition-delay: 0s;
        transition-delay: 0s;
      }
      figure.snip0015 a {
        left: 0;
        right: 0;
        top: 0;
        bottom: 0;
        position: absolute;
        color: #ffffff;
      }
      figure.snip0015:hover img {
        opacity: 0.35;
      }
      figure.snip0015:hover figcaption h2 {
        opacity: 1;
        -webkit-transform: translate3d(0%, 0%, 0);
        transform: translate3d(0%, 0%, 0);
        -webkit-transition-delay: 0.3s;
        transition-delay: 0.3s;
      }
      figure.snip0015:hover figcaption p {
        opacity: 0.9;
        -webkit-transition-delay: 0.6s;
        transition-delay: 0.6s;
      }
      figure.snip0015:hover figcaption::before {
        background: rgba(255, 255, 255, 0);
        top: 30px;
        bottom: 30px;
        opacity: 1;
        -webkit-transition-delay: 0s;
        transition-delay: 0s;
      }
      
      /* 탑으로 스크롤 */
      a.top {
 	 position: fixed;
 	 left: 85%;
  	 bottom: 50px;
  	 display: none;
			}
			

    </style>

    <title>메인홈</title>
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
    <![endif]-->
  </head>
  <body>
    <%@include file="/includes/header.jsp" %>
    <div class="container">
      <!--   
		<a href="sitter/sitter_service_main.jsp">펫시터</a>
		<a href="#">추천산책루트</a>
		<a href="#">병원</a>
		<a href="#">고객센터</a>
		<a href="#">커뮤니티</a>
			-->

      <!-- 메뉴바 만들기 전에 임시로 채팅연결용으로 사용 
		<a href="view/customer_service/customer_service_chat.jsp">채팅목록</a>	
		-->

      <!-- Am!go 소개 -->
      <div class="container col-md-6 text-center" id="AmigoTop">
        <figure class="snip0015">
          <img
            src="/amigo/resources/img/MainPageImg.png"
            class="img-fluid"
            alt="amigoPet"
          />
          <figcaption>
            <h2>반가워요!! <span>AM!GO</span> 입니다!</h2>
            <p>
              당신곁에 항상 있는 우리의 반려동물들 그들을 위해서 만들어진
              곳이예요.
            </p>
            <p>혹시 당신의 AM!GO가 집에 혼자 남겨져있나요?</p>
            <p>걱정말고 AM!GO의 펫시터 앱을 이용해보세요 !</p>
            <a href="#"></a>
          </figcaption>
        </figure>
      </div>
      <!--소개 종료-->

      <!-- AM!GO 서비스 -->
      <!-- 차후에 아이콘으로 대체할것임.-->
      <div class="container overflow-hidden col-md-6 mb-5 mt-5">
        <h4>AM!GO서비스</h4>
        <div class="row gy-5">
          <!-- 펫시터 -->
          <div class="col-6">
            <div class="p-3">
              <a href="/amigo/view/sitter/sitter_service_main.jsp">
                <img
                  src="/amigo/resources/img/petsitter.png"
                  class="img-fluid"
                  alt="sitter"
                />
              </a>
            </div>
          </div>
          <!-- 펫시터 end -->
          <!-- 추천산책루트  -->
          <div class="col-6">
            <div class="p-3">
              <a href="<%=request.getContextPath() %>/view/trail/recommend_trail_list.jsp">
                <img
                  src="/amigo/resources/img/walking.png"
                  class="img-fluid"
                  alt="trail"
                />
              </a>
            </div>
          </div>
          <!-- 추천산책루트 end -->
          <!-- 병원 -->
          <div class="col-6">
            <div class="p-3">
              <a href="<%=request.getContextPath() %>/view/hospital/recommend_hospital_list.jsp">
                <img
                  src="/amigo/resources/img/hp.png"
                  class="img-fluid"
                  alt="hospital"
                />
              </a>
            </div>
          </div>
          <!-- 병원 end -->
          <!-- 고객센터 -->
          <div class="col-6">
            <div class="p-3">
              <a
                href="<%=request.getContextPath() %>/cs_main.do">
                <img
                  src="/amigo/resources/img/cs.png"
                  class="img-fluid"
                  alt="..."
                />
              </a>
            </div>
          </div>
          <!-- 고객센터 end -->
        </div>
      </div>
      <hr />
      <!-- 커뮤니티 -->
      <div class="container  col-md-6 mt-5">
        <div class="row justify-content-between">
          <div class="col-4">
            <h4>커뮤니티</h4>
          </div>
          <div class="col-4 text-end">
            <a href="user_board_list.do" class="all-view">전체보기</a>
          </div>
        </div>
        <div class="row text-center">
          <a href="user_board_list.do">
            <img
              src="/amigo/resources/img/community.png"
              class="img-fluid"
              alt="community"
            />
          </a>
        </div>
        <br />
        <div class="row text-center">
        <c:choose>
        <c:when test="${ sessionScope.user.getUser_type() == 'U' }">
          <a href="view/mypage/apply/sitter_join.do">
            <img
              src="/amigo/resources/img/needYou.png"
              class="img-fluid"
              alt="needYou"
            />
          </a>
         </c:when>
         <c:when test="${ sessionScope.user.getUser_type() == 'A' || sessionScope.user.getUser_type() == 'S'}">
           <a href="#">
            <img
              src="/amigo/resources/img/needYou.png"
              class="img-fluid"
              alt="needYou"
              onclick="alert('일반 회원만 신청 가능합니다')"
            />
          </a>
         </c:when>
         </c:choose>
         <!-- sitter_join 쪽 상단 이미지를 클릭하면 펫시터 지원 페이지로 감.  -->
         <!-- 펫시터 회원과 관리자는 지원을 제한함. -->
         
        </div>
      </div>
      <!-- 커뮤니티 종료-->
      <br />
           <!— 실시간 후기 —>
      <div class="container col-md-6 mt-5">
      <div class="row justify-content-between">
        <div class="col-4">
          <h4>실시간 후기</h4>
        </div>
        <div class="col-4 text-end">
          <a href="user_review_list.do" class="all-view">전체보기</a>
        </div>
      </div>
      <!--  실시간 후기 추가한부분-카드가 아래로 내려가버림. -->
      
      <div class="rating-card">
              <div class="text-center m-b-30">                                                    <!— $ {도그카운트} 로 강아지 테이블의 마릿수를 가져옴 —>
                <div class="review-member">
                  <a href="#">${dogCount}</a>마리의 친구들이 AM!GO와 함께했어요!
                </div>
                <br />
                <!--  점수  -->
                <h1 class="rating-number">${starsAverage}<small>/5</small></h1>
                <div class="rating-stars d-inline-block position-relative mr-2">
                  
                  <img src="amigo/resources/img/grey-star.svg" alt="" />
                  <div class="filled-star" style="width: 86%"></div>
                </div>
                                                               <!— 총 레이팅 : 별 갯수를 서버단에서 직접 가져옴. —>
                <div class="text-muted">${starsTotalCount } ratings</div>
      </div> 
      </div>
      <!--   후기 종료 -->
      <br />
      <!-- Q&A -->
      <div class="container col-md-6">
      <div class="row justify-content-between mt-5">
        <div class="col-4">
          <h4>Q&A</h4>
        </div>
        <div class="col-4 text-end">
          <a href="user_board_cate.do?ubd_cate=질문" class="all-view">전체보기</a>
        </div>
      </div>
      <div class="container card text-center" id="card-last" style="cursor:pointer; border-radius: 20px;" onclick="location.href='user_board_detail.do?ubd_no=5&updateCount_is=abd&cnt=3'">
      	<h5 class="card-title"><b>Q ${ board.getUbd_title() }</b></h5>
        	<small> ${ board.getUser_nick() } </small>
        <div class="card-body">
          <p class="card-text">
            ${ board.getUbd_cont() }
          </p>
        </div>
      </div>
      </div>
      <br />
      <!-- Q&A 종료 -->


    </div>
	<%@include file="/includes/scrollTop.jsp" %>
    <%@include file="/includes/footer.jsp" %>

    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
