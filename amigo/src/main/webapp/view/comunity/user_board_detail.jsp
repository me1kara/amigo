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
						<th>제목</th>
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
							<c:if test="${board.getUbd_file()!=null and board.getUbd_file()!=''}">
								<c:forEach items="${fileSplit}" var="file">
								<img src="/img/${file}" width="300px" height="300px"><br><br>
								</c:forEach>
							</c:if>
						</td>
						</tr>	
			
			</table>
			<br>
			<div>
				<a class="heart" style="text-decoration-line: none;">
					<img id="heart" src="resources/img/heart.svg">
					좋아요( ${board.getLike_cnt()} )
				</a>
			</div>
			
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
            $(".heart").prop('name', findHeart)
        }
        else {
        	console.log(findHeart);
            $("#heart").prop("src", "resources/img/heart.svg");
            $(".heart").prop('name', findHeart)
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