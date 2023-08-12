<!DOCTYPE html>
<html lang="en">
	
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>메인페이지</title>
		<div>
			<h1>환영합니다 FOODMALL 입니다</h1>
			<c:if test="${sessionScope.member != null }">
				<p>${sessionScope.member.memberId} 님 환영합니다</p>
				<a href="logout">로그아웃</a>
			</c:if>
			<a href="login">로그인</a>
			<a href="member/add">회원가입</a>
			<a href="member/update?memberId=${sessionScope.member.memberId}">회원정보수정</a>
			<a href="basket/">장바구니</a>
			<a href="member/">회원리스트</a>
			<a href="category/list">카테고리 리스트</a>
			<a href="product/">상품 리스트</a>
			<p>아직 오픈 안했습니다</p>
	

</head>
<body>
	
</body>
</html>



