		//array of silver list items
		var silverItems = [];
		//array of gold list items
		var goldItems = [];
		//highlighting class name
		var className = "";
		//is draggable over drop area
		//this variable also holds the highlighted item
		//which is equivalent to true
		var over = false;
		//silver and gold lists
		var silverDrop = null, goldDrop = null;
		//current drop and current items
		var activeDrop = null, activeItems = [];
		//points to droparea holding currently dragged item
		var ownerDrop = null;
		//highlights the items under draggable item
		function highlight() {
			if (!over) {
				return false;
			}
			var overEl = findElementByY(activeItems, activeDrop.dropArea, activeDrop.mousePos.y);
			if(overEl){
				over = moveHighlight(over, overEl, className) || true;
			}
		}
		function init() {
			//global event listener to restore elements original position
			Zapatec.GlobalEvents.addEventListener("onDragEnd", function(ev, draggable) {
				if (!over) {
					draggable.restorePos();
				}
			});
			Zapatec.Utils.initDragObjects("item", null, true, {dragCSS : "lastItem"});
			silverItems = getItems("box");
			silverDrop = new Zapatec.Utils.DropArea({
				container : "box",
				eventListeners : {
					//on drop we need to restore element to its
					//original place, move it ot the place it
					//was dragged to(in DOM tree), reset highlighting and
					//refresh last item(to have a bottom border)
					onDrop : function(el, droparea) {
						if (!isItem(el)) {
							return false;
						}
						el.dragObj.restorePos();						
						droparea.dropArea.insertBefore(el, (over === true) ? null : over);
						silverItems = getItems("box");
						moveHighlight(over, null, className);
						setLastItem(silverItems);
						
						
					},
					//on drag init we need to renew all items array
					//as one element was remover from the list(draggable one),
					//and refresh last item
					onDragInit : function(el, droparea) {
						if (!isItem(el)) {
							return false;
						}
						if (el.className.indexOf("silverItem") != -1) {
							ownerDrop = this;
						}
						silverItems = getItems("box");
						setLastItem(silverItems);
					},
					//when element is over drop area we need to start highlighting
					onDragOver : function(el, droparea) {
						if (!isItem(el)) {
							return false;
						}
						over = true;
						activeDrop = this;
						activeItems = silverItems;
						className = "silverHighlight";
						if (ownerDrop != this) {
							Zapatec.Utils.removeClass(el, "goldItem");
							Zapatec.Utils.addClass(el, "silverItem");
						}
						Zapatec.GlobalEvents.addEventListener("onDragMove", highlight);
					},
					//we need to stop highlighting and remove it from the element
					//when element was dragged out the drop area
					onDragOut : function(el, droparea) {
						if (!isItem(el)) {
							return false;
						}
						Zapatec.GlobalEvents.removeEventListener("onDragMove", highlight);
						if (ownerDrop != this) {
							Zapatec.Utils.addClass(el, "goldItem");
							Zapatec.Utils.removeClass(el, "silverItem");
						}
						moveHighlight(over, null, className);
						className = "";
						activeItems = [];
						activeDrop = null;
						over = false;
					},
					//on drag end we need to refresh last item and
					//refresh items list(one element was returned to the list)
					onDragEnd : function(el, droparea) {
						if (!isItem(el)) {
							return false;
						}
						silverItems = getItems("box");
						setLastItem(silverItems);
					}
				}
			});
			goldItems = getItems("selbox");
			goldDrop = new Zapatec.Utils.DropArea({
				container : "selbox",
				//array of listeners
				eventListeners : {
					//on drop we need to restore element to its
					//original place, move it ot the place it
					//was dragged to(in DOM tree), reset highlighting and
					//refresh last item(to have a bottom border)
					onDrop : function(el, droparea) {
						if (!isItem(el)) {
							return false;
						}
						el.dragObj.restorePos();						
						droparea.dropArea.insertBefore(el, (over === true) ? null : over);
						goldItems = getItems("selbox");
						moveHighlight(over, null, className);
						setLastItem(goldItems);
						
					},
					//on drag init we need to renew all items array
					//as one element was remover from the list(draggable one),
					//and refresh last item
					onDragInit : function(el, droparea) {
						if (!isItem(el)) {
							return false;
						}
						if (el.className.indexOf("goldItem") != -1) {
							ownerDrop = this;
						}
						goldItems = getItems("selbox");
						setLastItem(goldItems);
					},
					//when element is over drop area we need to start highlighting
					onDragOver : function(el, droparea) {
						if (!isItem(el)) {
							return false;
						}
						over = true;
						activeDrop = this;
						activeItems = goldItems;
						className = "goldHighlight";
						if (ownerDrop != this) {
							Zapatec.Utils.removeClass(el, "silverItem");
							Zapatec.Utils.addClass(el, "goldItem");
						}
						Zapatec.GlobalEvents.addEventListener("onDragMove", highlight);
					},
					//we need to stop highlighting and remove it from the element
					//when element was dragged out the drop area
					onDragOut : function(el, droparea) {
						if (!isItem(el)) {
							return false;
						}
						Zapatec.GlobalEvents.removeEventListener("onDragMove", highlight);
						if (ownerDrop != this) {
							Zapatec.Utils.addClass(el, "silverItem");
							Zapatec.Utils.removeClass(el, "goldItem");
						}
						moveHighlight(over, null, className);
						className = "";
						activeItems = [];
						activeDrop = null;
						over = false;
					},
					//on drag end we need to refresh last item and
					//refresh items list(one element was returned to the list)
					onDragEnd : function(el, droparea) {
						if (!isItem(el)) {
							return false;
						}
						goldItems = getItems("selbox");
						setLastItem(goldItems);
					}
				}
			});
		}






























