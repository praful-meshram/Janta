<%
	String ibarcode = request.getParameter("ibarcode");
	System.out.println("Barcode "+ibarcode);
	
	item.ManageItem mi;
	mi = new item.ManageItem("jdbc/js");
    if(ibarcode!=null){	
    	mi.listItemBarCode(ibarcode,"");
    }
    String targetItemDetails = "";
    int i=0;
    if(mi.rs.next()){
    	if(i==0)  
    	targetItemDetails=mi.rs.getString("item_code");
    	targetItemDetails=targetItemDetails+"@@"+mi.rs.getString("item_name");
    	targetItemDetails=targetItemDetails+"@@"+mi.rs.getString("item_weight");
    	targetItemDetails=targetItemDetails+"@@"+mi.rs.getString("item_rate");
    	targetItemDetails=targetItemDetails+"@@"+mi.rs.getString("item_mrp");
    	targetItemDetails=targetItemDetails+"@@"+mi.rs.getString("deal_amount");
    	targetItemDetails=targetItemDetails+"@@"+mi.rs.getString("deal_on_qty");
    	targetItemDetails=targetItemDetails+"@@"+mi.rs.getString("item_group_code");
    	targetItemDetails=targetItemDetails+"@@"+mi.rs.getString("barcode");
    	
    	System.out.println("targetItemDetails "+targetItemDetails);  
    	out.println(targetItemDetails);
    }else{
    	 out.println("Barcode does not exist");
    }
   
	 mi.closeAll();			  

  %>  	