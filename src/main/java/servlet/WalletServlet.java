package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

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
import entity.Wallet;
import service.WalletService;
import service.impl.WalletServiceImpl;


@WebServlet("/wallet")
public class WalletServlet extends HttpServlet {
	
	private WalletService walletService = new WalletServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		Member member = (Member) request.getSession().getAttribute("member");
		
		request.setAttribute("wallets", walletService.queryAmountList(member.getId()));
		request.setAttribute("totalAmount", walletService.getAmount(member.getId()));
		request.setAttribute("member", member);
		request.setAttribute("selectFunction", "\"selectWallet\"");
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/wallet.jsp");
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
			Wallet wallet = new Wallet();
			if(data != null) {
				wallet = gson.fromJson(data, Wallet.class);
				walletService.addWallet(wallet);
				resp.setResult(true);
				resp.setMessage("儲值成功");
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
