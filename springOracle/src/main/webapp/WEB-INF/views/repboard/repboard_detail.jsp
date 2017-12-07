<%@page import="com.my.vo.RepBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<style>
.board {
	width: 500px;
	margin: 10px auto;
	text-align: center;
	border-collapse: collapse;
	height: auto;
}

thead, .tr_line {
	border-bottom: 1px solid #c3c3c3
}

tr {
	height: 30px;
}

.num {
	width: 20%;
}

.title {
	width: 80%;
}

.content {
	height: 100px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<%
	List<RepBoard> list = (List) request.getAttribute("boardList");
%>
<script>

	$(window).bind("pageshow", function(event) {
		if (event.originalEvent.persisted) {
			document.location.reload();
		}
	});

	$(function() {
		var $parentObj = $("article");
		if ($parentObj.length == 0) {
			$parentObj = $("body");
		}
		$("input[type=submit]").click(function() {
			//var $boardno = $(this).parent().siblings(".tdData").text();
			var $boardno = $(this).parents("tbody").find("span").text()
			var $responseName = $(this).attr('name');
			console.log($boardno);
			alert($responseName);
			var url = 'isauthorization.do';
			if ($responseName == 'reply') {
				url = 'insert.jsp';
			}
			console.log($boardno);
			$.ajax({
				url : url,
				method : 'post',
				data : 'check=' + $responseName + '&boardno=' + $boardno,
				success : function(responseData) {
					//console.log(responseData);
					var $parentObj = $("article");
					if ($parentObj.length == 0) { //article영역의 유무에 따라 출력
						$parentObj = $("body");
					}
					//$parentObj.remove(); //객체 자체를 지워버리기
					$parentObj.empty(); //객체는 있지만 기존내용 clear하고
					$parentObj.html(responseData.trim()); //검색결과 출력
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
	<section>
		<article>
			<table style="border-collapse: collapse; border: 1px solid;" class="board">
				<%
					for (RepBoard rb : list) {
				%>
				<thead>
					<tr>
						<th class="num">번호</th>
						<th class="title" colspan=2>제목</th>
					</tr>
				</thead>
				<tbody>
					<tr class="tr_line">
						<td class="tdData">
							<span><%=rb.getNo()%></span>
						</td>
						<td colspan=2><%=rb.getSubject()%></td>
					</tr>

					<tr>
						<td colspan=3 class="content">
							<%=rb.getContent()%>
						</td>
					</tr>
					<tr>
						<td colspan=3>
							<input type='submit' name='reply' value='답글달기' />
							<input type='submit' name='modify' value='수정' />
							<%
								if (list.size() < 2) {
							%><input type='submit' name='delete' value='삭제' />
							<%
								}
							%>
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</article>
	</section>

</body>