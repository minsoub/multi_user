package kr.co.neodreams.multi_user.base.dto;

public class BasePagingDto {

	private int pageNo;			// 페이지
	private int perPageCnt;		// 1페이지당 노출 갯수
	private int pageRange;			// 노출 페이징수
	private int totalCnt;			// 게시물 총 갯수
	
	private int pageStartNo;		// 페이징시 시작 
	private int pageEndNo;			// 페이징시 종료
	
	private String sort;			// 정렬조건
	private int menuID;
	
	public BasePagingDto () {
		this.pageNo = 1;
		this.perPageCnt = 10;
		this.pageRange = 10;
		this.sort = "";
	}	
	
	
	// getter, setter
	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPerPageCnt() {
		return perPageCnt;
	}

	public void setPerPageCnt(int perPageCnt) {
		this.perPageCnt = perPageCnt;
	}

	public int getPageRange() {
		return pageRange;
	}

	public void setPageRange(int pageRange) {
		this.pageRange = pageRange;
	}

	public int getPageStartNo() {
		this.pageStartNo = (this.pageNo - 1) * this.perPageCnt;
		
		return this.pageStartNo;
	}

	public void setPageStartNo(int pageStartNo) {
		this.pageStartNo = pageStartNo;
	}

	public int getPageEndNo() {
		this.pageEndNo = this.pageNo * this.perPageCnt;
		return this.pageEndNo;
	}

	public void setPageEndNo(int pageEndNo) {
		this.pageEndNo = pageEndNo;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}

	public int getMenuID() {
		return menuID;
	}

	public void setMenuID(int menuID) {
		this.menuID = menuID;
	}
	
	
	
}
