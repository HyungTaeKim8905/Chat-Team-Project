package Controller;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	PasswordAuthentication passAuth;
    
    public GoogleAuthentication(){
        this.passAuth = new PasswordAuthentication("gudxo12261", "zplhmecqsxrndavy");
    }
 
    public PasswordAuthentication getPasswordAuthentication() {
        return this.passAuth;
    }
}
