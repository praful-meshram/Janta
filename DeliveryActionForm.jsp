<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<%
boolean flag1 = true;
try{
	if(request.getParameter("backPage").equals("ReceivePayment.jsp"))
		flag1 = false;
} catch (Exception e){
	System.out.print("Flag exp : ");
	//e.printStackTrace();
}
if(flag1){
%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="DeliveryActionForm.jsp" />	
</jsp:include> --%>

<%@ page errorPage="ErrorPage.jsp?page=DeliveredActionForm.jsp" %>

	<%
	session.getAttribute("UserName").toString();
	System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
		
		%>

<%
}
%>
<%@page contentType="text/html"%>
<script src="js/lastOrderDetails.js"></script>
<%
	String code,desc,status_code_value="TRANSIT",statusCode="",actionValue="";
	String[] actionValueArray=null;
  	String name="";
  	String custCode="";
  	String phno="";
  	String area="";
  	String add1="";
  	String add2="";
  	String orderNo="";
  	orderNo=request.getParameter("orderNo");
  	String orderDate="";
  	String status="";
  	String d_name="";
  	String d_code="";
  	String payment_type_desc="";
  	String totalItems="";
  	String deliveryBalance="";
  	float totalValue=0.0f;
  	float change=0.0f;
  	float balance=0.0f;
  	float advance=0.0f;
  	float discount=0.0f;
  	float paid_amt=0.0f;
  	float expected_amt=0.0f;
  	float other_charges=0.0f;
  	float sum = totalValue + change;
	float comm_amt=0.0f;
  	order.ManageOrder mo;
	mo = new order.ManageOrder("jdbc/js");
	mo.getOrderDetails(orderNo);
	
	while(mo.rs.next()){	
		custCode = mo.rs.getString("custcode");
	  	name = mo.rs.getString("custname");
	  	phno = mo.rs.getString("phone");
	  	area = mo.rs.getString("area");
	  	add1 = mo.rs.getString("add1");
	  	add2 = mo.rs.getString("add2");
	  	orderDate= mo.rs.getString("order_date");
	  	status= mo.rs.getString("status_code");
	  	d_name= mo.rs.getString("dstaff_name");
	  	d_code= mo.rs.getString("dstaff_code");
	  	totalItems= mo.rs.getString("total_items");
	  	totalValue=mo.rs.getFloat("total_value");
	 	change=mo.rs.getFloat("change_amt");
	  	balance = mo.rs.getFloat("balance_amt");
	  	advance = mo.rs.getFloat("advance_amt");
	  	discount = mo.rs.getFloat("discount_amt");
	 	sum = balance + change;
	 	payment_type_desc = mo.rs.getString("payment_type_desc");
	 	paid_amt = mo.rs.getFloat("paid_amt");
	 	expected_amt = mo.rs.getFloat("expected_amt");
	 	other_charges = mo.rs.getFloat("other_charges"); 
	 	comm_amt= mo.rs.getFloat("ord_comm_amt"); 	
	}
	mo.closeAll();

