package Controller;
import java.util.ArrayList;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.Random;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 * Servlet implementation class MailSendServlet
 */
@WebServlet("/mailSendServlet")
public class MailSendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MailSendServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("1:::::::");
		request.setCharacterEncoding("UTF-8");
		String sender = request.getParameter("sender");
		String receiver = request.getParameter("email");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		response.setContentType("text/html;charset=UTF-8");
		subject = "채팅 사이트 이메일 인증번호 입니다.";

		int len = 6;
		int dupCd = 1; // 1 중복허용 , 2 중복제거
		Random rand = new Random();
		String numStr = ""; // 난수가 저장될 변수

		for (int i = 0; i < len; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			if (dupCd == 1) {
				numStr += ran;
			} else if (dupCd == 2) {
				if (!numStr.contains(ran)) {
					numStr += ran;
				} else {
					i -= 1;
				}
			}
		}
		
		content = "인증 번호는 : " + numStr + " 입니다.";
		System.out.println(sender);	
		System.out.println(receiver);
		System.out.println(subject);
		System.out.println(content);
		PrintWriter out = response.getWriter();
		try {
			Properties properties = System.getProperties();
			properties.put("mail.smtp.starttls.enable", "true"); // gmail은 무조건 true 고정
			properties.put("mail.smtp.host", "smtp.gmail.com"); // smtp 서버 주소
			properties.put("mail.smtp.auth", "true"); // gmail은 무조건 true 고정
			properties.put("mail.smtp.port", "587"); // gmail 포트
			System.out.println("2:::::::");
			Authenticator auth = new GoogleAuthentication();
			Session s = Session.getDefaultInstance(properties, auth);
			// Session s = Session.getdefultInstance(properties, auth);
			System.out.println("3:::::::");
			Message message = new MimeMessage(s);
			System.out.println("4:::::::");
			Address sender_address = new InternetAddress(sender); //////////// 여기서 오류
			System.out.println("5:::::::");
			Address receiver_address = new InternetAddress(receiver);
			message.setHeader("content-type", "text/html;charset=UTF-8");
			message.setFrom(sender_address);
			message.addRecipient(Message.RecipientType.TO, receiver_address);
			message.setSubject(subject);
			message.setContent(content, "text/html;charset=UTF-8");
			message.setSentDate(new java.util.Date());
			Transport.send(message);
			System.out.println("6:::::::");
			// JSON 형식
			JSONArray jsonArrList = new JSONArray();
			JSONObject jsonList = new JSONObject();
			jsonList.put("numStr", numStr);
			jsonArrList.add(jsonList);
			out.println(jsonArrList);
			System.out.println("성공적으로 메일을 전송했습니다.");
		} catch (Exception e) {
			out.println("SMTP 서버가 잘못 설정되었거나, 서비스에 문제가 있습니다.");
			e.printStackTrace();
		}
	}

}
