package Action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class logoutAction
 */
@WebServlet("/logoutAction")
public class logoutAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public logoutAction() {
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
		String check = request.getHeader("cookie");
		HttpSession session = request.getSession();
		Cookie cookies[] = null;
		String cookie = "";
		if(check != null) {
			cookies = request.getCookies();
		}
		if((cookies != null) && (cookies.length > 0))	{
			for(int i = 0; i < cookies.length; i++) {
				if(cookies[i].getName().equals("autologincheckbox"))	{
					cookies[i].setMaxAge(0);
					response.addCookie(cookies[i]);
				}
			}
		}
		session.invalidate();
		out.println("<script>");
		out.println("alert('로그아웃 되었습니다.')");
		out.println("</script>");
		int num = 1;
		RequestDispatcher dispatcher = request.getRequestDispatcher("mainAction");
		request.setAttribute("num", num);
		dispatcher.forward(request, response);
	}

}
