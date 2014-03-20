<html>
<head>
 	<title>Retail Management-Janta Stores</title>
 	<%-- <jsp:include page="sessionBoth.jsp">	
   		<jsp:param name="formName" value="OrderProcessingCheckedForm.jsp" />	
	</jsp:include> --%>
	
	<%@ page errorPage="ErrorPage.jsp?page=OrderProcessingCheckedForm.jsp" %>
	
	<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
	%>
	
 	<script type="text/javascript" src="js/OrderCheck.js"></script> 
 
	<link rel="stylesheet" type="text/css" href="css/border_radius.css" />
</head>
<body class="bodyClass">
<form name="myform" onclick="return false;">
<% 
	String selOrderNo = request.getParameter("orderNo");
	System.out.println("selOrderNo :"+selOrderNo);
	
	String backPage =  request.getParameter("backPage");
 %>
  <input type="hidden" name="backPage" value="OrderCheckedMenuForm.jsp">
    <input type="hidden" name="orderNo" value="<%=selOrderNo%>">
 <input type="hidden" name="hOrderNo" value="<%=selOrderNo%>">
 <div align="center">
 <table  style="width:80%;">
  <tr>
   <td height="10px;"></td>
  </tr> 
  <tr> 
   <td>
	<table style="width:100%;">
<!--     Display Customer  Information -->
	 <tr>
 	  <td style="width:5%;">&nbsp;</td>
 	  <td align="center" style="width:90%;"><div id="CustInfoDiv"></div></td>
 	  <td style="width:5%;">&nbsp;</td>
	 </tr>
<!--     Display Order  Information -->
	 <tr>
	   <td style="width:5%;">&nbsp;</td>
 	   <td align="center"  style="width:90%;"><div id="OrderInfoDiv"></div></td>
 	   <td style="width:5%;">&nbsp;</td>
	 </tr>
	 <tr>
	  <td style="width:5%;">&nbsp;</td>
 	  <td style="width:90%;">
 	   <div id="SearchStringDiv" style=" border:1px solid black;padding-top: 10px; padding-bottom: 10px;">
 	   <table style="width:100%;">
 	    <tr>
		 <td style=" font-size:12px;width: 400px;"><b> Enter Item Bar<font color="blue" style="text-decoration: underline;">c</font>ode : </b>
		 &nbsp;&nbsp; <input type="text" name="itemBarcode" class="roundedSearchTextField" size="10"  accesskey="c" />			
		 &nbsp;&nbsp;&nbsp;<input type="submit" onclick="funMatchBarCode();" style="width: 120px"
		 class="imgButton" value="Search Barcode"/>
		 </td>
		 <td style=" font-size:12px;width: 70px;"><b>Item <font color="blue" style="text-decoration: underline;">N</font>ame</b></td>
		 <td style="position:relative;">
		  <div id="selItemComboDiv">
		  	<select name="selItemName" id ="selItemName" style="font-size: 9px;"  accesskey="n" >
		  	<option value="">SELECT</option>
		  	</select>&nbsp;&nbsp;
		  	<input type="button" onclick="funCheckItemName();" class="imgButton" accesskey="f" 
		  	style="width: 120px;" value="Check Item"/>&nbsp;&nbsp;
		  	<input type="button" onclick="displayPopup();" class="imgButtonSearch"
		  	style="width: 60px;" value="search" accesskey="s"/>
		 </div>		  			
		 </td>
		</tr>
 	   </table>
 	   </div>
 	  </td>
 	  
	 </tr>
