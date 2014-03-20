var frDate = null;
var toDate = null;
var popupStatus = 0;

 var toThemeProperty = function (className) {
       //return className + " " + className + "-" + theme;
        return className + " " + className;
   }

$(document).ready(function(){
		$("#range1").jqxDateTimeInput({theme:'ui-redmond', width: '250px', height: '25px',max:new Date(),formatString: "yyyy-MM-dd"});
		$("#range2").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),readonly:true,formatString: "yyyy-MM-dd",value:new Date()});
		
		//$("#range2").jqxDateTimeInput({disabled: true});
		
		$('#range1').on('close', function (event) {
		 // Some code here. 
		 	$("#range2").jqxDateTimeInput({disabled: false});
		 	$("#range2").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});
 		});
 		
 		
 		$("#popupContactClose").click(function() {
		disablePopup();
	});
	$("#backgroundPopup").click(function() {
		disablePopup();
	});
	$(document).keypress(function(e) {
		if (e.keyCode == 27 && popupStatus == 1) {
			disablePopup();
		}
	});
	//alert(document.documentElement.clientWidth/2)
	//$('.result').css({'width':document.documentElement.clientWidth/2})
 		
});


function getSuggestedItem(){
	
	var item_name = $('#searchItemName').val();
	
	//alert("item_name "+item_name +"\n length "+item_name.length); 
	 
		if(item_name.length<3){
		//alert('Please enter item name at least 3 character ');
		alert('Please enter at least 3 character ');
		return;
		}
	
	frDate = $('#range1').jqxDateTimeInput('getText');
	toDate = $('#range2').jqxDateTimeInput('getText');
	
	 
	$.ajax({
		url:"StockMovementAjaxResponse.jsp",
		type:'post',
		data:'ajaxCall=suggestedItemDetails&item_name='+item_name,
		dataType:'text',
		success:function(ajaxResonse)
		{	
			//alert('success'+ajaxResonse);
			$('#stack_info').html(ajaxResonse);
			
			 centerPopup();
			 loadPopup();
			
		} //end of success
		
	});	// end of ajax
	
}



// for pop up


function loadPopup() {
	if (popupStatus == 0) {
		$("#backgroundPopup").css({
			"opacity" : "0.7"
		});
		$("#backgroundPopup").fadeIn("slow");
		$("#popupContact").fadeIn("slow");
		popupStatus = 1;
	}
}

function disablePopup() {
	if (popupStatus == 1) {
		$("#backgroundPopup").fadeOut("slow");
		$("#popupContact").fadeOut("slow");
		popupStatus = 0;
	}
}

function centerPopup() {
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	var popupHeight = $("#popupContact").height();
	var popupWidth = $("#popupContact").width();
	$("#popupContact").css({
		"position" : "absolute",
		"top" : windowHeight / 2 - popupHeight / 2,
		"left" : windowWidth / 2 - popupWidth / 2
	});
	$("#backgroundPopup").css({
		"height" : windowHeight
	});

}

function currentRowOver(row){
$(row).css({'background-color':'gray'});
}
function currentRowOut(row){
$(row).css({'background-color':'transparent'});
}


// Report Stock
function getStock(item_code, name, weight, qty) {
	

	
	var url = "item_code=" + item_code;
	url = url + "&ajaxCall=item_stock";
	
		
		$.ajax({
		url:"StockMovementAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'json',
		success:function(gsonObject)
		{	
			
			disablePopup();	
			
			$('#list1').html('<b>Item Name :&nbsp;</b>'+name);
			$('#list2').html('<b>Item Weight :&nbsp;</b>'+weight);
			$('#list3').html('<b>Total Quantity :&nbsp;</b>'+gsonObject.grandTotalValues);
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
         	$("#stock").jqxGrid(
            {	
            	theme:'darkblue',
                height: 190,
                source: source,
                sortable: true,
                filterable: true,
                width:656,
                pageable :true,
               // showaggregates: true,
                //showstatusbar: true,
                groupable: true,
               // selectionmode: 'singlecell',
                columnsresize: true,
                columns:gsonObject.format
                
            });	
			
			//$("#stockToExcel").css({'display':'block'});
			
			$("#stockToExcel").click(function () {
                $("#stock").jqxGrid('exportdata', 'xls', 'Item Stock Details');           
            });
			
			
			//calling report function
			 getReport(item_code); 
			
			
		} //end of success
		
	});	// end of ajax
	
	
}	
	
