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
  <script src="/resources/json/test.json" type="text/javascript"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>산책04_추천산책로</title>
<style>
* {margin:0;padding:0;font-family:Pretendard-Regular;font-size:20px;}
.placeinfo {position:relative;width:150%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
.placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.placeinfo .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
.placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
.placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
.placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;font-weight: bold;text-align:center;}
.placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}

</style>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
	
	<%@include file="/includes/header.jsp" %>
		<div class="container" >
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
		level: 9, //지도의 레벨(확대, 축소 정도)
	};
	
	var map = new kakao.maps.Map(mapContainer, mapOption); //지도 생성 및 객체 리턴
	
	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
	var testData = JSON.parse(JSON.stringify(TestFile));

        
    for (var i = 0; i < 100; i ++) {    // i 100개

    	var linePath =[];

    	var route_no = (testData.features[i].id).substr(14),  // 넘버
        	route_nm  = testData.features[i].properties.route_nm,   // 이름 
        	length_km = testData.features[i].properties.length_km,  // 길이
        	time2walk = testData.features[i].properties.time2walk,  // 소요시간
        	latpoint = testData.features[i].geometry.coordinates[0][0][1],
        	lonpoint = testData.features[i].geometry.coordinates[0][0][0];
    	var places    = [route_no,route_nm,length_km,time2walk];
    	

    	var marker = new kakao.maps.Marker({
            map: map, // 마커를 표시할 지도
            position: new kakao.maps.LatLng(latpoint, lonpoint)
        });

        for (var j = 0; j < testData.features[i].geometry.coordinates[0].length; j ++){
    	   	
    	var lat = testData.features[i].geometry.coordinates[0][j][1], // 위도
            lon = testData.features[i].geometry.coordinates[0][j][0]; // 경도

        linePath.push(new kakao.maps.LatLng(lat, lon));

    	}

    	// 지도에 표시할 선을 생성합니다
	var polyline = new kakao.maps.Polyline({
	    path: linePath, // 선을 구성하는 좌표배열 입니다
	    strokeWeight: 4, // 선의 두께 입니다
	    strokeColor: '#F00', // 선의 색깔입니다
	 	strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
		 strokeStyle: 'solid' // 선의 스타일입니다
	}); 
		
     // 지도에 선을 표시합니다 
	polyline.setMap(map);
   
	(function(marker, places) {
	kakao.maps.event.addListener(marker, 'click', function() {
		displayInfowindow(marker,places);
		map.panTo(marker.getPosition());
	});
	
	kakao.maps.event.addListener(map, 'click', function() {
		infowindow.close();
	});
	
	 })(marker, places);
	
    }
    
  // 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker,places,latLng) {

        // places = [route_no,route_nm,length_km,time2walk]
        
		var content = '<div class="placeinfo">' +
        '<a class="title" href=trail_detail.do?route_no='+places[0]+' title="' + places[1] + '">' + places[1] + '</a>' +
        ' <span title="' + places[2] + '"> 길이(km) : ' + places[2] + '</span>' +
        ' <span title="' + places[3] + '"> 소요시간  : ' + places[3] + '</span>' +
        '</div><div class="after"></div>';
         

		infowindow.setContent(content);
		infowindow.open(map, marker); 
 }
    
 </script>
