<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.jqxgridFormat"%>
<%@page import="beans.JsonOutputBean"%>
<%@page import="beans.CustomerBean"%>
<%@page import="payment.ManagePayment"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="editCustomerDetails.jsp" />	
</jsp:include>
<%		
String call_type=request.getParameter("call_type");
//String call_type=request.getParameter("type");

System.out.println("call type "+call_type);
	if(call_type == null){
		call_type = "";
	}
	String type = request.getParameter("type");
	customer.ManageCustomer c;
	//c = new customer.ManageCustomer("jdbc/js");
	c = new customer.ManageCustomer("jdbc/re");
	
	if(type.equals("dispList")){
		JsonOutputBean jsonOutputBean = new JsonOutputBean();
		
		String hchckall="";
		hchckall=request.getParameter("hchckallStartWith");
		String fromForm="";
		fromForm=request.getParameter("fromForm");		
		String selmonth="";
		System.out.println(" hchckall "+hchckall);
		if(hchckall.equals("1")){
			c.listCustomers();
		}
		else{
			String name="";
	    	String phone="";
	    	String mobile="";
	    	String building="";
	    	String block="";
	    	String wing="";
	    	String add1="";
	    	String add2="";
	    	String custCode="";
	    	String nameString="";
	    	String c_date1="";
	    	String c_date2="";
	    	String u_date1="";    	
	    	String u_date2="";    	
	    	String city="", state="", area="";
	    	String building_no="", station="";
	    	String ordernumber = "";
	    	
	  		 //name=request.getParameter("name");
			name=request.getParameter("nameStartWith");
		
			phone=request.getParameter("phStartWith"); 
			building=request.getParameter("bldgStartWith");
			building_no=request.getParameter("bldgnoStartWith");
			block=request.getParameter("blockStartWith");
			wing=request.getParameter("wingStartWith");
			add1=request.getParameter("add1StartWith");
			add2=request.getParameter("add2StartWith");
			custCode=request.getParameter("custCodeStartWith");
			nameString=request.getParameter("nameStringStartWith");
			c_date1=request.getParameter("c_date1StartWith");
			c_date2=request.getParameter("c_date2StartWith");
			u_date1=request.getParameter("u_date1StartWith");
			u_date2=request.getParameter("u_date2StartWith");
			area=request.getParameter("areaStartWith");
			station=request.getParameter("stationStartWith");
			selmonth = request.getParameter("selmonth");
			String payment = request.getParameter("payment");
			mobile = request.getParameter("moStartWith");
			if(request.getParameter("ordernumber") != null){
				ordernumber = request.getParameter("ordernumber");
			}
			System.out.println(name +"c_date1 "+c_date1+" u_date1 "+u_date1+" nameString "+nameString);
			System.out.println("c_date2 "+c_date2+" u_date1 "+u_date2);
			c.listCustomerWithDate(name, phone, building, building_no, block, wing, add1, add2, custCode, 
					c_date1, c_date2, u_date1, u_date2,nameString, area, station,selmonth,payment,mobile,
					call_type,ordernumber); 
	}
		if(call_type.equals("search_payment")){
		%>	
		<div style="width:100%;">
			<input type= "checkbox" id="respective_check" style="float: left; margin-left: 1%;px;"/>
			<font style="float: left; color: red;">Select Other Order of same customer</font>
		</div>
		<br/>
		<br/>
		<%} 
				
 				/* jsonOutputBean.getFormat().add(new jqxgridFormat("Cust Code","custcode"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Cust Name","custname"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Phone","phone"));
				jsonOutputBean.getFormat().add(new jqxgridFormat("Mobile","mobile1")); */
			%>
				<table style="text-align: left;border-collapse: collapse;width: 100%;" border="1">
					<thead>
						<tr><%if(call_type.equals("communication") || call_type.equals("search_payment") || call_type.equals("receive_payment")){
							out.print("<td>Cust Code</td>");
						} else
							out.print("<td>Cust Code</td>");
						%>
							
							<td>Cust Name</td> 
							<td>Phone</td>
							<td>Mobile</td>
						
			<%
				
				
				if(call_type.equals("communication")){
			/* 		jsonOutputBean.getFormat().add(new jqxgridFormat("Contact Date","contactDate"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Commit Date","commitDate")); */ 
					%>
						<td>Contact Date</td>
						<td>Commit Date</td>
					<%
				}else{
			/* 		jsonOutputBean.getFormat().add(new jqxgridFormat("Building","building"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Flat No.","building_no"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Area","area"));  */
					%>
					<td>Building</td>
					<td>Flat No.</td>
					<td>Area.</td>
					<%
				}
				if(call_type.equals("search_payment") || call_type.equals("communication")){
					
					/* jsonOutputBean.getFormat().add(new jqxgridFormat("Order Number","order_number"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Date","orderdate"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Del Date ","del_date"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Balance","balance"));  */
					
					%>
					<td>Order Number</td>
					<td>Date </td>
					<td>Del Date</td>
					<td>Payment Type</td>
					<td>Balance</td>
					<%	
				}else{
					/*  jsonOutputBean.getFormat().add(new jqxgridFormat("Create Date","create_datetime"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Update Date","update_datetime"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Payment Type ","payment_type"));  */
					%>
					<td>Create Date</td>
					<td>Update Date </td>
					<td>Payment Type</td>
					<%if(call_type.equals("receive_payment")){
					%>
					<td>Balance</td>
					<%	}
			}
				if(selmonth !=null && selmonth !=""){				
					/*  jsonOutputBean.getFormat().add(new jqxgridFormat("Last Order No.","last_order_num"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Last Order Date","last_order_date"));
					jsonOutputBean.getFormat().add(new jqxgridFormat("Days ","DATEDIFF"));  */
					%>
					<td>Last Order No.</td>
					<td>Last Order Date</td>
					<td>Days</td>
					
					<%	
				}
		%>		</tr>
				</thead>
				<tbody>
		<%
		int count = 0;
		//ArrayList<CustomerBean> listOutputBeans = new ArrayList();
    	while(c.rs.next()) {
    		//CustomerBean outputBean = new CustomerBean();
    		%>
    		<tr id="tr_<%=count%>" onmouseover="onMouseOver(this);" onmouseout="onMouseOut(this);" style="cursor: pointer;">
    		<%
       		String custCodeLink=null;
			if(fromForm.equals("CustPmtHstry")){
			custCodeLink = 	"<a href=\"editCustPaymentHistoryForm.jsp?name="+c.rs.getString(1)+"&cuscode="+c.rs.getString(8)+"\" >";
			%>
			
			<td><%=custCodeLink+c.rs.getString(8)+"</a>"%></td>
			<%
			}else if(call_type.equals("search_payment") || call_type.equals("communication")){
		/* 	custCodeLink="<input id='ch_"+count+"' type='checkbox' name =selected_cust value='true' "+
							"onclick=selectCustomer('ch_"+count+"','tr_"+count+"','"+c.rs.getString(8)+"','"+c.rs.getString("order_number")+"','"+c.rs.getString(1)+
							"','"+c.rs.getFloat("balance")+"')/>"; */
			custCodeLink=c.rs.getString(8);				
							
							
			if(call_type.equals("search_payment")){
					custCodeLink="<input id=ch_"+count+" type='checkbox' name =selected_cust value='true' "+
							"onclick=\"selectCustomer('ch_"+count+"','tr_"+count+"','"+c.rs.getString(8)+"','"+c.rs.getString("order_number")+"','"+c.rs.getString(1)+
							"','"+c.rs.getFloat("balance")+"')\"/>"+c.rs.getString(8)+"</a>";
							
				} 
		
				%>
						<%-- <td><%=custCodeLink+c.rs.getString(8)+"</a>"%></td> --%>
						<td><%=custCodeLink%></td>
				<%	
			}else if(call_type.equals("receive_payment")){
				%>
				
				<td><%=c.rs.getString(8)+"</a>"%></td>
			<%	

			}else{
				custCodeLink="<a href=\"editCustomerForm.jsp?name="+c.rs.getString(1)+"&tele="+c.rs.getString(2)+"&bldg="+c.rs.getString(3)+"&block="+c.rs.getString(4)+
				"&wing="+c.rs.getString(5)+"&add1="+c.rs.getString(6)+"&add2="+c.rs.getString(7)+"&cuscode="+c.rs.getString(8)+"&area="+c.rs.getString(11)+"&station="+
				c.rs.getString(16)+"&pincode="+c.rs.getString(12)+"&city="+c.rs.getString(13)+"&state="+c.rs.getString(14)+"&building_no="+c.rs.getString(15)+
				"&payment="+c.rs.getString(18)+"&mobile="+c.rs.getString(17)+"\">";
				%>
				
				<td><%=custCodeLink+c.rs.getString(8)+"</a>"%></td>
			<%
			}
			//outputBean.setCustcode(custCodeLink+c.rs.getString(8)+"</a>");
			
			if(call_type.equals("communication")){
				//outputBean.setCustname("<font color=blue style=\"cursor: pointer;\" onclick=\"dispCommForm('"+c.rs.getString(8)+">')\"><u>"+c.rs.getString(1)+"</u></font>"); 
				%>
					<td><font color=blue style="cursor: pointer;" onclick="dispCommForm('<%=c.rs.getString(8)%>')"><u><%=c.rs.getString(1) %></u></font></td>
				<%
			}else{
				//outputBean.setCustname(c.rs.getString(1));
				%>
				<td><%=c.rs.getString(1) %></td>
				<%
			}
			/* outputBean.setPhone(c.rs.getString(2));
			outputBean.setMobile1(c.rs.getString(17)); */
			%>
				<td><%=c.rs.getString(2) %></td>
				<td><%=c.rs.getString(17) %></td>
				
			<%
			if(call_type.equals("communication")){
				//ManagePayment mp = new ManagePayment("jdbc/js");
				ManagePayment mp = new ManagePayment("jdbc/re");
				mp.getLastCommDetail(c.rs.getString(8));
				if(mp.rs.next()){
				/*  outputBean.setContactDate(mp.rs.getString(1));
				outputBean.setCommitDate(c.rs.getString(2));  */

				%>
				<td><%=mp.rs.getString(1) %></td>
				<td><%=mp.rs.getString(2) %></td>
				
				<%
				
				} else {
			/* 		 outputBean.setContactDate("--");
					outputBean.setCommitDate("--");  */
					%>
					<td style="text-align: center;">--</td>
					<td style="text-align: center;">--</td>
					
					<%
				}
				mp.closeAll();
			}else{
/* 			 outputBean.setBuilding(c.rs.getString(3));
			outputBean.setBuilding_no(c.rs.getString(15));
           outputBean.setArea(c.rs.getString(11));  */
           %>
			<td><%=c.rs.getString(3) %></td>
			<td><%=c.rs.getString(15) %></td>
			<td><%=c.rs.getString(11) %></td>
			
			<%
			
			}
			if(call_type.equals("search_payment") || call_type.equals("communication")){
			

				/*  outputBean.setOrder_number(c.rs.getString("order_number"));
				outputBean.setOrderdate(c.rs.getString("orderdate"));	 
				outputBean.setDel_date(c.rs.getString("del_date"));	 */
				%>
				<td><%=c.rs.getString("order_number") %></td>
				<td><%=c.rs.getString("orderdate") %></td>
				<td><%=c.rs.getString("del_date") %></td>
				
				<%
				
			}else{
			/* outputBean.setCreate_datetime(c.rs.getString(9));	
          	outputBean.setUpdate_datetime(c.rs.getString(10));   */
          	%>
			<td><%=c.rs.getString(9) %></td>
			<td><%=c.rs.getString(10) %></td>
			
			
			<%
			}
           	String paytype=c.rs.getString(18);
           	//outputBean.setPayment_type(paytype);
           String	typedesc = c.getpaytype(paytype);
           	if(paytype.equals("")){
           		paytype = "NO TYPE";
           	 	//outputBean.setPayment_type("NO TYPE");
           	 %>
 			<td><%="NO TYPE"%></td>
 			
 			
 			<%
           		
           	}else{
           		%>
           		<td><%=typedesc%></td>
           		<%
           	}
			if(call_type.equals("receive_payment")){
				//outputBean.setBalance("<a href=\"ReceivePayment.jsp?cust_code="+c.rs.getString(8)+"\">"+c.rs.getFloat("balance")+"</a>");
				 %>
		 			<td><a href="ReceivePayment.jsp?cust_code_=<%=c.rs.getString(8)%>"><%=c.rs.getFloat("balance") %></a></td>
		 			
		 			
		 			<%
			}else if(call_type.equals("search_payment") || call_type.equals("communication")){
			//outputBean.setBalance((c.rs.getFloat("balance")+"").trim());
			 %>
	 			<td><%=(c.rs.getFloat("balance")+"").trim()%></td>
	 			
	 			
	 			<%
			}else{
				//String typedesc =null;
		
			if(paytype.equals("NO TYPE")){
				typedesc = "NO TYPE";
				
			}else{
				typedesc = c.getpaytype(paytype);
           		
           	}
			//System.out.println("typedesc "+typedesc);
			//outputBean.setPayment_type("<a href=\"JavaScript:dispDiv('"+c.rs.getString(8)+"','"+c.rs.getString(1)+"','"+paytype+"','"+c.rs.getString(11)+"');\">"+typedesc+"</a>");
			String a = "<a href=\"JavaScript:dispDiv('"+c.rs.getString(8)+"','"+c.rs.getString(1)+"','"+paytype+"','"+c.rs.getString(11)+"');\">"+typedesc+"</a>";
			%>
 			<%-- <td><%=a %></td> --%>
 			
 			<%
			}

				if(selmonth !=null && selmonth !=""){	
					/* outputBean.setLast_order_num(c.rs.getString(19));
					outputBean.setLast_order_date(c.rs.getString(20));
					outputBean.setDATEDIFF(c.rs.getString(21)); */
					%>
		 			<td><%=c.rs.getString(19) %></td>
		 			<td><%=c.rs.getString(20) %></td>
		 			<td><%=c.rs.getString(21) %></td>
		 			
		 			<%
				}
				
	count++;
	//listOutputBeans.add(outputBean);
	}    
    //jsonOutputBean.setOutputData(listOutputBeans);	
    
    //System.out.println(new Gson().toJson(jsonOutputBean));
    //out.println(new Gson().toJson(jsonOutputBean));
    	
%>
</tbody>
</table>
		
			</div>
			<ceneter> <div id="dispdiv" align="center" style="border:1px solid black; padding:25px; text-align:center; display:none; background-color:#FFF; overflow:auto; height:300px; width=200px;"> </div></center>
	        <input type="hidden" id="rows" name="rows" value="<%=count%>"/>	  

<%		
	}else if(type.equals("dispDiv")){
	  String custcode = request.getParameter("custcode");
	  String custname = request.getParameter("custname");
	  String payment =  request.getParameter("payment");	
	  String area=  request.getParameter("area");
	    
%>	  <div style="z-index: 1000">
	  <table style="z-index: 1000">
	  	<tr><td><b>Customer Code </b> &nbsp;: &nbsp; <%= custcode%></td>
	  	<td><b>Customer Name</b> &nbsp;: &nbsp; <%= custname%></td>
		<td><b>Payment Type</b>   &nbsp;:&nbsp; <select name="selpay" id="selpay1" >
<% 	
			if(payment.equals("NO TYPE")){
%>
				<option value="select"> Select Type</option>
<%			}		
				c.disppaytype();
				while(c.rs1.next()){
				
 			 if(c.rs1.getString(1).equals(payment)){%>
				<option selected value="<%=c.rs1.getString(1)%>"><%=c.rs1.getString(2)%></option>
<%			}%>				
				<option value="<%=c.rs1.getString(1)%>"><%=c.rs1.getString(2)%></option>
<%			 }%>
	  		</select></td>
	  	</tr>
	  	<tr><td colspan="3">
	  		<div style="overflow:auto; height:200px;">
	  		<table  border="1" id="id" class="item3" align="center" width="100%">  
				<th colspan="10"><b>Order Details</b></th>
		      	<tr>				
					<td width="10%"><b>Order Number</b></td>				
					<td width="10%"><b>Order Date</b></td>
					<td width="10%"><b>Total Items</b></td>
					<td width="10%"><b>Total Values</b></td>
					<td width="10%"><b>MRP</b></td>
					<td width="10%"><b>Discount</b></td>
					<td width="10%"><b>Balance Amount</b></td>
					<td width="10%"><b>Payment Type</b></td>
					<td width="10%"><b>Last Modified Date</b></td>
					<td width="5%"><b>Status </b></td>
			</tr>
<%	
		c.getcustDetails(custcode);
			String orderno,orderdt,totalitem , paymenttype,lastdt,status;
			float totval,mrp,dis,bal;
			float sumval=0.0f,summrp=0.0f,sumdis=0.0f,sumbal=0.0f;
    	while(c.rs.next()) {
    	   orderno = c.rs.getString(1);
    	   orderdt= c.rs.getString(2);
    	   totalitem = c.rs.getString(3);
    	   totval=c.rs.getFloat(4);
    	   mrp=c.rs.getFloat(5);
    	   dis=c.rs.getFloat(6);
    	   paymenttype= c.rs.getString(7);
    	   lastdt= c.rs.getString(8);
    	   status= c.rs.getString(9);
    	   bal =  c.rs.getFloat(10);    	   
    	   
    	   sumval = sumval + totval;
    	   //summrp = summrp = mrp;
    	  // sumdis = sumdis + dis;
    	   sumbal = sumbal +bal;
%>
			<tr id="tr"><td align="left" width="10%">
<% out.println(c.rs.getString(1));%>
			</td><td align="left" width="10%">
<% out.println(c.rs.getString(2));%>
			</td><td align="right" width="10%">
<% out.println(c.rs.getString(3));%>
			</td><td align="right" width="10%">
<% out.println(c.rs.getString(4));%>
			</td><td align="right" width="10%">
<%	out.println(c.rs.getString(5));%>       
			</td><td align="right" width="10%">
<%	out.println(c.rs.getString(6));%>       
			</td><td align="right" width="10%">
<%	out.println(c.rs.getString(10));%>       
	    	</td><td align="left" width="10%">
<%	out.println(c.rs.getString(7));%>       
			</td><td align="left" width="10%">
<%	out.println(c.rs.getString(8));%>       
			</td><td align="left" width="10%">
<%	out.println(c.rs.getString(9));%>       
			</td></tr>						        	  
<%		}%>

<tr id="tr"><td align="left" width="10%">
			</td><td align="right"  width="10%">
			</td><td align="right" width="10%"><b>Total :</b>
			</font></td><td align="right" width="10%"><font color="red">
<% out.println(sumval);%>
			</font></td><td align="right" width="10%"><font color="red">     
			</font></td><td align="right" width="10%">
			</td><td align="right" width="10%"> <font color="red">
<%	out.println(sumbal);%>       
			</font>     
	    	</td><td align="left" width="10%"> 
			</td><td align="left" width="10%">     
			</td><td align="left" width="10%">
			</td></tr>			    
	  	</table> </div> 	
	  	</td></tr>
	  	<tr><td align ="center" colspan="3"><input type="button" value="Save Payment Type" onclick="funsave('<%= custcode%>','<%= custname%>');return false;"><input type="button" name="return" value="Close" onclick="funclose();"></td></tr>
	  </table>
	  </div>
	  
<%
	}else if(type.equals("savepay")){
	
		 String custcode = request.getParameter("custcode");	
		 String custname = request.getParameter("custname");  
	 	 String payment =  request.getParameter("payment");
	 	// System.out.println(custcode+payment);
	 	 int ans = c.savePaymentType(custcode,payment);
	 	 if(ans == 1){
	 	 	String typedesc = c.getpaytype(payment);
%>
		Added Payment Type <%=typedesc  %> for <%= custcode %> ,<%= custname %> 
<%
	 	 }else{
%>
		<center> Error</center>
<%
	 	 }
	}
	c.closeAll();
%>

