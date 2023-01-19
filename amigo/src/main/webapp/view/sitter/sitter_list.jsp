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
<title>펫시터 리스트</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
			<div class="container" align="center">
	<!--  	<div class="mt-4 p-5 bg-primary text-white rounded">
			<h3>User List</h3>
			<c:if test="${ userList.isEmpty() }">
				<h5><p class="bg-danger text-white">등록된 사용자 정보가 존재하지 않습니다!!</p></h5>
			</c:if>  
			
		</div>-->
		<br>

		<table class="table table-hover" align="center">
			<thead>
				<input type="text" name="sitter_list" placeholder="인근 시터들 목록">   <!-- 인근 시터목록을 검색할수있도록 해준다. 안되면 어쩔수없고.  -->
			</thead>
			<tbody>
			<c:forEach  var="sitter" items="${ sitter_list }">    <!-- 시터서비스에서 시터가 4명이 보이도록 함. -->
				<tr>
					<td><img src=# >          <!-- 시터의 이미지 갖고옴  -->
					<td scope="row"><a href="updateUser.do?id=${ user.getId() }">${ user.getId() }</a></td> <!-- 시터(회원명)갖고옴 -->
					<td>${ user.getId() }</td>																<!-- 경력사항 씀 -->
					<td>${ user.getId() }</td>															<!-- 특기인데 없앨까함. -->
					<td align="center">
						<a href="deleteUser.do?id=${ user.getId() }" class="btn btn-danger">자세히보기  <!-- 버튼쓸거고, 시터상세정보로이동. -->
						</a>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>	
	<br>
	
	<div class="container" align="center">
		<div class="row">
			
			
			<div class="col-sm-auto">
				
				<ul class="pagination justify-content-center">					
					<c:if test="${ pageInfo.getStartPage() != 1 }">
						<li class="page-item"><a href="getUserList.do?p=1" class="page-link"><i class="fas fa-fast-backward"></i></a></li>
						<li class="page-item"><a href="getUserList.do?p=${ pageInfo.getStartPage() - 10 }" class="page-link"><i class="fas fa-backward"></i></a></li>				
					</c:if>
				
					<c:set var="cp" value="${ pageInfo.getCurrentPage() }"/>
				
					<c:forEach var="page" begin="${ pageInfo.getStartPage() }" end="${ pageInfo.getEndPage() }">
						<li class="page-item ${ (cp==page) ? 'active' : ''}"><a href="getUserList.do?p=${page}" class="page-link">${page}</a></li>
					</c:forEach>
					
					<c:if test="${ pageInfo.getEndPage() < pageInfo.getTotalPages() }">
						<li class="page-item"><a href="getUserList.do?p=${ pageInfo.getEndPage() + 1 }" class="page-link"><i class="fas fa-forward"></i></a></li>				
						<li class="page-item"><a href="getUserList.do?p=${ pageInfo.getTotalPages() }" class="page-link"><i class="fas fa-fast-forward"></i></a></li>				
					</c:if>
				</ul>
			</div>
			<br><br>
			<div class="col-sm-2">
				<!-- button trigger modal form - user add -->
				<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUser">이전
				</button>
			</div>
			<div class="col-sm-2">
				<!-- button trigger modal form - user add -->
				<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUser">신청
				</button>
			</div>
		</div>
	</div>	
	
	<!--사용자등록 modal form  -->
	<div id="addUser" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tableindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
		
			<form action="insertUser.do" method="post">
			
				<div class="modal-content">
					
					<div class="modal-header">
						<h1 class="motal-title fs-5" id="staticBackdropLabel">사용자등록하기</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div> <!-- modal-header -->
					
					<div class="modal-body">
						<div class="input-group mb-3">
							<div class="input-group-text"><i class="fas fa-user"></i></div>
							<input type="text" name="id" class="form-control" id="id" required placeholder="User Id(email)....">
						</div>
						<div class="input-group mb-3">
							<div class="input-group-text"><i class="fas fa-lock"></i></div>
							<input type="password" name="password" class="form-control" id="password" required placeholder="Password....">
						</div>
						<div class="input-group mb-3">
							<div class="input-group-text"><i class="fas fa-address-book"></i></div>
							<input type="text" name="name" class="form-control" id="name" required placeholder="User Name....">
						</div>
						<div class="input-group mb-3">
							<input type="checkbox" name="role" class="input-group-text" id="role">
							<label class="form-check-label ms-sm-2" for="role">관리자</label>
						</div>
					</div> <!-- modal-body -->
 					
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary">Add User</button>
					</div> <!-- modal-footer -->
				</div> <!-- modal-content -->
			</form>	
		</div> <!-- modal diaglog -->
	</div> <!-- modal end -->
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>