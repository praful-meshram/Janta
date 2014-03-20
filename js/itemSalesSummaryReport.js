var flag;
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
	var flag=true;
	
	document.myform.iGroupCode.value="select";			
	document.myform.chckall.checked= true;
	
	$("#range1").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',max:new Date(),formatString: "dd/MM/yyyy"});
	$("#range2").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: "dd/MM/yyyy",value:new Date()});
	
	$('#range1').on('close', function (event) {
		 // Some code here. 
		 	
		 	$("#range2").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});
 		}); 	
	
	//document.myform.frDate.value="";
	//document.myform.frDate.value="";
	
	if(document.myform.itemname.value != ""){
		document.getElementById("box").innerHTML='';
		document.getElementById("selbox").innerHTML='';
		document.getElementById("dispitem").innerHTML='';
		document.getElementById("dispitem").style.visibility="hidden";	
		document.getElementById("dispitem").style.display="none";  
	}
	document.myform.itemname.value="";
	document.getElementById('div4').style.visibility="hidden";
		
	return false;
}
//---------Page : Report Disply ..............
function checkField(){
	//var fromDate = document.myform.frDate.value;
	//var toDate = document.myform.toDate.value;
	
	var fromDate =$('#range1').jqxDateTimeInput('getText');
	var toDate = $('#range2').jqxDateTimeInput('getText');
	
	var GroupCode = document.myform.iGroupCode.value;
	var itemName = document.myform.itemname.value;
	
	//alert(fromDate+" "+toDate);
	
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="ItemSalesSummaryReport.jsp?fromDate="+fromDate+"&toDate="+toDate+"&grpCode="+GroupCode+"&item="+itemName;			
	//alert(url);
	
	document.myform.action=url;
	document.myform.submit();
	
	//xmlHttp.onreadystatechange=statereport;
	//xmlHttp.open("GET",url,true);
	//xmlHttp.send(null);	
}

function statereport(){	
	if (xmlHttp.readyState==4){ 		
		var result =xmlHttp.responseText.replace(/^\s+|\s+$/g,"");
		document.getElementById("pdfDiv").innerHTML = result;
	}
}


