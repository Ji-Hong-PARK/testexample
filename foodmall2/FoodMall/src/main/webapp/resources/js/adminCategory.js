$(function(){
	
	// 카테고리 추가 모달
	$("#admin").on("click", "#addCategory", function(){
		$("#category-update-submit").hide();
		$("#category-add-submit").show();
		
		$("input[name='categoryId']").val("카테고리번호는 자동으로 생성 됩니다.");
		$("input[name='categoryName']").val("");
		$("input[id='categorySY']").removeAttr("checked");
		$("input[id='categorySN']").removeAttr("checked");
		
		$("#category-add-submit").click(function(){
			if($("input[name='categoryName']").val() == ""){
				alert("카테고리이름을 입력해주세요!");
				return false;
			}
			if(!$("input[id='categorySY']").is(":checked") && !$("input[id='categorySN']").is(":checked")){
				alert("활성화 여부를 선택해주세요!");
				return false;
			}
			const item = {
					categoryName: $("input[name='categoryName']").val(),
					categoryState: $("input[name='categoryState']:checked").val()
			}
			
			$.ajax({
				method: "post",
				url: "/admin/categoryAdd",
				contentType: "application/json",
				data: JSON.stringify(item),
				dataType: "json",
				success: function(data){
					console.log(data);
					
					const tr = $("<tr>");
					tr.attr("data-categorystate", data.categoryState).attr("data-categoryid", data.categoryId).attr("data-categoryname", data.categoryName);
					tr.append($("<td>").text(data.categoryState).addClass("categoryState") );
					tr.append($("<td>").text(data.categoryId).addClass("categoryId") );
					tr.append($("<td>").text(data.categoryName).addClass("categoryName") );
					
					const td = $("<td>");
					
					td.append( $("<button>").text("수정").addClass("categoryUpdate btn-sm btn-warning mx-1").attr("data-bs-target","#categoryModal").attr("data-bs-toggle", "modal") );
					tr.append(td);
					
					$("tbody").append(tr);
					
					$("#categoryModal").modal('hide');
				}
			})
		})
	})
        		

	// 카테고리 업데이트 모달
	$("#admin").on("click", "button.categoryUpdate", function(){        
		$("#category-update-submit").show();
		$("#category-add-submit").hide();
		
		const category = $(this).parent().parent().data();
		const tr = $(this).parent().parent();

		$("input[name='categoryId']").val(category.categoryid);
		$("input[name='categoryName']").val(category.categoryname);
		
		$("input[id='categorySY']").removeAttr("checked");
		$("input[id='categorySN']").removeAttr("checked");
		if(category.categorystate == 'Y'){
			$("input[id='categorySY']").attr("checked",true); 
		}else{
			$("input[id='categorySN']").attr("checked",true);       				
		}
		
		$("#category-update-submit").on("click", function(){
			if($("input[name='categoryName']").val() == ""){
				alert("카테고리이름을 입력해주세요!");
				return false;
			}
			if(!$("input[id='categorySY']").is(":checked") && !$("input[id='categorySN']").is(":checked")){
				alert("활성화 여부를 선택해주세요!");
				return false;
			}
			
			//const item = $("form[id='categoryForm']").serialize(); serialize를 하면 인코딩 문제로 한글이 깨진다.
			const item = {
				categoryId: $("input[name='categoryId']").val(),
				categoryName: $("input[name='categoryName']").val(),
				categoryState: $("input[name='categoryState']:checked").val()
			}
			
			$.ajax({
				method: "put",
				url: "/admin/categoryUpdate",
				contentType: "application/json",
				data: JSON.stringify(item),
				dataType: "json",
				success: function(data){
					$("#categoryModal").modal('hide');
					tr.children().siblings(".categoryState").text(data.categoryState);
					tr.children().siblings(".categoryName").text(data.categoryName);
					// 카테고리번호는 수정을 못하게 했기 때문에 생략
				}
			})
		});
		
	});
	
	
	// 메뉴 - 카테고리 선택 - 카테고리 리스트 및 수정,추가 버튼 띄우기
	$("#category").on("click", function(){
		
		$.ajax({
			url: "/admin/category",
			method: "POST",
			contentType: "application/json",
			dataType: "json",
			success: (function(data){        					
				$("#adminContent").remove();
				
				const adminContent = $("<div>").attr("id","adminContent");
				
				$("#admin").append(adminContent);
				
				const table = $("<table>").addClass("table").attr("style", "width:100%");
				adminContent.append(table);
				
				const thead = $("<thead>");
				const tr = $("<tr>");
				tr.append($("<th>").text("활성화여부"));
				tr.append($("<th>").text("카테고리번호"));
				tr.append($("<th>").text("카테고리명"));
				tr.append($("<th>").text("관리"));
				
				table.append(thead.append(tr));
				
				const tbody = $("<tbody>");

				for(let i=0; i<data.length; i++){
					const tr = $("<tr>");
					tr.attr("data-categorystate", data[i].categoryState).attr("data-categoryid", data[i].categoryId).attr("data-categoryname", data[i].categoryName);
					tr.append($("<td>").text(data[i].categoryState).addClass("categoryState") );
					tr.append($("<td>").text(data[i].categoryId).addClass("categoryId") );
					tr.append($("<td>").text(data[i].categoryName).addClass("categoryName") );
					
					const td = $("<td>");
					
					td.append( $("<button>").text("수정").addClass("categoryUpdate btn-sm btn-warning mx-1").attr("data-bs-target","#categoryModal").attr("data-bs-toggle", "modal") );
					tr.append(td);
					tbody.append(tr);
				}
				table.append(tbody);
				
				const addButton = $("<button>").text("추가").addClass("btn-sm btn-primary mx-1").attr("id","addCategory").attr("data-bs-target","#categoryModal").attr("data-bs-toggle", "modal");
				adminContent.append(addButton);
			})
		})
	});
	
})