%>
<form name="myform" method="post" class="ddm1" id="form1">
	<%
		if(flag1){
	%>
	<br/>
	<div style="border: 1px solid black; width: 90%;">
	<%}else{ %>
	<div style="display:none;">
	<%} %>
	<table  style=" font-family: arial;">
	<tr align="left">
    	<th><font color="blue">Current Status :</font></th>
    	<th><label id='status' ></label></th>
    	<td colspan=4></td>
    	<th><font color="blue">Next Action :</font></th>
    	<th><label id='action' ></label></th>
    </tr>
	</table>

	<table  style="width:100%; font-family: arial;"> 
		<tr align="left">
			<td align="left" valign="top">
				    		<table id="1" style="border: 1px solid black;width: 100%;">
								<tr><th colspan="5" align="center"><u>Customer Information</u></th></tr>
								<tr>
									<td><b>Cust Code</b></td>
									<td>: <%=custCode%></td>
									<td></td>
									<td><b>Area</b></td>
									<td>: <%=area%> </td>
						
								</tr>
								<tr>
									<td><b>Cust Name</b></td>
									<td>: <%=name%></td>
									<td></td>
									<td><b>Address 1</b></td>
									<td>: <%=add1%></td>
								</tr>
								<tr>
									<td><b>Phone</b></td>
									<td>: <%=phno%></td>
									<td></td>
									<td><b>Address 2</b></td>
									<td>: <%=add2%></td>
								</tr>
								<tr>
									<th colspan="5" align="center"><hr></th>
								</tr>
								<tr>
									<th colspan="5" align="center"><u>Order Information</u></th>
								</tr>
								<tr></tr>
								<tr>	
									<td><b>Order Num</b></td>
									<td>: <%=orderNo%></td>	
									<td></td>
									<td><b>Order Date</b></td>
									<td>: <%=orderDate%></td>
								</tr>
								<tr>				
									<td><b>Total Items</b></td>
									<td>: <label id='totalItem' ></label></td>	
									<td></td>
									<td><b>Payment Type</b></td>
									<td>: <label id='paymentdiv' ></label></td>
								</tr>
								<tr>	
									<td><b>Total Value</b></td>
									<td>: <label id='totalValue' ></label></td>
									<td></td>
									<td><b>Commission :</b></td>
									<td id="comm"><%=comm_amt%></td>
									<td style="display: none;"><input type="text" name="comm1" value="<%=comm_amt%>"/></td>
								</tr>
								<tr>	
									<td><b>Less Discount</b></td>
									<td>: <%=discount%></td>
									<td></td>
									<td><b>Less Advance</b></td>
									<td>: <%=advance%></td>
								</tr>
								<tr>	
									<td><b>Balance</b></td>
									<%
									if(other_charges > 0){
									%>			
									<td>: <font color="red"><label id='balanceValue' ></label></font><font color="blue">, Other Charges : <%=other_charges%></font></td>
									<%			
									}else if(other_charges <=0){
									%>
									<td>: <font color="red"><label id='balanceValue' ></label></font></td>
									<%
									}
									%>	
									<td></td>	
									<td><b>Change</b></td>
									<td>: <label id='changeAmt' ></label></td>						
								</tr>
								<tr>
									<td><b>Exp Amount </b></td>
									<td>: <label id='expamtdiv' ></label></td>
									<td></td>
								<td><b>Paid Amount </b></td>
								<%
								if(payment_type_desc.equals("Cash") || payment_type_desc.equals("Cheque")){
								%>
								<td> :<input type="text" name="paidamt" size="5" disabled value='<%=paid_amt%>'></td>
								<%
								}else {
									if(flag1){
								%>	
								<td> :<input type="text" name="paidamt" size="5" value='' ></td>
								<%	
									} else{
								%>
								<td> :<input type="text" name="paidamt" size="5" value='<%=other_charges%>' ></td>
								<%
									}
								}
								%>
							</tr>
							<tr>	
								<td><b>Remark </b></td>
								<%
								if(flag1){
								%>	
								<td>:<input type="text" name="remark" size="20" value='' ></td>
								<%
								} else{
								%>
								<td>:<input type="text" name="remark" size="20" value="By receive Payment" ></td>
								<%
								}
								if(payment_type_desc.equals("Credit") || payment_type_desc.equals("Hawala")){
								%>	
								<td></td>			
								<td ><b>Cheque </b></td>				
								<td ><input type="CHECKBOX" name="chckchq" value=''  onclick="SelectCheque();"></td>
								<%
								}
								%>				
							</tr>	
							<%	
								Connection conn=null;
								Statement stmt=null,stat=null;
								ResultSet rs=null,rs1=null;
								try {
									Context initContext = new InitialContext();
									Context envContext  = (Context)initContext.lookup("java:/comp/env");
									DataSource ds = (DataSource)envContext.lookup("jdbc/js");
									conn = ds.getConnection();
									stmt = conn.createStatement();	
									//stat = conn.createStatement();			
									rs = stmt.executeQuery("SELECT status_code, allow_action FROM status where status_code='"+status_code_value+"'");
							%>
							<tr>	
								<td><b>Del Person </b></td>
								<td>: <%=d_name%></td>
								<td></td>
								<td><b>Allow Action </b></td>
								<td>:<SELECT name="allow_action" >
										<OPTION VALUE="" >Select action</OPTION>
										<%
										while(rs.next()){
											statusCode=rs.getString(1);
											actionValue=rs.getString(2);
										}
										actionValueArray=actionValue.split(",");
										for(int index=0; index<actionValueArray.length; index++){
											if(index==0 && !flag1){
												System.out.println(" index "+index+"\n actionValueArray "+actionValueArray[index]);
											%>
											<OPTION VALUE="<%= index%>" selected="selected"><%= actionValueArray[index]%></OPTION>	
											<%
											} else{
												System.out.println(" index "+index+"\n actionValueArray "+actionValueArray[index]);
											%>
											<OPTION VALUE="<%= index%>"><%= actionValueArray[index]%></OPTION>
											<%
											}
										}
										
									    conn.close();
									    rs.close();
									    stmt.close();
									  }
									  catch (Exception e) {
									    conn.close();
									    rs.close();
									    stmt.close();
								        e.getMessage();
								        e.printStackTrace();
								      }    
									%>		
								</SELECT>
							</td>
						</tr>
					</table>
				</td>
				<%
				if(flag1){
				%>	
				<td align=left valign="top">			
					<div id="OrderHistory" class="ddm1"> </div> 
				</td>		
				<%
				} else{
				%>
				<td align=left valign=top>			
					<div id="OrderHistory" class="ddm1"  style="display:none;"> </div> 
				</td>
				<%
				}
				%>
			</tr>
		</table>		
	</div>
	<br/>
	
	
	<div id="txtHint" class="ddm1" style="background-color: white;">	</div>
	<p><div id="waitMessage"  style="cursor: sw-resize"></div></p>
 	<hr><br>
 	<input type="hidden" name="horderNo" value="<%=orderNo%>">
 	<input type="hidden" name="horderDate" value="<%=orderDate%>"> 	
 	<input type="hidden" name="hstatus" value="<%=status%>">
 	<input type="hidden" name="d_staff" value="<%=d_code%>">
	<input type="hidden" name="hsum" value="<%=sum%>"> 	
	<input type="hidden" name="hicodearray" value=""> 	
	<input type="hidden" name="htotalitems" value="<%=totalItems%>"> 
	<input type="hidden" name="hretitem" value="0"> 	
	<input type="hidden" name="htotalvalue" value="0"> 
	<input type="hidden" name="hitemtaken" value="0"> 
	<input type="hidden" name="hretmrp" value="0"> 
	<input type="hidden" name="hpagename" value="DeliveryActionForm"> 
	<input type="hidden" name="hchange" value="<%=change%>"> 					
	<input type="hidden" name="hsplitflag" value="0"> 		
	<input type="hidden" name="hallowaction" value="">	
	<input type="hidden" name="hafterretcomm" value="0">	
	<input type="hidden" name="hCheckChanged" value="No">
	<input type="hidden" name="htotalmrp" value="0">
	<input type="hidden" name="holdItems" value="">
	<%if(flag1){ %>
	<input type="hidden" name="hbalanceAmt" value="<%=expected_amt%>">
	<input type="hidden" name="back_page" value="TrackingForm.jsp">
	<input type="hidden" name="cust_code" value="">
	<%}else{
	%>
	<input type="hidden" name="hbalanceAmt" value="<%=expected_amt - change%>">
	<input type="hidden" name="back_page" value="<%=request.getParameter("backPage")%>">
	<input type="hidden" name="cust_code" value="<%=request.getParameter("cust_code")%>">
	<%
	} %>
	<input type="hidden" name="hpaid_amt" value="0">
	
	<input type="hidden" name="hqtyArray" value="0">
	<input type="hidden" name="hpriceArray" value="0">
	<input type="hidden" name="hentryArray" value="0">
	<input type="submit" name="Submit"  disabled accesskey="s" onClick=" checkField();return false; " value="Save <Alt+s>"/>
