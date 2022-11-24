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

import entity.Member;
import entity.RespMsg;
import service.MemberService;
import service.impl.MemberServiceImpl;


@WebServlet("/error")
public class ErrorServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		request.setAttribute("loginMessage", request.getSession().getAttribute("loginMessage"));
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/error.jsp");
		rd.forward(request, response);
	}
}
