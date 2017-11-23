<%@page import="com.my.vo.Customer"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
/* 	$(function() {
		var $header = $("header");
		var $a = $header.find("a");
		$a.click(function() {
			var url = $(this).attr("href")
			$.ajax({
				url : url,
				success : function(responseData) {
					location.href = responseData.trim();
				}
			});
		});
		return false;
	}); */
</script>

/*상단 메뉴바 start*/
<script>
$(document).ready(function() {
  $('.home-menu').click(function() {
    $('nav ul').slideToggle(500);
  });//end slide toggle

  $(window).resize(function() {
		if (  $(window).width() > 700 ) {
			$('nav ul').removeAttr('style');
		 }
	});//반응형 700사이즈 이하부터 메뉴 바뀜
});//메뉴바 제이쿼리
</script>
/*상단 메뉴바 end*/

<nav class="header">
    <a href="#" class="home-menu">MENU</a>
	<ul>
		<c:choose>
			<c:when test="${empty sessionScope.loginInfo}">
				<li><a href="${pageContext.request.contextPath}/customer/signupform">가입</a></li>
				<li><a href="${pageContext.request.contextPath}/customer/login">로그인</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="${pageContext.request.contextPath}/customer/logout">로그아웃</a></li>
				<li><a href="${pageContext.request.contextPath}/customer/customerdetail\">내정보</a></li>
			</c:otherwise>
		</c:choose>
		<li><a href="productlist.do">상품목록</a></li>
		<li><a href="cartlist.do">장바구니</a></li>
		<li><a href="orderlist.do">주문목록보기</a></li>
		<li><a href="repboardlist.do">게시판</a></li>
	</ul>
</nav>
