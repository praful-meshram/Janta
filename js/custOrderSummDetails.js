var xmlHttp;
var counter = 0;

function _showHint() {
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="DisplayMarquee.jsp";	
	xmlHttp.onreadystatechange=stateChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function stateChanged(){
	if (xmlHttp.readyState==4)	{ 
		document.getElementById("txtHint").innerHTML=xmlHttp.responseText;
		document.myform.order.focus();
		//document.myform.order.addRowFirst();
	}
	
	//funOnLoad();
}

function funOnLoad(){
	if(counter == 0){
		var balance = parseFloat(document.getElementById("balance").innerHTML);
		if(balance > 0){
			var ans = confirm("Customer has "+balance+" Rs. pending balance.\nDo you still want to create order for customer");
			if(!ans){
				self.close();
			}
			else{
				document.order.addRowFirst();
			}
		}
		counter++;
	}
}

function _showHint1() {
	
	var str;	
	str=document.myform.hcuscode.value;		
	
	if (str.length==0)
  	{ 
  		document.getElementById("txtHint1").innerHTML="";
  		return;
  	}
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	var v1= Math.random().toString();
  	var sid1 = parseInt(v1 * 100);
  	
  	
	var url="custOrderSummDetails.jsp";
	url=url+"?sid="+sid1+"&hcuscode="+str;	
	//alert(url);
	xmlHttp.onreadystatechange=stateChanged1;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
} 

function stateChanged1() 
{
	if (xmlHttp.readyState==4)
	{ 
		document.getElementById("waitMessage").innerHTML="";
		document.getElementById("txtHint1").innerHTML=xmlHttp.responseText;

		_showHint();

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
