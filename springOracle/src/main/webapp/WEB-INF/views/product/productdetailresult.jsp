
<%@page import="com.my.vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="p" value="${requestScope.productDetail}" />
<!DOCTYPE html">
<html>
<head>
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
			$parentObj.off();
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
		<form id=cartform>
			<table>
				<thead>
					<tr>
						<th colspan="2">상품상세정보</th>
						<td></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>상품번호</td>
						<td id="no"><input type="text" name="prod_no" value="${p.prod_no}" readonly="readonly"></td>
					</tr>
					<tr>
						<td>상품명</td>
						<td id="name"><input type="text" name="prod_name" value="${p.prod_name}" readonly="readonly"></td>
					</tr>
					<tr>
						<td>상품가격</td>
						<td id="price"><input type="text" name="prod_price" value="${p.prod_price}" readonly="readonly"></td>
					</tr>
					<tr>
						<td>수량</td>
						<td><input type=number style="width: 100px" min="1" value="1" name="quantity"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="button" value="장바구니담기" id="btCart"></td>
					</tr>
				</tbody>
			</table>
		</form>
	</section>
</body>
</html>