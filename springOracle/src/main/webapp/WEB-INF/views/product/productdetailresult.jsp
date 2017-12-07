
<%@page import="com.my.vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="p" value="${requestScope.productDetail}" />
<!DOCTYPE html">
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
<link href="<%=request.getContextPath()%>/resources/product.css" type="text/css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/resources/reset.css" type="text/css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {
		var $parentObj = $("body");

		$parentObj.on("click", "#btCart", function() {
			//지금존재하는 객체의 하위 객체의 아이디가 btCart인것의 click 이벤트처리
			$.ajax({
				url : '${pageContext.request.contextPath}/cart/addcart',
				method : 'post',
				data : $(this).parents("form").serialize(),
				success : function(responseData) {
					var twoWay = confirm("장바구니를 확인 하시겠습니까?");
					if (twoWay) {
						$parentObj.empty();
						$parentObj.html(responseData);
					} else {

					}
				}
			});
			return false;
		});
	});
</script>
</head>
<body>
	<header>
		<jsp:include page="../header.jsp"></jsp:include>
	</header>
	<section>
		<div class="page-selection">
			<ol>
				<li><a href="${pageContext.request.contextPath}">홈</a></li>
				<li><a href="${pageContext.request.contextPath}/product/productlist">상품목록</a></li>
				<li><input type="text" name="prod_no" value="${p.prod_no}" readonly="readonly" style="width:50px"></li>
			</ol>
		</div>
		
	<div class="product-detail">
	<p class="product-img">🐈</p>
	
	<form id=cartform>
			<table>
				<tbody>
					<tr><td id="no"><input type="text" name="prod_no" value="${p.prod_no}" readonly="readonly"></td>
					</tr>
					<tr>
						<td id="name"><input type="text" name="prod_name" value="${p.prod_name}" readonly="readonly"></td>
					</tr>
					<tr>
						<td id="price"><input type="text" name="prod_price" value="${p.prod_price}" readonly="readonly"><span>원 </span> </td>
					</tr>
					<tr>
						<td class="quantity-title">수량선택 </td>
						<td class="quantity-input"><input type=number style="width: 100px" min="1" value="1" name="quantity"></td>
					</tr>
				</tbody>
			</table>
		<input type="button" value="장바구니담기" id="btCart">
		</form>
	</div>
	</section>
</body>
</html>