<!--     Display Messages after entering barcode -->
	  <tr id="displayMsgTR">
	  <td style="width:5%;">&nbsp;</td>
 	  <td style="width:90%;">
 	  <div id="matchedItemTableDiv" class="roundedDiv" style="position:relative;height:30px;display:none; border:1px solid black;">
	   	 <table class="custorderinfo"  style="width:100%;font-size: 110%;background-color: #996699;" id="matchedItemTable"  >
	   	  <tr>
	   	 	<th style="width:17%;color:pink;">Matched Item barcode:</th>
	   	 	<td style="width:7%;color:pink;"><input type="text" name="mBarcode" size="6" class="hideTextField" readonly="readonly" style="background-color:#996699;font-size: 12;color:white;"/></th>
	   	 	<th style="width:8%;color:pink;"> Item name :</th>
	   	 	<td style="width:23%;color:pink;"><input type="text" name="mItemName" size="40" class="hideTextField" readonly="readonly" style="background-color:#996699;font-size: 12;color:white;"/></th>
			<th style="width:5%;color:pink;">Weight:</th>
			<td style="width:6%;color:pink;"><input type="text" name="mWeight" size="3" class="hideTextField" readonly="readonly" style="background-color:#996699;font-size: 12;color:white;"/></th>
	   		<th style="width:9%;color:pink;">Order quantity:</th>
	   		<td style="width:6%;color:pink;"><input type="text" name="mOrderedQty" size="5" class="hideTextField" readonly="readonly" style="background-color:#996699;font-size: 12;color:white;"/></th>
	   	 	<th style="width:12%;color:pink;">Accounted quantity:</th>
	   	 	<td style="width:6%;color:pink;"><input type="text" name="mAccQty" size="5" class="hideTextField" value="" onchange="setValue(this.value);" /></th>
	   	  </tr> 	   	 
	   	 </table>
	    </div>
	    <div id="removedItemTableDiv"  class="roundedDiv" style="background-color: #996699;position:relative;height:30px;display:none; border:1px solid black;">
	   	 <table class="custorderinfo"  style="width:100%;font-size: 110%;background-color: #996699;" id="removedItemTable" >
	   	  <tr> 	   	 	
	   	 	<th style="width:17%;color:pink;">Last Matched Item barcode:</th>
	   	 	<td style="width:7%;color:pink;"><input type="text" name="rBarcode"  class="hideTextField" size="6" readonly="readonly" style="background-color:#996699;font-size: 12;color:white;" value=""/></td>
	   	 	<th style="width:8%;color:pink;"> Item name :</th>
	   	 	<td style="width:23%;color:pink;"><input type="text" name="rItemName"  class="hideTextField" size="40" readonly="readonly" style="background-color:#996699;font-size: 12;color:white;" value=""/></td>
			<th style="width:5%;color:pink;">Weight:</th>
			<td style="width:6%;color:pink;"><input type="text" name="rWeight"  class="hideTextField" size="3" readonly="readonly" style="background-color:#996699;font-size: 12;color:white;" value=""/></td>
	   		<th style="width:9%;color:pink;">Order quantity:</th>
	   		<td style="width:6%;color:pink;"><input type="text" name="rOrderedQty"  class="hideTextField" size="5"readonly="readonly" style="background-color:#996699;font-size: 12;color:white;" value=""/></td>
	   	 	<th style="width:12%;color:pink;">Accounted quantity:</th>
	   	 	<td style="width:6%;color:pink;"><input type="text" name="rAccQty" class="hideTextField" size="5" value="" readonly="readonly" style="background-color:#996699;font-size: 12;color:white;" value=""/></td> 	   	 	
	   	  </tr> 	   	 
	   	 </table>
	    </div>
	    <div id="notMatchedItemTableDiv" style=" height :120px ; width:400px; border:1px; solid black; background-color:#cccccc; /*padding:25px;*/ display:none; font-size:100%; text-align:center; ">
	   	 <table class="custorderinfo" align="center"  style="width:100%;font-size: 140%;" id="notMatchedItemTable">
	   	 <tr><td colspan="2">&nbsp;</td></tr>
	   	  <tr> 	   	 	
	   	 	<td colspan="2"><b>&nbsp;&nbsp;&nbsp;&nbsp;Item barcode &nbsp;<input type="text" name="notMatchBarcode"  class="hideTextField" size="5" readonly="readonly" style="background-color:#BEF781;font-weight: bold;"/>&nbsp;
	   	 	does not match. Do you want to swap item?</b></td>
	   	 </tr>
	   	 <tr><td colspan="2">&nbsp;</td></tr>
   	 	 <tr> 
   	 		<td width="30%">&nbsp;</td>
   	 		<td><input type="button" value="Swap" onclick="funShowPopup(document.myform.notMatchBarcode.value);" class="maroonButton"/>&nbsp;&nbsp;<input type="button" value="Cancel" onclick="funCancel()" class="maroonButton"/></td> 	   	 	
	   	  </tr> 	   	 
	   	 </table>
	    </div>
 	  	<!-- <div id="displayMessageDiv" class="roundedDiv" style="background-color: #BEF781;position:relative;height:30px;"> </div> -->
 	  </td>
 	  <td style="width:5%;">&nbsp;</td>
	 </tr>
	 
	 
	 
