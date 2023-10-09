<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script
  src="https://code.jquery.com/jquery-3.6.3.min.js"
  integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
  crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
  
  <!-- 아임포트 -->
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>my02_예약확인~예약취소</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
<style>

	.book_item{
		 margin-bottom: 20px;
		 padding: 20px;
	}
	.book_item:hover{
		cursor:pointer;
	}
	.modal{
		 position: absolute; top:0;left:0;
		 width:100%; height:100%;
		 background-color: rgba(0, 0, 0, 0.4);
		 display:none;
	}
	.modal_body {
		 position:absolute; top:50%;left:50%;
		 width: 400px;height: 400px;
		
		 padding: 40px;		
		 text-align: center;
		
		 background-color: rgb(255, 255, 255);
		 border-radius: 10px;
		 box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
		
		 transform: translateX(-50%) translateY(-50%);
	}
	.book_content{
		width: 100%;height: 90%;
	}

	table {
	  border-radius: 10px;
	  border-style: hidden;
	  box-shadow: 0 0 0 1.5px #000;
	  overflow: hidden;

	}
	#main_table{
	box-shadow: 5px 2px 20px rgb(0 0 0 / 20%);
	}
	.modal_tTitle{
		background:rgb(87, 160, 227);
		color:white;
	}
	
	.book_ch_title {
		font-family: "Jalnan";
		font-size: 30px;
		color : rgb(87, 160, 227);
	}
	
	.table-modal{
		box-shadow: 5px 2px 20px rgb(0 0 0 / 20%);
	}
	section {
		margin-top : 80px;
	}
	
	a:link, a:visited, a:hover, a:active {
	  color : blue;
	}
	
	
</style>

<script>

	//예약내용 모달 열기
	function open_book_modal(e){
		let rno = $(e).find("#book_res_no").text();

		let sit_name = $(e).find("#sit_name").text();
		let sit_no = $(e).find("#sit_no").text();
		
		console.log(sit_name, sit_no);
		//let res_state = $(e).find("#book_res_state").text();
		getBook_detail(rno, sit_name, sit_no);
		$('.modal').fadeIn();
		$('body').css("overflow", "hidden");
	}
	//예약내용 모달 닫기
	function close_book_modal(){
		$('.modal').fadeOut();
		$('.book_content').remove();
		$('.book_btn').remove();	
		$('body').css("overflow", "auto");
	}
	
	//예약내용모달 구하는 로직, ajax
	function getBook_detail(rno,user_name,sit_no){
 		$.ajax({
			url : '/ajax/getBook_detail.do',
			type : 'POST',
			data : {
				'rno' : rno
			},
			success : function(result) {
				let modalBody = $('.modal_body');
				if (result != null) {
					let temp='<ul class="book_content list-group" style="overflow: auto;">';
					result.forEach((content, index) =>{
						console.log(content);
						temp += '<li style="padding:5px;"><table class="table-sm table-bordered table-modal" border="2" style="width:95%;">';
						temp += '<tr style="border-bottom:solid 1px black;"><td style="width:20%;" class="modal_tTitle">일자</td><td style="width:50%;">' + content.res_date +'</td></tr>';
						temp += '<tr style="border-bottom:solid 1px black;"><td class="modal_tTitle">시간</td><td>' + content.res_time +'</td></tr>';
						temp += '<tr style="border-bottom:1px solid black; vertical-align: middle;"><td class="modal_tTitle">장소</td><td>' + content.res_addr +'</td></tr>';
						temp += '</table></li>';
					});
					temp+='</ul>';
					
					console.log(sit_no);
					console.log(user_name);
					
					//날짜 비교해서 취소하기 버튼 유무
					let res_start = new Date(result[0].res_date);
					let today = new Date();	
					let limitDay = new Date(res_start);
					limitDay.setDate(res_start.getDate()-1);
					console.log(today + limitDay + res_start);
					
					//이전기록,현재기록 확인하기,현재기록일시에만 취소버튼 나오게
					let cate;
					if('${searchVO.getSearchCategory()}'!=''){
						cate = '${searchVO.getSearchCategory()}';
					}
					if(today<limitDay){
						temp+='<button class="btn btn-light book_btn btn-outline-danger" onclick="book_delete('+rno+')" style="position:relative;">예약취소</button>';
					}else if(cate=='past'){
						temp+='<button class="btn btn-ligth book_btn btn-outline-info" style="position:relative;"><a href="/sit_review_list.do?sit_no='+sit_no+"&user_name="+user_name+'">리뷰목록</a></button>';
					}else{
						temp+='<button disabled="disabled" class="btn btn-light book_btn btn-outline-dark" style="position:relative;">취소불가</button>';
					}
					modalBody.append(temp);
				} else {
					alert('예약정보가 없습니다! 다시 시도해주세요!');
					close_book_modal();
				}
			}
		});
		
	}
	
	
	//예약취소함수
	function book_delete(rno){
		if(confirm('정말로 취소하시겠습니까?')){
			$.ajax({
				url  : '/ajax/deleteBook.do',
				type : 'POST',
				data : {
					'rno' : rno	
				},
				success : function(payment){
					if(payment!=null){
						history.go(0);
					}else{
						alert('삭제에 실패했습니다!');
					    close_book_modal();
					}
				},
			    error : function(request, status, error) { // 결과 에러 콜백함수
			        console.log(error);
			        alert('삭제에 실패했습니다!');
			        history.go(0);
			    }
			});
			
		}
	}
	
 	function cancelPay() {
		
	  } 
