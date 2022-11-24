package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.Member;
import service.MemberService;
import service.impl.MemberServiceImpl;

@WebFilter(filterName = "sessionFilter", 
		   urlPatterns = {"/", "/product", "/member", "/wallet", "/shoppingCart",
				   		  "/shoppingList", "/stock", "/report"})
public class sessionFilter implements Filter{
	
	private MemberService memberService = new MemberServiceImpl();
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}
	
	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		HttpSession session = request.getSession();
		String uri = request.getRequestURI();
		
		Member member = (Member) session.getAttribute("member");
		//檢查是否登入
		if(member == null) {
			session.setAttribute("loginMessage", "您尚未登入，或者閒置超過30分鐘。<BR>請按確認鍵或3秒後自動轉至登入頁面，重新登入!!");
			response.sendRedirect(request.getContextPath() + "/error");
		} else {
			String role = memberService.getMemberRole(member.getAccount());
			String roleFunc = "";
			String uriFunc = uri.split("/")[2];
			//設定角色權限
			switch (role) {
			case "1":
				roleFunc = "sell,shoppingCart,wallet,shoppingList";
				break;
			case "8":
			case "9":
				roleFunc = "sell,shoppingCart,wallet,shoppingList,member,product,stock,report";
				break;
			}
			//檢查角色權限
			if(!roleFunc.contains(uriFunc)) {
				session.setAttribute("loginMessage", "您尚未有此功能之權限。<BR>如需開通權限，請洽管理人員。<BR>請按確認鍵或3秒後自動轉至起始頁面。");
				session.setAttribute("isLogin", true);
				response.sendRedirect(request.getContextPath() + "/error");
			} else {
				filterChain.doFilter(request, response);
			}
		}
	}

	@Override
	public void destroy() {

	}	
}
