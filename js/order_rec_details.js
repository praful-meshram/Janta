var xmlHttp

function showHint() {
	var str;
	var str1;
	var str2;
	var str3;
	var str4;
	var str5;		
	var str6;
	str=document.myform.orderNumber.value;
	str1=document.myform.customerCode.value;
	str2=document.myform.customerName.value	;
	str3=document.myform.enteredBy.value;
	str4=document.myform.c_date1.value;	
	str5=document.myform.c_date2.value;
	str6=document.myform.selstatus.value;
	document.getElementById("txtHint").innerHTML="";
	
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	}   
  	document.getElementById("waitMessage").innerHTML="Please wait ...";
	var url="getOrder_rec_details.jsp";
	url=url+"?orderNumberStartWith="+str+"&custCodeStartWith="+str1+"&custNameStartWith="+str2+"&enterByStartWith="+str3+"&c_date1StartWith="+str4+"&c_date2StartWith="+str5+"&selstatus="+str6+"&type=all&t="+new Date().getTime();
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
	document.myform.c_date1.value="";
	document.myform.c_date2.value="";	
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

function showList() {
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	}   
  	var url="getOrder_rec_details.jsp";
	url=url+"?type=list";
	url=url+"&sid="+Math.random();
	xmlHttp.onreadystatechange=stateChanged1;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
} 

function stateChanged1() 
{
	if (xmlHttp.readyState==4)
	{ 
		document.getElementById("dispdiv").innerHTML=xmlHttp.responseText;
		Popup.showModal('dispdiv',null,null,{'screenColor':'gray','screenOpacity':.6})	
	}
}

function showItemList(orderno,custCode) {
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	}   
  	var url="getOrder_rec_details.jsp";
	url=url+"?type=ItemList&orderno="+orderno+"&custcode="+custCode+"";
	url=url+"&sid="+Math.random();
	xmlHttp.onreadystatechange=stateChanged3;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
} 

function stateChanged3() 
{
	if (xmlHttp.readyState==4)
	{ 
		
		document.getElementById("dispdiv1").innerHTML=xmlHttp.responseText;
		Popup.showModal('dispdiv1',null,null,{'screenColor':'gray','screenOpacity':.6})	
	}
}
function funclose(){
	Popup.hide('dispdiv');
}	
function funclose1(){
	Popup.hide('dispdiv1');
}
function funcreate(orderno,custcode){
	 document.myform.action="OrderRecItemList.jsp?orderno="+orderno+"&custcode="+custcode+"";
	 document.myform.submit();
}