<!--     Display Order Item Information -->
	 <tr>
	  <td style="width:5%;">&nbsp;</td>
 	  <td align="center" style="width:90%;"><div id="OrderItemInfoDiv" style="background-color: #EFFBEF;overflow: auto;height: 100px;width: 100%; border:1px solid black;"></div></td>
 	  <td style="width:5%;">&nbsp;</td>
	 </tr>
	 <tr>
	  <td style="width:5%;">&nbsp;</td>
 	   <td align="left" style="width:90%;">
 	    <div id="buttonDiv"">
 	     <table>
	      <tr>
	       <td>
		   <input type="button" name="ShowOrderDetails" value="Show Item Details" onclick="ShowOrder();" class="maroonButton" style="display:none;"/>
		   <input type="button" name="HideOrderDetails" value="Hide Item Details" onclick="HideOrder();" class="maroonButton"  />
		   </td>
		  <td><input type="button" name="CheckedOrder" value="Check Order" onclick="SaveOrder();" class="maroonButton"/></td>
		  <td><input type="button" name="CancelOrder" value="Cancel Order" onclick="CancelOrder1();" class="maroonButton"/></td>
	     </tr>	    
	    </table>
 	   </div>
 	    
 	   <div id="bagDisplayDiv" style=" height :120px ; width:400px; border:1px; solid black; background-color:#cccccc; display:none; font-size:100%; text-align:center;">
	   	 <table align="center"  style="width:100%;font-size: 140%;" >
	   	 <tr><td colspan="2">&nbsp;</td></tr>
	   	 <tr>
	   	  <td colspan="6" align="center"><font size="1px"><b><font color="blue">Bags</b></font></font>
	      <input id="txt" type="text" name="bagname" value="" />	
	      </td>
	      </tr>
	   	 <tr><td colspan="2">&nbsp;</td></tr>
   	 	 <tr> 
   	 		<td width="30%">&nbsp;</td>
   	 		<td><input type="button" value="Save" onclick="funsave();" class="maroonButton"/>&nbsp;&nbsp;<input type="button" value="Cancel" onclick="cancelOrder();" class="maroonButton"/></td> 	   	 	
	   	  </tr> 	   	 
	   	 </table>
	    </div>

 	    </td>
 	  <td style="width:5%;">&nbsp;</td>
	 </tr>
 	
	 
	 
	 
<!--     Display Order Removed Item Information -->
 	 <tr>
	  <td style="width:5%;">&nbsp;</td>
 	  <td  style="width:90%;">
 	   <div id="removeItemInfoTableDiv" style="background-color: #EFFBEF;overflow: auto;height: 100px; border:1px solid black;">
 	    <table id="removeItemInfoTable" class="genericTbl" style="width:100%;">
	     <thead>
	      <tr style="position:relative;top:expression(document.all['removeItemInfoTableDiv'].scrollTop);">
			     <th colspan="8" align="center">Checked Items</th>			    
		  </tr>	  
		  <tr style="position:relative;top:expression(document.all['removeItemInfoTableDiv'].scrollTop);">
		  	<th>Item Code</th>
		  	<th>Item Name</th>
		  	<th>Item Weight</th>
		  	<th>Rate</th>
		  	<th>Order Quantity</th>	
		  	<th>Accounted Quantity</th>		  	
		  	<th>Total Price</th>
		  	<th>Remark</th>
		  </tr>
		 </thead>
		 <tbody>		 
		 </tbody>
	    </table>
 	   </div>
 	  </td>
 	  <td style="width:5%;">&nbsp;</td>
	 </tr>
    
