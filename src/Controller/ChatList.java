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

import DTO.ChatRoomDTO;
import VO.ChatRoomVO;

@WebServlet("/ChatList")
public class ChatList extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String fromID = request.getParameter("fromID");
		String toID = request.getParameter("toID");
		String lastNo = request.getParameter("lastNo"); //0
		if(fromID == null || fromID.equals("") || toID == null || toID.equals("") || lastNo == null || lastNo.equals("")) {
			System.out.println("doPost()");
			System.out.println("공백출력입니다.");
			out.println("");
			return;
		}
		else {
			if (lastNo != null && lastNo != "" && lastNo != "0") {
				try {
					JSONArray jsonArrList = new JSONArray();
					ChatRoomDTO dto = new ChatRoomDTO();
					ArrayList<ChatRoomVO> list = dto.ChttingListID(Integer.parseInt(lastNo), fromID, toID);
					for (int i = 0; i < list.size(); i++) {
						JSONObject jsonList = new JSONObject();
						jsonList.put("no", list.get(i).getNo());
						jsonList.put("fromID", list.get(i).getFromID());
						jsonList.put("toID", list.get(i).getToID());
						jsonList.put("content", list.get(i).getContent());
						jsonList.put("date", list.get(i).getDate());
						jsonArrList.add(jsonList);
					}
					out.println(jsonArrList);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	public JSONArray Current(String fromID, String toID) {
		JSONArray jsonArrList = new JSONArray();
		ChatRoomDTO dto = new ChatRoomDTO();
		ArrayList<ChatRoomVO> list = dto.ChttingListQuick(fromID, toID, 100); //최근 100개까지 읽어옴
		if(list.size() == 0) {
			System.out.println("");
			return null;
		}
		for(int i = 0; i < list.size(); i++) {
			JSONObject jsonList = new JSONObject();
			jsonList.put("no", list.get(i).getNo());
			jsonList.put("fromID", list.get(i).getFromID());
			jsonList.put("toID", list.get(i).getToID());
			jsonList.put("content", list.get(i).getContent());
			jsonList.put("date", list.get(i).getDate());
			jsonArrList.add(jsonList);
		}
		return jsonArrList;
	}
}
