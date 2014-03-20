<html>
<head>
<%@ page contentType="text/html"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="net.sourceforge.barbecue.*"%>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page errorPage="ReportErrorPage.jsp?page=print_order.jsp" %>
<title>Printing...</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
.boldtable, .boldtable TD, .boldtable TH
{
font-family: consolas;
font-size:11pt;
}

.boldtable1, .boldtable1 TD, .boldtable1 TH
{
font-family: consolas;
font-size:11pt;
}

</style>

</head>
<body>


<form name="myform">
<%
boolean flag1 = true;
//commnet to avoid exception
/* try{
	if(request.getParameter("callfrom").equals("receive_payment_page"))
		flag1 = false;
} catch (Exception e){
	System.out.print("Flag exp : ");
	e.printStackTrace();
} */
			    System.out.print("print order ");				

				DecimalFormat df = new DecimalFormat("###,###.00");
				DecimalFormat dfQty = new DecimalFormat("0.000");
				DecimalFormat dfQty1 = new DecimalFormat("0");
						
				String orderDate="";
				String enteredBy="";				
				String flag="";
				flag= request.getParameter("buttonFlag");
				if (flag==null)
					flag="N";
				int totalItems=0;
				int totalTaken=0;
				int taken_ind=0;
				int itemsPerPage=15;
				int pageItemCount=0;
				int emptyLines=0;
				int  itemQtyCheck=0;
        	    int i=0;
				
				float totalValue=0.0f;
				float itemRate=0.0f;
				float itemQty=0.0f;
				float itemTotPrice=0.0f;
				float itemMRP=0.0f;
				float totalValueMRP=0.0f;
				float savings=0.0f;
				float totalValueDis=0.0f;
				float itemTotDis=0.0f;
				float adv_amt=0.0f;
				float dis_amt=0.0f;
				float bal_amt=0.0f;
				float other_charges_amt=0.0f;				
				
				String username=(String)session.getAttribute("UserName");
				String itemName="";
				String itemWeight="";
				String custCode="";
				String custName="";
				String building="";
				String buildingNo="";
				String block="";
				String wing="";
				String add1="";
				String add2="";
				String area="";
				String phone="";
				String codeValue="";
				String categoryCode="";
				String storeName="";
				String storeAdd1="";
				String storePhone="";
				String billMessage="";
				String disRemark="";
				String p_type="";
				String station="";
				String deliveryRemark="";
        	    
        		String orderNo="",statusCode="";
        		
        		orderNo=request.getParameter("orderNo");
        		statusCode=request.getParameter("statusCode");
        		String backPage="";
        		
        		backPage=request.getParameter("backPage");
             
		String query="",copyOrder="CopyOrder";
		Connection conn=null;
		Statement stat=null;
		ResultSet rs=null;
		try{	
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			//DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			DataSource ds = (DataSource)envContext.lookup("jdbc/js");
			conn = ds.getConnection();
			stat=conn.createStatement();
			query="select code,value from code_table where code in ('StoreName','StoreAdd1','StorePhone','BILLMSG')";
			rs=stat.executeQuery(query);
			
			while(rs.next())
			{
				categoryCode=rs.getString(1);
				codeValue=rs.getString(2);
									
				if (categoryCode.equals("BILLMSG"))
				{
					billMessage=codeValue;
				}
				
				if (categoryCode.equals("StoreName"))
				{
					storeName=codeValue;
				}
				
				if (categoryCode.equals("StoreAdd1"))
				{
					storeAdd1=codeValue;
				}

				if (categoryCode.equals("StorePhone"))
				{
					storePhone=codeValue;
				}				
				
			}
			rs.close();

			query="select DATE_FORMAT(a.order_date,'%d/%m/%y %r'), a.total_items, a.total_taken, a.total_value, " +
					"a.total_value_mrp, a.enterd_by,a.total_value_discount,a.remark, a.advance_amt, a.discount_amt, a.balance_amt, " + 
					"a.other_charges,b.rate, b.qty, b.price, b.mrp, b.item_discount, b.remark,ifnull(e.payment_type_desc,''), b.item_taken, " + 
				  	"d.item_name, d.item_weight, c.custcode,c.custname,c.building,c.building_no, "+
				  	"c.block,c.wing,c.add1,c.add2,c.phone, c.area, c.station " +
					"from orders a left outer join payment_type e on a.payment_type_code = e.payment_type_code, "+
					"order_detail b, customer_master c, item_master d, item_group g " +
					"where a.order_num = b.order_num " +
					"and a.custcode = c.custcode " +
					"and b.item_code = d.item_code " +			
					"and a.order_num = '" + orderNo + "' "+
					" and g.item_group_code = d.item_group_code "+
					"order by g.item_group_number, b.entry_no";
			System.out.println(" Print Query :"+query);		
				rs=stat.executeQuery(query);		
				int ctr = 0, j=0, itemCount=0;
				
			while(rs.next()) {
					
			    i=1;
				itemCount=itemCount+1;
				pageItemCount=pageItemCount+1;		
				
				orderDate=rs.getString(i++);
				totalItems=rs.getInt(i++);
				totalTaken=rs.getInt(i++);
				totalValue=rs.getFloat(i++);
				totalValueMRP=rs.getFloat(i++);
				enteredBy=rs.getString(i++);
				totalValueDis=rs.getFloat(i++);
				deliveryRemark=rs.getString(i++);
				adv_amt=rs.getFloat(i++);
				dis_amt=rs.getFloat(i++);	
				//System.out.println(dis_amt);			
				bal_amt=rs.getFloat(i++);
				other_charges_amt=rs.getFloat(i++);
											
				itemRate=rs.getFloat(i++);
				itemQty=rs.getFloat(i);
				itemQtyCheck=rs.getInt(i++);
					
				itemTotPrice=rs.getFloat(i++);
				itemMRP=rs.getFloat(i++);
				itemTotDis=rs.getFloat(i++);
				disRemark=rs.getString(i++);
				
				p_type=rs.getString(i++);
				taken_ind=rs.getInt(i++);
				
				itemName=rs.getString(i++);
				itemWeight=rs.getString(i++);
				custCode=rs.getString(i++);
				custName=rs.getString(i++);
				building=rs.getString(i++);
				buildingNo=rs.getString(i++);
				block=rs.getString(i++);
				wing=rs.getString(i++);
				add1=rs.getString(i++);
				add2=rs.getString(i++);
				phone=rs.getString(i++);
				area=rs.getString(i++);
				station=rs.getString(i++);
				
				Barcode objBarcode = BarcodeFactory.createCode128C(orderNo+"");
				System.out.println(" Resultset :"+j);	
				//to avoid display order number under barcode image;
				objBarcode.setDrawingText(false);
				System.out.println(" Resultset1 :"+j);	
				String ImagePath = (String) envContext.lookup("imagesfile");
				System.out.println(" Resultset 2:"+j);	
				ImagePath = config.getServletContext().getRealPath(ImagePath)+"/"+orderNo+".PNG";
				System.out.println(ImagePath+" Resultset 3:"+j);	
				//System.out.println("ImagePath :"+ImagePath);
				File f = new File(ImagePath);            	
                BarcodeImageHandler.savePNG(objBarcode, f);
               	
				
					
	if (ctr==0) {	%> 
	
	<table class='boldtable' width=710 cellpadding='0' cellspacing='4' border='0'> 
	<tr><td width='15%' colspan=2 align='right'>&nbsp;</td>
	<td width='60%' colspan=2 align='center'>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<img src="images/barcodeImages/<%=orderNo%>.PNG" width="120px;"/></td>
	<td width='25%' colspan=2 align='right'></td>
	</tr>
	
	<tr><td colspan=6></td></tr>
	<tr><td colspan=2 align='right'><%=totalItems%>-<%=totalTaken%>=<%=totalItems - totalTaken%></td>
		<td colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=orderDate%> (<%=username%>)</td><tr>	
	<tr><td colspan=6></td></tr>
	<tr><td colspan=6></td></tr>
		
	<tr>
		<td width='15%' colspan=2 align='right'><%=custCode%></td>
<%			if(!deliveryRemark.equals("")){
				if(other_charges_amt>0){	
%>
			<td width='60%' colspan=2 align='center'><%=custName%> (DI: <%=deliveryRemark%>) (Oth Chrgs : <%=other_charges_amt%>)</td>
<%				}else if(other_charges_amt<=0){
%>
			<td width='60%' colspan=2 align='center'><%=custName%> (DI: <%=deliveryRemark%>)</td>
<%				}
			}else if(deliveryRemark.equals("")){
				if(other_charges_amt>0){
%>
					<td width='60%' colspan=2 align='center'><%=custName%> (Oth Chrgs : <%=other_charges_amt%>)</td>
<%				}else if(other_charges_amt<=0){
%>	
				<td width='60%' colspan=2 align='center'><%=custName%></td>				
<%				}
				System.out.println("deliveryRemark "+deliveryRemark);
			}
%>


		<td width='25%' colspan=2 align='right'></td>
	</tr>
	
	
		<tr>
		<td colspan=5 width='80%'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=buildingNo%>, <%=wing%>, <%=block%>, <%=building%>, <%=area%></td>
		<td colspan=1 width='20%' align='right'><%=phone%></td>
	</tr>
	
	<tr>
		<td colspan=5 width='80%'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=add1%> ,<%=add2%>, <%=station%></td>
		<!--  <td colspan=1 width='20%' align='right' height="100%"><img src="images/barcodeImages/<%=orderNo%>.PNG" width="150" height="105%"/></td>-->
		<td colspan=1 width='20%' align="right"><%=orderNo%></td>
	</tr>
	<tr><td colspan=6></td></tr>
	<tr><td colspan=6></td></tr>
	<tr><td colspan=6></td></tr>
	<tr><td colspan=6></td></tr>
	</table>
<% ctr = ctr + 1; 
	} 
	savings = totalValueMRP - totalValue;
	if(savings<0)
		savings=0.0f;
	
	%>
	<table class='boldtable1' width=700 cellpadding='0' cellspacing='3' border='0'>

<tr>
	<td width='9%' valign=top align="left"><%=itemWeight%></td>
	<% if ((itemQtyCheck-itemQty)==0)
	{ %>
	<td width='6%' valign=top align="left"><%=dfQty1.format(itemQty)%></td>
	<% } else { %>
	<td width='6%' valign=top align="left"><%=dfQty.format(itemQty)%></td>
	<% } %>
	
	<td width='55%' valign=top align="left"><%=itemName%>&nbsp;<%=disRemark%></td>
	<% if(taken_ind > 0) { %>
		<td width='10%' valign=top>Taken</td>
	<% } else { %>
	<td width='10%' valign=top align="left">&nbsp;</td>
	<%}%>
	<td width='10%' valign=top align=right><%=df.format(itemTotPrice)%></b></td>
	<% if(itemMRP<=0) { %>
	<td width='10%' valign=top align=right>NA</td>
	<% } else { %>
	<td width='10%' valign=top align=right><%=df.format(itemMRP)%></td>
	<%}%>
</tr>

<% 
if(flag1){
if ((pageItemCount == itemsPerPage)&&(itemCount != totalItems)) 
{ 
	pageItemCount = 0;%>
<tr>
	<td colSpan=6 align=right>Contd..</td>	

</tr>
<tr><td colSpan=6><p style="page-break-after:always;">&nbsp;</p></td></tr>

<tr><td colspan=6>&nbsp;</td></tr>
<tr><td colspan=6>&nbsp;</td></tr>
<tr><td colspan=6>&nbsp;</td></tr>
<tr><td colspan=6>&nbsp;</td></tr>
<tr><td colspan=6>&nbsp;</td></tr>
<tr><td colspan=6>&nbsp;</td></tr>

 <%
}

if (itemCount==totalItems) {
	emptyLines = itemsPerPage - (totalItems%itemsPerPage);
	while ((emptyLines > 0)&&(emptyLines !=itemsPerPage)) { %>

	<tr><td width='100%' colspan=6>&nbsp;</td></tr>

<% emptyLines=(emptyLines - 1);} } }}%>

<tr>
	<% if (bal_amt == 0 ) { %>
	<td colSpan=5 width='92%' cellspacing='0' align='right'><font size="5"><B><%=df.format(totalValue)%></b></font></td>
	<td colSpan=1 width='8%' cellspacing='0' align='right'>(<%=p_type%>)</td>	
	<% } else { %>
	<td colSpan=6 width='100%' cellspacing='0' align='right'><%=df.format(totalValue)%>(A:<%=df.format(adv_amt)%>,D:<%=df.format(dis_amt)%>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size="5pt"><B>Bal:<%=df.format(bal_amt)%></b></font>(<%=p_type%>)</td>
	<% } System.out.println("\n\n\ntotal value "+totalValue+"\t bal amt "+bal_amt);%>
</tr>

 <tr><td colSpan=6 cellspacing='0' align='center'><%= df.format(savings)%>/-</td></tr>

</table>
<%
		
		rs.close();
		stat.close();
		conn.close();
	}catch(Exception e)
	{
		System.out.println("Exception occured in print order.jsp ="+e);
		e.printStackTrace();
		rs.close();
		stat.close();
		conn.close();
	}

%>
<br><br>
<input type="hidden" name="horderNo" value="">
<input type="hidden" name="orderNo" value="">
<input type="hidden" name="backPage" value="<%=backPage%>">
<input type="hidden" name="hstatusCode" value="">
<input type="hidden" name="hcopy" value="">
</form>
<div id="id1">

<%
if(flag1){
%>
<input type="submit" id="Submit" value="Print <Alt+p>" accesskey="p" onClick="Pass();">
<input type="button" id="Edit" value="Edit <Alt+e>" accesskey="e" onClick="Edit();">
<input type="button" id="Cancel" value="Return <Alt+r>" accesskey="r" onClick="back();">
<input type="button" id="Copy" value="Copy <Alt+c>" accesskey="c" onClick="copy();">
<%
}
%>
</div>

</body>
</html>

<script>
function Fun_Print(){    
     document.getElementById('id1').style.visibility="hidden";
     self.print();
     back();
}

function Pass(){
	document.myform.orderNo.value="<%=orderNo%>";
	document.myform.backPage.value="<%=backPage%>";
	document.myform.action="print_order1.jsp?orderNo=<%=orderNo%>";
	document.myform.submit();
	
}


function back(){
	var backPage="";
	backPage ="<%=request.getParameter("backPage")%>";
	window.location=backPage;
}
function Edit(){
	document.myform.hcopy.value="";
	document.myform.horderNo.value="<%=orderNo%>";
	document.myform.hstatusCode.value="<%=statusCode%>";		
	document.myform.action="EditOrderForm.jsp";
	document.myform.submit();

}
function copy(){
	document.myform.horderNo.value="<%=orderNo%>";
	document.myform.hcopy.value="<%=copyOrder%>";
	document.myform.action="EditOrderForm.jsp";
	document.myform.submit();
}
window.onload = function(){
	var isPrint="<%=flag%>";
	if (isPrint == "N") {
		//Fun_Print();
	}
}	
</script>
