package Action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class mainAction
 */
@WebServlet("/mainAction")
public class mainAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public mainAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String num = (String)request.getAttribute("num");
		if(num == null) {
			num = "";
		}
		String check = request.getHeader("cookie");
		Cookie cookies[] = null;
		if(check != null)	{
			cookies =request.getCookies();
		}
		HttpSession session = request.getSession();
		if(session.getAttribute("id") != null)	{
			return;
		}
		if(!(num.equals("1")))	{	//로그아웃을 하지 않았다면 
			for(int i = 0; i < cookies.length; i++) {
				if(cookies[i].getName().equals("autologincheckbox")) {
					session.setAttribute("id", cookies[i].getValue());
				}
			}
		}
		response.sendRedirect("Main.jsp");
	}
}