</script>
</head>
<body>
	<%@include file="/includes/header.jsp" %>
				<c:set var="rp" value="${searchVO.getRowSizePerPage()}" />
				<c:set var="cp" value="${searchVO.getCurPage()}" />
				<c:set var="fp" value="${searchVO.getFirstPage()}" />
				<c:set var="lp" value="${searchVO.getLastPage()}" />
				<c:set var="ps" value="${searchVO.getPageSize()}" />
				<c:set var="tp" value="${searchVO.getTotalPageCount()}" />
				<c:set var="sc" value="${searchVO.getSearchCategory()}" />
				<c:set var="sw" value="${searchVO.getSearchWord()}" />
		<div class="container text-center">
			<section>	
				<article>
					<div class="row">
						<h2 class="book_ch_title d-flex justify-content-center">예약 확인</h2>
						
						
					<!-- 현재기록, 과거기록 버튼, 시터모드 버튼-->
						<div class="d-flex justify-content-end">
						<c:if test='${user.getUser_type().equals("S") }'>
							<button class="btn" onclick="location.href='/receiveBook_check.do'"><b>시터모드</b></button>
						</c:if>
						<c:choose>
						<c:when test="${sc eq 'past' }">
							<button class="btn" onclick="location.href='book_check.do?mode=user'"><b>현재예약</b></button>
						</c:when>
						<c:otherwise>
							<button class="btn" onclick="location.href='book_check.do?searchCategory=past&mode=user'"><b>이전예약</b></button>
						</c:otherwise>
						</c:choose>
						</div>
					 </div>
					<hr>
					
				</article>
					<article id="user_book">
						<c:choose>
						<c:when test="${!myBookList.isEmpty()}">	
							<ul style="list-style: none;">
							<c:forEach var="book" items="${myBookList }">
								<c:forEach var="sit" items="${sitList }">
								<c:if test="${ book.getSit_no()==sit.getSit_no()}">
								<li class="book_item">
									<table class="table" id="main_table">
										<tbody onclick="open_book_modal(this)">
										<tr style="background:rgb(87, 160, 227);"><th colspan="2" style="text-align: center; color:white;">${sit.getUser_name() } 펫시터</th></tr>
										<tr>
											<th class="tTitle" style="width:35%;">예약번호</th><td id="book_res_no" style="width:65%;">${book.res_no }</td>
										</tr>
										<tr>
											<th class="tTitle">방문여부</th>
											<th colspan="2" style="color:blue;'">
												
												<c:choose>
													<c:when test="${book.res_visit_is }">
														방문
													</c:when> 
													<c:otherwise>
														위탁
													</c:otherwise>
												</c:choose>
												
											</th>
										</tr>
										<tr>
											<th class="tTitle">예약일자</th><td>${book.res_regdate }</td>
										</tr>
										<tr>
											<th class="tTitle">예약날짜</th><td>${book.getRes_date() }</td>
										</tr>
										<tr>
											<th class="tTitle">결제금액</th><td><fmt:formatNumber value="${book.getRes_pay() }" pattern="#,###"/>원</td>
										</tr>
										<tr style="display: none;">
											<td id="sit_no">${sit.sit_no }</td>
										</tr>
										<tr style="display: none;">
											<td id="sit_name">${sit.user_name }</td>
										</tr>
										</tbody>
									</table>
								</li>
												
								</c:if>	
								</c:forEach>
							</c:forEach>
							</ul>
							
							<!-- 페이징처리 -->
								<div class="row align-items-start mt-3">
									<ul class="col pagination justify-content-center">
										<c:if test="${ fp != 1 }">
											<li class="page-item"><a
												href="book_check.do?curPage=1&rowSizePerPage=${rp}&searchCategory=${sc}&searchWord=${sw}&mode=user"
												class="page-link"><i class="fas fa-fast-backward"></i></a></li>
											<li class="page-item"><a
												href="book_check.do?curPage=${fp-1}&rowSizePerPage=${rp}&searchCategory=${sc}&searchWord=${sw}&mode=user"
												class="page-link"><i class="fas fa-backward"></i></a></li>
										</c:if>

										<c:forEach var="page" begin="${fp}" end="${lp}">
											<li class="page-item ${cp==page ? 'active' : ''}"><a
												href="book_check.do?curPage=${page}&rowSizePerPage=${rp}&searchCategory=${sc}&searchWord=${sw}&mode=user"
												class="page-link">${page}</a></li>
										</c:forEach>

										<c:if test="${ lp < tp }">
											<li class="page-item "><a
												href="book_check.do?curPage=${lp+1}&rowSizePerPage=${rp}&searchCategory=${sc}&searchWord=${sw}&mode=user"
												class="page-link"><i class="fas fa-forward"></i></a></li>
											<li class="page-item"><a
												href="book_check.do?curPage=${tp}&rowSizePerPage=${rp}&searchCategory=${sc}&searchWord=${sw}&mode=user"
												class="page-link"><i class="fas fa-fast-forward"></i></a></li>
										</c:if>
									</ul>
								</div>
								<!-- 페이징 -->
							</c:when>
						<c:otherwise>
							<h2 id="user_book">예약사항이 없습니다</h2>
						</c:otherwise>
						</c:choose>
					</article>
				
			</section>	
		</div>
		
		<!-- 예약내용모달 껍데기, 실내용은 ajax로 덧붙임 -->
		
		<div class="modal">
			<div class="modal_body">
				<button class="btn-close btn-dark" style="position: relative; left:50%; top: -5%" onclick="close_book_modal()"></button>
			</div>
			
		</div>
				
		
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>