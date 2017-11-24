<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.my.vo.Product"%>
<%@ page import="com.my.dao.ProductDAOOracle"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
  .tb_product{width:500px; border:1px solid; border-collapse: collapse; margin:auto;}
  .tb_product th{border:1px solid; text-align: center;}
  .tb_product td{border:1px solid; text-align: center;}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> 
<script>
$(function(){
	var $parentObj = $("article");
	if($parentObj.length==0){
		$parentObj=$("body");
	}
	$parentObj.on("click","#btCart",function(){//지금존재하는 객체의 하위 객체의 아이디가 btCart인것의 click 이벤트처리
		var no = $("table td#no").html();
		var name = $("#name").html();
		var price = $("#price").html();
		var quantity = $("input[name=quantity]").val();
  		$.ajax({
			url: 'addcart.do',
			method: 'post',
			data : {'no': no ,'name': name,'price': price,'quantity' :quantity},
			success:function(responseData){
				alert("장바구니에 넣었습니다.");
				$parentObj.empty();
				//location.href='productlist.do';
			}
		}); 
		console.log(no+":"+name+":"+price+":"+quantity+" 가 장바구니에 담았습니다.");
		$parentObj.off();
		return false;
	});
	$("table td>a").click(function(){

		$.ajax({url:'productdetail.do',
						method: 'post',
						data: 'no='+$(this).html().trim(),
						success: function(responseData){
/* 						$("article").empty(); //객체는 남기고 내용을 지우기
							$("article").html(responseData.trim()); */

							$parentObj.empty();
						/*
							var result = responseData.trim();
							if(result =='-1'){
								alert('해당상품을 찾지 못했습니다.');
							}
							else{
								var jsonObj = JSON.parse(result); */
    					var jsonObj = responseData;
    					console.log(jsonObj);
    					if(jsonObj.prod_no=='-1'){
    						alert('해당상품을 찾지 못했습니다');
    					}else{
								console.log(jsonObj.no+","+jsonObj.name+","+jsonObj.price);
								data = '<style>';
								data += '#t1{';
								data += 'width: 80%; margin: auto; border-collapse:collapse; border: 1px solid;';
								data += '}';
 								data += '#hh1{';
								data += 'width: 80%; margin : auto; background-color: #2B7AFF; color: white;';
								data += '}'; 
								data += '</style>';
								data += '<h1 id ="hh1">상품상세정보</h1>';
								data += '<table id ="t1">';
								data += '<tr>';
								data += '<td>상품번호</td>';
								data += '<td id="no">'+ jsonObj.prod_no + '</td>';
								data += '</tr>';
								
								data += '<tr>';
								data += '<td>이름</td>';
								data += '<td id ="name">'+ jsonObj.prod_name + '</td>';
								data += '</tr>';
								
								data += '<tr>';
								data += '<td>상품가격</td>';
								data += '<td id ="price">'+ jsonObj.prod_price + '</td>';
								data += '</tr>';
								
								data += '<tr>';
								data += '<td>수량</td>';
								data += '<td>';
								data += '<input type=number style="width:100px" min="1" value="1" name="quantity">'
								data += '</td>'
								data += '</tr>'
								
								data += '<tr>';
								data += '<td colspan="2">';
								data += '<input type="button" value="장바구니담기" id="btCart">'
								data += '</td>';
								data += '</tr>';
								
								$parentObj.html(data);
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
<jsp:include page="search.jsp"></jsp:include>

<c:set var="list" value="${requestScope.list}"/>

<br>
<table class="tb_product">
  <tr>
    <th>번호</th><th>이름</th><th>가격</th>
  </tr>
  <c:forEach var="p" items="${list}">

      <tr>
      <td> <%-- <a href="productdetail.do?no=<%=list2.getProd_no()%>"> --%>
      <a href="#">${p.prod_no}</a></td>
      <td> ${p.prod_name}</td>
      <td> ${p.prod_price}</td>
      </tr>
   </c:forEach>
</table>
</body>
</html>