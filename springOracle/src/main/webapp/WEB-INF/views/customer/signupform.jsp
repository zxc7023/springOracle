<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입 페이지</title>

<link href="<%=request.getContextPath()%>/resources/login_form.css" type="text/css"
	rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
   //dom트리가 구성될때까지 기다림
   $(function() {
	   
      var $idTag = $("input[name=id]");
      var $idchk = $("#idchk");
      $idTag.focus(function(){
         $("input[name=join]").hide();
         $idchk.css("color","red");
         $idchk.text('아이디 중복확인을 해주세요');
      });
      var $pwd = $("input[name=pwd]");
      var $pwd1 = $("input[name=pwd1]");
      $pwd1.add($pwd).bind('input', function(){
           if($pwd.val() != $pwd1.val()){
              $(".pwd_check").css("color","red");
              $(".pwd_check").text("불일치");
           }else{
              $(".pwd_check").css("color","#d8d8d8");
              $(".pwd_check").text("일치");
           }
       });
      
      $button=$("button");
      $button.click(function(){
         var $join = $("input[name=join]");
         $form.attr("action", "${pageContext.request.contextPath}/customer/dupchkid"); //-->jquery함수
         var $action = $form.attr("action"); 
         $.ajax({
            url : $action,
            method : 'POST',
            data : {'id': $("input[name=id]").val()},
            success : function(responseData) {
               // console.log(responseData);
               var result = responseData.trim();
               if (result == '1') {
                  $idchk.text('아이디가 이미 사용중입니다');                 
               } else {
                  //alert("아이디를 사용하셔도 됩니다.");
                  $idchk.css("color","#d8d8d8");
                  $idchk.text('아이디를 사용하셔도 됩니다..');
 
                  $join.show();
               }
               
            },
            error : function(xhr, status, error) {
               console.log("ERROR:" + status + "," + error);
            }
         });
         return false;
      });
   
      
      
      //jquery문법으로 비밀번호 input객체와 비밀번호확인 input객체찾기
      //from객체 찾기
      $form = $(".signupform");
      //서브밋 되어질때
      //$("input[type=submit]").click(function(){
      //$("[submit]").click(function(e){
      $form.submit(function() {
         var $id = $("input[name=id]").val();
         var $name = $("input[name=name]").val();
         var $pwd = $("input[name=pwd]").val();
         var $pwd1 = $("input[name=pwd1]").val();
         if ($pwd != $pwd1) {
            alert('비밀번호가 틀립니다.');
            return false; //기본이벤트 막기
         }
         //form객체의 action속성을 signup.do값으로 설정한다.
         $form.attr("action", "${pageContext.request.contextPath}/customer/signupform"); //-->jquery함수
         var $action = $form.attr("action"); //signup.do
         var $data = $form.serialize();
         
         
         $.ajax({
            url : $action,
            method : 'POST',
            data : $data,
            success : function(responseData) {
               // console.log(responseData);
               var result = responseData.trim();
               if (result == '1') {
                  alert('가입성공');
					location.href = '${pageContext.request.contextPath}';
               } else {
                  alert("가입실패");
               }
            },
            error : function(xhr, status, error) {
               console.log("ERROR:" + status + "," + error);
            }
         });
         return false;

      });

   });
</script>
</head>
<body>
    <div class="signupWrapper">
        <form class ="signupform" method="post">
            <!-- action="signup.do ">-->
            <input type="text" name="id" placeholder="아이디" required />
            <button name="dupcheck">중복확인</button>
            <label id="idchk">아이디 중복확인을 해주세요</label>
            <input type="password" placeholder="비밀번호" name="pwd" required/>
            <input type="password" placeholder="비밀번호확인" name="pwd1" required/>
            <label class="pwd_check"></label>
            <input type="text" placeholder="이름" name="name" required/>
            <input type="submit" value="가입하기" name="join" />
        </form>
    </div>
</body>
</html>