<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<jsp:include page="header.jsp" /> 
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="GroupItemDetailsForm.jsp" />	
</jsp:include> --%>

<%@ page errorPage="ErrorPage.jsp?page=GroupItemDetailsForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>


<%@page contentType="text/html"%>

<%
	DecimalFormat df = new DecimalFormat("###,###.00");
	Connection conn=null;
	Statement stat=null;
	ResultSet rs=null;
	try{
		String ig_code="";		
		ig_code=request.getParameter("ig_code");
						
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
    	stat=conn.createStatement();
    	   	
    	String query="";
    	query="select DISTINCT(i.item_code), i.item_group_code, i.item_name, " +
				" i.item_weight, i.item_mrp, i.item_rate,i1.item_group_desc, ifnull(i2.item_code,'NH'), " +
				" i.deal_active_flag, i.deal_type, i.deal_on_qty, i.deal_amount" +
    			" from  item_group i1,item_master i" +
    			" left join item_history i2 on i.item_code = i2.item_code"+
    	         " where i.item_group_code=i1.item_group_code and i1.item_group_code='"+ig_code+"' ";
    	
%>			   
       <center><br><br><b>Item details</b><br><br>
	   <div  class="ddm1">
       <table border="1" name="t" id="id" class="item3">
       
       		<tr>
				<td width="10%"><b>Item_Code</b></td>
				<td width="20%"><b>Item_Group</b></td>
				<td width="20"><b>Item_Name</b></td>
				<td width="10%"><b>Item_weight</b></td>
				<td width="10%"><b>Item_MRP</b></td>
				<td width="10%"><b>Item_Rate</b></td>
				<td width="5%"><b>Deal_active_flag</b></td>
				<td width="10%"><b>Item_History</b></td>
				
			</tr>	
		
<%		
    	rs = stat.executeQuery(query);
		while(rs.next()){  

	
 %>
			  <tr id="tr">		
				<td align="left"><a  href="EditItemForm.jsp?icode=<%=rs.getString(1)%>&igcode=<%=rs.getString(7)%>&iname=<%=rs.getString(3)%>&iweight=<%=rs.getString(4)%>&imrp=<%=rs.getString(5)%>&irate=<%=rs.getString(6)%>&id_type=<%=rs.getString(10)%>&id_flag=<%=rs.getString(9)%>&id_qty=<%=rs.getString(11)%>&id_amt=<%=rs.getString(12)%>"  >	
<%             
    			out.println(rs.getString(1));    		    		    		
%>
    	 		</a></td><td align="left">    			
<%			 
				out.println(rs.getString(7));  
%>
				</td><td align="left">			
<%			
             	out.println(rs.getString(3));
%>       						
				</td><td>
<%	
           		out.println(rs.getString(4));
%>
				</td><td align="right" >
<%	
           		out.println(df.format(rs.getFloat(5)));
%>
				</td><td align="right">
<%	
           		out.println(df.format(rs.getFloat(6)));
%>
            	</td><td align="right">
<%	
                String msg1= rs.getString(9); 
                if(msg1.equals("N")){   
           			out.println("No");
           		}
           		else{
           			out.println("Yes");
           		}
%>  
          		</td>
<%          
                String msg= rs.getString(8); 
                if(!msg.equals("NH")){                      
%>                       
            	    <td align="center"><a  href="ItemHistoryForm.jsp?icode=<%=rs.getString(1)%>">history</td>
<%           
                }
%>      	 
			    </td></tr>
			
<%			    		
		}	
		rs.close();
        stat.close();
		conn.close();
	}
	catch (Exception e) {
		e.getMessage();
		e.printStackTrace();		
        stat.close();
		conn.close();
	}

%>

</table>
			