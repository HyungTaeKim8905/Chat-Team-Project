package file;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
 

/**
 * Servlet implementation class Upload
 */
@WebServlet("/Upload")
@MultipartConfig(
			fileSizeThreshold=0,
			location = "./files"
		)
public class Upload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Upload() {
        super();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 request.setCharacterEncoding("UTF-8");
	     response.setContentType("text/html; charset=UTF-8");
	     PrintWriter out =response.getWriter();
	     
	     String uploadFileNameList="";
	     
	     for(Part part: request.getParts()) {
	    	 String contentDisposition = part.getHeader("content-disposition");
	    	 String uploadFileName = getUploadFileName(contentDisposition);
	    	 part.write(uploadFileName);
	    	 uploadFileNameList += "" + uploadFileName;
	     }
	     
	     out.print(uploadFileNameList + "파일을 업로드 하였습니다.");
	}
	private String getUploadFileName(String contentDisposition) {
		String uploadFileName=null;
		String[] contentSplitStr=contentDisposition.split(";");
		int firstQutosIndex = contentSplitStr[2].indexOf("\"");
		int lastQutosIndex = contentSplitStr[2].lastIndexOf("\"");
		uploadFileName = contentSplitStr[2].substring(firstQutosIndex+1, lastQutosIndex);
		return uploadFileName;
	}
}
