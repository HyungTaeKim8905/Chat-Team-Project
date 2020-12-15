package Controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import DTO.UserDTO;
import VO.UserVO;
/**
 * Servlet implementation class Mypage
 */
@WebServlet("/Mypage")
public class Mypage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Mypage() {
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
		response.setContentType("text/html;charset=utf-8");		// 서블릿에 응답할 데이터의 타입을 html 문서 타입으로 설정하는 부분이다.
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		ServletContext context = this.getServletContext();
		String uploadPath = context.getRealPath("/image");		//파일을 업로드할 서버상의 폴더명을 지정
		/* getRealPath()메서드는 현재 웹 서버의 상대경로를 웹 경로(uploadTest/upload)가 아닌 실제 서버 시스템상의 디렉토리 경로(c:\\uploadTest\\upload\)를 반환한다. */
		int size 			= 1024*1024*5;						// 5메가로 지정함. 15메가를 넘을 경우 예외 발생
		//한 번의 요청으로 업로드할 수 있는 업로드 파일의 최대 크기를 지정한다.
		String filename	    = "";								// 폼에서 선택한 원본 파일명
		String filerealname = "";								// 서버에 실제로 저장된 파일의 이름
		//String filepath     = uploadPath;						// 저장될 파일의 경로
		System.out.println(uploadPath);
		JSONArray jsonArrList = null;
		try	{
			MultipartRequest multipart = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
			String id = multipart.getParameter("id");
			String nick = multipart.getParameter("nick");
			String statusmessage = multipart.getParameter("statusmessage");
			Enumeration files = multipart.getFileNames();		//폼에서 전송되어온 파일 타입의 입력상자의 이름을 반환한다.
			//getFileNames()메서드는 파일을 여러개 업로드할 경우 타입이 file인 파라미터 이름들을 Enumeration 타입으로 반환한다.
			
			String file = (String)files.nextElement();		//파일을 업로드 했을 때 입력상자의 이름을 얻어온다.
			filerealname = multipart.getFilesystemName(file);	//업로드된 파일의 서버 상에 업로드된 실제 파일명을 얻어온다.
			//서버에 실제로 업로드된 파일의 이름을 반환한다.
			
			filename = multipart.getOriginalFileName(file);	//업로드된 파일의 처음에 폼에서 선택한 원본 파일명을 얻어온다.
			//클라이언트가 업로드한 파일의 원본 이름을 반환한다.
			System.out.println("id : "+id);
			System.out.println("nick : "+nick);
			System.out.println("statusmessage : "+statusmessage);
			System.out.println("filename원본 파일 명 : "+filename);
			System.out.println("filerealname서버에 저장되는 파일 명 : "+filename);
			System.out.println("파일을 업로드 했을 때 입력상자의 이름을 얻어온다. : "+file);
			String Str1 = "";
			String Str2 = "";
			if(filename == null || filerealname == null)	{
				Str1 = null;
				Str2 = null;
			}
			else	{
				Str1 = "./image/" + filename;
				Str2 = "./image/" + filerealname;
			}
			UserDTO dto = new UserDTO();
			UserVO vo = dto.MyPageModify(id, nick, statusmessage, Str1, Str2);
			if(vo == null)	{
				System.out.println("doPost() ==>  vo가 null 입니다.");
				return ;
			}
			jsonArrList = new JSONArray();
			JSONObject jsonList = new JSONObject();
			jsonList.put("nick", vo.getNick());
			jsonList.put("Statusmessage", vo.getStatusmessage());
			jsonList.put("PictureOriginName", vo.getPictureOriginName());
			jsonList.put("PictureRealName", vo.getPictureRealName());
			jsonArrList.add(jsonList);
			System.out.println(jsonArrList);
			out.println(jsonArrList);
		} catch(Exception e) {
			System.out.println("ERROR : " + e.getMessage());
			e.printStackTrace();
		}
	}

}
