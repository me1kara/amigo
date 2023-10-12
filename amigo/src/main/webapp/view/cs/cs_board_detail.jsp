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
<title>질문03_질문내용확인~04</title>
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
				<h4>${ csboard.getHbd_title() }</h4>
			</div>
			<div class="container text-start">
			<!-- 작성자 -->
			<!-- 이미지를 받아와야할거 같은데 참고: https://okky.kr/articles/1131945 -->
			

			<span>${ csboard.getUser_nick() }</span>

			<div class="ubd-group">
			<!-- 등록일 -->
			<span>${ csboard.getHbd_date() }</span>
			<!-- 조회 -->
			<span>조회수 ${ csboard.hbd_cnt }</span>
			</div>	
			</div>		
		</div>		
		<hr/>
		<br/>
		<!-- 수정본 글쓰기 end -->
		<!-- 글작성 내용 start -->
		<div>
		<a>${ csboard.getHbd_cont() }</a>
		<br/>
		<a>
		<c:if test="${csboard.getHbd_file()!=null and csboard.getHbd_file()!=''}">
			<c:forEach items="${fileSplit}" var="file">
				<img src="/csboardimg/${file}" width="300px" height="300px"><br><br>
			</c:forEach>
		</c:if>
		</a>
		
		</div>
		<!-- 글작성 내용 end -->
		<hr/>
		
			<div align="left">
				댓글(${ csboard.getReply_cnt() }) <hr> 
				<ul>
					<c:forEach items="${csreplyList}" var="csreply">
								<script>
									function deleteCsReply(hbd_r_no) {
									if(confirm("이 댓글을 삭제하겠습니까?")) {
									self.location.href = "deleteCsReply.do?hbd_r_no="+hbd_r_no+"&hbd_no=${csreply.hbd_no}&user_no=${csreply.user_no}&curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}";
										}
									}
								</script>
					<li>
						<div>
							<div>
							<span id="csreply_user">${csreply.user_nick}</span> <fmt:formatDate value="${csreply.hbd_r_regdate}" type="date"/>
							
							<c:if test="${csreply.user_no == user.getUser_no() || user.getUser_type() == 'A'}">
		     					<a href="#" onclick="deleteCsReply(${csreply.hbd_r_no})">삭제</a>
		     				</c:if>
		     				
		     				<c:if test="${csreply.user_no == user.getUser_no()}">
		     					<a href="updateCsReply.do?hbd_r_no=${csreply.hbd_r_no}&user_no=${csreply.user_no}&curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}">수정</a>
		     				</c:if>	

								<P>${csreply.hbd_r_cont}</P>
							</div>
		
						</div>
					</li>
					</c:forEach>
				</ul>
			</div>
			
			
			<div id="csreply_form" style="text-align: center;">
				<form action="insertCsReply.do" method="POST" >
				
				
					<!-- cols 30에서 60으로 수정 -->
				<p id = "csreply_input">
					<textarea style="margin:0 auto;" rows="2" cols="50" name="hbd_r_cont" placeholder="댓글을 입력하세요." required></textarea>		
				</p>
					<p><button type="submit" onclick="reload();" class="btn btn-sm btn-secondary col-2" >댓글입력</button></p>

		
					<input type="hidden" name="hbd_no" value="${csboard.getHbd_no()}"/>
					<input type="hidden" name="user_no" value="${user.getUser_no()}"/>		
					<input type="hidden" name="searchType" value="${searchVO.getSearchType()}"/>	
					<input type="hidden" name="searchWord" value="${searchVO.getSearchWord()}"/>	
					<input type="hidden" name="curPage" value="${searchVO.getCurPage()}"/>	
					<input type="hidden" name="rowSizePerPage" value="${searchVO.getRowSizePerPage()}"/>	

				</form>
			</div>
			<script type="text/javascript">
			function reload() {
				location.reload();
			}
			</script>
			
			
			<div class="container col-md-5 " align="center">
			
				<c:if test="${csboard.getUser_no() == user.getUser_no()}">
				<a href="cs_board_update.do?hbd_no=${csboard.getHbd_no()}&curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}
				&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}" class="btn btn-primary mt-5 mb-5">수정</a>
				</c:if>
				
		
				<a href="cs_board_list.do?&curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}
				&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}" class="btn btn-primary mt-5 mb-5">목록</a>
				

				<c:if test="${csboard.getUser_no() == user.getUser_no() || user.getUser_type() == 'A'}">
				<button type="button" class="btn btn-danger mt-5 mb-5" data-bs-toggle="modal" data-bs-target="#hbddelete"
				data-hbd_no="${csboard.getHbd_no()}" data-hbd_file="${csboard.getHbd_file()}" 
				data-cur_page="${searchVO.getCurPage()}" data-rowsize_perpage="${searchVO.getRowSizePerPage()}">삭제</button>
				</c:if>
				
			</div>	
		
	</div>
	
		<!--삭제 modal form  -->
				<div id="hbddelete" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="hbddeleteLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
				   <div class="modal-content">
				     <div class="modal-header">
				        <h5 class="modal-title" id="hbddeleteLabel">게시글 삭제</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				     </div>
				      <div class="modal-body">
				        게시글을 정말 삭제하시겠습니까?
				      </div>
				      <div class="modal-footer">
				      	<button type="button" class="btn btn-danger" onclick="deleteCsBoard();">삭제</button>
				       	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
				      </div>
				   </div>
				</div>
				</div>
				  
		<!--삭제 modal form script ubd_no전달-->	
		<script>
		var HBDNO="";
		var USERFILE="";
		var CURPAGE ="";
		var ROWPAGE ="";
		$(document).ready(function() {     
	        $('#hbddelete').on('show.bs.modal', function(event) {          
	        	HBDNO    = $(event.relatedTarget).data('hbd_no');
	        	USERFILE = $(event.relatedTarget).data('hbd_file');  
	        	CURPAGE  = $(event.relatedTarget).data('cur_page');
	        	ROWPAGE  = $(event.relatedTarget).data('rowsize_perpage');
	        });
	    });
		function deleteCsBoard() {location.href='cs_board_delete.do?hbd_no='+HBDNO+'&hbd_file='+USERFILE+'&curPage='+CURPAGE+'&rowSizePerPage='+ROWPAGE;}
		</script>


	<!-- Bootstrap core JS-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Core theme JS-->
    <script src="js/script.js"></script>
	<%@include file="/includes/footer.jsp" %>
</body>
	
</html>