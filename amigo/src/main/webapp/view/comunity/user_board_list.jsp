<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<title>게시판01_유저커뮤니티</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
<%@include file="/includes/header.jsp" %>

	<div class="container" align="center">
		<div class="mt-4 p-5 bg-primary text-white rounded">
			<h3>유저 커뮤니티</h3>
			<c:if test="${ boardList.isEmpty() }">
				<h5><p class="bg-danger text-white">등록된 게시판 정보가 존재하지 않습니다!!</p></h5>
			</c:if>
		</div> 
		<br>
			
		<form action="user_board_list.do" method="post" id="boardForm">   
			<input type="hidden" id="curPage" name="curPage" value="${searchVO.getCurPage()}"> 
			<input type="hidden" id="rowSizePerPage" name="rowSizePerPage" value="${searchVO.getRowSizePerPage()}">
	   		<div class="row mt-3 justify-content-center">
	   			<div class="col-auto">
					<a href="#">전체글</a> ㅣ
	   				<a href="">인기글</a> ㅣ
	   				<a href="">펫시터 커뮤니티</a>
	   			</div>
	   			<div class="col-auto">
					<select class="form-select" id="searchCategory" name="searchCategory" onchange="chageSelect()">
				    	<option value="말머리">말머리</option>							
				    	<option value="자랑글">자랑글</option>						
				    	<option value="자유글">자유글</option>							
				    	<option value="질문">질문</option>										
					</select>
					
					<script type="text/javascript">
					
					function chageSelect(){ 
						
						var selectList = document.getElementById("searchCategory")
						
						if(selectList.options[selectList.selectedIndex].value == "말머리"){
							location.href = "user_board_list.do";
						}
						if(selectList.options[selectList.selectedIndex].value == "자랑글"){
							location.href = "user_board_cate.do?ubd_cate=자랑글";
						}
						if(selectList.options[selectList.selectedIndex].value == "자유글"){
							location.href = "user_board_cate.do?ubd_cate=자유글";
						}
						if(selectList.options[selectList.selectedIndex].value == "질문"){
							location.href = "user_board_cate.do?ubd_cate=질문";
						}
					}
					</script>
					
				</div> 
		    	<div class="col-auto me-1">
					<select class="form-select" id="searchType" name="searchType">
				    	<option value="">검색</option>							
				    	<option value="ubd_title" ${searchVO.getSearchType()=="ubd_title" ? "selected" : "" }>제목</option>							
				    	<option value="user_nick" ${searchVO.getSearchType()=="user_nick" ? "selected" : ""}>작성자</option>						
				    	<option value="ubd_cont" ${searchVO.getSearchType()=="ubd_cont" ? "selected" : ""}>글내용</option>						
					</select>
				</div>
				<div class="col-3 me-1">			
					<input class="form-control me-2" name="searchWord" type="text" placeholder="input search keyword..." />
				</div>
				<div class="col-3 btn-group">
			    	<input type="submit" class="col-1 btn btn-primary me-2" value="검색">
	        	</div>
			</div>
		</form> <!-- getBoardList.do -->
	
		<div class="container mt-3">		
			<div class="row mt-4">
				<table class="table table-hover table-bordered">
					<thead class="table-dark text-center">
						<th scope="col" class="col-1 text-center">말머리</th>
						<th scope="col" class="col-6">제목</th>
						<th scope="col" class="col-1 text-center">작성자</th>
						<th scope="col" class="col-1 text-center">등록일</th>
						<th scope="col" class="col-1 text-center">조회수</th>									
						<th scope="col" class="col-1 text-center">추천수</th>									
					</thead>
					<tbody>
					<c:forEach  var="board" items="${ boardList }">
						<tr>
							<td>${ board.getUbd_cate()}</td>
							<td><a href="user_board_detail.do?ubd_no=${board.getUbd_no()}">${board.getUbd_title()}</a></td>
							<td>${ board.getUser_nick() }</td>
							<td><fmt:formatDate value="${board.ubd_date}" pattern="yyyy-MM-dd"/></td>
							<td>${ board.ubd_cnt }</td>
							<td>${ board.ubd_likecnt }</td>
						</tr>
					</c:forEach>									
					</tbody>
				</table>
			</div>	
		</div> <!-- 게시판 -->
 	
		<div class="row align-items-start mt-3">
			<ul class="col pagination justify-content-center">
			
				<c:set var="cp" value="${searchVO.getCurPage()}"/>
				<c:set var="rp" value="${searchVO.getRowSizePerPage()}"/>
				<c:set var="fp" value="${searchVO.getFirstPage()}"/>
				<c:set var="lp" value="${searchVO.getLastPage()}"/>
				<c:set var="ps" value="${searchVO.getPageSize()}"/>
				<c:set var="tp" value="${searchVO.getTotalPageCount()}"/>
				<c:set var="sc" value="${searchVO.getSearchCategory()}"/>
				<c:set var="st" value="${searchVO.getSearchType()}"/>
				<c:set var="sw" value="${searchVO.getSearchWord()}"/>
																
				<c:if test="${ fp != 1 }">
					<li class="page-item"><a href="user_board_list.do?curPage=1&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-fast-backward"></i></a></li>
					<li class="page-item"><a href="user_board_list.do?curPage=${fp-1}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-backward"></i></a></li>				
				</c:if>
			
				<c:forEach var="page" begin="${fp}" end="${lp}">
					<li class="page-item ${cp==page ? 'active' : ''}"><a href="user_board_list.do?curPage=${page}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link">${page}</a></li>
				</c:forEach>
				
				<c:if test="${ lp < tp }">
					<li class="page-item "><a href="user_board_list.do?curPage=${lp+ps}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-forward"></i></a></li>				
					<li class="page-item"><a href="user_board_list.do?curPage=${tp}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-fast-forward"></i></a></li>				
				</c:if>
			</ul> <!-- pagination -->	
	
		</div> <!-- 페이징 -->
		
		<div class="col-2 btn-group">
			    <a href="user_board_insert.do" class="col-1 btn btn-primary me-2">글등록</a>
		</div>					
	</div> <!-- main  -->
	
	    
	    
<%@include file="/includes/footer.jsp" %>
</body>
</html>