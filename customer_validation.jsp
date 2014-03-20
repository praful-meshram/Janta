<%@ page contentType="text/html"%>
<%@ page import="java.sql.*,javax.naming.*,javax.sql.*,java.io.*" %>
<%	
	Connection conn=null;
	Statement stat=null;
	ResultSet rs=null;
	try{
		String phone="";
		String type="";
		phone=request.getParameter("phStartWith"); 
		type = request.getParameter("type");
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
    	stat=conn.createStatement();
    	String selSql = "";
    	if(type.equals("ph"))
    		selSql = "select phone,custname,add1,add2 from customer_master where phone='"+phone+"'";
    	else
    		selSql = "select phone,custname,add1,add2 from customer_master where mobile='"+phone+"'";
    	System.out.print(selSql);
		rs = stat.executeQuery(selSql);
		if(rs.next()){  
			if(type.equals("ph")){
				out.println("Phone number already exist !!!");
			} else {
	    		out.println("Mobile number already exist !!!");
			}
			out.println("Customer Name : "+rs.getString(2));
			out.println("Customer Address1 : "+rs.getString(3));
			out.println("Customer Address2 : "+rs.getString(4));
		}		
		rs.close();	
        stat.close();
		conn.close();
	}
	catch (Exception e) {
		e.getMessage();
		e.printStackTrace();
		rs.close();	
        stat.close();
		conn.close();
	}

%>