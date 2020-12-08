package Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DTO.UserDTO;

/**
 * Servlet implementation class register
 */
@WebServlet("/register")
public class register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public register() {
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
		String nick 	= request.getParameter("nick");
		String email 	= request.getParameter("email");
		String address 	= request.getParameter("address");
		String phone 	= request.getParameter("phone");
		String picture 	= request.getParameter("picture");
		String statusmessage 	= request.getParameter("statusmessage");
		System.out.println(nick);
		System.out.println(address);
		UserDTO dto = new UserDTO();
		try {
			int result = dto.Join(id, password, nick, email, address, phone, picture, statusmessage);
			if(result == 1) 	{	//리다이엑트, 디스패처
				HttpSession session = request.getSession();
				session.setAttribute("id", id);
				out.println("<script>");
				out.println("alert('" + nick + " 님 회원가입을 축하드립니다.')");
				out.println("location.href='Main.jsp'");
				out.println("</script>");
				
				//RequestDispatcher dispatcher = request.getRequestDispatcher("Main.jsp");
				//dispatcher.forward(request, response);
			}
			else if(result == 0)	{
				out.println("<script>");
				out.println("alert('회원가입을 실패하였습니다.')");
				out.println("history.back()");
				out.println("</script>");
			}
		} catch(Exception e) {
			System.out.println("ERROR:" + e.getMessage());
		}
	}

}
