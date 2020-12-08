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
		response.setContentType("text/html;charset=utf-8");		// ������ ������ �������� Ÿ���� html ���� Ÿ������ �����ϴ� �κ��̴�.
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("utf-8");
		String id       = request.getParameter("id");
		String password = request.getParameter("password");
		UserDTO  dto = new UserDTO();
		int result = dto.LoginCheck(id, password);
		RequestDispatcher dispatcher = null;
		if(result == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("id", id);
			
			//dispatcher = request.getRequestDispatcher("Main.jsp");
			out.println("<script>");
			out.println("alert('" + id + "�� ȯ���մϴ�.')");
			out.println("location.href='Main.jsp'");
			out.println("</script>");
			//dispatcher.forward(request, response);
		}
		else if(result == 0)	{
			out.println("<script>");
			out.println("alert('��й�ȣ�� �ٸ��ϴ�.')");
			out.println("history.back()");
			out.println("</script>");
		}
		else if(result == -1)	{
			out.println("<script>");
			out.println("alert('�������� �ʴ� ���̵��Դϴ�.')");
			out.println("history.back()");
			out.println("</script>");
		}
		else if(result == -2) {
			out.println("<script>");
			out.println("�α����� ó���ϴµ� ������ �����ϴ�.')");		//DB ERROR
			out.println("history.back()");
			out.println("</script>");
		}
	}

}
