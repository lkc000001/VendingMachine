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

import entity.Member;
import entity.Page;
import entity.Product;
import entity.RespMsg;
import service.MemberService;
import service.impl.MemberServiceImpl;
import util.PageUtil;


@WebServlet("/member")
public class MemberServlet extends HttpServlet {
	
	private MemberService memberService = new MemberServiceImpl();
	
	private PageUtil pageUtil = new PageUtil();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		Long id = request.getParameter("id") == null || request.getParameter("id").equals("") ? null : Long.parseLong(request.getParameter("id"));
		String account = request.getParameter("account");
		String name = request.getParameter("name");
		String enabled = request.getParameter("enabled");
		String role = request.getParameter("role");
		String state = request.getParameter("state");
		int pageIndex = request.getParameter("pageIndex") == null ? 1 : Integer.parseInt(request.getParameter("pageIndex"));
		int pageSize = request.getParameter("pageSize") == null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
		int totalPage = 0;
		if(state != null) {
			Member member = new Member(id, account, name, enabled, role);
			List<Member> members = memberService.queryMember(member, new Page(pageIndex, pageSize));
			
			//取得總頁面
			int totalCount = memberService.count();
			totalPage = (totalCount / pageSize) + 1;
			totalPage = totalCount % pageSize == 0 ? totalPage - 1 : totalPage;
			
			request.setAttribute("showPage", pageUtil.showPage(totalPage, pageIndex));
			request.setAttribute("members", members);
		}
		
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("selectSize", pageSize);
		request.setAttribute("selectFunction", "\"selectMember\"");
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/member.jsp");
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
			Member member = null;
			if(data != null) {
				member = gson.fromJson(data, Member.class);
				Member dbMember = memberService.getMemberByAccount(member.getAccount());
				if(dbMember.getAccount() == null) {
					int addresp = memberService.addMember(member);
					if(addresp == 1) {
						resp.setResult(true);
						resp.setMessage("新增成功");
					} else {
						resp.setResult(false);
						resp.setMessage("新增失敗");
					}
				} else {
					resp.setResult(false);
					resp.setMessage("新增失敗，帳號已存在!!");
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

	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		RespMsg resp = new RespMsg();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss.SSSZ").create();
		
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream(), "UTF-8"));
			String data = br.readLine();
			Member member = null;
			if(data != null) {
				member = gson.fromJson(data, Member.class);
				Member dbMember = memberService.getMemberByAccount(member.getAccount());
				dbMember.setName(member.getName());
				dbMember.setEnabled(member.getEnabled());
				dbMember.setRole(member.getRole());
				
				int addresp = memberService.updateMember(dbMember);
				if(addresp == 1) {
					resp.setResult(true);
					resp.setMessage("修改成功");
				} else {
					resp.setResult(false);
					resp.setMessage("修改失敗");
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
	
	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		RespMsg resp = new RespMsg();
		Gson gson = new Gson();
		String deleteId = request.getParameter("deleteid");
		if(deleteId != null) {
			Long id = Long.parseLong(deleteId) ;
			int addresp = memberService.deleteMember(id);
			if(addresp == 1) {
				resp.setResult(true);
				resp.setMessage("刪除成功");
			} else {
				resp.setResult(false);
				resp.setMessage("刪除失敗");
			}
		} else {
			resp.setResult(false);
			resp.setMessage("刪除失敗");
		}
		PrintWriter out = response.getWriter();
        out.print(gson.toJson(resp));          
        out.close();
	}
}
