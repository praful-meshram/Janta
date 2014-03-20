// You can find instructions for this file at http://www.treeview.net

//Environment variables are usually set at the top of this file.
USETEXTLINKS = 1
STARTALLOPEN = 0
USEFRAMES = 0
USEICONS = 0
WRAPTEXT = 1
PRESERVESTATE = 1

foldersTree = gFld("", "")

if(user_type_code==2 || user_type_code==4){
	aux19 = insFld(foldersTree, gFld("Sales Analysis ", "SalesAnalysisForm.jsp")) 
		
}
if(user_type_code==2 || user_type_code==4){
	aux21 = insFld(foldersTree, gFld("Inventory Purchase Report ", "InventoryPurchaseReportForm.jsp")) 
		
}


if(user_type_code==2)
	aux1 = insFld(foldersTree, gFld("Sales Summary", "RcustSalesForm.jsp"))
	
 
if(user_type_code==2 || user_type_code==1){  
	aux2 = insFld(foldersTree, gFld("Customer List", "RcustListForm.jsp"))

	aux3 = insFld(foldersTree, gFld("Item  List", "RitemListForm.jsp")) 
}
if(user_type_code==2)
	aux4 = insFld(foldersTree, gFld("Commission ", "RCommissionForm.jsp")) 
	
if(user_type_code==2){
	aux14 = insFld(foldersTree, gFld("Delivery Person ", "RDeliveryStaffForm.jsp"))
}
if(user_type_code==2 || user_type_code==4){
	aux15 = insFld(foldersTree, gFld("Balance Pending ", "BalancePending.jsp")) 
}

if(user_type_code==2 || user_type_code==4){
	aux21 = insFld(foldersTree, gFld("Delayed Orders ","CheckedOrderReport.jsp?call=cheked&submit=aa")) 
}

/* 
	if(user_type_code==2 || user_type_code==4){
	aux22 = insFld(foldersTree, gFld("Item Stock Status ","StockStatusReportForm.jsp")) 
}
 */



if(user_type_code==2 || user_type_code==4){
	aux16 = insFld(foldersTree, gFld("Stock ", "")) 
		aux16_1 = insFld(aux16, gFld("Item Wise ", "SingelItemStack.jsp"))
		aux16_2 = insFld(aux16, gFld("Reorder List ", "ReorderList.jsp") )
		aux16_3 = insFld(aux16, gFld("Stock Movement ", "StockMovementReportForm.jsp") ) 
}

		
if(user_type_code==2){
	aux5 = insFld(foldersTree, gFld("Sales Report ", "")) 
		aux51 = insFld(aux5, gFld("Order Wise ", "") ) 
			aux511 = insFld(aux51, gFld("Daily Sales ", "RCollectionDailyReportForm.jsp"))
			aux512 = insFld(aux51, gFld("Monthly Sales", "RCollectionMonthlyReportForm.jsp"))	
		aux52 = insFld(aux5, gFld("Customer Wise ", "")) 	
			aux521 = insFld(aux52, gFld("Test1 ", "")) 
			aux521 = insFld(aux52, gFld("Test2 ", "")) 
		aux53 = insFld(aux5, gFld("Staff Wise ", "RSalesStaffReportForm.jsp")) 
		aux54 = insFld(aux5, gFld("Item Wise ", "RItemSalesStaffReportForm.jsp"))
	
	/* 	
	aux8 = insFld(foldersTree, gFld("Difference Report ", "")) 
	aux9 = insFld(aux8, gFld("Daily Difference ", "RDifferenceDailyReportForm.jsp")) 
	aux10 = insFld(aux8, gFld("Monthly Difference ", "RDifferenceMonthlyReportForm.jsp")) 
	 */
	
	aux11 = insFld(foldersTree, gFld("Delivery Report ", ""))
	aux12 = insFld(aux11, gFld("Daily Delivery ", "RDeliveryDailyReportForm.jsp")) 
	aux13 = insFld(aux11, gFld("Monthly Delivery ", "RDeliveryMonthlyReportForm.jsp"))
	aux15 = insFld(aux11, gFld("Delivery Analysis", "RADeliveryDailyReportForm.jsp"))
	
	aux16 = insFld(foldersTree, gFld("Customer Statistics ", ""))
	aux17 = insFld(aux16, gFld("All Stats ", "RCustomerStatsForm.jsp")) 
	aux18 = insFld(aux16, gFld("FMCG", "RCustomerFMCGStatsForm.jsp")) 
}
if(user_type_code==2 || user_type_code==1){	
	aux331 = insFld(foldersTree, gFld("Item Sales Report", ""))
	aux332 = insFld(aux331, gFld("Item Summary Report", "ItemSalesSummaryReportForm.jsp")) 	
	aux333 = insFld(aux331, gFld("Item Detail Report", "ItemSalesDetailReportForm.jsp")) 
	
	aux334 = insFld(foldersTree, gFld("Item Analysis", ""))
	aux335 = insFld(aux334, gFld("Daily Modifications", "RDailyModificationForm.jsp")) 	
		
}
if(user_type_code==2){	
	aux20 = insFld(foldersTree, gFld("Customer Payment History", "EditTargetReportForm.jsp?fromForm=CustPmtHstry"))	
}
 
if(user_type_code==2 || user_type_code==4){
	aux17 = insFld(foldersTree, gFld("Packaging ", "")) 
		aux17_1 = insFld(aux17, gFld("Date Wise ", "NewPackagingReportForm.jsp"))
//		aux17_2 = insFld(aux17,gFld("Complete Report"));		
}

 
	
/* 	

	if(user_type_code==2 || user_type_code==4){
	//aux18 = insFld(foldersTree, gFld("Packaging Report ", "PackagingReport.jsp?filter=filterData&value=")) 
	aux18 = insFld(foldersTree, gFld("Packaging Report ", "PackagingReport.jsp")) 
}

	if(user_type_code==2 || user_type_code==4){
	//aux18 = insFld(foldersTree, gFld("Packaging Report ", "PackagingReport.jsp?filter=filterData&value=")) 
	aux20 = insFld(foldersTree, gFld("POP up ALERT ", "popUpAlert.jsp")) 
}
 */
	
