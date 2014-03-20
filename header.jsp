<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<style>
	div#menu{
		z-index: 1000;
	}
</style>
<%@ page import="java.util.Hashtable" %>
<% 	
    String str = "",username="";
    Hashtable HT = new Hashtable();
	if (session != null) {
			if (session.getAttribute("user_type_code") != null) {		
			str = session.getAttribute("user_type_code").toString();
			username = session.getAttribute("UserName").toString();
			System.out.println("header.jsp   "+session.getAttribute("GlobalSiteId").toString());	   
		}
	}
	else{
	System.out.println("in else part");
	}
%>		
<html>
<head>
	 <title>Retail Management-Janta Stores</title>
	 <style type="text/css">
     body {
	     font: 13px Cambria;
	     color: black;
	     background: white;
	     margin: 0;
	     padding: 0px;
     }    
    </style>
	<link rel="stylesheet" type="text/css" href="stylesheet/menu1.css" />
	<script type="text/javascript" src="js/DropDownMenu1.js"></script>
</head>
<body>
<center>
	<div id="image"></div>
		<%  if(str.equals("1")){%>
		<style type="text/css">div#menu{width:14%;}</style>
		<%  }else if(str.equals("3")){%>
		<style type="text/css">div#menu{width:19.53%;}</style>
		<%  }else if(str.equals("4")){%>
		<style type="text/css">div#menu{width:10.5%;}</style>
		<%  }else if(str.equals("")){%>
		<style type="text/css">div#menu{width:99%;} div#menu:hover{background-color:#ECFB99;color:black;}</style>
		<% } %>
		<div id="menubar">
			<a href="#">
				<%  if(str.equals("2")){%>
				<div id="menu" style="width:100px">
				<%  }else{ %>
				<div id="menu">
				<% } %>Welcome <b><% out.print(username);%></b></div></a>
			<% if(!str.equals("")){ %>
			<a href="HomeForm.jsp"><div id="menu" style="width: 50px;">Home</div></a>
			<% if(str.equals("2")){ %>
			<div id="menu">Administration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div id="img1" style="margin-left:74px;">&nbsp;</div>
				<div id="submenu1">					
						<a href="NewUserForm.jsp"><div id="submenu2">Create User</div></a>
						<a href="EditUserForm.jsp"><div id="submenu2">Edit User</div></a>
						<a href="EditMsgForm.jsp"><div id="submenu2">Edit Message</div></a>
						<a href="Calculate.jsp"><div id="submenu2">Calculate</div></a>
						<a href="Denominations.jsp"><div id="submenu2">Denominations</div></a>
						<a href="UserAccessForm.jsp"><div id="submenu2">Access Permission</div></a>				
				</div>
			</div>
			<% }%>
			<div id="menu">Orders<div id="img1" style="margin-left:50px;">&nbsp;</div>
				<div id="submenu1">					
						<% if(!str.equals("3")) { %>
						<a href="customer_detailsForm.jsp"><div id="submenu2">Create Order</div></a>
						<a href="order_detailsForm.jsp"><div id="submenu2">List/Edit/Print&nbsp;Order</div></a>
						<% }
						if(!str.equals("1") && !str.equals("4")) { %>
						<a href="TrackingForm.jsp?Exp=0"><div id="submenu2">Order Processing</div></a>
						<a href="PrintDcForm.jsp"><div id="submenu2">View/Print DC</div></a>
						<% } if(!str.equals("3")) {%>
						<a href="OrderCheckedMenuForm.jsp"><div id="submenu2">Order Check</div></a>
						<% } if(!str.equals("1") && !str.equals("4")){
							%>
							<a href="CancelOrderForm.jsp"><div id="submenu2">Cancel Order</div></a>
							<%
						}
						
						%>					
				</div>
			</div>
			<% if(!str.equals("3")){%>
			<div id="menu">Items<div id="img1" style="margin-left:50px;" >&nbsp;</div>
				<div id="submenu1">				
						<a href="NewItemForm.jsp"><div id="submenu2">Create New Item</div></a>
						<a href="ItemDetailsForm.jsp?flag=1"><div id="submenu2">List/Edit Item</div></a>
						<a href="ManagePriceVersion.jsp"><div id="submenu2">Manage Price Version</div></a>
						<% if(!str.equals("1") && !str.equals("4")) { %>
						<a href="NewItemGroupForm.jsp"><div id="submenu2">Create&nbsp;New&nbsp;Item&nbsp;Group</div></a>
						<a href="ItemGroupDetailsForm.jsp"><div id="submenu2">List/Edit&nbsp;Item&nbsp;Group</div></a>
						<% } if(!str.equals("3") && !str.equals("4")) { %>
						<a href="ItemDetailsForm.jsp?flag=2"><div id="submenu2">Purchase Detail</div></a>
						<% } %>	
						<a href="BachkaMappingForm.jsp"><div id="submenu2">Bachka Mapping</div></a>	
						<a href="MixtureMappingForm.jsp"><div id="submenu2">Mixture Mapping</div></a>	
									
				</div>
			</div>
			<% } %>
			<% if(str.equals("2") || str.equals("4") || str.equals("1") )
				{ 
				if(str.equals("2"))
				{%>
				<div id="menu" style="width:120px">
			
			<%}else{%><div id="menu" style="width:135px;"><%}%>
			Stock Management<div id="img1" style="margin-left:119px;"></div>
				<div id="submenu1">					
								<a href="NewVendorForm.jsp"><div id="submenu2">Create Vender</div></a>
								<a href="SearchVendorForm.jsp"><div id="submenu2">Edit Vender</div></a>
								<a href="NewSiteForm.jsp"><div id="submenu2">Create Site</div></a>
								<a href="SearchSiteForm.jsp"><div id="submenu2">Edit Site</div></a>	
						<div id="submenu2_1">Inventory<div id="img2"></div>
							<div id="submenu3">								
									<a href="AcceptInventoryForm.jsp"><div>Accept Inventory</div></a>
									<a href="TransferInventoryForm.jsp"><div>Transfer Inventory</div></a>
									<a href="EditTransferInventoryForm.jsp"><div>Edit Transfer Inventory</div></a>
									<a href="ReceiveInventoryForm.jsp"><div>Receive Inventory</div></a>
									<a href="ReprintTransferInventoryForm.jsp"><div>Reprint Inventory</div></a>
									<a href="PakegingForm.jsp"><div>Packaging</div></a>
									<a href="ConversionForm.jsp"><div>Conversion</div></a>
							</div>
						</div>					
				</div>
			</div>
			<%  
			}
			if(str.equals("2") || str.equals("1") || str.equals("4")) { %>
			<a href="Reports.jsp"><div id="menu">Report</div></a>
			<%} if(str.equals("2") || str.equals("4")) { %>
			<div id="menu">Payment<div id="img1" style="margin-left:70px;" >&nbsp;</div>
				<div id="submenu1">				
						<a href="EditTargetReportForm.jsp?call_type=receive_payment"><div id="submenu2">Receive Payment</div></a>
						<a href="EditTargetReportForm.jsp?call_type=search_payment"><div id="submenu2">Payment Recovery</div></a>	
						<a href="EditTargetReportForm.jsp?call_type=communication"><div id="submenu2">Communication</div></a>			
				</div>
			</div>
			<%}%>
			
			<div id="menu">Master<div id="img1" style="margin-left:50px;">&nbsp;</div>
				<div id="submenu1">					
						<div id="submenu2_1">Customer<div id="img2"></div>
							<div id="submenu3">								
									<a href="create_newCustomerForm.jsp"><div>Create New Customer</div></a>
									<a href="EditTargetReportForm.jsp"><div>List/Edit Customer</div></a>								
							</div>
						</div>
						<% if(str.equals("2")) { %>
						<div id="submenu2_1">Area<div id="img2"></div>
							<div id="submenu3">								
									<a href="NewAreaForm.jsp"><div>Create New Area</div></a>
									<a href="AreaDetailsForm.jsp"><div>List/Edit Area</div></a>								
							</div>
						</div>
						<div id="submenu2_1">Staff Maintenance<div id="img2"></div>
							<div id="submenu3">	
									<a href="NewDeliveryStaffForm.jsp"><div>Add Staff</div></a>
									<a href="DeliveryStaffDetailsForm.jsp"><div>List/Edit Staff</div></a>								
							</div>
						</div>
						<div id="submenu2_1">Commissions<div id="img2"></div>
							<div id="submenu3">								
									<a href="CommissionsDetailsForm.jsp"><div style="height:30px">List/View/Settle Commissions</div></a>								
							</div>
						</div>
						<% } %>					
				</div>
			</div>
			<%  if(str.equals("2")) { %>
			<a href="#"><div id="menu">Profile</div></a>
			<div id="menu">Send Message&nbsp;&nbsp;<div id="img1" style="margin-left:90px;">&nbsp;</div>
				<div id="submenu1">					
						<a href="SendMessageForm.jsp"><div id="submenu2">Send Message</div></a>
						<a href="SendBulkMessageForm.jsp"><div id="submenu2">Send Bulk Message</div></a>	
						<a href="SendGroupMessage.jsp"><div id="submenu2">Message</div></a>			
				</div>
			</div>
			<% } %>
			<a href="Login.jsp?Log=1"><div id="menu">LogOut</div></a>
			<% } %>
		</div>

</div>
</center>

    
      