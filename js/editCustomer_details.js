var xmlHttp;

function showHint() {
	
	var str;
	var str1;
	var str2;
	var str3;
	var str4;
	var str5;
	var str6;
	var str9, str10, str11,str12, str13,str14,str15,str16,str17,str18;
	var call_type = document.myform.call_type.value;
	var ordernumber ;
	
	str=document.myform.custName.value;
	str1=document.myform.phonenumber.value;
	str2=document.myform.Building.value;
	str3=document.myform.block.value;
	str4=document.myform.wing.value;
	str5=document.myform.add1.value;
	str6=document.myform.add2.value;
	str7=document.myform.custCode.value;
	str8=document.myform.nameString.value;
	str9=document.myform.Building_no.value;
	str10=document.myform.area.value;
	str11=document.myform.station.value;
	
	if(!($("#createDate2").jqxDateTimeInput('disabled'))){
		str12=$('#createDate1').jqxDateTimeInput('getText');
		str14=$('#createDate2').jqxDateTimeInput('getText');
	}
	else{
		str12="";
		str14="";
	}
	if(!($("#updateDate2").jqxDateTimeInput('disabled'))){
		str13=$('#updateDate1').jqxDateTimeInput('getText');
		str15=$('#updateDate2').jqxDateTimeInput('getText');
	}else{
		str13="";
		str15="";
	}
	
	str16=document.myform.hchckall.value;
	str17=document.myform.selmonth.value;
	var payment = document.myform.payment.value;
	str18=document.myform.mobilenumber.value;
	
	//return;

	if(call_type == "search_payment" || call_type == "communication"){
		ordernumber = document.myform.ordernumber.value;
	}
	
	//document.getElementById("waitMessage").innerHTML="Please wait for Some Time";
	
	//if (str.length==0 && str1.length==0 && str2.length==0 && str3.length==0 && str4.length==0 && str5.length==0 && str6.length==0&&str7.length==0 && str8.length==0 && str9.length==0 && str10.length==0 && str11.length==0 && str12.length==0 && str13.length==0 && str14.length==0 && str15.length==0 && str16.length==0 && str17.length==0 && str18.length == 0)
  	if (str.length==0 && str1.length==0 && str2.length==0 && str3.length==0 && str4.length==0 && str5.length==0 && str6.length==0 && str7.length==0 && str8.length==0 && str9.length==0 && str10.length==0 && str11.length==0 && str16.length==0 && str17.length==0 && str18.length == 0)
  	{ 
  		document.getElementById("txtHint").innerHTML="";
  		return;
  	}
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url = "editCustomerDetails.jsp";
	url = url + "?type=dispList&nameStartWith="+str+"&phStartWith="+str1+"&bldgStartWith="+str2;
	url = url + "&blockStartWith="+str3+"&wingStartWith="+str4+"&add1StartWith="+str5+"&add2StartWith="+str6;
	url = url + "&custCodeStartWith="+str7+"&nameStringStartWith="+str8+"&bldgnoStartWith="+str9;
	url = url + "&areaStartWith="+str10+"&stationStartWith="+str11+"&c_date1StartWith="+str12;
	url = url + "&u_date1StartWith="+str13+"&c_date2StartWith="+str14+"&u_date2StartWith="+str15;
	url = url + "&hchckallStartWith="+str16+"&selmonth="+str17+"&payment="+payment+"&t="+new Date().getTime()+"&fromForm="+document.myform.fromForm.value;
	url = url + "&moStartWith="+str18;
	url = url + "&sid="+Math.random();
	url = url + "&call_type="+call_type;
	url = url + "&ordernumber="+ordernumber;
	xmlHttp.onreadystatechange=stateChanged;

	//alert(url);
	
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
} 

function stateChanged() 
{
	if (xmlHttp.readyState==4)
	{ 
	//alert(xmlHttp.responseText);
	document.getElementById("waitMessage").innerHTML="";
	document.getElementById("txtHint").innerHTML=xmlHttp.responseText;
	$('#insert_table tr').has('td').remove();
	$('#order_count_id').val(0);
	/*try{alert(xmlHttp.responseText)
		var gsonObject = jQuery.parseJSON(xmlHttp.responseText);
		 var source =
            {
                localdata:gsonObject.OutputData,
                datatype: "array"
                
            };
			$("#txtHint").jqxGrid(
            {	
            	theme:'darkblue',
	            height: 350,
                source: source,
                sortable: true,
                //filterable: true,
                width:'100%',
                pageable :true,
                 groupable: true,
                columns:gsonObject.format 
            });	
	
		$("#saveToExcel").click(function () {
               	//$('#deliveryStaffJqwidget').jqxGrid('showcolumn', 'totalOrders1');
				//$('#deliveryStaffJqwidget').jqxGrid('hidecolumn', 'totalOrders');
               	$("#txtHint").jqxGrid('exportdata', 'xls', 'Commision Details');     
                
         });		
	}catch(err){
		
		//alert("Data Overflow the Memory ");
		alert("Too much data to handle ");
		window.location.reload();
	}*/
	
	}
}

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

function dispDiv(custcode,custname,payment,area){
//alert(payment);
	var url="editCustomerDetails.jsp";
	url=url+"?custcode="+custcode+"&custname="+custname+"&payment="+payment+"&type=dispDiv&area="+area+"";
	xmlHttp.onreadystatechange=stateChanged1;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}

function stateChanged1() 
{
	if (xmlHttp.readyState==4)
	{ 
		document.getElementById("dispdiv").innerHTML=xmlHttp.responseText;
		Popup.showModal('dispdiv',null,null,{'screenColor':'gray','screenOpacity':.6})	 
	}
}

function funclose(){
	Popup.hide('dispdiv');
}

