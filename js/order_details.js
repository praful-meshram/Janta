var xmlHttp;

$(document).ready(function() {
	 $( "#c_date1" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			maxDate:new Date(),
			//numberOfMonths: 3,
			onClose: function( selectedDate ) {
				$( "#c_date2" ).datepicker( "option", "minDate", selectedDate );
			}
		});
		$( "#c_date2" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			//numberOfMonths: 3,
			maxDate:new Date(),
			
			onClose: function( selectedDate ) {
				$( "#c_date1" ).datepicker( "option", "maxDate", selectedDate );
			}
		});
		
		 $( "#u_date1" ).datepicker({
				defaultDate: "+1w",
				changeMonth: true,
				maxDate:new Date(),
				//numberOfMonths: 3,
				onClose: function( selectedDate ) {
					$( "#u_date2" ).datepicker( "option", "minDate", selectedDate );
				}
			});
			$( "#u_date2" ).datepicker({
				defaultDate: "+1w",
				changeMonth: true,
				//numberOfMonths: 3,
				maxDate:new Date(),
				
				onClose: function( selectedDate ) {
					$( "#u_date1" ).datepicker( "option", "maxDate", selectedDate );
				}
			});
})

function showHint() {
	var phoneNumber;
	var str;
	var str1;
	var str2;
	var str3;
	var str4;
	var str5;
	var str6;
	var str7;
	phoneNumber=document.myform.phonenumber.value;	
	str=document.myform.orderNumber.value;
	str1=document.myform.customerCode.value;
	str2=document.myform.customerName.value	;
	str3=document.myform.enteredBy.value;
	str4=document.myform.c_date1.value;
	str5=document.myform.u_date1.value;	
	str6=document.myform.c_date2.value;
	str7=document.myform.u_date2.value;	
	
	document.getElementById("txtHint").innerHTML="";
	if (phoneNumber.length==0 && str.length==0 && str1.length==0 && str2.length==0 && str3.length==0 && str4.length==0 && str5.length==0 && str6.length==0 && str7.length==0)
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
  	
  	document.getElementById("waitMessage").innerHTML="Please wait ...";
	var url="getOrder_details.jsp";
	url=url+"?orderNumberStartWith="+str+"&phoneNumberStartWith="+phoneNumber+"&custCodeStartWith="+str1+"&custNameStartWith="+str2+"&enterByStartWith="+str3+"&c_date1StartWith="+str4+"&u_date1StartWith="+str5+"&c_date2StartWith="+str6+"&u_date2StartWith="+str7+"&t="+new Date().getTime();
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
	document.myform.u_date1.value="";
	document.myform.u_date2.value="";
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

	