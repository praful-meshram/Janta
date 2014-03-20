var counter=0;
function setJsCounter(id){
	var objTable=eval('document.getElementById("'+id+'")')
	counter=eval(objTable.getElementsByTagName("TBODY")[0].childNodes.length)
}
function validateTable(id){
	if(id=="packageTable"||id=="CargoTable"){
		if(document.getElementById("equipmentTable").getElementsByTagName("TBODY")[0].getElementsByTagName("Tr").length==0){
			alert("Please add a row in equipment table first");
			return false;
		}else{
			return true;
		}
	}else{
		return true;
	}
}
function addRow(id){
	if(!validateTable(id))
		return false;
	var objTable=eval('document.getElementById("'+id+'")')
	var footerCount = objTable.rows.length;
	tableColumn=objTable.getElementsByTagName("THEAD")[0].getElementsByTagName("TR")[0].getElementsByTagName("TH").length
	objBody=objTable.getElementsByTagName("TBODY")[0]
	var objTr = document.createElement("TR");
	objTr.setAttribute("id","tr"+counter)
	objTr.setAttribute("onclick","setTableFooter(this,"+footerCount+");");
	var objTd;
	for(var i=0;i<tableColumn;i++){
		objTd= document.createElement("TD");
		objTd.setAttribute("align","left");
		objTd.setAttribute("valign","top");
		objTd.innerHTML="&nbsp;";
		objTr.appendChild(objTd);
	}
	objBody.appendChild(objTr);
	addField(objTr);
	counter++;
	if(id=="dataTable"){
		if(typeof(objTr.childNodes[1].childNodes[0].name)!="undefined"){
			objTr.childNodes[1].childNodes[0].focus();
		}
	}else{
		if(typeof(objTr.childNodes[0].childNodes[0].name)!="undefined")
			objTr.childNodes[0].childNodes[0].focus();
	}
	
	var rowCount = objTable.rows.length;
	rowCount =rowCount -1;	
	var objRowCount = eval("document.forms[0]."+id+"RowCount");
	objRowCount.value = "Record "+ rowCount + " of "+ rowCount;	
}

function deleteRow(t){
	var tr=t.parentNode.parentNode	
	var rowCount = tr.parentNode.rows.length;	
	var objTableId =tr.parentNode.parentNode.getAttribute("id");
	var objTable=document.getElementById(tr.parentNode.parentNode.getAttribute("id"));
	var rowCount = objTable.rows.length;

	for ( var i = tr.rowIndex; i < rowCount; i++) {		
		if(i== tr.rowIndex){
			tr.parentNode.removeChild(tr);			
		}	
		if(i!=(rowCount-1)){
			objTable.rows[i].removeAttribute("onclick","setTableFooter(this,"+i+")");
			objTable.rows[i].setAttribute("onclick","setTableFooter(this,"+i+")");	
		}		
	}	
	rowCount = objTable.rows.length;
	rowCount =rowCount - 1;				
	var objRowCount = eval("document.forms[0]."+objTableId+"RowCount");
	objRowCount.value = rowCount + " record(s) found.";
}

var trObj;
function setTableFooter(src,cnt){
	//alert("hi");
	if(trObj!=null)
		trObj.style.backgroundColor="#e7ebf7";
	trObj=src;
	trObj.style.backgroundColor="#b0c4de";
	var rowCount = src.parentNode.rows.length;
	var objTableId =src.parentNode.parentNode.getAttribute("id");
	var objRowCount = eval("document.forms[0]."+objTableId+"RowCount");
	objRowCount.value = "Record "+ cnt + " of "+ rowCount;
	
}

function changeValue(t){
	if(t.checked){
		t.value="true"
		t.setAttribute("checked","checked")
		t.parentNode.childNodes[1].value="true"
	}else{
		t.value="false"
		t.removeAttribute("checked")
		t.parentNode.childNodes[1].value="false"
	}
}
function setSelected(t){
	for(var i=0;i<t.options.length;i++)
		t.options[i].removeAttribute("selected")
	t.options[t.selectedIndex].setAttribute("selected","selected");
}
