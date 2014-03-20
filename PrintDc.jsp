<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@page contentType="text/html"%>

<head>
<title>Printing...</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
.boldtable, .boldtable TD, .boldtable TH
{
font-family: serif;
font-size:11pt;

}

.boldtable1, .boldtable1 TD, .boldtable1 TH
{
font-family:serif;
font-size:11pt;

}

</style>

</head>
<body>

<%
		DecimalFormat df = new DecimalFormat("###,###.00");
		DecimalFormat dfQty = new DecimalFormat("0.000");
		DecimalFormat dfQty1 = new DecimalFormat("0");
				
		String orderDate="",sentDate="";
		int totalItems=0;
		int totalTaken=0;
		int balanceItmes=0;
		int taken_ind=0;
		int itemsPerPage=15;
		int pageItemCount=0;
		int emptyLines=0;
		int  itemQtyCheck=0;
		float totalValue=0.0f;
		String enteredBy="";
		
		float itemRate=0.0f;
		float itemQty=0.0f;
		float itemTotPrice=0.0f;
		float itemMRP=0.0f;
		float totalValueMRP=0.0f;
		float savings=0.0f;
		float totalValueDis=0.0f;
		float itemTotDis=0.0f;
		float other_charges =0.0f;
		
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
		String advance="";
		String discount="";
		String balance="";
		String change_amt="";
	
		String deliveryPerson="";
	    int i=0;
	 
         String[] orderno ; 
		 String orderStr="";	
	 	 orderStr = request.getParameter("orderNo");
	 	 orderno = orderStr.split(","); 			
		String query="";
		Connection conn=null;
		Statement stat=null;
		ResultSet rs=null;
		try{	
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
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
			//System.out.println("orderno.length"+orderno.length);
		for(int cnt=0; cnt <orderno.length;cnt++){		
		//System.out.println("orderno"+orderno[cnt]);
			query="select DATE_FORMAT(a.sent_datetime,'%d/%m/%y %r'), a.total_items, a.total_taken, a.total_value, " +
					"a.total_value_mrp, a.enterd_by,a.total_value_discount,a.remark, " + 
					"b.rate, b.qty, b.price, b.mrp, b.item_discount, b.remark,e.payment_type_desc, b.item_taken, " + 
				  	"d.item_name, d.item_weight, c.custcode,c.custname,c.building,c.building_no,c.block,c.wing,c.add1, "+
				  	"c.add2,c.phone, c.area, c.station,a.advance_amt,a.discount_amt,a.balance_amt,f.dstaff_name, " +
					"a.other_charges, a.change_amt "+
					"from orders a, order_detail b, customer_master c, item_master d ,payment_type e, " +
					"delivery_staff f where a.order_num = b.order_num " +
					"and a.custcode = c.custcode " +
					"and b.item_code = d.item_code " +
					"and a.payment_type_code = e.payment_type_code "+
					"and a.dstaff_code=f.dstaff_code and a.order_num = '" + orderno[cnt] + "' "+
					"order by b.entry_no limit "+1+"";
				rs=stat.executeQuery(query);		
				int ctr = 0, j=0, itemCount=0;
				
			while(rs.next()) {
			    
				i=1;
				itemCount=itemCount+1;
				pageItemCount=pageItemCount+1;		
				
				//orderDate=rs.getString(i++);
				sentDate=rs.getString(i++);
				totalItems=rs.getInt(i++);
				totalTaken=rs.getInt(i++);
				totalValue=rs.getFloat(i++);
				totalValueMRP=rs.getFloat(i++);
				enteredBy=rs.getString(i++);
				totalValueDis=rs.getFloat(i++);
				deliveryRemark=rs.getString(i++);
				
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
				advance=rs.getString(i++);
				discount=rs.getString(i++);
				balance=rs.getString(i++);
				deliveryPerson=rs.getString(i++);
				other_charges =rs.getFloat(i++);	
				change_amt =rs.getString(i++);
					
				if(advance==null)
					advance="0";
					
				if(discount==null)					
					discount="0";

				if(balance==null)
					balance="0";

				balanceItmes = totalItems-totalTaken;
				
	if (ctr==0) {	 %>
	<table class='boldtable' width=710 cellpadding='0' cellspacing='4' border='0' width=100%>

	<tr>
		<td colspan=6>&nbsp;</td>
	</tr>
	<tr>
		<td width='100%' colspan="12"align='left'>Order No&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=orderno[cnt]%> Date & Time : <%=sentDate%>  Delv Person : <%=deliveryPerson%></td>
		
	</tr>	
	<tr><td colspan=6></td></tr>		
	<tr><td colspan=6></td></tr>
			
	<tr>
		<td width="50%" align='left'>Customer Code : <%=custCode%></td>
		
		<%if(!deliveryRemark.equals("")){ %>
			<td colspan=2 align='left'>Customer Name : <%=custName%> (DI: <%=deliveryRemark%>)</td>
		<%}else if(deliveryRemark.equals("")){ %>
			<td colspan=2 align='left'>Customer Name : <%=custName%></td>
		<%}%>		
<!--		<td width='25%' colspan=2 align='right'><%=orderDate%></td>    -->
	</tr>
	
	<tr>
		<td colspan=5 width='80%' align='left'>Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp: <%=buildingNo%>, <%=wing%>, <%=block%>, <%=building%>,<%=area%></td>
	</tr>
	
	<tr>
		<td colspan=5 width='80%'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=add1%> ,<%=add2%>, <%=station%> </td>
<!--		<td colspan=1 width='20%' align='left'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><br> -->
		<tr>
			<td width='60%'colspan=4 align='left'>Phone No&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=phone%></td>
		</tr>
	</tr>
	
	<tr><td colspan=6>&nbsp;</td></tr>

	<tr>
	<td colspan="10">
	<table border="0">
		<tr>
		<td colspan="2" align ="left" width="50%">
			<table border="0">
					<tr>
						<td align='left'>Total Items &nbsp;&nbsp;&nbsp;&nbsp; : <%=totalItems%></td>
					</tr>  
					<tr>
						<td  align='left'>Total Taken &nbsp;&nbsp;&nbsp; : <%=totalTaken%></td>
					</tr>
					<tr>
						<td align='left'>Balance Itmes&nbsp;&nbsp; : <%=balanceItmes%></td>
					</tr>
					<tr>
						<td  align='left'>Payment Type &nbsp;: <%=p_type%></td>
					</tr>	
			</table>			
		</td>
		 <td ></td>	
		<td   align="right" width="50%">
			<table border="0" align="left">
					<tr>
<%					if(other_charges <=0){
%>					
						<td align='left'>Total Amount &nbsp;&nbsp;&nbsp;&nbsp; : <%=totalValue%></td>
<%					}else if(other_charges >=0){
%>
						<td align='left'>Total Amount &nbsp;&nbsp;&nbsp;&nbsp; :  <%=totalValue%> (Dlv : <%=other_charges%>)</td>
<%					}
					double adamt = 0.0f;
					if(advance != null && discount != null){
						adamt = Double.parseDouble(advance) + Double.parseDouble(discount);
			    	}
%>					
					</tr>
					<tr>
						<td  align='left'>Adv/Dis Amt &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: <%=adamt%></td>
					</tr>				
					<tr>
						<td  align='left'>Bal Amt &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <%=balance%></td>
					</tr>
					<tr>
						<td  align='left'>Change Amt &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <%=change_amt%></td>
					</tr>
<%
					double amtdue=0.0f;
					if(balance != null && change_amt != null){
						amtdue = Double.parseDouble(balance) + Double.parseDouble(change_amt);
			    	}

%>
					<tr>
						<td  align='left'>Amount Due &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <%=amtdue%></td>
					</tr>
			</table>					
		</td>
		</td></tr></table>
	</tr>
	
	</table>
<% ctr = ctr + 1; 
	} 
	savings = totalValueMRP - totalValue;
	if(savings<0)
		savings=0.0f;
	%>
<%  } 
%>
<table>
	<tr>
		<td></td>
		<td colspan="2"></td>
	</tr>
	<tr widht="20%">
		<tr>
			<td colspan="10" widht="60%"></td>	
		</tr>
		<br><br>
		<tr>
			<td colspan="10" widht="60%">Please check your items when delivered and then sign here.</td>	
		</tr>			
		<tr>
			<td colspan="10" widht="60%">
				Your signature indicates that you have checked your items.
			</td>
		<tr>
	</tr>
<%  if( cnt < orderno.length-1) {
%>
	<tr><td colSpan=6><p style="page-break-after:always;">&nbsp;</p></td></tr>
<%}%>
<tr><td>
<input type="button" value="Print <Alt+p>" accesskey="p" onClick="Fun_Print();">

<input type="button" value="Cancel <Alt+s>" accesskey="s" onClick="Fun_Close();">
</td>

</table>
<%
        }
		rs.close();
		stat.close();
		conn.close();
	}catch(Exception e)
	{
		System.out.println(e);
		e.printStackTrace();
		rs.close();
		stat.close();
		conn.close();
	}

%>


<script>
function Fun_Print(){    
     self.print();
     window.close();
}

function Fun_Close(){
	window.close();
}

</script>