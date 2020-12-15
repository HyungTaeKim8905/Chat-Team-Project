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
@WebServlet("/PrintFriend")
public class PrintFriend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PrintFriend() {
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
		HttpSession session = request.getSession();
		String sessionID = (String)session.getAttribute("id");
		UserDTO dto = new UserDTO();
		ArrayList<UserVO> list = dto.PrintFriend(sessionID);
		if(list == null) {
			System.out.println("친구 목록을 가져오는데 null 입니다.");
			return;
		}
		for(int i = 0; i < list.size(); i++)	{
			System.out.println("어레이 잘 들어왔나 확인");
			System.out.println(list.get(i).getNick());
			System.out.println(list.get(i).getStatusmessage());
			System.out.println(list.get(i).getPictureRealName());
		}
		//제이슨으로 뿌려준다.
		JSONArray jsonArrList = new JSONArray();
		try	{
			for(int i = 0; i < list.size(); i++)	{
				JSONObject jsonList = new JSONObject();
				jsonList.put("ID", list.get(i).getNick());
				jsonList.put("pictureRealName", list.get(i).getPictureRealName());
				jsonList.put("statusmessage", list.get(i).getStatusmessage());
				jsonArrList.add(jsonList);
			}	
		} catch(Exception e) {
			System.out.println("AddFriend 서블릿 doPost() 오류");
			System.out.println("ERROR : " + e.getMessage());
		}
		out.println(jsonArrList);
	}

}
