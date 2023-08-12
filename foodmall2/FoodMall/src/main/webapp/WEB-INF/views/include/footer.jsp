 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
        <footer class="py-5 bg-dark mt-5">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; JINUFOOD 2021</p></div>
        </footer>
        
        <!-- login modal -->
		<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="loginModalLabel">회원 로그인</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		          <div class="mb-3">
		            <label for="recipient-name" class="col-form-label">아이디</label>
		            <input id="memberId" type="text" class="form-control" id="recipient-name" placeholder="ID">
		          </div>
		          <div class="mb-3">
		            <label for="message-text" class="col-form-label">비밀번호</label>
		            <input id="password" type="password" class="form-control" placeholder="password">
		          </div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		        <button id="login" type="button" class="btn btn-primary">로그인</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		

        
        <script>
        	const categoryArray = [];
        
        	$(function(){
        		//네비 - 카테고리 메뉴
        		$.ajax({
        			url: "/ajax/category",
        			method: "post",
        			dataType: "json",
        			success: function(data){
        				for(let i=0; i<data.length; i++){
        					categoryArray[i] = data[i];
        					
        					if(data[i].categoryState != 'N'){
        						const href = "/category/" + data[i].categoryId;
        						const name = data[i].categoryName;
        						
                				const a = $("<a>").addClass("dropdown-item").attr("href", href).text(name);
                				
                				$("#category-dropdown").append($("<li>").append(a));
        					}
        				}
        			}
        		})
        		
        		$("#login").on("click", function(){
        			const item = {
        				memberId: $("#memberId").val(),
        				memberPassword: $("#password").val()
        			}
        			
        			$.ajax({
        				method: "POST",
        				url: "/ajax/login",
        				data: JSON.stringify(item),
        				contentType: "application/json",
        				dataType: "text",
        				success: function(data){
        					console.log(data);
        					if(data == "success"){
        						location.reload(true);
        					}else if(data == "admin"){
        						location.href = "/admin";
        					}else{
        						alert("아이디 혹은 비밀번호가 일치하지 않습니다.");
        						$("#password").val("");
        						$("#password").focus();
        					}
        				}
        			});
        		});
        	});
        	// 로그아웃
        	$(function(){
        		$("#logout").on("click", function(){
        			const logoutConfirm = confirm("로그아웃 하시겠습니까?");
        			
        			if(logoutConfirm){
        				$.ajax({
            				method: "POST",
            				url: "/logout",
            				success: function(){
            					location.href = "/main"; 
            				}
            			});
					}
        		})
        	})
        </script>