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
		String content = request.getParameter("content");
		PrintWriter out = response.getWriter();
		if(fromID == null || fromID.equals("") || toID == null || toID.equals("") || content == null || content.equals("")) {
			out.write("1111111111:::::::::::::");
		}
		else {
			ChatRoomDTO dto = new ChatRoomDTO();
			int result = dto.Submit(fromID, toID, content);
			JSONArray jsonArrList = new JSONArray();
			JSONObject jsonList = new JSONObject();
			jsonList.put("result", result);
			jsonArrList.add(jsonList);
			out.println(jsonArrList);
		}
	}

}
