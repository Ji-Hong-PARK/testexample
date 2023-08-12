<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보 수정</title>
</head>
<body>
	<div>
		<div>
			<label>카테고리번호: </label>
			<div>${item.categoryId}</div>
		</div>
		<div>
			<label>상품번호: </label>
			<div>${item.productId}</div>
		</div>
		<div>
			<label>상품명: </label>
			<div>${item.productName}</div>
		</div>
		<div>
			<label>상품이미지: ${item.image}</label>
			<img src="/upload/files/${item.image}">
		</div>
		<div>
			<label>가격: </label>
			<div>${item.price}</div>
		</div>
		<div>
			<label>마일리지: </label>
			<div>${item.mileage}</div>
		</div>
		<div>
			<label>재고: </label>
			<div>${item.inventory}</div>
		</div>
		<div>
			<label>상품정보: </label>
			<div>${item.productInfo}</div>
		</div>
		<form action="../../order/confirm" method="post">
			<input type="hidden" name="items" value="${item.productId}">
			<button>주문하기</button>
		</form>
		<div>
			<a href="..">돌아가기</a>
		</div>
	</div>
</body>
</html>