<%@page contentType="text/html"%>   
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%
	try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		Connection conn = ds.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs=null,rs1=null;
		String selSql1="",item_code="";
		item_code=request.getParameter("icodeStartWith");
		String selSql = "select item_code from item_purchase_details";
		selSql=selSql + " where item_code='"+item_code+"'";
		selSql1="select i.item_name,ig.item_group_desc,ip.item_mrp,ip.purchase_price,"+
				"ip.margin_pct,ip.scheme_on_qty,ip.scheme_value,ip.landing_price,ip.lastmodifieddate,"+
				" ip.cash_discount,ip.purchase_qty,ip.total_price,s.scheme_desc,"+
				"v.vat_value from item_master i,item_group ig,item_purchase_details ip,scheme s,vat v "+
				" where  i.item_code=ip.item_code and ip.item_code='"+item_code+"' and "+
 				" i.item_group_code=ig.item_group_code and ip.scheme_code=s.scheme_code "+
 				" and ip.vat_code=v.vat_code order by ip.lastmodifieddate ";
 			
		rs = stmt.executeQuery(selSql);
		if(rs.next()){ 
%>
		<table border="1" name="t" id="id" class="item3">
      
       		<tr>
				<td width="10%"><b>Item Name</b></td>
				<td width="10%"><b>Item Group </b></td>
				<td width="30"><b>Item  MRP</b></td>
				<td width="10%"><b>Purchase Price</b></td>
				<td width="10%"><b>Margin</b></td>
				<td width="10%"><b>Scheme</b></td>
				<td width="10%"><b>Scheme Value</b></td>
				<td width="10%"><b>Scheme On Qty</b></td>
				<td width="10%"><b>Vat</b></td>
				<td width="10%"><b>Cash Discount</b></td>
				<td width="10%"><b>Landing Price</b></td>
				<td width="10%"><b>Purchase Qty</b></td>
				<td width="10%"><b>Total Price</b></td>
				<td width="10%"><b>Purchase Date</b></td>
			</tr>	
		
<%		
	       		
			rs1=stmt.executeQuery(selSql1);
			while(rs1.next()){	  
%> 
 			  <tr id="tr">		
				<td>
<%             
    			out.println(rs1.getString(1));    		    		    		
%>
    	 		</td><td>    			
<%			 
				out.println(rs1.getString(2));  
%>
				</td><td>			
<%			
             	out.println(rs1.getFloat(3));
%>       						
				</td><td>
<%	
           		out.println(rs1.getFloat(4));
%>
				</td><td>
<%	
           		out.println(rs1.getFloat(5));
%>
				</td><td>
<%	
           		out.println(rs1.getString(13));
%>
            	</td><td>
<%			
             	out.println(rs1.getInt(6));
%>       						
				</td><td>
<%	
           		out.println(rs1.getInt(7));
%>
				</td><td>
<%	
           		out.println(rs1.getFloat(14));
%>
				</td><td>
<%				
				out.println(rs1.getFloat(10));
%>
				</td><td>
				
<%	
           		out.println(rs1.getFloat(8));
%>
            	</td><td>
<%	
           		out.println(rs1.getFloat(11));
%>
            	</td><td>
<%	
           		out.println(rs1.getFloat(12));
%>
            	</td><td>
    	
            	
<%            	
				out.println(rs1.getString(9));
%>
          		</td> 
          	</tr>
<%
			}
%>
			</table>
<%						
		}
		
		
		//rs1.close();
		//stmt.close();
		//conn.close();
 	}
 	catch (Exception e) {
	        e.getMessage();
	        e.printStackTrace();
	        
	       // rs1.close();
			//stmt.close();
			//conn.close();
	 }
%>
					          		