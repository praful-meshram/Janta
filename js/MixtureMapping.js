//global variable declaration
var searchItemName = "";
var searchBarCode = "";	
var siteId = "";
var globalMixtureCode =null;
var globalItemGroupCode = null;
var globalMixtureCodeArray = new Array();
var globalItemCodeArray = new Array();

var rowCount = 0;
// on window onLoad
function initializeBachkaMapping()
		{		
			getSiteList();
			GetMixtureMapping();
		}




// function to fetch site name and Id from Database
function getSiteList(){
	var url="ajaxCallOption=getSite";
  	url=url+"&sid="+Math.random();
	$.ajax({
		url:"MixtureMappingAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'text',
		success:function(ajaxResonse)
		{	
			 document.getElementById("siteNameDiv").innerHTML = ajaxResonse;
			 document.getElementById("siteId").focus();
		}
	});	
 
} 

//code for searching bachka

function funSearchBachka(){
	searchItemName = document.bachkaMappingForm.bachkaName.value;
	searchBarCode = document.bachkaMappingForm.bachkaBarcode.value;	
	siteId = document.getElementById("siteId").value
	
	if(siteId == "" || siteId==null){
		
		alert("Please select site name");
		document.getElementById("siteId").focus();
		return false;
	}
	if(searchItemName == "" && searchBarCode == ""){
		alert("Please enter barcode or bachka name");
		document.bachkaMappingForm.bachkaName.focus();
		return false;
	}
	if(!isNaN(searchItemName))
	{
		alert("Please enter valid bachka name");
		document.bachkaMappingForm.bachkaName.focus();
		return;
	}
   	var url="ajaxCallOption=searchBachka";
  	url=url+"&searchBarCode="+searchBarCode;
  	url=url+"&searchItemName="+searchItemName;
  	url=url+"&siteId="+siteId;
  	url=url+"&sid="+Math.random();
  	
  	//alert('siteId '+siteId);
  	
  	//$("#displayBachkaId").html("<img src = 'images/Background/ajax-loader (3).gif' alt='loading'/><br/><br/>loading...");
  	
  	$("#displayBachkaIdCol").addClass("bachka");
  	
  	$.ajax({
		url:"MixtureMappingAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'text',
		success:function(ajaxResonse)
		{	
			//alert('ajax '+ajaxResonse);	
			$('#displayBachkaId').html(ajaxResonse);
			
			$('#bachkaTable').dataTable({
	        "sDom": "Rlfrtip",
	     	"bPaginate": false,
	     	"sScrollY": "100px"
		});
			  
		}
	});
}



// function to display info about selected bachka
function createSelectBachkaTable(item_code,item_name,item_weight,item_mrp,site_qty,item_qty,item_group_code)
{	
	globalMixtureCodeArray = new Array();
	globalItemCodeArray = new Array();
	
	globalMixtureCode = item_code;
	globalItemGroupCode = item_group_code;
	//alert(globalMixtureCode);
	//alert("item_name "+item_name+"\nitem_weight  "+item_weight+ " \n item mrp "+item_mrp+"\nsite qty "+site_qty+" item qty "+item_qty); 
	//alert(item_group_code);	
	
	$("#selectedItemName").html(item_name);
	$("#selectedItemWeight").html(item_weight);
	$("#selecteditemMrp").html(item_mrp);
	//$("#selectedItemSiteQty").html(site_qty);
	$("#selectedItemTotalQty").html(item_qty); 
	
	
	getItemGroupCode(globalItemGroupCode)
 	//getItemByGroupCode(globalItemGroupCode);
 	getItemByGroupCode();
	GetMixtureMapping();
	
}


// function for item group code
 function getItemGroupCode(item_group_code){
 	var url="ajaxCallOption=getItemGroupCode";
 	if(item_group_code!=undefined){
 	//	alert(" item group code ");
	  	url=url+"&item_group_code="+item_group_code;
	  }
	 
	 $("#itemByGroupCodeCol").addClass("bachka");
  	
  	$.ajax({
		url:"MixtureMappingAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'text',
		success:function(ajaxResonse)
		{	//alert("success");
			document.getElementById("searchItemByGroupCode").innerHTML = ajaxResonse;
			//getItemByGroupCode(item_group_code);
			// getItemByGroupCode(item_group_code);
			
		}
	});	
 
  
}




