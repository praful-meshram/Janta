<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>

<form name="createChart" >
 <table><tr>

<%	

	/*
			type of chart::
			----------------
			1. Area2D
			2. Bar2D
			3. Column2D
			4. Column3D
			5. Funnel
			6. Line
			7. Pie2D
			8. Pie3D
			9. Doughnut2D
	*/

	int height=600;
	int width=500;
	String chartName="Column3D";
	String caption="Item Sales Report";
	String xAxisName="Month-Year";
	String yAxisName="Quantity";
	String yAxisName1="Price";
	ArrayList Xvalue=new ArrayList();
	ArrayList Yvalue=new ArrayList();
	ArrayList Yvalue1=new ArrayList();
	//ArrayList descArr=new ArrayList();
	String[] Color={"AFD8F8","F6BD0F","8BBA00","FF8E46","008E8E","D64646","8E468E","588526","B3AA00","008ED6","9D080D","A186BE"};


	 
	 
		item.ManageItem i;
		i = new item.ManageItem("jdbc/js");
		String criteria="";
		String itemCode = request.getParameter("itemCode");	
		if(itemCode != null){
			i.ItemSalesGraph(itemCode,"","00-00-0000",""); 
			String itemName = request.getParameter("itemName");
		    criteria = " Item: "+itemName;
		}else {
			String igCode = request.getParameter("igCode");
			i.ItemSalesGraph("",igCode,"00-00-0000",""); 
			String igName = request.getParameter("igName");
		    criteria = " Item Group: "+igName;	
		}
	
	while(i.rs.next()){		
		Xvalue.add(i.rs.getString(1));
		Yvalue.add(i.rs.getInt(2));	
		Yvalue1.add(i.rs.getInt(3));		
	}	
	chart.createChart crt = new chart.createChart();
	String chartCode= crt.displayChart(chartName,caption,xAxisName,yAxisName,height,width,Xvalue,Yvalue,Color);

%>
<td>
	<br><h5><center> Monthly/Yearly Distibution For <font color="blue"><%=criteria%></font></center></h5>
   	
</td>
</tr>
<tr>
<td> 
 <%=chartCode%> 
 </td>
 <td>  
<%
	String chartName1="Column3D";
	chart.createChart crt1 = new chart.createChart();
	String chartCode1= crt1.displayChart(chartName1,caption,xAxisName,yAxisName1,height,width,Xvalue,Yvalue1,Color);
%>
 
 <%=chartCode1%>  
 </td></tr></table> 
</form>   
</BODY>
</HTML>
