
function funEnabled(){
    if (document.myform.chckall.checked==true){
		document.getElementById('div4').style.visibility="hidden";
		document.myform.iGroupCode.value="select";	
	}
	else{
		document.getElementById('div4').style.visibility="visible";
		document.myform.hchckall.value=0;			
	}
}
function showMsg(){
 	 document.myform.action="HomeForm.jsp";
  	 document.myform.submit();
}

function Clear(){
	document.myform.iGroupCode.value="select";			
	document.myform.chckall.checked= true;
	document.myform.frDate.value="";
	document.myform.frDate.value="";
	
	if(document.myform.itemname.value != ""){
		document.getElementById("box").innerHTML='';
		document.getElementById("selbox").innerHTML='';
		document.getElementById("dispitem").innerHTML='';
		document.getElementById("dispitem").style.visibility="hidden";	
		document.getElementById("dispitem").style.display="none";  
	}
	document.myform.itemname.value="";
	document.getElementById('div4').style.visibility="hidden";
	var newdate = new Date();
	var day= ""+newdate.getDate();
	if(day.length==1)
		day="0"+day;
	var month = ""+(newdate.getMonth()+1);		
	if(month.length==1)
		month="0"+month;
	var year  = newdate.getFullYear()
	var fromdate="01/"+ month +"/"+ year;
	newdate = day +"/"+ month + "/"+year;
	document.myform.frDate.value= fromdate;
	document.myform.toDate.value="";
	document.myform.toDate.value=newdate;	
	return false;
}

//---------Page : Report Disply ..............
function GetXmlHttpObject(){
	var xmlHttp=null;	
	try{
		  xmlHttp=new XMLHttpRequest();			  // Firefox, Opera 8.0+, Safari
	}catch (e) {
		  try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");			  // Internet Explorer
		  }catch (e){
		    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		  }	
	}
		return xmlHttp;
}

function checkField(){
	var fromDate = document.myform.frDate.value;
	var toDate = document.myform.toDate.value;
	var GroupCode = document.myform.iGroupCode.value;
	var itemName = document.myform.itemname.value;
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="ItemSalesDetailReport.jsp?fromDate="+fromDate+"&toDate="+toDate+"&grpCode="+GroupCode+"&item="+itemName;			
	//alert(url);
	xmlHttp.onreadystatechange=statereport;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);	
}

function statereport(){	
	if (xmlHttp.readyState==4){ 
		var result =trim(xmlHttp.responseText);
		document.getElementById("pdfDiv").innerHTML = xmlHttp.responseText;
	}
}

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}
