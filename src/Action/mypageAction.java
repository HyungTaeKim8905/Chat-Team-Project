package Action;

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
import VO.UserVO;

/**
 * Servlet implementation class mypageAction
 */
@WebServlet("/mypageAction")
public class mypageAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public mypageAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String sessionID = (String)session.getAttribute("id");
		if(sessionID == null)	{
			System.out.println("세션값이 null 이다. ::" + sessionID);
			return;
		}
		UserDTO dto = new UserDTO();
		UserVO vo = dto.MyPagePrint(sessionID);
		RequestDispatcher dispatcher = request.getRequestDispatcher("mypage.jsp");
		request.setAttribute("vo", vo);
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */

}
