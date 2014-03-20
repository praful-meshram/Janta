var xmlHttp,xmlHttp1;
var count=0,j;
var presentCount=0;
var fActiveMenu = false;

function showHint1() {
	var str1;
	str1=document.myform.orderNo.value;
	
	if (str1.length==0)
  	{   		
  		return;
  	}
	xmlHttp1=GetXmlHttpObject()
	if (xmlHttp1==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="getItemList.jsp";
	url=url+"?orderNo="+str1+"";
	xmlHttp1.onreadystatechange=stateChanged1;
	xmlHttp1.open("GET",url,true);
	xmlHttp1.send(null);
} 

function stateChanged1() 
{
	if (xmlHttp1.readyState==4)
	{ 
		 var ans = xmlHttp1.responseText;
		 var presentCount=0,tmpStr="";
		 eval(document.myform.htotPickup.value==0);	 
		 ans= ans.replace(/^\s+|\s+$/g,'');		
	     eval("var orderData=" + ans);
	     for(i=0;i<orderData.length;i++)	     
	     { 
	     	addRow();
	     	
	     	presentCount = presentCount + 1;	     	
	     	tmpStr = eval("document.myform.items" +presentCount+"_hidden")
	     	tmpStr.value=orderData[i][0];	     	
	     	tmpStr = eval("document.myform.items" +presentCount)
	     	tmpStr.value=orderData[i][1];	     	
	     	document.getElementById("rate"+presentCount).innerHTML="<input type='text' name='hidRate" + presentCount +"' value='"+orderData[i][3]+"' onkeyup='calculateByRate(this.value," + presentCount + ")'>";
	   		document.getElementById("weight"+presentCount).innerHTML=orderData[i][2];
	   		document.getElementById("qty"+presentCount).innerHTML="<input type='text' name='quantity" + presentCount + "' value='"+orderData[i][4]+"' onkeyup='calculate(this.value," + presentCount + ")' onblur='qtyValidate(this.value," + presentCount + ")' >";
	   		document.getElementById("jantaPrice"+presentCount).innerHTML=orderData[i][5];
	   		eval("document.myform.mrp" +presentCount+ ".value=" + orderData[i][6]);
			document.getElementById("price"+presentCount).innerHTML=orderData[i][6];
			if(orderData[i][7]==1){
				eval("document.myform.htotPickup.value++");
				document.getElementById("p_ind"+presentCount).checked=true;												
				document.getElementById("hitem_taken_ind"+presentCount).value=1;
				
			}
			else{
				document.getElementById("p_ind"+presentCount).checked=false;				
				document.getElementById("hitem_taken_ind"+presentCount).value=0;
				
			}
			eval("document.myform.hidDealFlag" +presentCount+ ".value='" +orderData[i][8] + "'");
			if (orderData[i][8]=="Y")
			{
				document.getElementById("dealRemark"+presentCount).innerHTML="<input type='text' name='delRemark" + presentCount + "' tabindex=5 size='3' value='Rs: " + orderData[i][10] + " on " + orderData[i][9] + " QTYs' ><A href='javascript:void' onfocus='addRow();' tabindex=6>";
			}	else
				document.getElementById("dealRemark"+presentCount).innerHTML="<input type='text' name='delRemark" + presentCount + "' tabindex=5  size='3' value='"+orderData[i][12]+"' ><A href='javascript:void' onfocus='addRow();' tabindex=6>";
			

			
			eval("document.myform.hidDisQty" +presentCount+ ".value=" +orderData[i][9]);
			eval("document.myform.hidDisAmt" +presentCount+ ".value=" + orderData[i][10]);
			document.getElementById("discount"+presentCount).innerHTML=orderData[i][11];
			itemCalculate(5);
	     }
			
	}	
}

	
function selectedItem(pCount)
{
		presentCount = pCount;
		xmlHttp=GetXmlHttpObject();
		var url="getItemDetails.jsp";
		//var url="ItemDetails.jsp";
		
		var ans = eval("document.myform.items"+pCount+"_hidden.value")
	
	//	eval("document.myform.quantity" +pCount+ ".focus()");
		url=url+"?ItemName="+ans+"&t="+new Date().getTime();
//		url=url+"?ItemName="+selected_value+"&t="+new Date().getTime();
		url=url+"&sid="+Math.random();
		xmlHttp.onreadystatechange=getRate;
		xmlHttp.open("GET",url,true);
		xmlHttp.send(null);

	}

	function getRate()
	{
		if (xmlHttp.readyState==4)
		{ 
			ans=xmlHttp.responseText;
			
			var prices=ans.split(",");
			
			document.getElementById("cusName"+presentCount).innerHTML="";
			document.getElementById("rate"+presentCount).innerHTML="<input type='text' name='hidRate" + presentCount +"' value='"+prices[0]+"' onkeyup='calculateByRate(this.value," + presentCount + ")' tabindex=2>";
	   		document.getElementById("weight"+presentCount).innerHTML=prices[1]
	   		eval("document.myform.mrp" +presentCount+ ".value=" + prices[2]);
			document.getElementById("price"+presentCount).innerHTML=prices[2];
			document.getElementById("qty"+presentCount).innerHTML="<input type='text' name='quantity" + presentCount + "' onkeyup='calculate(this.value," + presentCount + ")' onblur='qtyValidate(this.value," + presentCount + ")' tabindex=3>";

			eval("document.myform.hidDealFlag" +presentCount+ ".value='" + prices[3] + "'");
			if (prices[3]=="Y")
			{
				document.getElementById("dealRemark"+presentCount).innerHTML="<input type='text' name='delRemark" + presentCount + "' tabindex=5 value='Rs: " + prices[5] + " on " + prices[4] + " QTYs' ><A href='javascript:void' onfocus='addRow();' tabindex=6>";
			}	else
				document.getElementById("dealRemark"+presentCount).innerHTML="<input type='text' name='delRemark" + presentCount + "' tabindex=5 value='' ><A href='javascript:void' onfocus='addRow();' tabindex=6>";

			
			eval("document.myform.hidDisQty" +presentCount+ ".value=" + prices[4]);
			eval("document.myform.hidDisAmt" +presentCount+ ".value=" + prices[5]);
			document.getElementById("discount"+presentCount).innerHTML=0.00;

			
			eval("document.myform.quantity" +presentCount+ ".focus()");
 		}
	}

	function showHint(str,internalCount)
	{
		if (str.length==0)
  		{ 
	  		document.getElementById("cusName"+internalCount).innerHTML="";
  			return;
  		}
		xmlHttp=GetXmlHttpObject();
		if (xmlHttp==null)
  		{
	  		return;
  		}
      	presentCount=internalCount;
		var url="getItemSelected.jsp";
		url=url+"?q="+str+"&t=" +new Date().getTime();
		url=url+"&pCount="+presentCount;
		url=url+"&sid="+Math.random();
		xmlHttp.onreadystatechange=stateChanged;
		xmlHttp.open("GET",url,true);
		xmlHttp.send(null);
	} 

	function stateChanged() 
	{
		if (xmlHttp.readyState==4)
		{ 
					
				
					
			var DelSpaces=xmlHttp.responseText;
			var trimmed = DelSpaces.replace(/^\s+|\s+$/g, '') ;
					
					
			if(trimmed!=""){
        		document.getElementById("cusName"+presentCount).innerHTML=trimmed;
				menuActivate("items"+presentCount, "cusName"+presentCount, "itemsSel");
				var focus="document.myform.items"+presentCount+".focus()";
				eval(focus);
           		document.getElementById("rate"+presentCount).innerHTML="";
				document.getElementById("weight"+presentCount).innerHTML="";
      			document.getElementById("price"+presentCount).innerHTML="";
	    		document.getElementById("qty"+presentCount).innerHTML=""; 
				document.getElementById("jantaPrice"+presentCount).innerHTML="";
				
				
			 }
			 else 
			 	document.getElementById("cusName"+presentCount).innerHTML="";
		}

	}

	function GetXmlHttpObject()
	{
		var xmlHttp=null;
		try
		{
	  	// Firefox, Opera 8.0+, Safari
	  	xmlHttp=new XMLHttpRequest();
		}
		catch (e)
  		{
  		// Internet Explorer
			try
			{
				xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
			}
			catch (e)
			{
				xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		return xmlHttp;
	}

	function qtyValidate(quantity, pCount)
	{	
		if(quantity==0) {
			alert("Quantity cannot be zero or blank");
			eval("document.myform.quantity"+pCount+".focus()");
			return false;
		}
		itemCalculate(5);
	}
	function getPickupCount(inputObj,pCount) {
		if (inputObj.checked==true){
			document.myform.htotPickup.value++;
			document.getElementById("hitem_taken_ind"+pCount).value=1;								
		}
		else{
			 document.myform.htotPickup.value--;
			 document.getElementById("hitem_taken_ind"+pCount).value=0;		 
					
		}
				
		var tbl = document.getElementById('ItemTable');
		var lastRow = tbl.rows.length;
		itemCalculate(5);
				
	}
	function itemCalculate(extraRows) {	
		
	var tbl = document.getElementById('ItemTable');
	var lastRow = tbl.rows.length;
		
	document.myform.htotalSel.value = (lastRow - extraRows);
	document.getElementById("totalSel").innerHTML="Total items: " + document.myform.htotalSel.value +
													  " Pickup: " + document.myform.htotPickup.value+
													  " To Deliver: " +
													  (document.myform.htotalSel.value - document.myform.htotPickup.value);
	
	}
	function calculate(quantity,pCount) {

		var total;
		var totDiTimes;
		var disAmount;
		disAmount=0.00;
				
		if(isNaN(quantity)) {
		
			alert("Please Enter a valid number in quantity field");
			eval("document.myform.quantity"+pCount+".focus()");
			return false;
		}
		else{
			totDisTimes = parseInt(quantity / eval("document.myform.hidDisQty"+pCount+ ".value"));
			if(totDisTimes >= 1)
			{
				disAmount = Math.round(eval("document.myform.hidDisAmt"+pCount+ ".value") * totDisTimes * 100)/100;
			}
			
			eval("total=Math.round(quantity*document.myform.hidRate"+pCount+".value*100)/100");
			document.getElementById("jantaPrice"+pCount).innerHTML=total-disAmount;
			document.getElementById("discount"+pCount).innerHTML=disAmount;
			//eval("total=Math.round(quantity*document.myform.mrp"+pCount+".value*100)/100");
			eval("total=Math.round(document.myform.mrp"+pCount+".value*100)/100");
			document.getElementById("price"+pCount).innerHTML=total;
			calculateTotal();
		}
	}
	function calculateByRate(currentRate,pCount) {
	   var total;
	   var disAmount;
		disAmount=0.00;
		
	   if(isNaN(currentRate)) {
	   		alert("Please enter a valid number in rate Field");
	   }
	   else {
		   		totDisTimes = parseInt(eval("document.myform.quantity"+pCount+".value") / eval("document.myform.hidDisQty"+pCount+ ".value"));
				if(totDisTimes >= 1)
				{
					disAmount = Math.round(eval("document.myform.hidDisAmt"+pCount+ ".value") * totDisTimes * 100)/100;
				}
	   			eval("total=Math.round(currentRate*document.myform.quantity"+pCount+".value*100)/100");
	   			document.getElementById("jantaPrice"+pCount).innerHTML=total-disAmount;
	   			calculateTotal();
	   	}
	}   
	function calculateTotal(){
	
	//DecimalFormat df = new DecimalFormat("###,###.00");
	
		var total=0,i,totalMRP=0;
		var found=0;
	 	document.myform.hidCount.value=count;
	 	document.myform.htotPickup.value = 0;
	 	var checkCounter=document.myform.hidCount.value;
		
		for (i=1;i<=checkCounter;i++){
			if (eval(document.getElementById("jantaPrice"+i)) != null) {
				if (eval(document.getElementById("jantaPrice"+i)).innerHTML != "") 
					total = total + eval(document.getElementById("jantaPrice"+i).innerHTML);
					totalMRP = totalMRP + 
							(eval(document.getElementById("price"+i).innerHTML) *
								eval("document.myform.quantity"+i+".value"));
				if (eval("document.myform.p_ind"+i+".checked==true")){
						document.myform.htotPickup.value++;
						document.getElementById("hitem_taken_ind"+i).value=1;						
				}
				else{
						document.getElementById("hitem_taken_ind"+i).value=0;
					}
			}
		}
		total = Math.round(total);
		totalMRP = Math.round(totalMRP);
		document.getElementById("totalAmt").innerHTML=total + ".00";
		document.myform.htotOrderValue.value=total;
		document.myform.htotMRPValue.value=totalMRP;
		
	}
		
	
	function addRow() {			
			count=count+1;		
			//add a row to the rows collection and get a reference to the newly added row
			
			var tbl = document.getElementById('ItemTable');
			var lastRow = tbl.rows.length;
			var newRow = document.all("ItemTable").insertRow(lastRow-1);
			
			//add 3 cells (<td>) to the new row and set the innerHTML to contain text boxes
			//alert("hello"+count);
			
			var oCell = newRow.insertCell();
			
			oCell.innerHTML = "<input id='items" + count + "' name='items" + count +"' value='' onkeyup=ajax_showOptions(this,'getCountriesByLetters',event) size=50 tabindex=1> <div id='cusName" + count + "' style='position:absolute;margin-left:-0;margin-top:0;z-index:10'></div><input type=hidden id='items" + count + "_hidden' name='items" + count + "_hidden'>";
			//var as = 'new AutoSuggestControl(document.getElementById("items' + count + '"), new RemoteStateSuggestions())'; 
			//eval(as);
			
			oCell = newRow.insertCell();
			oCell.innerHTML = "<input type='checkbox' name='p_ind" + count + 
							  "' onClick='getPickupCount(this,count)'>" + 
							  "<input type='hidden' name='hitem_taken_ind" + count +
							  "' value='0'>";	
				
			oCell = newRow.insertCell();
			oCell.innerHTML = "<div id='rate" + count +"'></div>";
			
			oCell = newRow.insertCell();
			oCell.innerHTML = "<div id='weight" + count +"'></div>";
	      	
	      	oCell = newRow.insertCell();
			oCell.innerHTML = "<div id='qty" + count +"'></div>";
			
			oCell = newRow.insertCell();
			oCell.innerHTML = "<div align='right' id='jantaPrice" + count +"'></div><input type='hidden' name='mrp" + count +"' value='0'>";
			
			oCell = newRow.insertCell();
	 		oCell.innerHTML = "<input type='hidden' name='selItemCode" +count+"'><div id='price" + count +"'></div>";
			
			oCell = newRow.insertCell();
			oCell.innerHTML = "<div align='right' id='discount" + count +"'></div>" +
							  "<input type='hidden' name='hidDisAmt" + count +"' value='0'>" +
							  "<input type='hidden' name='hidDisQty" + count +"' value='0'>" +
							  "<input type='hidden' name='hidDealFlag" + count +"' value='0'>";
		
			oCell = newRow.insertCell();
			oCell.innerHTML = "<div id='dealRemark" + count +"' ></div>";
					
			oCell = newRow.insertCell();
			oCell.innerHTML = "<input type='button' accesskey='r' value='Del<Alt+r>' onclick='removeRow(this);'/>";
			
		
			
			as = "document.myform.items" +count+ ".focus()";
			eval(as);		
	}
	function removeRow(src) {

		/* src refers to the input button that was clicked.
		to get a reference to the containing <tr> element,
		get the parent of the parent (in this case <tr>)
		*/
		var oRow = src.parentElement.parentElement;
		
 		//once the row reference is obtained, delete it passing in its rowIndex	
		
		
	
		document.all("ItemTable").deleteRow(oRow.rowIndex);
		//alert(document.all("ItemTable").innerHTML);
			
		var tbl = document.getElementById('ItemTable');
		var lastRow = tbl.rows.length;

		itemCalculate(5);
	
		calculateTotal();
	}
	function menuActivate(idEdit, idMenu, idSel)
	{
		//if (fActiveMenu) return mouseSelect(0);

		oMenu = document.getElementById(idMenu);
		oEdit = document.getElementById(idEdit);
		nTop = oEdit.offsetTop + oEdit.offsetHeight;
		nLeft = oEdit.offsetLeft;
		while (oEdit.offsetParent != document.body)
		{
			oEdit = oEdit.offsetParent;
			nTop += oEdit.offsetTop;
			nLeft += oEdit.offsetLeft;
		}
		oMenu.style.left = nLeft;
		oMenu.style.top = nTop;
		oMenu.style.display = "";
		fActiveMenu = idMenu;
		document.getElementById(idSel).focus();
		return false;
	}
	function save()
	{
		var found=0;
	 	document.myform.hidCount.value=count;
	 	var p_code=document.myform.p_type.value;
	 	var orderNo=document.myform.orderNo.value;
	 	var orderDate=document.myform.orderDate.value;
	 	
	  	var checkCounter=document.myform.hidCount.value;
	 	var codeArray = new Array();
	 	var nameArray = new Array();
	 	for(i=1;i<=checkCounter;i++) {
	 	
	 		var checkNullItem="document.myform.items"+i;
	 		var checkNullCode="document.myform.items"+i+"_hidden";
	 			 		
	 		if(eval(checkNullItem)!=null)
	 		{
	 			codeArray[i]=eval(checkNullCode).value;
	 			nameArray[i]=eval(checkNullItem).value;
	 			
	 			for(j=1;j<=i-1;j++)
	 			{
	 				if(codeArray[j]==codeArray[i]){
	 				  
	 				   alert("Duplicate entry for: " + nameArray[i] );
	 				   eval(checkNullItem).focus();
	 				   return false;
	 				}
	 				
	 			}
	 					
	 			var checkQty =eval("document.myform.quantity"+i);
	 			var checkRate=eval("document.myform.hidRate"+i);
	 			 			
	 			if(eval(checkNullItem).value=="" || eval(checkNullCode).value==""){
	 				alert("Please enter a vald item");
	 				eval(checkNullItem).focus();
	 				return false;
	 			}
	 			
	 			if(isNaN(checkQty.value) || checkQty.value==0) {
	 			
	 				alert("Please enter a valid number in quantity field");
	 				checkQty.focus();
	 				return false;
	 			}
	 			if(isNaN(checkRate.value) || checkRate.value==0) {
	 			
	 				alert("Please enter a valid number in rate field");
	 				checkRate.focus();
	 				return false;
	 			}
	 			if (eval("document.myform.p_ind"+i+".checked==true")){
					document.getElementById("hitem_taken_ind"+i).value=1;
					
				}else{
					document.getElementById("hitem_taken_ind"+i).value=0;
						
				}		 		
	 		}	 		
	 	}	
	 	if(p_code==""){
	 		alert("Please select Payment Term");
	 		document.myform.p_type.focus();
	 		return false;
	 	}
	 		if(count!=0){
	 		     		    	
	 		    document.myform.action="EditBill.jsp";
				document.myform.submit();	 
		    }
		
	}		  
	  
