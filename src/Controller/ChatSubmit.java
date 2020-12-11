package Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import DTO.ChatRoomDTO;

/**
 * Servlet implementation class ChatSubmit
 */
@WebServlet("/ChatSubmit")
public class ChatSubmit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChatSubmit() {
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
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		String fromID = request.getParameter("fromID");
		String toID = request.getParameter("toID");
		String content = request.getParameter("content");	//ajax로 넘어온 파라미터값들을 받아옴
		System.out.println("::::::::::::::."+fromID);
		System.out.println("::::::::::::::."+toID);
		System.out.println("::::::::::::::."+content);
		PrintWriter out = response.getWriter();
		if(fromID == null || fromID.equals("") || toID == null || toID.equals("") || content == null || content.equals("")) {
			out.write("1111111111:::::::::::::");
		}
		else {
			//fromID = URLDecoder.decode(fromID, "UTF-8");
			//toID = URLDecoder.decode(toID, "UTF-8");
			//content = URLDecoder.decode(content, "UTF-8");
			System.out.println(":::::::::::::11111" + fromID);
			System.out.println(":::::::::::::11111" + toID);
			System.out.println(":::::::::::::11111" + content);
			ChatRoomDTO dto = new ChatRoomDTO();
			int result = dto.Submit(fromID, toID, content);
			// JSON 형식
			JSONArray jsonArrList = new JSONArray();
			JSONObject jsonList = new JSONObject();
			jsonList.put("result", result);
			jsonArrList.add(jsonList);
			out.println(jsonArrList);
		}
	}

}
