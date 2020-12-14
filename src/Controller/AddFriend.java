package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;

import DTO.UserDTO;
import VO.UserVO;

/**
 * Servlet implementation class AddFriend
 */
@WebServlet("/AddFriend")
public class AddFriend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddFriend() {
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
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String AddID = request.getParameter("AddID");
		HttpSession session = request.getSession();
		String sessionID = (String)session.getAttribute("id");
		UserDTO dto = new UserDTO();
		ArrayList<UserVO> list = dto.AddFriend(AddID, sessionID);
		if(list == null) {
			System.out.println("친구 목록을 가져오는데 null 입니다.");
			return;
		}
		JSONArray jsonArrList = new JSONArray();
		
		try	{
			
		} catch(Exception e) {
			System.out.println("AddFriend() 오류 발생");
			System.out.println("ERROR : " + e.getMessage());
		}
	}

}
