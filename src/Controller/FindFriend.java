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
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String id = request.getParameter("ID");

		if (id == null || id.equals("")) {
			System.out.println("id가 공백으로 넘어왔습니다.");
			out.println("0");
			return;
		}
		UserDTO dto = new UserDTO();
		ArrayList<UserVO> list = dto.FriendCheck(id);
		if(list.size() == 0)	{
			return;
		}
		JSONArray jsonArrList = new JSONArray();
		try {
			for (int i = 0; i < list.size(); i++) {
				JSONObject jsonList = new JSONObject();
				jsonList.put("ID", list.get(i).getId());
				jsonList.put("pictureRealName", list.get(i).getPictureRealName());
				jsonList.put("statusmessage", list.get(i).getStatusmessage());
				jsonArrList.add(jsonList);
			}
			System.out.println("검색 결과를 제이슨 데이터로 뿌려주기");
			System.out.println(jsonArrList);
			out.println(jsonArrList);
		} catch (Exception e) {
			System.out.println("doPost() 오류");
			System.out.println("ERROR : " + e.getMessage());
		}
	}

}
