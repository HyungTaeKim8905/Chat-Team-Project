package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import DTO.UserDTO;
import VO.UserVO;

/**
 * Servlet implementation class FindFriend
 */
@WebServlet("/FindFriend")
public class FindFriend extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FindFriend() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String id = request.getParameter("ID");

		if (id == null || id.equals("")) {
			System.out.println("id가 공백으로 넘어왔습니다.");
			out.println("0");
		}
		UserDTO dto = new UserDTO();
		ArrayList<UserVO> list = dto.FriendCheck(id);
		JSONArray jsonArrList = new JSONArray();
		try {
			for (int i = 0; i < list.size(); i++) {
				JSONObject jsonList = new JSONObject();
				jsonList.put("Num", list.get(i).getId());
				jsonArrList.add(jsonList);
			}
			System.out.println(jsonArrList);
			out.println(jsonArrList);
		} catch (Exception e) {
			System.out.println("doPost() 오류");
			System.out.println("ERROR : " + e.getMessage());
		}
	}

}
