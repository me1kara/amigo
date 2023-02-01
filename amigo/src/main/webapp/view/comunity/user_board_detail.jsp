<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script
  src="https://code.jquery.com/jquery-3.6.3.min.js"
  integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
  crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<style>
	.ubd-group {
		/*애플그레이*/
		color:rgb(153,153,153);
		
	}
	
	.heart{
		cursor : pointer;
		
	}

</style>
<title>게시판04_글상세내용~05_글삭제</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
				 
	<%@include file="/includes/header.jsp" %>
			<div class="container mt-3">
		
		<!-- 수정본 글쓰기 start -->
		<div class="container mt-5">
			<div class="container">
				<!-- 제목 -->
				<h4>${ board.getUbd_title() }</h4>
			</div>
			<div class="container text-start">
			<!-- 작성자 -->
			<!-- 이미지를 받아와야할거 같은데 참고: https://okky.kr/articles/1131945 -->
			
			
			<a href="#">${ board.getUser_nick() }</a>
			<div class="ubd-group">
			<!-- 등록일 -->
			<span>${ board.getUbd_date() }</span>
			<!-- 조회 -->
			<span>조회수 ${ board.ubd_cnt }</span>
			<!-- 추천 -->
			<span>좋아요 ${board.getLike_cnt()}</span>
			</div>	
			</div>		
		</div>		
		<hr/>
		<br/>
		<!-- 수정본 글쓰기 end -->
		<!-- 글작성 내용 start -->
		<div>
		<a>${ board.getUbd_cont() }</a>
		<br/>
		<a>
		<c:if test="${board.getUbd_file()!=null and board.getUbd_file()!=''}">
			<c:forEach items="${fileSplit}" var="file">
				<img src="/img/${file}" width="300px" height="300px"><br><br>
			</c:forEach>
		</c:if>
		</a>
		
		</div>
		<!-- 글작성 내용 end -->
		
		<!--  추천  -->
			<br>
			<div class="container text-center">
				<a class="heart" style="text-decoration-line: none;">
					<img id="heart" src="resources/img/heart.svg">
					좋아요
				</a>
			</div>
		<!-- 추천 -->
		<hr/>
		
		
			
			<div align="left">
				댓글(${ board.getReply_cnt() }) <hr> 
				<ul>
					<c:forEach items="${replyList}" var="reply">
								<script>
									function deleteReply(ubd_r_no) {
									if(confirm("이 댓글을 삭제하겠습니까?")) {
									self.location.href = "deleteReply.do?ubd_r_no="+ubd_r_no+"&ubd_no=${reply.ubd_no}&user_no=${reply.user_no}";
										}
									}
								</script>
					<li>
						<div>
							<div>
							${reply.user_nick} / <fmt:formatDate value="${reply.ubd_r_regdate}" type="date"/>
							
							<c:if test="${reply.user_nick == user.getUser_nick() || user.getUser_type() == 'A'}">
		     					<a href="#" onclick="deleteReply(${reply.ubd_r_no})">삭제</a>
		     				</c:if>
		     				
		     				<c:if test="${reply.user_nick == user.getUser_nick()}">
		     					<a href="updateReply.do?ubd_r_no=${reply.ubd_r_no}&user_no=${reply.user_no}">수정</a>
		     				</c:if>	

								<P>${reply.ubd_r_content}</P>
							</div>
		
						</div>
					</li>
					</c:forEach>
				</ul>
			</div>
			
			
			<div>
				<form action="insertReply.do" method="POST">
				
				<p>
					<!-- cols 30에서 50으로 수정 -->
					<textarea rows="3" cols="50" name="ubd_r_content" placeholder="댓글을 입력하세요"></textarea>
				</p>
				<p>
					<button type="submit">댓글 작성</button>
				</p>
					<input type="hidden" name="ubd_no" value="${board.getUbd_no()}"/>
					<input type="hidden" name="user_no" value="${user.getUser_no()}"/>	
					
				</form>
			</div>
			
			
			<div class="container" align="center">
			
				<c:if test="${board.getUser_nick() == user.getUser_nick()}">
				<a href="user_board_update.do?ubd_no=${board.getUbd_no()}" class="btn btn-warning mt-3">수정</a>
				</c:if>
				
				<a href="user_board_list.do?curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}" class="btn btn-primary mt-3">게시글목록</a>	
				
				<c:if test="${board.getUser_nick() == user.getUser_nick() || user.getUser_type() == 'A'}">
				<a href="#" onclick="deleteBoard()" class="btn btn-danger mt-3">삭제</a>
				</c:if>
				
			</div>
		
	</div>
	<%@include file="/includes/footer.jsp" %>
	
	<script>
		function deleteBoard() {
			if(confirm("이 게시글을 삭제하겠습니까?")) {
		    	self.location.href = "user_board_delete.do?ubd_no=${ board.ubd_no }";
		    }
		}
	</script>
</body>
	<script>
    $(document).ready(function () {
	// 좋아요가 있는지 확인한 값을 findLike에 저장
        var findHeart = ${findHeart};
        // findHeart이 1이면 좋아요가 이미 되있는것이므로 heart-fill.svg를 출력하는 코드
        if(findHeart>0) {
        	console.log(findHeart);
            $("#heart").prop("src", "resources/img/heart_fill.svg");
            $(".heart").prop('name', findHeart);
        }
        else {
        	console.log(findHeart);
            $("#heart").prop("src", "resources/img/heart.svg");
            $(".heart").prop('name', findHeart);
        }
    });
	</script>
	
	<script>
	// 좋아요 버튼을 클릭 시 실행되는 코드
        $(".heart").click(function() { 
           var that = $(".heart");
	    $.ajax({
	    	url :'heart.do',
	        type :'POST',
	        data : {'user_no':${user.getUser_no()}, 'ubd_no':${board.getUbd_no()}},
	    	success : function(data){
	    		that.prop('name', data);
	        	if(data==1) {
	            	     $('#heart').prop("src","resources/img/heart_fill.svg");
	        	} else {
                   	     $('#heart').prop("src","resources/img/heart.svg");
	        	}
            	}
	    });
       });
</script>

</html>