function funsave(custcode,custname){
		//var selpay = document.myform.selpay.value;
		var selpay =$('select#selpay1 option:selected').val();
		Popup.hide('dispdiv');		
		var url="editCustomerDetails.jsp";
		url=url+"?custcode="+custcode+"&custname="+custname+"&payment="+selpay+"&type=savepay";
		xmlHttp.onreadystatechange=stateChanged2;
		xmlHttp.open("GET",url,true);
		xmlHttp.send(null);
}

function stateChanged2() 
{
	if (xmlHttp.readyState==4)
	{ 
		var disp = xmlHttp.responseText;
		var finaldisp = disp.replace(/^\s+|\s+$/g, '') ;
		alert(finaldisp);
		showHint();
	}
}

function selectCustomer(ch_id, row_id, cust_code,order_no,cust_name,balance){
	//alert(row_id+" "+document.getElementById(row_id).length+" "+document.getElementById("rows"))
	var rows = parseInt(document.getElementById("rows").value);
	
	var table=document.getElementById("insert_table");
	if(document.getElementById(ch_id).checked){
		if(document.getElementById("respective_check").checked){
			for(var i=0;i<rows;i++){
				if(trim(document.getElementById("cust_code_"+i).value) == cust_code){
					if(isOrderExist(trim(document.getElementById("order_"+i).innerHTML))){
						document.getElementById("ch_"+i).checked=true;
						
						var row=table.insertRow(0);
						row.setAttribute("id", "inserted_tr_"+i);
						var cell1=row.insertCell(0);
						cell1.style.width='20%';
						var cell2=row.insertCell(1);
						cell2.style.width='35%';
						var cell3=row.insertCell(2);
						cell3.style.width='20%';
						var cell4=row.insertCell(3);
						cell4.style.width='25%';
						cell2.innerHTML=cust_name;
						cell3.innerHTML=balance;
						cell1.innerHTML=trim(document.getElementById("order_"+i).innerHTML)+" <input type=\"hidden\" name=\"orders\" value=\""+trim(document.getElementById("order_"+i).innerHTML)+"\"/>";
						cell4.innerHTML="<font color=blue onclick=\"removeRow('inserted_tr_"+i+"','tr_"+i+"','ch_"+i+"')\" style=\"cursor:pointer;\"><u>Remove</u></font>";
						var count = parseInt(document.getElementById("order_count_id").value);
						document.getElementById("order_count_id").value = count+1;
					}
					document.getElementById("tr_"+i).style.backgroundColor="#f3f3f3";
				}
			}
		} else {
			if(isOrderExist(order_no)){
				var row=table.insertRow(0);
				row.setAttribute("id", "inserted_"+row_id);
				var cell1=row.insertCell(0);
				cell1.style.width='20%';
				var cell2=row.insertCell(1);
				cell2.style.width='35%';
				var cell3=row.insertCell(2);
				cell3.style.width='20%';
				var cell4=row.insertCell(3);
				cell4.style.width='25%';
				cell2.innerHTML=cust_name;
				cell3.innerHTML=balance;
				cell1.innerHTML=order_no+" <input type=\"hidden\" name=\"orders\" value=\""+order_no+"\"/>";
				cell4.innerHTML="<font color=blue onclick=\"removeRow('inserted_"+row_id+"','"+row_id+"','"+ch_id+"')\" style=\"cursor:pointer;\"><u>Remove</u></font>";
				var count = parseInt(document.getElementById("order_count_id").value);
				document.getElementById("order_count_id").value = count+1;
			}
			document.getElementById(row_id).style.backgroundColor="#f3f3f3";
		}
	} else{
		if(document.getElementById("respective_check").checked){
			for(var i=0;i<rows;i++){
				if(trim(document.getElementById("cust_code_"+i).innerHTML) == cust_code){
					try{
						document.getElementById("ch_"+i).checked=false;
						document.getElementById("tr_"+i).style.backgroundColor="#ECFB99";
						table.deleteRow(document.getElementById("inserted_tr_"+i).rowIndex);
						var count = parseInt(document.getElementById("order_count_id").value);
						document.getElementById("order_count_id").value = count-1;
					}catch(ex){}
				}
			}
		} else {
			document.getElementById(row_id).style.backgroundColor="#ECFB99";
			table.deleteRow(document.getElementById("inserted_"+row_id).rowIndex);
			var count = parseInt(document.getElementById("order_count_id").value);
			document.getElementById("order_count_id").value = count-1;
		}
	}
}

function isOrderExist(order_no){
	var rows = document.getElementById("insert_table").getElementsByTagName("input").length;
	var flag = true;
	for(var i =0;i<rows;i++){
		if(document.getElementById("insert_table").getElementsByTagName("input")[i].value == order_no){
			flag=false;
		}
	}
	return flag;
}

function removeRow(id1,id2,ch){
	var table=document.getElementById("insert_table");
	table.deleteRow(document.getElementById(id1).rowIndex);
	document.getElementById(id2).style.backgroundColor="#ECFB99";
	document.getElementById(ch).checked=false;
	var count = parseInt(document.getElementById("order_count_id").value);
	document.getElementById("order_count_id").value = count-1;
}

function printSelectedInformation(){
	var rows = document.getElementById("insert_table").getElementsByTagName("tr").length;
	if(rows == 0){
		alert("Select Atleast one record to print..");
		return false;
	}
}
function dispCommForm(cust_code){
	window.location = "communicationForm.jsp?cust_code="+cust_code+"&msg=no";
}


function trim(str) {
    return str.replace(/^\s+|\s+$/g,"");
}
function onMouseOver(row){
	//alert(row + $(row))
	$(row).css({'backgroundColor':'#C8C8C8'});
}
function onMouseOut(row){
	//alert(row + $(row))
	$(row).css({'backgroundColor':'transparent'});
}

