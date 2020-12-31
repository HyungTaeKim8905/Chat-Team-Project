package util;

public class Util {
	public static String toJS(String str) {
		return str.replace("\\", "\\\\")
				.replace("\"", "\\\"")
				.replace("\r\n", "\\n")
				.replace("<", "&lt;")
				.replace(">", "&gt;")
				.replace("\n", "<br>")
				.replace("/", "&#x2f")
				.replace("&", "&amp");
	}
}
