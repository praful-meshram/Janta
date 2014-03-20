

   package user;
   
   import java.sql.*;
   import javax.sql.*;
   import javax.servlet.http.*;
   import javax.naming.*;
   import java.util.Hashtable;

   public class Login {

   private String username = "";
   private String password = "";
   private Integer siteId;
   public Hashtable HT = new Hashtable();
   public Login() {
                  }
 
  public void setUsername(String username) 
  {
     this.username = username;
  }

  public void setPassword(String password) 
  {
     this.password = password;
   }

  public void setSiteId(Integer siteId) 
  {
     this.siteId = siteId;
   }

 public String  authenticate(String username2,
 String password2,  HttpServletRequest request) 
 {
  String query="select  start_dt,end_dt,user_type_code,email_addr from user";
   
   String retValue;
   String start_dt,end_dt,email_addr,user_type_code,querydt;
   HttpSession session;
  try 
    {
	Context initContext = new InitialContext();
	Context envContext  = (Context)initContext.lookup("java:/comp/env");
	DataSource ds = (DataSource)envContext.lookup("jdbc/js");
	Connection conn = ds.getConnection();
	PreparedStatement stat1=conn.prepareStatement("select  start_dt,end_dt,user_type_code,email_addr from user where username=? and password=?");
	stat1.setString(1, username);
	stat1.setString(2, password);
   	Statement stat=conn.createStatement();
	query = query + " where username = '" + username + "' and password = '" + password + "'";
   	ResultSet rs=stat1.executeQuery();
	if (rs.next())
	 {
		querydt = query + " and now() >  start_dt ";
		start_dt = rs.getString(1);
		end_dt = rs.getString(2);
		user_type_code = rs.getInt(3)+"";
		email_addr = rs.getString(4);
		rs.close();
		rs=stat.executeQuery(querydt);
		if (rs.next())
		{
			querydt = query + " and now() <  end_dt ";
			rs.close();
			rs=stat.executeQuery(querydt);
			if (rs.next())
			{
				session = request.getSession(true);
				session.setAttribute("GlobalSiteId", siteId);
				session.setAttribute("UserName",username2);
				session.setAttribute("start_dt",start_dt);
				session.setAttribute("end_dt",end_dt);
				session.setAttribute("user_type_code",user_type_code);
				session.setAttribute("email_addr",email_addr);
				query = "SELECT a.screen_name, b.access_flag FROM screen_master a, user_access b where a.screen_id = b.screen_id and user_type_code = '" + user_type_code + "'";
				System.out.println(query);
			 	ResultSet rs1=stat.executeQuery(query);
				while(rs1.next()){
					String formname= rs1.getString(1);
					String accessFlag= rs1.getString(2);
					//System.out.println("Formname :"+formname +"flag"+accessFlag);
					HT.put(formname, accessFlag);
					HT.get(formname);
					
				 	session = request.getSession(true);
				 	session.setAttribute("ParaHash",HT);
				}
				
				retValue = "1";
			}
			else 
				retValue =  "3," + end_dt;
		}
		else
			retValue =  "2," + start_dt;
	}
	else
		retValue =  "0," ;
	if (rs!=null)
		rs.close();
	stat.close();
	conn.close();
	return retValue;

 }catch(Exception e){

 e.printStackTrace();
 retValue =  "0," ;
 return retValue;
 }
}
   public boolean logOff(HttpServletRequest request) 
   {
	HttpSession session;
	session = request.getSession(false);
	if (session != null)
	
	session.invalidate();
	return true;
  } 
 }


