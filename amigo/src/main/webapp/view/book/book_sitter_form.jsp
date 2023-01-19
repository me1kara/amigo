<%@page import="com.lec.amigo.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="resources/css/plugin/datepicker/bootstrap-datepicker.css">

<script
  src="https://code.jquery.com/jquery-3.6.3.min.js"
  integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
  crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="resources/js/plugin/datepicker/bootstrap-datepicker.js"></script>


<!--한국어  달력 쓰려면 추가 로드-->
<script src="resources/js/plugin/datepicker/bootstrap-datepicker.ko.min.js"></script>  
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<title>펫시터02_펫시터예약폼</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
    
        
    <style>
    	td{
    		width:100px;heigth:500px;
    	}
    </style>
</head>

<% UserVO user=(UserVO)session.getAttribute("user");%>

<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container">
			
			
			<form action="book.do">
					
			<button class="btn btn-secondary">방문</button>
			<button class="btn btn-secondary">위탁</button>
			
			<br>
			<b>예약날짜</b>
			
			<br>
			
			
			<button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#calendar">
				<img src="http://192.168.0.101:8088/amigo/resources/img/dool.png" alt="달력" /> 	
			</button><br>
			
			이용주소 <input type="text" name="address" value="" /><button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#address">변경</button><br>
			휴대전화 <input type="text" name="phone" value=""/><button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#phone">변경</button><br>
			
			<b>특이사항</b><br>
			<textarea></textarea><br>
			
			<b>비용:30000원</b><br>
			
			<b>개인정보이용동의</b><br>
			
			
			
			
			
			<div class="btn" data-bs-toggle="collapse" data-bs-target="#term">더보기</div><br>
			
			<p id="term" class="collapse">얼마나 튼튼하며 그들의 피부가 얼마나ㅁㄴㅇㅁㄴㅇㄴㅁㅇ</p>
			
			<button class="btn btn-primary" onclick="history.back(-1)">이전</button>
			<button type="submit" class="btn btn-primary">확인</button>
			</form>
			
			
			
			

		</div>
		
	<%@include file="/includes/footer.jsp" %>
	
	
<!-- 모달창 -->
	
<div class="modal" id="calendar">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">예약날짜 모달창</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        
      </div>

      <!-- Modal body -->
      <div class="modal-body">


		<body>
   <!-- 시작시 기본 날짜 설정은 value를 이용 -->
   		<input type="text" id="datepicker" class="form-control"/>
		</body>
      	
        
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<div class="modal" id="address">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">주소변경 모달창</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        
      </div>

      <!-- Modal body -->
      <div class="modal-body">


		<body>
   <!-- 시작시 기본 날짜 설정은 value를 이용 -->
   		<input type="text" id="datepicker" class="form-control"/>
		</body>
      	
        
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<div class="modal" id="phone">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">휴대폰변경 모달창</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
		<body>
   <!-- 시작시 기본 날짜 설정은 value를 이용 -->
   		<input type="text" id="datepicker" class="form-control"/>
   		
   		
		</body>
      	
        
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>


      	<script>
   	$(function() {
    	   //input을 datepicker로 선언
       $("#datepicker").datepicker({
           dateFormat: 'yy-mm-dd' //달력 날짜 형태
           ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
           ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
           ,changeYear: true //option값 년 선택 가능
           ,changeMonth: true //option값  월 선택 가능                
           ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
           ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
           ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
           ,buttonText: "선택" //버튼 호버 텍스트              
           ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
           ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
           ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip
           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
           ,minDate: "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
           ,maxDate: "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
       });                    
       
       //초기값을 오늘 날짜로 설정해줘야 합니다.
       $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
   });
</script>
	
</body>
</html>