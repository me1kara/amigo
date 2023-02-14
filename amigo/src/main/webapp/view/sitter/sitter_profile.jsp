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
   <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>프로필01_시터 프로필 확인</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->

<% UserVO user = (UserVO)session.getAttribute("user"); 
%>    
    <style>
		.petsitter_name {
			font-family: "Jalnan";
			font-size:20px;
			padding-top:20px;
		}
    	
    	#profile_card {
    		margin: 0 auto;
    		width: 400px;
    		margin-top:50px;
    		margin-bottom:50px;
    		border-radius: 10px;
			box-shadow: 5px 2px 20px rgba(0,0,0,0.2);
    	}
    	
    	
    	.sitter_profile_title {
    		font-family: "Jalnan";
       		font-size:30px;
       		color: rgb(87, 160, 227);
    	}
    	
    	section {
    		margin-top:80px;
    	}
    	
    	#petsitter_title {
    		padding-top:20px;
    		
    	}
    	
    </style>
    <script>	
    
    //아임포트 결제api 구동, 
		function requestPay() {
			var IMP = window.IMP; 
			IMP.init("imp07716558"); 
		    IMP.request_pay({
		        pg : 'html5_inicis.INIpayTest',
		        pay_method : 'card',
		        merchant_uid: 'merchant_'+new Date().getTime(), 
		        name : '시터예약',
		        amount : '100', //${book.res_pay},
		        buyer_email : '<%=user.getUser_email()%>',
		        buyer_name : '<%=user.getUser_name()%>',
		        buyer_tel : '<%=user.getUser_phone()%>',
		        buyer_addr : '<%=user.getUser_addr()%>',
		        buyer_postcode : <%=user.getUser_no() %>
		    }, function (rsp) { // callback
		    	
		    	//결제성공시
		        if (rsp.success) {
		        	
		        	//백단에 내용전달
					$.ajax({
						url : 'ajax/payment.do',
						type : 'POST',
			            //dataType: 'json',
			            contentType: 'application/json; charset=utf-8',
						data : JSON.stringify(rsp),
						success : function(result) {
							console.log(result);
							
							//백단에 성공적으로 들어갔을시
							//실패시 자동환불(백단에서)
							let process_result = result.process_result.split(":");
 							if(process_result[0]=='결제성공'){
								alert('결제성공!');
								
								//성공시 완료페이지로 이동
								let alink = '/amigo/requestBook.do?sit_no='+${sitter.sit_no }+'&merchant_uid='+process_result[1]+"";
								console.log(alink);
								window.location.href = alink;
							}else{
								alert(process_result[1]);
							}

						},error: function(result){
							alert(result);
						}
					});
		        } else {
		            alert("결제실패!");
		        }
		    });
		}
</script>
</head>

<body>
	<%@include file="/includes/header.jsp" %>
			<div class="container text-center" >
				<section>
				
				<!-- 시터카드 -->
					<h2 class="sitter_profile_title"> 시터 프로필 정보</h2><hr>
					<article id="profile_card">
						<div id="petsitter_title">
							<div id="img_ex" style="border:1px solid; width:200px; height:200px; margin:0 auto;">
				    		 <c:choose>
				     		 <c:when test="${not empty sitter.sit_photo}">
				     			<img src="../../resources/img/${sitter.sit_photo}" alt="Profile Picture"/>
				     	 	 </c:when>
				     		 <c:otherwise>
				     			<span>Profile picture not available</span>
				     		 </c:otherwise>
				    		 </c:choose>
				    		 </div>
						 <p class="petsitter_name"><c:out value="${sitter.getUser_name()}"/> 펫시터</p>
				   		</div>	
				   		<hr>
						<div>
							 	<p>펫시터 전문가 교육 수료</p>
							 	<p>전문 펫시터 자격증 보유</p>
							 	<p>펫시터 직업훈련 교육 수료</p>
						</div>
								<hr>
								<div>후기</div>
								
							 <div class="container">
      <div class="row">
      <c:choose>
         <c:when test="${ rev.isEmpty() || rev == null }">
            <h6>등록된 게시판 정보가 존재하지 않습니다. 다시 확인해주세요.</h6>
         </c:when>
      <c:otherwise>
     	 <c:forEach var="rev" items="${ rev }">
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
                      src="../../resources/img/${rev.getUser_photo() }"
                      class="review-user-photo"
                      alt="userProfile"
                      width="50px"
                      class="mr-3 rounded-circle"
                    />
                    </c:when>
                    <c:otherwise>
                    <img src="../../resources/img/logo2.png" alt="logo2" width="50px" class="mr-3 rounded-circle" alt="logo2"/>
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
                      		<img src="../../resources/img/star1.png" style="width:150px;height:60px;">
                      	</c:when>
                      	<c:when test="${rev.getStar_cnt() == 2}">
                      		<img src="../../resources/img/star2.png" style="width:150px;height:60px;">
                      	</c:when>
                      	<c:when test="${rev.getStar_cnt() == 3}">
                      		<img src="../../resources/img/star3.png" style="width:150px;height:60px;">
                      	</c:when>
                      	<c:when test="${rev.getStar_cnt() == 4}">
                      		<img src="../../resources/img/star4.png" style="width:150px;height:60px;">
                      	</c:when>
                      	<c:when test="${rev.getStar_cnt() == 5}">
                      		<img src="../../resources/img/star5.png" style="width:150px;height:60px;">
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
								
					</article>
				<article>
				<article>
					<button type="button" class="btn btn-secondary" id="pay_btn" onclick="requestPay()">결제 및 신청</button>
				</article>
<%-- 			<a href="/amigo/requestBook.do?sit_no=${sitter.sit_no }">신청</a>
				<br>
				<a href="/amigo/view/review/user_review_insert.do?sit_no=${sitter.sit_no}&user_name=${sitter.user_name}">리뷰작성</a> --%><!-- 리뷰작성 컨트롤러로 진입 -->



<!-- 메시지 요청된 리소스 [/view/review/user_review_insert.do]은(는) 가용하지 않습니다. -->
<!-- 파일 [/view/review/view/review/review_insert.jsp]을(를) 찾을 수 없습니다. -->


















				</section>
			</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>