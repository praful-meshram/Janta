<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>



<marquee id="newsFlash" BGCOLOR="#FFE4C4" direction="up" loop="true" scrollamount="1.5" height="100">
<center>
<div width="100%" style="" onMouseOver="newsFlash.stop();" onMouseOut="newsFlash.start();" ><nobr><font size="2">
<table border=0 width="100%">
<tr style="background-color: #ffffff;">
  <td><b>Name</b></td>
  <td><b>Rate</b></td>
  <td><b>MRP</b></td>
  <td><b>Type</b></td>
  <td><b>Deal_Qty</b></td>
  <td><b>Amount</b></td>
 </tr>

<%	
	Connection conn1=null;
	Statement stat1=null;	
	ResultSet rs1=null;
	
	String itcode="", itnme="", itrate="", itmrp="",ittype="",itdealqty ="", itdealamt="";
	String display="";
	int ik=0;
	try{	
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds1 = (DataSource)envContext.lookup("jdbc/js");
		conn1 = ds1.getConnection();
		stat1 = conn1.createStatement();		
		
		//String query1="SELECT item_code, item_name, item_rate, item_mrp, deal_type, deal_on_qty, deal_amount FROM item_master where deal_active_flag ='Y' order by rand() limit 3";
		String query1="SELECT item_code, item_name, item_rate, item_mrp, deal_type, deal_on_qty, deal_amount FROM item_master where ticker_flag ='Y' order by item_name ";
		//System.out.println(query1);
		rs1=stat1.executeQuery(query1);	
		int rowcount=0;		
		while(rs1.next()) {	  
			rowcount++;
			itcode = rs1.getString(1);
			itnme = rs1.getString(2);
			itrate = rs1.getString(3);
			itmrp = rs1.getString(4);
			ittype = rs1.getString(5);
			itdealqty = rs1.getString(6);
			itdealamt = rs1.getString(7);
			if(rowcount%2==0){
%>
<tr style="background-color: #ffffff;">
<% }
	else{
%>
<tr style="background-color: #eeeeee;">
<% } %>

 <td><%=itnme%></td>
 <td ><%=itrate%></td>
 <td><%=itmrp%></td>
 <td><%=ittype%></td>
 <td><%=itdealqty%></td>
 <td><%=itdealamt%> </td>
</tr>

<%		
			//if(ik == 0){
				// display = itcode+" "+itnme+" "+itrate+" "+itmrp+" "+ittype+" "+itdealqty+" "+itdealamt;
				// ik= ik+1;
			//}else display = display +" ,       "+itcode+" "+itnme+" "+itrate+", "+itmrp+" "+ittype+" "+itdealqty+", "+itdealamt;
		}
	
		conn1.close();
	}catch(Exception e){
		System.out.println(e);
		conn1.close();
	}	
%>

<!--  <br><marquee BGCOLOR="#FFE4C4" HEIGHT=25   BEHAVIOR="alternate"> </marquee>-->
</table>
</nobr></div></center></marquee>
