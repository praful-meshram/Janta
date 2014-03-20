$(document).ready(function(){
		
	$( "#range1" ).datepicker({
		defaultDate: "+1w",
		changeMonth: true,
		maxDate:new Date(),
		//numberOfMonths: 3,
		onClose: function( selectedDate ) {
			$( "#range2" ).datepicker( "option", "minDate", selectedDate );
		}
	});
	$( "#range2" ).datepicker({
		defaultDate: "+1w",
		changeMonth: true,
		//numberOfMonths: 3,
		maxDate:new Date(),
		
		onClose: function( selectedDate ) {
			$( "#from" ).datepicker( "option", "maxDate", selectedDate );
		}
	});
	
	//var theme = getDemoTheme(); 
/*
 	$("#range1").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',max:new Date(),formatString: "yyyy-MM-dd"});
	$("#range2").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: "yyyy-MM-dd",value:new Date()});
	//$("#range1").jqxDateTimeInput({readonly:true});
	//$("#range2").jqxDateTimeInput({disabled: true});
	
	$('#range1').on('close', function (event) {
		 // Some code here. 
		 	$("#range2").jqxDateTimeInput({disabled: false});
		 	$("#range2").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});
			}); 	
	*/
	//alert(new Date('2014-12-02'))
	
	$.ajax({
		url:"InventoryPurchaseAjaxResponse.jsp",
		type:'post',
		data:'ajaxCall=vendorList',
		dataType:'text',
		success:function(ajaxResonse)
		{	
			$('#venodorList').html(ajaxResonse);
		}
	});
	
});

function validateDate(){
	var dateRange1 = new Date($('#range1').val());
	var dateRange2 = new Date($('#range2').val());
	if($('#range1').val()=='' || $('#range1').val() == null){
		alert("enter from date ");
		return false;
	}
	if(dateRange1 > new Date()){
		alert('from date can not greater than current date');
		$('#range1').val('');
		return false;
	}
	if($('#range2').val()=='' || $('#range2').val() == null){
		alert("enter to date ");
		return false;
	}
	if(dateRange2 > new Date()){
		alert('to date can not greater than current date');
		$('#range2').val('');
		return false;
	}
	
	
}

function getPurchaseDetails(){
	
	//var dateRange1 = new Date($('#range1').val());
	//var dateRange2 = new Date($('#range2').val());
	
	var dateRange1 = $('#range1').val();
	var dateRange2 = $('#range2').val();
	
	//alert(dateRange1+"\n "+dateRange2);

	if((dateRange1=='' || dateRange1 == null) && (dateRange2=='' || dateRange2 == null)){
		alert("enter date range ");
		return false;
	}
	if(dateRange1=='' || dateRange1 == null){
		alert("enter from date ");
		return false;
	}
	if(dateRange2=='' || dateRange2 == null){
		alert("enter to date ");
		return false;
	}
	
	
	var url = "ajaxCall=purchaseDetails";
		url+="&fromDate="+dateRange1;
		url+="&toDate="+dateRange2;
	//if($('#vendorNameList option:selected').val()!='' || $('#vendorNameList option:selected').val()!=null)
	url+="&vendorId="+$('#vendorNameList option:selected').val();
	
	$.ajax({
		url:"InventoryPurchaseAjaxResponse.jsp",
		type:'post',
		data:url,
		dataType:'text',
		success:function(ajaxResonse)
		{	
			//alert(ajaxResonse)
			$('#inventoryPurchase').html(ajaxResonse);
			
			
			
		}
	});
	
}