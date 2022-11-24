package servlet;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.Page;
import entity.Product;
import service.ProductService;
import service.impl.ProductServiceImpl;
import util.PageUtil;


@WebServlet("/sell")
public class SellServlet extends HttpServlet {
	
	private ProductService productService = new ProductServiceImpl();
	
	private PageUtil pageUtil = new PageUtil();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String name = request.getParameter("name");
		String classify = request.getParameter("classify");
		int pageIndex = request.getParameter("pageIndex") == null ? 1 : Integer.parseInt(request.getParameter("pageIndex"));
		int pageSize = request.getParameter("pageSize") == null ? 6 : Integer.parseInt(request.getParameter("pageSize"));
		Product product = new Product(null, name, "1", classify);
		int totalPage = 0;
		
		List<Product> products = productService.queryProduct(product, new Page(pageIndex, pageSize));
		//取得總頁面
		int totalCount = productService.count(true);
		totalPage = (totalCount / pageSize) + 1;
		totalPage = totalCount % pageSize == 0 ? totalPage - 1 : totalPage;
		
		//設定圖片完整路徑
		List<Product> pageProduct = products.stream()
				.peek(s -> s.setImage( request.getContextPath() + "/DrinksImage/" + s.getImage()))
				.collect(Collectors.toList());
		//最後項目不足3時,補空白項目,
		if(pageProduct.size() % 3 != 0) {
			int count = 3 - (pageProduct.size() % 3);
			for(int i=0; i < count; i++) {
				pageProduct.add(new Product());
			}
		}

		request.setAttribute("products", pageProduct);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("showPage", pageUtil.showPage(totalPage, pageIndex));
		request.setAttribute("selectFunction", "\"selectSell\"");
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/sell.jsp");
		rd.forward(request, response);
	}
}
