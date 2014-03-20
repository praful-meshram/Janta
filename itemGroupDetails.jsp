<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@page contentType="text/html"%>
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="itemGroupDetails.jsp" />	
</jsp:include>
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=itemGroupDetails.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<%
	DecimalFormat df = new DecimalFormat("###,###.00");
	Connection conn=null;
	Statement stat=null;
	ResultSet rs1=null;
	try{
		
		String ig_code="";
		String ig_desc="";
		String hchckall="";
		String query="";
		int igNumber=0;
		ig_code=request.getParameter("ig_codeStartWith"); 
		ig_desc=request.getParameter("ig_descStartWith"); 
		hchckall=request.getParameter("hchckallStartWith"); 
		igNumber=Integer.parseInt(request.getParameter("igNumber")); 
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
    	stat=conn.createStatement(); 
    	if(hchckall.equals("1")){	
    		query="select count(i.item_group_code), i1.item_group_code,i1.item_group_desc,i1.item_group_number, i1.fmcg_ind" +
			   " from  item_group i1 left join item_master i "+
				" on i1.item_group_code=i.item_group_code ";
			
		}
		else{	   	
	    	query="select count(i.item_group_code), i1.item_group_code,i1.item_group_desc,i1.item_group_number, i1.fmcg_ind" +
				   " from  item_group i1 left join item_master i "+
					" on i1.item_group_code=i.item_group_code  where 1=1";
	    	
	    	if(!ig_code.equals("")){
	    		query = query + " and i1.item_group_code like'" + ig_code + "%'";
	    	}    			
	    	if(!ig_desc.equals("")){
	    	    query = query + " and i1.item_group_desc like'" + ig_desc + "%'";
	    	}
	    	if(igNumber != 0){
	    	    query = query + " and i1.item_group_number like'" + igNumber + "%'";
	    	}
	    }
	    	query=query + " group by i1.item_group_code order by i1.item_group_desc";
	    	
	    	
    	
%>		
	   
       
	   <div  class="ddm1">
       <table border="1" name="t" id="id" class="item3" style="background-color: #ECFB99;">
       <thead>
       		<tr>
				
				<td width="20%" align="center"><b>Item Group Code</b></td>
				<td width="20%" align="center"><b>Item Group </b></td>
				<td width="20%" align="center"><b>Item Group Number</b></td>
				<td width="20%" align="center"><b>FMCG Flag </b></td>
				<td width="20%" align="center"><b>Total Items</b></td>	
				<td width="30%" align="center"><b>Remark/Comment</b></td>								
			</tr>	
		<thead>
		<tbody>	
<%		
		System.out.println(query);
    	ResultSet rs = stat.executeQuery(query);
    	
		while(rs.next()){  

	
 %>
			  <tr id="tr">		
				<td align="left"><a  href="EditItemGroupForm.jsp?ig_code=<%=rs.getString(2)%>&ig_desc=<%=rs.getString(3)%>&ig_number=<%=rs.getString(4)%>&fmcg_flag=<%=rs.getString(5)%>">	
<%             
    			out.println(rs.getString(2));    		    		    		
%>
    	 		</a></td><td align="left">    			
<%			 
				out.println(rs.getString(3));  
%>
				</a></td><td align="left">    			
<%			 
				out.println(rs.getString(4));  
%>
				</a></td><td align="left">    			
<%			 
				String msg1= rs.getString(5); 
                if(msg1.equals("0")){   
           			out.println("No");
           		}
           		else{
           			out.println("Yes");
           		}				
%>
				</a></td><td align="right"><a  href="GroupItemDetailsForm.jsp?ig_code=<%=rs.getString(2)%>">	
				    			
<%			 
				out.println(rs.getString(1));  
%>			    </td>
				<td></td>
			    </tr>
			
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
</tbody>
</table>
			