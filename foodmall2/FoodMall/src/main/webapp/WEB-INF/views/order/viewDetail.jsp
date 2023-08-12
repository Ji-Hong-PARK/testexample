<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		<h3>주문번호 : ${order.orderId}</h3>
		<h3>주문날짜 : <fmt:formatDate value="${order.orderDate}" pattern="yyyy년 MM월 dd일"/></h3>
		<h3>주문상태 : 
			<c:choose>
				<c:when test="${order.state == 0}"><td>접수중</td></c:when>
				<c:when test="${order.state == 1}"><td>접수완료</td></c:when>
				<c:when test="${order.state == 2}"><td>배송중</td></c:when>
				<c:when test="${order.state == 3}"><td>배송완료</td></c:when>
				<c:when test="${order.state == 4}"><td>주문취소</td></c:when>
				<c:when test="${order.state == 5}"><td>반품</td></c:when>
				<c:otherwise><td>기타</td></c:otherwise>
			</c:choose>
		</h3>
		<table border="1" class="table">
			<thead>
				<tr>
					<th>카테고리</th>
					<th>상품사진</th>
					<th>상품명</th>
					<th>주문수량</th>
					<th>가격합계</th>
					<th>마일리지합계</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${list}">
					<tr>
						<td>${item.categoryId}</td>
						<td><img src="/upload/files/${item.image}" style="height:100px; weight:100px;"></td>
						<td>${item.productName}</td>
						<td>${item.count}</td>
						<td>${item.sumPrice}</td>
						<td>${item.sumMileage}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<h4>사용한 마일리지: ${order.useMileage}</h4>
		<h4>가격 총 합계: ${order.sumPriceLast} 원</h4>
		<h4>적립(예정) 마일리지 총 합계: ${order.sumMileageLast}</h4>
		<div>
			<a href="/order/list" class="btn btn-outline-dark">주문목록</a>
			<a href="/main" class="btn btn-outline-primary">홈으로</a>
		</div>
	</div>
	
	<!-- Footer-->
    <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>