<%@ page import="java.net.URLEncoder"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>

<%
	String filedownload = request.getParameter("file_name");	//클라이언트에서 파라미터로 전송되어 오는 다운로드할 파일 이름을 받는 부분
	
	//*****************************// 파일 다운로드 카운트 ++1**********************************************
								
	String savePath = "upload";	// 서버에 어떠한 파일이 업로드된 폴더의 이름을 저장
	
	//*****************************************************************************************************
	
	//******************************upload폴더의 서버 상의 실제 물리적인 경로를 얻어오는 부분***********************************
	
	ServletContext context = request.getSession().getServletContext();	
	String sDownloadPath = context.getRealPath(savePath);	//upload폴더의 서버 상의 실제 물리적인 경로를 얻어오는 부분이다.
	// sDownloadPath변수에 저장되어있는 경로는 => D:\KHT\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\Chat-Team-Project
	String sFilePath = sDownloadPath + "\\" + filedownload;	//다운로드 할 파일의 경로와 파일의 이름을 합침
	// sFilePath변수에 저장되어있는 경로는 =>  D:\KHT\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\Chat-Team-Project\\file
	
	//*****************************************************************************************************
	
	
	byte b[] = new byte[4096];		//바이너리 배열 만듬
	FileInputStream in = new FileInputStream(sFilePath);			// 경로가 가리키는 파일을 바이트스트림으로 읽기 위한 FileInputStream객체를 생성
	String sMimeType = getServletContext().getMimeType(sFilePath);	//다운로드할 파일의 마임타입을 얻어옴
	System.out.println("sMimeType>>>" + sMimeType);	
	//마임타입은 확장자명이라고 생각하면 된다.
	if (sMimeType == null) {	//다운로드할 파일의 마임 타입이 제대로 반환되지 않으면 기본 마임타입을 지정하는 부분이다.
		sMimeType = "application/octet-stream";
	}
	response.setContentType(sMimeType);	//응답할 데이터의 마임 타입을 다운로드 할 파일의 마임 타입으로 지정하는 부분이다.
	String agent = request.getHeader("User-Agent");
	boolean ieBrowser = (agent.indexOf("MSIE") > -1) || (agent.indexOf("Trident") > -1);//클라이언트가 사용하는 브라우저 종류가 internet explorer인지를 판단하는 부분이다.

	if (ieBrowser) {	//만약 사용 브라우저의 종류가 internet explorer인경우 다운로드 시 한글 파일명이 깨지지 않도록 처리하는 부분 
						//또한 사용 브라우저의 종류가 internet explorer인 경우 공백 부분이 "+"문자로 변경되므로 "+"문자를 다시
						//공백 문자("%20")으로 변경해 주고 있다.
		filedownload = URLEncoder.encode(filedownload, "UTF-8").replaceAll("\\+", "%20");
	} else {	//사용 브라우저의 종류가 internet explorer가 아닌경우 다운로드 시 한글 파일명이 깨지지 않도록 처리하는 부분이다.
		filedownload = new String(filedownload.getBytes("UTF-8"), "iso-8859-1");
	}

	response.setHeader("Content-Disposition", "attachment; filename= " + filedownload);
	//브라우저에서 해석되는 확장자의 파일도 다운로드 박스가 실행되게 처리하는 부분이다. 헤더 정보 설정 시 Content-Disposition값을 attachment로
	//설정하면 모든 파일에 대해서 다운로드 박스가 실행된다.
	ServletOutputStream out2 = response.getOutputStream();
	//파일 다운로드 역할을 하는 바이트 기반 출력 스트림 객체를 생성하는 부분이다. jsp자체에서 out이라는 문자기반
	//출력 스트림이 존재하므로 출력 스트림 객체명을 out2라고 지정하였다.
	int numRead;

	while ((numRead = in.read(b, 0, b.length)) != -1) {	// b 바이트 배열 객체 단위로 다운로드 할 파일 정보를 읽어서 응답에 출력
														// 하여 다운로드 처리를 하는 부분이다.
		out2.write(b, 0, numRead);
	}
	out2.flush();
	out2.close();
	in.close();
%>