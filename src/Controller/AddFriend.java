package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

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
		int result = dto.AddFriend(AddID, sessionID);
		JSONArray jsonArrList = new JSONArray();
		try	{
			JSONObject jsonList = new JSONObject();
			jsonList.put("result", result);
			jsonArrList.add(jsonList);
		} catch(Exception e)	{
			System.out.println("AddFriend 서블릿 doPost() 오류");
			System.out.println("ERROR :"  + e.getMessage());
		}
		out.println(jsonArrList);
	}

}
