<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="boardList" value="${requestScope.boardList}"></c:set>
<c:set var="preBoard" value="${requestScope.preBoard}"></c:set>
<c:set var="nextBoard" value="${requestScope.nextBoard}"></c:set>
<c:set var="no" value="${requestScope.no}"></c:set>
<c:set var="cri" value="${requestScope.cri}"></c:set>
<c:set var="pageMaker" value="${requestScope.pageMaker}"></c:set>

<!DOCTYPE html>
<head>
<link href="<%=request.getContextPath()%>/resources/reset.css" type="text/css" rel="stylesheet" />
<link href="<%=request.getContextPath()%>/resources/repboarddetail.css" type="text/css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {
		
		var loading;
		if($("div#loading, img#loading_img").length !=2){
			loading = $('<div id="loading" class="loading"></div><img id="loading_img" alt="loading" src="<%=request.getContextPath()%>/resources/viewLoading.gif" />').appendTo(document.body).hide();
		}
		else{
			loading =$("div#loading, img#loading_img");
		}
		$(document).ajaxStart(function() {
			loading.fadeIn(200);
		}).ajaxStop(function() {
			loading.fadeOut();
		});

		var $parentObj = $("section");
		if ($parentObj.length == 0) {
			$parentObj = $("body");
		}

		//hidden태그 폼
		var formObj = $("form[role=form]");

		$("input[name=reply]").click(function() {
			var $parent_no = $("th.no").text();

			$.ajax({
				url : "${pageContext.request.contextPath}/repboard/insert",
				method : 'post',
				data : "parent_no=" + $parent_no + "&" + $("form#replyboard").serialize(),
				success : function(responseData) {
					var data = responseData.trim();
					if (data == '-1') {
						alert('게시글 작성에 실패 하였습니다.');
					} else {
						formObj.find("input[name=no]").val(data);
						$.ajax({
							url : "${pageContext.request.contextPath}/repboard/repboarddetail",
							method : 'get',
							data : formObj.serialize(),
							success : function(responseData2) {
								$parentObj.empty();
								var tmp = $parentObj.html(responseData2).find("article")
								$parentObj.html(tmp);
							},
							error : function(xhr, status, error) {
								console.log(xhr.status);
							}
						});
					}

				},
				error : function(xhr, status, error) {
					console.log(xhr.status);
				}
			});
			return false;
		});

		$("input[name=modify]").click(function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/repboard/checkpassword",
				method : 'get',
				data : {
					type : $(this).attr("name")
				},
				success : function(responseData) {
					$parentObj.empty();
					$parentObj.html(responseData);
				},
				error : function(xhr, status, error) {
					console.log(xhr.status);
				}
			});
			return false;
		});

		$("input[name=back]").click(function() {
			formObj.attr("method", "get");
			formObj.attr("action", "${pageContext.request.contextPath}/repboard/repboardlist");
			formObj.submit();
			return false;
		});

		$(".board a").click(function() {
			formObj.attr("method", "get");
			formObj.attr("action", "${pageContext.request.contextPath}/repboard/repboarddetail");
			formObj.find("input[name=no]").val($(this).attr("href"));
			formObj.submit();
			return false;
		});
	});
</script>
</head>
<body>
	<header>
		<jsp:include page="../header.jsp"></jsp:include>
	</header>

	<form role="form">
		<input type="hidden" name="no" value="${no}">
		<input type="hidden" name="page" value="${cri.page == null ? '1' : cri.page}">
		<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
		<input type="hidden" name="searchType" value="${cri.searchType}">
		<input type="hidden" name="keyword" value="${cri.keyword}">
	</form>

	<section>
		<article>

			<table class="board">
				<c:forEach var="originalBoard" items="${boardList}">
					<c:if test="${originalBoard.no == no}">
						<thead>
							<tr>
								<th class="no" style="display: none;">${originalBoard.no}</th>
								<td class="title" colspan="2">${originalBoard.subject}</td>
							</tr>
						</thead>
						<tbody>
							<tr class="tr_line">
								<td>
									<fmt:formatDate value="${originalBoard.registerDate}" type="date" pattern="yyyy-MM-dd HH:mm:ss" />
								</td>
								<td>${originalBoard.viewCount}</td>
							</tr>
							<tr class="tr_line">
								<td colspan="2">${originalBoard.content}</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type='submit' name='modify' value='수정' />
									<input type='submit' name='delete' value='삭제' />
									<input type="submit" name="back" value="돌아가기" />
								</td>
							</tr>
						</tbody>
					</c:if>
				</c:forEach>
			</table>

			<form id="replyboard">
				<table class="repboard">
					<tbody>
						<tr>
							<td>
								<input type="text" name="subject" placeholder="제목을 입력해주세요">
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" name="content" placeholder="내용을 입력해주세요">
							</td>
						</tr>
						<tr>
							<td>
								<input type="password" name="password" placeholder="비밀번호">
							</td>
						</tr>
						<tr>
							<td>
								<input type='button' name='reply' value='답글달기' />
							</td>
						</tr>

					</tbody>

				</table>

			</form>
			<table class="board">
				<tbody>
					<tr class="tr_line">
						<c:forEach var="pre" items="${preBoard}">
							<c:if test="${pre==null}">
								<td colspan="3"></td>
							</c:if>
							<c:if test="${pre!=null}">
								<td>이전글</td>
								<td>
									<a href="${pre.no}"><input type="text" value="${pre.subject}" readonly="readonly" /></a>
								</td>
								<td>
									<fmt:formatDate value="${pre.registerDate}" type="both" pattern="yyyy-MM-dd" var="registerDate" />
									<c:choose>
										<c:when test="${today == pre.registerDate}">
											<fmt:formatDate value="${pre.registerDate}" type="both" pattern="HH:mm" />
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${pre.registerDate}" type="both" pattern="yyyy-MM-dd" />
										</c:otherwise>
									</c:choose>
								</td>
							</c:if>
						</c:forEach>
					</tr>
					<c:forEach var="repBoard" items="${boardList}">
						<c:if test="${repBoard.level != 1}">
							<tr class="tr_line">
								<td></td>
								<td style="text-align: left;">
									<a href="${repBoard.no}"> <c:forEach begin="1" end="${repBoard.level-1}">&nbsp;&nbsp;</c:forEach> <c:if test="${repBoard.level != 1 }">
											<img src="<%=request.getContextPath()%>/resources/reply_icon.gif" style="width: 40px; height: 15px; display: inline;" />
										</c:if> <span <c:out value="${repBoard.no == no ? 'class = articleActive' : '' }"/>> ${repBoard.subject} </span></a>
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
						</c:if>
					</c:forEach>
					<tr>
						<td>다음글</td>
						<c:forEach var="next" items="${nextBoard}">
							<c:if test="${next==null}">
								<td colspan="3"></td>
							</c:if>
							<c:if test="${next!=null}">
								<td>
									<a href="${next.no}"><input type="text" value="${next.subject}" readonly="readonly" /></a>
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