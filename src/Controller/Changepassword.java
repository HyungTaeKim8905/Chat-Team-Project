package Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import DTO.UserDTO;

/**
 * Servlet implementation class Changepassword
 */
@WebServlet("/Changepassword")
public class Changepassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Changepassword() {
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
		String newpassword = request.getParameter("newpassword");
		String newpasswordRe = request.getParameter("newpasswordRe");
		System.out.println("newpassword :::" + newpassword);
		System.out.println("newpasswordRe :::" + newpasswordRe);
		if(!(newpassword.equals(newpasswordRe)))	{
			return;
		}
		HttpSession session = request.getSession();
		String sessionID = (String)session.getAttribute("id");
		if(sessionID == null)	{
			return;
		}
		UserDTO dto = new UserDTO();
		int result = dto.ChangePassWord(sessionID, newpassword);
		JSONArray jsonArrList = new JSONArray();
		JSONObject jsonList = new JSONObject();
		jsonList.put("result", result);
		jsonArrList.add(jsonList);
		out.println(jsonArrList);
	}

}
