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
  <script src="test.json" type="text/javascript"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>산책04_추천산책로</title>
<style>
/* 레이아웃 외곽 너비 400px 제한*/
.wrap{
    max-width: 480px;
    margin: 0 auto; /* 화면 가운데로 */
    background-color: #fff;
    height: 100%;
    padding: 20px;
    box-sizing: border-box;

}
.reviewform textarea{
    width: 100%;
    padding: 10px;
    box-sizing: border-box;
}
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

.warning_msg {
    display: none;
    position: relative;
    text-align: center;
    background: #ffffff;
    line-height: 26px;
    width: 100%;
    color: red;
    padding: 10px;
    box-sizing: border-box;
    border: 1px solid #e0e0e0;
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
         <c:if test="${ boardList.isEmpty() || boardList == null }">
            <p align="center">등록된 후기 정보가 존재하지 않습니다.</p>
         </c:if>
              
            <!-- 후기 리스트 -->
            <c:forEach  var="board" items="${ boardList }">
            <div class="inner-main-body p-2 p-sm-3 forum-content show" >
                  <div class="media forum-item">
                    <div class="media-body">
                      <!-- 후기글 -->
                      <span> ${board.getReply_cnt()}</span>
                      <!-- 작성자 -->
                        <span class="nickName" style="color:#498dcc; font-weight:bold">${ board.getUser_nick() }</span>&nbsp;    
                    </div>
                  </div>
            </div>
            </c:forEach>
         </div>
        <!-- 페이징 -->
      <c:if test="${ searchVO.getCurPage()> 1 }">
      <div class="row align-items-start mt-3">
         <ul class="col pagination justify-content-center">
         
            <c:set var="cp" value="${searchVO.getCurPage()}"/>
            <c:set var="rp" value="${searchVO.getRowSizePerPage()}"/>
            <c:set var="fp" value="${searchVO.getFirstPage()}"/>
            <c:set var="lp" value="${searchVO.getLastPage()}"/>
            <c:set var="ps" value="${searchVO.getPageSize()}"/>
            <c:set var="tp" value="${searchVO.getTotalPageCount()}"/>
    <!--    <c:set var="sc" value="${searchVO.getSearchCategory()}"/>
            <c:set var="st" value="${searchVO.getSearchType()}"/>
            <c:set var="sw" value="${searchVO.getSearchWord()}"/>  
     -->                                           
            <c:if test="${ fp != 1 }">
               <li class="page-item"><a href="user_board_list.do?curPage=1&rowSizePerPage=${rp}" class="page-link"><i class="fas fa-fast-backward"></i></a></li>
               <li class="page-item"><a href="user_board_list.do?curPage=${fp-1}&rowSizePerPage=${rp}" class="page-link"><i class="fas fa-backward"></i></a></li>            
            </c:if>
         
            <c:forEach var="page" begin="${fp}" end="${lp}">
               <li class="page-item ${cp==page ? 'active' : ''}"><a href="user_board_list.do?curPage=${page}&rowSizePerPage=${rp}" class="page-link">${page}</a></li>
            </c:forEach>
            
            <c:if test="${ lp < tp }">
               <li class="page-item "><a href="user_board_list.do?curPage=${lp+1}&rowSizePerPage=${rp}" class="page-link"><i class="fas fa-forward"></i></a></li>            
               <li class="page-item"><a href="user_board_list.do?curPage=${tp}&rowSizePerPage=${rp}" class="page-link"><i class="fas fa-fast-forward"></i></a></li>            
            </c:if>
         </ul> <!-- pagination -->     
      </div> 
		</c:if>	    
	  		   <!-- 후기 작성 폼 --> 
   						 <h4>후기</h4><p>별점과 리뷰를 남겨주세요.</p>
			    <form role="form" class="reviewform container" method="post" action="insertTrailReview.do">
			        <input type="hidden" name="route_no" id="rate" value='${route_no}'>

			        <div class="review_rating">
			            <div class="warning_msg">별점을 선택해 주세요.</div>
			            <div class="rating">
			                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
			                <input type="checkbox" name="walk_star" id="rating1" value="1" class="rate_radio" title="1점">
			                <label for="rating1"></label>
			                <input type="checkbox" name="walk_star" id="rating2" value="2" class="rate_radio" title="2점">
			                <label for="rating2"></label>
			                <input type="checkbox" name="walk_star" id="rating3" value="3" class="rate_radio" title="3점" >
			                <label for="rating3"></label>
			                <input type="checkbox" name="walk_star" id="rating4" value="4" class="rate_radio" title="4점">
			                <label for="rating4"></label>
			                <input type="checkbox" name="walk_star" id="rating5" value="5" class="rate_radio" title="5점">
			                <label for="rating5"></label>
			            </div>
			        </div>
			        <div class="review_contents">
			            <div class="warning_msg">5자 이상으로 작성해 주세요.</div>
			            <textarea rows="6" class="review_textarea" name="walk_cont" placeholder="후기는 5~400자를 써주세요."></textarea>
			        </div>   
			            <button type="submit" id="save" class="btn btn-primary">등록</button>
			    </form>   
			       
		</div>		
	<%@include file="/includes/footer.jsp" %>
	
</body>
</html>

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


//별점 마킹 모듈 프로토타입으로 생성
function Rating(){};
Rating.prototype.rate = 0;
Rating.prototype.setRate = function(newrate){
    //별점 마킹 - 클릭한 별 이하 모든 별 체크 처리
    this.rate = newrate;
    let items = document.querySelectorAll('.rate_radio');
    items.forEach(function(item, idx){
        if(idx < newrate){
            item.checked = true;
        }else{
            item.checked = false;
        }
    });
}
let rating = new Rating();//별점 인스턴스 생성

document.addEventListener('DOMContentLoaded', function(){
    //별점선택 이벤트 리스너
    document.querySelector('.rating').addEventListener('click',function(e){
        let elem = e.target;
        if(elem.classList.contains('rate_radio')){
            rating.setRate(parseInt(elem.value));
        }
    })
});

//상품평 작성 글자수 초과 체크 이벤트 리스너
document.querySelector('.review_textarea').addEventListener('keydown',function(){
    //리뷰 400자 초과 안되게 자동 자름
    let review = document.querySelector('.review_textarea');
    let lengthCheckEx = /^.{400,}$/;
    if(lengthCheckEx.test(review.value)){
        //400자 초과 컷
        review.value = review.value.substr(0,400);
    }
});

//저장 전송전 필드 체크 이벤트 리스너
document.querySelector('#save').addEventListener('click', function(e){
    //별점 선택 안했으면 메시지 표시
    if(rating.rate == 0){
        rating.showMessage('rate');
        return false;
    }
    //리뷰 5자 미만이면 메시지 표시
    if(document.querySelector('.review_textarea').value.length < 5){
        rating.showMessage('review');
        return false;
    }
    //폼 서밋
});

Rating.prototype.showMessage = function(type){//경고메시지 표시
    switch(type){
        case 'rate':
            //안내메시지 표시
            document.querySelector('.review_rating .warning_msg').style.display = 'block';
            //지정된 시간 후 안내 메시지 감춤
            setTimeout(function(){
                document.querySelector('.review_rating .warning_msg').style.display = 'none';
            },1000);            
            break;
        case 'review':
            //안내메시지 표시
            document.querySelector('.review_contents .warning_msg').style.display = 'block';
            //지정된 시간 후 안내 메시지 감춤
            setTimeout(function(){
                document.querySelector('.review_contents .warning_msg').style.display = 'none';
            },1000);    
            break;
    }
}
</script>