<!--     Display Order Item Information -->
     <tr>
 	  <td style="width:5%;">&nbsp;</td>
 	  <td align="center" style="width:90%;">
		<div id="swapItemDetailsDiv" style="width:100%;">
		 <table style="width:100%;">
		  <tr>
		   <td width="50%">
		    <div id="swapNewItemTableDiv" style="background-color: #EFFBEF;overflow: auto;height: 100px;width:100%; border:1px solid black;">
			 <table id="swapNewItemTable" class="genericTbl" style="width:100%;">
			  <thead>
		       <tr style="position:relative;top:expression(document.all['swapNewItemTableDiv'].scrollTop);">
			     <th colspan="7" align="center">New Items</th>			    
		       </tr>
		       <tr style="position:relative;top:expression(document.all['swapNewItemTableDiv'].scrollTop);">
			    <th>Item Code </th>
			    <th>Item Name </th>
			    <th>Rate </th>
			    <th>MRP </th>
			    <th>Order Quantity</th>
			    <th>Price</th>
			    <th>Remark</th>
		       </tr>
		      </thead>
		      <tbody>
		      </tbody>
             </table>
            </div>
		   </td>
		   <td width="50%">
		    <div id="swapOldItemTableDiv" style="background-color: #EFFBEF;overflow: auto;height: 100px;width:100%; border:1px solid black;">
			 <table id="swapOldItemTable" class="genericTbl" style="width:100%;">
		      <thead>
		       <tr style="position:relative;top:expression(document.all['swapOldItemTable'].scrollTop);">
			    <th colspan="7" align="center">Old Items </th>			    
		       </tr>
		       <tr style="position:relative;top:expression(document.all['swapOldItemTable'].scrollTop);">
			    <th>Item Code </th>
			    <th>Item Name </th>
			    <th>Rate </th>
			    <th>MRP </th>
			    <th>Order Quantity</th>
			    <th>Price</th>
			    <th>Remark</th>
		       </tr>
		      </thead>
		      <tbody>
		      </tbody>
		     </table>
		    </div>
           </td>
          </tr>
         </table>
 	    </div>
		   </td>
		  </tr>
		 </table>
		</div>
	  </td>
 	  <td style="width:5%;">&nbsp;</td>
     </tr>
     </table>
    </td>
   </tr>
  </table>
 </div>
  <!-- ------------------Display Message Div----------------------- -->
  
<!-- Swapn Item Popup Div -->

