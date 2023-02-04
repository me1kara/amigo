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
				<form action="updateReply.do" method="POST">
				
				<p>
					<textarea rows="3" cols="30" name="ubd_r_content" >${reply.getUbd_r_content()}</textarea>
				</p>
				<p>
					<button type="submit">수정 완료</button>
				</p>
					<input type="hidden" name="ubd_no" value="${reply.getUbd_no()}"/>
					<input type="hidden" name="user_no" value="${reply.getUser_no()}"/>	
					<input type="hidden" name="ubd_r_no" value="${reply.getUbd_r_no()}"/>	
					<input type="hidden" name="searchType" value="${searchVO.getSearchType()}"/>	
					<input type="hidden" name="searchWord" value="${searchVO.getSearchWord()}"/>	
					<input type="hidden" name="curPage" value="${searchVO.getCurPage()}"/>	
					<input type="hidden" name="rowSizePerPage" value="${searchVO.getRowSizePerPage()}"/>	
					<input type="hidden" name="cnt" value="${cnt}"/>
				</form>
</body>
</html>