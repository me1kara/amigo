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
    	#rev_list::-webkit-scrollbar { display:none; }
    </style>
    <script>	
    
    //아임포트 결제api 구동, 
		function requestPay() {
			var IMP = window.IMP; 
			IMP.init("imp07716558"); 
		    IMP.request_pay({
		        pg : 'html5_inicis.INIpayTest',
		        pay_method : 'card',
		        merchant_uid: new Date().getTime(), 
		        name : '시터예약',
		        amount : '100', //${book.res_pay},테스트용으로 100원 고정
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
								let alink = '/requestBook.do?sit_no='+${sitter.sit_no }+'&merchant_uid='+process_result[1]+"";
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
							<div id="img_ex" style="margin:0 auto;">
				    		 <c:choose>
				     		 <c:when test="${not empty sitter.sit_photo}">
				     			<img src="/sitterimg/${sitter.sit_photo}" alt="sitterPicture" width="200px;" height="200px;" style="border-radius:20px;"/>
				     	 	 </c:when>
				     	 	 <c:otherwise>
				     	 	 	<img src="https://via.placeholder.com/200x200" alt="sitterPictureNull"/>
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
								<div id="rev_list" style="height: 300px; overflow: scroll; overflow-x:hidden; -ms-overflow-style:none;">
								<p style="font-family:Jalnan;font-size:20px;">후기<c:if test="${rev.size()>0 }">(${rev.size() })</c:if></p>
								<table style="margin:0 auto;">
								<c:choose>
								<c:when test="${not empty rev}">
									<c:forEach var="r"  items="${ rev }">
										<tr class="row">
											<td><c:choose>
						                         <c:when test="${r.getStar_cnt() == 1}">
						                            <img src="/resources/img/star1.png" style="width:50px;height:20px;">
						                         </c:when>
						                         <c:when test="${r.getStar_cnt() == 2}">
						                            <img src="/resources/img/star2.png" style="width:50px;height:20px;">
						                         </c:when>
						                         <c:when test="${r.getStar_cnt() == 3}">
						                            <img src="/resources/img/star3.png" style="width:50px;height:20px;">
						                         </c:when>
						                         <c:when test="${r.getStar_cnt() == 4}">
						                            <img src="/resources/img/star4.png" style="width:50px;height:20px;">
						                         </c:when>
						                         <c:when test="${r.getStar_cnt() == 5}">
						                            <img src="/resources/img/star5.png" style="width:50px;height:20px;">
						                         </c:when>
						                        </c:choose>
						                   </td>
											<th>${ r.getUser_nick() }</th>
											<td>${ r.getRev_content() }</td>										
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
										<tr><td class="text-center">리뷰가 없습니다!<tr>
								</c:otherwise>
								</c:choose>
								</table>
							</div>	
					</article>
				<article>
					<button type="button" class="btn btn-secondary" id="pay_btn" onclick="requestPay()">결제 및 신청</button>
				</article>
<%-- 			<a href="/requestBook.do?sit_no=${sitter.sit_no }">신청</a>
				<br>
				<a href="/view/review/user_review_insert.do?sit_no=${sitter.sit_no}&user_name=${sitter.user_name}">리뷰작성</a> --%><!-- 리뷰작성 컨트롤러로 진입 -->



<!-- 메시지 요청된 리소스 [/view/review/user_review_insert.do]은(는) 가용하지 않습니다. -->
<!-- 파일 [/view/review/view/review/review_insert.jsp]을(를) 찾을 수 없습니다. -->


















				</section>
			</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>