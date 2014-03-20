
$(document).ready(function(){
	
	 $( "#createFromDate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			maxDate:new Date(),
			//numberOfMonths: 3,
			onClose: function( selectedDate ) {
				$( "#createToDate" ).datepicker( "option", "minDate", selectedDate );
			}
		});
		$( "#createToDate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			//numberOfMonths: 3,
			maxDate:new Date(),
			
			onClose: function( selectedDate ) {
				$( "#createFromDate" ).datepicker( "option", "maxDate", selectedDate );
			}
		});
		
		 $( "#updateFromDate" ).datepicker({
				defaultDate: "+1w",
				changeMonth: true,
				maxDate:new Date(),
				//numberOfMonths: 3,
				onClose: function( selectedDate ) {
					$( "#updateToDate" ).datepicker( "option", "minDate", selectedDate );
				}
			});
			$( "#updateToDate" ).datepicker({
				defaultDate: "+1w",
				changeMonth: true,
				//numberOfMonths: 3,
				maxDate:new Date(),
				
				onClose: function( selectedDate ) {
					$( "#updateFromDate" ).datepicker( "option", "maxDate", selectedDate );
				}
			});
	
	//if(!($("#crateDate2").jqxDateTimeInput('disabled')))  var updateDate1 = $('#updateDate1').jqxDateTimeInput('getText');
	
})
function checkField(){
	var c_date1 = $('#createFromDate').val();
	var c_date2 = $('#createToDate').val();
	var u_date1 = $('#updateFromDate').val();
	var u_date2 = $('#updateToDate').val();

	if(c_date1!="" && c_date2==""){
		alert("enter create to_date ");
		return false;
	}
	if(c_date2!="" && c_date1==""){
		alert("enter create from_date ");
		return false;
	}
	if(u_date1!='' && u_date2==''){
		alert("enter update to_date ");
		return false;
	}
	if(u_date2!='' && u_date1==''){
		alert("enter update from_date ");
		return false;
	}
       
    showHint();		    
}

function showMsg(){
	//alert('show message ');
	 document.myform.action="HomeForm.jsp";
	 document.myform.submit();
}

function showHint() {
	var phoneNumber;
	var str;
	var str1;
	var str2;
	var str3;
	var str4;
	var str5;
	var str6;
	var str7;
	phoneNumber=document.myform.phonenumber.value;	
	str=document.myform.orderNumber.value;
	str1=document.myform.customerCode.value;
	str2=document.myform.customerName.value	;
	str3=document.myform.enteredBy.value;
	var c_date1 = $('#createFromDate').val();
	var c_date2 = $('#createToDate').val();
	var u_date1 = $('#updateFromDate').val();
	var u_date2 = $('#updateToDate').val();

	document.getElementById("txtHint").innerHTML="";
	if (phoneNumber.length==0 && str.length==0 && str1.length==0 && str2.length==0 && str3.length==0 && c_date1=="" && u_date1=="")
  	{ alert('select ')
  		document.getElementById("txtHint").innerHTML="";
  		
  		return;
  	}
	  	
  	document.getElementById("waitMessage").innerHTML="Please wait ...";
	var url ="ajaxOption=getOrderDetails"
	url+="&orderNumber="+str+"&phoneNumber="+phoneNumber+"&customerCode="+str1+"&custName="+str2+"&enterBy="+str3;
	url+="&createFromDate="+c_date1+"&createToDate="+c_date2;
	url+="&updateFromDate="+u_date1+"&updateToDate="+u_date2;
	//alert("url "+url);
	
	
	$.ajax({
		url:"CancelOrderAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'text',
		success:function(ajaxResonse)
		{	
			document.getElementById("waitMessage").innerHTML="";
			 $("#txtHint").html(ajaxResonse);
			
		}
	});	
	
} 

function cancelOrder(orderNumber,rowID){
	var flag=confirm("Do you really want to cancel this Order ?");
	if(flag){
		
		var url = 'ajaxOption=cancelOrder&orderNum='+orderNumber;
		$.ajax({
		url:"CancelOrderAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'text',
		success:function(ajaxResonse)
		{	
			// alert(ajaxResonse+" "+rowID);
			$('#'+rowID).remove();
			alert(ajaxResonse);
			
		}
	});	
		
	}
	else{
		return false;
	}
	
}




	