// function for item group code
 function getItemByGroupCode(item_group_code,itemName){
 
 	/* //globalMixtureCodeArray = new Array();
	//globalItemCodeArray = new Array();
 	
	
 	if(item_group_code==undefined){
 		//
 		item_group_code = $("#itemGroupCode option:selected").text();
 		//alert(item_group_code);
 	}
 
 //	alert('siteId '+siteId);
 	var url="ajaxCallOption=getItemByGroupCode";
 	url+="&item_group_code="+item_group_code;
 	url+="&siteID="+siteId;
 	url=url+"&mixtureCode="+globalMixtureCode;
 	
 	// $("#itemByGroupCode").html("<img src = 'images/Background/ajax-loader (3).gif' alt='loading' style=\"margin-left:300px;margin-top:70px;\"/>"); */
 	
 	
 	//
 	 	var url="ajaxCallOption=getItemByGroupCode";
 	
 
 	if(item_group_code==undefined && itemName==undefined){	
 		//alert("if ");
		//item_group_code = $("#itemGroupCode option:selected").val();
		item_group_code = globalItemGroupCode	
 	 	url+="&item_group_code="+item_group_code;
	 }	
 	else{
 		//alert("else ");
		item_group_code = $("#itemGroupCode option:selected").val();
		itemName = document.getElementById("itemName").value;
		url+="&item_group_code="+item_group_code+"&itemName="+itemName;
		
 	}	
 	url+="&siteID="+siteId;
 	url=url+"&mixtureCode="+globalMixtureCode;
 	
 	
 	$.ajax({
		url:"MixtureMappingAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'text',
		success:function(ajaxResonse)
		{	//alert(ajaxResonse);
			$("#itemByGroupCode").html(ajaxResonse);
			//getItemByGroupCode(item_group_code);
			
			$('#itemByGroupCodeTable').dataTable({
	        "sDom": "Rlfrtip",
	     	"bPaginate": false,
	     	"sScrollY": "205px"
		});
			
		}
	});	
 
  
}

function addItemIntoDIV(item_name,item_weight,item_code,checkboxID){
	// disable checkbox to prevent from duplication 
	$("#"+checkboxID).attr('disabled',true);
	
	imageRemove = "<img id='remove' src='images/trash-iconBachka.png' alt='remove item' value='' onClick=\"deleteRow('row"+rowCount+"','"+checkboxID+"','"+globalMixtureCode+"','"+item_code+"');\"></img>";
	
	//alert(item_name+"\n "+item_weight +" \n"+globalMixtureCode+"\n "+item_code);
	
	/* if(rowCount==0)
		$("#mixtureMapping").empty(); */
	
	//var row = document.createElement("<tr class='.alt' style='text-align: left;height: 3px;color:#000000;background-color:#EAF2D3;'  id='row"+rowCount+"'>");
	var row = null;
	
	/* 
		
	if(rowCount%2==0){
		row = document.createElement("<tr style='text-align: left;height: 3px;color:#000000;background-color:#EAF2D3;'  id='row"+rowCount+"'>");
		}
	else{
		row = document.createElement("<tr style='text-align: left;height: 3px;'  id='row"+rowCount+"'>");
		
	}
	 */
	
	row = document.createElement("<tr style='text-align: left;height: 3px;'  id='row"+rowCount+"'>");
	var col1 = document.createElement("<td>");
	col1.innerHTML= item_name;
	row.appendChild(col1);
	

	
	var col3 = document.createElement("<td>");
	col3.innerHTML= item_code;
	row.appendChild(col3);
	
	var col2 = document.createElement("<td>");
	col2.innerHTML= item_weight;
	row.appendChild(col2);
	
	var col4 = document.createElement("<td>");
	col4.innerHTML= imageRemove;
	row.appendChild(col4);
	
//	document.getElementById('mixtureMapping').appendChild(row);
	$("#mixtureMapping").append(row);
	
	globalMixtureCodeArray.push(globalMixtureCode);
	globalItemCodeArray.push(item_code);
	
	
//	var globalMixtureCodeArray = new Array();
//	var globalItemCodeArray = new Array();
	
	
	
	rowCount++;

}


