package util;

public class Util {
	public static String toJS(String str) {
		return str.replace("<", "&lt;")
				.replace(">", "&gt;")
				.replace("\\", "\\\\")
				.replace("\"", "\\\"")
				.replace("\r\n", "\\n")
				.replace("\n", "<br>");
	}
	public static String toFileJS(String str) {
		return str.replace("\\", "\\\\")
				.replace("\"", "\\\"")
				.replace("\r\n", "\\n")
				.replace("\n", "<br>");
	}
}
