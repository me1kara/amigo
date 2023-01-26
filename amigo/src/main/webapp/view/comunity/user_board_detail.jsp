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
<title>게시판04_글상세내용~05_글삭제</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
				 
	<%@include file="/includes/header.jsp" %>
			<div class="container mt-3" align="center">

			<table>
						<tr>
						<th>제목(추천 ${ board.getUbd_likecnt()} )</th>
						<td>${ board.getUbd_title() }</td>
						</tr>
						<tr>
						<th>작성자</th>
						<td>${ board.getUser_nick() }</td>
						</tr>
						<tr>
						<th>내용</th>
						<td>${ board.getUbd_cont() }</td>
						</tr>
						<tr>
						<th>등록일</th>
						<td>${ board.getUbd_date() }</td>
						</tr>
						<tr>
						<th>조회수</th>
						<td>${ board.ubd_cnt }</td>
						</tr>
						
						<tr>
						<th>사진</th>
						<td>
							<c:if test="${board.getUbd_file()!=null}">
								<img src="/img/${board.getUbd_file()}" width="250px" height="250px">
							</c:if>
						</td>
						</tr>	
			
			</table>

			<a href="like.do?ubd_no=${ board.getUbd_no() }">추천</a>
			
			<div align="left">
				댓글 <hr>
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
							<p>${reply.user_nick} / <fmt:formatDate value="${reply.ubd_r_regdate}" pattern="YYYY-MM-DD"/>
							
							<c:if test="${reply.user_nick == user.getUser_nick() || user.getUser_type() == 'A'}">
		     					<a href="#" onclick="deleteReply(${reply.ubd_r_no})">삭제</a>
		     				</c:if>
		     				
		     				<c:if test="${reply.user_nick == user.getUser_nick()}">
		     					<a href="updateReply.do?ubd_r_no=${reply.ubd_r_no}">수정</a>
		     				</c:if>				
							</p>
							<p>${reply.ubd_r_content}</p>
						</div>
					</li>
					</c:forEach>
				</ul>
				
			</div>
			
			
			<div>
				<form action="insertReply.do" method="POST">
				
				<p>
					<textarea rows="3" cols="30" name="ubd_r_content" placeholder="댓글을 입력하세요"></textarea>
				</p>
				<p>
					<button type="submit">댓글 작성</button>
				</p>
					<input type="hidden" name="ubd_no" value="${board.getUbd_no()}"/>
					<input type="hidden" name="user_no" value="${user.getUser_no()}"/>	
					
				</form>
			</div>
			
			
			<div class="container" align="center">
				<a href="user_board_update.do?ubd_no=${board.getUbd_no()}" class="btn btn-warning mt-3">게시글수정</a>
				<a href="user_board_list.do" class="btn btn-primary mt-3">게시글목록</a>	
				<a href="#" onclick="deleteBoard()" class="btn btn-danger mt-3">게시글삭제</a>
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
</html>