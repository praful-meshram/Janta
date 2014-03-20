var xmlHttp,xmlHttp1;
var returnVal="NULL";
var jantaprice,qty,itemtaken,itemMrp;
var rtotalItem=0,rtotalValue=0,rtotItems=0,rtotVal=0,
	rpickup=0,rdeliver=0,rcomm=0,exptval=0,rbalanceValue,retItem1;
function showHistory(){		
	var str;	
	str=document.myform.horderNo.value;
	var str1;	
	str1=document.myform.horderDate.value;
	
	xmlHttp1=GetXmlHttpObject()
	if (xmlHttp1==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="OrderHistory.jsp";
	url=url+"?orderNoStartWith="+str+"&orderDateStartWith="+str1+"";
	url=url+"&sid="+Math.random();
	xmlHttp1.onreadystatechange=stateChanged1;	
	xmlHttp1.open("GET",url,true);
	xmlHttp1.send(null);
}

function stateChanged1() 
{
	if (xmlHttp1.readyState==4)
	{ 
		document.getElementById("OrderHistory").innerHTML=xmlHttp1.responseText;				
		showHint(document.myform.hpagename.value);				
	}
}

function showHint(pagename) {	
	var str;	
	str=document.myform.horderNo.value;
	var str1;	
	str1=document.myform.horderDate.value;
	document.getElementById("waitMessage").innerHTML="Please wait...";
	if (str.length==0 && str1.length==0)
  	{ 
  		document.getElementById("txtHint").innerHTML="";
  		return;
  	}
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
 	
	var url="lastOrderDetails.jsp";
	url=url+"?orderNoStartWith="+str+"&orderDateStartWith="+str1+"&pageName="+pagename+"";
	url=url+"&sid="+Math.random();		
	xmlHttp.onreadystatechange=stateChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);	
} 

