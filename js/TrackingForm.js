var xmlHttp;
var match;
var temp,linkId,globalflag;
var orderArr,val,tempval,pos=0;
var delperson='',dstaffNm='';
var tempdelPerson='';
var rowcnt=0;
var ic=0, iccnt=1, cntchange=0;
var vcustName,vorderNo,varea,vorderDate,vtotalItems,vtotalValuePrice,vadvanceAmt,vdiscountAmt,vbalanceAmt;
var vdelchgs,vadamt,vpayment,vchangeAmt,vexpectedAmt,vbagsno, vsubValue,vpaidAmt ,vord_comm_amt;
var camtVal;
var changeArray;
var tempArray; 
var RsArray;
var totalRsArray;
var totalChangeAmt =0.0, totalPaidAmt=0.0 ;
var tempChangeAmt=0.0;
var totCommAmt=0.0;
var totbagno=0;
var totalAllChangeAmt =0.0, totalAllPaidAmt=0.0 ;
var tempAllChangeAmt=0.0;
var commArray =0.0;

function showHint(param) {	
	document.getElementById("displayDiv").innerHTML="";
	 match=0; val=''; tempval=0; pos=0; temp = 0;linkId = 0;	
	 globalflag = false;	 
	 delperson='';dstaffNm='';
	 tempdelPerson='';
	 rowcnt=0;
	 ic=0; iccnt=1; cntchange=0;
	 vcustName="";
	 vorderNo="";vorderDate="";
	 vbagsno=0;vtotalItems=0;vtotalValuePrice=0.0;vadvanceAmt=0.0;vdiscountAmt=0.0;vbalanceAmt=0.0;
	 vdelchgs=0.0;vadamt=0.0;vpayment="";vchangeAmt=0.0;vexpectedAmt=0.0; 
	 vsubValue="";vpaidAmt=0.0;vord_comm_amt=0.0;
	 camtVal = new Array();
	 changeArray = new Array();
	 tempArray = new Array(); 
	 RsArray = new Array();
	 totalRsArray = new Array();
	 totalChangeAmt =0.0, totalPaidAmt=0.0 ;
	 tempChangeAmt=0.0;
	 totCommAmt=0.0;
	 totbagno=0;
	 totalAllChangeAmt =0.0, totalAllPaidAmt=0.0 ;
	 tempAllChangeAmt=0.0;
	 commArray =0.0;
	xmlHttp=GetXmlHttpObject()
	if (xmlHttp==null)
  	{
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	var url=param;
	xmlHttp.onreadystatechange=stateChanged;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
} 

function stateChanged() 
{
	if (xmlHttp.readyState==4){
		document.getElementById("displayDiv").innerHTML="";
		document.getElementById("displayDiv").innerHTML=xmlHttp.responseText;
		if(document.myform.hcountorder==undefined){
			
		}
		else if(document.myform.hcountorder.value==0)	
			document.getElementById("searchTable").innerHTML='';
		fundisplay();
		
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

function checkHoldStatus(orderNo,statusCode){
		var status=statusCode;
		var hold="holdPurpose";
		document.myform.action="EditOrderForm.jsp?orderNo="+orderNo+"&holdOrder="+hold+"&status_Code="+statusCode+"";
		document.myform.submit();
}



function showMsg(flag)
{
	globalflag=flag;
	val=document.myform.search.value;	
	orderArr=document.myform.horderArr.value.split("|");
	if(flag==true){
		dstaffNm=document.myform.d_staff[document.myform.d_staff.selectedIndex].text;		
	}
	if(val!=''){		
		if(document.getElementById(val)){		
			if(flag==true && dstaffNm != 'Select staff'){	
				//var len=val.length;	
				var testval=checkOrderNo(len);	
				getDeliveryPersonName();
				if(delperson == dstaffNm){
					setFocus();									
				}	
				else 
					showMessage();
			}	
			else if(flag==false || flag==true && dstaffNm == 'Select staff'){
				var testval=checkOrderNo(len);	
				if(testval==1)
					setFocus();		
				else
					showMessage();
			}
			//showMessage();															
		}
		else{ 
				var ans=confirm("Order number "+ val +" does not exist ! Do you want to search order starting with  "+val+" ? ");								
				if (ans==true){
					var len=val.length;
					var test=0;
					for(i=0; i< val.length; i++){	
						test=checkOrderNo(len);										
						if(test==1){
							if(flag==true && dstaffNm != 'Select staff'){
								getDeliveryPersonName();										
								if(delperson == dstaffNm){
									setFocus();								
									break;								
								}			
							}
							else if(flag==false || flag==true && dstaffNm == 'Select staff'){							
								setFocus();															
								break;
							}
						}						
						else if(test==0){
							len=len-1;		
							for(len1=len; len>0; len--){									
								test=checkOrderNo(len);															
								if(test==1){
									if(flag==true && dstaffNm != 'Select staff'){									
										getDeliveryPersonName();										
										if(delperson == dstaffNm){
											setFocus();																	
											break;
										}																								
									}
									if(flag==false || flag==true && dstaffNm == 'Select staff'){
										setFocus();																								
										break;
									}
								}
	
							}//EOF inner for
							if (test == 1)
								break;
						}
						
					}//EOF for	
					showMessage();						
				}
				else{	
				  	//window.refresh; 
				  	document.myform.search.value='';
				}				
			}
		}
		else if(globalflag==true && val=='' && dstaffNm!='Select staff'){
			var result=SearchDeliveryPerson();
			if(result==1)
				setFocus();
			else 
				alert(dstaffNm+" not found");
		} 
		else if(globalflag==true && val=='' && dstaffNm=='Select staff')
			alert("Please fill Order number or Delivery person name ");
		else if(globalflag==false && val=='')
			alert("Order Number field is empty");
}

function showMsgTransit(flag)
{
	globalflag=flag;
	val=document.myform.search.value;	
	orderArr=document.myform.horderArr.value.split("|");
	if(flag==true){
		dstaffNm='Select staff';
	}
	if(val!=''){		
		if(document.getElementById(val)){		
			if(flag==true && dstaffNm != 'Select staff'){	
				//var len=val.length;	
				var testval=checkOrderNo(len);	
				getDeliveryPersonName();
				if(delperson == dstaffNm){
					setFocus();									
				}	
				else 
					showMessage();
			}	
			else if(flag==false || flag==true && dstaffNm == 'Select staff'){
				var testval=checkOrderNo(len);	
				if(testval==1)
					setFocus();		
				else
					showMessage();
			}
			//showMessage();															
		}
		else{ 
				var ans=confirm("Order number "+ val +" does not exist ! Do you want to search order starting with  "+val+" ? ");								
				if (ans==true){
					var len=val.length;
					var test=0;
					for(i=0; i< val.length; i++){	
						test=checkOrderNo(len);										
						if(test==1){
							if(flag==true && dstaffNm != 'Select staff'){
								getDeliveryPersonName();										
								if(delperson == dstaffNm){
									setFocus();								
									break;								
								}			
							}
							else if(flag==false || flag==true && dstaffNm == 'Select staff'){							
								setFocus();															
								break;
							}
						}						
						else if(test==0){
							len=len-1;		
							for(len1=len; len>0; len--){									
								test=checkOrderNo(len);															
								if(test==1){
									if(flag==true && dstaffNm != 'Select staff'){									
										getDeliveryPersonName();										
										if(delperson == dstaffNm){
											setFocus();																	
											break;
										}																								
									}
									if(flag==false || flag==true && dstaffNm == 'Select staff'){
										setFocus();																								
										break;
									}
								}
	
							}//EOF inner for
							if (test == 1)
								break;
						}
						
					}//EOF for	
					showMessage();						
				}
				else{	
				  	//window.refresh; 
				  	document.myform.search.value='';
				}				
			}
		}
		else if(globalflag==true && val=='' && dstaffNm!='Select staff'){
			var result=SearchDeliveryPerson();
			if(result==1)
				setFocus();
			else 
				alert(dstaffNm+" not found");
		} 
		else if(globalflag==true && val=='' && dstaffNm=='Select staff')
			alert("Please fill Order number or Delivery person name ");
		else if(globalflag==false && val=='')
			alert("Order Number field is empty");
}

function checkOrderNo(len){	
	pos=0;	
	val=val.substr(0, len);	
	for(i=0; i<orderArr.length; i++){
		temp=orderArr[i];		
		if(temp.substr(0, len)==val){
		//Since div id begins from 1. increment pos by 1.
			pos=(i+1)+'#';	
			if(globalflag==true && dstaffNm != 'Select staff'){	
				CompareAndSetValues();				
				return 1;
				break;
	
			}
			else if(globalflag==false || globalflag==true && dstaffNm == 'Select staff'){		
					match=1;
					linkId=temp;	
					return 1;
					break;
			}
				setZeroValues();				
		}
		else{
				setZeroValues();
		}
	}//EOF  For 	
	return 0;
}

function cancel(){
  	 document.myform.action="TrackingForm.jsp";
   	 document.myform.submit();
}

function showMessage(){
	if(globalflag==true && match==0  && dstaffNm != 'Select staff')					
		alert("Order number starting with "+document.myform.search.value+" was not delivered by "+dstaffNm);
	if(globalflag==true && match==0  && dstaffNm == 'Select staff')
		alert("No order number starts with "+document.myform.search.value);	
	else if(globalflag==false && match==0)
		alert("No order number starts with "+document.myform.search.value);						
}
 
function setFocus(){

	document.getElementById(linkId).style.background="#CCCCFF";
	document.getElementById(linkId).style.fontWeight = 'bolder';
	document.getElementById(linkId).style.color = 'red';	
	document.getElementById(linkId).focus();
	document.myform.search.value=""; 	
	document.myform.search.focus(); 
}

function CompareAndSetValues(){
	tempdelPerson=document.getElementById(pos).innerHTML;						
	tempdelPerson=tempdelPerson.replace(/^\s+|\s+$/g,'');			
	if(tempdelPerson==dstaffNm){
		match=1;
		linkId=temp;
	}	
	else
		setZeroValues();
}					

function setZeroValues(){
	match=0;
	linkId=0;	
}				

function getDeliveryPersonName(){
	delperson=document.getElementById(pos).innerHTML;
	delperson=delperson.replace(/^\s+|\s+$/g,'');
}

function SearchDeliveryPerson(){
	for(i=0; i<orderArr.length; i++){	
		temp=orderArr[i];
		pos=(i+1)+'#';	
		tempdelPerson=document.getElementById(pos).innerHTML;						
		tempdelPerson=tempdelPerson.replace(/^\s+|\s+$/g,'');	
		if(tempdelPerson==dstaffNm){
			match=1;
			linkId=temp;
			alert("tempdelPerson = "+tempdelPerson);
			return 1;
		}
	}
}

function func(orderNum){
	document.myform.action="print_delivered_order.jsp??backPage=customer_detailsForm1.jsp&orderNo=" + orderNum +"";
	document.myform.submit();
}

function calChangeAmt(){
	totalChangeAmt =0.0;
	var tbl = document.getElementById('sendid');
	var lastRow = tbl.rows.length;	
	j=0;
	// alert(lastRow+" camtVal.length "+camtVal.length)
 	for(i=1; i<camtVal.length; i++){
 	// alert(camtVal[i]);
 		if(camtVal[i] != "|"){
 			tempArray[j] = camtVal[i];
 			//alert("change11 "+camtVal[i])
 			j++;
 		}
 	}
 	j=0;
 	cntchg=0;
 	for(i=1; i<lastRow; i++){
 	 	totalChangeAmt = eval("["+totalChangeAmt+"+"+tempArray[cntchg]+"]");	 
 	 	j++;
 	 	cntchg++;
 	 	//alert("change "+eval("["+totalChangeAmt+"+"+tempArray[cntchg]+"]"));
 	 	
 	}
  document.getElementById('divtotchange').innerHTML = totalChangeAmt;
}

function RemoveRow(src){
	//alert("remove row ");
	 var tbl = document.getElementById('id');
	 var lastRow = tbl.rows.length;	
	 //alert(lastRow +"remove row ");
	 for(i=0; i<lastRow; i++){
		 celVal = tbl.rows[i].cells[1].innerHTML.replace(/.*>(.*)<.*$/g,"$1");
		 celVal= celVal.replace(/^\s+|\s+$/g,'');
		 celVal = src
	 	 if(celVal == src){	 	 
	 	  	  	document.all("id").deleteRow(i);
	 	  	  	//alert('delte row ');
	 	  	  	break;
	 	 }
	 }
	 
	var lastRow = tbl.rows.length;	
	document.getElementById('divtono').innerHTML = lastRow -2;	
	//alert($('#row0'));
	//$('#row0').css("display":"none");
	
	document.myform.search.focus(); 		
} 

function funsend(){
	var d_code =document.myform.d_staff.value;
    if(d_code == 'select'){
      alert("Select staff");
      return false;    
    }
    
     var tbl = document.getElementById('sendid');
	  var lastRow = tbl.rows.length;
	  
	  if($("#sendid > tbody > tr").size() == 0){
	  	alert("No Row Seletced");
	  	return false;
	  }
    
    
    var orderArray = new Array();
    var changeArray = new Array();
    
    var i = 0;
    $("#sendid > tbody > tr").each(function(){
    	orderArray[i]= $(this).find('td').eq(1).text();
    	changeArray[i]=$(this).find('td').find('input').val();
    	i++;
    });
    
	 	document.myform.horderArray.value = orderArray;
	 	document.myform.hchangeArray.value = changeArray;
	 	
	 	document.myform.action="SendOrderProcessing.jsp"
	 	document.myform.submit();

}

function RemoveRowTransit(src){
	 var tbl = document.getElementById('id');
	 var lastRow = tbl.rows.length;	
	 for(i=0; i<lastRow; i++){
	  celVal = tbl.rows[i].cells[1].innerHTML.replace(/.*>(.*)<.*$/g,"$1");
		 celVal= celVal.replace(/^\s+|\s+$/g,'');
	 	 if(celVal == src){	 	 
	 	  	  	document.all("id").deleteRow(i);
	 	  	  	break;
	 	 }
	 }
	var lastRow = tbl.rows.length;	
	document.getElementById('divtono').innerHTML = lastRow -2;
	document.myform.search.focus(); 		
} 

function funsendTransit(){
	
	 var tbl = document.getElementById('sendid');
	  var lastRow = tbl.rows.length;
	  //alert($("#sendid > tbody > tr").size()+" last row "+(lastRow-1))
	  if($("#sendid > tbody > tr").size()== 0){
	  	alert("No Row Seletced");
	  	return false;
	  }
	    
    var orderArray = new Array();
    var changeArray = new Array();
	 	var i = 0;
	 	$('#sendid > tbody >tr').each(function() {
	 		 orderArray[i]=$.trim($(this).find("td").eq(1).text());
	 		//changeArray[i] = $.trim($(this).find("td").eq(8).text());	
	 		changeArray[i] = $.trim($(this).find("td").eq(6).text());	
	 		 
	 		 //alert( orderArray[i]+"  "+changeArray[i]);
	 		 i++;
	 	}); 
	 	
	 	document.myform.horderArray.value = orderArray;
	 	document.myform.hchangeArray.value = changeArray;
	 	
	 	document.myform.action="OrderProcessingTransit.jsp"
	 	document.myform.submit();

}

	function fundisplay(){
		if(document.myform.htotalchangeamt==undefined){
			
		}
		else if(document.myform.htotalchangeamt.value != null && document.myform.htotalchangeamt.value != ""){
			 totalAllChangeAmt = document.myform.htotalchangeamt.value;
			 totalAllPaidAmt = document.myform.htotalpaidamt.value;
			 if(document.getElementById('divtotchange')!=undefined)
				 document.getElementById('divtotchange').innerHTML = totalAllChangeAmt;
			
			 if(document.getElementById('divtotpaid')!=undefined)
				 document.getElementById('divtotpaid').innerHTML = totalAllPaidAmt;
			
			 if(document.getElementById('divtono')!=undefined)
				 document.getElementById('divtono').innerHTML =  document.myform.htotalordercnt.value;
			 
		}//else
			 //document.getElementById('divtono').innerHTML =  $('#id > tbody >tr').size()-2;

	} 
	
	// below function adds row in the above table as send order table and remove it from order detail table
	function AddRow(custName,orderNo,area,orderDate,totalItems,totalValuePrice,
			advanceAmt,discountAmt,balanceAmt,delchgs,adamt,payment,changeAmt,expectedAmt,
			bagsNo,cnt,subValue,ord_comm_amt,rowID){
	      //alert("add row "+custName+":"+orderNo+":"+area+":"+orderDate+":"+totalItems+":"+totalValuePrice+":"+advanceAmt+":"+discountAmt+":"+balanceAmt+":"+delchgs+":"+adamt+":"+payment+":"+changeAmt+":"+expectedAmt+":"+bagsNo+":"+cnt+":"+subValue+":"+ord_comm_amt)
	        
			var tbl = document.getElementById('sendid');
			vcustName=custName;
			vorderNo=orderNo;
			varea=area;
			vorderDate=orderDate;
			vtotalItems=totalItems;
			vtotalValuePrice=totalValuePrice;
			vadvanceAmt=advanceAmt;
			vdiscountAmt=discountAmt;
			vbalanceAmt=balanceAmt;	
	        vdelchgs=delchgs;
			vadamt=adamt;
			vpayment=payment;
			vchangeAmt=changeAmt;
			vexpectedAmt=expectedAmt;
			vbagsno=bagsNo;
			vsubValue= subValue;
			rowcnt = tbl.rows.length;
			vord_comm_amt = ord_comm_amt;
			
			// if first row added then initialize variable
	        if($('#sendid > tbody >tr').size()==0){
	        	totalChangeAmt =0.0;
	        	tempChangeAmt=0.0;
	        	ic = 0; 
	        }
	        
	    	camtVal[ic]=vchangeAmt;
			ic++;
	        
	      	str ="'"+vcustName+"','"+vorderNo+"','"+varea+"','"+vorderDate+"','"+vtotalItems+"','"+vtotalValuePrice+"','"+vadvanceAmt+"'," +
	      			"'"+vdiscountAmt+"','"+vbalanceAmt+"','"+vdelchgs+"','"+vadamt+"','"+vpayment+"','"+vchangeAmt+"','"+vexpectedAmt+"'," +
	      					"'"+vbagsno+"','0','"+vsubValue+"','"+vord_comm_amt+"'";
			str1 ="orderNo="+vorderNo +"&subValue="+vsubValue+"&id="+vorderNo;
		
		// adding row in table	
		$("#sendid").css("display","block");
		$('#sendid > tbody:last').append("<tr id='tr"+rowID+"'>"+$('#row'+rowID).html()+
				"<td id='comm"+rowID+"'>"+vord_comm_amt+"</td" +
				"</tr>");
		
		// update content of some cell
		$('#tr'+rowID+' #orderNum'+rowID).html("<a href=\"Javascript:RemoveSend("+str+","+rowID+");\" id="+orderNo+">"+orderNo+"</a>");
		$('#tr'+rowID+' #send'+rowID).html("<a href=\"Javascript:RemoveSend("+str+","+rowID+");\" id="+orderNo+">Clear</a>");
		$('#tr'+rowID+' #TA'+rowID).html("<a href=\"DeliveryDetailsForm.jsp?"+str1+"\">T.A.</a>");
	
		
		
		if(payment == "Cash" || payment == "Cheque" || payment == "Credit"){	
			$('#tr'+rowID+' #change'+rowID).html("<input name='InputChange"+iccnt+"' disabled  type='text' value="+changeAmt+">");
		}else {		
			//$('#tr'+rowID+' #change'+rowID).html("<input name='InputChange"+iccnt+"' type='text' onblur='funexpamt("+vbalanceAmt+","+orderNo+","+iccnt+");' value="+changeAmt+">")
			$('#tr'+rowID+' #change'+rowID).html("<input name='InputChange"+iccnt+"' type='text' onblur='funexpamt("+vbalanceAmt+","+orderNo+","+rowID+");' value="+changeAmt+">")
			tempChangeAmt = changeAmt;
		}	
		
		// update exp amount
		chageVal = $('#sendid >tbody > #tr'+rowID).find('td').find('input').val();
		balance = $.trim($('#sendid >tbody > #tr'+rowID).find('td').eq(9).text());
		expAmt =  parseFloat(chageVal)+parseFloat(balance)

		//alert("bala "+balance+" change "+chageVal);
		$('#sendid >tbody > #tr'+rowID).find('td').eq(11).text(expAmt);
		
		totbagno=parseInt(totbagno)+parseInt(bagsNo);
		totCommAmt = parseFloat(totCommAmt)+parseFloat(vord_comm_amt); 
		
		//totalChangeAmt =parseFloat(totalChangeAmt) + parseFloat(changeAmt);
		//alert(parseInt(totalChangeAmt) +" change "+parseInt(tempChangeAmt))
		
		var grandTotalChange = 0;
		// row object for send order detail
		var rowObj = $('#sendid >tbody > tr');
		rowObj.each(function(){
			chageVal = $(this).find('td').find('input').val();
			grandTotalChange = parseFloat(grandTotalChange) + parseFloat(chageVal);
		});
		
		totalChangeAmt =grandTotalChange;
		
		// finally removig row from order detail row 
		$("#row"+rowID).remove();
		
		document.getElementById('divtonosend').innerHTML = $('#sendid > tbody >tr').size() ;	
		document.getElementById('divtotcomm').innerHTML = totCommAmt;
		document.getElementById('divtotchange').innerHTML = totalChangeAmt;
		document.getElementById('divtotbags').innerHTML=totbagno;
		
	
		
	 
	}	
	
	// this function remove order detail from send table and add it back to order detail table
	function RemoveSend(custName,orderNo,area,orderDate,totalItems,totalValuePrice,advanceAmt,
			discountAmt,balanceAmt,delchgs,adamt,payment,changeAmt,expectedAmt,bagsNo,iccnt,subValue,
			ord_comm_amt,rowID){
		
			//alert(str+"\n "+str1)
	    	//alert(custName+":"+orderNo+":"+area+":"+orderDate+":"+totalItems+":"+totalValuePrice+":"+advanceAmt+":"+discountAmt+":"+balanceAmt+":"+delchgs+":"+adamt+":"+payment+":"+changeAmt+":"+expectedAmt+":"+bagsNo+":"+subValue+":"+ord_comm_amt+":"+iccnt);   	
			vcustName=custName;
			vorderNo=orderNo;
			varea=area;
			vorderDate=orderDate;
			vtotalItems=totalItems;
			vtotalValuePrice=totalValuePrice;
			vadvanceAmt=advanceAmt;
			vdiscountAmt=discountAmt;
			vbalanceAmt=balanceAmt;	
			vdelchgs=delchgs;
			vadamt=adamt;
			vpayment=payment;
			vchangeAmt=changeAmt;
			vexpectedAmt=expectedAmt;
			vbagsno=bagsNo;
			vsubValue= subValue;  
	        vord_comm_amt = ord_comm_amt;
	       // alert("vord_comm_amt :"+vord_comm_amt);
	        totCommAmt = parseFloat(totCommAmt)-parseFloat(vord_comm_amt); 
	        //if(isNaN(parseInt(vchangeAmt)))
	        totalChangeAmt = parseFloat(totalChangeAmt) - parseFloat(changeAmt);
	        totbagno = parseInt(totbagno)-parseInt(bagsNo); 
			
	        camtVal.splice(ic,1);
			ic--;
			
			str ="'"+vcustName+"','"+vorderNo+"','"+varea+"','"+vorderDate+"','"+vtotalItems+"','"+vtotalValuePrice+"','"+vadvanceAmt+"','"+vdiscountAmt+"','"+vbalanceAmt+"','"+vdelchgs+"','"+vadamt+"','"+vpayment+"','"+vchangeAmt+"','"+vexpectedAmt+"','"+vbagsno+"','"+iccnt+"','"+vsubValue+"','"+vord_comm_amt+"'";
			str1 ="orderNo="+vorderNo +"&subValue="+vsubValue+"&id="+vorderNo;
			
			// add row in order detail table 
		    addRowInOrderDetail(rowID,str,str1,payment,changeAmt);
		    // remove row from send order table
		    $("#tr"+rowID).remove();
		    
		    
		    document.getElementById('divtonosend').innerHTML = $('#sendid > tbody >tr').size() ;	
		    document.getElementById('divtotcomm').innerHTML = totCommAmt; 
		    document.getElementById('divtotbags').innerHTML=totbagno;
		    
		    var grandTotalChange = 0;
			// row object for send order detail
			var rowObj = $('#sendid >tbody > tr');
			rowObj.each(function(){
				chageVal = $(this).find('td').find('input').val();
				grandTotalChange = parseFloat(grandTotalChange) + parseFloat(chageVal);
			});
		    
		    document.getElementById('divtotchange').innerHTML = grandTotalChange;
		    
		    // if no rows are available then hide table
		    if($('#sendid > tbody >tr').size()==0)
		    	$("#sendid").css("display"," none");
		    
		    document.myform.search.focus(); 
			
	}
	
	// search and plce order detail in above table
	function searchOno(){	
 		var onval=document.myform.search.value;	
		if(onval == "" || isNaN(onval)){
		   alert("Enter Order Number");
		   document.myform.search.value ="";
		   document.myform.search.focus();  
		   return false;
		}	
		var rowCount = 0;
		$('#id > tbody >tr').each(function() {
			
			  // if order number matched then add it the send order table	
			  if($.trim($(this).find("td").eq(1).text())==onval)
			    {
				  //alert(jQuery(this)+"tableRow "+(jQuery(this).index()-1) +" #"+$.trim($(this).find("td").eq(1).text())+"#");
					   
					
					area = $.trim($(this).find("td").eq(0).text());
			        orderNo = $.trim($(this).find("td").eq(1).text());
			        custName=$.trim($(this).find("td").eq(2).text());
			        
			        orderDate=$.trim($(this).find("td").eq(3).text());
			        totalItems=$.trim($(this).find("td").eq(4).text());
			        payment=$.trim($(this).find("td").eq(5).text());
			        
			        totalValuePrice=$.trim($(this).find("td").eq(6).text());
			        advanceAmt=$.trim($(this).find("td").eq(7).text());
			        delchgs=$.trim($(this).find("td").eq(8).text());
			        
			        balanceAmt=$.trim($(this).find("td").eq(9).text());					
			        changeAmt=$.trim($(this).find("td").eq(10).text());
			        expectedAmt=$.trim($(this).find("td").eq(11).text());
			        
			        bagsNo=$.trim($(this).find("td").eq(12).text());
					ord_comm_amt=$.trim($(this).find("td").eq(15).text());
					subValue= "Submitted3";
					
					//rowID = (jQuery(this).index()-1);
					
					// get id of specified row 
					rowID = this.id.substring(3);
					//alert("rowID "+rowID)
					AddRow(custName,orderNo,area,orderDate,totalItems,totalValuePrice,
							advanceAmt,0,balanceAmt,delchgs,0,payment,changeAmt,expectedAmt,
							bagsNo,0,subValue,ord_comm_amt,rowID);	
					document.myform.search.value ="";
					document.myform.search.focus(); 
					rowCount--;
					return false;
				
			    }
			  rowCount++;
			 });
			
		if($('#id > tbody >tr').size()==rowCount){
				alert("Order number "+ onval +" does not exist !");
				document.myform.search.value ="";
				document.myform.search.focus(); 
		}
}
	
	// function to add row in order detail table
	function addRowInOrderDetail(rowID,str,str1,payment,changeAmt){
		//alert($('#tr'+rowID)+" "+rowID +" send to order "+$('#tr'+rowID).html())
		$('#id > tbody:last').append("<tr id='row"+rowID+"'>"+$('#tr'+rowID).html()+"</tr>");
		orderNo=$.trim($('#tr'+rowID+' #orderNum'+rowID).text());
		$('#row'+rowID+' #orderNum'+rowID).html("<a href=\"Javascript:AddRow("+str+","+rowID+");\" id="+orderNo+">"+orderNo+"</a>");
		$('#row'+rowID+' #send'+rowID).html("<a href=\"Javascript:AddRow("+str+","+rowID+");\" id="+orderNo+">Send</a>");
		$('#row'+rowID+' #TA'+rowID).html("<a href=\"DeliveryDetailsForm.jsp?"+str1+"\">T.A.</a>");
		$('#row'+rowID+' #change'+rowID).html(changeAmt);
		$('#row'+rowID+' #comm'+rowID).remove();
	}
	
	// below code add row in transit table and remove it from order detail table
	function AddRowTransit(custName,orderNo,area,orderDate,totalItems,totalValuePrice,advanceAmt,
			discountAmt,balanceAmt,delchgs,adamt,payment,
			changeAmt,expectedAmt,cnt,subValue,paidAmt,rowID){
	    	
		vcustName=custName;
		vorderNo=orderNo;
		varea=area;
		vorderDate=orderDate;
		vtotalItems=totalItems;
		vtotalValuePrice=totalValuePrice;
		vadvanceAmt=advanceAmt;
		vdiscountAmt=discountAmt;
		vbalanceAmt=balanceAmt;	
	    vdelchgs=delchgs;
		vadamt=adamt;
		vpayment=payment;
		vchangeAmt=changeAmt;
		vexpectedAmt=expectedAmt;
		vsubValue= subValue;
		vpaidAmt = paidAmt;
		
		
		//alert("row id "+rowID +$('#row'+rowID).html())
		
		if(payment == "Hawala" || payment == "Cheque"){
			if (vpaidAmt == 0){
			  //vpaidAmt = expectedAmt;
			  paidAmt = expectedAmt;
			}
		}
	    if($('#sendid > tbody >tr').size() == 0){
	    	totalChangeAmt =0.0;
	    	totalPaidAmt=0.0 ;        	
	    	 totalAllChangeAmt = document.myform.htotalchangeamt.value;
	    	 totalAllPaidAmt = document.myform.htotalpaidamt.value;
	    	 ic=0;
	    }

	    camtVal[ic]=vchangeAmt;
		ic++;
	
	    
		str ="'"+vcustName+"','"+vorderNo+"','"+varea+"','"+vorderDate+"','"+vtotalItems+"','"+vtotalValuePrice+"'," +
		"'"+vadvanceAmt+"','"+vdiscountAmt+"','"+vbalanceAmt+"','"+vdelchgs+"','"+vadamt+"','"+vpayment+"'," +
		"'"+vchangeAmt+"','"+vexpectedAmt+"','0','"+vsubValue+"','"+paidAmt+"','"+vpaidAmt+"'";
		
		str1 ="orderNo="+vorderNo +"&subValue="+vsubValue+"&id="+vorderNo;
		//alert(vpaidAmt+ ' paid amt '+paidAmt)
		
		totalAllChangeAmt = parseFloat(totalAllChangeAmt)- parseFloat(changeAmt); 	
		totalAllPaidAmt = parseFloat(totalAllPaidAmt)-parseFloat(paidAmt); 	
		
		
	 // adding row in table	
		$("#sendid").css("display","inline-table");
		$('#sendid > tbody:last').append("<tr id='tr"+rowID+"'>"+$('#row'+rowID).html()+
				"<td id='comm"+rowID+"'>"+vord_comm_amt+"</td" +
				"</tr>");
		
		
		// update content of some cell
		$('#tr'+rowID+' #orderNum'+rowID).html("<a href=\"Javascript:RemoveSendTransit("+str+","+rowID+");\" id="+orderNo+">"+orderNo+"</a>");
		$('#tr'+rowID+' #select'+rowID).html("<a href=\"Javascript:RemoveSendTransit("+str+","+rowID+");\" id="+orderNo+">Clear</a>");
		$('#tr'+rowID+' #TA'+rowID).html("<a href=\"DeliveryDetailsForm.jsp?"+str1+"\">T.A.</a>");
		$('#tr'+rowID+' #paid'+rowID).html("<font color=\"red\">"+paidAmt+"</font>");
		
		
		
		// finally removig row from order detail row 
		$("#row"+rowID).remove();
	
	    document.getElementById('divtonosend').innerHTML = $('#sendid > tbody >tr').size();	
	    document.getElementById('divtotchange').innerHTML = totalAllChangeAmt;	   
	    document.getElementById('divtotpaid').innerHTML = totalAllPaidAmt;	
	    
	}

	
	//below function Remove row from transit table
	function RemoveSendTransit(custName,orderNo,area,orderDate,totalItems,totalValuePrice,
			advanceAmt,discountAmt,balanceAmt,delchgs,adamt,payment,changeAmt,expectedAmt,cnt,
			subValue,paidAmt,paidAmt1,rowID){
		   
		//alert('remove send '+rowID);
		
		vcustName=custName;
		vorderNo=orderNo;
		varea=area;
		vorderDate=orderDate;
		vtotalItems=totalItems;
		vtotalValuePrice=totalValuePrice;
		vadvanceAmt=advanceAmt;
		vdiscountAmt=discountAmt;
		vbalanceAmt=balanceAmt;	
		vdelchgs=delchgs;
		vadamt=adamt;
		vpayment=payment;
		vchangeAmt=changeAmt;
		vexpectedAmt=expectedAmt;
	    vsubValue= subValue;
  		vpaidAmt = paidAmt;
  		
  	    camtVal.splice(ic,1);
		ic--;
  		str ="'"+vcustName+"','"+vorderNo+"','"+varea+"','"+vorderDate+"','"+vtotalItems+"','"+vtotalValuePrice+"'," +
		"'"+vadvanceAmt+"','"+vdiscountAmt+"','"+vbalanceAmt+"','"+vdelchgs+"','"+vadamt+"','"+vpayment+"'," +
		"'"+vchangeAmt+"','"+vexpectedAmt+"','0','"+vsubValue+"','"+paidAmt1+"'";
 
		str1 ="orderNo="+vorderNo +"&subValue="+vsubValue+"&id="+vorderNo;
		
		totalAllPaidAmt = parseFloat(totalAllPaidAmt)+parseFloat(paidAmt);
		totalAllChangeAmt = parseFloat(totalAllChangeAmt)+parseFloat(changeAmt);
		
		// add row in order detail table 
		addRowInOrderDetailFromTransit(rowID,str,str1,payment,changeAmt,paidAmt1);
	    // remove row from send order table
	    $("#tr"+rowID).remove();
	    
	    // if no rows are available then hide table
	    if($('#sendid > tbody >tr').size()==0){
	    	
	    	$("#sendid").css("display"," none");
	    }
	    	
	 
    document.getElementById('divtonosend').innerHTML = $('#sendid > tbody >tr').size();	
    document.getElementById('divtotchange').innerHTML = totalAllChangeAmt;
    document.getElementById('divtotpaid').innerHTML = totalAllPaidAmt;	
    
   document.myform.search.focus(); 
}

	// function to add row in order detail table
	function addRowInOrderDetailFromTransit(rowID,str,str1,payment,changeAmt,paidAmt){
		$('#id > tbody:last').append("<tr id='row"+rowID+"'>"+$('#tr'+rowID).html()+"</tr>");
		orderNo=$.trim($('#tr'+rowID+' #orderNum'+rowID).text());
		$('#row'+rowID+' #orderNum'+rowID).html("<a href=\"Javascript:AddRowTransit("+str+",'"+rowID+"');\" id="+orderNo+">"+orderNo+"</a>");
		$('#row'+rowID+' #select'+rowID).html("<a href=\"Javascript:AddRowTransit("+str+",'"+rowID+"');\" id="+orderNo+">Select</a>");
		$('#row'+rowID+' #TA'+rowID).html("<a href=\"DeliveryActionForm.jsp?"+str1+"\">T.A.</a>");
		$('#row'+rowID+' #change'+rowID).html(changeAmt);
		$('#row'+rowID+' #paid'+rowID).html("<font color=\"red\">"+paidAmt+"</font");
		
		$('#row'+rowID+' #comm'+rowID).remove();
	}

function searchOnoTransit(){
	var onval=document.myform.search.value;	
	if(onval == "" || isNaN(onval)){
	   alert("Enter Order Number");
	   document.myform.search.value ="";
	   document.myform.search.focus();  
	   return false;
	}
	var rowCount = 0;
	$('#id > tbody >tr').each(function() {
	
		 // if order number matched then add it the send order table	
		  if($.trim($(this).find("td").eq(1).text())==onval)
		    {	   
			  	area = $.trim($(this).find("td").eq(0).text());
		        orderNo = $.trim($(this).find("td").eq(1).text());
		        custName=$.trim($(this).find("td").eq(2).text());
		        
		        orderDate=$.trim($(this).find("td").eq(3).text());
		        totalItems=$.trim($(this).find("td").eq(4).text());
		        payment=$.trim($(this).find("td").eq(5).text());
		        
		        paidAmt=$.trim($(this).find("td").eq(6).text());
		        balanceAmt=$.trim($(this).find("td").eq(7).text());
		        changeAmt=$.trim($(this).find("td").eq(8).text());
		        
		        
		        expectedAmt=$.trim($(this).find("td").eq(9).text());					
		        ord_comm_amt=$.trim($(this).find("td").eq(12).text());
		        
		        totalValuePrice=$.trim($(this).find("td").eq(13).text());					
		        advanceAmt=$.trim($(this).find("td").eq(14).text());
		        delchgs=$.trim($(this).find("td").eq(15).text());
								
				subValue= "Transit3";
				// get id of specified row 
				rowID = this.id.substring(3);
				AddRowTransit(custName,orderNo,area,orderDate,totalItems,totalValuePrice,advanceAmt,0,
	            		balanceAmt,delchgs,0,payment,changeAmt,expectedAmt,0,subValue,paidAmt,rowID);
	          	  
				document.myform.search.value ="";
				document.myform.search.focus();		
				rowCount--;
				return false;
		    }
		  rowCount++;
	});
	//alert($('#id > tbody >tr').size()+" "+rowCount)
	if($('#id > tbody >tr').size()==rowCount){
		alert("Order number "+ onval +" does not exist !");
		document.myform.search.value ="";
		document.myform.search.focus(); 
	}
}		
	
// following code will update expected amount depending on change amt 
// also update total_order,total_change ,total_comm ,total_bag	
function funexpamt(vbal, orderNo, rowID){ 
	
	chageVal = $('#sendid >tbody > #tr'+rowID).find('td').find('input').val();
	balance = $.trim($('#sendid >tbody > #tr'+rowID).find('td').eq(9).text());
	expAmt =  parseFloat(chageVal)+parseFloat(balance)
	$('#sendid >tbody > #tr'+rowID).find('td').eq(11).text(expAmt);
	var grandTotalChange = 0;
	
	// row object for send order detail
	var rowObj = $('#sendid >tbody > tr');
	rowObj.each(function(){
		chageVal = $(this).find('td').find('input').val();
		grandTotalChange = parseFloat(grandTotalChange) + parseFloat(chageVal);
	});
	
	//alert(grandTotalChange +" total change" +totalAllChangeAmt)
	totalAllChangeAmt = grandTotalChange;
	document.getElementById('divtotchange').innerHTML = totalAllChangeAmt;
	document.myform.search.focus(); 
	
}
		
// calculate denomination for change Amount
function calculate(){  
 // initialize array
	 camtVal = new Array();
	 tempArray=  new Array();
	 var i =0;
	
	 // if now row was added then return back with alert mesage
	 if($('#sendid > tbody >tr').size()==0){
			alert("No Row Seletced");
		  	return false;
	    }
	
	 // othewise push it in the changeAmt array
	 $('#sendid > tbody >tr').each(function() {
		camtVal[i++] = $(this).find('td').find('input').val();
	  });
	
	  tempRsArray = document.myform.hcoinArray.value.split("|");
	
	  var tempcnt=1;
	  for (rscnt=0; rscnt< tempRsArray.length-1; rscnt++){	
	      RsArray[rscnt]=tempRsArray[tempcnt];
		  totalRsArray[rscnt]=0;
		  tempcnt++;
	  }	

	  	j=0;
		var calcnt=0;
		var strDisplay ="";
	 	for(i=0; i<camtVal.length; i++){	 
	 		if(camtVal[i] != "|"){
	 			tempArray[j] = camtVal[i];
	 			j++;
	 		}	 		
	 	}
	 	
	 	// calculation for denominations
	 	for(i=0; i<tempArray.length; i++){
	 	    no = tempArray[i];
	 	    if(no > 0){
		 		for (rscnt=0; rscnt< RsArray.length; rscnt++){		
			    	calcnt=0;			    	
			    	while(parseFloat(no) >=  parseFloat(RsArray[rscnt])){
			    		no = no - RsArray[rscnt];
			    		if(no >=0){	    	   
			    	   		calcnt++;
			    		}	    		
			    	}
			    totalRsArray[rscnt] = totalRsArray[rscnt] + calcnt;				    	
		  		}	
		  	} 
	    }	     
	    for(i=0; i<totalRsArray.length; i++){
	        if(totalRsArray[i] != 0){	      	
	 			strDisplay = strDisplay + "\n Rs  : " + RsArray[i]+"\t- "+totalRsArray[i];			
	 		}
	    }
	    alert("currency/coin denomination \n" +strDisplay);
}		



	