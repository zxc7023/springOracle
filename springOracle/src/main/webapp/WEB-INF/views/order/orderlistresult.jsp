<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.my.vo.Product"%>
<%@ page import="com.my.vo.OrderLine"%>
<%@ page import="com.my.vo.OrderInfo"%>
<%@ page import="java.util.List"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cList" value="${requestScope.orderInfoList}" />

<!DOCTYPE html>
<html>
<head>
<link href="<%=request.getContextPath()%>/resources/reset.css" type="text/css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/resources/orderlist.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="Referrer" content="origin">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<meta name="twitter:card" content="summary">
<meta name="twitter:title" content="">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {
		var termButton = $("div.term-select").find("input");
		termButton.click(function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/order/orderlist",
				data : {
					"info_date" : $(this).val()
				},
				method : "get",
				success : function(responseData) {
					$("body").empty();
					$("body").html(responseData.trim());
				},

			})
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
	<article class=orderlist_wrap>

		<div class="term-select">
			<ul>
				<li><input type="submit" name="info_date" value="오늘" id="1day" class="button" /></li>
				<li><input type="submit" name="info_date" value="1주일" id="1week" class="button" /></li>
				<li><input type="submit" name="info_date" value="1개월" id="1month" class="button" /></li>
				<li><input type="submit" name="info_date" value="3개월" id="3month" class="button-on" /></li>
				<li><input type="submit" name="info_date" value="6개월" id="6month" class="button" /></li>
				<li><input type="submit" name="info_date" value="이전" id="previous" class="button" /></li>
			</ul>
		</div>

		<table class="type05">
			<colgroup>
				<col width="10%" />
				<col width="30%" />
				<col width="10%" />
				<col width="*" />
				<col width="15%" />
				<col width="5%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr class="title">
					<td>주문번호</td>
					<td>주문일자</td>
					<td>상품번호</td>
					<td>상품명</td>
					<td>가격</td>
					<td>수량</td>
					<td>금액</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="orderInfo" items="${cList}" varStatus="status">
					<tr class="order-line-end">
						<td rowspan="${fn:length(orderInfo.lines)}">${orderInfo.info_no }</td>
						<td rowspan="${fn:length(orderInfo.lines)}"><fmt:formatDate
								value="${orderInfo.info_date}" type="date" pattern="yyyy년 MM월 dd일 kk시 mm분" /></td>
						<c:forEach var="orderLine" items="${orderInfo.lines}" end="0">
							<td>${orderLine.line_p.prod_no }</td>
							<td>${orderLine.line_p.prod_name }</td>
							<td>${orderLine.line_p.prod_price }</td>
							<td>${orderLine.line_quantity}</td>
							<td>${orderLine.line_p.prod_price * orderLine.line_quantity}</td>
						</c:forEach>
					</tr>
					<c:forEach var="orderLine2" items="${orderInfo.lines}" begin="1">
						<tr>
							<td>${orderLine2.line_p.prod_no }</td>
							<td>${orderLine2.line_p.prod_name }</td>
							<td>${orderLine2.line_p.prod_price }</td>
							<td>${orderLine2.line_quantity}</td>
							<td>${orderLine2.line_p.prod_price * orderLine2.line_quantity}</td>
						</tr>
					</c:forEach>
				</c:forEach>
			</tbody>

		</table>
	</article>
	</section>
	
</body>
</html>