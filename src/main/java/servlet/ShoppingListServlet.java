package servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static java.util.stream.Collectors.groupingBy;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entity.Member;
import entity.ShoppingCart;
import service.MemberService;
import service.ShoppingCartService;
import service.WalletService;
import service.impl.MemberServiceImpl;
import service.impl.ShoppingCartServiceImpl;
import service.impl.WalletServiceImpl;


@WebServlet("/shoppingList")
public class ShoppingListServlet extends HttpServlet {
	
	private MemberService memberService = MemberServiceImpl.getInstance();
	
	private WalletService walletService = new WalletServiceImpl();
	
	private ShoppingCartService shoppingCartService = new ShoppingCartServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		Member member = (Member) request.getSession().getAttribute("member");
		List<ShoppingCart> shoppingCarts = shoppingCartService.queryShoppingList(member.getId());
		Long totalSum = 0L;
		Map<String, List<ShoppingCart>> groupByOrderId = new HashMap<>();
		if(shoppingCarts != null) {
			groupByOrderId = shoppingCarts.stream()
					.collect(groupingBy(ShoppingCart::getOrderId, LinkedHashMap::new, Collectors.toList()));
		}
		int totalAmount = walletService.getAmount(member.getId());

		request.setAttribute("member", memberService.getMemberById(member.getId()));
		request.setAttribute("shoppingCarts", shoppingCarts);
		request.setAttribute("groupByOrderId", groupByOrderId);
		request.setAttribute("totalAmount", totalAmount);
		request.setAttribute("selectFunction", "\"selectShoppingList\"");
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/shoppingList.jsp");
		rd.forward(request, response);
	}
}
