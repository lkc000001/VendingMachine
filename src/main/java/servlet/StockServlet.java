package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import entity.Page;
import entity.Product;
import entity.Purchase;
import entity.RespMsg;
import service.ProductService;
import service.impl.ProductServiceImpl;
import util.PageUtil;


@WebServlet("/stock")
public class StockServlet extends HttpServlet {
	
	private ProductService productService = new ProductServiceImpl();
	
	private PageUtil pageUtil = new PageUtil();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		Long id = request.getParameter("id") == null || request.getParameter("id").equals("") ? null : Long.parseLong(request.getParameter("id"));
		String name = request.getParameter("name");
		String classify = request.getParameter("classify");
		String enabled = "1";
		String state = request.getParameter("state");
		int pageIndex = request.getParameter("pageIndex") == null ? 1 : Integer.parseInt(request.getParameter("pageIndex"));
		int pageSize = request.getParameter("pageSize") == null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
		int totalPage = 0;
		
		if(state != null) {
			Product product = new Product(id, name, enabled, classify);
			
			List<Product> products = productService.queryProduct(product, new Page(pageIndex, pageSize));
			//取得總頁面
			int totalCount = productService.count(false);
			totalPage = (totalCount / pageSize) + 1;
			totalPage = totalCount % pageSize == 0 ? totalPage - 1 : totalPage;
			
			request.setAttribute("showPage", pageUtil.showPage(totalPage, pageIndex));
			request.setAttribute("products", products);
			
		}
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("selectSize", pageSize);
		request.setAttribute("selectFunction", "\"selectStock\"");
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/stock.jsp");
		rd.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		RespMsg resp = new RespMsg();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss.SSSZ").create();
		
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream(), "UTF-8"));
			String data = br.readLine();
			Purchase purchase = null;
			if(data != null) {
				purchase = gson.fromJson(data, Purchase.class);
				
				int addPurchase = productService.addPurchase(purchase);
				Product product = new Product(purchase.getProductId(), purchase.getProductCost(), purchase.getQuantity());
				int addresp = productService.addStock(product);
				
				if(addresp == 1) {
					resp.setResult(true);
					resp.setMessage("新增成功");
				} else {
					resp.setResult(false);
					resp.setMessage("新增失敗");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.setResult(false);
			resp.setMessage(e.getMessage());
		}
		
		PrintWriter out = response.getWriter();
        out.print(gson.toJson(resp));          
        out.close();
	}
}
