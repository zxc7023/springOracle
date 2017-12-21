<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="boardList" value="${requestScope.boardList}"></c:set>
<c:set var="pageMaker" value="${requestScope.pageMaker}"></c:set>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />



<!DOCTYPE html>
<html>
<head>
<link href="<%=request.getContextPath()%>/resources/reset.css" type="text/css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/resources/repboardlist.css" type="text/css" rel="stylesheet" />
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>게시판</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {
		/* $("ul.pagenavigation li a").click(function() {
			var $data = "page=" + $(this).attr("href");
			$.ajax({
				url : '${pageContext.request.contextPath}/repboard/repboardlist',
				method : 'get',
				data : $(this).attr("href"),
				success : function(responseData) {
					var $parentObj = $("section");
					if ($parentObj.length == 0) { //article영역의 유무에 따라 출력
						$parentObj = $("body");
					}
					$parentObj.empty();
					var tmp = $parentObj.html(responseData).find("article")
					$parentObj.html(tmp);

				},
				error : function(xhr, status, error) {
					console.log(xhr.status);
				}
			});
			return false;
		});
		 */
		/* 		$("table.repboardlist a").click(function(){
		 var $url = $(this).attr("href");
		
		 $.ajax({
		 url : $url,
		 method : 'get',
		 success : function(responseData) {
		 var $parentObj = $("section");
		 if ($parentObj.length == 0) { //article영역의 유무에 따라 출력
		 $parentObj = $("body");
		 }
		 $parentObj.empty();
		 var article = $parentObj.html(responseData).find("article");
		 $parentObj.html(article);

		 },
		 error : function(xhr, status, error) {
		 console.log(xhr.status);
		 }
		 }); 
		
		 return false;
		 });
		
		 */
	});
</script>
</head>

<body>
	<header>
		<jsp:include page="../header.jsp"></jsp:include>
	</header>

	<section>
		<article>
			<jsp:include page="repboard_search.jsp"></jsp:include>

			<table class="repboardlist">
				<colgroup>
					<col width="40%" />
					<col width="40%" />
					<col width="20%" />
				</colgroup>
				<thead>
					<tr class="tr_line">
						<td>제목</td>
						<td>작성일</td>
						<td>조회수</td>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="repBoard" items="${boardList}" varStatus="status">
						<tr class="tr_line">
							<td>
								<a href="${pageContext.request.contextPath}/repboard/detail${pageMaker.makeQuery(pageMaker.cri.page)}&no=${repBoard.no}"> <c:forEach
										begin="1" end="${repBoard.level-1}">&nbsp;&nbsp;</c:forEach> <c:if test="${repBoard.level != 1 }">
										<img src="<%=request.getContextPath()%>/resources/reply_icon.gif" style="width: 40px; height: 15px; display: inline;" />
									</c:if> <span <c:out value="${repBoard.no == no ? 'class = articleActive' : '' }"/>> ${repBoard.subject} </span>
								</a>
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
							<td>${repBoard.viewCount}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<ul class="pagenavigation">
				<c:if test="${pageMaker.prev}">
					<li><a href="repboardlist${pageMaker.makeQuery(pageMaker.startPage - 1)}">&laquo;</a></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
					<li <c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>><a href="repboardlist${pageMaker.makeQuery(idx)}">${idx}</a></li>
				</c:forEach>
				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li><a href="repboardlist${pageMaker.makeQuery(pageMaker.endPage+1)}">&raquo;</a></li>
				</c:if>
			</ul>

		</article>
	</section>
</body>
</html>