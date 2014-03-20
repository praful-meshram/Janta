<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%@ page import="java.io.*" %>
<jsp:include page="header.jsp" /> 
<script src="js/editItem_details.js"></script>
<link rel="stylesheet" type="text/css" href="css/border_radius.css" />
<%@page contentType="text/html"%>


<%@ page errorPage="ErrorPage.jsp?page=ChangeQuantityItemForm.jsp" %>
	
<%
	session.getAttribute("UserName").toString();
	//System.out.println("session bachka maapping : "+session +" \n user "+session.getAttribute("UserName").toString());
		
		%>


<%
		String i_code1="";
		String i_barcode1="";
		String ig_code1="";
		String i_name1="";
		String i_weight1="";
		String i_mrp1="";
		String i_rate1="";
		String id_type1="";
		String id_flag1="";
		String id_qty1="";
		String id_amt1="";
		String i_comm="";
		String i_tickflg="";
		
		i_code1=request.getParameter("icode");
		i_barcode1 = request.getParameter("ibarcode");
		ig_code1=request.getParameter("igcode");
		i_name1=request.getParameter("iname");
		i_weight1=request.getParameter("iweight");
		i_mrp1=request.getParameter("imrp");
		i_rate1=request.getParameter("irate");
		id_type1=request.getParameter("id_type");
		id_flag1=request.getParameter("id_flag");
		id_qty1=request.getParameter("id_qty");
		id_amt1=request.getParameter("id_amt");
		i_comm=request.getParameter("i_comm");
		i_tickflg = request.getParameter("i_tickflag");
%>
<center><h3>Change Quantity</h3></center><br>
<form name="myform" class="ddm1">
<table align="center">
<tr>
<td><b>Select Site : </b></td>
<td>
<select name="siteId" onchange="getList();">
<option value="0" selected >all</option>
<%item.ManageItem mi;
mi = new item.ManageItem("jdbc/js");
mi.getSiteList();
Integer GlobalSiteId = Integer.parseInt(session.getAttribute("GlobalSiteId").toString());
Integer siteId;
String siteName;
while(mi.rs.next()){  
	siteId = mi.rs.getInt(1);
	siteName = mi.rs.getString(2);	
	if(GlobalSiteId == siteId){
%>	
			<option value="<%=siteId%>" selected ><%=siteName%></option>
<%			
		}else{
%>	
			<option value="<%=siteId%>"><%=siteName%></option>
<%				
		}
	}mi.closeAll();
%>
</select>
</td>
<td><input type="hidden" name="hItemCode" value="<%=i_code1%>"/></td>
</tr>
</table>
<br/>
<br/>
<center>
<div id="editDiv" style="height: 30px; width:800px; background-color: #BEF781;">
	<table style="font-size: 120%;">
		<tr>
			<td><b>Site Name : </b></td>
			<td>
				<input type="text" readonly="readonly" name="siteName" size="20" value="-" class="hideTextFieldGreen"/>				
			</td>
			<td>&nbsp;&nbsp;&nbsp;</td>
			<td><b>Price Version : </b></td>
			<td><input type="text" readonly="readonly" name="priceVersion" size="5" value="-" class="hideTextFieldGreen"/></td>
			<td>&nbsp;&nbsp;&nbsp;</td>
			<td><b>Old Quantity : </b></td>
			<td><input type="text" readonly="readonly" name="oldQty" size="5" value="-" class="hideTextFieldGreen"/></td>
			<td>&nbsp;&nbsp;&nbsp;</td>
			<td><b>New Quantity : </b></td>
			<td><input type="text" name="newQuantity" size="5" value="0" readonly="readonly"" /></td>
			<td><input type="hidden"  name="newSiteId"/></td>
			<td><input type="button"  name="Save" value="Save"  onclick ="funSaveQuantity();"/></td>
		</tr>
	</table>
</div>
<br/>
<div id="waitMessage"  style="cursor: sw-resize"></div>
<div id="listDiv" style="height: 200px; width:850px;"></div></center>

<script type="text/javascript">
window.onload = getList;
</script>
</form>