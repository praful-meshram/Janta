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

function getdata1(){
	getData();
}
function getData() {
	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	var url = "ReorderListAjaxResponse.jsp";
	url = url + "?site_id="+document.myform.siteId.value;
	url = url + "&site_name="+document.myform.siteId[document.myform.siteId.value].text;
	xmlHttp.onreadystatechange = setReorderList;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
}

function setReorderList() {
	if (xmlHttp.readyState == 4) {
		//document.getElementById("reorder_list").innerHTML = xmlHttp.responseText;
		
		var gsonObject = jQuery.parseJSON(xmlHttp.responseText);
			 var source =
            {
                localdata: gsonObject.OutputData,
                datatype: "array"
                
            };
            
         	$("#reorder_list").jqxGrid(
            {	
            	theme:'darkblue',
                height: 340,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                //showaggregates: true,
                //selectionmode: 'singlerow',
                  groupable: true,
                  columnsresize: true,
                  columns:gsonObject.format
                
            });	
            
             $("#saveToExcel").click(function () {
                $("#reorder_list").jqxGrid('exportdata', 'xls', 'Reorde List Details');           
            });	
		
	}
}

window.onload = getSites;

function getSites() {
	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	var url = "AcceptInventoryAjaxResponse.jsp";
	url = url + "?ajaxCallOption=getSite";
	xmlHttp.onreadystatechange = setSite;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
}

function setSite(){
	if (xmlHttp.readyState == 4) {
		document.getElementById("site_td").innerHTML = xmlHttp.responseText;
	}
}

function printPage(){
	if(document.getElementById("item_count").innerHTML == 0){
		alert("Nothing to print..")
		return;
	}
	var html="<html>";
	html+= document.getElementById("reorder_list").innerHTML;
	html+="</html>";
	var printWin = window.open('','','left=3,top=4,width=5,height=2,toolbar=0,scrollbars=2,status  =0');
	printWin.document.write(html);
	printWin.document.close();
	printWin.focus();
	printWin.print();
	printWin.close();
}

function saveToExcell(){
	if(document.getElementById("item_count").innerHTML == 0){
		alert("Nothing to Save..")
		return;
	}
	document.excell.data.value=document.getElementById("reorder_list").innerHTML;
	document.excell.submit();
}