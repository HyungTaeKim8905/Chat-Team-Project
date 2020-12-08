package Controller;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Test {
	public static String testMD5(String str) {
	    String MD5 = "";
	    int j = 1;
	    try {
	    	while(j <= 6)	{
		        MessageDigest md = MessageDigest.getInstance("MD5");
		        md.update(str.getBytes());
		        byte byteData[] = md.digest();
		        StringBuffer sb = new StringBuffer();
		        for (int i = 0; i < byteData.length; i++) {
		            sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
		        }
		        MD5 = sb.toString();
	    	}
	    } catch (NoSuchAlgorithmException e) {
	        e.printStackTrace();
	        MD5 = null;
	    }
	    return MD5;
	}

	public static void main(String[] args) {
		System.out.println(testMD5("8905love!!"));
	}

}
