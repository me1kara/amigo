<%@page import="com.lec.amigo.vo.DogVO"%>
<%@page import="com.lec.amigo.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<% UserVO user=(UserVO)session.getAttribute("user");%>
<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-3.6.3.min.js"
integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
	crossorigin="anonymous"></script>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 풀캘린더 -->
<script src='/resources/fullcalendar-6.0.3/dist/index.global.js'></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/css/calendar.css" type="text/css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- 타임피커 -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>

<!-- 신청자격확인, 반려견이 등록된 사람만 가능 -->
<% List<DogVO> myDog_list = (List<DogVO>)session.getAttribute("myDog_list");
	if(myDog_list==null || myDog_list.isEmpty()){
		%>
		<script>
			alert('등록된 강아지가 없습니다!마이페이지에서 등록해주세요!');
			history.go(-1);
		</script>
		<% 
	}
%>

<script>
	//예약기능 달력 스크립트
      var calendar = null;
      var g_info = null;
      $(document).ready(function(){  
    	  
      	//달력 api
          var calendarEl = document.getElementById('calendar');
          calendar = new FullCalendar.Calendar(calendarEl, {
          	
            //한글, 크기 설정
            locale: "ko",
            initialView: 'dayGridMonth',
            width:400,
            selectable: true,
            editable: false,
            droppable: true,
            firstDay : 1,
            
        	  //달력내용수정
            eventClick:function(info) {
          	  modalOpen('modify',info);
            },
  		 //달력내용넣기
            select: function(info) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
          	  let date = new Date();
          	  if(info.start>new Date(date.setDate(date.getDate()+1))){
            		$('#eventStartTime').val('10:00');
          		$('#eventEndTime').val('12:00');
          	  	modalOpen('insert',info);
          	  }else{
          		  //예약가능날짜체크
          		  let arim =date.toLocaleDateString(date.setDate(date.getDate()+1));
          		  alert(arim.substr(0,arim.length-1)+"부터 예약가능합니다");
          		  
          	  }
          }});
          calendar.render();
        
        //시작시간 ui설정,타임피커
   		$('#eventStartTime').timepicker({
   			timeFormat: 'HH:mm',
 	        interval: 60,
 	        minTime: '10',
 	        maxTime: '6:00pm',
 	        defaultTime: '10',
 	        startTime: '10:00',
 	        dynamic: false,
 	        dropdown: true,
 	        scrollbar: true

 		});
        
        //끝시간 ui설정
   		$('#eventEndTime').timepicker({
   		 	timeFormat: 'HH:mm',
 	        interval: 60,
 	        minTime: '12',
 	        maxTime: '8:00pm',
 	        defaultTime: '12',
 	        startTime: '12:00',
 	        dynamic: false,
 	        dropdown: true,
 	        scrollbar: true,        
 		});
       
      });
     
      //예약내용
      function addEvent(g_info){
    	  	let title = $('#eventDog').val() + "," + $('#eventStartTime').val() + "~" + $('#eventEndTime').val();
			if($('#eventStartTime').val()=='' || $('#eventEndTime').val()==''){
				alert('시간을 입력해주세요!');
			}else{
				let startTime = $('#eventStartTime').val();
				let endTime = $('#eventEndTime').val();
 				let startTimeList = startTime.split(':');
				let endTimeList = endTime.split(':');		
				startTime = startTimeList[0] + startTimeList[1];
				endTime = endTimeList[0] + endTimeList[1];
				
				console.log("스타트:"+startTime);
				console.log("엔드:"+endTime);
				
				if(Number(startTime)+200>Number(endTime)){
					alert('2시간 간격으로 입력해주세요!');
				}else{
		            calendar.addEvent({
		            title: title,
		            start: g_info.start,
		            end: g_info.end,
		            allDay: g_info.allDay
		            })
		            calendar.unselect();
		            modalClose();
		            cost_cal();
				}

			}
     }
      //예약정보변경
      function modifyEvent(g_info){
			let start = $('#eventStartTime').val();
			let end = $('#eventEndTime').val();
		
			if(start=='' || end==''){
				alert('시간을 입력해주세요!');
			}else{
				let startTime = $('#eventStartTime').val();
				let endTime = $('#eventEndTime').val();			
 				let startTimeList = startTime.split(':');
				let endTimeList = endTime.split(':');		
				startTime = startTimeList[0] + startTimeList[1];
				endTime = endTimeList[0] + endTimeList[1];	
				
				//200인 이유는, 입력값이 3시20분 즉 1520 이라면 -> 1720 이 나와야하기때문
				if(Number(startTime)+200>Number(endTime)){
					alert('2시간 간격으로 입력해주세요!');
				}else{
	    			if(!startTime.includes(':')){
	    				startTime = startTime.substring(0,2) + ":" + startTime.substring(2,4);	
	    			}
	    			if(!endTime.includes(':')){
	    				endTime = endTime.substring(0,2) + ":" + endTime.substring(2,4);		
	    			}
					
					let title = $('#eventDog').val() + "," + startTime + "~" + endTime;
					
					console.log(title+"타이틀입니다");
					//이벤트에 수정값을 넣어줍니다.
		  		  	g_info.event.setProp('title', title);
		  		  	modalClose();
		  		  	cost_cal();
				}
				
			}
			
	
      }
      //예약내용지우기
      function deleteEvent(g_info){
			g_info.event.remove();
			modalClose();
			cost_cal();
      }
      
      //폼유효성검사
      function checkResult() {
    	var allEvent = calendar.getEvents();
    	
    	//예약내용체크
  	  	if(allEvent.length==0){
  	  		alert('예약일정을 등록해주세요!');
  	  		return false;
  	  	}else{
  	  		//내용이있으면 히든 input에 등록
  	  		sendBookDate();
  	  	}
  	  	
  	  	if($("input[name=res_visit_is]:radio:checked").length<1){
  	  		alert("방문여부를 선택해주세요!");
  	  		return false;
  	  	}
      }
      
      //예약정보 백단에 넘기기
      function sendBookDate(){
    	  var allEvent = calendar.getEvents();   	  
    	  console.log(allEvent);
    	  var events = new Array();
    	  for(let i=0; i< allEvent.length; i++){
    		  var obj = new Object();
    		  console.log(allEvent[i]);
    		  obj.title = allEvent[i]._def.title;
    		  obj.allday = allEvent[i]._def.allDay;
    		  obj.start = allEvent[i].startStr;
    		  obj.end = allEvent[i].endStr;		  
    		  events.push(obj);
    	  }
    	  let bookDate = JSON.stringify(events);
    	  $('#reciveBookData').val(bookDate);
      }
    </script>
