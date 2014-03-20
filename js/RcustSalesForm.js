//window.onload =Clear;
var flag=false;
window.onload=function(){
		//var theme = getDemoTheme(); 
		
		document.myform.chckall.checked=true;
		document.myform.hchckall.value="1";
		document.myform.custName.value="";
		
		$("#range1").jqxDateTimeInput({theme:'ui-redmond', width: '250px', height: '25px',max:new Date(),formatString: "yyyy/MM/dd"});
		$("#range2").jqxDateTimeInput({theme:'ui-redmond',width: '250px', height: '25px',min:new Date(),max:new Date(),formatString: "yyyy/MM/dd",value:new Date()});
		
		
		//$("#range2").jqxDateTimeInput({disabled: true});
		
		
		$('#range1').on('close', function (event) {
		 // Some code here. 
		 	$("#range2").jqxDateTimeInput({disabled: false});
		 	$("#range2").jqxDateTimeInput({min: $('#range1').jqxDateTimeInput('getDate')});
 		}); 
 		
 		
	}
  
	function checkField(){
		
		var custCode=document.myform.custCode.value;
		var custName=document.myform.custName.value;
		var area=document.myform.area.value;
		
		var frDate=$('#range1').jqxDateTimeInput('getText');
		var toDate=$('#range2').jqxDateTimeInput('getText');
		
		if (document.myform.chckall.checked==false && custName=="" && custCode=="" && area=="") {
					alert("fill the information");
					return false;				
		}	
		
		if(frDate=="" || frDate==null ){
			alert('please select from date');
			return; 
		}
	
		if(toDate=="" || toDate==null ){
			alert('please select To date');
			return;
		}
		
 		if (flag==false){
 		  document.myform.hcondition.value = "details";
 		}
 		else{
 			document.myform.hcondition.value = "summary";
 		}
 		
 		if(custName != ""){
 			var stritemname = new Array();
 			var cn = 0;
			for(si=0; si<goldItems.length; si++){
				if(cn == 0){
					if (goldItems[si].id != ""){				
						stritemname = goldItems[si].id;
						cn= cn+1;							
					}
				}else{
					if (goldItems[si].id != ""){	
						stritemname = stritemname + "#" +goldItems[si].id;
					}
				}
			} 			
	 		document.myform.hitemname.value =  stritemname;	
	 		document.myform.hitem.value =  custName;		 		
 		} 		
 		
 		document.myform.action="RsalesSummary.jsp?Exp=0&type=all&frDate="+frDate+"&toDate="+toDate;
 		document.myform.action+="&hcondition="+document.myform.hcondition.value;
 		
 	//	alert("checkfield "+document.myform.action);
 		document.myform.submit();	 		
	}
	
	function showMsg(){
	  	 document.myform.action="HomeForm.jsp";
	   	 document.myform.submit();
	}
	
	
	function funEnabled(){
	    if (document.myform.chckall.checked==true){
			document.getElementById('div4').style.visibility="hidden";
			document.myform.custCode.value="";
			document.myform.area.value="";
			document.myform.custName.value="";
			
		}
		else{
			document.getElementById('div4').style.visibility="visible";
			document.myform.hchckall.value=0;			
		}
	}
	
	function getDemoTheme() {
    var theme =  $.data(document.body, 'theme');
    if (theme == null) {
        theme = '';
    }
    else {
        return theme;
    }
    var themestart = 'darkblue'

    var theme = 'darkblue'
    var url = "jqwidgets/styles/jqx." + theme + '.css';

    if (document.createStyleSheet != undefined) {
        var hasStyle = false;
        $.each(document.styleSheets, function (index, value) {
            if (value.href != undefined && value.href.indexOf(theme) != -1) {
                hasStyle = true;
                return false;
            }
        });
        if (!hasStyle) {
            document.createStyleSheet(url);
        } 
    }
    else $(document).find('head').append('<link rel="stylesheet" href="' + url + '" media="screen" />');
  
    return theme;
};