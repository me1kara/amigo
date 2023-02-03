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
			

			<span>${ board.getUser_nick() }</span>

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
							
							<c:if test="${reply.user_no == user.getUser_no() || user.getUser_type() == 'A'}">
		     					<a href="#" onclick="deleteReply(${reply.ubd_r_no})">삭제</a>
		     				</c:if>
		     				
		     				<c:if test="${reply.user_no == user.getUser_no()}">
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
			
				<c:if test="${board.getUser_no() == user.getUser_no()}">
				<a href="user_board_update.do?ubd_no=${board.getUbd_no()}&curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}
				&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}" class="btn btn-warning mt-3">수정</a>
				</c:if>
				
				<c:choose>
				<c:when test="${cnt==1}">
				<a href="user_board_list.do?curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}
				&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}" class="btn btn-primary mt-3">목록</a>
				</c:when>
				
				<c:when test="${cnt==2}">
				<a href="user_board_list_like.do?curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}
				&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}" class="btn btn-primary mt-3">목록</a>
				</c:when>
				
				<c:when test="${cnt==3}">
				<a href="user_board_cate.do?ubd_cate=${board.getUbd_cate()}&curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}
				&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}" class="btn btn-primary mt-3">목록</a>
				</c:when>
				</c:choose>
				
				<c:if test="${board.getUser_no() == user.getUser_no() || user.getUser_type() == 'A'}">
				<button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#ubddelete"
				data-ubd_no="${board.getUbd_no()}" data-ubd_file="${board.getUbd_file()}" 
				data-cur_page="${searchVO.getCurPage()}" data-rowsize_perpage="${searchVO.getRowSizePerPage()}">삭제</button>
				</c:if>
				
			</div>
		
	</div>
	
		<!--삭제 modal form  -->
				<div id="ubddelete" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="ubddeleteLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
				   <div class="modal-content">
				     <div class="modal-header">
				        <h5 class="modal-title" id="ubddeleteLabel">게시글 삭제</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				     </div>
				      <div class="modal-body">
				        게시글을 정말 삭제하시겠습니까?
				      </div>
				      <div class="modal-footer">
				      	<button type="button" class="btn btn-danger" onclick="deleteBoard();">삭제</button>
				       	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
				      </div>
				   </div>
				</div>
				</div>
				  
		<!--삭제 modal form script ubd_no전달-->	
		<script>
		var UBDNO="";
		var USERFILE="";
		var CURPAGE ="";
		var ROWPAGE ="";
		$(document).ready(function() {     
	        $('#ubddelete').on('show.bs.modal', function(event) {          
	        	UBDNO    = $(event.relatedTarget).data('ubd_no');
	        	USERFILE = $(event.relatedTarget).data('ubd_file');  
	        	CURPAGE  = $(event.relatedTarget).data('cur_page');
	        	ROWPAGE  = $(event.relatedTarget).data('rowsize_perpage');
	        });
	    });
		function deleteBoard() {location.href='user_board_delete.do?ubd_no='+UBDNO+'&ubd_file='+USERFILE+'&curPage='+CURPAGE+'&rowSizePerPage='+ROWPAGE;}
		</script>

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

	<!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="js/script.js"></script>
	<%@include file="/includes/footer.jsp" %>
</body>
</html>