<title>펫시터02_펫시터예약폼</title>
<!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->

<style>



   	body {
  padding-top: 50px;
  /* 생략 */
}
  	li {
	
  font-family: "Roboto", sans-serif;
  color: black;
  font-family: "Jalnan";
  font-size: 90%;
  
}
td {
	width: 100px;
	heigth: 500px;
}

.select {
	padding: 15px 10px;
}

.select input[type=radio] {
	display: none;
}

.select input[type=radio]+label {
	display: inline-block;
	cursor: pointer;
	height: 36px;
	width: 90px;
	border: 1px solid #333;
	line-height: 36px;
	text-align: center;
	font-weight: bold;
	font-size: 16px;
	width: 150px;
	border-radius: 5px;
}

.select input[type=radio]+label {
	background-color: #fff;
	color: #333;
	width: 150px;
}

.select input[type=radio]:checked+label {
	background-color: #333;
	color: #fff;
}

.etc_content {
	width: 100%;
	height: 80px;
	padding: 10px;
	box-sizing: border-box;
	border: solid 2px gray;
	border-radius: 5px;
	font-size: 16px;
	resize: both;
}

#address {
	border-radius: 5px;
	border: solid 2px gray;
}

.item_change {
	background: #d2d2d2;
	border-radius: 5px;
	border: none;
	margin-left: 5px;
	height: 30px;
}

.select input {
	border-radius: 5px;
	width: 150px;
}

.ctn_btn {
	width: 150px;
}

