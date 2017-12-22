<%@page import="com.my.vo.RepBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% List<RepBoard> list = (List)request.getAttribute("selectData");
   String contextPath = request.getContextPath();
   RepBoard rep = list.get(0);%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> 
<script>
 $(function(){
    var $parentObj = $("article");
    if($parentObj.length==0){
        $parentObj=$("body");
    }

    
    
    $("input[name=modify]").click(function(){
        var $no = <%= rep.getNo() %>;
        var $subject = $("input[name=subject]").val();
        var $content = $("#content").val();
        var $password = '<%= rep.getPassword() %>';
        
        console.log($no+$subject+$content+$password);
        $.ajax({url:'update.do',
                         method: 'post',
                         data: 'no='+$no+'&subject='+$subject
                         +'&content='+$content+'&password='+$password,
                         success: function(responseData){
                          var data = responseData.trim();
                          if(data == '1'){
                     				alert('게시글 수정이 완료 되었습니다.');
                      			location.href = '<%= contextPath %>';
                     			}else if(data == '-1'){
                      			alert('게시글 수정에 실패 하였습니다.');
                    			}else{
                      			alert(data);
                    			}
                         },
                         error: function(xhr, status, error){
                             console.log(xhr.status);
                             }
                         });
        return false; 
    });
 }); 
</script>
</head>

<body>
<table style="border:1px solid">
  <tr>
    <td style='width:30%'>번호 : <%= rep.getNo() %></td>
    <td style='width:70%'>제목 : <input style="width: 70%" type='text' name='subject' value='<%= rep.getSubject() %>'></td>
  </tr>
  <tr>
    <td colspan='2' width='500px' height='150px'>
    <textarea rows="5" cols="30" style="width:99%; height:100%" id="content"><%= rep.getContent() %></textarea>
  </tr>
  <tr>
    <td style='width:100px'><input type='submit' name='modify' value='수정'></td>
    <td style='width:100px'><input type='submit' name='modify' value='취소'></td>
      </tr>
</table>

</body>
</html>