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

import DB.DBManager;
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
		response.setContentType("text/html;charset=utf-8");		// ������ ������ �������� Ÿ���� html ���� Ÿ������ �����ϴ� �κ��̴�.
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String id       = request.getParameter("id");
		String password = request.getParameter("password");
		String nick 	= request.getParameter("nick");
		String email 	= request.getParameter("email");
		String address 	= request.getParameter("address");
		String phone 	= request.getParameter("phone");
		String picture 	= request.getParameter("picture");
		String statusmessage 	= request.getParameter("statusmessage");
		UserDTO dto = new UserDTO();
		try {
			int result = dto.Join(id, password, nick, email, address, phone, picture, statusmessage);
			if(result != 0) 	{	//�����̿�Ʈ, ����ó
				HttpSession session = request.getSession();
				session.setAttribute("nick", nick);
				
				//out.println("<script>");
				//out.println("alert('" + nick + "�� ȸ�������� ���ϵ帳�ϴ�.')");
				//out.println("location.href='#.jsp'");
				//out.println("</script>");
				RequestDispatcher dispatcher = request.getRequestDispatcher("joinok.jsp");
				dispatcher.forward(request, response);
			}
			else	{
				out.println("<script>");
				out.println("alert('ȸ�������� �����Ͽ����ϴ�.')");
				out.println("location.href='#.jsp'");
				out.println("</script>");
			}
		} catch(Exception e) {
			System.out.println("ERROR:" + e.getMessage());
		}
	}

}