.inline_box {
	text-align: center;
}

.term_css {
	display: block;
}


<!-- 일정입력 모달창, 컨트롤 f 강아지 검색하면 돼요 -->
.modal{
	position:absolute;
	top:0; left:0;
	dispaly:none;
	background: rgba(0,0,0,0.8);
}

.fc-daygrid-day-number {
  text-decoration-line: none;
}

.fc-col-header-cell-cushion{
	text-decoration: none;
}

.fc-day{
	width:61.92px;
	hieght:25.61px;
	text-overflow:ellipsis;
}
.fc-day a{
	color : black;
}
.fc-day-sun a {
  color: red;
  text-decoration: none;
}
.fc-day-sat a {
  color: blue;
  text-decoration: none;
}

.fc-event-title-container{
	text-align: center;
}

.ui-timepicker { 
	font-size: 12px; width: 80px;
	background: white;
	position:relative;
	z-index: 1056;
}



.timepick {
	width:90px;
	border: 1px solid rgb(87, 160, 227);
	border-radius: 10px;
	padding-left:10px;
}

.modal_title {
	font-family: "Jalnan";
	color: color: rgb(87, 160, 227);
	padding-top:20px;
}



 #modal_content_st {
 	width:460px; 
 	margin:0 auto; 
 	margin-top:170px;
 	border-radius: 10px;
	box-shadow: 5px 2px 20px rgba(0,0,0,0.2);
 }
 
 #eventDog {
 	border: 1px solid rgb(87, 160, 227);
 	border-radius: 10px;
 	padding-left:10px;
 }

 h2 {
 	font-family: "Jalnan";
 }
 
   /* header nav css  */

      .nav-link {
        font-family: "Roboto", sans-serif;
        color: black;
        font-family: "Jalnan";
        font-size: 90%;
        border-bottom:20px;
      }

      .navbar-toggler {
        margin-left: 20px;
        width: 30px;
        display: contents;
      }

      .menu-trigger,
      .menu-trigger span {
        display: inline-block;
        transition: all 0.4s;
        box-sizing: border-box;
      }

      .menu-trigger {
        position: relative;
        width: 40px;
        height: 34px;
        margin-left: 30px;
      }

      .menu-trigger span {
        position: absolute;
        left: 0;
        width: 100%;
        height: 4px;
        background-color: gray;
        border-radius: 4px;
      }

      .menu-trigger span:nth-of-type(1) {
        top: 0;
      }

      .menu-trigger span:nth-of-type(2) {
        top: 15px;
      }

      .menu-trigger span:nth-of-type(3) {
        bottom: 0;
      }

      /* type-01 */
      /* 중앙 라인이 고정된 자리에서 투명하게 사라지며 상하라인 회전하며 엑스자 만들기 */
      .menu-trigger.active-1 span:nth-of-type(1) {
        -webkit-transform: translateY (15px) rotate (-45deg);
        transform: translateY(15px) rotate(-45deg);
      }

      .menu-trigger.active-1 span:nth-of-type(2) {
        opacity: 0;
      }

      .menu-trigger.active-1 span:nth-of-type(3) {
        -webkit-transform: translateY(-15px) rotate(45deg);
        transform: translateY(-15px) rotate(45deg);
      }


</style>

