// You can find instructions for this file at http://www.treeview.net

//Environment variables are usually set at the top of this file.
USETEXTLINKS = 1
STARTALLOPEN = 0
USEFRAMES = 0
USEICONS = 0
WRAPTEXT = 1
PRESERVESTATE = 1


foldersTree = gFld("", "")
	//aux1 = insFld(foldersTree, gFld("Submitted", "OrderProcessing.jsp"))
	aux1 = insFld(foldersTree, gFld("Submitted",""))
		 aux11 = insFld(aux1, gFld("Today", 'javascript:showHint("OrderProcessing.jsp?subValue=Submitted1")'))
	 	 aux12 = insFld(aux1, gFld("Last Five Days", 'javascript:showHint("OrderProcessing.jsp?subValue=Submitted2")'))
		 aux13 = insFld(aux1, gFld("All", 'javascript:showHint("OrderProcessing.jsp?subValue=Submitted3")'))
		 aux14 = insFld(aux1, gFld(" Bulk Send", 'javascript:showHint("OrderProcessingSend.jsp?subValue=Submitted3&send=nsend&arraycnt=0")'))

			
	aux7 = insFld(foldersTree, gFld("Checked", ""))	 
		 aux71 = insFld(aux7, gFld("Today", 'javascript:showHint("OrderProcessing.jsp?subValue=Checked1")'))
	 	 aux72 = insFld(aux7, gFld("Last Five Days", 'javascript:showHint("OrderProcessing.jsp?subValue=Checked2")'))
		 aux73 = insFld(aux7, gFld("All", 'javascript:showHint("OrderProcessing.jsp?subValue=Checked3")'))
		 aux74 = insFld(aux7, gFld(" Bulk Send", 'javascript:showHint("OrderProcessingSend.jsp?subValue=Checked3&send=nsend&arraycnt=0")'))

	aux8 = insFld(foldersTree, gFld("Submitted & Checked", 'javascript:showHint("OrderProcessingSend.jsp?subValue=Both&send=nsend&arraycnt=0")'))	 
	//aux2 = insFld(foldersTree, gFld("Transit", 'javascript:showHint("TransitOrdersDetails.jsp")'))
	aux2 = insFld(foldersTree, gFld("Transit","" ))
		 aux21 = insFld(aux2, gFld("Today", 'javascript:showHint("OrderProcessing.jsp?subValue=Transit1")'))
	 	 aux22 = insFld(aux2, gFld("Last Five Days", 'javascript:showHint("OrderProcessing.jsp?subValue=Transit2")'))
		 aux23 = insFld(aux2, gFld("All", 'javascript:showHint("OrderProcessing.jsp?subValue=Transit3")'))
		 aux24 = insFld(aux2, gFld("by Delivery Person", ""))		
	
	//aux3 = insFld(foldersTree, gFld("Delivered", 'javascript:showHint("DeliveredOrdersDetails.jsp")')) 
	aux3 = insFld(foldersTree, gFld("Delivered", "")) 
		 aux31 = insFld(aux3, gFld("Today", 'javascript:showHint("OrderProcessing.jsp?subValue=Delivered1")'))
	 	 aux32 = insFld(aux3, gFld("Last Five Days", 'javascript:showHint("OrderProcessing.jsp?subValue=Delivered2")'))
		 aux33 = insFld(aux3, gFld("All", 'javascript:showHint("OrderProcessing.jsp?subValue=Delivered3")'))
	
	aux4 = insFld(foldersTree, gFld("Hold", ""))
		 aux41 = insFld(aux4, gFld("Today", 'javascript:showHint("OrderProcessing.jsp?subValue=Hold1")'))
	 	 aux42 = insFld(aux4, gFld("Last Five Days", 'javascript:showHint("OrderProcessing.jsp?subValue=Hold2")'))
		 aux43 = insFld(aux4, gFld("All", 'javascript:showHint("OrderProcessing.jsp?subValue=Hold3")'))
	
	aux5 = insFld(foldersTree, gFld("Closed ", "")) 
		 aux51 = insFld(aux5, gFld("Today", 'javascript:showHint("OrderProcessing.jsp?subValue=Closed1")'))
	 	 aux52 = insFld(aux5, gFld("Last Five Days", 'javascript:showHint("OrderProcessing.jsp?subValue=Closed2")'))
		 aux53 = insFld(aux5, gFld("All", 'javascript:showHint("OrderProcessing.jsp?subValue=Closed3")'))
		 
	aux6 = insFld(foldersTree, gFld("Delivery Report ", ""))
		/*aux61 = insFld(aux6, gFld("Daily Delivery ", 'javascript:showHint("RDeliveryDailyReportForm.jsp")')) 
		aux62 = insFld(aux6, gFld("Monthly Delivery ", 'javascript:showHint("RDeliveryMonthlyReportForm.jsp")'))*/
		aux61 = insFld(aux6, gFld("Daily Delivery ", "RDeliveryDailyReportForm.jsp")) 
		aux62 = insFld(aux6, gFld("Monthly Delivery ", "RDeliveryMonthlyReportForm.jsp"))
	
	