// Purchase Details
function getPurchaseDetails(item_code) {
	var url = "item_code=" + item_code;
	url = url + "&ajaxCall=purchaseDetails";
	url = url + "&fromDate=" + frDate;
	url = url + "&toDate=" + toDate;
	
		$.ajax({
		url:"StockMovementAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'json',
		success:function(gsonObject)
		{	
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
             var groupsrenderer = function (text, group, expanded, data) {
                    var number = dataAdapter.formatNumber(group, data.groupcolumn.cellsformat);
                    var text = data.groupcolumn.text + ': ' + number;
              		data.groupcolumn.datafield='total_items';
              		
                    if (data.subItems.length > 0) {
                        var aggregate = this.getcolumnaggregateddata(data.groupcolumn.datafield, ['sum'], true, data.subItems);
                    }
                    else {
                        var rows = new Array();
                        var getRows = function (group, rows) {
                            if (group.subGroups.length > 0) {
                                for (var i = 0; i < group.subGroups.length; i++) {
                                    getRows(group.subGroups[i], rows);
                                }
                            }
                            else {
                                for (var i = 0; i < group.subItems.length; i++) {
                                    rows.push(group.subItems[i]);
                                }
                            }
                        }
                        getRows(data, rows);
                        var aggregate = this.getcolumnaggregateddata(data.groupcolumn.datafield, ['sum'], true, rows);
                    }
                    
                    return '<div class="' + toThemeProperty('jqx-grid-groups-row') + '" style="position: absolute;"><span>' + text + ', </span>' + '<span class="' + toThemeProperty('jqx-grid-groups-row-details') + '">' + "Total Items " + ' (' + aggregate.sum + ')' + '</span></div>';
               
            }
            
         	$("#purchase").jqxGrid(
            {	
            	theme:'darkblue',
                height: 190,
                source: dataAdapter,
                sortable: true,
                filterable: true,
                width:656,
                //pageable :true,
                showstatusbar: true,
                showaggregates: true,
                groupsrenderer: groupsrenderer,
                groupable: true,
                selectionmode: 'singlecell',
                columnsresize: true,
                columns:
                [
	                {"text":"PO Number","datafield":"po_number","hidden":false,"sortable":true},
	                {"text":"Bill Number","datafield":"bill_number","hidden":false,"sortable":true},
	                {"text":"Vendor Name","datafield":"vendor_name","hidden":false,"sortable":true},
	                {"text":"Site Name","datafield":"site_name","hidden":false,"sortable":true},
	                {"text":"Item Mrp","datafield":"item_mrp","hidden":false,"sortable":true},
	                {"text":"Item Rate","datafield":"item_rate","hidden":false,"sortable":true},
	                {"text":"Total Items","datafield":"total_items","hidden":false,"sortable":true,aggregates:['sum']},
	                {"text":"PO Date","datafield":"po_date","hidden":false,"sortable":true},
	                {"text":"New Qty","datafield":"new_qty","hidden":false,"sortable":true},
	                {"text":"Entered By","datafield":"enteredby","hidden":false,"sortable":true}
	             ]
                
            });	
			
			//$("#purchaseToExcel").css({'display':'block'});
			$("#purchaseToExcel").click(function () {
                $("#purchase").jqxGrid('exportdata', 'xls', 'Purchase Details');           
            });
			
			
		} //end of success
		
	});	// end of ajax
	
}	

