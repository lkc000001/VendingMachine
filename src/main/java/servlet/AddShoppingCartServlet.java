package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import entity.Member;
import entity.Product;
import entity.RespMsg;
import entity.ShoppingCart;
import service.MemberService;
import service.ProductService;
import service.WalletService;
import service.impl.MemberServiceImpl;
import service.impl.ProductServiceImpl;
import service.impl.WalletServiceImpl;


@WebServlet("/addShoppingCart")
public class AddShoppingCartServlet extends HttpServlet {
	
	private ProductService productService = new ProductServiceImpl();
	
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
			ShoppingCart shoppingCart = new ShoppingCart();
			List<ShoppingCart> shoppingCarts = new ArrayList<ShoppingCart>();
			if(data != null) {
				shoppingCart = gson.fromJson(data, ShoppingCart.class);
				shoppingCarts = (List<ShoppingCart>) request.getSession().getAttribute("shoppingCarts");
				if(shoppingCarts == null) {
					shoppingCarts = new ArrayList<ShoppingCart>();
				}
				
				Product product = productService.getProductById(shoppingCart.getProductId());
				shoppingCart.setProductName(product.getName());
				shoppingCart.setProductPrice(product.getPrice());
				shoppingCart.setProductImage(product.getImage());
				shoppingCart.setProductCost(product.getCost());
				shoppingCart.setProductStock(product.getStock());
				shoppingCart.setTotal(product.getPrice() * shoppingCart.getBuyQuantity());
				shoppingCarts.add(shoppingCart);
				
				request.getSession().setAttribute("shoppingCarts", shoppingCarts);
				resp.setResult(true);
				resp.setMessage("已加入購物車");
				resp.setData(shoppingCarts.size());
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

	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		RespMsg resp = new RespMsg();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss.SSSZ").create();
		
		Integer updateIndex = Integer.parseInt(request.getParameter("updateIndex"));
		Integer buyQty = Integer.parseInt(request.getParameter("buyQty"));

		List<ShoppingCart> shoppingCarts = (List<ShoppingCart>) request.getSession().getAttribute("shoppingCarts");
		ShoppingCart updateshoppingCart = shoppingCarts.get(updateIndex);
		updateshoppingCart.setBuyQuantity(buyQty);
		updateshoppingCart.setTotal(updateshoppingCart.getProductPrice() * updateshoppingCart.getBuyQuantity());
		shoppingCarts.set(updateIndex, updateshoppingCart);
		
		request.getSession().setAttribute("shoppingCarts", shoppingCarts);
		resp.setResult(true);
		resp.setMessage("修改完成");
		
		PrintWriter out = response.getWriter();
        out.print(gson.toJson(resp));          
        out.close();
	}
	
	
}