var xmlHttp;
		
	
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

	function OpenDiv(orderdt,itemcode,itemname){
	
		xmlHttp=GetXmlHttpObject()
		if (xmlHttp==null)
	  	{
	  		alert ("Your browser does not support AJAX!");
	  		return;
	  	} 
	  	
	  	
		var url="RitemSalesCustInfo.jsp";
		url=url+"?orderdt="+orderdt+"&iCode="+itemcode+"&iName="+itemname+"&Exp=0&type=all&t="+new Date().getTime();
		url=url+"&sid="+Math.random();		
		xmlHttp.onreadystatechange=stateChanged1;
		xmlHttp.open("GET",url,true);
		xmlHttp.send(null);
		
	}

	function stateChanged1() 
	{
		if (xmlHttp.readyState==4)
		{ 	
			document.getElementById("dispdiv").innerHTML=xmlHttp.responseText;
			 //document.getElementById("dispdiv").style.visibility="visible";	
			 Popup.showModal('dispdiv',null,null,{'screenColor':'gray','screenOpacity':.6})	 
			
		}
	}

	function passVar(code){
	
		document.myform.orderNo.value=code;
		document.myform.action="print_order.jsp??&backPage=HomeForm.jsp&buttonFlag=Y";
	    document.myform.submit();
	
	}
	function Pass(){
		document.myform.action="RItemSales.jsp?Exp=1";
	    document.myform.submit();
	}
	function Pass1(){
		document.myform.action="RitemSalesCustInfo.jsp?Exp=1";
	    document.myform.submit();
	}
	function funReturn(){
		document.myform.action="RItemSalesForm.jsp";
	    document.myform.submit();
	}
	function funclose(){
		Popup.hide('dispdiv');
	}

	
	function checkField(){
		
		var iGroupCode=document.myform.iGroupCode.value;
		var iname=document.myform.itemname.value;
		var frDate=document.myform.frDate.value;
		var toDate=document.myform.toDate.value;
		
		if (document.myform.chckall.checked==false && iGroupCode=="select" && iname == "") {
					alert("Fill the information");
					return false;				
		}	
		if(frDate!="" && toDate !="") {	
				var str = "";
				str = str + document.myform.frDate.value ;
				//str = str + document.myform.frMonth.value;	
				if (validateIndiaDate(str) == false){
					alert("Please enter a valid From Date");
					return false;
				}
				str = "";
				str = str + document.myform.toDate.value ;
				if (validateIndiaDate(str) == false){
					alert("Please enter a valid To Date");
					return false;
				}
				
				document.myform.frDate.value = document.myform.frDate.value.substring(6,10) + "-" +
			                                document.myform.frDate.value.substring(3,5) +
			                                "-" + document.myform.frDate.value.substring(0,2);
			
			 	document.myform.toDate.value  = document.myform.toDate.value.substring(6,10) + "-" +
			                                                document.myform.toDate.value.substring(3,5) +
			                                                "-" + document.myform.toDate.value.substring(0,2);						
				
	    }
		else{
			alert("Select Both Date");
			return false;
				
 		}
 		
 		if(iname != ""){
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
	 		document.myform.hitem.value =  iname;		 		
 		} 		
 		document.myform.action="RItemSales.jsp?Exp=0";
	    document.myform.submit();	 		
	}
	
	function Clear(){
		document.myform.iGroupCode.value="select";			
		document.myform.chckall.checked= true;
		document.myform.frDate.value="";
		document.myform.frDate.value="";
		
		if(document.myform.itemname.value != ""){
			document.getElementById("box").innerHTML='';
			document.getElementById("selbox").innerHTML='';
			document.getElementById("dispitem").innerHTML='';
			document.getElementById("dispitem").style.visibility="hidden";	
			document.getElementById("dispitem").style.display="none";  
		}
		document.myform.itemname.value="";
		document.getElementById('div4').style.visibility="hidden";
		var newdate = new Date();
		var day= ""+newdate.getDate();
		if(day.length==1)
			day="0"+day;
		var month = ""+(newdate.getMonth()+1);		
		if(month.length==1)
			month="0"+month;
		var year  = newdate.getYear()
		var fromdate="01/"+ month +"/"+ year;
		newdate = day +"/"+ month + "/"+year;
		document.myform.frDate.value= fromdate;
		document.myform.toDate.value="";
		document.myform.toDate.value=newdate;	
		return false;
	}
	
	function showMsg(){
	  	 document.myform.action="HomeForm.jsp";
	   	 document.myform.submit();
	}
	
	function funEnabled(){
	    if (document.myform.chckall.checked==true){
			document.getElementById('div4').style.visibility="hidden";
			
			document.myform.iGroupCode.value="select";	
			
		}
		else{
			document.getElementById('div4').style.visibility="visible";
			document.myform.hchckall.value=0;			
		}
	}
	
  	function fundispitem(itemnm){
  		xmlHttp=GetXmlHttpObject()
		if (xmlHttp==null)
	  	{
	  		alert ("Your browser does not support AJAX!");
	  		return;
	  	} 
	  	if(itemnm == ""){
	  		alert("Enter Item Name");
	  		document.getElementById("dispitem").innerHTML='';
			document.getElementById("dispitem").style.visibility="hidden";	
			document.getElementById("dispitem").style.display="none";  	
	  	}else{	
	  		document.myform.itemname.disabled = true;
	  		document.getElementById("dispitem").innerHTML='';
			document.getElementById("dispitem").style.visibility="hidden";	
			document.getElementById("dispitem").style.display="none";  	
			var url="RitemSalesCustInfo.jsp";
			url=url+"?itemnm="+itemnm+"&type=dispitem";
			url=url+"&sid="+Math.random();
			//alert(url);
			xmlHttp.onreadystatechange=stateChanged2;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);
		}
	}
	
	function stateChanged2() 
	{
		if (xmlHttp.readyState==4)
		{ 	
			document.getElementById("dispitem").innerHTML=xmlHttp.responseText;
			document.getElementById("dispitem").style.visibility="visible";	
			document.getElementById("dispitem").style.display="block";
			
			init();	
		}
	}
	