<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="Referrer" content="origin">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<meta name="twitter:card" content="summary">
<meta name="twitter:title" content="">
<link href="<%=request.getContextPath()%>/resources/reset.css" type="text/css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/resources/index.css" type="text/css" rel="stylesheet" />
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
				<span>DEVELOPER</span> <span>준비된 인재는</span>  <span>다릅니다!</span>
			</p>

			<h2 class="profile-img">
				<img src="<%=request.getContextPath()%>/resources/junki.png" alt="junki" />
			</h2>
		</article>

		<article class="container02">

			<div class="myself">
				<div class="myself-in"></div>
				<p>우제는 롱패딩이 없어서 하나랑 데이트할때 오들오들 떨면서 춥다고 해요 이번기회에 커버낫 롱패딩이 나와서 우제는 롱패딩을 사려고하는데 할인 받기 위해서 하나는
					게인소브르 후기를 맛깔나게 써서 포인트를 오지게 지리게 받아야 되요. 그래야지 우제가 패딩을 살때 보탬이 되거든요. 빨리 우제가 롱패딩을 사서 훌찌럭 훌찌럭 안했으면
					좋겠네요ㅡ,.ㅡ</p>
			</div>
			<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> <script>
				var $animation_elements = $('.myself-in, .myself p');
				var $window = $(window);

				function check_if_in_view() {
					var window_height = $window.height();
					var window_top_position = $window.scrollTop();
					var window_bottom_position = (window_top_position + window_height);

					$.each($animation_elements, function() {
						var $element = $(this);
						var element_height = $element.outerHeight();
						var element_top_position = $element.offset().top;
						var element_bottom_position = (element_top_position + element_height);

						//check to see if this current container is within viewport
						if ((element_bottom_position >= window_top_position) && (element_top_position <= window_bottom_position)) {
							$element.addClass('in-view');
						} else {
							$element.removeClass('in-view');
						}
					});
				}

				$window.on('scroll resize', check_if_in_view);
				$window.trigger('scroll');
			</script>
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