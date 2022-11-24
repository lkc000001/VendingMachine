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
import entity.ShoppingCart;
import service.ProductService;
import service.ShoppingCartService;
import service.impl.ProductServiceImpl;
import service.impl.ShoppingCartServiceImpl;
import util.PageUtil;
import util.ValidateUtil;


@WebServlet("/report")
public class ReportServlet extends HttpServlet {
	
	private ShoppingCartService shoppingCartService = new ShoppingCartServiceImpl();
	
	private PageUtil pageUtil = new PageUtil();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		Long productId = request.getParameter("productId") == null || request.getParameter("productId").equals("") ? null : Long.parseLong(request.getParameter("productId"));
		Long memberId = request.getParameter("memberId") == null || request.getParameter("memberId").equals("") ? null : Long.parseLong(request.getParameter("memberId"));
		String startDate = ValidateUtil.isBlank(request.getParameter("startDate")) || request.getParameter("startDate").equals("____/__/__") ? null : "'" + request.getParameter("startDate") + " 00:00:00.000'";
		String endDate = ValidateUtil.isBlank(request.getParameter("endDate")) || request.getParameter("endDate").equals("____/__/__") ? null : "'" + request.getParameter("endDate") + " 23:59:59.997'";
		String state = request.getParameter("state");
		int pageIndex = request.getParameter("pageIndex") == null ? 1 : Integer.parseInt(request.getParameter("pageIndex"));
		int pageSize = request.getParameter("pageSize") == null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
		int totalPage = 0;
		if(state != null) {
			ShoppingCart shoppingCart = new ShoppingCart(memberId, productId, startDate, endDate);
			
			List<ShoppingCart> shoppingCarts = shoppingCartService.queryShoppingCart(shoppingCart, new Page(pageIndex, pageSize));
			//取得總頁面
			int totalCount = shoppingCartService.count();
			totalPage = (totalCount / pageSize) + 1;
			totalPage = totalCount % pageSize == 0 ? totalPage - 1 : totalPage;

			request.setAttribute("showPage", pageUtil.showPage(totalPage, pageIndex));
			request.setAttribute("shoppingCarts", shoppingCarts);
		}
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("selectSize", pageSize);
		request.setAttribute("selectFunction", "\"selectReport\"");
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/report.jsp");
		rd.forward(request, response);
	}
}
