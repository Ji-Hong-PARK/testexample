        	//order move
        	function moveOrder(page){
        		state.page = page;
        		
        		$.ajax({
        			url: "/admin/order",
        			method: "post",
        			contentType: "application/json",
        			data: JSON.stringify(state),
        			dataType: "json",
        			success: function(data){        				
        				$("tbody").remove();
        				
        				const tbody = $("<tbody>");
        				
        				for(let i=0; i<data.order.length; i++){
        					const tr = $("<tr>");
        					
        					let state = "";
        					switch(data.order[i].state){
        					case 0:
        						state = "접수중"; break;
        					case 1:
        						state = "접수완료"; break;
        					case 2:
        						state = "배송중"; break;
        					case 3:
        						state = "배송완료"; break;
        					case 4:
        						state = "주문취소"; break;
        					case 5:
        						state = "반품"; break;
        					case 6:
        						state = "기타"; break;
        					}
        					
        					tr.append($("<td>").addClass("orderId").text(data.order[i].orderId));
        					tr.append($("<td>").addClass("memberId").text(data.order[i].memberId));
        					tr.append($("<td>").addClass("orderDate").text(data.order[i].orderDate));
        					tr.append($("<td>").addClass("orderState").attr("data-orderState",data.order[i].state).text(state));
        					tr.append($("<td>").append($("<button>").text("관리").addClass("btn-sm btn-warning mx-1 orderUpdate").attr("data-bs-target","#orderModal").attr("data-bs-toggle", "modal") ));
        					
        					tbody.append(tr);
        				}
        				
        				$("table").append(tbody);
        				
        				//페이저
        				$("tfoot").remove();
        				
        				const tfoot = $("<tfoot>");
        				const td = $("<td>").attr("colspan", "9");
        				
        				const div = $("<div>").addClass("pagination pagination-sm justify-content-center")
        				div.append($("<div>").addClass("page-item").append( $("<a>").addClass("page-link").attr("data-page", "1").text("처음") ));
        				div.append($("<div>").addClass("page-item").append( $("<a>").addClass("page-link").attr("data-page", data.pager.prev).text("이전") ));
        				
        				for(let i=0; i<data.pager.list.length; i++){
        					if(state.page == data.pager.list[i]){
        						div.append($("<div>").addClass("page-item active").append( $("<a>").addClass("page-link").attr("data-page", data.pager.list[i]).text(data.pager.list[i]) ));	
        					}else{
        						div.append($("<div>").addClass("page-item").append( $("<a>").addClass("page-link").attr("data-page", data.pager.list[i]).text(data.pager.list[i]) ));
        					}
        				}
        				
        				div.append($("<div>").addClass("page-item").append( $("<a>").addClass("page-link").attr("data-page", data.pager.next).text("다음") ));
        				div.append($("<div>").addClass("page-item").append( $("<a>").addClass("page-link").attr("data-page", data.pager.last).text("마지막") ));
        				
        				td.append(div);
        				
        				tfoot.append($("<tr>").append(td) );
        				
        				$("table").append(tfoot);
        			}
        		})
        	}



$(function(){
	        		// order //
        		
        		$("#admin").on("click", "button.orderUpdate", function(){
        			const orderId = $(this).parent().siblings(".orderId").text();
        			const memberId = $(this).parent().siblings(".memberId").text();
        			const orderDate = $(this).parent().siblings(".orderDate").text();
        			const orderState = $(this).parent().siblings(".orderState").data("orderstate");
        			
        			$("input[name='orderId']").val(orderId);
        			$("input[name='memberId']").val(memberId);
        			$("input[name='orderDate']").val(orderDate);
        			$("select[name='orderState']").val(orderState);
        			
        			// Modal에서 orderDetailList 보여주기 (주문한 상품 리스트)
        			$.ajax({
        				url: "/admin/order/Detail",
        				method: "POST",
        				contentType: "application/json",
        				data: orderId,
        				dataType: "json",
        				success: function(data){        					
        					
        					$("#orderDetail tbody").remove();
        					$("#orderDetail tfoot").remove();
        					
        					const tbody = $("<tbody>");
        					
        					for(let i=0; i<data.length; i++){
        						const tr = $("<tr>");
        						
        						tr.append($("<td>").text(data[i].productId));
        						tr.append($("<td>").text(data[i].productName));
        						tr.append($("<td>").text(data[i].count));
        						
        						tbody.append(tr);
        					}
        					
        					$("#orderDetail").append(tbody);
        					
        				}
        			})
        			

        		});



    			// orderModal submit
    			$("#order-submit").on("click", function(){    				
    				const item = {
    						orderId : $("input[name='orderId']").val(),
    						state : $("select[name='orderState']").val()
    				}
    				
    				$.ajax({
    					url: "/admin/order/update",
    					method: "PUT",
    					contentType: "application/json",
    					data: JSON.stringify(item),
    					dataType: "text",
    					success: function(data){
    						$("#orderModal").modal("hide");
    						moveOrder(state.page);
    					}
    				})
    				
    			})




        		// order 메뉴 클릭
        		$("#order").on("click", function(){
        			resetState();
        			state.menu = "order";
        			
        			$("#admin #adminContent").remove();
        			
        			const adminContent = $("<div>").attr("id", "adminContent");
        			
        			$("#admin").append(adminContent);
        			
        			//테이블 헤드
        			const table = $("<table>").addClass("table").attr("style", "width:100%");
        			adminContent.append(table);
        			
        			const thead = $("<thead>");
        			const tr = $("<tr>");
        			tr.append($("<th>").text("주문번호"));
        			tr.append($("<th>").text("회원ID"));
        			tr.append($("<th>").text("주문일"));
        			tr.append($("<th>").text("상태"));
        			tr.append($("<th>").text("관리"));
        			
        			table.append(thead);
        			thead.append(tr);
        			
        			moveOrder(1);
        		})


	
	
	
})