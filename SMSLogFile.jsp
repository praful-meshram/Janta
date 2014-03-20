<%@page contentType="text/html"%>
<jsp:include page="header.jsp" />
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="RItemMonthlySalesForm.jsp" />	
</jsp:include>

<script src="js/smslog.js"></script>
<script src="js/smslog.js"></script>
<script language="javascript" src="js/codethatcalendarstd.js"></script>
<script>
	var caldef1 = {
	firstday:0,
	dtype:'dd/MM/yyyy',
	width:250,
	windoww:300,
	windowh:200,
	border_width:0,
	border_color:'#0000d3',
	dn_css:'clsDayName',                        
	cd_css:'clsCurrentDay',
	wd_css:'clsWorkDay',
	we_css:'clsWeekEnd',
	wdom_css:'clsWorkDayOtherMonth',
	weom_css:'clsWeekEndOtherMonth',
	headerstyle: {
	type:"comboboxes",
	css:'clsWorkDayOtherMonth',
	yearrange:[1987,2050]
	},
	monthnames :["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
	daynames : ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
	};
	var c1 = new CodeThatCalendar(caldef1);
</script>
<form name="smslog" method="post">
<center>
<table border="1">
<tr><td>From Date : </td><td><input readonly name="from" onclick="c1.popup('from');" value=""></td></tr>
<tr><td>From Date : </td><td><input readonly name="to" onclick="c1.popup('to');" value=""></td></tr>
<tr><td align="center"><input type="button" value="Submit <Alt+s>" accesskey="s" onclick="getSmsLog()"></td><td align="center"><input type="reset" value="Reset <Alt+r>" accesskey="r"></td></tr>
</table>
<br><br>
<div id="smsdetails"></div>
</center>
<input type="hidden" name="from1">
<input type="hidden" name="to1">
</form>
<script>
function chkallit(t){
	if(document.smslog.count!=null)
		var count=document.smslog.count.value
	for(var i=0;i<count;i++)
		if(t.checked==true)
			eval('document.smslog.chk_'+i+'.checked=true')
		else
			eval('document.smslog.chk_'+i+'.checked=false')
}
</script>