package sms;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class StartSMSSendProcess implements Runnable{
    public static void main(String vikas[]){
	Thread t=new Thread(new StartSMSSendProcess());
	
	t.start();
    }
    public void run(){
	Connection con=null;
	Statement s=null;
	try{
	    SMSClient sc=new SMSClient(4);
	    Class.forName("com.mysql.jdbc.Driver");
	    con = DriverManager.getConnection("jdbc:mysql://rms:3306/js?autoReconnect=true", "root", "");
	    s=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	    ResultSet rs=s.executeQuery("SELECT msg_text, to_number FROM sms_detail");
	    rs.next();
	    while(rs.next()){
		sc.sendMessage(rs.getString(1),rs.getString(2));
		Thread.sleep(10000);
	    }
	
	}catch (Exception e) {
	    e.printStackTrace();
	}finally{
	    try{
		con.close();
	    }catch (Exception e) {
		 e.printStackTrace();
	    }
	}
    }
    
}
