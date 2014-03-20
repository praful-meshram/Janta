var xmlHttp;
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
	xmlHttp.onreadystatechange = SetItemList;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
}

function SetItemList() {
	if (xmlHttp.readyState == 4) {
		
		//document.getElementById("item_list_td").innerHTML = xmlHttp.responseText;
		//document.getElementById("item_list_td").style.border = '1px solid black';
		
		
		var gsonObject = jQuery.parseJSON(xmlHttp.responseText);
		
		 var source =
            {
                localdata:gsonObject.OutputData,
                datatype: "array"
                
            };
			$("#item_list_td").jqxGrid(
            {	
            	theme:'darkblue',
	            height: 340,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                //showaggregates: true,
                //showstatusbar: true,
                //selectionmode: 'singlecell',
                columns: gsonObject.format
            });	
	
		$("#saveToExcel").click(function () {
             
               $("#item_list_td").jqxGrid('exportdata', 'xls', 'Commission Order Report');     // not work for huge data
             
         });
	}
}

function getStock(item_code, name, weight, qty) {
	var from_date = document.getElementById("from_date").value;
	var to_date = document.getElementById("to_date").value;
	if (validateIndiaDate(from_date) == false) {
		alert("Choose Valid From Date...");
		return;
	}
	if (validateIndiaDate(to_date) == false) {
		alert("Choose Valid To Date...");
		return;
	}
	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	var url = "ItemDetailReport.jsp";
	var url = url + "?item_code=" + item_code;
	var url = url + "&call_option=item_sales";
	var url = url + "&name=" + name;
	var url = url + "&to_date=" + to_date;
	var url = url + "&from_date=" + from_date;
	xmlHttp.onreadystatechange = SetItemStock;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
}

function SetItemStock() {
	if (xmlHttp.readyState == 4) {
		document.getElementById("stack_info").innerHTML = xmlHttp.responseText;
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
	if (document.getElementById("count").innerHTML == 0) {
		alert("Noting to print...");
		return;
	}
	var html = "<html>";
	html += document.getElementById("stack_info").innerHTML;
	html += "</html>";
	var printWin = window
			.open(
					'',
					'',
					'left=3,top=4,width=5,height=2,toolbar=0,scrollbars=2,status=0,font-family=arial');
	printWin.document.write(html);
	printWin.document.close();
	printWin.focus();
	printWin.print();
	printWin.close();
}

var flag = true;
var caldef1 = {
	firstday : 0,
	dtype : 'dd/MM/yyyy',
	width : 250,
	windoww : 300,
	windowh : 200,
	border_width : 0,
	border_color : '#0000d3',
	dn_css : 'clsDayName',
	cd_css : 'clsCurrentDay',
	wd_css : 'clsWorkDay',
	we_css : 'clsWeekEnd',
	wdom_css : 'clsWorkDayOtherMonth',
	weom_css : 'clsWeekEndOtherMonth',
	headerstyle : {
		type : "comboboxes",
		css : 'clsWorkDayOtherMonth',
		yearrange : [ 1987, 2050 ]
	},
	monthnames : [ "January", "February", "March", "April", "May", "June",
			"July", "August", "September", "October", "November", "December" ],
	daynames : [ "Su", "Mo", "Tu", "We", "Th", "Fr", "Sa" ]
};
var c1 = new CodeThatCalendar(caldef1);

function validateIndiaDate(strValue) {
	var objRegExp = /^\d{1,2}(\-|\/|\.)\d{1,2}\1\d{4}$/
	if (!objRegExp.test(strValue))
		return false;
	else {
		var strSeparator = strValue.substring(2, 3);
		var arrayDate = strValue.split(strSeparator);
		var arrayLookup = {
			'01' : 31,
			'03' : 31,
			'04' : 30,
			'05' : 31,
			'06' : 30,
			'07' : 31,
			'08' : 31,
			'09' : 30,
			'10' : 31,
			'11' : 30,
			'12' : 31
		}
		var intDay = parseInt(arrayDate[0], 10);
		if (arrayLookup[arrayDate[1]] != null) {
			if (intDay <= arrayLookup[arrayDate[1]] && intDay != 0)
				return true;
		}
		var intYear = parseInt(arrayDate[2], 10);
		var intMonth = parseInt(arrayDate[1], 10);
		if (((intYear % 4 == 0 && intDay <= 29) || (intYear % 4 != 0 && intDay <= 28))
				&& intDay != 0)
			return true;
	}
	return false;
}
function getDetailForItem(name, code, date) {
	var url = "ItemDetailReport.jsp";
	var url = url + "?item_code=" + code;
	var url = url + "&call_option=item_sales_detail";
	var url = url + "&name=" + name;
	var url = url + "&date=" + date;
	open_in_new_tab(url);
}
function open_in_new_tab(url) {
	var win = window.open(url);
	win.focus();
}