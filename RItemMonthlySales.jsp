<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<script src="js/GraphItemMonthlySales.js"></script> 
<script type="text/javascript" src="js/popup.js"></script>

<%
			String str1="";
		    str1=request.getParameter("Exp");		    
		    if(str1.equals("1")){		    	
		    	response.setContentType("application/vnd.ms-excel");    
		    }else{		 
		    	response.setContentType("text/html");		    
		    }
%>
<form name="myform" method="post">
<% 		
	DecimalFormat df = new DecimalFormat("###,###.00");
		
	String frDate="",toDate="";
	String hchckall="";
	String selMonth="",iGroupCode="";
	String criteria ="";
	String type="";
	String name="",desc="";
	String itemWeight="";
	String query="";
	frDate = request.getParameter("frDate");		
	toDate = request.getParameter("toDate");		
	hchckall = request.getParameter("hchckall"); 
	Connection conn=null;
	Statement stmt=null, stat=null;
	ResultSet rs=null, rs2=null;		
	try {
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/js");
		conn = ds.getConnection();
		stmt = conn.createStatement();
			
%> 
		<table  border="1" id="id" class="item3">
	      	
	      			<input type="hidden" name="frDate" value="<%=frDate%>">
		      		<input type="hidden" name="toDate" value="<%=toDate%>">
		      		<input type="hidden" name="hchckall" value="<%=hchckall%>">
		      		
		<br><center><b> Item Sales Report</center> 
     	
		      		
      			
<%
			if(hchckall.equals("1")){		
				query=	"SELECT CONCAT(MONTHNAME(a.order_date),'-',year(a.order_date)),b.item_code, c.item_name,d.item_group_code,d.item_group_desc, c.item_weight,sum(b.qty)" +
					" FROM orders a, order_detail b, item_master c,item_group d" +
					" where a.order_num = b.order_num" +
					" and b.item_code = c.item_code" +
					" and c.item_group_code = d.item_group_code" +
					" group by CONCAT(MONTHNAME(a.order_date),'-',year(a.order_date))," +
					" b.item_code, c.item_name,d.item_group_code,d.item_group_desc,c.item_weight";
					criteria = "All Months";
			}
			else{
			   selMonth = request.getParameter("selMonth");
			   iGroupCode = request.getParameter("iGroupCode");
			   String itemname =  request.getParameter("hitemname");
			   String iname =  request.getParameter("hitem");
			   query = "select CONCAT(MONTHNAME(a.order_date),'-',year(a.order_date)),b.item_code, c.item_name,d.item_group_code,d.item_group_desc, c.item_weight,sum(b.qty)" +
					" from orders a, order_detail b, item_master c,item_group d" +
					" where a.order_num = b.order_num" +
					" and b.item_code = c.item_code" +
					" and c.item_group_code = d.item_group_code";
			   if(! iGroupCode.equals("select")){
					rs = stmt.executeQuery("select item_group_code, item_group_desc from item_group");
				 	while (rs.next()) {
				 		name = rs.getString(1);
					    if(name.equals(iGroupCode)) {
					      desc = rs.getString(2);	
					      criteria = "Month- "+selMonth+", Item Group- "+desc;
					     }
					}
					rs.close();
			   }
				if(!itemname.equals("")){
					String tempArray1[] = new String[100];
					String itemnamelist="";
					tempArray1 = itemname.split("#");
					int strcnt=0;
					if(!tempArray1[0].equals("All")){
						for(int i=0; i<tempArray1.length; i++){	
							if(i == 0){
								itemnamelist = "'"+tempArray1[i]+"'";
							}else{
								itemnamelist = itemnamelist +","+"'"+ tempArray1[i]+"'";
							}
						}
							//System.out.println("itemnamelist : "+itemnamelist);
						criteria = criteria + "Item Names- "+itemnamelist;	
						if(! iGroupCode.equals("select")){
							if(!selMonth.equals("select")){
								query = query +			
									" and MONTHNAME(a.order_date) = '"+selMonth+"'"+
									" and c.item_group_code = '"+iGroupCode+"'" +
									" and c.item_name in ("+itemnamelist+")";
									criteria = "Item Group " +desc +"Month : "+selMonth + "Item Names " + itemnamelist;
							}else{
								query = query +			
									" and c.item_group_code = '"+iGroupCode+"'" +
									" and c.item_name in ("+itemnamelist+")";
									criteria = "Item Group " +desc +"Item Names " + itemnamelist;
						
							}
						}else{
							if(!selMonth.equals("select")){
								query = query +			
								" and MONTHNAME(a.order_date) = '"+selMonth+"'"+
								" and c.item_name in ("+itemnamelist+")";
								criteria = "Month : "+selMonth + "Item Names " + itemnamelist;						
							}else{
								query = query +			
								" and c.item_name in ("+itemnamelist+")";
								criteria = "Item Names " + itemnamelist;						
							}
						}							
					}else{
						criteria = criteria + "Item Names- "+iname;	
						if(! iGroupCode.equals("select")){
							if(!selMonth.equals("select")){
								query = query +			
									" and MONTHNAME(a.order_date) = '"+selMonth+"'"+
									" and c.item_group_code = '"+iGroupCode+"'" +
									" and c.item_name like '"+iname+"%'";
									criteria = "Item Group " +desc +"Month : "+selMonth + "Item Names " + iname;
							}else{
								query = query +			
									" and c.item_group_code = '"+iGroupCode+"'" +
									" and c.item_name like '"+iname+"%'";
									criteria = "Item Group " +desc + "Item Names " + iname;
							}	
						}else{
							if(!selMonth.equals("select")){
								query = query +			
								" and MONTHNAME(a.order_date) = '"+selMonth+"'"+
								" and c.item_name like '"+iname+"%'";
								criteria = "Month : "+selMonth + "Item Names " + iname;
							}else{
								query = query +			
								" and c.item_name like '"+iname+"%'";
								criteria = "Item Names " + iname;
							}	
						}					
					}
				}else{
					if(! iGroupCode.equals("select")){
						if(!selMonth.equals("select")){
							query= query +		
							" and MONTHNAME(a.order_date) = '"+selMonth+"'"+
							" and c.item_group_code = '"+iGroupCode+"'" ;
							criteria = "Item Group " +desc +"Month : "+selMonth;
						}else{
							query= query +		
							" and c.item_group_code = '"+iGroupCode+"'" ;
						}
					}else if(!selMonth.equals("select")){
						query= query +		
							" and MONTHNAME(a.order_date) = '"+selMonth+"'" ;
							 criteria = "Month : "+selMonth;
					}							
				}
				query= query+
					" group by CONCAT(MONTHNAME(a.order_date),'-',year(a.order_date)),"+
					" b.item_code, c.item_name,d.item_group_code,d.item_group_desc,c.item_weight";
					
%>   
				<input type="hidden" name="selMonth" value="<%=selMonth%>">
	      		<input type="hidden" name="iGroupCode" value="<%=iGroupCode%>">
				<input type="hidden" name="hitemname" value="<%=itemname%>">
				<input type="hidden" name="hitem" value="<%=iname%>">
<%			
			}		  
%>
		   <br>	&nbsp	 Criteria&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:  <%=criteria%>
   	
			<tr>				
				<td align="center"><b>Order Date</b></td>
				<% if(str1.equals("0")){	%>
				<td align="center"><b>Detail Information</b></td>
				<%}%>
				<td align="center" ><b>Item Code</b></td>
				<td align="center" ><b>Item Name</b></td>
				<td align="center" ><b>Item Group Name</b></td>
				<td align="center" ><b>Item Weight</b></td>
				<td align="center"><b>Quantity</b></td>										
			</tr>
			
<%   		System.out.println(query);
			rs = stmt.executeQuery(query);
			int   chckcnt=0;
			while(rs.next()){
			    chckcnt++;
				int cnt=1;
				String i_date = rs.getString(cnt++);
				String i_code = rs.getString(cnt++);
				String i_name = rs.getString(cnt++);
				String ig_code = rs.getString(cnt++);
				String ig_name = rs.getString(cnt++);
				String i_weight = rs.getString(cnt++);
				String i_qty = rs.getString(cnt++);
				
%>  	
		
		<tr>					
			<td><!--  <input type="checkbox" name="chck<%=chckcnt%>" value="<%=i_date%>" onclick="funchck('<%=i_date%>','<%=i_code%>','<%=chckcnt%>');" >-->
				<%=i_date%> 
			</td>
			<% if(str1.equals("0")){	%>
			<td>
				<a href="JavaScript:funchck('<%=i_date%>','<%=i_code%>','<%=i_name%>','Customer');">Customer</a>
				&nbsp;&nbsp;<a href="JavaScript:funchck('<%=i_date%>','<%=i_code%>','<%=i_name%>','Item');">Item</a>
			</td>	
			<%}%>
			<td><a href="GraphRItemSales.jsp?itemCode=<%=i_code%>&itemName=<%=i_name%>"><%=i_code%></a></td>
			<td><%=i_name%></td>	
			<td><a href="GraphRItemSales.jsp?igCode=<%=ig_code%>&igName=<%=ig_name%>"><%=ig_name%></td>	
			<td align="right"><%=i_weight%></td>			    
			<td align="right"><%=i_qty%></td>
	 	 
		</tr>  
			  
<%	
		
		  }	
		  rs.close();	
		 	stmt.close();
		 	conn.close();
	}
	catch (Exception e) {
   		e.getMessage();
    	e.printStackTrace();
    	conn.close();    	
	}	
%>
</table> 	
<div id="divDate" align="center" style="border:1px solid black; padding:25px; text-align:center; display:none; background-color:#FFF; overflow:auto; height:400;"></div>
<style type="text/css">
a:link {color: blue}
a:hover {background: blue;color: white}
a:active {background: blue;color: white}
</style>
</table>
<div id="div4" style="VISIBILITY:visible"><table><tr><td><a href="Javascript:Pass();">Save to excel</a></td><td><input type="button" name="return" value="Return" onclick="funReturn();"></td></tr></table></div>

<script>

function passVar(code){
	
		document.myform.orderNo.value=code;
		document.myform.action="print_order.jsp??&backPage=HomeForm.jsp&buttonFlag=Y";
	    document.myform.submit();
	
}
	function Pass(){
		document.myform.action="RItemMonthlySales.jsp?Exp=1";
	    document.myform.submit();
	}
function funReturn(){
		document.myform.action="RItemMonthlySalesForm.jsp";
	    document.myform.submit();
	}
function check(){	
	var jExp=<%=str1%>			
	if(jExp==1){			
		document.getElementById('divexcel').style.visibility="hidden";		
	}
}

	window.onload = check;


</script>

</form></body>
</html>