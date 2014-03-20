<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@page contentType="text/html"%>
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="editItemDetails.jsp" />	
</jsp:include> 


<%
	int site_id=0;
	DecimalFormat df = new DecimalFormat("###,###.00");
	try{
		site_id = (Integer)session.getAttribute("GlobalSiteId");
		System.out.print("In : "+site_id);
	}catch(Exception e){
		e.printStackTrace();
	}
	String i_code="";
	String ig_code="";
	String i_name="";
	String i_mrp="";
	String i_mrp2="";
	String i_rate="";
	String i_rate2="";	
	String flag="";
	String paramList="";
	String changeParamList="";
	String i_tickflag="";
	String ibarcode = request.getParameter("ibarcode");
	i_code=request.getParameter("icodeStartWith");
	ig_code=request.getParameter("igcodeStartWith");
	
	i_name=request.getParameter("inameStartWith");
	i_mrp=request.getParameter("imrpStartWith");
	i_rate=request.getParameter("irateStartWith");
	i_mrp2=request.getParameter("imrp2StartWith");
	i_rate2=request.getParameter("irate2StartWith");
	flag=request.getParameter("flag");		
	i_tickflag = request.getParameter("i_tickflg");
	
	
	item.ManageItem mi;
	mi = new item.ManageItem("jdbc/js");
    	
    mi.listItem(i_code,ig_code,i_name,i_mrp,i_mrp2,i_rate,i_rate2,i_tickflag,ibarcode,site_id);
    	
		
%>
       <style>
       #id #tr:hover td{
       		background-color: white;
       		cursor: pointer;
       }
       #id td{
       		padding: 3px 0px 3px 5px;
       }
       </style>
       <table border="1" name="t" id="id" class="item3" cellspacing = 0 cellpadding = 0 style="border-collapse: collapse; width: 96%;background-color: #ECFB99;" bordercolor=black>
      
    	 <thead>
     		  	<tr align="left">
				<td><b>Item Code</b></td>
				<td><b>Change Quantity</b></td>
				<td><b>Item Group</b></td>
				<td><b>Item  Name</b></td>
				<td><b>Item  Barcode</b></td>
				<td><b>Item Weight</b></td>
				<td><b>Item MRP</b></td>
				<td><b>Item Rate</b></td>
				<td><b>Deal Flag</b></td>
				<td><b>Ticker Flag</b></td>
				<td><b>Is bachka</b></td>
				<td><b>Mix Item</b></td>
				<td><b>Item History</b></td>
			</tr>
     	</thead>	
		<tbody>
<%		
	       
	      	while(mi.rs.next()) {
	      	if(flag.equals("1")){
	       		paramList="EditItemForm.jsp?icode="+mi.rs.getString(1)+"&igcode="+mi.rs.getString(7)+"&iname="+mi.rs.getString(3)+"&iweight="+mi.rs.getString(4)+"&imrp="+mi.rs.getString(5)+"&irate="+mi.rs.getString(6)+"&id_type="+mi.rs.getString(10)+"&id_flag="+mi.rs.getString(9)+"&id_qty="+mi.rs.getString(11)+"&id_amt="+mi.rs.getString(12)+"&i_comm="+mi.rs.getString(13)+"&i_tickflag="+mi.rs.getString(14)+"&ibarcode="+mi.rs.getString(15)+"&box_qty="+mi.rs.getInt(16)+"&is_bachka="+mi.rs.getString("is_bachka")+"&is_mixture="+mi.rs.getString("mix_item")+"&groupCodeValue="+mi.rs.getString("item_group_code");	       			
	       }
	       else{
	       		paramList="ItemDetails.jsp?icode="+mi.rs.getString(1)+"&igcode="+mi.rs.getString(7)+"&iname="+mi.rs.getString(3)+"&iweight="+mi.rs.getString(4)+"&imrp="+mi.rs.getString(5);		
	       }
	      	changeParamList="ChangeQuantityItemForm.jsp?icode="+mi.rs.getString(1)+"&igcode="+mi.rs.getString(7)+"&iname="+mi.rs.getString(3)+"&iweight="+mi.rs.getString(4)+"&imrp="+mi.rs.getString(5)+"&irate="+mi.rs.getString(6)+"&id_type="+mi.rs.getString(10)+"&id_flag="+mi.rs.getString(9)+"&id_qty="+mi.rs.getString(11)+"&id_amt="+mi.rs.getString(12)+"&i_comm="+mi.rs.getString(13)+"&i_tickflag="+mi.rs.getString(14)+"&ibarcode="+mi.rs.getString(15);
	       	
	        %>
			  <tr id="tr" align="left">		
				<td align="left"><a  href="<%=paramList%>"><%=mi.rs.getString(1)%></a></td>
    	 		<td><a href="<%=changeParamList%>">Change Quantity</a></td>
    	 		<td><%=mi.rs.getString(7)%></td>
    	 		<td><%=mi.rs.getString(3)%></td>
    	 		<td><%=mi.rs.getString(15)%></td>
    	 		<td><%=mi.rs.getString(4)%></td>
    	 		<td><%=df.format(mi.rs.getFloat(5))%></td>
    	 		<td><%=df.format(mi.rs.getFloat(6))%></td>
    	 		<%-- <td><%=mi.rs.getString("is_bachka") %></td>  --%>
    	 		<td>
<%	
                String msg1= mi.rs.getString(9); 
                if(msg1.equals("N")){   
           			out.println("No");
           		}
           		else{
           			out.println("Yes");
           		}
%>  
          		</td><td>
<%	
                String msg2= mi.rs.getString(14); 
                if(msg2.equals("N")){   
           			out.println("No");
           		}
           		else{
           			out.println("Yes");
           		}
%>  
            	</td>
            	<td><%=mi.rs.getString("is_bachka") %></td>
            	<td><%=mi.rs.getString("mix_item") %></td><td> 
<%          	
                String msg= mi.rs.getString(8); 
                if(!msg.equals("NH")){                      
%>                       
            	    <a  href="ItemHistoryForm.jsp?icode=<%=mi.rs.getString(1)%>">history
<%           
                }
%>			
				
            	 
			    </td></tr>
			
<%			    
		      }
		      mi.closeAll();			  
%>
			 <style type="text/css">
			 a:link {color: blue}
			 a:hover {background: blue;color: white}
			 a:active {background: blue;color: white}
			 </style>

	</tbody>
</table>
			
    	