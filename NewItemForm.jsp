<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>

<%@ page contentType="text/html"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">
	<jsp:param name="formName" value="NewItemForm.jsp" />
</jsp:include>
 --%>
 
<%@ page errorPage="ErrorPage.jsp?page=NewItemForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
 
 

<script type="text/javascript">
<%String str2 = "";
			str2 = request.getParameter("Exp");%>
	var jExp=<%=str2%>
	if(jExp==2){
		alert("Item already exists !!!");
	}
<%String backPage = "";
			backPage = request.getParameter("backPage");
			System.out.println("backPage = " + backPage);%>
	function checkField(){
		var iname =document.myform.i_name.value;
		var ibarcode = document.myform.i_barcode.value;
		var iweight =document.myform.i_weight.value;
		var imrp =document.myform.i_mrp.value;
		var irate =document.myform.i_rate.value;
		var iGroupCode =document.myform.iGroupCode.value;
		var iDealType =document.myform.iDealType.value;
		var id_qty =document.myform.id_qty.value;
		var id_amt =document.myform.id_amt.value;
		var box_qty=document.myform.box_qty.value;
		if(iGroupCode=="") {
				alert("Please Select the Item Group");
				document.myform.iGroupCode.focus();
				return false;
		}
		else if(iname=="") {
				alert("Please Enter Item Name");
				document.myform.i_name.focus();
				return false;
		}
		/*else if(ibarcode=="") {
			alert("Please Enter Item Barcode");
			document.myform.i_barcode.focus();
			return false;
		}*/
		else if(imrp=="") {
				alert("Please Enter Item MRP Value");
				document.myform.i_mrp.focus();
				return false;
		}
		else if(isNaN(imrp)) {
				alert("Please Enter a number in MRP field");
				document.myform.i_mrp.value="";
				document.myform.i_mrp.focus();
				return false;
		}
		else if(box_qty=="") {
				alert("Please Enter Box Quantity Value");
				document.myform.i_mrp.focus();
				return false;
		}
		else if(isNaN(box_qty)) {
				alert("Please Enter a number in Box Quantity field");
				document.myform.i_mrp.value="";
				document.myform.i_mrp.focus();
				return false;
		}
		else if(irate=="") {
				alert("Please Enter Item Rate");
				document.myform.i_rate.focus();
				return false;
		}
		else if(isNaN(irate)) {
				alert("Please Enter a number in Rate field");
				document.myform.i_rate.value="";
				document.myform.i_rate.focus();
				return false;
		}
		else  if (document.myform.chck.checked==true){
					
			        if(iDealType=="") {
						alert("Please Select the Deal type");
						document.myform.iDealType.focus();
						return false;
					}
					else if(id_qty=="") {
						alert("Please Enter Deal Item Qty Value");
						document.myform.id_qty.focus();
						return false;
					}
					else if(isNaN(id_qty)) {
							alert("Please Enter a number in Qty field");
							document.myform.id_qty.value="";
							document.myform.id_qty.focus();
							return false;
					}
					else if(id_amt=="") {
							alert("Please Enter Item amount");
							document.myform.id_amt.focus();
							return false;
					}
					else if(isNaN(id_amt)) {
							alert("Please Enter a number in amount field");
							document.myform.id_amt.value="";
							document.myform.id_amt.focus();
							return false;
					}	
					else if(isNaN(i_comm)) {
							alert("Please Enter a number in Commission field");
							document.myform.i_comm.value="";
							document.myform.i_comm.focus();
							return false;
					}					    
		}
		
		  document.myform.Submit.disabled = true;
			var ans=confirm("Do you want to create this Item?");
			if (ans==true){
			    
				document.myform.action="NewItem.jsp";
				document.myform.submit();
			}
			else
			 {
			  window.refresh; 
			 }
			
			
	}	
	function showMsg(){
		var backPage=document.myform.backPage.value;
		if(backPage !="ItemDetailsForm.jsp"){
	  	 document.myform.action="HomeForm.jsp";
	   	 document.myform.submit();
	   	}else{
	   		window.close();
	   	}
	}
	function CalComm(){
		var rate= document.myform.i_rate.value;
		document.myform.i_comm.value = rate * 0.01;
	}			 	
    
    function disableBoxField(){
    	var item_type = document.myform.item_type.options[document.myform.item_type.selectedIndex].value;
		if(item_type=="true"){
			document.myform.box_qty.readOnly=true;
			document.myform.box_qty.value="1";
			
		} else{
			document.myform.box_qty.value="";
			document.myform.box_qty.readOnly=false;
		}
    }
</script>
<fieldset style="width: 35%;"><legend>
	<h3>Create a New Item</h3>
