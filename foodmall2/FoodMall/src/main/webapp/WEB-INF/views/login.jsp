<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
</style>
<title>FoodMall 로그인</title>
</head>
<body>
	<div>
		<h3>FoodMall 로그인</h3>
		<div>
			<form method="post">
				<div>
					<label>아이디</label>
					<input type="text" name="memberId"placeholder="ID를 입력하세요">
				</div>
				<div>
					<label>비밀번호</label>
					<input type="password" name="memberPassword" placeholder="비밀번호를 입력하세요">
				</div>
				<div>
					<button type="submit">로그인</button>
				</div>
			</form>
		</div>
		<div>
			<div>
				<a href="../member/add">회원가입</a>
			</div>
			<div>
				<a href="find/passwd">비밀번호 찾기</a>
			</div>
		</div>
	</div>
</body>
</html>