package Test;

public class Test {

	public static void main(String[] args) {
		String img = "이미지.jpg";
		img = "<a href='file_down.jsp?file_name=<%= filename1 %>'>" + img + "</a>";
		System.out.println(img);
	}
}



//<a href='file_down.jsp?file_name=<%= filename1 %>'>이미지.jpg</a>