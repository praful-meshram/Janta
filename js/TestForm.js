function funCheckBarcode(){
//	var objTable=eval('document.getElementById("itemTable")');
//	var objrows = objTable.getElementsByTagName("TBODY")[0].rows;
	var enteredBarcode = document.myform.itemBarcode.value;
	alert(enteredBarcode);
//	enteredBarcode = enteredBarcode.toUpperCase();
//	var itemcode = document.myform.itemCode;
//	var itemname = document.myform.itemName;
	var x = document.getElementById(enteredBarcode);
	if(x==null){
		alert("Wrong Enterd");
	}else{
		var s =x.parentNode.parentNode;
		alert(s.rowIndex)
		var price = document.myform.itemPrice[s.rowIndex].value;
		alert(price);
		var orderQty = document.myform.orderQty;
	}
	
//	for(var i=0;i<itemcode.length;i++){
//		if(hbarcode[i].value == EnteredBarcode){
//			alert("Item Code : "+itemcode[i].value);
//			alert("Item Name : "+itemname[i].value);
//			alert("Item Price : "+price[i].value);
//			alert("Order Qty : "+orderQty[i].value);
//			if(orderQty[i].value==1){
//				document.getElementById('lastRecordDiv').style.visibility = "visible";
//				objrows[i].parentNode.removeChild(objrows[i]);
//				document.myform.itemBarcode.value="";
//				document.myform.itemBarcode.focus();
//			}
//		}
//	}
}
