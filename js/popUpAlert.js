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
	// alert(xmlHttp.responseText)
		document.getElementById("item_list_td").innerHTML = xmlHttp.responseText;
		document.getElementById("item_list_td").style.border = '1px solid black';
	}
}

function getBreakdownDetails(number){
//	alert("breakdown number :"+number);
	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	
	var url = "popUpAlertResponse.jsp";
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


	function Clear(){
	    var frday="";
	   	var newdate = new Date();
		var day= ""+newdate.getDate();
		if(day.length==1)
			day="0"+day;
		var month = ""+(newdate.getMonth()+1);		
		if(month.length==1)
			month="0"+month;
		var year  = newdate.getFullYear();
		
		 
		if(day==30)
		{
			alert(newdate.getMonth()-1);
			alert("30...");
		 
			
			if(newdate.getMonth()== 2)
			{
				frday="28";
			}
			
		}

		else if(day==31)
		{
			// alert(newdate.getMonth());
			// alert("30...");
		 
			
			if(newdate.getMonth() == 4 || newdate.getMonth() == 6 || newdate.getMonth()-1 == 9 || newdate.getMonth() == 11 )
			{
				frday="30";
			}
			else if ((newdate.getMonth()) == 2){
				frday="28";
			}
			
		}
		
		else if(day==29)
		{
			// alert(newdate.getMonth());
			// alert("30...");
		 
			if ((newdate.getMonth()) == 2){
				frday="28";
			}
			
		}
		
		else{
			frday=day;
		}
		
		var fromdate=frday +"/0"+ (month-1) +"/"+ year;
		newdate = day +"/"+ month + "/"+year;
		// document.myform.frDate.value= fromdate;
		// document.myform.toDate.value="";
		// document.myform.toDate.value=newdate;
		
		document.getElementById("frDate").value = fromdate;
		document.getElementById("toDate").value = newdate;
		
		
		return false;
	    
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