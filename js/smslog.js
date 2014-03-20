function setDate(){
	var to=document.smslog.to.value
	var from=document.smslog.from.value
	from=from.split("/")
	from=from[2]+"/"+from[1]+"/"+from[0]
	to=to.split("/")
	to=to[2]+"/"+to[1]+"/"+to[0]
	document.smslog.from1.value=from
	document.smslog.to1.value=to
}
function getSmsLog(){
  	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
  	setDate();
	url="SMSLog.jsp?from="+document.smslog.from.value+"&to="+document.smslog.to.value+"&from1="+document.smslog.from1.value+"&to1="+document.smslog.to1.value+"&sid="+Math.random();
	xmlHttp.onreadystatechange=stateChangedSMS;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
}
function stateChangedSMS(){
	if (xmlHttp.readyState==4)
		document.getElementById("smsdetails").innerHTML=xmlHttp.responseText;
}
function GetXmlHttpObject(){
	try{
  		xmlHttp=new XMLHttpRequest();// Firefox, Opera 8.0+, Safari
  	}catch (e){
  		try{
    		xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");  	// Internet Explorer
    	}catch (e){
	    	xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
    	}
  	}
	return xmlHttp;
}
function getRecord(t){
	xmlHttp=GetXmlHttpObject();
	if (xmlHttp==null){
  		alert ("Your browser does not support AJAX!");
  		return;
  	} 
	url="SMSRecord.jsp?from="+document.smslog.from.value+"&to="+document.smslog.to.value+"&from1="+document.smslog.from1.value+"&to1="+document.smslog.to1.value+"&sid="+Math.random()+"&t="+t;
	xmlHttp.onreadystatechange=stateChangedSMSRecord;
	xmlHttp.open("GET",url,true);
	xmlHttp.send(null);
	document.getElementById("smsrecord").innerText=t
}
function stateChangedSMSRecord(){
	if (xmlHttp.readyState==4)
		document.getElementById("smsrecord").innerHTML=xmlHttp.responseText;
}
function stopSMS(t){
	var c=0;
	if(document.smslog.count!=null){
		var count=document.smslog.count.value
		for(var i=0;i<count;i++)
			if(eval('document.smslog.chk_'+i+'.checked'))
				c++
		if(c==0){
			alert("Please select sms to stop")
			return false;
		}
		document.smslog.action="StopSMS.jsp?operation="+t
		document.smslog.submit();
	}
}