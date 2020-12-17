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
		String filename[] = new String[5];     // 폼에서 선택한 원본 파일명
		String filerealname[] = new String[5]; //실제 파일명
		try	{
			MultipartRequest multipart = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
			
			Enumeration files = (Enumeration)multipart.getFileNames();
			//Enumeration n1 = files.values();
			System.out.println(files);
			String file = (String)files.nextElement();	// file = file
			System.out.println(file);
			
			/*
			while(files.asIterator().hasNext())	{
				System.out.println("*********************");
				System.out.println(files.asIterator().next());
			}
			*/
			/*
			Iterator<String> files = (Iterator<String>) multipart.getFileNames();
			System.out.println(files);
			while(files.hasNext())	{
				String uploadFile = files.next();
				System.out.println(uploadFile);
			}
			*/
			
			for(int i = 0; i < 5; i++)	{
				filename[i] = multipart.getOriginalFileName(file);
				filerealname[i] = multipart.getFilesystemName(file);
				System.out.println(filename[i]);
				System.out.println(filerealname[i]);
			}
			
			/*
			int num = 0;
			//System.out.println(files.length);
			while(files.asIterator().hasNext())	{
				files.asIterator().next();
				num++;
			}
			*/
			//System.out.println("num :::::::::: "+num);
			
			
		} catch(Exception e) {
			System.out.println("ERROR : " + e.getMessage());
			e.printStackTrace();
		}
	}

}
