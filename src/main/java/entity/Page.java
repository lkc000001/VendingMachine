package entity;

public class Page {
	private Integer pageIndex;
	
	private Integer pageSize;

	public Page() {

	}

	public Page(Integer pageIndex, Integer pageSize) {
		this.pageIndex = pageIndex;
		this.pageSize = pageSize;
	}

	public Integer getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
}
