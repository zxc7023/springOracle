<%@ page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="<%=request.getContextPath()%>/resources/product.css" type="text/css" rel="stylesheet" />

<c:set var="item" value="${param.searchItem}" />
<c:if test="${item == null}">
   ${item=no}
</c:if>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {
		$("option[value='${item}']").attr("selected", "true");
		$("input[name=searchValue]").val('${param.searchValue}');

/* 		$("input[type=submit]").click(function() {
  			$.ajax({
				url : "productlist",
				method : "get",
				data : $("form").serialize(),
				success : function(responseData) {
					//console.log(responseData);
					var $parentObj = $("article");
					if ($parentObj.length == 0) { //article영역의 유무에 따라 출력
						$parentObj = $("body");
					}
					//$parentObj.remove(); //객체 자체를 지워버리기
					$parentObj.empty(); //객체는 있지만 기존내용 clear하고
					$parentObj.html(responseData.trim()); //검색결과 출력
				}
			});
			return false;
		}); */
	});
</script>


<div class="product-search-wrap">
	<form style="border-collapse: collapse; border: 1px solid; padding: 10px;">
		<select name="searchItem">
			<option value="no" selected>번호로검색</option>
			<option value="name">이름으로검색</option>
		</select> <input type="search" name="searchValue"> <input type="submit" value="검색">
	</form>
</div>
