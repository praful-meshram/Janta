var xmlHttp

function printOrder(custcode,custname,building,block,wing,add1,add2,telphone,enteredby,orddate,orderNo)
{
content = document.getElementById('orders').innerHTML;
/*

items="";

for (i=1;i<=count;i++)
{

var checkExists='document.myform.items'+i;
if(eval(checkExists)!=null)
{
col1=eval('document.myform.items' +i+'.value');
col2=eval('document.myform.hidRate' +i+'.value');
col3=eval('document.getElementById("weight' +i+'").innerHTML');
col4=eval('document.myform.quantity' +i+'.value');
col5=eval('document.getElementById("jantaPrice' +i+'").innerHTML');
col6=eval('document.getElementById("price' +i+'").innerHTML');
	

items = items + "<tr>";
items = items + "<td>" +col1+ "</td>";
items = items + "<td>" +col2+ "</td>";
items = items + "<td>" +col3+ "</td>";
items = items + "<td>" +col4+ "</td>";
items = items + "<td>" +col5+ "</td>";
items = items + "<td>" +col6+ "</td>";
items = items + "</tr>";
}

}

OrderAmt=document.myform.hidTotal.value;
TotMRP=document.myform.hidMRP.value;
TotItems=count;
savings=TotMRP - OrderAmt;

items = items + "<tr>";
items = items + "<td colspan=6>&nbsp</td>";
items = items + "</tr>";

items = items + "<tr>";
items = items + "<td>Total Items: " +TotItems+ "</td>";
items = items + "<td colspan=3 align=right>Bill Amount: Rs </td>";
items = items + "<td>"+OrderAmt+ "</td>";
items = items + "</tr>"; */

newwin = window.open();
//'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"\n',
//'"http://www.w3.org/TR/html4/strict.dtd">\n',
newwin.document.write('<html>\n',
'<head>\n',
'<title>Printing...</title>\n',
'<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">\n',
'</head>\n',
'<body>\n',
'<table width=600>\n',
'<tr><td>Entered By: '+enteredby+ '</td><td align=center colspan=5>Janta Stores</td></tr>\n',
'<tr><td>Packed By:</td><td align=center colspan=5>S.V. Road, Borivali (W), Mumbai - 92</td></tr>\n',
'<tr><td>Delivered By:</td><td align=center colspan=5>Tel: 2805 3865 / 2805 0693 / 5628 3335 / 36</td></tr>\n',
'<tr><td>Order No: ' +orderNo+ '</td><td align=center colspan=5>Date: '+orddate+'</td></tr>\n',
'<tr><td colspan=6>&nbsp</td></tr>\n',

'<tr><td colspan=6>' +custcode+'</td></tr>\n',
'<tr><td colspan=6>' +custname+'</td></tr>\n',
'<tr><td colspan=6>' +building+ ' ' +block+ ' ' +wing+'</td></tr>\n',
'<tr><td colspan=6>' +add1+ ' ' +add2+'</td></tr>\n',
'<tr><td colspan=6>Tel: ' +telphone+'</td></tr>\n',
'<tr><td colspan=6>&nbsp</td></tr>\n',


/*'<tr><td colspan=6 align=center>Item Details</td></tr>\n',
'<tr><td>Item</td><td>Rate</td><td>Weight</td><td>Qty</td><td>Price</td><td>MRP</td></tr>\n',
''+items+'\n',
'<tr><td colspan=6>&nbsp</td></tr>\n',
'<tr><td colspan=6>&nbsp</td></tr>\n',
'<tr><td colspan=6>You have saved Rs. ' +savings+ ' by shopping at Janata Stores</td></tr>\n',
*/

'</table>\n',
''+content+'\n',
'</body>\n',
'</html>\n',
'<script>\n',
'window.onload=function(){\n',
'self.print();\n',
'self.close();}\n',
'</script>\n');
//newwin.reload();
//newwin.print();
//newwin.close();


}


function showHint() {
	var str;
	str=document.myform.orderNo.value
	//alert(str);
	if (str.length==0)
  	{ 
  		document.getElementById("orders").innerHTML="";
  		return;
  	}
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="getOrderno_of_OrderDetails.jsp";
	url=url+"?orderNumberStartWith="+str+"&t="+new Date().getTime();
	url=url+"&sid="+Math.random();
	xmlHttp.onreadystatechange=stateChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
} 

function stateChanged() 
{
	if (xmlHttp.readyState==4)
	{ 
	document.getElementById("orders").innerHTML=xmlHttp.responseText;
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

	