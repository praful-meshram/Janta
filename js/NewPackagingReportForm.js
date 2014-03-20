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

 
function getBreakDownList(){
	
	document.getElementById("frDate").value =  $('#range1').jqxDateTimeInput('getText');
	document.getElementById("toDate").value = $('#range2').jqxDateTimeInput('getText');

	var fromDate = document.getElementById("frDate").value;
	var toDate = document.getElementById("toDate").value;
	
	//alert("from date "+ fromDate +" toDate "+toDate); 
	
	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	//	alert("browser support ajax ");
	
	var url = "NewPackagingReport1.jsp";
	var url = url+"?fromDate="+fromDate;
	var url = url+"&toDate="+toDate;
	var url = url+"&call_option=brekdown_list";
	
	// alert("url 11 :" +url);
	
	xmlHttp.onreadystatechange = SetBreakdownList;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
	
}

function SetBreakdownList() {
	if (xmlHttp.readyState == 4) {
	$('#firstDIV').html('<table style="width: 100%;height: auto;border: 10px;">'+
		'<tr style="cursor: pointer;"><td style="width: 97%;"><img alt="All Reports" src="images/Background/report.png" onclick="window.location.assign(\'Reports.jsp\');"'+
		'style=\"float:right;\"></td><td><img alt="Home" src="images/Background/House-icon.png" onclick="window.location.assign(\'HomeForm.jsp\');" style=\"float:right;\">'+
		'</td><td><img alt=\"Save To Excel\" src="images/Background/Excel-icon (2).png"  id=\"saveToExcel\" style=\"float:right;\"/></td>	</tr>'+
		'<tr></tr></table><h3>Search Result</h3>');
		
	var gsonObject = jQuery.parseJSON(xmlHttp.responseText);
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
         	$("#item_list_td").jqxGrid(
            {	
            	theme:'darkblue',
                height: 350,
                source: source,
                sortable: true,
                filterable: true,
                width:'100%',
                //pageable :true,
                //showaggregates: true,
                groupable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
                columns:gsonObject.format
                
            });	
			
			$("#item_list_td").jqxGrid('clearselection');  
            $("#item_list_td").unbind('cellselect');
			$("#item_list_td").unbind('rowselect');
	     	$("#item_list_td").bind('rowselect', function (event) {
	     	var row = $("#item_list_td").jqxGrid('getrowdata', event.args.rowindex);
					passVar(row);
				 
			}); 
			
			$("#saveToExcel").click(function () {
				
                $("#item_list_td").jqxGrid('exportdata', 'xls', 'Customer Details');          
            });	
	
	}
}

function getBreakdownDetails(number){
//	alert("breakdown number :"+number);
	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	
	var url = "NewPackagingReport1.jsp";
	var url = url+"?bd_number="+number;
	var url = url+"&call_option=brekdown_details";
	
	xmlHttp.onreadystatechange = SetBreakdownDetails;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
	
}


function SetBreakdownDetails() {
	if (xmlHttp.readyState == 4) {
		document.getElementById("breakdown_info").innerHTML = xmlHttp.responseText;
		centerPopup();
		loadPopup();
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


var newUrl ="";
function passVar(rowData){
	
	   newUrl="NewPackagingReport1.jsp?call_option=brekdown_detailsPopUp&breakDownNumber="+rowData.breakdownNumber;
	    $.ajax({
			url:newUrl,
			type:'post',
			data:'',
			dataType:'json',
			success:function(gsonObject)
			{	
				
				var source =
	            {
	                localdata:  gsonObject.OutputData,
	                datatype: "array"
	                
	            };
			
				$("#breakdown_info").jqxGrid(
	            {
	            	theme:'darkblue',
	                height: 200,
	                source: source,
	                sortable: true,
	                filterable: true,
	                //groupable: true,
	                width:'100%',
	                //pageable :true,
	                //showaggregates: true,
	                //selectionmode: 'singlerow',
	                columnsresize: true,
	                columns: gsonObject.format
	            });
				
				var rowDetails = "<hr><br/><table border=0 style='padding: 5px;width:100%;margin-left: 2px;'><tr><td><b>Breakdown Number :</b> "+rowData.breakdownNumber
				rowDetails += "</td><td><b>Bachka Name :</b> "+rowData.bachkaName
				rowDetails += "</td><td><b> Weight :</b> "+rowData.itemWeight
				rowDetails += "<td/></tr><tr><td><b>Loss :</b> "+rowData.loss
				rowDetails += "</td><td><b>Gain :</b> "+rowData.gain
				rowDetails += "</td><td><b>Site :</b> "+rowData.siteName
				rowDetails += "</td></tr><td><b>Date :</b> "+rowData.breakdownDate
				rowDetails += "</td><td><b>Entered By  :</b> "+rowData.enteredBy
				rowDetails += "</td><td></td><td></td></tr></table><br/<br/>"
				
				
				$('#rowDetails').html(rowDetails);
					
				centerPopup();
				loadPopup();
			
			}
		
		});
 	      
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
	

function printPage() {
	var html = "<html>";
	html += document.getElementById("breakdown_info").innerHTML;
	html += "</html>";

	var printWin = window.open('', '',
			'left=3,top=4,width=5,height=2,toolbar=0,scrollbars=2,status  =0');
	
	//	var printWin = window.open('', '',
	//		'left=10,top=10,width=10,height=10,toolbar=0,scrollbars=2,status  =0');
	
			
	printWin.document.write(html);
	printWin.document.close();
	printWin.focus();
	printWin.print();
	printWin.close();
}

