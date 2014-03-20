import java.awt.Desktop;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



public class SendMessageToCustomer{
	private ResultSet resultSet;
	
	public Connection getConnection() {
		Connection connection=null;
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource dataSource= (DataSource)envContext.lookup("jdbc/js");
			connection = dataSource.getConnection();
		} catch (SQLException  e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		catch (NamingException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		System.out.println(connection.toString()+" \n  "+connection);
		return connection;
		
	}
	
	
	
	public  void  getMobileNumber(String mob) {
		
		
		String selectMessage = "select * from message_master where status='INIT' ";
		String mobileNumQuery = "select mobile,phone from customer_master where  custcode=? ";
		Connection connection = null;
		
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			//connection = DriverManager.getConnection("jdbc:mysql://192.169.1.150:3306/js_data?autoReconnect=true","dev","");
			
			// client side changes
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/js_data?autoReconnect=true","root","@ss123");
			//connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/js_data_13?autoReconnect=true","root","@ss123");
			
			System.out.println(" connected to DB "+connection.toString());
			PreparedStatement preparedStatement = connection.prepareStatement(selectMessage);
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()){
				do{
					String sr_no = resultSet.getString("sr_no");
					String cust_code = resultSet.getString("cust_code");
					String message = resultSet.getString("message");
					preparedStatement = connection.prepareStatement(mobileNumQuery);
					preparedStatement.setString(1, cust_code);
					
					ResultSet set = preparedStatement.executeQuery();
					while(set.next()){
						String mobNNUmber=null;
						
						if(!mob.equals(""))
							mobNNUmber = mob;
						else
							mobNNUmber = set.getString("mobile");
						
												
						if(mobNNUmber.equals("") && set.getString("phone").length()<10)
							continue;
						
						
						
						System.out.println("cust_code  :"+cust_code);
						System.out.println("SR _NO  :"+sr_no);
						System.out.println("message   :"+message);
						System.out.println("mobile no  :"+mobNNUmber);
						System.out.println("phone no  :"+set.getString("phone")+"\n====");
						
						if(mobNNUmber.equals("")){
							mobNNUmber = set.getString("phone");
						}
						
						String messageUrl="http://luna.a2wi.co.in:7501/failsafe/HttpLink?aid=512643&pin=gaint123&" +
											"mnumber="+mobNNUmber+"&message=" +
											URLEncoder.encode(message) + "&signature=JANTAS";
						
						
						
					
						
						
						System.out.println("message URl :"+messageUrl);
						
						URL myURL = new URL(messageUrl);
						URLConnection myURLConnection = myURL.openConnection();
					    myURLConnection.connect();
					    
					    InputStream inp = (InputStream) myURLConnection.getInputStream();
					    
					    String updateMessageMasterQuery="update message_master set status = ? , sent_date=now() where sr_no=?";
					    PreparedStatement updateStatement = connection.prepareStatement(updateMessageMasterQuery);
					    updateStatement.setString(1, "SENT");
					    updateStatement.setString(2, sr_no);
					    
					    int count = updateStatement.executeUpdate();
					    if(count>0)
					    	System.out.println("mesage master updated successfully ");
					    
					    

						System.out.println("\n==============");
						
						
						
					}
					
				}while(resultSet.next());
			}
			
			connection.close(); 
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
		}
		catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		catch (ClassNotFoundException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	
		
				
	}

	
	public static void main(String[] args) {
		
		SendMessageToCustomer send = new SendMessageToCustomer();
		//System.out.println("main "+args[0]);
		if(args.length>0)
			send.getMobileNumber(args[0]);
		else
			send.getMobileNumber("");
	}



	
	

}