// function to delete data from div and database
function deleteRow(row_id,checkboxID,mixture_code,item_code){
	//alert('row id '+ row_id);
	//return;
	//alert("mixture  code "+mixture_code+" \n item code "+item_code);
	
	if(!confirm('Are you sure you want to delete?')){
		return false;
	}
	else{
	$('#'+row_id).remove();
	//alert(checkboxID+ "  "+ $("#"+checkboxID));
	$("#"+checkboxID).attr("checked", false);
	$("#"+checkboxID).attr('disabled',false);
	
		rowCount--;
	}
	
	for(var i = 0 ; i<globalMixtureCodeArray.length && i<globalItemCodeArray.length;i++)
	{
		if(mixture_code==globalMixtureCodeArray[i] && item_code == globalItemCodeArray[i]){
			globalMixtureCodeArray.splice(i,1);
			globalItemCodeArray.splice(i,1);
			
			
		}
	}

	alert(" item deleted from grid ");
}

function deleteRowFromDatabase(row_id,mixture_code,item_code){
	
	//alert(row_id+" "+mixture_code+" "+item_code);
	
	if(!confirm('Are you sure you want to delete?')){
		return false;
	}
	else{
	$('#'+row_id).remove();
	
	
	var url="ajaxCallOption=deleteFromDB";
	url+="&mixture_code="+mixture_code;
	url+="&item_code="+item_code;	
	
	$.ajax({
		url:"MixtureMappingAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'text',
		success:function(ajaxResonse)
		{	
			
			count = parseInt(ajaxResonse);
				if(count>0){
					alert(" item deleted from data base")
				}
				else{
						alert("error in deleting data ");
				}
			
			//$("#itemByGroupCode").html(ajaxResonse);
			//getItemByGroupCode(globalItemGroupCode);
			getItemByGroupCode();
			
		}
	});			


		
	}
	
}

//function to save item mapping into Databse
function saveToDB(){
//alert(globalItemCodeArray.length+" "+globalMixtureCodeArray.length);
if(globalMixtureCodeArray.length==0){
	alert("nothing to save ");
	return;
}


var url="ajaxCallOption=saveToDB";
url+="&mixtureCodeArray="+globalMixtureCodeArray;
url+="&itemCodeArray="+globalItemCodeArray;
 	

$.ajax({
		url:"MixtureMappingAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'text',
		success:function(ajaxResonse)
		{	
			
			count = parseInt(ajaxResonse);
				if(count>0){
					alert(count +" data item inserted successfully ");
					globalMixtureCodeArray = new Array();
					globalItemCodeArray = new Array();
				}
				else{
						alert("eror in inserting data ");
				}
			
			//alert(globalItemGroupCode);		
			//getItemGroupCode(globalItemGroupCode)
		 	//getItemByGroupCode(globalItemGroupCode);
			GetMixtureMapping();	
		
			
		}
	});	
 	
}

function GetMixtureMapping(){
	
	//alert(' get mixture mapping ');
	var url="ajaxCallOption=mixtureMapping";
  	url=url+"&globalMixtureCode="+globalMixtureCode;
  
  	$.ajax({
		url:"MixtureMappingAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'text',
		success:function(ajaxResonse)
		{	
			//alert('ajax '+ajaxResonse);	
			$('#addToBachka').html(ajaxResonse);
			rowCount = parseInt(1);
			
		/* 	$('#selectedBachkaTable1').dataTable({
	     	 "sDom": "Rlfrtip",
	     	"bPaginate": false,
	     	"sScrollY": "90px"
	   		}); 
			   */
		}
	});

}

// cancel item from Div
function cancelReccord(){
	if(globalMixtureCodeArray.length==0)
	{
		alert('nothing to cancel');
		return;
	}
	
	globalMixtureCodeArray = new Array();
	globalItemCodeArray = new Array();
	
	//alert(globalItemGroupCode);		
	//getItemGroupCode(globalItemGroupCode)
 	getItemByGroupCode(globalItemGroupCode);
 	getItemByGroupCode();
	GetMixtureMapping();
		
}

// on click function for search item 
function getItem(){
	//alert("jkhjk" +document.getElementById("itemName"));
	item_group_code = $("#itemGroupCode option:selected").val();
	itemName1 = document.getElementById("itemName").value;
	

	if((item_group_code=="" || item_group_code==null) && (itemName1=="" || itemName1 == null)){
		alert("enter value ");
		return;
	}
		globalMixtureCodeArray = new Array();
		globalItemCodeArray = new Array();
		
		GetMixtureMapping();
		getItemByGroupCode('aaa');
		
}
 
 

