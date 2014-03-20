var xmlHttp1;
var xmlHttp2;
var xmlHttp3;
var xmlHttp4;
var cust_code;
var dot_count = 0;

function GetXmlHttpObject() {
	var xmlHttp = null;
	try {
		// Firefox, Opera 8.0+, Safari
		xmlHttp = new XMLHttpRequest();
	} catch (e) {
		// Internet Explorer
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	return xmlHttp;
}

function loadCustDetails(cust_code1) {
	cust_code = cust_code1;
	xmlHttp2 = GetXmlHttpObject()
	if (xmlHttp2 == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	var url = "ReceivePaymentAjaxResponse.jsp";
	url = url + "?call_option=cust_info"
	url = url + "&cust_code=" + cust_code1;
	xmlHttp2.onreadystatechange = showCustDetails;
	xmlHttp2.open("GET", url, true);
	xmlHttp2.send(null);
}

function showCustDetails() {
	if (xmlHttp2.readyState == 4) {
		document.getElementById("cust_info").innerHTML = xmlHttp2.responseText;
		loadOrderDetails();
	}
}

function loadOrderDetails() {
	xmlHttp3 = GetXmlHttpObject()
	if (xmlHttp3 == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	var url = "ReceivePaymentAjaxResponse.jsp";
	url = url + "?call_option=order_info"
	url = url + "&cust_code=" + cust_code;
	xmlHttp3.onreadystatechange = showOrderDetails;
	xmlHttp3.open("GET", url, true);
	xmlHttp3.send(null);
}

function showOrderDetails() {
	if (xmlHttp3.readyState == 4) {
		document.getElementById("order_detail").innerHTML = xmlHttp3.responseText;
		loaadRecentPayment();
	}
}

function loaadRecentPayment(){
	xmlHttp1 = GetXmlHttpObject()
	if (xmlHttp1 == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	var url = "ReceivePaymentAjaxResponse.jsp";
	url = url + "?call_option=recent_payment"
	url = url + "&cust_code=" + cust_code;
	xmlHttp1.onreadystatechange = showRecentPayment;
	xmlHttp1.open("GET", url, true);
	xmlHttp1.send(null);
}

function showRecentPayment(){
	if (xmlHttp1.readyState == 4) {
		document.getElementById("recent_payment_detail").innerHTML = xmlHttp1.responseText;
	}
}

function loaadDetailSinglePayment(pay_code,amount,receive_by,date){
	xmlHttp4 = GetXmlHttpObject()
	if (xmlHttp4 == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	var url = "ReceivePaymentAjaxResponse.jsp";
	url = url + "?call_option=detail_payment"
	url = url + "&pay_code=" + pay_code;
	url = url + "&amount=" + amount;
	url = url + "&receive_by=" + receive_by;
	url = url + "&date=" + date;
	xmlHttp4.onreadystatechange = showDetailPayment;
	xmlHttp4.open("GET", url, true);
	xmlHttp4.send(null);
}

function showDetailPayment(){
	if (xmlHttp4.readyState == 4) {
		document.getElementById("single_payment_detail").innerHTML = xmlHttp4.responseText;
		//document.myform.total_payment.focus();
	}
}

function copyAmount(fromid, toid , index) {
	if(parseFloat(document.getElementById("rem_amt").innerHTML)==0){
		alert("All Payment Distributed. No Remaining Payment..");
		return;
	}
	document.getElementById("right_"+index).style.display = 'none';
	document.getElementById("wrong_"+index).style.display = 'none';
	document.getElementById("rem_amt").innerHTML = parseFloat(document.getElementById("rem_amt").innerHTML) + parseFloat(document.getElementById(toid).value); 
	document.getElementById("cal_amt").innerHTML = parseFloat(document.getElementById("cal_amt").innerHTML) - parseFloat(document.getElementById(toid).value); 
	if (document.myform.total_payment.value == ""
			|| document.myform.total_payment.value == "0") {
		alert("Please Enter Payment First");
		document.myform.total_payment.focus();
		return;
	}
	if (parseFloat(document.getElementById("rem_amt").innerHTML) < parseFloat(document
			.getElementById(fromid).innerHTML)) {
		alert("Entered amount can not be greater than remaining amount..");
		
		document.getElementById(toid).value = document.getElementById("rem_amt").innerHTML;
		document.getElementById("wrong_"+index).style.display = 'block';
		calculate(toid);
		return;
	}

	document.getElementById(toid).value = document.getElementById(fromid).innerHTML;
	document.getElementById("right_"+index).style.display = 'block';
	calculate(toid);
}

function goBack() {
	window.location = "EditTargetReportForm.jsp?call_type=receive_payment";
}

function isNumberKey(evt) {
	var charCode = (evt.which) ? evt.which : event.keyCode;
	if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
		return false;
	else
		return true;
}

function checkTotal(obj, balance) {
	if (document.myform.total_payment.value == ""
			|| document.myform.total_payment.value == "0") {
		alert("Please Enter Payment First");
		document.myform.total_payment.focus();
		document.getElementById(obj).value = "";
		return;
	}
	if (parseFloat(document.getElementById("rem_amt").innerHTML) < parseFloat(document
			.getElementById(obj).value)) {
		alert("Entered amount can not be greater than remaining amount..");
		document.getElementById(obj).value = document.getElementById("rem_amt").innerHTML;
		calculate(obj);
		return;
	}
	if (parseFloat(document.getElementById(balance).innerHTML) < parseFloat(document
			.getElementById(obj).value)) {
		alert("Entered amount can not be greater than remaining amount..");
		document.getElementById(obj).value = document.getElementById(balance).innerHTML;
		calculate(obj);
		return;
	}
	calculate(obj);
}

function manageAmount() {
	var total_payment = parseFloat(document.myform.total_payment.value);
	var grand_total_balance = parseFloat(document.getElementById("grand_total_balance").innerHTML);
	if(total_payment > grand_total_balance){
		alert("Payment can not be grater than Total Pending Balance..");
		var str = document.myform.total_payment.value;
		document.myform.total_payment.value = str.substring(0, str.length - 1);
		return;
	}
	document.getElementById("rem_amt").innerHTML = document.getElementById("total_amt").value;
	document.getElementById("tot_amt").innerHTML = document.getElementById("total_amt").value;
	document.getElementById("cal_amt").innerHTML = "0";
	var rows = parseInt(document.getElementById("row_count").value);
	for ( var i = 0; i < rows; i++) {
		document.getElementById("amount_" + i).value = "0";
		document.getElementById("right_" + i).style.display = 'none';
		document.getElementById("wrong_" + i).style.display = 'none';
	}
}
function calculate(obj) {
	document.getElementById("rem_amt").innerHTML = parseFloat(document.getElementById("rem_amt").innerHTML)- parseFloat(document.getElementById(obj).value);
	document.getElementById("cal_amt").innerHTML = parseFloat(document.getElementById("cal_amt").innerHTML)+ parseFloat(document.getElementById(obj).value);
}
function confirmAction() {
	if (document.myform.total_payment.value == ""
			|| document.myform.total_payment.value == "0") {
		alert("Please Enter Payment First");
		document.myform.total_payment.focus();
		return false;
	}
	if (parseFloat(document.getElementById("rem_amt").innerHTML) > 0) {
		alert("Please Distibute All Payment");
		document.myform.total_payment.focus();
		return false;
	}
	document.myform.rem_amt_send.value = document.getElementById("rem_amt").innerHTML;
	return confirm("Are you sure to update the paymant data..");
}

function distributePayment() {
	manageAmount();
	if (document.myform.total_payment.value == ""
			|| document.myform.total_payment.value == "0") {
		alert("Please Enter Payment First");
		document.myform.total_payment.focus();
		return;
	}
	var rows = parseInt(document.getElementById("row_count").value);
	for ( var i = 0; i < rows; i++) {
		copyAmount1("balance_" + i, "amount_" + i,i);
	}
	document.myform.total_payment.focus();
}

function copyAmount1(fromid, toid , index ) {
	if(parseFloat(document.getElementById("rem_amt").innerHTML)==0){
		return;
	}
	if (parseFloat(document.getElementById("rem_amt").innerHTML) < parseFloat(document.getElementById(fromid).innerHTML)) {
		document.getElementById(toid).value = document.getElementById("rem_amt").innerHTML;
		document.getElementById("wrong_"+index).style.display = 'block';
		calculate(toid);
		return;
	}

	document.getElementById(toid).value = document.getElementById(fromid).innerHTML;
	document.getElementById("right_"+index).style.display = 'block';
	calculate(toid);
}

function displayOrderDetail(ord_num){
	xmlHttp = GetXmlHttpObject()
	if (xmlHttp == null) {
		alert("Your browser does not support AJAX!");
		return;
	}
	
	var url="print_order.jsp";
	url=url+"?orderNo="+ord_num;
	url=url+"&callfrom=receive_payment_page";
	url=url+"&sid="+Math.random();		
	xmlHttp.onreadystatechange = showOrderDetailsPopup;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
}

function showOrderDetailsPopup(){
	var msg = xmlHttp.responseText;
	if (xmlHttp.readyState == 4) {
		document.getElementById("order_detail_popup").innerHTML = msg;
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
 function returnItemPage(order_no){
	window.location = "DeliveryActionForm.jsp?orderNo="+order_no+"&subValue=Transit3&backPage=ReceivePayment.jsp&cust_code="+cust_code;
}	
 
function confirmDiscount(toid , fromid, waivedid,index){
	var bal = parseFloat(document.getElementById(fromid).innerHTML);
	var less = parseFloat(document.getElementById(toid).value);
	var waived = bal-less;
	// rem0ve comment to apply limit on waived amount; change 100 to other limit
	/*if(waived > 100){
		alert("Cnanot Waived amount grater than 100.");
		return;
	}*/
	var ans = confirm("Are you Sure to waived off "+waived+" Rs on the order");
	if(ans){
		document.getElementById(waivedid).value = waived;
		document.getElementById(toid).value = less+waived;
		document.getElementById("wrong_"+index).style.display = 'none';
		document.getElementById("right_"+index).style.display = 'block';
		document.getElementById("undo_"+index).style.display = 'block';
	}else{
		return;
	}
}
function undoDiscount(toid , fromid, waivedid,index){
	var bal = parseFloat(document.getElementById(fromid).innerHTML);
	var waived = parseFloat(document.getElementById(waivedid).value);
	document.getElementById(waivedid).value = "0";
	document.getElementById(toid).value = bal-waived;
	document.getElementById("wrong_"+index).style.display = 'block';
	document.getElementById("right_"+index).style.display = 'none';
	document.getElementById("undo_"+index).style.display = 'none';
}