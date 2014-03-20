<%
	String userTypeCode=session.getAttribute("user_type_code").toString();
%>	


<script>
	var user_type_code=<%=userTypeCode%>
</script>

<script src="js/ua.js"></script>
<script src="js/ftiens4.js"></script>
<script src="js/demoFramelessNodes.js"></script>
<jsp:include page="sessionBoth.jsp">	
   <jsp:param name="formName" value="leftsidemenu.jsp" />	
</jsp:include>

<TABLE>
	<TR>
		<TD width="8%"  style="vertical-align: top;">

		<TABLE class=treenav1 style='background:#CCCCFF' align="left">
			<TR>
			<TD><IMG height=7 alt=* src="images/plus.gif" width=2 border=0>
			</TD>
			<TD vAlign=top align="left">		
				<script>initializeDocument()</script>
			</TD>
			</TR>	
		</TABLE>		
	</TD>

