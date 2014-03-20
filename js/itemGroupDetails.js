var xmlHttp

function showHint() {
	var str;
	str=document.myform.ig_code.value;
	var str1;
	str1=document.myform.ig_desc.value;
	var str3;
	str3=document.myform.ig_number.value;
	var str2;
	str2=document.myform.hchckall.value;

	if (str.length==0 && str1.length==0 && str2.length==0 && str3.length ==0)
  	{ 
  		return;
  	}
	if(str3 == ""){
		str3=0;
	}
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="itemGroupDetails.jsp";
	url=url+"?ig_codeStartWith="+str+"&ig_descStartWith="+str1+"&hchckallStartWith="+str2+"&igNumber="+str3+"";
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
		
			$('#id').dataTable({
	        "sDom": "Rlfrtip",
	      	"bPaginate": false
		});
		
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
