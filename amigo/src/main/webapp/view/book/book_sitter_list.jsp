<%@page import="com.lec.amigo.vo.SitterVO"%> <%@page
import="com.lec.amigo.vo.ChatVO"%> <%@page import="java.util.List"%> <%@page
import="com.lec.amigo.dao.ChatDAO"%> <%@ page language="java"
contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
    <% String addr = request.getParameter("addr"); %>

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
        display: flex;
        margin: 50px auto;
        padding-right: 10px;
        border-radius: 10px;
        width: 450px;
        height: 300px;
        background-color: #f8f9fa;
        align-items: center;
        flex-direction: column;
        justify-content: space-around;
        box-shadow: 1px 1px 20px rgba(0, 0, 0, 0.2);
      }

      #item-box-shadow:hover {
        box-shadow: 1px 1px 20px #69abce;
      }

      .sitter_list_title {
        font-family: "Jalnan";
        font-size: 30px;
        color: rgb(87, 160, 227);
        text-align: center;
      }

      th {
        font-family: "Jalnan";
      }
    </style>
  </head>
  <body>
    <script type="text/javascript">

      $(document).ready(function(){
        	 let b = ${calr};
        	 $('#bookDate').val(JSON.stringify(b));
      });
       	function sendJsonUrl(curPage,rowSize){
       		console.log('입장확인용');
       	    var f = document.f;
       	    f.curPage.value=curPage;
       	    f.rowSizePerPage.value=rowSize;
       	    f.submit();
       	}
    </script>

    <%@include file="/includes/header.jsp"%>
    <div class="container col-md-6">
      <section>
        <article class="ssitter_list">
          <h2 class="sitter_list_title"><%=addr%> 펫시터 목록</h2>
          <hr />
          
          <!-- 시 단위의 시터목록 -->
          <c:choose>

            <c:when test="${sittList!=null && !sittList.isEmpty() }">
              <c:forEach var="sit" items="${sittList }">

                <div
                  class="sitter_item"
                  id="item-box-shadow"
                  style="cursor: pointer"
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
                  <table>
                    <tr>
                      <th style="width: 100px; padding: 2px">이름</th>
                      <td>${sit.getUser_name() }</td>
                    </tr>
                    <tr>
                      <th style="padding: 2px">시간</th>
                      <td>${sit.getSit_time() }</td>
                    </tr>
                    <tr>
                      <th style="padding: 2px">경력 및 특기</th>
                      <td>${sit.sit_care_exp }</td>
                    </tr>
                  </table>
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
  </body>
</html>
