package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.google.gson.Gson;

import entity.Member;
import entity.RespMsg;
import service.MemberService;
import service.impl.MemberServiceImpl;


@WebServlet("/uploadFile")
@MultipartConfig(
		  fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
		  maxFileSize = 1024 * 1024 * 10,      // 10 MB
		  maxRequestSize = 1024 * 1024 * 100   // 100 MB
		)
public class UploadFileServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		RespMsg resp = new RespMsg();
		Gson gson = new Gson();
		try {
			Part filePart = request.getPart("uploadFile");
			ServletContext sctx = getServletContext();
			//System.out.println(sctx.getRealPath("/DrinksImage/"));
		    String fileName = filePart.getSubmittedFileName();
		    for (Part part : request.getParts()) {
		      part.write("C:/java/tdcchr/VendingMachine/src/main/webapp/DrinksImage/" + fileName);
		    }
			resp.setResult(true);
			resp.setMessage("上傳成功");
		} catch(Exception e) {
			resp.setResult(false);
			resp.setMessage(e.getMessage());
		}
		resp.setResult(false);
		resp.setMessage("測試");
	    PrintWriter out = response.getWriter();
        out.print(gson.toJson(resp));          
        out.close();
	    //response.getWriter().print("The file uploaded sucessfully.");
	}
}