function stateChanged() 
{
	if (xmlHttp.readyState==4)
	{ 		
		document.getElementById("waitMessage").innerHTML="";	
		document.getElementById("txtHint").innerHTML=xmlHttp.responseText;
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


function GetXmlHttpObject1()
{
	var xmlHttp1=null;
	try
  	{
  		// Firefox, Opera 8.0+, Safari
  		xmlHttp1=new XMLHttpRequest();
  	}
	catch (e)
  	{
  	// Internet Explorer
  		try
    	{
    		xmlHttp1=new ActiveXObject("Msxml2.XMLHTTP");
    	}
  		catch (e)
    	{
    	xmlHttp1=new ActiveXObject("Microsoft.XMLHTTP");
    	}
  	}
	return xmlHttp1;
}

	function SelectReturnedItem(retItem,index,janta_price,quantity,item_taken,itemCode,item_Mrp,pageName,itemCount,entry_no,ch){		
		if(pageName=="DeliveryActionForm"){
			
			 jantaprice=janta_price;
			 qty=quantity;
			 itemtaken=item_taken;
			 itemMrp=item_Mrp;
			retItem1 = retItem;
			rtotalItem=document.getElementById("totalItem").innerHTML;
			rtotalValue=document.getElementById("totalValue").innerHTML;
			rbalanceValue=document.getElementById("balanceValue").innerHTML;
			//LastOrder table var	
			rtotItems=document.getElementById("totItems").innerHTML;
			rpickup=document.getElementById("pickup").innerHTML;
			rdeliver=document.getElementById("deliver").innerHTML;
			rtotVal=rtotVal=document.getElementById("totVal").innerHTML;
			rcomm=document.getElementById("comm").innerHTML;
			
			if(ch.checked==true){		
				Checked(itemCount);	
			}
			else if(ch.checked==false){		
			 	Unchecked(itemCount);	
			}
					
			if(document.myform.chck.value==null){		
				for(i=0; i<document.myform.chck.length; i++){
				    if (document.myform.chck[index].checked==true){	
				    	Checked(itemCount);
				    	break;
			    	}
				    else if(document.myform.chck[index].checked==false){
				    	Unchecked(itemCount);						
				    	break;				    	
					}
				}//EOF for	    	
			}//EOF 2nd if	    		
		}//EOF 1st if	    	
	}//EOF function
	
	function checkreturnedItem(){
		document.myform.htotalvalue.value=document.getElementById("totVal").innerHTML;
		var code='$$$$';
		var count=0;
		var arr=new Array();
		var qtyArray = new Array();
		var priceArray =new Array();
		var entryArray =new Array();
		var oldQty =new Array();
		var rows = document.getElementById("row_count").value;
		for(var i=0; i<rows; i++){
			 if (document.getElementById("chck_"+i).checked==true){
			 	arr[i]=document.getElementById("chck_"+i).value;
			 	if(document.getElementById("divNewQty"+i).innerHTML == document.getElementById("divPrevQty"+i).innerHTML ){
			 		qtyArray[i] = 0;
			 	}else{
			 		qtyArray[i] = document.getElementById("divNewQty"+i).innerHTML;
			 	}	
			 	priceArray[i] = document.getElementById("divTotalPrice"+i).innerHTML;
			 	entryArray[i] =  document.getElementById("hentry_id_"+i).innerHTML;
			 	oldQty[i]=document.getElementById("divPrevQty"+i).innerHTML;
			 	count++;			 	 
			 }	
		}	
		document.myform.hicodearray.value=arr;
		document.myform.hqtyArray.value=qtyArray;
		document.myform.hpriceArray.value=priceArray;
		document.myform.hentryArray.value=entryArray;
		document.myform.hretitem.value=count;
		document.myform.holdItems.value=oldQty;
	}
	function Checked(itemCount){
		//alert("check")
		
		
		document.getElementById("divInQty"+itemCount).style.visibility="visible";
		document.getElementById("inQty_"+itemCount).value="";
		document.getElementById("inQty_"+itemCount).focus();	
	}
	function Unchecked(itemCount){
		//alert("unchek")
		document.getElementById("divInQty"+itemCount).style.visibility="hidden";
		 var prevQty = document.getElementById("divPrevQty"+itemCount).innerHTML;  
	   	 var newQty = document.getElementById("divNewQty"+itemCount).innerHTML;    
	   	 
	   	 
	  	if(parseFloat(newQty) < parseFloat(prevQty)){
	  		//alert(document.getElementById("divNewQty"+itemCount)+" "+document.getElementById("newQtyTextField"+itemCount))
	   		   document.getElementById("divNewQty"+itemCount).innerHTML = document.getElementById("divPrevQty"+itemCount).innerHTML;
	   		   document.getElementById("newQtyTextField"+itemCount).value=document.getElementById("divPrevQty"+itemCount).innerHTML; 
		   var prevPrice = 	parseFloat(retItem1) * parseFloat(newQty);
		    
		   var totalPrice = parseFloat(retItem1) * parseFloat(prevQty);  
		   
		   document.getElementById("divTotalPrice"+itemCount).innerHTML = totalPrice ;
		   var totalVal = (parseFloat(rtotalValue)-parseFloat(prevPrice))+ parseFloat(totalPrice);
		   document.getElementById("totalValue").innerHTML= totalVal;
		   var totalBal = (parseFloat(rbalanceValue)-parseFloat(prevPrice))+ parseFloat(totalPrice);
		   document.getElementById("balanceValue").innerHTML = totalBal;
		  
		   var totVal = (parseFloat(rtotVal)-parseFloat(prevPrice))+ parseFloat(totalPrice);
		   document.getElementById("totVal").innerHTML=totVal;
		   itemMrp=(parseFloat(itemMrp)*parseFloat(prevQty));
		   document.myform.hretmrp.value=parseFloat(document.myform.hretmrp.value)+parseFloat(itemMrp);	
		   
			
	   }
	   else{
	   	return false;
	   }
	  
	   if(parseFloat(newQty) == 0){
		   document.getElementById("totItems").innerHTML=parseInt(rtotItems)+1;
		   if(itemtaken==1)
			document.getElementById("pickup").innerHTML=parseInt(rpickup)+1;
		   else if(itemtaken==0)				
			document.getElementById("deliver").innerHTML=parseInt(rdeliver)+1;	
		}
	   document.getElementById("expamtdiv").innerHTML=parseFloat(document.getElementById("balanceValue").innerHTML)+parseFloat(document.getElementById("changeAmt").innerHTML);					
	   document.myform.hsum.value=document.getElementById("totalValue").innerHTML;		   
	   if(document.getElementById("paymentdiv").innerHTML==="Cash" || document.getElementById("paymentdiv").innerHTML==="Cheque"){
			document.myform.paidamt.value=document.getElementById("expamtdiv").innerHTML;
		} 
	   document.myform.hitemtaken.value=document.getElementById("pickup").innerHTML;
	   document.myform.hretitem.value=document.getElementById("totItems").innerHTML;
	   document.myform.htotalvalue.value=document.getElementById("totVal").innerHTML;
	}	
	
	function funEnabled(){
		if (document.myform.note.checked==true){
			document.getElementById('divnote').style.visibility="hidden";							
		}
		else{
			document.getElementById('divnote').style.visibility="visible";					
		}
	}
	
	function funInQty(retItem,index,janta_price,quantity,item_taken,itemCode,item_Mrp,pageName,itemCount,entry_no,id){
	   var prevQty = document.getElementById("divPrevQty"+itemCount).innerHTML;  
	   document.getElementById("divNewQty"+itemCount).innerHTML =id.value;
	   document.getElementById("newQtyTextField"+itemCount).value=id.value;
	   var totMrp = parseFloat(document.getElementById("totMrp").innerHTML.replace(",",""));
	   var newQty = parseFloat(quantity)-parseFloat(id.value);
	   var newQty = id.value;  
	   if(parseFloat(newQty) > parseFloat(prevQty)){
		   alert("New Qty is greater than Old Qty");
		   id.value="";
		   id.focus();
		   document.getElementById("divNewQty"+itemCount).innerHTML =prevQty;
		   document.getElementById("newQtyTextField"+itemCount).value=prevQty;
	    }else if(id.value == 0 ){
	       var totalPrice = parseFloat(retItem) * parseFloat(newQty); 
		   document.getElementById("totMrp").innerHTML = totMrp-((parseFloat(quantity)-newQty)*item_Mrp);
		   document.getElementById("divTotalPrice"+itemCount).innerHTML = totalPrice ;
	  	   document.getElementById("totalItem").innerHTML=parseInt(rtotItems)-1;
	   	   document.getElementById("totalValue").innerHTML=parseFloat(rtotalValue)-parseFloat(jantaprice);
	   	   document.getElementById("balanceValue").innerHTML=parseFloat(rbalanceValue)-parseFloat(jantaprice);
	   	   document.getElementById("totItems").innerHTML=parseInt(rtotItems)-1;
		   if(itemtaken==1)
			document.getElementById("pickup").innerHTML=parseInt(rpickup)-1;
		   else if(itemtaken==0)				
			document.getElementById("deliver").innerHTML=parseInt(rdeliver)-1;			
		   document.getElementById("totVal").innerHTML=parseFloat(rtotVal)-parseFloat(jantaprice);
		   itemMrp=(parseFloat(itemMrp)*parseFloat(qty));
		document.myform.hretmrp.value=parseFloat(document.myform.hretmrp.value)+parseFloat(itemMrp);						
	   }else{
		   document.getElementById("totMrp").innerHTML = totMrp-((parseFloat(quantity)-newQty)*item_Mrp);
	   	   var totalPrice = parseFloat(retItem) * parseFloat(newQty);   
		   document.getElementById("divTotalPrice"+itemCount).innerHTML = totalPrice ;
		   var totalVal = (parseFloat(rtotalValue)-parseFloat(jantaprice))+ parseFloat(totalPrice);
		   document.getElementById("totalValue").innerHTML= totalVal;
		   var totalBal = (parseFloat(rbalanceValue)-parseFloat(jantaprice))+ parseFloat(totalPrice);
		   document.getElementById("balanceValue").innerHTML = totalBal;
		   var totVal = (parseFloat(rtotVal)-parseFloat(jantaprice))+ parseFloat(totalPrice);
		   document.getElementById("totVal").innerHTML=totVal;
		   itemMrp=(parseFloat(itemMrp)*parseFloat(newQty));
			document.myform.hretmrp.value=parseFloat(document.myform.hretmrp.value)+parseFloat(itemMrp);						
	  }
	   document.getElementById("expamtdiv").innerHTML=parseFloat(document.getElementById("balanceValue").innerHTML)+parseFloat(document.getElementById("changeAmt").innerHTML);					
	   document.myform.hsum.value=document.getElementById("totalValue").innerHTML;		   
	   if(document.getElementById("paymentdiv").innerHTML==="Cash" || document.getElementById("paymentdiv").innerHTML==="Cheque"){
			document.myform.paidamt.value=document.getElementById("expamtdiv").innerHTML;
		} 
	   document.myform.hitemtaken.value=document.getElementById("pickup").innerHTML;
	   document.myform.hretitem.value=document.getElementById("totItems").innerHTML;
	   document.myform.htotalvalue.value=document.getElementById("totVal").innerHTML;
	}
	
	function funchckempty(id){
		if(id.value == ""){
			alert("New Qty can not be blank");
		    id.focus();	
		}   
	}
	
	function isNumberKey(evt) {
		var charCode = (evt.which) ? evt.which : event.keyCode;
		if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
			return false;
		else
			return true;
	}
		