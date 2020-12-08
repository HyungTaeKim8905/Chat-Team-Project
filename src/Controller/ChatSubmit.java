package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String fromID = request.getParameter("fromID");
		String toID = request.getParameter("toID");
		String content = request.getParameter("inputmessage");
		
		if(fromID == null || fromID.equals("") || toID == null || toID.equals("") || content == null || content.equals("")) {
			PrintWriter out = response.getWriter();
			out.write("0");
		}
		else {
			fromID = URLDecoder.decode(fromID, "UTF-8");
			toID = URLDecoder.decode(toID, "UTF-8");
			content = URLDecoder.decode(content, "UTF-8");
			response.getWriter().write(new ChatRoomDTO().submit(fromID, toID, content) + "");
		}
	}

}
