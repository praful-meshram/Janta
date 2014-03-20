<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<jsp:include page="header.jsp" /> 
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="create_newCustomer.jsp" />	
</jsp:include>



<%@page contentType="text/html"%>
<script type="text/javascript">
      	window.onload=Check;
      	function Check(){
<%
		String backPage="";        		
        backPage=request.getParameter("backPage");
        System.out.println("back page :"+backPage);
        String custName="";
        String mobile="";
		String phoneNo="";
		String building="";
		String buildingno="";
		String block="";
		String wing="";
		String add1="";
		String add2="";
		String area="";
		String station="";
		String pinCode="";
		String city="";
		String state="";
		String country="India";
				
		custName=request.getParameter("cusName");
		mobile=request.getParameter("mobile");
		phoneNo=request.getParameter("phone");
		building=request.getParameter("building");
		buildingno=request.getParameter("buildingno");
		block=request.getParameter("block");
		wing=request.getParameter("wing");
		add1=request.getParameter("add1");
		add2=request.getParameter("add2");		
		area=request.getParameter("area");
		station=request.getParameter("station");
		pinCode=request.getParameter("pinCode");
		city=request.getParameter("city");
		state=request.getParameter("state");
		
		
		String payment = request.getParameter("payment");
		
			String get1="",code="";
			int cusCode=0;
			code.ManageCode c1;
			c1 = new code.ManageCode("jdbc/js");
			get1 = c1.getCodeValue("CustCodeStart"); 
			code = c1.getCodeValue("NextCustCode");			
			cusCode=Integer.parseInt(code);
			get1=get1+cusCode;	
			cusCode= cusCode + 1;
			
		customer.ManageCustomer c;
		c = new customer.ManageCustomer("jdbc/js");
		String ans = c.addCustomer(get1,custName, building, buildingno, block, wing, add1, add2, area, station, city, state, country, pinCode, phoneNo,payment,mobile); 
		
    	if(ans.equals("JS")){
    	 	c1.editCodeValue(cusCode,"NextCustCode");
    	 	c1.closeAll();
    	 	if(backPage.equals("customer_detailsForm.jsp")){
%>	
			alert("Sucessfully Created User");
			//alert(window.parent.location.href);
			//window.parent.location.replace("cust_orderBill.jsp?hadd1=<%=add1%>&hadd2=<%=add2%>&hcuscode=<%=get1%>&harea=<%=area%>&backPage=create_newCustomer.jsp")
			
			window.close();
			
<%			}


		}
		c.closeAll();
    	
%>   
	
      	}
</script> 

<h3><b><br><br><br><center> Sucessfully Created User <font color=blue>   <%=get1%>, <%=custName%> ,<%=phoneNo%>  <a href="create_newCustomerForm.jsp">   Create New Customer</a></center></b></h3>	



	
	
		