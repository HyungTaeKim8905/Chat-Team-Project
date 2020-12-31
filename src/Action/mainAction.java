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
		//이 부분 고침요								//******************************************
		if(cookies == null) {					//로그아웃을 했다면 cookies가  null
			response.sendRedirect("Main.jsp");	//리다이엑트해줘도 doPost()함수가 실행되기 때문에 return 추가
			return;								//******************************************
		}
		if(!(num.equals("1")))	{	//로그아웃을 하지 않았다면 num = 1
			for(int i = 0; i < cookies.length; i++) {
				if(cookies[i].getName().equals("autologincheckbox")) {
					HttpSession session = request.getSession();
					session.setAttribute("id", cookies[i].getValue());
				}
			}
		}
		response.sendRedirect("Main.jsp");
	}
}
