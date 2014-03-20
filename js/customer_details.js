var xmlHttp;
var xmlHttp1;
var childWin = null;
function showHint1() {	
	
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="currentOrderList.jsp";
	xmlHttp.onreadystatechange=stateChanged1;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
} 

function stateChanged1() 
{
	if (xmlHttp.readyState==4)
	{ 		
		document.getElementById("OrderList").innerHTML=xmlHttp.responseText;
		recentlySubmittedOrdList() ;		
	}
}

function recentlySubmittedOrdList(){
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="recentlySubmittedOrderList.jsp";
	xmlHttp.onreadystatechange=stateChanged2;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function stateChanged2() 
{
	if (xmlHttp.readyState==4)
	{ 		
		document.getElementById("SubmittedOrderList").innerHTML=xmlHttp.responseText;
	}
}

function showHint() {

			
	var str;
	var str1;
	var str2;
	var str3;
	var str4;
	var str5;
	var str6;
	var str9, str10, str11,str12,str13,str14,str15;
	str=document.myform.cusName.value
	str1=document.myform.phonenumber.value
	str2=document.myform.Building.value
	str3=document.myform.block.value
	str4=document.myform.wing.value
	str5=document.myform.add1.value
	str6=document.myform.add2.value
	str7=document.myform.custCode.value
	str8=document.myform.nameString.value
	str9=document.myform.Building_no.value
	str10=document.myform.area.value
	str11=document.myform.station.value
	str12=document.myform.c_date1.value
	str13=document.myform.u_date1.value	
	str14=document.myform.c_date2.value
	str15=document.myform.u_date2.value	
	
	document.getElementById("waitMessage").innerHTML="Please wait...";
	if (str.length==0 && str1.length==0 && str2.length==0 && str3.length==0 && str4.length==0 && str5.length==0 && str6.length==0&&str7.length==0 && str8.length==0  && str9.length==0 && str10.length==0 && str11.length==0 && str12.length==0 && str13.length==0 && str14.length==0 && str15.length==0)
  	{ 
  		document.getElementById("txtHint").innerHTML="";
  		return;
  	}
	xmlHttp1=GetXmlHttpObject()
	if (xmlHttp1==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="customer_details.jsp";
	url=url+"?nameStartWith="+str+"&phStartWith="+str1+"&bldgStartWith="+str2+"&blockStartWith="+str3+"&wingStartWith="+str4+"&add1StartWith="+str5+"&add2StartWith="+str6+"&custCodeStartWith="+str7+"&nameStringStartWith="+str8+"&bldgnoStartWith="+str9+"&areaStartWith="+str10+"&stationStartWith="+str11+"&c_date1StartWith="+str12+"&u_date1StartWith="+str13+"&c_date2StartWith="+str14+"&u_date2StartWith="+str15+"&t="+new Date().getTime();
	url=url+"&sid="+Math.random();
	xmlHttp1.onreadystatechange=stateChanged;
	xmlHttp1.open("GET",url,true);
	xmlHttp1.send(null);
} 

function stateChanged() 
{
	if (xmlHttp1.readyState==4)
	{ 
		document.getElementById("waitMessage").innerHTML="";
		document.getElementById("txtHint").innerHTML=xmlHttp1.responseText;
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

function Pass(add1,add2,cuscode,area,custName,custPhone){	
   
   document.myform.hcusname.value=custName;
   document.myform.hcusphone.value=custPhone;
	document.myform.hcuscode.value = cuscode;               
    document.myform.hadd1.value = add1;
    document.myform.hadd2.value = add2;
    document.myform.harea.value = area;			
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="TodaysCustOrderList.jsp?custcode="+cuscode;
	xmlHttp.onreadystatechange=stateChanged55;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
	
                	        		 
				 		
}

	
function stateChanged55() 
{
	if (xmlHttp.readyState==4)
	{ 		
	   
	
		var ans = xmlHttp.responseText;
		 ans= ans.replace(/^\s+|\s+$/g,'');
		document.myform.custCode.focus();
		cuscode=document.myform.hcuscode.value ;   
		add1=document.myform.hadd1.value ;
		add2=document.myform.hadd2.value ;
		area= document.myform.harea.value;	
		var anss = ans.split("#");
		var bal = parseFloat(anss[1]);
		if(bal > 0){
			var anss = confirm("This Customer have "+anss[1]+"Rs. balance Pending.\n Do you want to create order..?");
			if(!anss)
				return;
		}
		if(parseInt(anss[0]) == 0){
			showMe(add1,add2,cuscode,area);		
		}else{
			var ans1 = confirm("You have already created "+ anss[0] +" order(s) for this customer"+"\n"+"Do you want to create one more Order..?");
			//alert(ans1);
			if(ans1 == true){
				showMe(add1,add2,cuscode,area);
			}
			else{
			  
				window.refresh; 
			}
		}		
	}
}		
		function launchchildW(add1,add2,cuscode,area) {
		   if (childWin == null){
		        document.myform.hcuscode.value = cuscode;		                   
		        document.myform.hadd1.value = add1;
		        document.myform.hadd2.value = add2;
		        document.myform.harea.value = area;
		        custName=document.myform.hcusname.value;
		        custPhone=document.myform.hcusphone.value;	
		        
		        //alert("launchchildW :"+document.myform.siteId.value);
	         	document.myform.action="cust_orderBill.jsp?hcuscode="+cuscode+
	         							"&hadd1="+add1+"&hadd2="+add2+"&harea="+area+
	         							"&hcustname="+custName+"&hcustphone="+custPhone+
	         							"&hsiteId="+document.myform.siteId.value+
	         							"&hsiteName="+document.myform.siteId.options[document.myform.siteId.selectedIndex].text;
		 	 	document.myform.target="OrderForm";
		 	 	//wopts  = 'resizable=1,alwaysRaised=1,scrollbars=1';
		 	 	childWin = window.open(myform.action,myform.target,'location=1,status=1,scrollbars=1,width=1050,toolbar=1,height=1400,resizable=1');
		 	 	 //childWin.document.myform.Firstfocus.focus();			 
		 	 }
		 }
		
		 function showMe(add1,add2,cuscode,area) {		 	
		   if (childWin != null ) {		        
		       // childWin.document.location = "cust_orderBill.jsp?hcuscode="+cuscode+"&hadd1="+add1+"&hadd2="+add2+"&harea="+area+"";	
		      
		       	childWin.document.myform.hcuscode.value = cuscode;  
		                 
		        childWin.document.myform.hadd1.value = add1;
		        childWin.document.myform.hadd2.value = add2;
		        childWin.document.myform.harea.value = area; 
		        childWin.document.myform.hsiteId.value = document.myform.siteId.value;
		        childWin.document.myform.hsiteName.value =document.myform.siteId.options[document.myform.siteId.selectedIndex].text;
		        childWin.Pass(add1,add2,cuscode,area);
		        childWin.document.myform.Firstfocus.focus();			       
		   }
		   else {
		   		launchchildW(add1,add2,cuscode,area);
		   }
		   
		  
		 }
