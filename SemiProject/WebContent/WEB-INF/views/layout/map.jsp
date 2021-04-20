<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<style type="text/css">

.wrap {
	width:1000px;
	margin : 0 auto;
}

.box {
	float:left
}

.textbox {
	width: 40%;
	height: 350px;
	margin-left : 30px;
	border-left: 1px solid black;
}

.wrap h2 {
	margin : 50px;
}

.wrap h4 {
	margin-left : 10px;
	font-weight: bold;
}

.wrap span {
	margin-left : 50px;
}

.wrap .subtitle {
	margin-top : 30px;
}

.clear {
	clear: both;
	height:0px;
	overflow:hidden;
}

</style>

<div class="wrap">

<h2>찾아오시는 길</h2>

<div class="clear"></div>

<div id="map" style="width:49%; height:350px; z-index: 0;" class="box"></div>
<div class="box textbox">

<h4>주소</h4>
<span>서울특별시 강남구 테헤란로14길 6 남도빌딩</span>
<h4 class="subtitle">대중교통 이용시</h4>
<span>역삼역 3번출구 방향 500m 직진</span> <br>
<span>강남역 1번출구 방향 500m 직진</span>
<h4 class="subtitle">전화번호</h4>
<span>02-1234-5678</span>
<h4 class="subtitle">FAX</h4>
<span>02-1234-5678</span>
</div>

<div class="clear"></div>

</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3f19d8a0b62c7447d148d0c69bf17c0b&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), 
    mapOption = {
        center: new kakao.maps.LatLng(37.49919726447784, 127.03285535302733), // 지도의 중심좌표
        level: 3
    };  

var map = new kakao.maps.Map(mapContainer, mapOption); 

var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표 검색
geocoder.addressSearch('서울특별시 강남구 테헤란로14길 6 남도빌딩', function(result, status) {

     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        map.setCenter(coords);
    } 
});    
</script>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>