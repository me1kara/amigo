<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
				<form action="updateCsReply.do" method="POST">
				
				<p>
					<textarea rows="3" cols="30" name="hbd_r_cont" >${csreply.getHbd_r_cont()}</textarea>
				</p>
				<p>
					<button type="submit">수정 완료</button>
				</p>
					<input type="hidden" name="hbd_no" value="${csreply.getHbd_no()}"/>
					<input type="hidden" name="user_no" value="${csreply.getUser_no()}"/>	
					<input type="hidden" name="hbd_r_no" value="${csreply.getHbd_r_no()}"/>	
					<input type="hidden" name="searchType" value="${searchVO.getSearchType()}"/>	
					<input type="hidden" name="searchWord" value="${searchVO.getSearchWord()}"/>	
					<input type="hidden" name="curPage" value="${searchVO.getCurPage()}"/>	
					<input type="hidden" name="rowSizePerPage" value="${searchVO.getRowSizePerPage()}"/>	
				</form>
</body>
</html>