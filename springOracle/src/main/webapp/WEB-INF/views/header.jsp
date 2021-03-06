<%@page import="com.my.vo.Customer"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="Referrer" content="origin">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<meta name="twitter:card" content="summary">
<meta name="twitter:title" content="">
<link href="<%=request.getContextPath()%>/resources/menu.css" type="text/css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		$("a[href$='/logout']").click(function() {
			var $url = $(this).attr('href');
			$.ajax({
				url : $url,
				success : function(responseData) {
					console.log(responseData);
					location.href = responseData.trim();
				}
			});
			return false;
		});

		$('.home-menu').click(function() {
			$('nav ul').slideToggle(500);
		});//end slide toggle

		$(window).resize(function() {
			if ($(window).width() > 700) {
				$('nav ul').removeAttr('style');
			}
		});//반응형 700사이즈 이하부터 메뉴 바뀜
	});//메뉴바 제이쿼리
</script>

<nav class="header">
	<a href="#" class="home-menu">MENU</a>
	<ul>
		<li><a href="${pageContext.request.contextPath}">홈 </a></li>
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
		<li><a href="${pageContext.request.contextPath}/product/productlist">상품목록</a></li>
		<li><a href="${pageContext.request.contextPath}/cart/cartlist">장바구니</a></li>
		<li><a href="${pageContext.request.contextPath}/order/orderlist">주문목록보기</a></li>
		<li><a href="${pageContext.request.contextPath}/repboard/repboardlist">게시판</a></li>
	</ul>
</nav>
