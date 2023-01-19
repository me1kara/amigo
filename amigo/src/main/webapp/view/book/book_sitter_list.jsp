<%@page import="com.lec.amigo.vo.ChatVO"%>
<%@page import="java.util.List"%>
<%@page import="com.lec.amigo.dao.ChatDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>

	<% %>
	
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
	
	<%@include file="/includes/header.jsp" %>
		<div class="container">
			<p>인근시터들 목록</p>
			
			<div class="row">
				<img src="https://via.placeholder.com/100x100"" class="col-sm-4"/>
				<div class="col-sm-4">
					<h4>시터이름</h4>
					<p>경력사항,특기</p>
				</div>
				<div class="col-sm-4">
					<button class="btn btn-secondary"  onclick="location.href='sitter_profile.do?name=최성형'">자세히보기</button>
					
				</div>
			</div>
			
			<div class="row">
			<img src="https://via.placeholder.com/100x100"" class="col-sm-4"/>
				<div class="col-sm-4">
					<h4>시터이름</h4>
					<p>경력사항,특기</p>
				</div>
				<div class="col-sm-4">
					<button class="btn btn-secondary" onclick="location.href='sitter_profile.do?name=최성형'">자세히보기</button>
				</div>
			
			</div>
			<div class="row">
			<img src="https://via.placeholder.com/100x100"" class="col-sm-4"/>
				<div class="col-sm-4">
					<h4>시터이름</h4>
					<p>경력사항,특기</p>
				</div>
				<div class="col-sm-4">
					<button class="btn btn-secondary" onclick="location.href='sitter_profile.do?name=최성형'">자세히보기</button>
				</div>
			
			</div>
			<div class="row">
			<img src="https://via.placeholder.com/100x100"" class="col-sm-4"/>
				<div class="col-sm-4">
					<h4>시터이름</h4>
					<p>경력사항,특기</p>
				</div>
				<div class="col-sm-4">
					<button class="btn btn-secondary" onclick="location.href='sitter_profile.do?name=최성형'">자세히보기</button>
				</div>
			
			</div>
				
		
			
			
			
			

			
			
		</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>