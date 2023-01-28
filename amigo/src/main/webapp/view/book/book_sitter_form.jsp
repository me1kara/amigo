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


<!--한국어 달력 쓰려면 추가 로드-->
<script src="resources/js/plugin/datepicker/bootstrap-datepicker.ko.min.js"></script>  
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">

<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link  rel="stylesheet" href="/amigo/resources/css/calendar.css" type="text/css">
<script type="text/javascript" src="/amigo/resources/js/calendar.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script src='<%=request.getContextPath() %>/resources/fullcalendar-6.0.3/dist/index.global.js'></script>
    <script>
    
      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth',
          contentHeight: 300,
          selectable: true,
          editable: true,
          droppable: true,
          eventDrop: function (info){
              console.log(info);
              if(confirm("'"+ info.event.title +"'수정하시겠습니까 ?")){
              }
              var events = new Array(); // Json 데이터를 받기 위한 배열 선언
              var obj = new Object();

              obj.title = info.event._def.title;
              obj.start = info.event._instance.range.start;
              obj.end = info.event._instance.range.end;
              events.push(obj);

              console.log(events);
              $(function deleteData() {
                  $.ajax({
                      url: "/full-calendar/calendar-admin-update",
                      method: "PATCH",
                      dataType: "json",
                      data: JSON.stringify(events),
                      contentType: 'application/json',
                  })
              })
          },
			
          events: [
        	    {
        	      title: 'Event1',
        	      start: '2023-01-07'
        	    },
        	    {
        	      id : 'hello',
        	      className : 'he',
        	      title: 'gg',
        	      start: '2023-01-05',
              	  color: 'yellow',   // an option!
                  textColor: 'black'
        	    }
           ],
          select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
              var title = prompt('일정 입력');
              if (title) {
                  calendar.addEvent({
                  title: title,
                  start: arg.start,
                  end: arg.end,
                  allDay: arg.allDay
                })
              }
              calendar.unselect()
            }
        
          /*
          dateClick: function(info) {
        	  
      	    alert('Clicked on: ' + info.dateStr);
      	  	alert('Clicked on: ' + info.dayEl);
      	  	alert('Clicked on: ' + info.view);
      	  	
      	  	
      	    // change the day's background color just for fun
      	    info.dayEl.style.backgroundColor = 'blue';
        }*/
        });
        calendar.render();
      });

    </script>
<title>펫시터02_펫시터예약폼</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
    
      
    <style>
    	td{
    		width:100px;heigth:500px;
    	}
		.select {
		    padding: 15px 10px;
		}
		.select input[type=radio]{
		    display: none;
		}
		.select input[type=radio]+label{
		    display: inline-block;
		    cursor: pointer;
		    height: 36px;
		    width: 90px;
		    border: 1px solid #333;
		    line-height: 36px;
		    text-align: center;
		    font-weight:bold;
		    font-size:16px;
		    width:150px;
		    border-radius: 5px;
		}
		.select input[type=radio]+label{
		    background-color: #fff;
		    color: #333;
		    width:150px; 
		}
		.select input[type=radio]:checked+label{
		    background-color: #333;
		    color: #fff;
		}
		.etc_content{
			width: 100%;
			height: 80px;
			padding: 10px;
			box-sizing: border-box;
			border: solid 2px gray;
			border-radius: 5px;
			font-size: 16px;
			resize: both;
		}
		#address{
			border-radius: 5px;
			border: solid 2px gray;
		}
		.item_change{
			background: #d2d2d2;
			border-radius: 5px;
			border: none;	
			margin-left: 5px;
			height: 30px;
		}
		.select input{
			border-radius: 5px;
			width:150px;
		}
		.ctn_btn{
			width:150px;
		}
		.inline_box{
			text-align: center;
		}
		.term_css {
  			display: block;
		}
    </style>
    
    <script>   
    	$(document).ready(function(){ 
    		$('.term_text').hide();    		
    	});
    	function term_text_toggle(){
    		$('.term_text').toggle();
    	}
    </script>
</head>

<% UserVO user=(UserVO)session.getAttribute("user");%>

