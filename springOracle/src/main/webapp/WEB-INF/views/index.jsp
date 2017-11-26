<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="<%=request.getContextPath()%>/resources/reset.css"
	type="text/css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/resources/index.css"
	type="text/css" rel="stylesheet" />
<%-- <link href="<%=request.getContextPath()%>/resources/menu.css" type="text/css"
	rel="stylesheet" />  --%>
<title>index</title>
</head>
<body>

	<header>
		<jsp:include page="header.jsp"></jsp:include>
	</header>

	<section class="container-wrap">

		<article class="container01">
			<h2 class="hide">container01</h2>
			<p>
				<span>DEVELOPER</span> <span>준비된 인재는 다릅니다!</span>
			</p>
		</article>

		<article class="container02">
			<h2 class="hide">container02</h2>
			<p class="junki_profile">
			<%-- 	<img src="<%=request.getContextPath()%>/resources/junki.jpg"	alt="junki" /> --%>
			</p>
		</article>

		<article class="container03">
			<h2 class="hide">container03</h2>
		</article>

	</section>

	<footer>
		<!--<div>상호명 : 김준기의 홈페이지 대표이사 : 김준기/김하나 경기도 경기동 70번지 2호 사업자등록번호 :
				000-00-0000 사업자 정보확인 개인정보 보호책임자 : 대표이사 김준기 EMAIL : zxc7023@gmail.com</div> -->
	</footer>

</body>
</html>