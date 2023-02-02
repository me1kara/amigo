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
				<h4>${ board.getUbd_title() }</h4>
			</div>
			<div class="container text-start">
			<!-- 작성자 -->
			<!-- 이미지를 받아와야할거 같은데 참고: https://okky.kr/articles/1131945 -->
			
			
			<a>${ board.getUser_nick() }</a>
			<div class="ubd-group">
			<!-- 등록일 -->
			<span>${ board.getUbd_date() }</span>
			<!-- 조회 -->
			<span>조회수 ${ board.ubd_cnt }</span>
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
		
		<hr/>
		
		
			
			<div align="left">
				댓글(${ board.getReply_cnt() }) <hr> 
				<ul>
					<c:forEach items="${replyList}" var="reply">
								<script>
									function deleteReply(ubd_r_no) {
									if(confirm("이 댓글을 삭제하겠습니까?")) {
									self.location.href = "deleteReply.do?ubd_r_no="+ubd_r_no+"&ubd_no=${reply.ubd_no}";
										}
									}
								</script>
					<li>
						<div>
							<c:if test="${ reply.ubd_r_lev !=0 }">
								┗
								<c:forEach var="i" begin="1" end="${reply.ubd_r_lev}">
									-
								</c:forEach>
							</c:if>
							
							<div>
							${reply.user_nick} / <fmt:formatDate value="${reply.ubd_r_regdate}" pattern="YYYY-MM-DD"/>
							
							<c:if test="${reply.user_nick == user.getUser_nick() || user.getUser_type() == 'A'}">
		     					<a href="#" onclick="deleteReply(${reply.ubd_r_no})">삭제</a>
		     				</c:if>
		     				
		     				<c:if test="${reply.user_nick == user.getUser_nick()}">
		     					<a href="updateReply.do?ubd_r_no=${reply.ubd_r_no}">수정</a>
		     				</c:if>	
		     				
		     					<a href="updateReply.do?ubd_r_no=${reply.ubd_r_no}">답글</a> <br>

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
				
				
			</div>
		
	</div>
	<%@include file="/includes/footer.jsp" %>
	
</body>
	
</html>