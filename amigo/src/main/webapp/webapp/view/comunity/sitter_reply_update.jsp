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
<title>Insert title here</title>
<style>
	#reply_form {
		margin: 30px;
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
</head>
<body>

		<div id="reply_form" align="center">
				<form action="updateSitterReply.do" method="POST">
				
				<p>
					<textarea rows="2" cols="50" name="sbd_r_cont" >${sreply.getSbd_r_cont()}</textarea>
				</p>
				<p>
					<button type="submit" class="btn btn-sm btn-primary col-2" >수정 완료</button>
					<button type="button" class="btn btn-sm btn-secondary col-1" onclick="history.go(-1)">취소</button>
				</p>
					<input type="hidden" name="sbd_no" value="${sreply.getSbd_no()}"/>
					<input type="hidden" name="user_no" value="${sreply.getUser_no()}"/>	
					<input type="hidden" name="sbd_r_no" value="${sreply.getSbd_r_no()}"/>	
					<input type="hidden" name="searchType" value="${searchVO.getSearchType()}"/>	
					<input type="hidden" name="searchWord" value="${searchVO.getSearchWord()}"/>	
					<input type="hidden" name="curPage" value="${searchVO.getCurPage()}"/>	
					<input type="hidden" name="rowSizePerPage" value="${searchVO.getRowSizePerPage()}"/>	
				</form>
		</div>
</body>
</html>