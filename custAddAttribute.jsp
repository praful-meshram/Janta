<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>


<%		
		customer.ManageCustomer c;
		c = new customer.ManageCustomer("jdbc/js");
		
		int language_code=0;
    	String mobile="";
    	String email="";
    	String dob="";
    	String marital_status="";
    	String spouse_name="";
    	String spouse_dob="";    	
    	String marr_ann="";
    	int totalmemb=0;
    	String grocery_name="";
    	
    	int occu_code=0;    	
    	String work_name="";  
    	String work_add1="",work_add2="";  	
    	String work_city="", work_state="", work_pincode="";
    	String work_country="",work_tel="",work_fax="";
   
 		String custCode="";
 		custCode=request.getParameter("custCodeStartWith");
 		//System.out.println("custcode"+custCode);
		c.listCustomerAttribute(custCode); 
		
		while(c.rs.next()) {
		
			language_code = c.rs.getInt(1);
			custCode = c.rs.getString(2);
			mobile = c.rs.getString(3);		
			email = c.rs.getString(4);
			dob = c.rs.getString(5);
			marital_status = c.rs.getString(6);		
			spouse_name = c.rs.getString(7);
			spouse_dob = c.rs.getString(8);
			marr_ann = c.rs.getString(9);		
			totalmemb = c.rs.getInt(10);
			grocery_name = c.rs.getString(11);
			occu_code = c.rs.getInt(12);
			work_name = c.rs.getString(13);
			work_add1 = c.rs.getString(14);
			work_add2 = c.rs.getString(15);
			work_city = c.rs.getString(16);
			work_state = c.rs.getString(17);
			work_pincode= c.rs.getString(18);
			work_country = c.rs.getString(19);
			work_tel = c.rs.getString(20);
			work_fax = c.rs.getString(21);
			
			if(dob.equals("null")){
				dob ="";
			}
			if(spouse_dob.equals("null")){
				spouse_dob ="";
			}
			if(marr_ann.equals("null")){
				marr_ann ="";
			}
		
		}
			c.closeAll();
		try {
		
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			Connection conn = ds.getConnection();
		
%>		  	
 		
	<fieldset><legend>Customer Additional Attributes:</legend><table border="0">
		<tr>
			<td ><b>Language  Code</b></td><td>
<%
		String name ,code;
		Statement stmt = conn.createStatement();		
		ResultSet rs = stmt.executeQuery("select code, value from code_table where category='Language'");
					
%>
					<center>
						<SELECT name="language_code" align="left">						
<%			if(language_code == 0){
%>
					<OPTION VALUE="0"  selected> Select language
<%		}    
	
 		while (rs.next()) {
 			code = rs.getString(1);
 			name = rs.getString(2);
 			int tempcode = Integer.parseInt(code);
 			if(tempcode == language_code){		
 				System.out.println(code+","+language_code);	
 			
%>
								<OPTION VALUE="<%=code%>" seleted > <%= name%> 
<%			}else{
%>	
					<OPTION VALUE="<%=code%>" > <%= name%> 
					
<%			}
		}
%>			
			
			</td>
			<td ><b>Mobile Number</b></td><td><input type="text" name="mobile" value="<%=mobile%>"></td>
		</tr>
		<tr>
			<td ><b>Email ID</b></td><td><input type="text" name="email" value="<%=email%>"></td>
			<td ><b>Date Of Birth</b></td><td><input type ="text" accesskey="d" name="c_date1" value ="<%=dob%>" size="15"><input type="button" onClick="c1.popup('c_date1');" value="..."/></td>
		</tr>
		<tr>
			<td ><b>Marital Status</b></td><td><input type="text" name="marital_status" value="<%=marital_status%>"></td>
			<td ><b>Marriage Anneversary</b></td><td><input type ="text" accesskey="d" name="c_date2" value ="<%=marr_ann%>" size="15"><input type="button" onClick="c1.popup('c_date2');" value="..."/></td>
		</tr>
		<tr>
			<td ><b>Spouse Name</b></td><td><input type="text" name="spouse_name" value="<%=spouse_name%>"></td>
			<td ><b>Spouse DOB</b></td><td><input type ="text" accesskey="d" name="u_date1" value ="<%=spouse_dob%>" size="15"><input type="button" onClick="c1.popup('u_date1');" value="..."/></td>
		</tr>
		<tr>
			<td ><b>No. of Persons in Family</b></td><td><input type="text" name="totalmemb" value="<%=totalmemb%>"></td>
			<td ><b>Groucery Person Name</b></td><td><input type="text" name="grocery_name" value="<%=grocery_name%>"></td>
		</tr>
		<tr><td colspan="4">
		<fieldset><legend>Work Information</legend><table>
		<tr>
			<td ><b>Occupation Code</b></td><td>
			
<%
		String name1 ,code1;
		Statement stmt1 = conn.createStatement();		
		ResultSet rs1 = stmt1.executeQuery("select code, value from code_table where category='Occupation'");
					
%>
					<center>
						<SELECT name="occu_code" align="left">
						
<%		if(occu_code == 0){
%>
					<OPTION VALUE="0" selected> Select Occupation
<%		}
    	
 		while (rs1.next()) {
 			code1 = rs1.getString(1);
 			name1 = rs1.getString(2);
 			int tempcode1 = Integer.parseInt(code1);
 			if(tempcode1 == occu_code){					
 			
%>
								<OPTION VALUE="<%=code1%>" selected > <%= name1%> 
<%			}else{
%>	
					<OPTION VALUE="<%=code1%>"> <%= name1%> 
					
<%			}
		}
		
%>			</td>
			<td ><b>Work Name</b></td><td><input type="text" name="work_name" value="<%=work_name%>"></td>
		</tr>
		<tr>
			<td ><b>Work Address1</b></td><td><input type="text" name="work_add1" value="<%=work_add1%>"></td>
			<td ><b>Work Address2</b></td><td><input type="text" name="work_add2" value="<%=work_add2%>"></td>
		</tr>
		<tr>
			<td ><b>Work city</b></td><td><input type="text" name="work_city" value="<%=work_city%>"></td>
			<td ><b>Work State</b></td><td><input type="text" name="work_state" value="<%=work_state%>"></td>
		</tr>
		<tr>
			<td ><b>Work PinCode</b></td><td><input type="text" name="work_pincode" value="<%=work_pincode%>"></td>
			<td ><b>Work Country</b></td><td><input type="text" name="work_country" value="<%=work_country%>"></td>
		</tr>
		<tr>
			<td ><b>Work Telephone</b></td><td><input type="text" name="work_tel" value="<%=work_tel%>"></td>
			<td ><b>Work Fax</b></td><td><input type="text" name="dob" value="<%=work_fax%>"></td>
		</tr>
		</table></fieldset></td></tr>


</table></fieldset>
<%
		
    	conn.close();
	}
	catch (Exception e) {
   		e.getMessage();
    	e.printStackTrace(); 
    	//conn.close();   	
	}
%>