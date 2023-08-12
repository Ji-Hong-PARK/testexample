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
    
	<div class="container position-relative">
		<h3 class="mt-5">주문 내역</h3>
		<div>
			<table border="1" class="table">
				<thead>
					<tr>
						<th>주문번호</th>
						<th>주문날짜</th>
						<th>배송지</th>
						<th>결제수단</th>
						<th>가격합계</th>
						<th>적립마일리지</th>
						<th>사용마일리지</th>
						<th>상태</th>
						<th>*</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${list.size() < 1}">
						<tr>
							<td colspan="7">등록 된 사용자가 없습니다</td>
						</tr>
					</c:if>
					<c:forEach var="item" items="${list}">
						<tr>
							<td>${item.orderId}</td>
							<td><fmt:formatDate value="${item.orderDate}" pattern="yyyy-MM-dd" /></td>
							<td>${item.destination}</td>
							<c:choose>
								<c:when test="${item.pay == 'card'}">
									<td>카드</td>
								</c:when>
								<c:otherwise>
									<td>계좌이체</td>
								</c:otherwise>
							</c:choose>
							<td>${item.sumPriceLast}</td>
							<td>${item.sumMileageLast}</td>
							<td>${item.useMileage}</td>
							<c:choose>
								<c:when test="${item.state == 0}"><td>접수중</td></c:when>
								<c:when test="${item.state == 1}"><td>접수완료</td></c:when>
								<c:when test="${item.state == 2}"><td>배송중</td></c:when>
								<c:when test="${item.state == 3}"><td>배송완료</td></c:when>
								<c:when test="${item.state == 4}"><td>주문취소</td></c:when>
								<c:when test="${item.state == 5}"><td>반품</td></c:when>
								<c:otherwise><td>기타</td></c:otherwise>
							</c:choose>
							<td><a class="btn btn-outline-dark btn-sm" href="/order/viewDetail?orderId=${item.orderId}">자세히</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div>
			<a href="/main" class="btn btn-secondary">처음으로</a>
		</div>
	</div>
	
	<!-- Footer-->
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>