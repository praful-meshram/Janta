<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>

<%@ page import="java.io.*"%>
<jsp:include page="header.jsp" />
<%-- <jsp:include page="sessionBoth.jsp">
	<jsp:param name="formName" value="EditItemForm.jsp" />
</jsp:include>
 --%>
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<%@ page errorPage="ErrorPage.jsp?page=EditItemForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>

<%@page contentType="text/html"%>

<%
	String i_code1 = "";
	String i_barcode1 = "";
	String ig_code1 = "";
	String i_name1 = "";
	String i_weight1 = "";
	String i_mrp1 = "";
	String i_rate1 = "";
	String id_type1 = "";
	String id_flag1 = "";
	String id_qty1 = "";
	String id_amt1 = "";
	String i_comm = "";
	String i_tickflg = "";
	String box_qty = "";

	i_code1 = request.getParameter("icode");
	i_barcode1 = request.getParameter("ibarcode");
	ig_code1 = request.getParameter("igcode");
	i_name1 = request.getParameter("iname");
	i_weight1 = request.getParameter("iweight");
	i_mrp1 = request.getParameter("imrp");
	i_rate1 = request.getParameter("irate");
	id_type1 = request.getParameter("id_type");
	id_flag1 = request.getParameter("id_flag");
	id_qty1 = request.getParameter("id_qty");
	id_amt1 = request.getParameter("id_amt");
	i_comm = request.getParameter("i_comm");
	i_tickflg = request.getParameter("i_tickflag");
	box_qty = request.getParameter("box_qty");
	String is_bachka = request.getParameter("is_bachka");
	String is_mixture = request.getParameter("is_mixture");
	System.out.println("=====\n\n111  box_qty "+ box_qty +"\t is_bachka "+is_bachka +" \t is_mixture "+is_mixture);
%>


