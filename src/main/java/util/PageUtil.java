package util;

public class PageUtil {
	/**
	 * 產出分頁條
	 * @param totalPage
	 * @param pageIndex
	 * @return
	 */
	public String showPage(int totalPage, int pageIndex) {
		StringBuilder pageStr = new StringBuilder();
		int startPage = 1;
		int endPage = totalPage;
		boolean startPoint = false;
		boolean endPoint = false;
		
		if(totalPage > 5) {
			if(pageIndex % 5 == 0) {
				startPage = 1 + ((pageIndex / 5) - 1) * 5;
			} else {
				startPage = 1 + (pageIndex / 5) * 5;
			}
			startPoint =  startPage == 1 ? false : true;
			
			if((startPage + 5) > totalPage) {
				endPage = totalPage;
			} else {
				endPage = startPage + 4;
				endPoint = true;
			}
		} 
		
		pageStr.append("<div class=\"jsgrid-pager-container\" colspan=\"3\">");
		pageStr.append("<div class=\"jsgrid-pager\">頁數:");
		if(pageIndex != 1) {
    		pageStr.append("<span class=\"jsgrid-pager-nav-button jsgrid-pager-nav-inactive-button\">");
    		pageStr.append("<a href=\"javascript:void(0);\" onclick=\"doquery(1)\">第一頁</a></span>");
    		pageStr.append("<span class=\"jsgrid-pager-nav-button jsgrid-pager-nav-inactive-button\">");
    		pageStr.append("<a href=\"javascript:void(0);\" onclick=\"doquery(" + (pageIndex - 1) + ")\">上一頁</a></span>");
    	}
		if(startPoint) {
	    	pageStr.append("<span class=\"jsgrid-pager-nav-button\">");
	    	pageStr.append("<a href=\"javascript:void(0);\" onclick=\"doquery(" + (startPage - 5) + ")\">...</a></span> ");
	    }
	    for (var i = startPage; i <= endPage; i++) {
	    	if(pageIndex == i) {
	    		pageStr.append("<span class=\"jsgrid-pager-page jsgrid-pager-current-page\" href=\"javascript:void(0);\">" + i + "</span>");
	    	} else {
	    		pageStr.append("<span class=\"jsgrid-pager-page\"><a href=\"javascript:void(0);\" onclick=\"doquery(" + i + ")\">" + i + "</a></span>");
	    	}
	    }
	    if(endPoint) {
	    	pageStr.append("<span class=\"jsgrid-pager-nav-button\">");
	    	pageStr.append("<a href=\"javascript:void(0);\" onclick=\"doquery(" + (endPage + 1) + ")\">...</a></span> ");
	    }
	   
	    if(pageIndex != totalPage) {
    		pageStr.append("<span class=\"jsgrid-pager-nav-button\">");
    		pageStr.append("<a href=\"javascript:void(0);\" onclick=\"doquery(" + (pageIndex + 1) + ")\">下一頁</a></span>");
    		pageStr.append("<span class=\"jsgrid-pager-nav-button\">");
    		pageStr.append("<a href=\"javascript:void(0);\" onclick=\"doquery(" + totalPage + ")\">最後頁</a></span>");
    	}
	    pageStr.append("&nbsp;&nbsp;" + pageIndex + "/" + totalPage + "</div></div>");
		
		return pageStr.toString();
	}
}