<script> 
		//약관동의 토글
    	function term_text_toggle(){
    		$('.term_text').toggle();
    	}
		//예약내용모달open
    	function modalOpen(path ,info){
    		g_info = info;
    		console.log(path);
 
			//수정,삽입 분기
    		if(path == 'modify'){	
    			//타이틀은 달력에 입력했었던 내용
    			let array = g_info.event.title.split(',');
    			let dog = array[0];
    			let time = array[1];
    
    			let startTime = time.split('~')[0];
    			let endTime = time.split('~')[1];
    			
    			if(!startTime.includes(':')){
    				startTime = startTime.substring(0,2) + ":" + startTime.substring(2,4);	
    			}
    			if(!endTime.includes(':')){
    				endTime = endTime.substring(0,2) + ":" + endTime.substring(2,4);		
    			}
    			
    			//타이틀을 가져와서 인풋에 미리 채워주기
    			$('#eventDog').val(dog);
    			$('#eventStartTime').val(startTime);
    			$('#eventEndTime').val(endTime);			
    			
    			
    			$('#eventModifyForm').fadeIn();
    			$('#modifyEvent').fadeIn();
    			$('#deleteEvent').fadeIn()
           		
    		}else if(path == 'insert'){
    			
    			$('#eventModifyForm').fadeIn();
    			$('#addEvent').fadeIn();
    		}
    		
    	}
    	
		
		//예약modal 닫기
    	function modalClose(){
			$('#addEvent').fadeOut();
			$('#modifyEvent').fadeOut();
			$('#deleteEvent').fadeOut();
    		$("#eventModifyForm").fadeOut();
    		$('#eventStartTime').val('');
			$('#eventEndTime').val('');
    	}
        
		//방문여부 선택 자바스크립트
        $('#select1').click(function(){
        	$('#select2').prop("checked", false);
        	$('#select1').prop("checked", true);
        });
        $('#select2').click(function(){
        	$('#select2').prop("checked", true);
        	$('#select1').prop("checked", false);
        });
</script>


<script>
//모달 스크립트
	function open_address_modal(){
		console.log('입장확인');
		$('#address_modal').show();
	}
	function close_address_modal(){
		$('#address_modal').hide();	
	}
</script>

<script>
	//예약금액계산
	function cost_cal() {
		var allEvent = calendar.getEvents();
		console.log(allEvent);
		var events = new Array();

		if (allEvent.length > 0) {
			for (let i = 0; i < allEvent.length; i++) {
				var obj = new Object();
				console.log(allEvent[i]);
				obj.title = allEvent[i]._def.title;
				obj.allday = allEvent[i]._def.allDay;
				obj.start = allEvent[i].startStr;
				obj.end = allEvent[i].endStr;
				events.push(obj);
			}
			let bookDate = JSON.stringify(events);
			
			//아작스로 비동기적 처리, json형태로 데이터 통신
			$.ajax({
				url : 'ajax/calMoney.do',
				type : 'POST',
				data : {
					'book_date' : bookDate
				},
				success : function(result) {
					//that.prop('name', data);
					console.log('결과:' + result);
					if (result != 0) {
						//서버에서 계산한 값 form에 넣기 
						$('#money').val(result); 
						$('#show_money').text(result + '원');
					} else {
						$('#money').val('');
						$('#show_money').text(' 0원');
					}
				}
			});
		} else {
			$('#money').val('');
		}
	}
</script>

</head>

