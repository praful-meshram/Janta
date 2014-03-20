var xmlHttp;
var orderNumArray=new Array();
var countries = new Array("Afghanistan", "Albania", "Algeria");
// windows onload function
	window.onload=function(){
	
	
	$("#orderNum").jqxInput({placeHolder: "Enter a Order Number", height: 25, width: 200, minLength: 1, theme: 'ui-redmond'});
    
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
	
		//var theme = getDemoTheme(); 
		$("#range1").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',max:new Date(),formatString: "yyyy/MM/dd"});
		$("#range2").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: "yyyy/MM/dd",value:new Date()});
		//$("#range1").jqxDateTimeInput({readonly:true});
		//$("#range2").jqxDateTimeInput({disabled: true});
		
		//$('#range1').jqxDateTimeInput({allowNullDate: true});
		//alert( $('#range1').jqxDateTimeInput('allowNullDate'));
		
		$('#range1').on('close', function (event) {
		 // Some code here. 
		 	$("#range2").jqxDateTimeInput({disabled: false});
		 	$("#range2").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});
 		}); 
	}

 

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

 
function getSalesAnalysis(){
	//alert($('#range1').jqxDateTimeInput('getDate'))
	//return;
	
	var dateRange1 = $('#range1').jqxDateTimeInput('getText');
	var dateRange2 = $('#range2').jqxDateTimeInput('getText');
	var orderNum = $('#orderNum').val();
	
	//alert("orderNum "+orderNum);
	ifOrderNum = (orderNum=='' || orderNum==null || orderNum=='Enter a Order Number');
	ifOrderDate = (dateRange1=="" || dateRange1==null )|| (dateRange2=="" || dateRange2==null);
	
	//alert(ifOrderNum && ifOrderDate)
	if(ifOrderNum && ifOrderDate){
		alert('please enter Order Number or Date range');
		return;
	}
	else if (!ifOrderNum){
		
	}
	else{
		
		if(dateRange1=="" || dateRange1==null ){
				alert('please select from date');
				return; 
			}
			
		if(dateRange2=="" || dateRange2==null ){
				alert('please select To date');
				return;
			}
	}
	
		
	 	var url;
	 if(!ifOrderNum){
	 	url="call_option=suggestedOrderNumberList&orderNum="+orderNum;
	 
	 }else{
	 	url = "dateRange1="+dateRange1;
		url = url+"&dateRange2="+dateRange2;;
		url = url+"&call_option=analysis_list";
	 }
	
	//alert(url);
		
		$.ajax({
		url:"SalesAnalysis.jsp",
		type:'post',
		data:url,
		dataType:'json',
		success:function(ajaxResonse)
		{	
			//alert('success '+jQuery.parseJSON(ajaxResonse));
			//document.getElementById("sales_info").innerHTML = ajaxResonse;
			//	document.getElementById("sales_info").style.border = '1px solid black';
		 	
		 	$('#excell').css({'display':'block'});
		 	
		 	//alert(ajaxResonse);
		 	
		 	 var source =
            {
                localdata:ajaxResonse ,
                datatype: "array"
                
            };
            	
		
			$("#sales_info").jqxGrid(
            {
            	theme:'darkblue',
                height: 350,
                source: source,
                sortable: true,
                filterable: true,
                width:'100%',
                // pageable :true,
                //showaggregates: true,
                  groupable: true,
                 // groupsrenderer: groupsrenderer,
                selectionmode: 'singlerow',
                columnsresize: true,
                columns: [
                  { text: 'Site Name ', datafield: 'siteName', width: 120 },
                  { text: 'Customer Name', datafield: 'customerName', width: 150 },
                  { text: 'Building', datafield: 'bulding', width: 150},
                  { text: 'Station', datafield: 'station', width: 120 },
                  { text: 'Item group Desc', datafield: 'itemGroupDesc', width: 135 },
                  { text: 'FMCG IND', datafield: 'FMCG_IND', width: 80 },
                  { text: 'Item Name', datafield: 'itemName', width: 130 },
                  
                  { text: 'Order No', datafield: 'orderNo', width: 68 },
                  { text: 'Order Date', datafield: 'orderDate', width: 90, cellsformat: 'yyyy-MM-dd' },
                  { text: 'Total Value Discount', datafield: 'totalValueDiscount', width: 144 },
                  { text: 'Quatity', datafield: 'quantity', width: 55 },
                  { text: 'Price', datafield: 'price', width: 85},
                  { text: 'Item Discount', datafield: 'itemDiscount', width: 101 },
                  
                  
                ]
            });
            
             $("#sales_info").jqxGrid('clearselection');  
            $("#sales_info").unbind('cellselect');
			$("#sales_info").unbind('rowselect');
	     	$("#sales_info").bind('rowselect', function (event) {
			var row = $("#sales_info").jqxGrid('getrowdata', event.args.rowindex);
				passVar(row.orderNo1);
				   
			}); 
			$("#sales_info").jqxGrid('clearselection');
			
            $("#saveToExcel").click(function () {
            	
            	$('#sales_info').jqxGrid('showcolumn', 'orderNo1');
            	$('#sales_info').jqxGrid('hidecolumn', 'orderNo');
               
                //$("#sales_info").jqxGrid('beginupdate');
                $("#sales_info").jqxGrid('exportdata', 'xls', 'Sales Analysis Details');   
 				//$("#sales_info").jqxGrid('resumeupdate');
                
                $('#sales_info').jqxGrid('hidecolumn', 'orderNo1');
            	$('#sales_info').jqxGrid('showcolumn', 'orderNo');
            	        
            });	  
           
			
			
            
            
			
		} // end of ajax success
		
	});// end of ajax call	
	
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
	
	// alert("breakdown number :"+number+"  breakdown detaisl url :" + url);
	
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




var newUrl ="";
function passVar(code){

	    newUrl="print_orderAjaxPopUp.jsp?backPage=RcustSalesForm.jsp&buttonFlag=Y&orderNo="+code;
	   //alert(newUrl);
	   // window.location.assign(newUrl);
	    
	    
	    $.ajax({
			url:newUrl,
			type:'post',
			data:'',
			dataType:'text',
			success:function(ajaxResonse)
			{	
				
				$('#stack_info').html(ajaxResonse);	
				//document.getElementById("stack_info").innerHTML = " ";	
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

function enterNumber(event){
	//alert(event.keyCode);
	var keyCode = event.keyCode;
	
	if(keyCode>=65 && keyCode<=90){
		alert('enter valid order Number');
		event.preventDefault();
		return false;
		 
	} 
	
}


