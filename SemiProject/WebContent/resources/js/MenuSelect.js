
$(document).ready(function() {
	
	if(localStorage.menu != "" ) {
		
		$('#' + localStorage.menu).addClass('on'); // 로컬에 저장된 메뉴값에  클래스 on 부여
	} 

})


// 메뉴 클릭시  로컬스토리지에 저장
$(function() { 
	$('li a').click(function(){
		let menuSelect = $(this).attr('data-menu');  // 클릭한 메뉴 값 저장
		localStorage.menu = menuSelect; //클릭한 메뉴값  로컬에 저장
	})
})