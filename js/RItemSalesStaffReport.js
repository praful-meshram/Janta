var xmlHttp;
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
	
	
	document.myform.chckall.checked = true;
	document.getElementById('hidDiv').style.visibility="hidden";
	document.myform.serachItemName.value="all";	
	return false;
}

function showMsg(){
	 document.myform.action="HomeForm.jsp";
 	 document.myform.submit();
}

function funEnabled(){
    if (document.myform.chckall.checked==true){
		document.getElementById('hidDiv').style.visibility="hidden";
		document.myform.serachItemName.value="all";	
	}
	else{
		document.getElementById('hidDiv').style.visibility="visible";	
		document.myform.serachItemName.value="";
	}
}

function funGetData(){
	var serachItem = document.myform.serachItemName.value;
	if(serachItem == "all"){
		checkField("all");
	}else{	
		xmlHttp=GetXmlHttpObject()
		if (xmlHttp==null){
	  		alert ("Your browser does not support AJAX!");
	  		return;
	  	} 
		var url="RItemSalesStaffReport.jsp?serachItem="+serachItem+"&type=searchItem";	
		document.getElementById("dataDiv").innerHTML  = "Please Wait...";
		//alert(url);
		xmlHttp.onreadystatechange=stateChangeFunGetData;
		xmlHttp.open("GET",url,true);
		xmlHttp.send(null);	
	}
}

function stateChangeFunGetData(){
	
		if (xmlHttp.readyState==4){ 		
		//document.getElementById("dataDiv").innerHTML = xmlHttp.responseText;
		gsonObject = jQuery.parseJSON(xmlHttp.responseText);
		
		 var source =
            {
                localdata:gsonObject.OutputData,
                datatype: "array"
                
            };
			$("#dataDiv").jqxGrid(
            {	
            	theme:'darkblue',
	            height: 350,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                //showaggregates: true,
                //selectionmode: 'singlecell',
                //autoresizecolumns :true;
                columns: gsonObject.format
            });	
            
		
	}	
	
}


function checkField(selItem){
	//var frDate = document.myform.frDate.value;
	//var toDate = document.myform.toDate.value;
	
	var frDate = $('#range1').jqxDateTimeInput('getText');
	var toDate = $('#range2').jqxDateTimeInput('getText');
	
	var tempFrDate = frDate;
	var tempToDate = toDate;
		
 		 	
	var selUeser = document.myform.selUeser.value;
	
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	
  	if(!($("#range2").jqxDateTimeInput('disabled')))
  	{	
  		var Criteria = "Criteria : Item Name :"+selItem+", Sales Persons :"+selUeser+", Report From Date "+frDate+" To "+toDate+"." ;
  		var url="RItemSalesStaffReport.jsp?fromDate="+frDate+"&toDate="+toDate+"&selUeser="+selUeser+"&selItem="+selItem+"&type=pdf&Criteria="+Criteria;
  	}
  	else{
  	var Criteria = "Criteria : Item Name :"+selItem+", Sales Persons :"+selUeser;
  		var url="RItemSalesStaffReport.jsp?selUeser="+selUeser+"&selItem="+selItem+"&type=pdf&Criteria="+Criteria;
  	}
		
	
	//document.myform.frDate.value = tempFrDate;
	//document.myform.toDate.value = tempToDate;
	
	document.myform.action = url;
	//alert(url)
	//return;
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