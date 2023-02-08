<%@page import="com.lec.amigo.vo.SitterVO"%>
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
<title>프로필01_시터 프로필 확인</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<%
	

%>
<body>
	
	<%@include file="/includes/header.jsp" %>
				
			<div class="container text-center">
			<h2> 시터 프로필 정보</h2>
				<table>
					<tr>
	     			 <td>Profile Picture:</td>
	     			 <td>
	    			    <c:choose>
	     			     <c:when test="${not empty sitter.sit_photo}">
	     			       <img src="${sitter.sit_photo}" alt="Profile Picture"/>
	     			     </c:when>
	     			     <c:otherwise>
	     			       Profile picture not available.
	     			     </c:otherwise>
	    			    </c:choose>
	  			   	 </td>
	   				</tr>
			 		   <tr>
	    			  <td></td>
	    			  <td>
	    			    <c:out value="${sitter.user_name}"/> 펫시터
	     			 </td>
	  			  </tr>
				</table>
				<button class="btn btn-primary"><a href="/amigo/requestBook.do?sit_no=${sitter.sit_no }" style="color: white;">신청하기</a> </button>
				<button class="btn btn-primary"><a href="/amigo/requestBook.do?sit_no=${sitter.sit_no }" style="color: white;">신청하기</a> </button>
			</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>