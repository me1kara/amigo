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
	
	
	ul{
		list-style-type:none;	
	}
	
	#sreply_user {
		color: #189cc4;
		font-weight: bold;
	}
	
	#sreply_form {
		text-align:center;
	}
	
	textarea {
		border: solid 1px #1E90FF;
		border-radius: 5px;
		}
	
	textarea::placeholder {
		padding : 10px;
		font-size: 14px;
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
				<h4>${ sboard.getSbd_title() }</h4>
			</div>
			<div class="container text-start">
			<!-- 작성자 -->
			<!-- 이미지를 받아와야할거 같은데 참고: https://okky.kr/articles/1131945 -->
			

			<span>${ sboard.getUser_nick() }</span>

			<div class="ubd-group">
			<!-- 등록일 -->
			<span>${ sboard.getSbd_date() }</span>
			<!-- 조회 -->
			<span>조회수 ${ sboard.getSbd_cnt() }</span>

			</div>	
			</div>		
		</div>		
		<hr/>
		<br/>

		<!-- 글작성 내용 start -->
		<div>
		<a>${ sboard.getSbd_cont() }</a>	
		</div>
		<!-- 글작성 내용 end -->
		

		<hr/>
		
		
			
			<div align="left">
				댓글(${ sboard.getReply_cnt() }) <hr> 
				<ul>
					<c:forEach items="${sreplyList}" var="sreply">
								<script>
									function deleteSitterReply(sbd_r_no) {
									if(confirm("이 댓글을 삭제하겠습니까?")) {
									self.location.href = "deleteSitterReply.do?sbd_r_no="+sbd_r_no+"&sbd_no=${sreply.sbd_no}&user_no=${sreply.user_no}&curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}";
										}
									}
								</script>
					<li>
						<div>
							<div>
							<span id="sreply_user">${sreply.user_nick}</span> / <fmt:formatDate value="${sreply.sbd_r_regdate}" type="date"/>
							
							<c:if test="${sreply.user_no == user.getUser_no() || user.getUser_type() == 'A'}">
		     					<a href="#" onclick="deleteSitterReply(${sreply.sbd_r_no})">삭제</a>
		     				</c:if>
		     				
		     				<c:if test="${sreply.user_no == user.getUser_no()}">
		     					<a href="updateSitterReply.do?sbd_r_no=${sreply.sbd_r_no}&user_no=${sreply.user_no}&curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}">수정</a>
		     				</c:if>	

								<P>${sreply.sbd_r_cont}</P>
							</div>
		
						</div>
					</li>
					</c:forEach>
				</ul>
			</div>	
			
			
			<div id="sreply_form">
				<form action="insertSitterReply.do" method="POST" >
				
				
					<!-- cols 30에서 60으로 수정 -->
				<p id = "sreply_input">
					<textarea style="margin:0 auto;" rows="2" cols="50" name="sbd_r_cont" placeholder="댓글을 입력하세요." required></textarea>		
				</p>
					<p><button type="submit" class="btn btn-sm btn-secondary col-2" >댓글입력</button></p>

		
					<input type="hidden" name="sbd_no" value="${sboard.getSbd_no()}"/>
					<input type="hidden" name="user_no" value="${user.getUser_no()}"/>		
					<input type="hidden" name="searchType" value="${searchVO.getSearchType()}"/>	
					<input type="hidden" name="searchWord" value="${searchVO.getSearchWord()}"/>	
					<input type="hidden" name="curPage" value="${searchVO.getCurPage()}"/>	
					<input type="hidden" name="rowSizePerPage" value="${searchVO.getRowSizePerPage()}"/>	

				</form>
			</div>

			
			<div class="container col-md-5 " align="center">
			
				<c:if test="${sboard.getUser_no() == user.getUser_no()}">
				<a href="sitter_board_update.do?sbd_no=${sboard.getSbd_no()}&curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}
				&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}&cnt=${cnt}" class="btn btn-primary mt-5 mb-5">수정</a>
				</c:if>
				
				<a href="sitter_board_list.do?&curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}
				&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}" class="btn btn-primary mt-5 mb-5">목록</a>


				<c:if test="${sboard.getUser_no() == user.getUser_no() || user.getUser_type() == 'A'}">
				<button type="button" class="btn btn-danger mt-5 mb-5" data-bs-toggle="modal" data-bs-target="#sbddelete"
				data-sbd_no="${sboard.getSbd_no()}">삭제</button>
				</c:if>
				
			</div>	
		
	</div>
	
		<!--삭제 modal form  -->
				<div id="sbddelete" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="sbddeleteLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
				   <div class="modal-content">
				     <div class="modal-header">
				        <h5 class="modal-title" id="sbddeleteLabel">게시글 삭제</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				     </div>
				      <div class="modal-body">
				        게시글을 정말 삭제하시겠습니까?
				      </div>
				      <div class="modal-footer">
				      	<button type="button" class="btn btn-danger" onclick="deletesBoard();">삭제</button>
				       	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
				      </div>
				   </div>
				</div>
				</div>
				  
		<!--삭제 modal form script sbd_no전달-->	
		<script>
		var SBDNO="";

		$(document).ready(function() {     
	        $('#sbddelete').on('show.bs.modal', function(event) {          
	        	SBDNO    = $(event.relatedTarget).data('sbd_no');  

	        });
	    });
		function deletesBoard() {location.href='sitter_board_delete.do?sbd_no='+SBDNO;}
		</script>


	<!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="js/script.js"></script>
	<%@include file="/includes/footer.jsp" %>
</body>
</html>