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
<title>my02_예약확인~예약취소</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	<%@include file="/includes/header.jsp" %>
		<div class="container">
			<section>	
				<article>
					<h3>예약확인</h3>
					<p>펫시터</p>
				</article>
				
				<c:choose>
				<c:when test='${user.getUser_type().equals("U") }'>
					<article>
						<c:choose>
						<c:when test="${myBookList!=null}">	
							<c:forEach var="book" items="${myBookList }">
								<c:forEach var="sit" items="${sitList }">
								<c:if test="${ book.getSit_no()==sit.getSit_no()}">
								<li>
									<table>
										<tr><td colspan="2">${sit.getUser_name() } 펫시터</td></tr>
										<tr>
											<td>예약장소</td><td>${book.getRes_addr() }</td>
										</tr>
										<tr>
											<td>예약날짜</td><td>${book.getRes_date() }</td>
										</tr>
										<tr>
											<td>예약시간</td><td>${book.getRes_time() }</td>
										</tr>
										<tr>
											<td>결제금액</td><td>${book.getRes_pay() }</td>
										</tr>
										<tr>
											<td>특이사항</td><td>${book.getRes_etc() }</td>
										</tr>
									</table>
								</li>
												
								</c:if>	
								</c:forEach>
							</c:forEach>
							</ul>
						</c:when>
						<c:otherwise>
							<h2>예약사항이 없습니다</h2>
						</c:otherwise>
						</c:choose>
					</article>
					</c:choose>
				</c:when>
				<c:when test='${user.getUser_type().equals("P") }'>
					<h1>시터전용</h1>
				</c:when>
			</section>	
		</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>