<div id="baseDiv" style="position: absolute;top:0px;" align="center" ></div>
<div id="swapItemDiv" style=" height :180px ; width:900px; border:1px; solid black; background-color:#BEF781; /*padding:25px;*/ display:none; font-size:100%; text-align:center; ">
	<table>
	 <tr>
		<td colspan="1" align="right"><img src="images/close-16.png" alt="No Image" onclick="funCloseSwapDiv();"/></td>			
	 </tr>
	 <tr>
	  <td>
	 	<table id ="swapItemTable" class="genericTbl" style="font-size: 72%;width: 100%;">		
		<tr bgcolor="LightBlue">
			<th></th>
			<th>Item Name</th>
			<th>Weight</th>
			<th>Rate</th>
			<th>MRP</th>
			<th>Quantity</th>
			<th>Item Discount</th>
			<th>Total Price</th>
			<th>Remark</th>			
		</tr>
		<tr>
			<td>Target Item </td>
			<td><input type="text" name="targetName"  class="hideTextField" readonly="readonly" size="30"/></td>
			<td><input type="text" name="targetWeight"  class="hideTextField" readonly="readonly" size="3"/></td>
			<td><input type="text" name="targetRate"  class="hideTextField" readonly="readonly" size="5"/></td>		
			<td><input type="text" name="targetMrp"  class="hideTextField" readonly="readonly" size="5"/></td>
			<td><input type="text" name="targetQty" onchange="setTotalPrice(this.value);" value="" size="5"/></td>
			<td><input type="text" name="targetDiscount" value="" class="hideTextField" readonly="readonly" size="5"/></td>
			<td><input type="text" name="targetPrice" value="" class="hideTextField" readonly="readonly" size="5"/></td>
			<td><input type="text" name="targetRemark" value="" class="hideTextField" readonly="readonly" size="15"/></td>
			<td style="display: none"><input type="hidden" name="targetItemGroupCode" value="" class="hideTextField"/></td>
			<td style="display: none"><input type="hidden" name="targetItemCode" value="" class="hideTextField"/></td>
			<td style="display: none"><input type="hidden" name="targetBarcode" value="" class="hideTextField"/></td>
			<td style="display: none"><input type="hidden" name="targetDealAmount" value="" class="hideTextField"/></td>
			<td style="display: none"><input type="hidden" name="targetDealQty" value="" class="hideTextField"/></td>
		</tr>
		<tr> 
			<td>Source Item </td>
			<td>
				<select name="selSourceItem" id="selSourceItem" onchange="funSetItemValues();">
				</select> 
			</td>  
			<td><input type="text" name="sourceWeight"  class="hideTextField" size="3"/></td>
			<td><input type="text" name="sourceRate"  class="hideTextField"  size="3"/></td>
			<td><input type="text" name="sourceMrp"  class="hideTextField"  size="3"/></td>			
			<td><input type="text" name="sourceQty" class="hideTextField" size="5"/></td>
			<td><input type="text" name="sourceDiscount" value="" class="hideTextField" size="5"/></td>
			<td><input type="text" name="sourcePrice" value="" class="hideTextField" size="5"/></td>
			<td><input type="text" name="sourceRemark" value="" class="hideTextField" size="15"/></td>
			<td style="display: none"><input type="hidden" name="sourceBarcode"  class="hideTextField"/></td>
		</tr>			
	   </table>
	  </td>
	 </tr>
	 <tr>			
		<td colspan="6" align="center"><input type="button" value="Swap Item" onclick="funSwapItems();" class="maroonButton"/></td>		
	</tr>
	</table>	
</div>


<div id="searchItemNameDiv"  style=" height :180px ; width:900px; border:1px solid black; background-color:#BEF781; /*padding:25px;*/ display:none;font-size:100%; text-align:center;">
 <table>
  <tr>
	<td colspan="6" align="right"><img src="images/close-16.png" onclick="funCloseItemDiv();" /> </td>
  </tr>
  <tr>
	<td colspan="6" align="center"><font size="1px"><b><font color="blue">E</font>nter Item Name</b></font>
	 <input type="text" name="serachItemName"  accesskey="e" onchange="searchString();"/>	
	<img class="ToolButton" id="img_find" title="Find" src="images/find.gif" alt="Find" border="0"  onclick="searchString();"  style="cursor:hand;"/></td>
     
	</tr>	
	<tr>
		<td colspan="6"><div id="ResponseDiv" style="width:800px;height:100px;overflow:auto;"></div></td>
	</tr>
</table>
</div>

<embed src="audio/beep.mp3" autostart=false width="1" height="1" id="sound1" >


</form>
<script  type="text/javascript">
window.onload = onLoadFunctions;

function onLoadFunctions(){
	
		funShowCustInfo();
		//not work functions.....//funShowOrderDetails();//funShowOrderItemDetails();
		//showItemNames();
	document.myform.itemBarcode.focus();	
	
}



</script>
</body>
</html>