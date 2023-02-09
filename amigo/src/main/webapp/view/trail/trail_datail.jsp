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
  <script src="test.json" type="text/javascript"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>산책04_추천산책로</title>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container">

		<div id="map" style="width:100%;height:700px;"></div>
		

		</div>
	<%@include file="/includes/footer.jsp" %>

	
</body>
</html>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f2228c73e69b779ab44c4ad05812df28&libraries=services"></script>
<script>
	var mapContainer  = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var mapOption  = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(37.526215674471935   , 126.97602792607842   ), //지도의 중심좌표.
		level: 8, //지도의 레벨(확대, 축소 정도)
	};
	
	var map = new kakao.maps.Map(mapContainer, mapOption); //지도 생성 및 객체 리턴
	
	let testData = JSON.parse(JSON.stringify(TestFile));
        
    for (var i = 0; i < 100; i += 1) {    // i 100개
    	var linePath =[];
    	for (var j = 0; j < testData.features[i].geometry.coordinates[0].length; j += 1){
    	
    	
    	var lat = testData.features[i].geometry.coordinates[0][j][1], // 위도
            lon = testData.features[i].geometry.coordinates[0][j][0]; // 경도

        linePath.push(new kakao.maps.LatLng(lat, lon));

    	}

    	// 지도에 표시할 선을 생성합니다
	var polyline = new kakao.maps.Polyline({
	    path: linePath, // 선을 구성하는 좌표배열 입니다
	    strokeWeight: 4, // 선의 두께 입니다
	    strokeColor: '#F39', // 선의 색깔입니다
	 	strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
		 strokeStyle: 'solid' // 선의 스타일입니다
	}); 
		
     // 지도에 선을 표시합니다 
	polyline.setMap(map);
  
   }
 </script>
