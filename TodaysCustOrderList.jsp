<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*,payment.*" %>
<%
		
    	String custCode="";
    	int count=0;
    	String ordernum="";
		custCode=request.getParameter("custcode");	
		
		order.ManageOrder c;
		c = new order.ManageOrder("jdbc/js");
		c.TodaysCustOrderList(custCode); 
	
    	while(c.rs.next()) {
    	    if(ordernum==""){
    	   		ordernum = count+") " + c.rs.getString(1);	 
    	   		count++;   	
		    }
		    else{	
		    	ordernum = ordernum +", "+ count+")" + c.rs.getString(1);	    	
		    	count++;
		    }
 
		}	
		c.closeAll();	
		ManagePayment mp = new ManagePayment("jdbc/js");
	  	float balance = mp.getTotalBalane(custCode);
	  	mp.closeAll();
		System.out.println("::::::::"+custCode+":::"+count+":::"+balance);
		out.println(count+"#"+balance);
%>



