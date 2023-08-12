package kr.ac.kopo.foodmall.util;

import java.util.ArrayList;
import java.util.List;

public class Pager {
	private int page = 1;
	private int perPage = 12;
	private float total;
	private int perGroup = 5;
	
	private int search = 0;
	private int search2;
	private String keyword = "";
	private int sort = 0;
	
	private int min;
	private int max;
	private int id; // 상품번호 혹은 주문번호 등으로 쓰일 예정
	private String state; // 상품상태(매진,판매중지,판매중 등), 주문상태(주문접수중, 배송준비중 등)등으로 쓰일 예정
	
	private int categoryId = 0;
	
	public int getSearch() {
		return search;
	}
	public void setSearch(int search) {
		this.search = search;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}

	public List<Integer> getList(){
		ArrayList<Integer> list = new ArrayList<Integer>();
		
		int startPage = (page - 1) / perGroup * perGroup + 1;
				
		for(int index = startPage; index < (startPage + perGroup) && index <= getLast() ; index++)
			list.add(index);
		
		if(list.isEmpty())
			list.add(1);
		
		return list;
	}
	
	public int getLast() {
		return (int) Math.ceil(total / perPage);
	}
	
	public int getPrev() {
		return page <= perPage ? 1 : ((page - 1) / perGroup - 1) * perGroup + 1;
	}
	
	public int getNext() {
		int next = ((page - 1) / perGroup + 1) * perGroup + 1;
		int last = getLast();
		
		return next < last ? next : last;
	}
	
	public String getQuery() {
		// search(0=키워드없음, 1=키워드있음), keyword, categoryId(>0 Id있음/없음), maxPrice(>0 max,min잇음), minPrice 
		String path = "";
		
		if(search > 0) {
			path = path + "search=" + search + "&keyword=" + keyword;
			//return "search=" + search + "&keyword=" + keyword;
		}else {
			path = path + "search=" + search;
		}
		if(categoryId >= 0)
			path = path + "&categoryId=" + categoryId;
		if(max > 0) {
			path = path + "&min=" + min + "&max=" + max;
		}
		
		return path;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}

	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getMin() {
		return min;
	}
	public void setMin(int min) {
		this.min = min;
	}
	public int getMax() {
		return max;
	}
	public void setMax(int max) {
		this.max = max;
	}
	public int getSearch2() {
		return search2;
	}
	public void setSearch2(int search2) {
		this.search2 = search2;
	}


}