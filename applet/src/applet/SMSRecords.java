package applet;
import java.sql.*;

import javax.naming.*;
import javax.sql.*;
public class SMSRecords {
    public void addSMSDetails(int ordernumber){
	Connection con=null;
	try{
	    Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://ss:3306/js?autoReconnect=true", "dev", "");
		Statement s1 = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		Statement s=con.createStatement();
		System.out.println("select o.status_code, o.del_date,'CREATED', '', concat('YourOrder: ',o.order_num,' by ',c.custname,'(',c.custcode,') is currently in ',o.status_code,' for delivery. Items:',(o.total_items-o.total_taken),',Amount:',o.total_value,',Balance:',o.balance_amt,'-Janta Stores'), c.mobile, o.order_num, o.custcode from customer_master c,orders o where o.order_num="+ordernumber+" and c.custcode=o.custcode");
		ResultSet rs=s1.executeQuery("select o.status_code, o.del_date,'CREATED', '', concat('YourOrder: ',o.order_num,' by ',c.custname,'(',c.custcode,') is currently in ',o.status_code,' for delivery. Items:',(o.total_items-o.total_taken),',Amount:',o.total_value,',Balance:',o.balance_amt,'-Janta Stores'), c.mobile, o.order_num, o.custcode from customer_master c,orders o where o.order_num="+ordernumber+" and c.custcode=o.custcode");
		if(rs.next()){
		    rs.beforeFirst();
		}
		
		if(rs.next()){
		 System.out.println(rs.getString(5));   
		    if(rs.getString(5).indexOf("in SUBMITTED for delivery")!=-1)
			if(s.executeUpdate("insert into sms_detail (msg_type, msg_create, msg_status, msg_remark, msg_text, to_number, msg_order_num, custcode) values('"+rs.getString(1)+"',now(),'"+rs.getString(3)+"','"+rs.getString(4)+"','"+rs.getString(5).replaceAll("in SUBMITTED for delivery", "being processed")+"','"+rs.getString(6)+"',"+rs.getInt(7)+",'"+rs.getString(8)+"')")>0)
			    System.out.println("Record added in sms queue");
			else
			    System.out.println("fail to add record in sms queue");
		}else
			if(s.executeUpdate("insert into sms_detail (msg_type, msg_create, msg_status, msg_remark, msg_text, to_number, msg_order_num, custcode) values('"+rs.getString(1)+"',now(),'"+rs.getString(3)+"','"+rs.getString(4)+"','"+rs.getString(5)+"','"+rs.getString(6)+"',"+rs.getInt(7)+",'"+rs.getString(8)+"')")>0)
			    System.out.println("Record added in sms queue");
			else
			    System.out.println("fail to add record in sms queue");
	}catch (Exception e){
		System.out.println("Exception : " + e.getMessage());
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
