<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- head -->
	<jsp:include page="../include/head.jsp"></jsp:include>
</head>
<body>
	<!-- Navigation-->
    <jsp:include page="../include/navigation.jsp"></jsp:include>
    <!-- Header-->
    <jsp:include page="../include/header.jsp"></jsp:include>

	<div class="container px-4 px-lg-5 mt-5">
		<h2>주문이 접수되었습니다!</h2>
		<h4>주문번호 : <a href="/order/viewDetail?orderId=${orderId}">${orderId}</a> </h4>
		<h4><a href="/order/viewDetail?orderId=${orderId}">주문내역 확인하기</a></h4>
		<h4>배송은 평균 1~3일이 소요 됩니다.</h4>
		<a href="/main" class="btn btn-outline-primary">홈으로</a>
	</div>
	
	<!-- Footer-->
    <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>