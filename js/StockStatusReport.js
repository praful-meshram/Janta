//declacing global array  
var CheckBoxIDGlobalArray = new Array();
var itemCodeGlobalArray = new Array();

$(document).ready(function(){
	
	$.ajax({
		url:"StockStatusReportAjaxResponse.jsp",
		type:'post',
		data:'ajaxCall=itemName',
		dataType:'text',
		success:function(ajaxResonse)
		{	
			// document.getElementById("item_list_td").innerHTML = ajaxResonse;
			// document.getElementById("item_list_td").focus();
		} //end of success
		
	});	// end of ajax

}); // end of document ready function


function getItemDetails(){

	if(itemCodeGlobalArray.length==0){
		alert("select at least 1 item ");
		return;
	}
	
	var url = "ajaxCall=itemDetails&itemCodeArray="+itemCodeGlobalArray;
	
	$.ajax({
		url:"StockStatusReportAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'json',
		success:function(ajaxResonse)
		{	
			
			 //document.getElementById("item_list_details").innerHTML = ajaxResonse;
			 $('#imageGrid').css({'display':'block'});
			 
			  var source =
            {
                localdata:ajaxResonse.OutputData,
                datatype: "array"
                
            };
		
			var dataAdapter = new $.jqx.dataAdapter(source);
			
			var toThemeProperty = function (className) {
                //return className + " " + className + "-" + theme;
                return className + " " + className + "-";
            }
			
			var groupsrenderer = function (text, group, expanded, data) {
                    var number = dataAdapter.formatNumber(group, data.groupcolumn.cellsformat);
                    data.groupcolumn.datafield = 'item_site_qty';
                    var text = data.groupcolumn.text + ': ' + number;
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
            
		
		
			$("#item_list_details").jqxGrid(
            {
            	theme:'darkblue',
                height: 300,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                 //pageable :true,
                //showaggregates: true,
                  groupable: true,
                  groupsrenderer: groupsrenderer,
                //selectionmode: 'singlerow',
                columnsresize: true,
                columns: ajaxResonse.format
            });
			 
			
			
			  $("#saveToExcel").click(function () {
                $("#item_list_details").jqxGrid('exportdata', 'xls', 'Sales Details');           
            }); 
			
		} //end of success
		
	});	// end of ajax
	
}

function getSuggestedItem(){
	
	CheckBoxIDGlobalArray = new Array();
	itemCodeGlobalArray = new Array();
	
	//alert($('#searchItemName').val());
	var item_name = $('#searchItemName').val();
	
	$.ajax({
		url:"StockStatusReportAjaxResponse.jsp",
		type:'post',
		data:'ajaxCall=suggestedItemDetails&item_name='+item_name,
		dataType:'json',
		success:function(ajaxResonse)
		{	
			
			 //document.getElementById("item_list_details").innerHTML = ajaxResonse;
			 
			  var source =
            {
                localdata:ajaxResonse.OutputData,
                datatype: "array"
                
            };
		
			$("#suggesetedGrid").jqxGrid(
            {
            	theme:'darkblue',
                height: '200',
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                 //pageable :true,
                //showaggregates: true,
                //  groupable: true,
                //selectionmode: 'singlerow',
                columnsresize: true,
                columns: ajaxResonse.format
            });
			 
			//centerPopup();
			 //loadPopup();
			$('#suggestedRow').css({'display':'block'});
			
            
			
			
		} //end of success
		
	});	// end of ajax
	
	
}

function addStock(checkBox,item_name){
	//alert(checkBox.id+" "+item_name);
	//alert($('#'+checkBox.id)+" "+checkBox.id)
	//if($('#'+checkBox.id).prop(':checked'))
	
	if(checkBox.checked){
		//alert("if ");
		CheckBoxIDGlobalArray.push(checkBox.id);
		itemCodeGlobalArray.push(item_name);
	}
	else{
		// alert("else ");
			for(var i = 0;i<CheckBoxIDGlobalArray.length;i++){
				if(CheckBoxIDGlobalArray[i]==checkBox.id){
					CheckBoxIDGlobalArray.splice(i,1);
					itemCodeGlobalArray.splice(i,1);	
				}
			}
	}
		
}

// for pop up
var popupStatus = 0;

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
