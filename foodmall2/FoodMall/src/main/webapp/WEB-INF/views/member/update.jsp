<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FoodMall 회원정보수정</title>
<style>
</style>
<script>
</script>
</head>
<body>
	<div>
		<h3>회원정보수정</h3>
			<form name="registerForm" method="POST">
				<div>
					<label>아이디</label>
					<input type="text" value="${item.memberId}" readonly>
				</div>
				<div>
					<label>성함</label>
					<input type="text" name="memberName" value="${item.memberName}" readonly>
				</div>
				<div>
					<label>이메일주소</label>
					<input type="text" name="memberMail" value="${item.memberMail}">
				</div>
				<div>
					<label>전화번호</label>
					<input type="text" name="memberTel" value="${item.memberTel}">
				</div>
				<div>
					<label>주소</label>
					<input type="text" name="memberAddress" value="${item.memberAddress}">
				</div>
				<button>수정</button>
			</form>
	</div>
</body>
</html>