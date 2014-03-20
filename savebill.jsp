<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html"%>
<%
        int max=0;
		int i=0;
        int totCount=0;
        int totItems=0;
        int totDisTimes = 0;
        long totPickupItems=0;
        long pickup_ind=0;
        
        float disQty =0.0f;
        float itemRate=0.0f;
        float itemMRP=0.0f;
		float itemQty=0.0f;
		float totItemPrice=0.0f;
		float totOrderValue=0.0f;
		float totMRPValue=0.0f;
		float totItemDisAmt=0.0f;
		float totDisValue=0.0f;
		float minDisAmt=0.0f;
		
		
   		String itemCode="";
       	String customerCode="";
   		String query="";   	
   		String nullCheck="";
   		String disRemark="";
   		String p_type="";
   		String user="";
   		String status="";
   	
   		
        totCount=Integer.parseInt(request.getParameter("hidCount"));
        totItems=Integer.parseInt(request.getParameter("htotalSel"));
        customerCode=request.getParameter("cusCode");
       	totOrderValue=Float.valueOf(request.getParameter("htotOrderValue")).floatValue();
       		System.out.println(totOrderValue);
       	totOrderValue = 0.0f;
       		System.out.println(totOrderValue);
       	totMRPValue=Float.valueOf(request.getParameter("htotMRPValue")).floatValue();
       	p_type=request.getParameter("p_type");
       	user=(String)session.getAttribute("UserName");
	
		order.ManageOrder mo;
		mo = new order.ManageOrder("jdbc/js");
		max=mo.getOrderNum();
		status=mo.getStatus("SUBMITTED");
   	 	for(i=1;i<=totCount;i++) {
   	 		
   	 		nullCheck = request.getParameter("items"+i+"_hidden");
   	 		if(nullCheck != null)
   	 		{
   	 			itemRate=Float.valueOf(request.getParameter("hidRate"+i)).floatValue();
   	 			itemMRP=Float.valueOf(request.getParameter("mrp"+i)).floatValue();
    		    itemQty=Float.valueOf(request.getParameter("quantity"+i)).floatValue();
    			itemCode=request.getParameter("items"+i+"_hidden");
    			disQty=Float.valueOf(request.getParameter("hidDisQty"+i)).floatValue();
    			minDisAmt=Float.valueOf(request.getParameter("hidDisAmt"+i)).floatValue();
    			pickup_ind = Long.parseLong(request.getParameter("hitem_taken_ind"+i));
    			totPickupItems = totPickupItems + pickup_ind;
    			disRemark= request.getParameter("delRemark"+i);
    			
    			totDisTimes = (int)(itemQty / disQty);
    			
    			
				if(totDisTimes >= 1) totItemDisAmt = minDisAmt * totDisTimes;
				else totItemDisAmt=0;
							        			
    			if(totItemDisAmt>0)
    			{
    				disRemark=totItemDisAmt+ "(@Rs " + Float.valueOf(request.getParameter("hidDisAmt"+i)).floatValue() +
    							" per " + Float.valueOf(request.getParameter("hidDisQty"+i)).floatValue() + " QTYs)";
    			}
    			
    			
    			totItemPrice=(itemQty*itemRate) - totItemDisAmt;
    					System.out.println(totItemPrice);
    			totOrderValue = totOrderValue + totItemPrice;
    			
    				System.out.println(totOrderValue);
    			totDisValue = totDisValue + totItemDisAmt;
    			System.out.println(totDisValue);
    			         	
     			mo.addOrderDetail(max,itemCode,itemRate,itemQty,totItemPrice,totItemDisAmt,disRemark,itemMRP,i,pickup_ind); 			 			
    		}
        }

       	mo.addOrders(max,customerCode,totItems,totPickupItems,totOrderValue,totMRPValue,totDisValue,user,p_type,status);
       	mo.closeAll();
       	String sendURL="";
		String backPage=request.getParameter("backPage");
	
		if(!backPage.equals("create_newCustomer.jsp")) backPage="customer_detailsForm.jsp";
		sendURL="print_order1.jsp?orderNo=" + max+ "&backPage=" +backPage;
		//sendURL="customer_detailsForm.jsp";
			
		response.sendRedirect(sendURL);
		

%>


		