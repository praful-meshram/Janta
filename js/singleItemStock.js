var xmlHttp;
var globalUrl = null;
function GetXmlHttpObject() {
	var xmlHttp = null;
	try {
		xmlHttp = new XMLHttpRequest();
	} catch (e) {
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	return xmlHttp;
}

function getItemList() {
	var item_name = document.getElementById("item_name_id").value;
	var item_code = document.getElementById("item_code_id").value;
	var item_group = document.getElementById("item_group_id").value;
	var item_barcode = document.getElementById("item_barcode_id").value;
	if (item_name == "" && item_code == "" && item_group == ""
			&& item_barcode == "") {
		alert("Please Enter Atleast On Criteria..")
		document.getElementById("item_name_id").focus();
		return;
	}
	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	var url = "ItemList.jsp";
	var url = url + "?item_name=" + item_name;
	var url = url + "&item_code=" + item_code;
	var url = url + "&item_group=" + item_group;
	var url = url + "&item_barcode=" + item_barcode;
	var url = url + "&call_option=item_list";
	globalUrl = url;
	xmlHttp.onreadystatechange = SetItemList;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
	
	
	
}

function SetItemList() {
	if (xmlHttp.readyState == 4) {
		//document.getElementById("item_list_td").innerHTML = jQuery.parseJSON(xmlHttp.responseText);
			 $("#excelRow").css({'display':'block'});
			var gsonObject = jQuery.parseJSON(xmlHttp.responseText);
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
         	$("#item_list_td").jqxGrid(
            {	
            	theme:'darkblue',
                height: 340,
                source: source,
                sortable: true,
                filterable: true,
                width:'100%',
                //pageable :true,
                //showaggregates: true,
                selectionmode: 'singlerow',
                  groupable: true,
                  columnsresize: true,
                columns:gsonObject.format
                
            });	
            
           
            
            $("#item_list_td").jqxGrid('clearselection');  
            $("#item_list_td").unbind('cellselect');
			$("#item_list_td").unbind('rowselect');
	     	$("#item_list_td").bind('rowselect', function (event) {
			var row = $("#item_list_td").jqxGrid('getrowdata', event.args.rowindex);
			//	alert(row.itemCode+" "+row.itemName+" "+row.weight+"  "+row.quntity);
				getStock(row.itemCode,row.itemName,row.weight,row.quntity);
				   
			}); 
			$("#item_list_td").jqxGrid('clearselection');
			
			
			$("#saveToExcel").click(function () {
                $("#item_list_td").jqxGrid('exportdata', 'xls', 'Item Wise Stock Report');    
                //window.location.assign(globalUrl+"&excel=true")  
                     
            });
            
         	
           
           
		document.getElementById("item_list_td").style.border = '1px solid black';
	}
}

function getStock(item_code, name, weight, qty) {
	
	var url = "item_code=" + item_code;
	var url = url + "&call_option=item_stock";
	var url = url + "&name=" + name;
	var url = url + "&weight=" + weight;
	var url = url + "&qty=" + qty;
	//alert(url);
	$.ajax({
		url:"ItemList.jsp",
		type:'post',
		data:url,
		dataType:'json',
		success:function(gsonObject)
		{	
		
		$('#list1').html('<b>Item Name :&nbsp;</b>'+name);
		$('#list2').html('<b>Item Weight :&nbsp;</b>'+weight);
		$('#list3').html('<b>Total Quantity :&nbsp;</b>'+gsonObject.grandTotalValues);
		
		 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
            
         	$("#stack_info").jqxGrid(
            {	
            	theme:'darkblue',
                height: 170,
                source: dataAdapter,
                sortable: true,
                filterable: true,
                width:656,
                //pageable :true,
               // showaggregates: true,
                //showstatusbar: true,
                //groupable: true,
               // selectionmode: 'singlecell',
                columnsresize: true,
                columns:gsonObject.format
                
            });	
		
		centerPopup();
		loadPopup();
			
		} //end of success
		
	});	// end of ajax
	
	
}

function SetItemStock(name,weight,qty) {
	if (xmlHttp.readyState == 4) {
		
		//document.getElementById("stack_info").innerHTML = ;
		
		
		 
		 var gsonObject = jQuery.parseJSON(xmlHttp.responseText)
		 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
         	$("#stack_info").jqxGrid(
            {	
            	theme:'darkblue',
                height: 170,
                source: source,
                sortable: true,
                filterable: true,
                width:656,
                //pageable :true,
               // showaggregates: true,
                //showstatusbar: true,
                //groupable: true,
               // selectionmode: 'singlecell',
                columnsresize: true,
                columns:gsonObject.format
                
            });	
		
		centerPopup();
		loadPopup();
	}
}

function clear() {
	document.getElementById("item_name_id").value = "";
	document.getElementById("item_code_id").value = "";
	document.getElementById("item_group_id").value = "";
	document.getElementById("item_barcode_id").value = "";
}

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

$(document).ready(function() {
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
});

function printPage() {
	var html = "<html>";
	html += document.getElementById("stack_info").innerHTML;
	html += "</html>";

	var printWin = window.open('', '',
			'left=3,top=4,width=5,height=2,toolbar=0,scrollbars=2,status  =0');
	printWin.document.write(html);
	printWin.document.close();
	printWin.focus();
	printWin.print();
	printWin.close();
}