<body>

	 <div class="container" style="padding-top: 50px;">
      <nav
        class="navbar navbar fixed-top navbar-light bg-light navbar-expand-custom navbar-mainbg"
      >
        <button
          class="navbar-toggler"
          type="button"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
        </button>
        <a
          class="logo"
          href="<%=request.getContextPath()%>/main_home.do?ubd_no=5"
          ><img alt="AmigoLogo" src="/resources/img/logo1.png"
        /></a>
         <c:choose>
          	<c:when test="${user.getUser_photo()!=null and user.getUser_photo()!=''}">
          	<img src="/userimg/${user.getUser_photo()}" style="border-radius:50px; margin-right:20px;" alt="userphoto" width="50px" height="50px" style="border-radius:10px" />
            </c:when>
            <c:otherwise>
            <img src="../../resources/img/logo2.png" style="border-radius:50px; margin-right:20px;" alt="logo2" width="50px" height="50px"/>
            </c:otherwise>
        </c:choose>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav ml-auto">
            <div class="hori-selector">
              <div class="left"></div>
              <div class="right"></div>
            </div>
            <hr />
            <li class="nav-nickName">
              <a
                class="nav-link"  
                href="<%=request.getContextPath() %>/my_profile.do"
                >${ user.getUser_nick() }</a
              >
            </li>
            <hr />
            <li class="nav-item">
              <a
                class="nav-link"
                href="<%=request.getContextPath() %>/view/mypage/my_page_list.jsp"
                >마이페이지</a
              >
            </li>
            <li class="nav-item active">
              <a class="nav-link" href="/book_check.do">예약확인</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/myChatList.do">채팅</a>
            </li>
            <li class="nav-item">
              <a
                class="nav-link"
                href="<%=request.getContextPath() %>/user_board_list.do"
                >커뮤니티</a
              >
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">아미고 파트너 모집</a>
            </li>
            <li class="nav-item">
              <a
                class="nav-link"
                href="<%=request.getContextPath() %>/cs_main.do"
                >고객센터</a
              >
            </li>
          </ul>
        </div>
      </nav>
    </div>
    <!-- 네비바 종료 -->
    <!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="/resources/js/script.js"></script>
    <script>
      var burger = $(".menu-trigger");

      burger.each(function (index) {
        var $this = $(this);

        $this.on("click", function (e) {
          e.preventDefault();
          $(this).toggleClass("active-" + (index + 1));
        });
      });
    </script>
    <!-- 네비바 종료 -->
	<!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="/resources/js/script.js"></script>
	<div class="container" style="width: 480px;">
		<section>
			<!-- 신청하기 이전, 유효성검사 -->
			<form action="book.do" onsubmit="return checkResult();" method="get">
			
				<!--방문여부 선택, radio사용  -->
				<article class="select" style="display: flex; justify-content: space-between; margin-top: 50px;">
					<input type="radio" id="select1" name="res_visit_is" value="true" checked="checked">
					<label class="ctn_btn" for="select1">방문</label> 
					<input type="radio" id="select2" name="res_visit_is" value="false">
					<label class="ctn_btn" for="select2">위탁</label>
				</article>

				<!-- 달력 프론트단에 호출 -->
				<article id='calendar-container' style="margin-top:20px;">
					<div id='calendar' name="calendar"></div>
				</article>
				
				
				<!-- 주소 -->
				<article style="margin-top:20px;">
					<b style="font-family: 'Jalnan';">이용주소</b>&nbsp;&nbsp;<input type="text" name="res_addr" id="address" required="required" readonly="readonly" style="width :300px; padding-left:10px;"
					value="<%=user.getUser_addr() %>"/>
					<!-- 주소모달 -->
					<button type="button" class="item_change" onclick="open_address_modal()" style="width:60px;">변경</button>
				</article>
				
				<article>
					<br> <br> <b style="font-family: 'Jalnan';">특이사항</b><br>
					<textarea class="etc_content" name="res_etc" rows="5" cols="16" style="margin-top:8px;"
						placeholder="펫시터분이 알아야 할 우리 아이에 대한 특이사항을 적어주세요!"></textarea>
					<br>
				</article>
				
				<!-- 예약내용 ajax로 얻어온 값 실반영 및 input 설정 -->
				<article class="inline_box">
					<b style="margin: 0 auto; font-family: 'Jalnan';">비용</b>&nbsp;<span id="show_money" style="font-size:22px;"> 0원</span>
					<input type="hidden" id="money" name="res_pay"></input>
				</article>
				
				
				<!-- 약관동의 토글 -->
				<article>
					<br> <label for="term" class="term_css"> <input
						type="checkbox" id="term" name="res_term_is" required="required"> <span style="font-family: 'Jalnan';">개인정보 이용
							동의<strong>(필수)</strong>
					</span>
					</label>
					&nbsp;<button type="button" class="btn" onclick="term_text_toggle()">더보기</button>		
					<input type="hidden" id="reciveBookData" name="bookDate">
					<br>
					<div class="term_text" style="height: 100px; overflow: auto; display: none;">
						여러분을 환영합니다. amigo 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 amigo
						서비스의 이용과 관련하여 amigo 서비스를 제공하는 amigo 주식회사(이하 ‘amigo’)와 이를 이용하는 amigo 서비스
						회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 amigo 서비스 이용에 도움이 될 수 있는 유익한
						정보를 포함하고 있습니다. amigo 서비스를 이용하시거나 amig 펫시터 서비스를 예약하실 경우 여러분은 본 약관 및 관련
						운영 정책을 확인하거나 동의하게 되므로, 잠시 시간을 내시어 주의 깊게 살펴봐 주시기 바랍니다.</div>
					<br>
				</article>
				
				<!-- 확인 시 유효성검사 -->
				<article style="display: flex; justify-content: space-between; margin-top:30px; margin-bottom:100px;">
					<button class="btn btn-primary ctn_btn" onclick="history.back(-1)">이전</button>
					<button type="submit" class="btn btn-primary ctn_btn">확인</button>
				</article>
			</form>




		</section>
	</div>	

	<%@include file="/includes/footer.jsp"%>
	
	
	<!-- 예약내용 작성모달 -->
	<div class="modal" id="eventModifyForm" style="display: none;">
		<div class="modal-content" id="modal_content_st">
		
			<div align="center" >
				
				<c:set var="myDog_list" value="<%=myDog_list %>"></c:set>
				<p class="modal_title">반려동물 선택</p>
				<select name="selectDog" id="eventDog">
						<c:if test="${myDog_list!=null }">					
							<c:forEach var="dog" items="${myDog_list }">
								<option value="${dog.getDog_name() }">${dog.getDog_name() }</option>	
							</c:forEach>
						</c:if>
				</select>
				<p class="modal_title">이용시간 선택</p>
				
				<div>
					<input type="text" id="eventStartTime" class="timepick" placeholder="시작시간"/>~<input type="text" id="eventEndTime" class="timepick" placeholder="끝시간"/>
				</div>
				
				<div style="margin:20px 0;">
				<button class="btn btn-secondary" type="button" id="modifyEvent" style="display: none; " onclick="modifyEvent(g_info)">수정</button>
				<button class="btn btn-danger" type="button" id="deleteEvent" style="display: none; "onclick="deleteEvent(g_info)">삭제</button>
				<button class="btn btn-dark" type="button" id="addEvent" style="display: none; "onclick="addEvent(g_info)">추가</button>
				<button class="btn btn-dark" type="button" onclick="modalClose()">닫기</button>
				</div>
				
			</div>
			
		</div>
	</div>

	<!-- 주소모달창 -->

	<div class="modal" id="address_modal" style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- 모달헤더 -->
				<div class="modal-header">
					<h4 class="modal-title">주소</h4>
					
					<!-- 모달닫기 -->
					<button type="button" class="btn-close" onclick="close_address_modal()"></button>

				</div>

				<!-- 모달바디 -->
				<div class="modal-body">


					<!-- 시작시 기본 날짜 설정은 value를 이용 -->
					<div class="form-group">

						<input type="text" id="p_postcode" placeholder="우편번호" disabled="disabled">
						<input type="button" onclick="p_execDaumPostcode()"
							value="우편번호 찾기"><br> <input type="text"
							id="p_roadAddress" class="form-control" name="user_addr"
							placeholder="도로명주소" readonly="readonly"> <input type="hidden"
							id="p_jibunAddress" class="form-control" placeholder="지번주소">
						<span id="guide" style="color: #999; display: none"></span> <input
							type="text" id="p_detailAddress" class="form-control"
							name="user_addr2" placeholder="상세주소">
					</div>


				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" id="address_submit" class="btn btn-secondary">확인</button>
				</div>

			</div>
		</div>
	</div>

	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
            	$('#address_submit').click(function(){
            	  	if($('#p_detailAddress').val() =='' || $("#p_roadAddress").val() == '' || $("#p_postcode").val() ==''){	
            	  		//$(this).removeAttr("data-bs-dismiss");
            	  	}else{
            	  		//$(this).attr("data-bs-dismiss", "modal");
            	  		let temp = $("#p_roadAddress").val() + '/' +$('#p_detailAddress').val();
            			$('#address').val(temp);
            	  		close_address_modal();
            	  	}
            	}) 
                //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
                function p_execDaumPostcode() {
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
                            document.getElementById('p_postcode').value = data.zonecode;
                            document.getElementById("p_roadAddress").value = roadAddr;
                            document.getElementById("p_jibunAddress").value = data.jibunAddress;
            
    
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