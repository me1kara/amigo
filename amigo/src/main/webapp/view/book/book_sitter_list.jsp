<%@page import="com.lec.amigo.vo.SitterVO"%> <%@page
import="com.lec.amigo.vo.ChatVO"%> <%@page import="java.util.List"%> <%@page
import="com.lec.amigo.dao.ChatDAO"%> <%@ page language="java"
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
  <head>

    <script
      src="https://code.jquery.com/jquery-3.6.3.min.js"
      integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
      crossorigin="anonymous"
    ></script>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta charset="UTF-8" />
    <title>펫시터03_펫시터목록</title>
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
    <![endif]-->

    <style>
      a:hover {
        color: white;
        text-decoration: none;
      }
      a:active {
        color: white;
        text-decoration: none;
      }
      a:visited {
        color: white;
        text-decoration: none;
      }
      a:link {
        color: white;
        text-decoration: none;
      }

      .container {
        width: 70%;
      }

      * {
        margin: 0 auto;
      }

      .sitter_list {
        text-align: left;
        margin: 0 auto;
        padding: 10px;
        margin-top: 80px;
      }

      .sitter_item {
        padding-top: 25px auto;
        padding-right: 10px;
        border-radius: 10px;
        max-width : 970px;
        height : 146px;
        align-items: center;
        border-bottom: 1px solid #e1e1e1;

      }

      #item-box-shadow:hover {
        box-shadow: 1px 1px 20px #69abce;
      }

      .sitter_list_title {
        font-family: "Jalnan";
        font-size: 25px;
        color: rgb(87, 160, 227);
        text-align: center;
      }

      th {
        font-family: "Jalnan";
      }
      
      article{
      	margin-bottom: 10px;
      }
      .sitter_item > div {
	    max-width: 100px; /* 첫 번째 자식 요소의 최대 너비 설정 */
	    flex-shrink: 0; /* 자식 요소 크기 고정 */
	    margin-right: 10px; /* 간격 설정 (원하는 간격으로 조절) */
	  }
	
	.sitter_item ul.sitter-content {
	    flex-grow: 1; /* 나머지 공간을 모두 차지하도록 설정 */
	    white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis;
	  }
      
      .sitter-content > li:first-child{
      	font-size: 18px;
    
      }

      .sitter-content > li:not(:first-of-type){
      	font-size: 14px;
      }
      
    </style>
  </head>
  <body>
    <%@include file="/includes/header.jsp"%>
    <div class="container col-md-6">
      <section>
        <article class="ssitter_list">
          <h2 class="sitter_list_title">${addr } 펫시터 목록</h2>
          <hr />
          
          <!-- 시 단위의 시터목록 -->
          <c:choose>

            <c:when test="${sittList!=null && !sittList.isEmpty() }">
              <c:forEach var="sit" items="${sittList }">

                <div
                  class="sitter_item d-flex"
                  id="item-box-shadow"
                  style="cursor: pointer;"
                  onclick="location.href='sitter_profile.do?sit_no=${sit.getSit_no()}&user_name=${sit.getUser_name() }';"
                >
                  <div>
                  	<c:choose>
                  	<c:when test="${not empty sit.sit_photo }">
                    <img
                      src="/sitterimg/${sit.sit_photo}"   
                      width="100px"
                      height="100px"
                      style="border-radius:20px;"
                    />
                    </c:when>
                    <c:otherwise>
                    <img
                      src="https://via.placeholder.com/100x100"   
                      width="100px"
                      height="100px"
                      style="border-radius:20px;"
                    />
                    </c:otherwise>
                    </c:choose>
                    
                  </div>
                  <!-- 전체 테이블 -->
             
                  <ul style="list-style: none;" class="sitter-content">
                    <li><b>${sit.getUser_name() }</b></li>
                    <li>${sit.getSit_time() }</li>
                    <li style="white-space: nowrap; max-width:inherit; text-overflow: ellipsis; overflow: hidden;">${sit.sit_care_exp }</li>
                  </ul>
                  <!-- 전체 테이블 end -->
                </div>
              </c:forEach>
              
              <!-- 페이징처리 -->
              <c:if test="${searchVO.totalPageCount>1 }">
                <div class="row align-items-start mt-3">
                  <ul class="col pagination justify-content-center">
                    <c:set var="cp" value="${searchVO.getCurPage()}" />
                    <c:set var="rp" value="${searchVO.getRowSizePerPage()}" />
                    <c:set var="fp" value="${searchVO.getFirstPage()}" />
                    <c:set var="lp" value="${searchVO.getLastPage()}" />
                    <c:set var="ps" value="${searchVO.getPageSize()}" />
                    <c:set var="tp" value="${searchVO.getTotalPageCount()}" />
                    <c:if test="${ fp != 1 }">
                      <li class="page-item">
                        <button class="btn" onclick="sendJsonUrl(1,${rp})">
                          <i class="fas fa-fast-backward"></i>
                        </button>
                      </li>
                      <li class="page-item">
                        <button
                          class="btn"
                          onclick="sendJsonUrl(${fp-rp},${rp})"
                        >
                          <i class="fas fa-backward"></i>
                        </button>
                      </li>
                    </c:if>
                    <c:forEach var="page" begin="${fp}" end="${lp}">
                      <li class="page-item ${cp==page ? 'active' : ''}">
                        <button
                          class="btn page-link"
                          onclick="sendJsonUrl(${page},${rp})"
                        >
                          ${page}
                        </button>
                      </li>
                    </c:forEach>
                    <c:if test="${ lp < tp }">
                      <li class="page-item">
                        <span class="btn" onclick="sendJsonUrl(${lp+1},${rp})"
                          ><i class="fas fa-forward"></i
                        ></span>
                      </li>
                      <button class="btn" onclick="sendJsonUrl(${tp},${rp})">
                        <i class="fas fa-fast-forward"> </i>
                      </button>
                    </c:if>
                  </ul>
                  <!-- 페이징마침 -->
                </div>
              </c:if>
            </c:when>
            <c:otherwise>
              <h1>해당한 지역의 펫시터가 없습니다!</h1>
            </c:otherwise>
          </c:choose>
        </article>
        <article style="text-align: center">
          <button class="btn btn-dark" onclick="history.go(-1)">이전</button>
        </article>
      </section>
    </div>
	<%@include file="/includes/footer.jsp" %>

    <!-- json보내기용 -->
    <form name="f" action="book.do">
      <input type="hidden" name="res_addr" value="${address }" />
      <input type="hidden" name="rowSizePerPage" />
      <input type="hidden" name="curPage" />
      <input type="hidden" id="bookDate" name="bookDate" />
    </form>
     <script type="text/javascript">

      $(document).ready(function(){
        	 let b = ${calr};
        	 $('#bookDate').val(JSON.stringify(b));
      });
       	function sendJsonUrl(curPage,rowSize){
       	    var f = document.f;
       	    f.curPage.value=curPage;
       	    f.rowSizePerPage.value=rowSize;
       	    f.submit();
       	}
    </script>
  </body>
</html>
