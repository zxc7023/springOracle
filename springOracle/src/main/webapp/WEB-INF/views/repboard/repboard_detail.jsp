<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="boardList" value="${requestScope.boardList}"></c:set>
<c:set var="prevNextList" value="${requestScope.prevNextList}"></c:set>

<!DOCTYPE html>
<head>
<link href="<%=request.getContextPath()%>/resources/reset.css" type="text/css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/resources/repboarddetail.css" type="text/css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {
		var $parentObj = $("section");
		if ($parentObj.length == 0) {
			$parentObj = $("body");
		}
		$("input[type=submit]").click(function() {
			var $parent_no = $("th.no").text();
			$.ajax({
				url : "${pageContext.request.contextPath}/repboard/insert",
				method : 'get',
				data : "parent_no=" + $parent_no,
				success : function(responseData) {
					//console.log(responseData);
					$parentObj.empty(); //객체는 있지만 기존내용 clear하고
					var tmp = $parentObj.html(responseData).find("article")
					$parentObj.html(tmp);
				},
				error : function(xhr, status, error) {
					console.log(xhr.status);
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
		<article>
			<table class="board">
				<c:forEach var="parentBoard" items="${boardList}" end="0">
					<thead>
						<tr>
							<th class="no" style="display: none;">${parentBoard.no}</th>
							<td class="title" colspan="2">${parentBoard.subject}</td>
						</tr>
					</thead>
					<tbody>
						<tr class="tr_line">
							<td>
								<fmt:formatDate value="${parentBoard.registerDate}" type="date" pattern="yyyy-MM-dd kk:mm:ss" />
							</td>
							<td>${parentBoard.viewCount}</td>
						</tr>
						<tr class="tr_line">
							<td colspan="2">${parentBoard.content}</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type='submit' name='reply' value='답글달기' />
								<input type='submit' name='modify' value='수정' />
								<input type='submit' name='delete' value='삭제' />
								<input type="submit" name="back" value="돌아가기" />
							</td>
						</tr>
					</tbody>
				</c:forEach>
			</table>
			<table class="board">
				<tbody>
					<tr class="tr_line">
						<td>이전글</td>
						<c:forEach var="prev" items="${prevNextList}" end="0">
							<c:if test="${prev==null}">
								<td></td>
								<td></td>
							</c:if>
							<c:if test="${prev!=null}">
								<td>
									<a href="${pageContext.request.contextPath}/repboard/repboarddetail?no=${prev.no}"><input type="text" value="${prev.subject}"
											readonly="readonly" /></a>
								</td>
								<td>
									<fmt:formatDate value="${prev.registerDate}" type="both" pattern="yyyy-MM-dd" var="registerDate" />
									<c:choose>
										<c:when test="${today == prev.registerDate}">
											<fmt:formatDate value="${prev.registerDate}" type="both" pattern="HH:mm" />
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${prev.registerDate}" type="both" pattern="yyyy-MM-dd" />
										</c:otherwise>
									</c:choose>
								</td>
							</c:if>
						</c:forEach>
					</tr>
					<c:forEach var="repBoard" items="${boardList}" varStatus="status" begin="1">
						<tr class="tr_line">
							<td></td>
							<td>
								<a href="${pageContext.request.contextPath}/repboard/repboarddetail?no=${repBoard.no}"> <input type="text" value="${repBoard.subject}"
										readonly="readonly" /></a>
							</td>
							<td>
								<fmt:formatDate value="${repBoard.registerDate}" type="both" pattern="yyyy-MM-dd" var="registerDate" />
								<c:choose>
									<c:when test="${today == registerDate}">
										<fmt:formatDate value="${repBoard.registerDate}" type="both" pattern="HH:mm" />
									</c:when>
									<c:otherwise>
										<fmt:formatDate value="${repBoard.registerDate}" type="both" pattern="yyyy-MM-dd" />
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td>다음글</td>
						<c:forEach var="next" items="${prevNextList}" begin="1">
							<c:if test="${next==null}">
								<td></td>
								<td></td>
							</c:if>
							<c:if test="${next!=null}">
								<td>
									<a href="${pageContext.request.contextPath}/repboard/repboarddetail?no=${next.no}"><input type="text" value="${next.subject}"
											readonly="readonly" /></a>
								</td>
								<td>
									<fmt:formatDate value="${next.registerDate}" type="both" pattern="yyyy-MM-dd" var="registerDate" />
									<c:choose>
										<c:when test="${today == next.registerDate}">
											<fmt:formatDate value="${next.registerDate}" type="both" pattern="HH:mm" />
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${next.registerDate}" type="both" pattern="yyyy-MM-dd" />
										</c:otherwise>
									</c:choose>
								</td>
							</c:if>
						</c:forEach>
					</tr>
				</tbody>
			</table>
		</article>
	</section>

</body>