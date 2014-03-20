
var cust=new Array();
var rowobject=new Array();

window.onload = func();

function func(){
	$.ajax({url:"ShowMessageDetails.jsp?callfor=arealist",success:function(result){
    $("#selectboxid").html(result);
  }});
  
   }
   
   function phoneCheck(){
   if(event.keyCode>=48 && event.keyCode<=57)
   event.returnValue=true;
   else
   event.returnValue=false;
   
   }
   
function showCustDetails(){
      if(document.myform.custCode.value=='' 
           && document.myform.custName.value=='' 
           && document.myform.building.value==''
           && document.myform.buildingNo.value==''
           && document.myform.block.value==''
           && document.myform.wing.value==''
           && document.myform.area.value==''
           && document.myform.station.value==''
           && document.myform.phonenumber.value==''
           && document.myform.nameString.value==''
           && document.myform.address1.value==''
           && document.myform.address2.value==''){
           alert("Please enter some value");
          return false;
}
         
    
         
         
var myurl="ShowMessageDetails.jsp?callfor=customerlist";
myurl=myurl+"&cust_code="+document.myform.custCode.value;
myurl=myurl+"&cust_name="+document.myform.custName.value;
myurl=myurl+"&cust_building="+document.myform.building.value;
myurl=myurl+"&building_no="+document.myform.buildingNo.value;
myurl=myurl+"&cust_block="+document.myform.block.value;
myurl=myurl+"&cust_wing="+document.myform.wing.value;
myurl=myurl+"&cust_address1="+document.myform.address1.value;
myurl=myurl+"&cust_address2="+document.myform.address2.value;
myurl=myurl+"&cust_area="+document.myform.area.value;
myurl=myurl+"&cust_station="+document.myform.station.value;
myurl=myurl+"&cust_phonenumber="+document.myform.phonenumber.value;

$.ajax({url:myurl,success:function(result){
    $("#customersearchresult").html(result);
    fun();
  }});
 
  
}


function fun()
{
	 $("#resulttable").dataTable( {
        "sDom": "Rlfrtip",                        
        "sScrollY": "300px",
		"sScrollX": "70%",
        "sScrollXInner": "100%",
        "bPaginate": false
	 });
}


function onCustomerSelect(custcode,custname,custphone,count){
                 for(var i=0;i<cust.length;i++)
                            {
                                                    if(cust[i]===custcode)
                                           
                                                       {   
                                                          //alert("Already entered!");
                                                          return;
                                                       }
                             }
                 cust.push(custcode);
                 rowobject.push(count);
                 var newRow = document.all("messagelisttable").insertRow(-1); 
                 var Cell1 = newRow.insertCell(0);
                 Cell1.innerHTML = custcode;
                 Cell1.style.width='25%';
                 var Cell2 = newRow.insertCell(1);
                 Cell2.innerHTML = custname;
                 Cell2.style.width='40%';
                 var Cell3 = newRow.insertCell(2);
                 Cell3.innerHTML = custphone;
                 Cell3.style.width='30%';
                 var Cell4 = newRow.insertCell(3);
                 var str="<font onclick=\"removeRow(this,'"+custcode+"')\" style=\"cursor:pointer;\"> X </font>";
                 str=str+"<input type=\"hidden\" name=\"custcode\" value=\""+custcode+"\"/>";
                 str=str+"<input type=\"hidden\" name=\"custphone\" value=\""+custphone+"\"/>";
                 Cell4.innerHTML = str;
                 Cell4.style.width='5%';
                 //rowobj.style.background='white';
                 document.getElementById("rowcount"+count).style.background='white';
               
                 }
              
 

function removeRow(objrow,custcode){
 
var p=objrow.parentNode.parentNode.rowIndex;
document.getElementById("messagelisttable").deleteRow(p);
//cust.splice(custcode);
//alert(cust.length);
//alert(rowobject.length);
 for(var i=0;i<cust.length;i++)
                            {
                                                    if(cust[i]===custcode)
                                           
                                                       {   
                                                         
                                                          cust.splice(i,1);
                                                          //alert(rowobject[i]);
                                                          document.getElementById("rowcount"+rowobject[i]).style.background='#ECFB99';
                                                          //document.getElementById("rowcount").style.background='#ECFB99';
                                                          rowobject.splice(i,1);
                                                          //objrow.style.background='#ECFB99';
                                                          return;
                                                       }
                             }
//document.getElementByTagName("rowobj").style.backgroundColor="#ECFB99"
//rowobj.style.background='#ECFB99';
}



function validateForm(){
//alert("Hi!");
var msg=document.MessageForm.message.value;
if(msg==""){
alert("Please enter the message!");
return false;
}
}


function checkMsgLength(message){
var limit=159;
var leng=message.value.length;
var disp=document.getElementById("charlimitinfo");
if(leng>limit){
message.value=message.value.substr(0,limit);
return false;
}
disp.innerHTML= leng +"/160 ";
return true;
}



function MessageDispTab()
{
	 $("#messagelisttable").dataTable( {
        "sDom": "Rlfrtip",                        
        "sScrollY": "150px",
		"sScrollX": "30%",
        "sScrollXInner": "100%",
        "bPaginate": false
	 });
}


function popupopen(name,code,phone){
document.getElementById("popuplight").style.display="block";
document.getElementById("popupfade").style.display="block";
document.getElementById("singleMessageName").innerHTML=name;
document.getElementById("singleMessageCode").innerHTML=code;
document.getElementById("singleMessagePhone").innerHTML=phone;
}


function popupclose(){
//alert("Hi");
document.getElementById("popuplight").style.display="none";
document.getElementById("popupfade").style.display="none";
document.getElementById("textmsg").value="";
document.getElementById("messageLimit").innerHTML="160";
}


function singleCustMessage(){
var msg=document.getElementById("textmsg").value;
if(msg==""){
alert("Please enter some message!");
}
else{
//alert("Hi!@");
var msgurl="SaveGroupMessage.jsp?callfor=sendmessage";
msgurl=msgurl+"&custcode="+document.getElementById("singleMessageCode").innerHTML;
msgurl=msgurl+"&message="+document.getElementById("textmsg").value;
msgurl=msgurl+"&custphone="+document.getElementById("singleMessagePhone").innerHTML;
msgurl=msgurl+"&messageType="+document.getElementById("msgType").value;
alert(msgurl);
$.ajax({url:msgurl,success:function(result){
   alert("Message Sent");
   popupclose();
  }});
  document.getElementById("textmsg").value="";
  document.getElementById("messageLimit").innerHTML="0/160";
}
}


function checkMessageLimit(message){
var limit=159;
var len=message.value.length;
var display=document.getElementById("messageLimit");
if(len>limit){
message.value=message.value.substr(0,limit);
return false;
}
display.innerHTML=len+"/160";
return true;
}



function redirect(){
document.myform.action="HomeForm.jsp";
document.myform.submit();
}



function  checkSelectedRow(){
var rows=document.getElementById("messagelisttable").getElementsByTagName("tr").length;
if(rows==0){
alert("Please select at atleast one customer");
return false;
}
}



$("#textmsg").keyup(function(){
    el = $(this);
    if(el.val().length >= 160){
        el.val( el.val().substr(0, 160) );
    } else {
        $("#messageLimit").text(160-el.val().length);
    }
});















