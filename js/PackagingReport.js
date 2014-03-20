var xmlHttp;
var popupStatus = 0;
var myVal;
function GetXmlHttpObject()
{
	var xmlHttp=null;
	try
  	{
  		// Firefox, Opera 8.0+, Safari
  		xmlHttp=new XMLHttpRequest();
  	}
	catch (e)
  	{
  	// Internet Explorer
  		try
    	{
    		xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    	}
  		catch (e)
    	{
    	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    	}
  	}
	return xmlHttp;
}


function orderByBreakdownNumber(param)
{	
	alert("data in ascending order according to "+param);
	//alert(bd_number);
//	document.getElementById("tableRecord").innerHTML = "dis is new JSp";
	
  	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url="OrderByParamBreakdownHeader.jsp";
	url=url+"?param="+param;
	url=url+"&callOption=breakdownData";
	xmlHttp.onreadystatechange=stateChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function stateChanged() 
{
	if (xmlHttp.readyState==4)
	{ 
		document.getElementById("tableData").innerHTML = xmlHttp.responseText;		

	}	
}

function getPopup(param){
	//	alert("getPopup :"+param);
	// document.onmousemove = getMousePosition;

	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	
	var url = "OrderByParamBreakdownHeader.jsp";
	var url = url+"?param="+param;
	var url = url+"&callOption=popup";
	
	// alert("url :" + url);
	
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





/* 
	function centerPopup() {

	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	

	
	var popupHeight = 50+"px";
	var popupWidth = 100+"px";
		
			
		
	 
// alert("cursor _x : _y "+_x+" :"+_y);
 
	$("#popupContact").css({
		"position" : "absolute",
		"top" :150 ,
		"left" : 150
	});
	  
	 

	
	$("#backgroundPopup").css({
		"height" : windowHeight
	});

}

function loadPopup() {
//alert("popup status : "+popupStatus)
	if (popupStatus == 0) {
		$("#backgroundPopup").css({
			"opacity" : "0.7"
		});
		$("#backgroundPopup").fadeIn("slow");
		$("#popupContact").fadeIn("slow");
		popupStatus = 1;
	}
}

 */

 
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
	

 



/* 
	function getMousePosition(e) {
	
	if (!isIE) {
		_x = e.pageX;
		_y = e.pageY;
	}
	if (isIE) {
		_x = event.clientX + document.body.scrollLeft;
		_y = event.clientY + document.body.scrollTop;
	}
	posX = _x;
	posY = _y;
	return true;
}
	
	
 */


function closePopup()
{
	document.getElementById("breakdown_info").innerHtml="";
	document.myform.action="PackagingReport.jsp";
	document.myform.submit();
}


function goHome()
{
//alert("go home ...");
//document.myform.action.value="HomeForm.jsp";
//document.myform.action.submit;

 document.myform.action="HomeForm.jsp";
 document.myform.submit();
}

function getParamPopUp(column,link)
{
	//alert("getParamPopUp :: column :"+ column+" link "+link);
	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	
	var url = "OrderByParamBreakdownHeader.jsp";
	var url = url+"?param="+column;
	var url = url+"&link="+link;
	
	var url = url+"&callOption=popupParam";
	
	xmlHttp.onreadystatechange = SetBreakdownDetails;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
	
}

function getParamPopUpResult(column,link)
{	
	//alert("column :"+column+" link "+link);

	value = document.getElementById("th2").value;
	if(value=="" || value==null)
	{
		alert("enter a value ");
		return false;
	}
	//alert(" val is "+value);
	//return false;
	
	/* var url = "PackagingReport.jsp";
	var url = url+"?column="+column;
	var url = url+"&link="+link;
	var url = url+"&value="+value;
	var url = url+"&filter=yes";
	
	alert(url);
	document.myform.action=url;
	document.myform.submit(); */
	
	
	
	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	
	var url = "OrderByParamBreakdownHeader.jsp";
	var url = url+"?column="+column;
	var url = url+"&link="+link;
	var url = url+"&value="+value;
	
	
	var url = url+"&callOption=popupParamResult";
	
	//alert("url :" + url);
	
	//xmlHttp.onreadystatechange = SetBreakdownDetails;
	xmlHttp.onreadystatechange=stateChangedParamResult;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null); 
	
}

function stateChangedParamResult() 
{
	if (xmlHttp.readyState==4)
	{ 
			
		//closePopup();
		
		document.getElementById("tableData").innerHTML = xmlHttp.responseText;	
		//document.getElementById("breakdown_info").style.display="none";	
		//document.getElementById("breakdown_info").style.visibility = 'hidden'; 
		
	}	
}


/* function SetBreakdownDetails() {

	if (xmlHttp.readyState == 4) {
		document.getElementById("breakdown_info").innerHTML = xmlHttp.responseText;
		centerPopup();
		loadPopup();
	}	
} */


function getPopStart(param,link)
{
	alert("pop up param "+ param+" :: link "+link);
	
	SetPopStart();
	//window.showModalDialog("GetPopUpResult.jsp?param="+param+"&link="+link,window,"resizable: yes","width:250,height:150");
	window.showModalDialog("GetPopUpResult.jsp?param="+param+"&link="+link,window,'center:yes');
	
	
}

function getPopContains(param,link)
{
	alert("pop up param "+ param+" :: link "+link);
	
	SetPopStart();
	//window.showModalDialog("GetPopUpResult.jsp?param="+param+"&link="+link,"resizable: yes","width:250,height:150","target=_self");
	window.showModalDialog("GetPopUpResult.jsp?param="+param+"&link="+link,window,'center:yes');
	
}

function getPopEnd(param,link)
{
	alert("pop up param "+ param+" :: link "+link);
	
	SetPopStart();
	//window.showModalDialog("GetPopUpResult.jsp?param="+param+"&link="+link,"resizable: yes","width:250,height:150");
	window.showModalDialog("GetPopUpResult.jsp?param="+param+"&link="+link,window,'center:yes');
}


function SetPopStart() {

//	if (xmlHttp.readyState == 4) {
	
	$("#popupContact").css({
		"display":"none"
	});
	  
	 	
	$("#backgroundPopup").css({
		"display":"none"
	});

	
	
}


function getPopStartResult(param)
{
	//alert(param);
	var th2 = document.myform.th2.value;
	if(th2==" " || th2==null)
	{	
		alert ("enter value for "+param);
		return false;
	}
	//window.close();
	//alert("after close")
	document.myform.action="PackagingReport.jsp?filter=filterData&value="+th2;
	//document.myform.target="_top";
	document.myform.submit();	
	window.close();
	
	//alert(window.parent.parent.location)
	//window.parent.location.href = "PackagingReport.jsp?filter=filterData&value="+th2;
	
	///myVal = document.getElementById("th2").value;
	//alert()

       // window.opener.GetValueFromChild(myVal);

        window.close();

       // return false;
}	
	
	function GetValueFromChild(myVal)

    {	alert("ip from child :"+myVal);

        document.getElementById("hiddenValue").value = myVal;

    }
	

function windowRefresh()
{
	document.myform.action="PackagingReport.jsp";
 	document.myform.submit();	
	
}

function windowRefresh1()
{
	alert("window refresh 1");
	
	
	//document.myform.action="PackagingReport.jsp";
 	//document.myform.submit();	
	
	
			
	//document.myform.action="PackagingReport.jsp?filter=filterData&value=1";
	//document.myform.action="PackagingReport.jsp";
	
	//document.myform.target="_top";
	document.myform.submit();
	 
	
}

	
