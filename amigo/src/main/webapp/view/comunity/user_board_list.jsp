<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<title>게시판01_유저커뮤니티</title>
<!-- 
         사용시 에러발생 
   <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-2/css/all.min.css"
      integrity="sha256-46r060N2LrChLLb5zowXQ72/iKKNiw/lAmygmHExk/o="
      crossorigin="anonymous"
    />
    -->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
      <style>
      .card {
       box-shadow: 5px 2px 20px rgba(0,0,0,0.2);
      }

      .card {
        position: relative;
        display: flex;
        flex-direction: column;
        min-width: 0;
        word-wrap: break-word;
        background-color: #fff;
        background-clip: border-box;
        border: 0 solid rgba(0, 0, 0, 0.125);
        border-radius: 0.25rem;
      }
      
      .card:hover{
        box-shadow: 5px 2px 20px #69abce;
      }

      .card-body {
        flex: 1 1 auto;
        min-height: 1px;
        padding: 1rem;
      }
      
      
      .udb-header-menu {
      font-family: "Jalnan";
         padding:15px;   
      }
      
      .ubd-header-title{
       font-family: "Jalnan";
       font-size:40px;
       
      }
      
       .ubd-header-menu:link {
        color: gray;
      }
      .ubd-header-menu:visited {
        color: gray;
      }
      .ubd-header-menu:hover {
        color: #189cc4;
      }
      
    </style>
    
	<!-- far fa icon 불러오기 -->
	<link rel="stylesheet" href=
	"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css">
	</head>