//transefer details 
function getTransferDetails(item_code) {
	
	var url = "item_code=" + item_code;
	url = url + "&ajaxCall=transferDetails";
	
		$.ajax({
		url:"StockMovementAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'json',
		success:function(gsonObject)
		{	
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
             var dataAdapter = new $.jqx.dataAdapter(source);
             
             
            var groupsrenderer = function (text, group, expanded, data) {
                    var number = dataAdapter.formatNumber(group, data.groupcolumn.cellsformat);
                    var text = data.groupcolumn.text + ': ' + number;
              		data.groupcolumn.datafield='transfer_qty';
              		
                    if (data.subItems.length > 0) {
                        var aggregate = this.getcolumnaggregateddata(data.groupcolumn.datafield, ['sum'], true, data.subItems);
                    }
                    else {
                        var rows = new Array();
                        var getRows = function (group, rows) {
                            if (group.subGroups.length > 0) {
                                for (var i = 0; i < group.subGroups.length; i++) {
                                    getRows(group.subGroups[i], rows);
                                }
                            }
                            else {
                                for (var i = 0; i < group.subItems.length; i++) {
                                    rows.push(group.subItems[i]);
                                }
                            }
                        }
                        getRows(data, rows);
                        var aggregate = this.getcolumnaggregateddata(data.groupcolumn.datafield, ['sum'], true, rows);
                    }
                    
                    return '<div class="' + toThemeProperty('jqx-grid-groups-row') + '" style="position: absolute;"><span>' + text + ', </span>' + '<span class="' + toThemeProperty('jqx-grid-groups-row-details') + '">' + "Total" + ' (' + aggregate.sum + ')' + '</span></div>';
               
            }
             
         	$("#transfer").jqxGrid(
            {	
            	theme:'darkblue',
                height: 190,
                source: dataAdapter,
                sortable: true,
                filterable: true,
                width:656,
                //pageable :true,
                groupsrenderer: groupsrenderer,
                groupable: true,
                showstatusbar: true,
                showaggregates: true,
                selectionmode: 'singlecell',
                columnsresize: true,
                columns:
                [
	                {"text":"Transfer ID","datafield":"transfer_id","hidden":false,"sortable":true},
	                {"text":"Source ","datafield":"source","hidden":false,"sortable":true},
	                {"text":"Dest    ","datafield":"dest","hidden":false,"sortable":true},
	                {"text":"Transfer Qty","datafield":"transfer_qty","aggregates":['sum'],"hidden":false,"sortable":true},
	                {"text":"Item MRP","datafield":"item_mrp","hidden":false,"sortable":true},
	                {"text":"Item Rate","datafield":"item_rate","hidden":false,"sortable":true},
	                {"text":"Item Trans Status","datafield":"item_trans_status","hidden":false,"sortable":true}
                ]
                
            });	
            
            
			
			//$("#transferToExcel").css({'display':'block'});
			$("#transferToExcel").click(function () {
                $("#transfer").jqxGrid('exportdata', 'xls', 'Transfer Details');           
            });				
			
		}
           
        }); 
	
}

function gerSalesReport(item_code){
// alert('sales report');

	var url = "item_code="+ item_code;
	url = url + "&ajaxCall=salesDetails";
	url = url + "&fromDate="+frDate;
	url = url + "&toDate="+toDate;
	
		$.ajax({
		url:"StockMovementAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'json',
		success:function(gsonObject)
		{	
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array",
                
            };
             var dataAdapter = new $.jqx.dataAdapter(source);
             var groupsrenderer = function (text, group, expanded, data) {
                    var number = dataAdapter.formatNumber(group, data.groupcolumn.cellsformat);
                    var text = data.groupcolumn.text + ': ' + number;
              		data.groupcolumn.datafield='totalQty';
              		
                    if (data.subItems.length > 0) {
                        var aggregate = this.getcolumnaggregateddata(data.groupcolumn.datafield, ['sum'], true, data.subItems);
                    }
                    else {
                        var rows = new Array();
                        var getRows = function (group, rows) {
                            if (group.subGroups.length > 0) {
                                for (var i = 0; i < group.subGroups.length; i++) {
                                    getRows(group.subGroups[i], rows);
                                }
                            }
                            else {
                                for (var i = 0; i < group.subItems.length; i++) {
                                    rows.push(group.subItems[i]);
                                }
                            }
                        }
                        getRows(data, rows);
                        var aggregate = this.getcolumnaggregateddata(data.groupcolumn.datafield, ['sum'], true, rows);
                    }
                    
                    return '<div class="' + toThemeProperty('jqx-grid-groups-row') + '" style="position: absolute;"><span>' + text + ', </span>' + '<span class="' + toThemeProperty('jqx-grid-groups-row-details') + '">' + "Total" + ' (' + aggregate.sum + ')' + '</span></div>';
               
            }
             
             
          	$("#sales").jqxGrid(
            {	
            	theme:'darkblue',
                height: 190,
                source: dataAdapter,
                sortable: true,
                filterable: true,
                width:656,
                //pageable :true,
                showaggregates: true,
                showstatusbar: true,
                groupsrenderer: groupsrenderer,
                groupable: true,
                //selectionmode: 'singlecell',
                columnsresize: true,
                columns:[
			                {"text":"Order Number","datafield":"orderNumber","hidden":false,"sortable":true},
			                {"text":"Order Date","datafield":"orderDate","hidden":false,"sortable":true},
			                {"text":"Item Rate","datafield":"itemRate","hidden":false,"sortable":true},
			                {"text":"Qty      ","datafield":"totalQty","hidden":false,"sortable":true,aggregates:['sum']},
			                {"text":"Total Value","datafield":"totalItemValue","hidden":false,"sortable":true}
		                ]
                
            });	
			
			//$("#salesToExcel").css({'display':'block'});
			$("#salesToExcel").click(function () {
                $("#sales").jqxGrid('exportdata', 'xls', 'Sales Details');           
            });				
			
		}
           
        }); 
	
}

function getReport(item_code){
	
	getTransferDetails(item_code);
	getPurchaseDetails(item_code);
	gerSalesReport(item_code);
}



    
         
           