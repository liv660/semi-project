<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유기동물 관리</title>

<!-- jQuery 2.2.4 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<!-- 부트스트랩 3.2.2 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>





<style type="text/css">


#wrap{ max-width:1920px; 
	min-width:1280px; 
	width:100%; 
	background-color:rgba(234,205,153, 0.3 );
	margin:0 auto;
}

#header {
   width: 1200px;
   margin: 0 auto;
}

#login {
   width: 1200px;
   height: 50px;
}

#login > button {
    float: right;  
   margin-top: 10px;
   margin-right: 10px;
   background-color: transparent !important;
}

#loginNick {
   float: right;
   margin-top: 10px;
}

.navbar {
   background-color: none;
   margin:0;
}

.container-fluid .navbar-header {
/*    margin-right: 30px; */
/*     margin-left: 10px; */
    width:150px;
    height:70px;
/*     padding-left:45px; */
    margin-bottom:10px;
   
}
.container-fluid .navbar-header h1{width:150px; height:70px;
	padding:0;
	margin:0;
}
.container-fluid .navbar-header h1 a{display:block; width:100%; height:100%;}
.container-fluid .navbar-header img{width:100%; height:100%; z-index:99;}



/* 메뉴 가운데 정렬 */
.navbar .navbar-nav {
  display: inline-block;
  float: none;
  vertical-align: bottom;
}

.navbar .navbar-collapse {
  text-align: center;
}
/* 가운데 정렬 끝 */


.nav li a {
   	font-size: 1.05em;
	font-weight: bold;
	display: block;
	padding: 1em 3em;
}

.nav li a:link, .nav li a:visited {
     color: #aaa;  
     background : none;  
} 

.nav li a:hover, .nav li a:active { 
 	color: #EBAA5F; 
 	background: none; 
} 

.nav li a:after { 
    display:block; 
    content: ''; 
    border-bottom: solid 1px #EBAA5F;
    transform: scaleX(0); 
   	transition: transform 250ms ease-in-out; 
} 
.nav li a:hover:after { 
    transform: scaleX(1); 
} 

.on {
	color :#EBAA5F !important;
}


</style>


</head>
<body>
<div id="wrap">
<div id="header">
<%   if(session.getAttribute("login") == null || !(boolean)session.getAttribute("login")) { %>
<!-- 비로그인상태 -->

   <div id="login">
      <button class="btn" onclick="location.href= '/login/login';">로그인</button>
      <button class="btn" onclick="location.href= '/login/terms';">회원가입</button>
   </div>

<%   } else if( (boolean)session.getAttribute("login") ) { %>
<!-- 로그인상태 -->

   <div id="login">
      <div id="loginNick">
         <%=session.getAttribute("nick") %>님 
         <%	if(session.getAttribute("adminid") != null && (boolean)session.getAttribute("login")) { %>
         <button class="btn" onclick="location.href='/admin'">관리자홈</button> |
         <button class="btn" onclick="location.href= '/login/logout';">로그아웃</button> 
         <% } else { %>
         <button class="btn" onclick="location.href= '/mypage';">마이페이지</button> |
         <button class="btn" onclick="location.href= '/login/logout';">로그아웃</button> 
         <% } %>
      </div>
   </div>

<%   } %>

<!-- <nav class="navbar navbar-default"> -->
<nav class="navbar">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <h1 class="navbar-brand" >
      	<a href="/main" title="메인으로이동">
         <img src="../resources/se2/img/logo.png" />
        </a>
      </h1>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
      <!-- 해주시죠 고수씨 -->
        <li class="active topMenuLi"><a href="/find/list" id="menu1" data-menu="menu1" ><span>반려동물 찾기</span></a></li> 
        <li class="topMenuLi"><a href="/discover/list" id="menu2" data-menu="menu2" ><span>유기동물 발견</span></a></li> 
        <li class="topMenuLi"><a href="/product" id="menu3" data-menu="menu3" ><span>스토어</span></a></li>
        <li class="topMenuLi"><a href="/review/list" id="menu4" data-menu="menu4" ><span>후기</span></a></li>
        <li class="topMenuLi"><a href="/notice/list" id="menu5" data-menu="menu5"><span>공지사항</span></a></li>
      </ul>
    </div>
  </div>
</nav>

</div>
<script type="text/javascript" src="/resources/js/MenuSelect.js"> 
</script>