<body>
<%@include file="/includes/header.jsp" %>



   <div class="container col-md-6" align="left">
      <div class="mt-4">
         <p class="ubd-header-title">유저 커뮤니티</p>
      </div> 
      <hr/>
               
         <!-- 상단 메뉴 -->
            <div class="row justify-content-between">
               <div class="col-auto">
               <a class="ubd-header-menu" href="user_board_list.do">전체글</a>&nbsp;&nbsp;
                  <a class="ubd-header-menu" href="user_board_list_like.do?curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}&searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}">인기글</a>&nbsp;&nbsp;
                  
                  <c:if test="${user.getUser_type() == 'S' || user.getUser_type() == 'A'}">
                  <a class="ubd-header-menu" href="sitter_board_list.do">펫시터커뮤니티</a>
                  </c:if>
                  
               </div>
                     <div class="col-auto">
               <select class="form-select" id="searchCategory" name="searchCategory" onchange="chageSelect()">
                   <option value="말머리">말머리</option>                     
                   <option value="자랑글">자랑글</option>                  
                   <option value="자유글">자유글</option>                     
                   <option value="질문">질문</option>                              
               </select>
                 </div>    
            
         </div>
      

      <div class="container">               
         <c:if test="${ boardList.isEmpty() }">
            <h6 class="text-center">등록된 글이 없습니다.</h6>
         </c:if>
               <c:forEach  var="board" items="${ boardList }">
                    <div class="container" style="cursor: pointer;">
            <!-- Forum List -->
            <!-- div를 눌러서 접속 될수 있게 만듦 -->
            <div class="inner-main-body p-2 p-sm-3 forum-content show" >
              <div class="card mb-2">
                <div class="card-body p-2 p-sm-3">
                  <div class="media forum-item">
                  <!-- user profile 아직 미완성이라 여기 완성되면 다른 리스트에도 복붙!!-->
                   <c:choose>
                      <c:when test="${board.getUser_photo()!=null and board.getUser_photo()!=''}">
                      <img src="/userimg/${board.getUser_photo()}" alt="userProfile" width="50px" class="mr-3 rounded-circle" />
                     </c:when>
                     <c:otherwise>
                     <img src="resources/img/logo2.png" alt="logo2" width="50px" class="mr-3 rounded-circle" alt="logo2"/>
                     </c:otherwise>
                   </c:choose>
                    <!-- user profile/ -->
                    <div class="media-body" >
                      <!-- 말머리 -->
                        <div class="text-secondary">${ board.getUbd_cate()}</div>
                      <!-- 말머리/ -->
                      <!-- 제목 -->
                      <h6>
                      <a class="text-body" style="font-size:20px;" href="user_board_detail.do?ubd_no=${board.getUbd_no()}&user_no=${user.getUser_no()}
                      &curPage=${searchVO.getCurPage()}&rowSizePerPage=${searchVO.getRowSizePerPage()}
                      &searchType=${searchVO.getSearchType()}&searchWord=${searchVO.getSearchWord()}&updateCount_is=abc&cnt=1">${board.getUbd_title()}</a><span> [${board.getReply_cnt()}]</span>
                      </h6>
                      <!-- 제목/ -->
                      <p class="text-muted">
                      <!-- 작성자 -->
                        <span class="nickName" style="color:#498dcc; font-weight:bold">${ board.getUser_nick() }</span>&nbsp;
                       <!-- 작성자/ -->
                       <!-- 작성일 -->
                        <span class="text-secondary font-weight-bold">
                        <fmt:formatDate value="${board.ubd_date}" pattern="yyyy-MM-dd"/></span>
                        &nbsp;<span><i class="fa-solid fa-dog"></i>${board.getDog_kind()}</span>
                         <!-- 작성일자/ -->      
                      </p>
                    </div>
                    <div class="text-muted small text-center align-self-center">
                      <span class=""><i class="fa fa-eye"></i>${ board.ubd_cnt }</span>&nbsp;&nbsp;
                      <span><i class="fa fa-heart" aria-hidden="true"></i>${ board.getLike_cnt() }</span>
                       </div>
                       </div>
                      </div>
                       </div>
                  </div>
              </div>
          </c:forEach>
          </div>
      <div class="row align-items-start mt-3">
         <ul class="col pagination justify-content-center">
         
            <c:set var="cp" value="${searchVO.getCurPage()}"/>
            <c:set var="rp" value="${searchVO.getRowSizePerPage()}"/>
            <c:set var="fp" value="${searchVO.getFirstPage()}"/>
            <c:set var="lp" value="${searchVO.getLastPage()}"/>
            <c:set var="ps" value="${searchVO.getPageSize()}"/>
            <c:set var="tp" value="${searchVO.getTotalPageCount()}"/>
            <c:set var="sc" value="${searchVO.getSearchCategory()}"/>
            <c:set var="st" value="${searchVO.getSearchType()}"/>
            <c:set var="sw" value="${searchVO.getSearchWord()}"/>
                                                
            <c:if test="${ fp != 1 }">
               <li class="page-item"><a href="user_board_list.do?curPage=1&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-fast-backward"></i></a></li>
               <li class="page-item"><a href="user_board_list.do?curPage=${fp-1}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-backward"></i></a></li>            
            </c:if>
         
            <c:forEach var="page" begin="${fp}" end="${lp}">
               <li class="page-item ${cp==page ? 'active' : ''}"><a href="user_board_list.do?curPage=${page}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link">${page}</a></li>
            </c:forEach>
            
            <c:if test="${ lp < tp }">
               <li class="page-item "><a href="user_board_list.do?curPage=${lp+1}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-forward"></i></a></li>            
               <li class="page-item"><a href="user_board_list.do?curPage=${tp}&rowSizePerPage=${rp}&searchType=${st}&searchWord=${sw}" class="page-link"><i class="fas fa-fast-forward"></i></a></li>            
            </c:if>
         </ul> <!-- pagination -->   
   
      </div> <!-- 페이징 -->
      
   
      <!-- 하단 검색 시스템 -->
      <form action="user_board_list.do" method="post" >  
      	<div class="row align-items-center mt-3 mb-3">
            <div class="col-3 ms-auto mb-3">
               <select class="form-select" id="searchType" name="searchType">
                   <option value="">검색</option>                     
                   <option value="ubd_title" ${searchVO.getSearchType()=="ubd_title" ? "selected" : "" }>제목</option>                     
                   <option value="user_nick" ${searchVO.getSearchType()=="user_nick" ? "selected" : ""}>작성자</option>                  
                   <option value="ubd_cont" ${searchVO.getSearchType()=="ubd_cont" ? "selected" : ""}>글내용</option>                  
               </select>
            </div>
            <div class="col-5 ms-auto mb-3">
               <input class="form-control me-2 col-6" name="searchWord" type="text" placeholder="내용을 입력하세요." />
			</div>
            <div class="col-2 me-auto mb-3">
                <input type="submit" class="btn btn-primary" value="검색">
            </div>         
       </div>
			
            <div class="container" align="center">
             	<a href="user_board_insert.do" class="btn btn-primary">글 작성하기</a>
            </div>
      </form>
    </div>      
       
<%@include file="/includes/scrollTop.jsp" %>       
<%@include file="/includes/footer.jsp" %>

               <script type="text/javascript">
               
               function chageSelect(){ 
                  
                  var selectList = document.getElementById("searchCategory")
                  
                  if(selectList.options[selectList.selectedIndex].value == "말머리"){
                     location.href = "user_board_list.do?";
                  }
                  if(selectList.options[selectList.selectedIndex].value == "자랑글"){
                     location.href = "user_board_cate.do?ubd_cate=자랑글";
                  }
                  if(selectList.options[selectList.selectedIndex].value == "자유글"){
                     location.href = "user_board_cate.do?ubd_cate=자유글";
                  }
                  if(selectList.options[selectList.selectedIndex].value == "질문"){
                     location.href = "user_board_cate.do?ubd_cate=질문";
                  }
               }
               </script>     
</body>
</html>