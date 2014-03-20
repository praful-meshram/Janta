var xmlHttp;

function showHint() {
	var str;
	str=document.myform.EditUserName.value;
	if (str.length==0){
  		document.getElementById("txtHint").innerHTML="";
  		return;
  	}
  	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="EditUser.jsp";
	url=url+"?nameStartWith="+str+"";
	url=url+"&sid="+Math.random();
	xmlHttp.onreadystatechange=stateChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
	
} 

function stateChanged() 
{
	if (xmlHttp.readyState==4)
	{
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



function trimString(str){
		return str.replace(/^\s+|\s+$/g, '');
	}
	function validateString(field, errmsg, lenmsg, min, max, required){ 
		if (!field.value && !required){
			return true;
		}
		if (!field.value){
			alert(errmsg);
		  	field.focus(); 
		  	field.select(); 			  
		  	return false;
		}
		if (trimString(field.value).length < min || field.value.length > max){
		  	alert(lenmsg);
		  	field.focus(); 
		  	field.select(); 
		  	return false;
		}
		return true; 
	}
	
	function validateEmail(email, msg, required) { 
		if (!email.value && !required) { 
			return true; 
		} 
		var regEx = /^[\w-\.\+]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,6}$/; 
		if (!regEx .test(email.value)) { 
			alert(msg); 
			email.focus(); 
			email.select(); 	
			return false; 
		} 
		return true; 
	}
	
	function showMsg(){
		document.myform.action="HomeForm.jsp";
	 	document.myform.submit();
	}
	
	function Operation1(){
		var ans=confirm("Do you really want to save  the changes?");
	 	if (ans==true){
	  		document.myform.Operation.value=0;
	  		
	 	}
	 	else {
	 	    
	  		window.refresh;
	  		
	 	}
	}
	function Operation2(){
	    var ans=confirm("Do you really want to Delete this User?");
	 	if (ans==true){
	 		
	  		document.myform.Operation.value=1;
	  		document.myform.action="Edition.jsp";
	  		document.myform.submit();	  		
	  		
		}
	 	else {
	 	    document.myform.Operation.value=2;
	  	}
		
	}
	function Warn(){
		alert("U  Can't Change The User Name");
	}

	