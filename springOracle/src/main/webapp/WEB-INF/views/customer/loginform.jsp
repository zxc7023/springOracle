<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login Page</title>
<link href="<%=request.getContextPath()%>/resources/login_form.css" type="text/css"
	rel="stylesheet" />
	

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	$(function() {
		var $form = $("form"); //배열타입으로 반환

		//localStorage에 저장된 아이디가 있나 확인 후 설정
		var itemValue = localStorage.getItem("saveId");
		if (itemValue != null) {
			$("input[name=id]").val(itemValue)
		}

		$form.submit(function() {
			if ($("input[name=c").prop("checked") == true) {
				localStorage.setItem("saveId", $("input[name=id]").val());
			} else {
				localStorage.removeItem("saveId");
			}
			$.ajax({
				url : '${pageContext.request.contextPath}/customer/login',
				method : 'POST',
				data : $form.serialize(),
				success : function(responseData) {
					var data = responseData.trim();
					if (data == '1') {
						alert("로그인 성공");
						//location.href='${requestScope.getContextPath}';
						location.href = '${pageContext.request.contextPath}';
					} else if (data == '-1') {
						alert("로그인 실패");
					} else {
						alert(data);
					}
				}
			});
			//기본이벤트핸들러(submit핸들러 : methood="get" action="")가 처리됨
			return false;
		});
	});
</script>
</head>

<body>
<div class="login-wrap">
	<form>
		<input type="text" name="id" placeholder="아이디를 입력하세요" required />
		 <input type="password" name="pwd" required placeholder="비밀번호를 입력하세요" />
		 <input type="checkbox" name="c" value="save" ><span>아이디저장</span></input>
		 <input type="submit" value="로그인" class="logoin" />
	</form>
	</div>
</body>
</html>