<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
</head>
<body>
	<div>
		<h3>회원 목록</h3>
		<div>
			<table border="1">
				<thead>
					<tr>
						<th>아이디</th>
						<th>성명</th>
						<th>메일주소</th>
						<th>전화번호</th>
						<th>주소</th>
						<th>마일리지</th>
						<th>관리</th>
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
							<td>${item.memberId}</td>
							<td>${item.memberName}</td>
							<td>${item.memberMail}</td>
							<td>${item.memberTel}</td>
							<td>${item.memberAddress}</td>
							<td>${item.memberMileage}</td>
							<td><a href="delete?memberId=${item.memberId}">삭제</a> <a href="update?memberId=${item.memberId}">변경</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div>
			<a href="..">처음으로</a>
		</div>
	</div>
</body>
</html>