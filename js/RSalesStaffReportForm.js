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

function Clear(){
	document.myform.selUeser.value="all";	
	
	
	 $("#range1").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',max:new Date(),formatString: "yyyy/MM/dd"});
		$("#range2").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: "yyyy/MM/dd",value:new Date()});
		
		//$("#range1").jqxDateTimeInput({readonly:true});
		//$("#range2").jqxDateTimeInput({disabled: true});
		
		
		$('#range1').on('close', function (event) {
		 // Some code here. 
		 	$("#range2").jqxDateTimeInput({disabled: false});
		 	$("#range2").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});
 		}); 
		
	return false;
}

function showMsg(){
	 document.myform.action="HomeForm.jsp";
 	 document.myform.submit();
}

function checkField(){
	//var frDate = document.myform.frDate.value;
	//var toDate = document.myform.toDate.value;
	
	//alert(document.myform.selUeser.value);
	
	var frDate = $('#range1').jqxDateTimeInput('getText');
	var toDate = $('#range2').jqxDateTimeInput('getText');
	
	var tempFrDate = frDate;
	var tempToDate = toDate;

	var selUeser = document.myform.selUeser.value;
	
	//var frDate = document.myform.frDate.value;
	//var toDate = document.myform.toDate.value;
	
	var Criteria = "Criteria : Sales Persons "+selUeser+" Report From Date "+frDate+" To "+toDate+"." ;

	
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	if(!($("#range2").jqxDateTimeInput('disabled')))
  	{	
  		var Criteria = "Criteria : Sales Persons "+selUeser+" Report From Date "+frDate+" To "+toDate;
		var url="RSalesStaffReport.jsp?fromDate="+frDate+"&toDate="+toDate+"&selUeser="+selUeser+"&Criteria="+Criteria;	
	}else{
		var Criteria = "Criteria : Sales Persons "+selUeser;
		var url="RSalesStaffReport.jsp?selUeser="+selUeser+"&Criteria="+Criteria;
	}
	//document.myform.frDate.value = tempFrDate;
	//document.myform.toDate.value = tempToDate;
	
	//$('#range1').jqxDateTimeInput({'value':tempFrDate});
	//$('#range2').jqxDateTimeInput({'value':tempToDate});
	
	document.myform.action = url;
	//alert(Criteria+"\n url ="+url);
	
	document.myform.submit();
}
	/*document.getElementById("pdfDiv").innerHTML  = "Please Wait...";
	alert(url);
	xmlHttp.onreadystatechange=statereport;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);	
}

function statereport(){	
	if (xmlHttp.readyState==4){ 
		//alert(xmlHttp.responseText);
		var result =xmlHttp.responseText.replace(/^\s+|\s+$/g,"");
		document.getElementById("pdfDiv").innerHTML = result;
	}
}*/