<%
	if(flag1){
	%>
	<input type="reset" name="clear" accesskey="r" value="Clear <Alt+r>">
	<INPUT type=BUTTON value="Cancel <Alt+c>" accesskey="c" onClick="showMsg();"></center>
	<%
	}else{
	%>
	<INPUT type=BUTTON  accesskey="c" onClick="javascript:window.location ='<%= request.getParameter("backPage")%>?cust_code=<%=request.getParameter("cust_code")%>'" value="Cancel <Alt+c>">
	<%} %>
	
</form>
<script type="text/javascript">	
		//document.myform.paidamt.focus();	
		if("<%=payment_type_desc%>"=='Credit' || "<%=payment_type_desc%>"=='Hawala')
			document.myform.paidamt.focus();
		document.onkeydown = checkKey;
		document.onclick = checkKey;
		function checkKey() {
			document.myform.Submit.disabled=false;			
		}
		function checkField(){	
			//alert("submit ") 
			
			checkreturnedItem();
			
			temp=document.myform.hicodearray.value.split(',');			
			var paidamt  = document.myform.paidamt.value;	
			var allow_action = document.myform.allow_action.value;	
			var allow_actionnm = document.myform.allow_action[document.myform.allow_action.selectedIndex].text;				
			document.myform.hallowaction.value=allow_actionnm;	
			document.myform.hafterretcomm.value=document.getElementById("comm").innerHTML;
			document.myform.htotalmrp.value = document.getElementById("totMrp").innerHTML;
			document.myform.hchange.value=document.getElementById("changeAmt").innerHTML;
			document.myform.hbalanceAmt.value=document.getElementById("balanceValue").innerHTML;
			//document.myform.hexpectedAmt.value=document.getElementById("expamtdiv").innerHTML;						
			
			var remark  = document.myform.remark.value;
			
			if(paidamt==""){//} && allow_actionnm=="Delivery Done") {
					alert("Please Enter Paid Amount ");
					document.myform.paidamt.focus();
					return false;
			}
			else if(paidamt>parseFloat(document.getElementById("expamtdiv").innerHTML)) 
				alert("Paid amount should not be greater than expected amount");			
/*			
			else if(parseInt(document.getElementById("totalItem").innerHTML)<=0)
				alert("Order with zero items cannot be delivered");	
*/		
			else if(allow_action=="") {
					alert("Please Select Allow action");
					document.myform.allow_action.focus();
					return false;
			}	

			else if(isNaN(paidamt)) {
				alert("Please Enter a number in Pai amount field");
				document.myform.paidamt.value="";
				document.myform.paidamt.focus();
				return false;
			}
				
			//else if(paidamt != <%=sum%>){		
				
				else if(parseFloat(paidamt) != parseFloat(document.getElementById("expamtdiv").innerHTML)){									
				if(remark==''&& allow_actionnm=="Delivery Done")
					alert("Please fill the remark field");					
				else if(remark!='' && allow_actionnm=="Delivery Done"){						
					var ans=confirm("The paid amount is "+ paidamt +" instead of "+document.getElementById("expamtdiv").innerHTML +". Do you still want to change the status to Delivered? ");					
					if (ans==true ){
						var str="";
						if("<%=payment_type_desc%>"=='Credit' || "<%=payment_type_desc%>"=='Hawala')
							document.myform.paidamt.disabled=false;	
						
						document.myform.action="DeliveryAction.jsp";
						document.myform.submit();
						
					}
					else{
					  	window.refresh; 
					}
				}
				
				
				else if(remark!='' || allow_actionnm=="Hold"){				
					var ans=confirm("The paid amount is "+ paidamt +" instead of "+ document.getElementById("expamtdiv").innerHTML+". Do you still want to change the status to Hold? ");					
					if (ans==true ){
						var str="";
						if("<%=payment_type_desc%>"=='Credit' || "<%=payment_type_desc%>"=='Hawala' || "<%=payment_type_desc%>"=='Cheque')
							document.myform.paidamt.disabled=false;	
						
						document.myform.action="DeliveryAction.jsp";
						document.myform.submit();
						
					}
					else{
					  	window.refresh; 
					}
				}				
				
			}
			else{	
			
				var ans=confirm("Do you want to change the status to Delivered? ");
				if (ans==true){
					//checkreturnedItem();
					if("<%=payment_type_desc%>"=='Credit' || "<%=payment_type_desc%>"=='Hawala')
						document.myform.paidamt.disabled=false;		
					document.myform.action="DeliveryAction.jsp";
					document.myform.submit();
				}
				else{
				  	window.refresh; 
				}
			}
		}
		function showMsg(){
		  	 document.myform.action="TrackingForm.jsp";
		   	 document.myform.submit();
		}

		function func(){	
			document.getElementById("totalItem").innerHTML="<%=totalItems%>";
			document.getElementById("totalValue").innerHTML="<%=totalValue%>";
			document.getElementById("expamtdiv").innerHTML=<%=expected_amt%>;
			document.getElementById("changeAmt").innerHTML=<%=change%>;
			document.getElementById("status").innerHTML="<%=status%>";
			document.getElementById("action").innerHTML="<%=actionValue%>";
			document.getElementById("paymentdiv").innerHTML="<%=payment_type_desc%>";
			document.getElementById("balanceValue").innerHTML="<%=balance%>";
			balanceValue
			if("<%=payment_type_desc%>"=='Credit' || "<%=payment_type_desc%>"=='Hawala')
				document.myform.chckchq.checked=false;
			showHistory();
			//showHint(document.myform.hpagename.value);
			
		}
		function SelectCheque(){
			if(document.myform.chckchq.checked==true){
				document.getElementById("paymentdiv").innerHTML='Cheque';
				document.myform.hCheckChanged.value='Yes';
				document.myform.paidamt.disabled="disabled";
				document.myform.paidamt.value=document.getElementById("expamtdiv").innerHTML;
			}
			else if(document.myform.chckchq.checked==false){
				document.getElementById("paymentdiv").innerHTML="<%=payment_type_desc%>";
				document.myform.hCheckChanged.value='No';
				document.myform.paidamt.value='';
				document.myform.paidamt.disabled="";
				document.myform.paidamt.focus();
			}
		}
		window.onload= func;
   	</script>