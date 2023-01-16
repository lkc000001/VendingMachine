package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.http.HttpClient;

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
import service.MemberService;
import service.impl.MemberServiceImpl;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/login.jsp");
		rd.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		RespMsg resp = new RespMsg();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss.SSSZ").create();
		
		//取得輸入資料
		BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream(), "UTF-8"));
		String data = br.readLine();
		Member inputUser = null;
		if(data != null) {
			inputUser = gson.fromJson(data, Member.class);
		} else {
			resp.setResult(false);
			resp.setMessage("登入失敗<br>請確認帳號及密碼是否正確!!");
		}
		//取得會員資料
		MemberService memberService = MemberServiceImpl.getInstance();
		Member member = memberService.getMemberByAccount(inputUser.getAccount());
		//檢查是否註冊
		if(member.getAccount() != null) {
			//檢查是否啟用
			if(member.getEnabled().equals("1")) {
				//比對密碼
				if(inputUser.getPwd().equals(member.getPwd())) {
					member.setPwd("");
					request.getSession().setAttribute("member", member);
					resp.setResult(true);
					resp.setMessage("OK");
				} else {
					resp.setResult(false);
					resp.setMessage("登入失敗<br>請確認帳號及密碼是否正確!!");
				} 
			} else {
				resp.setResult(false);
				resp.setMessage("登入失敗<br>帳號未啟用，請洽管理人員!!");
			}
		} else {
			resp.setResult(false);
			resp.setMessage("登入失敗<br>請確認帳號及密碼是否正確!!");
		}
		
		//resp
		PrintWriter out = response.getWriter();
        out.print(gson.toJson(resp));          
        out.close();
	}
}
