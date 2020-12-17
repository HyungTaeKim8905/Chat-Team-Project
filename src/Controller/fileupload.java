package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class fileupload
 */
@WebServlet("/fileupload")
public class fileupload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public fileupload() {
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
		ServletContext context = this.getServletContext();
		String uploadPath = context.getRealPath("/file");//저장될경로
		int size = 1024*1024*15;
		ArrayList<String> filenamelist = new ArrayList<String>(); // 폼에서 선택한 원본 파일명
		ArrayList<String> filerealnamelist = new ArrayList<String>(); //실제 파일명
		try	{
			MultipartRequest multipart = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
			
			
			List<MultipartFile> files = multipart.getFileNames();
			while(files.hasMoreElements()) {
				String name = (String)files.nextElement();
				String filename = multipart.getOriginalFileName(name);
				String filerealname = multipart.getFilesystemName(name);
				System.out.println(name);
				System.out.println(filename);
				System.out.println(filerealname);
				filenamelist.add(filename);
				filerealnamelist.add(filerealname);
			}
			
			/*
			Iterator<String> iterator = files.asIterator();
			while(iterator.hasNext())	{
				String file = iterator.next();
				System.out.println(file);
			}
			*/
			
		} catch(Exception e) {
			System.out.println("ERROR : " + e.getMessage());
			e.printStackTrace();
		}
	}

}
