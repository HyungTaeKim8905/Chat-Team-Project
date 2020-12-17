package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import DTO.ChatRoomDTO;
import VO.UserVO;

/**
 * Servlet implementation class fileuploadtest
 */
@WebServlet("/fileuploadtest")
@MultipartConfig(fileSizeThreshold=0, location="D:\\KHT\\Chat-Team-Project\\WebContent\\file")
public class fileuploadtest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public fileuploadtest() {
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
		ArrayList<String> list = new ArrayList<String>();
		String uploadFileNameList = "";	//파일 이름을 받기 위해 선언
		for(Part part: request.getParts()){
			System.out.println(part.getName());	// file속성의 name값 찍어본다.
			if(part.getName().equals("fileuld")){
				//인자로 지정된 헤더의 정보를 String 형태로 반환한다.
				String contentDisposition = part.getHeader("content-disposition");
				System.out.println("contentDisposition = " + contentDisposition); //출력
				//업로드한 파일의 이름들을 반환한다.
				String uploadFileName = getUploadFileName(contentDisposition);
				list.add(uploadFileName);
				part.write(uploadFileName);	//Part객체의 파일을 인자로 지정된 파일 이름으로 디스크 상에 출력한다.
				
			}
		}
		ChatRoomDTO dto = new ChatRoomDTO();
		HttpSession session = request.getSession();
		String sessionID = (String)session.getAttribute("id");
		int result = dto.FileSubmit(sessionID, "123", list);
		
	}
	
	
	//사용브라우저가 Chrome인 경우
		private String getUploadFileName(String contentDisposition) {
				String uploadFileName = null;
				String[] contentSplitStr = contentDisposition.split(";");
				int firstQutosIndex = contentSplitStr[2].indexOf("\"");
				int lastQutosIndex = contentSplitStr[2].lastIndexOf("\"");
				uploadFileName = contentSplitStr[2].substring(firstQutosIndex + 1, lastQutosIndex);
				//*******************
				System.out.println("getUploadFileName() ===>" + uploadFileName);
				return uploadFileName;
			}
	
	
	//사용 브라우저가 IE인 경우
	/*private String getUploadFileName(String contentDisposition) {
		String uploadFileName = null;
		String[] contentSplitStr = contentDisposition.split(";");
		int lastPathSeparatorIndex = contentSplitStr[2].lastIndexOf("\\");
		int lastQutosIndex = contentSplitStr[2].lastIndexOf("\"");
		uploadFileName = contentSplitStr[2].substring(lastPathSeparatorIndex + 1, lastQutosIndex);
		return uploadFileName;
	}
	}*/
}
