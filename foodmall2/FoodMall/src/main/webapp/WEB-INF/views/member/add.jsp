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
		<div class="col">
			<h3>회원가입</h3>
			<form name="registerForm" method="POST">
				<div class="mt-3">
					<label class="col-md-3">아이디</label>
					<input type="text" name="memberId" onchange="changeId()" placeholder="아이디">
				</div>
				<div onclick="checkId()" class="mt-3 btn btn-secondary btn-sm">아이디 중복확인</div>
				<div class="mt-3">
					<label class="col-md-3">비밀번호</label>
					<input type="password" name="memberPassword" placeholder="비밀번호">
				</div>
				<div class="mt-3">
					<label class="col-md-3">비밀번호 확인</label>
					<input type="password" name="memberPasswordCheck" placeholder="비밀번호 확인">
				</div>
				<div class="mt-3">
					<label class="col-md-3">성함</label>
					<input type="text" name="memberName" placeholder="성함">
				</div>
				<div class="mt-3">
					<label class="col-md-3">이메일주소</label>
					<input type="text" name="memberMail" placeholder="이메일">
				</div>
				<div class="mt-3">
					<label class="col-md-3">전화번호</label>
					<input type="text" name="memberTel" placeholder="전화번호">
				</div>
				<div class="mt-3">
					<label class="col-md-3">주소</label>
					<input type="text" name="memberAddress" placeholder="주소">
				</div>
			</form>
			<div class="mt-3">
				<button onclick="signup()" class="btn btn-primary btn-sm">회원가입</button>
				<button onclick="goBack()" class="btn btn-danger btn-sm">취소</button>
			</div>
		</div>
	</div>


	<!-- Footer-->
    <jsp:include page="../include/footer.jsp"></jsp:include>
	
<script>
	let check_id = false;
	
	function checkId(){		
		const form = document.registerForm;	
		
		if(form.memberId.value == ''){
			alert('아이디를 입력 해 주세요');
			form.memberId.focus();
			return;
		}
		
		const xhr = new XMLHttpRequest();
		
		xhr.open("GET", "checkId?memberId=" + form.memberId.value, true);
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == XMLHttpRequest.DONE){
				if(xhr.status == 200){	//정상적인 처리가 되었을 때
					if(xhr.responseText == "OK"){
						check_id = true;
						alert("사용가능한 id 입니다");
					}else{
						alert("이미 등록 된 id 입니다");
					}
				}
			}
		};
		
		xhr.send();
	}

	function signup(){
		const form = document.registerForm;
		
		if(form.memberId.value == ''){
			alert('아이디를 입력 해 주세요');
			form.memberId.focus();
			return;
		}

		if(!check_id){
			alert('아이디 중복확인을 해 주세요');
			return;
		}

		if(form.memberPassword.value == ''){
			alert('비밀번호를 입력 해 주세요');
			form.memberPassword.focus();
			return;
		}
		if(form.memberPasswordCheck.value == ''){
			alert('비밀번호 확인을 입력 해 주세요');
			form.memberPasswordCheck.focus();
			return;
		}
		
		if(form.memberPassword.value !== form.memberPasswordCheck.value){
			alert('비밀번호와 비밀번호 확인이 일치하지 않습니다');
			form.memberPasswordCheck.focus();
			return;
		}
		
		if(form.memberName.value == ''){
			alert('성함을 입력 해 주세요');
			form.memberName.focus();
			return;
		}
		if(form.memberMail.value == ''){
			alert('메일주소를 입력 해 주세요');
			form.memberMail.focus();
			return;
		}
		if(form.memberTel.value == ''){
			alert('전화번호를 입력 해 주세요');
			form.memberTel.focus();
			return;
		}
		if(form.memberAddress.value == ''){
			alert('주소를 입력 해 주세요');
			form.memberAddress.focus();
			return;
		}
		
		form.submit();
	}
	
	function changeId(){
		check_id = false;
	}
	function goBack() {
		location.href = "/main";
	}
</script>	
</body>
</html>