<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container-sm" style="width:480px;">
			
			
		
			<form action="book.do">
			<div class="select" style="display:flex; justify-content: space-between;">
     			<input type="radio" id="select1" name="shop" value="visit"><label class="ctn_btn" for="select1">방문</label>
     			<input type="radio" id="select2" name="shop" value="consign"><label class="ctn_btn" for="select2">위탁</label>
			</div>
					
			<!-- 
			<br>
			<b>예약날짜</b>
			<br>
			<div class="sec_cal">
			  <div class="cal_nav">
			    <a href="javascript:;" class="nav-btn go-prev">prev</a>
			    <div class="year-month"></div>
			    <a href="javascript:;" class="nav-btn go-next">next</a>
			  </div>
			  <div class="cal_wrap">
			    <div class="days">
			      <div class="day">월</div>
			      <div class="day">화</div>
			      <div class="day">수</div>
			      <div class="day">목</div>
			      <div class="day">금</div>
			      <div class="day">토</div>
			      <div class="day">일</div>
			    </div>
			    <div class="dates"></div>
			  </div>
			</div>
			 -->
			
		  	<div id='calendar-container'>
    			<div id='calendar'></div>
  			</div>
  			
  			<br>
			<b>이용주소</b> <input type="text" name="address" id="address" /><button type="button" class="item_change" data-bs-toggle="modal" data-bs-target="#address_modal">변경</button><br>
			
			<br>
			<b>특이사항</b><br>
			<textarea class="etc_content" name="etc_content" rows="5" cols="16" placeholder="펫시터분이 알아야 할 우리 아이에 대한 특이사항을 적어주세요!"></textarea><br>
			
			
			<div class="inline_box">
				<b style="margin: 0 auto;">비용</b>
			</div>
			
			<br>
			
			<label for="term" class="term_css">
  				<input type="checkbox" name="term" value="3">
  				<span>개인정보 이용 동의<strong>(필수)</strong></span>
			</label>
      		
			<button type="button" class="btn" onclick="term_text_toggle()">더보기</button><br>
			<div class="term_text" style="height: 100px; overflow: auto;">
                여러분을 환영합니다. amigo 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 amigo
                서비스의 이용과 관련하여 amigo 서비스를 제공하는 amigo 주식회사(이하 ‘JUN’)와 이를 이용하는 JUN 서비스
                회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 JUN 서비스 이용에 도움이 될 수 있는
                유익한 정보를 포함하고 있습니다. JUN 서비스를 이용하시거나 JUN 서비스 회원으로 가입하실 경우 여러분은 본
                약관 및 관련 운영 정책을 확인하거나 동의하게 되므로, 잠시 시간을 내시어 주의 깊게 살펴봐 주시기
                바랍니다.
             </div>
			<br>
			<div style="display:flex; justify-content: space-between;">
				<button class="btn btn-primary ctn_btn" onclick="history.back(-1)">이전</button>
				<button type="submit" class="btn btn-primary ctn_btn">확인</button>
			</div>
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
		
   <!-- 시작시 기본 날짜 설정은 value를 이용 -->
   		
   		<input type="text" id="datepicker" class="form-control"/>
      	
        
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<div class="modal" id="address_modal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">주소</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        
      </div>

      <!-- Modal body -->
      <div class="modal-body">
		

   <!-- 시작시 기본 날짜 설정은 value를 이용 -->
   		           <div class="form-group">
               
               <input type="text" id="sample4_postcode" placeholder="우편번호">
               <input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
               <input type="text" id="sample4_roadAddress" class="form-control" name="user_addr" placeholder="도로명주소">
               <input type="hidden" id="sample4_jibunAddress" class="form-control" placeholder="지번주소">
               <span id="guide" style="color:#999;display:none"></span>
               <input type="text" id="sample4_detailAddress" class="form-control" name="user_addr2" placeholder="상세주소">
                </div>
                
        
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" id="address_submit" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
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

	 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
            <script>
            	$('#address_submit').click(function(){
            			$('#address').val($("#sample4_roadAddress").val() + $("#sample4_jibunAddress").val());
            		}
            	);
                //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
                function sample4_execDaumPostcode() {
                    new daum.Postcode({
                        oncomplete: function(data) {
                            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            
                            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                            var roadAddr = data.roadAddress; // 도로명 주소 변수
                            var extraRoadAddr = ''; // 참고 항목 변수
            
                            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                                extraRoadAddr += data.bname;
                            }
                            // 건물명이 있고, 공동주택일 경우 추가한다.
                            if(data.buildingName !== '' && data.apartment === 'Y'){
                               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                            if(extraRoadAddr !== ''){
                                extraRoadAddr = ' (' + extraRoadAddr + ')';
                            }
            
                            // 우편번호와 주소 정보를 해당 필드에 넣는다.
                            document.getElementById('sample4_postcode').value = data.zonecode;
                            document.getElementById("sample4_roadAddress").value = roadAddr;
                            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            
    
                            var guideTextBox = document.getElementById("guide");
                            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                            if(data.autoRoadAddress) {
                                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                                guideTextBox.style.display = 'block';
            
                            } else if(data.autoJibunAddress) {
                                var expJibunAddr = data.autoJibunAddress;
                                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                                guideTextBox.style.display = 'block';
                            } else {
                                guideTextBox.innerHTML = '';
                                guideTextBox.style.display = 'none';
                            }
                        }
                    }).open();
                }
            </script>
</body>
</html>