<script type="text/javascript">

	 function disableBoxField(){
    	var item_type = document.myform.item_type.options[document.myform.item_type.selectedIndex].value;
		if(item_type=="true"){
			document.myform.box_qty.readOnly=true;
			document.myform.box_qty.value="1";
			// document.myform..readOnly=true;
			
		} else{
			document.myform.box_qty.value="";
			document.myform.box_qty.readOnly=false;
		}
    }

	function checkField(){	
		var iname =document.myform.i_name.value;
		var ibarcode = document.myform.i_barcode.value;
		var iweight =document.myform.i_weight.value;
		var imrp =document.myform.i_mrp.value;
		var irate =document.myform.i_rate.value;
		var iDealType =document.myform.iDealType.value;
		var id_qty =document.myform.id_qty.value;
		var id_amt =document.myform.id_amt.value;
		var i_comm = document.myform.i_comm.value;
		var i_tickflg =document.myform.i_tickflg.value;
		
		var item_type = document.myform.item_type.value;
		
		var ig_code;
		
		for(var i=0; i<document.myform.iGroupCode.length; i++){
			if(document.myform.iGroupCode.options[i].selected==true)
				ig_code = document.myform.iGroupCode.options[i].text;
				
		}

		if(document.myform.chck.checked==false)
			document.myform.hCheckValue.value=0;				
		if(document.myform.chck.checked==true)
			document.myform.hCheckValue.value=1;		
		
		
		if(iname=="") {
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
					else if(isNaN(id_qty)) {
							alert("Please Enter a number in Qty field");
							document.myform.id_qty.value="";
							document.myform.id_qty.focus();
							return false;
					}
					else if(isNaN(id_amt)) {
							alert("Please Enter a number inamount field");
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
		
		
		var ans=confirm("Do you want to Edit this Item?");
		if (ans==true){
			var Remark="Changed Value For : ";
			if(ig_code != document.myform.hidd_ig_code.value){
				Remark=Remark+"Item Group Code= "+ig_code;
			}
			if(iname != document.myform.hidd_i_name.value){
				Remark=Remark+"  Item Name= "+iname;
			}
			if(iweight != document.myform.hidd_i_weight.value){
				Remark=Remark+"  Item Weight= "+iweight;
			}
			if(imrp != document.myform.hidd_i_mrp.value){
				Remark=Remark+"  Item MRP= "+imrp;
			}
			if(irate != document.myform.hidd_i_rate.value){
				Remark=Remark+"  Item Rate= "+irate;
			}
			if(i_comm != document.myform.hidd_i_comm.value){
				Remark=Remark+"  Item Commission Amt= "+i_comm;
			} 
			if(i_tickflg != document.myform.hidd_i_tickflg.value){
				Remark=Remark+"  Item TickerFlag= "+i_tickflg;
			}
			
					
			
			document.myform.hidd_Remark.value=Remark;
			alert(document.myform.hidd_Remark.value);
			document.myform.action="EditItem.jsp";
			
			if(iname != document.myform.hidd_i_name.value || iweight != document.myform.hidd_i_weight.value || document.myform.hidd_item_group_Value.value!=$('#iGroupCode1 option:selected').val())
			{	
				//alert(iname +"   "+ document.myform.hidd_i_name.value);
				//alert(iweight +"   "+ document.myform.hidd_i_weight.value);
				//alert($('#iGroupCode1 option:selected').val()+"   "+document.myform.hidd_item_group_Value.value);
				getDuplicateRecord(iname,iweight);
			}else{
				document.myform.action="EditItem.jsp";
				document.myform.submit();
			}
			
		}
		else{
		  	window.refresh; 
		}
	}	
	function showMsg(){
	  	 document.myform.action="HomeForm.jsp";
	   	 document.myform.submit();
	}
	function Warn(){
		alert("U  Can't Change The Item Code");
    }
    function CalComm(){
		var rate= document.myform.i_rate.value;
		document.myform.i_comm.value = rate * 0.01;
	}
	
	function getDuplicateRecord(iname,iweight){
	ig_code_Value = $('#iGroupCode1 option:selected').val();
	
	//alert(" get duplicate "+iname+" "+iweight+" "+ig_code_Value);
	
		var url ="name="+iname;
		url +="&weight="+iweight
		url +="&groupCode="+ig_code_Value; 
		url +="&ajaxOption=duplicateRecord";
		$.ajax({
			url:"EditItemAjaxResponse.jsp",
			type:'post',
			data:url,
			dataType:'text',
			success:function(ajaxResonse)
			{	
				var CheckRecord = parseInt(ajaxResonse);
				if(CheckRecord==1)
					alert('Item already exist for same Item Group ,Item Name & item Weight');
				else{
					document.myform.action="EditItem.jsp";
					document.myform.submit();
				}
			}
		});
	}
	
</script>
<fieldset style="width: 30%;">
<legend><h3>Edit Item</h3></legend>

<form name="myform" action="EditItem.jsp" method="POST">

	<input type="hidden" name="hidd_ig_code" value="<%=ig_code1%>">
	<input type="hidden" name="hidd_i_name" value="<%=i_name1%>">
	<input type="hidden" name="hidd_i_weight" value="<%=i_weight1%>">
	<input type="hidden" name="hidd_i_mrp" value="<%=i_mrp1%>"> <input
		type="hidden" name="hidd_i_rate" value="<%=i_rate1%>"> <input
		type="hidden" name="hidd_i_comm" value="<%=i_comm%>"> <input
		type="hidden" name="hidd_ig_code" value="<%=ig_code1%>"> <input
		type="hidden" name="hidd_i_tickflg" value="<%=i_tickflg%>">
	<input type="hidden" name="hidd_Remark" value="">
	<input type="hidden" name="hidd_item_group_Value" value="<%=request.getParameter("groupCodeValue")%>">

	<table border="0" align="center">
		<tr>
			<td style="width: 25%;" align="left"><b>Item Code</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left"><input type="text" name="i_code" readonly
				value="<%=i_code1%>" onClick="Warn();">
		</tr>
		<tr>
			<td style="width: 25%;" align="left"><b>Item Group Code</b></td>
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
			<td style="width: 40%;" align="left"><SELECT name="iGroupCode" id='iGroupCode1'>
					<!--	<OPTION VALUE="<%=ig_code1%>"><%=ig_code1%> -->
					<%
						rowcount = 0;
							while (rs.next()) {
								name = rs.getString(1);
								desc = rs.getString(2);
								if (ig_code1.equals(desc)) {
					%>
					<OPTION selected VALUE="<%=name%>"><%=desc%>
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
						%>
					</td>
			</SELECT>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr>
			<td style="width: 25%;" align="left"><b>Item Name</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left"><input type="text" name="i_name" value="<%=i_name1%>" ></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr>
			<td style="width: 25%;" align="left"><b>Item Barcode</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left"><input type="text" name="i_barcode" value="<%=i_barcode1%>"></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr style="width: 25%;" align="left">
			<td><b>Item Weight</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left"><input type="text" name="i_weight" value="<%=i_weight1%>"></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr>
			<td style="width: 25%;" align="left"><b>Item Type</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left">
				<select name="item_type" style="width:60%;" onchange="disableBoxField();">
					<%
						String value=null,text=null;
						if(is_bachka.equals("true")){
							value="true";
							text="Bachka";
							
						}
						else if(is_mixture.equals("true")){
							value="mixItem";
							text="Mix Item";
						}
						else{
							value="false";
							text="Single Item";
						}
							
					%>
					<option value="<%=value%>"><%=text%></option>
					<option value="false">Single Item</option>
					<option value="true">Bachka</option>
					<option value="mixItem">Mix Item</option>
				</select>
			</td>
		</tr>
		<tr></tr>
		<tr></tr>
		
		<tr>
			<td style="width: 25%;" align="left"><b>Box Quantity </b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left"><input type="text" name="box_qty" value="<%=box_qty%>"></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr>
			<td style="width: 25%;" align="left"><b>Item MRP [Rs.]</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left"><input type="text" name="i_mrp" value="<%=i_mrp1%>"></td>
		</tr>
		<tr></tr>
		<tr></tr>
		<tr>
			<td style="width: 25%;" align="left"><b>Item Rate [Rs.]</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left"><input type="text" name="i_rate" value="<%=i_rate1%>"
				onblur="CalComm();"></td>
		</tr>
		<tr>
			<td style="width: 25%;" align="left"><b>Commission Amt.[Rs.]</b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left"><input type="text" name="i_comm" value="<%=i_comm%>"></td>
		</tr>
		<tr>
			<td style="width: 25%;" align="left"><b>Ticker Flag </b></td>
			<td style="width: 2%;" align="left">:</td>
			<td style="width: 40%;" align="left"><select name="i_tickflg">

					<%
						if (i_tickflg.equals("Y")) {
					%>
					<option selected value="Y">Yes</option>
					<option value="N">No</option>
					<%
						} else if (i_tickflg.equals("N")) {
					%>
					<option value="Y">Yes</option>
					<option selected value="N">No</option>
					<%
						} else {
					%>
					<option selected value="">Select Ticker Flag</option>
					<option value="Y">Yes</option>
					<option value="N">No</option>
					<%
						}
					%>
			</select></td>
		</tr>
		<tr/><tr/><tr/><tr/><tr/><tr/><tr/><tr/>
		
		<tr>
			
			<%
				if (id_flag1.equals("N")) {
			%>
			<td><input type="Checkbox" id="chck" name="chck1" size="10"
				onClick="funEnabled();"><b>&nbsp&nbsp&nbsp&nbspDeal flag</b></td>
			<%
				} else {
			%>
			<td><input type="Checkbox" id="chck" name="chck1" checked
				size="10" onClick="funEnabled();"><b>&nbsp&nbsp&nbsp&nbspDeal
					flag</b></td>
			<%
				}
			%>
			<td></td>

			<input type="hidden" name="hCheckValue">
		</tr>

		<tr>

			<td colspan="4"><div id="div4" style="VISIBILITY: visible">
					<fieldset>
						<legend>
							<font color="blue"><b>Deal</b></font>
						</legend>
						<table align="center">
							<tr>
								<td><b>Deal Type</b></td>
								<td><SELECT name="iDealType">
										<OPTION VALUE="">
											Select type

											<%
											String name1, items = "", money = "", category = "";
												stat = conn.createStatement();
												rs2 = stat
														.executeQuery("select value from code_table where category='DealType'");
												if (id_type1.equals("")) {
										%>
										
										<OPTION VALUE="">
											Select type
											<%
																					}
																						while (rs2.next()) {
																							name1 = rs2.getString(1);
																							if (id_type1.equals(name1)) {
																				%>
										
										<OPTION VALUE="<%=name1%>" selected>
											<%=name1%>
											<%
												}

														else {
											%>
										
										<OPTION VALUE="<%=name1%>">
											<%=name1%>
											<%
												}
													}

													rs.close();
													stmt.close();
													conn.close();
												} catch (Exception e) {
													e.getMessage();
													e.printStackTrace();
												}
											%>
										
								</select></td>
							</tr>
							<tr>
								<td><b>Quantity</b></td>
								<td><input type="text" name="id_qty" value="<%=id_qty1%>"
									size="10"></td>
								<td><b>Amount</b></td>
								<td><input type="text" name="id_amt" value="<%=id_amt1%>"
									size="10"></td>
							</tr>
						</table>
				</div>
		</tr>

	</table>
	<center>
		<input type="button" name="Submit" disabled accesskey="s" onClick="checkField();return false;" value="Submit <Alt+ s>"/> 
		<input type="reset" name="clear" accesskey="r" value="Clear <Alt+ r>"/>
		<INPUT type=BUTTON accesskey="c" onClick="showMsg();" value="Cancel <Alt+ c>"/>
	</center>

</form>
</fieldset>
<script type="text/javascript">
  
  			if (document.myform.chck.checked==true){
				document.getElementById('div4').style.visibility="visible";
				
			}
			else{
				document.getElementById('div4').style.visibility="hidden";
			
			}
      	document.myform.i_name.focus();
      	    function check(){
	    		document.myform.Submit.disabled=false;
		}
		document.onkeyup = check;
		document.onclick = check;
		//window.onload=func;
		function func(){
			alert("Func check val = "+document.myform.chck.checked);
			if(document.myform.chck.checked==false)
				document.myform.hCheckValue.value=0;				
			if(document.myform.chck.checked==false)
				document.myform.hCheckValue.value=1;
		}
		function funEnabled(){			
		    if (document.myform.chck.checked==true){		    	
				document.getElementById('div4').style.visibility="visible";
				document.myform.hCheckValue.value=1;
								
			}
			else{
				document.getElementById('div4').style.visibility="hidden";
				document.myform.hCheckValue.value=0;					
			}
		}
  </script>
</body>
</html>