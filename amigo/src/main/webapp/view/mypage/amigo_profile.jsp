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
<title>amigo_profile</title>
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

      .card-body {
        flex: 1 1 auto;
        min-height: 1px;
        padding: 1rem;
      }
      
      .dog-profile-photo{
      position: relative;
     
      
      }
</style>
<link rel="stylesheet" href=
"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css">
</link>
</head>
<body>

    
   
   
   
   <%@include file="/includes/header.jsp" %>
      <div class="container mt-3">
      
      
      <c:choose>
          <c:when test="${ dogList.isEmpty() || dogList == null }">
              <div class="text-center">
            <h5><p class="bg-danger">반려동물이 없습니다.</p></h5>
                <p>반려동물 프로필을 등록하세요!</p>
                <a href="amigo_profile_insert.jsp" class="col-1 btn btn-primary">등록하기</a>
            </div>
         </c:when>
      
      <c:otherwise>
      <div class="container text-center">
      <p style="color:#498dcc; font-weight:bold; font-family: Jalnan; font-size: 35px;">당신의 AM!GO</p>
      <p style="font-family: jalnan; font-size: 20px;">클릭하시면 프로필 수정이 가능합니다.</p>
      </div>
         <div class="container col-md-6 ">
            <table class="table table-hover table-bordered">
               
               <!-- 수정본  -->
               
               <div class="container">					
					 <c:forEach var="dog" items="${ dogList }">
                    <div class="container">
            <!-- Forum List -->
            <!-- div를 눌러서 접속 될수 있게 만듦 -->
            <div class="inner-main-body p-2 p-sm-3 forum-content show" >
              <div class="card mb-2">
                <div class="card-body p-2 p-sm-3">
                  <div class="media forum-item" style="cursor: pointer;" onclick="location.href='updateDog.do?dog_no=${dog.getDog_no()}'">
                  <!-- Dog profile -->
              <div style="text-align: center">  <c:if test="${dog.getDog_image_file()!=null and dog.getDog_image_file()!=''}">
                           <img class="dog-profile-photo" src="/dogimg/${dog.getDog_image_file()}" width="150px" height="100px" style="border-radius:20px;"></c:if> 
                           </div>
                    <!-- Dog profile/ -->
                    <div class="media-body">
                    
                     <!-- 이름 -->
                      <h6 style="text-align: center; margin-top:10px;">
                      <a class="text-body" style="font-size:20px; margin-top:5px; font-family: 'Jalnan';">${dog.getDog_name()}</a>
                      </h6>
                      <!-- /이름 -->
                      <p class="text-muted" style="margin-top:20px;">
                      <!-- 품종 -->
                        <span class="nickName" style="font-weight:bold"><i class="fa-solid fa-dog">&nbsp;&nbsp;${ dog.getDog_breeds()}</i></span>&nbsp;
                       <!-- /품종 -->
                      <!-- 성별 -->
                      <span class="text-secondary"><c:choose><c:when test="${ dog.getDog_gender()=='f' }"><i class="fa fa-venus"></i></c:when>
                                    <c:when test="${ dog.getDog_gender()=='m' }"><i class="	fa fa-mars"></i></c:when></c:choose></span>
                      <!-- /성별 -->
                      <!-- 생일 -->
                      <span>생일 : ${ dog.getDog_birth() }</span>
                      <!-- /생일  -->
                      <!-- 몸무게 -->
                      &nbsp;&nbsp;<span>체중 : ${ dog.getDog_weight() }kg</span>
                      <!-- /몸무게 -->
                      </p>
                    </div>
                 		</div>
                 		<div class="container text-center">
                 		<button type="button" class="btn btn-outline-danger text-center" data-bs-toggle="modal" data-bs-target="#dogdelete"
                        data-dog_no="${dog.getDog_no()}" data-dog_image_file="${dog.getDog_image_file()}">삭 제</button>
                		</div>
                		</div>
              			</div>
 			        </div>
 			    </div>
 			</c:forEach>
 			</div>
 			
            </table>
         
         <!-- 반려동물 추가 -->   
            <div class="text-center mb-5 mt-5">
               <a href="amigo_profile_insert.jsp" class="btn btn-primary">반려동물 추가</a>
            </div>
       </c:otherwise>
      </c:choose>
      </div>
          <!--삭제 modal form  -->
            <div id="dogdelete" class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="dogdeleteLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="dogdeleteLabel">반려동물 삭제</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    반려견 정보를 정말 삭제하시겠습니까?
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-danger" onclick="deleteDog();">삭제</button>
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
                  </div>
                </div>
              </div>
              </div>
              </div>
      <!--삭제 modal form script dog_no전달-->     
      <script>
      var DOGNO="";
      var DOGIMAGE="";
      $(document).ready(function() {     
           $('#dogdelete').on('show.bs.modal', function(event) {          
              DOGNO = $(event.relatedTarget).data('dog_no');
              DOGIMAGE =  $(event.relatedTarget).data('dog_image_file');      
           });
       });
      function deleteDog() {location.href='deleteDog.do?dog_no='+DOGNO+'&dog_image_file='+DOGIMAGE;}
      </script>
      
    <!-- 부트 and js  -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/script.js"></script>
   <%@include file="/includes/footer.jsp" %>

</body>
</html>