</legend>
<form name="myform" action="NewItem.jsp" method="post">
	<table border="0" align="center">
		<tr>
			<td style="width: 30%;" align="left"><b>Item Group </b></td>
			<td style="width: 2%;" align="left">:</td>
			<%
				Connection conn = null;
				Statement stmt = null, stat = null;
				ResultSet rs = null, rs2 = null;
				try {
					String name, desc;
					int rowcount;
					Context initContext = new InitialContext();
					Context envContext = (Context) initContext
							.lookup("java:/comp/env");
					DataSource ds = (DataSource) envContext.lookup("jdbc/js");
					conn = ds.getConnection();
					stmt = conn.createStatement();
					rs = stmt.executeQuery("select item_group_code, item_group_desc from item_group");
			%>
			<td style="width: 40%;" align="left"><SELECT name="iGroupCode">
					<OPTION VALUE="">
						Select Group
						<%
						rowcount = 0;
							while (rs.next()) {
								name = rs.getString(1);
								desc = rs.getString(2);
								if (rowcount == 0) {
					%>
					
					<OPTION VALUE="<%=name%>"><%=desc%>
						<%
							} else {
						%>
					
					<OPTION VALUE="<%=name%>"><%=desc%>
						<%
							}
									rowcount++;
								}
								rowcount = 0;
								rs.close();
								stmt.close();
						%>
					</td>
			</SELECT>


		</tr>
		<tr></tr>
		<tr></tr>
		<tr>
			<td style="width: 25%;" align="left"><b>Item Name</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left"><input type="text" name="i_name"></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr>
			<td style="width: 25%;" align="left"><b>Item Barcode</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left"><input type="text" name="i_barcode"></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr>
			<td style="width: 25%;" align="left"><b>Item Weight</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left"><input type="text" name="i_weight"></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr>
			<td style="width: 25%;" align="left"><b>Item Type</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left">
				<select name="item_type" style="width:60%;" onchange="disableBoxField();">
					<option value="false">Single Item</option>
					<option value="true">Bachka</option>
					<option value="mixItem">Mix Item</option>
					
				</select>
			</td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr >
			<td style="width: 25%;" align="left"><b>Box Quantity</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left"><input type="text" name="box_qty" value=""></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr>
			<td style="width: 25%;" align="left"><b>Item MRP [Rs.]</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left"><input type="text" name="i_mrp"></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr>
			<td style="width: 25%;" align="left"><b>Item Rate [Rs.]</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left"><input type="text" name="i_rate" onblur="CalComm();"></td>
		</tr>
		<tr>
			<td rowspan="2" style="width: 25%;" align="left"><b>Commission Amount</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td rowspan="2" style="width: 40%;" align="left"><input type="text" name="i_comm">
				&nbsp[1% of rate]</td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr></tr>
		
		
		<tr>
			
			<td><input type="Checkbox" id="chck" value="N" size="20"
				onClick="funEnabled();"><b>&nbsp&nbsp&nbsp&nbspDeal flag</b></td>
				<td></td>
		</tr>

		<tr>

			<td colspan="4"><div id="div4" style="VISIBILITY: hidden">
					<fieldset>
						<legend>
							<font color="blue"><b>Deal</b></font>
						</legend>
						<table align="center">
							<tr>
								<td><b>Deal Type</b></td>
								<td><SELECT name="iDealType">
										<OPTION VALUE="">
											Select Type
											<%
											String name2, items = "", money = "", category = "";
												stat = conn.createStatement();
												rs2 = stat.executeQuery("select value from code_table where category='DealType'");
												while (rs2.next()) {
													name2 = rs2.getString(1);
										%>
											<OPTION VALUE="<%=name2%>"> <%=name2%> 
<%
 	}

 		rs2.close();
 		stat.close();
 		conn.close();
 	} catch (Exception e) {
 		e.getMessage();
 		e.printStackTrace();
 		rs.close();
 		stmt.close();
 		rs2.close();
 		stat.close();
 		conn.close();
 	}
 %>  			
								</select></td>
		  		</tr>
		  		<tr>
		  			<td><b>Quantity</b></td>
								<td><input type="text" name="id_qty" size="20"></td>
		  			<td><b>Amount</b></td>
								<td><input type="text" name="id_amt" size="20"></td>
		  		</tr>
		  	</table>
				</div>
		  
		</tr>			
		  	
  	</table>
  	<br>
	<center>
		<input type="submit" name="Submit" disabled value="Submit <Alt+ s>" accesskey="s" onClick="checkField();return false;">
	
<input type="reset" name="clear" accesskey="r"
												value="Clear <Alt+ r>"> <INPUT type=BUTTON
												value="Cancel <Alt+ c>" accesskey="c" onClick="showMsg();"></center>
  	<input type="hidden" name="backPage" value="<%=backPage%>">
  
  </form>
  
  </fieldset>
  <script type="text/javascript">
    document.myform.i_name.focus();
    function check(){
    		document.myform.Submit.disabled=false;
	}
	document.onkeyup = check;
	function funEnabled(){
	    if (document.myform.chck.checked==true){
			document.getElementById('div4').style.visibility="visible";
			
		}
		else{
			document.getElementById('div4').style.visibility="hidden";
			
		}
	}
			
</script>
</body>
</html>