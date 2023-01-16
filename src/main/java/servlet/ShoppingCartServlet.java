package servlet;

import java.io.IOException;
import java.io.PrintWriter;
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
import entity.RespMsg;
import entity.ShoppingCart;
import entity.Wallet;
import repositories.ShoppingCartRepositories;
import service.MemberService;
import service.ProductService;
import service.ShoppingCartService;
import service.WalletService;
import service.impl.MemberServiceImpl;
import service.impl.ProductServiceImpl;
import service.impl.ShoppingCartServiceImpl;
import service.impl.WalletServiceImpl;


@WebServlet("/shoppingCart")
public class ShoppingCartServlet extends HttpServlet {
	
	private MemberService memberService = MemberServiceImpl.getInstance();
	
	private WalletService walletService = new WalletServiceImpl();
	
	private ShoppingCartService shoppingCartService = new ShoppingCartServiceImpl();
	
	private ProductService productService = new ProductServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		Member member = (Member) request.getSession().getAttribute("member");
		List<ShoppingCart> shoppingCarts = (List<ShoppingCart>) request.getSession().getAttribute("shoppingCarts");
		Long totalSum = 0L;
		if(shoppingCarts != null) {
			totalSum = shoppingCarts.stream().mapToInt(ShoppingCart :: getTotal).summaryStatistics().getSum();
		}
		int totalAmount = walletService.getAmount(member.getId());
		request.setAttribute("member", memberService.getMemberById(member.getId()));
		request.setAttribute("shoppingCarts", shoppingCarts);
		request.setAttribute("totalAmount", totalAmount);
		request.setAttribute("totalSum", totalSum);
		String totalErrorMsg = "'null'";
		if(totalAmount < totalSum) {
			totalErrorMsg = "'錢包餘額不足，請先儲值'";
		}

		request.setAttribute("totalError", totalErrorMsg);
		request.setAttribute("selectFunction", "\"selectShoppingCart\"");
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/shoppingCart.jsp");
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
			Member member = (Member) request.getSession().getAttribute("member");
			List<ShoppingCart> shoppingCarts = (List<ShoppingCart>) request.getSession().getAttribute("shoppingCarts");
			if(shoppingCarts != null) {
				//新增訂單資料
				shoppingCartService.addShoppingCarts(shoppingCarts, member.getId());
				//扣除錢包金額
				Long totalSum = shoppingCarts.stream().mapToInt(ShoppingCart :: getTotal).summaryStatistics().getSum();
				Wallet wallet = new Wallet(member.getId(), (~(totalSum.intValue() - 1)));
				walletService.addWallet(wallet);
				//扣除庫存
				shoppingCarts.forEach(sc -> productService.updateStock(sc));
				
				//刪除購物車資料
				request.getSession().removeAttribute("shoppingCarts");
				
				resp.setResult(true);
				resp.setMessage("結帳完成");
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
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		RespMsg resp = new RespMsg();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss.SSSZ").create();
		
		String deleteId = request.getParameter("deleteid");
		if(deleteId != null) {
			List<ShoppingCart> shoppingCarts = (List<ShoppingCart>) request.getSession().getAttribute("shoppingCarts");
			shoppingCarts.remove(Integer.parseInt(deleteId));
			request.getSession().setAttribute("shoppingCarts", shoppingCarts);
		}
		
		resp.setResult(true);
		resp.setMessage("修改成功");
		
		PrintWriter out = response.getWriter();
        out.print(gson.toJson(resp));          
        out.close();
	}
}
