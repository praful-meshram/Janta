var xmlHttp;
var xmlHttp1;

function showHint(code) {
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	
  	
	var url="customerOrderDetails_1.jsp";
	url=url+"?custCodeStartWith="+code;
	url=url+"&call_from=comm";
	xmlHttp.onreadystatechange=stateChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
} 

function stateChanged() 
{
	if (xmlHttp.readyState==4)
	{ 
	document.getElementById("div2").innerHTML=xmlHttp.responseText;
	
	}
}

function GetXmlHttpObject()
{
	var xmlHttp=null;
	try{
  		xmlHttp=new XMLHttpRequest();
  	}
	catch (e){
		try{
    		xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    	}
  		catch (e){
    	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    	}
  	}
	return xmlHttp;
}


	function validate(){
		var subject = document.getElementById("c_date_id").value;
		var feedback = document.getElementById("comm_feedback_id").value;
		if(subject == "" || subject == null){
			alert("Enter Date of Commitment..");
			document.getElementById("c_date_id").focus();
			return false;
		} else if(feedback == "" || feedback == null){
			alert("Enter Feddback of Communication..");
			document.getElementById("comm_feedback_id").focus();
			return false;
		} 
		
	}
	
	function loaadDetailSinglePayment1(pay_code,amount,receive_by,date){
		
		xmlHttp4 = GetXmlHttpObject()
		if (xmlHttp4 == null) {
			alert("Your browser does not support AJAX!");
			return;
		}
		var url = "ReceivePaymentAjaxResponse.jsp";
		url = url + "?call_option=detail_payment1"
		url = url + "&pay_code=" + pay_code;
		url = url + "&amount=" + amount;
		url = url + "&receive_by=" + receive_by;
		url = url + "&date=" + date;
		xmlHttp4.onreadystatechange = showDetailPayment1;
		xmlHttp4.open("GET", url, true);
		xmlHttp4.send(null);
	}

	function showDetailPayment1(){
		if (xmlHttp4.readyState == 4) {
			document.getElementById("order_detail_popup").innerHTML =xmlHttp4.responseText;
			displayPopup();
		}
	}

	function displayPopup(){
		document.getElementById('popupItemDiv').style.display = "block";
		Popup.showModal('popupItemDiv');
	} 

	function funCloseDiv(){
		document.getElementById("order_detail_popup").innerHTML = "";
		Popup.hide('popupItemDiv');
	}