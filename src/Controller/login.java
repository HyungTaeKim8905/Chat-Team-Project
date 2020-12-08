package Controller;

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

import DTO.UserDTO;

/**
 * Servlet implementation class login
 */
@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");		// 서블릿에 응답할 데이터의 타입을 html 문서 타입으로 설정하는 부분이다.
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("utf-8");
		String id       = request.getParameter("id");
		String password = request.getParameter("password");
		String checkbox = request.getParameter("rememberid");
		// 체크가되어있으면 checkbox = true check가 안되있으면 false가 아닌 null이 된다.
		Cookie cookie = new Cookie("id", id);	//쿠키 객체를 생성하고 id란 쿠키 이름에 id값을 저장함.
		if(checkbox != null)	{ 				// 체크박스에 체크가  되어있다면(아이디 저장)
			cookie.setMaxAge(60*60*24);				//쿠키의 유효시간을 24시간으로 설정한다.
			response.addCookie(cookie);				//클라이언트로 쿠키값을 전송한다.
		}
		else	{	// 체크박스가 해제 되었으면
			cookie.setMaxAge(0);		// 쿠키 유효시간 0으로 해서 브라우저에서 삭제하게 한다.
			response.addCookie(cookie);
		}
		UserDTO  dto = new UserDTO();
		int result = dto.LoginCheck(id, password);
		RequestDispatcher dispatcher = null;
		if(result == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("id", id);
			session.setMaxInactiveInterval(60*60);
			//dispatcher = request.getRequestDispatcher("Main.jsp");
			out.println("<script>");
			out.println("alert('" + id + "님 환영합니다.')");
			out.println("location.href='Main.jsp'");
			out.println("</script>");
			//dispatcher.forward(request, response);
		}
		else if(result == 0)	{
			out.println("<script>");
			out.println("alert('비밀번호가 다릅니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		else if(result == -1)	{
			out.println("<script>");
			out.println("alert('존재하지 않는 아이디입니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		else if(result == -2) {
			out.println("<script>");
			out.println("로그인을 처리하는데 오류가 났습니다.')");		//DB ERROR
			out.println("history.back()");
			out.println("</script>");
		}
	}

}