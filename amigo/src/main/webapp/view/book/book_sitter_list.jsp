<%@page import="com.lec.amigo.vo.SitterVO"%>
<%@page import="com.lec.amigo.vo.ChatVO"%>
<%@page import="java.util.List"%>
<%@page import="com.lec.amigo.dao.ChatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	
	
	<%
		String addr = request.getParameter("addr");
	
	%>

<script
  src="https://code.jquery.com/jquery-3.6.3.min.js"
  integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
  crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>펫시터03_펫시터목록</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
    
    <style>
    	a:hover{color: white; text-decoration: none;}
    	a:active {color: white; text-decoration: none;}
    	a:visited {color: white; text-decoration: none;}
    	a:link{color: white; text-decoration: none;}
    </style>
</head>
<body>

	<%@include file="/includes/header.jsp"%>
		<div class="container">
			<p><%=addr %> 시터들 목록</p>
			
			<c:choose>

			<c:when test="${sittList!=null }">
				<c:forEach var="sit" items="${sittList }">
					<c:forEach var="user" items="${sittNameList }">
					
						<c:if test="${user.getUser_no() == sit.getUser_no() }">
						<div class="row">
							<img src="https://via.placeholder.com/100x100" " class="col-sm-4" />
							<div class="col-sm-4">
								<h4>이름:${user.getUser_name() }</h4>
								<p>경력사항,특기</p>
								<p>시간:${sit.getSit_time() }</p>
							</div>
							<div class="col-sm-4">
								<button class="btn btn-secondary"
									onclick="location.href='sitter_profile.do?user_name=${user.getUser_name()}'">자세히보기</button>
							</div>
						</div>
						</c:if>
					</c:forEach>
				</c:forEach>
			</c:when>

			<c:otherwise>
					<h>해당한 지역의 펫시터가 없습니다!</h>
				</c:otherwise>
			</c:choose>


	</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>