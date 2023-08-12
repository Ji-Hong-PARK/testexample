<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script>
	$(function(){
		$("textarea").summernote();
	});
</script>
</head>
<body>
	<div>
		<form method="post" enctype="multipart/form-data">
			<div>
				<label>카테고리번호: </label>
				<input type="number" name="categoryId">
			</div>
			<div>
				<label>상품명: </label>
				<input type="text" name="productName">
			</div>
			<div>
				<label>상품이미지: </label>
				<input type="file" name="uploadFile">
			</div>
			<div>
				<label>가격: </label>
				<input type="number" name="price">
			</div>
			<div>
				<label>마일리지: </label>
				<input type="number" name="mileage">
			</div>
			<div>
				<label>재고: </label>
				<input type="number" name="inventory">
			</div>
			<div>
				<label>상품정보: </label>
				<textarea name="productInfo" rows="60" cols="30"></textarea>
			</div>
			<div>
				<button>등록</button>
			</div>
		</form>
	</div>
</body>
</html>