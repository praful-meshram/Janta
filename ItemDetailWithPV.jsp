<%@page import="java.sql.ResultSet"%>
<%@page import="item.ManageItem"%>
<%
	String first = request.getParameter("first");
	String second = request.getParameter("second");
	ManageItem mi = new ManageItem("jdbc/js");
	ResultSet rs1 = mi.getItemWithPV(first,second);
%>
	<form action="SavePriceVersion.jsp?start_with=<%=first+second%>" method="post">
	<input type="submit" value="Save"/>
	<div style="width: 100%;overflow-x: hidden;">
		<table style="width: 100%;float: right;border-collapse: collapse;" border="1"  cellspacing = 0 cellpadding = 0 bordercolor=black>
			<tr style="background-color: #81F781;">
				<th style="width: 15%;">Item Name</th>
				<th style="width: 7%;">Weight</th>
				<th style="width: 78%;">Price Versions</th>
			</tr>
<%
	if(mi.rs.next()){
		String temp = "";
		int count=0;
		do{
			if(!mi.rs.getString(1).equals(temp)){
				count++;
				if(count%2==0){
			%>
				<tr style="background-color: #E0F8F1;">
			<%
				}else{
			%>
				<tr style="background-color: #ECFB99;">
			<%
				}
			%>
				<td style="width: 15%;" align="left" valign="top"><%=mi.rs.getString(2)%>
					<input type="hidden" name="item_code" value="<%=mi.rs.getString(1)%>"/>
				</td>
				<td style="width: 7%;" align="left" valign="top"><%=mi.rs.getString(3)%></td>
				<td style="width: 78%;" align="left" valign="top">
					<div id="pv_div" style="border: 1px solid black;float: left;">
						<div class="popup" id="popup_<%=mi.rs.getString(1)%>_<%=mi.rs.getString(4)%>">
							<div class="arrow-right"></div>
							<%
								if(rs1 != null){
									%>
									Price Version : <%=mi.rs.getInt(4) %>
									<table style="widows: 100%">
										<tr><th>Id</th><th>Site</th><th>Qty</th></tr>
									<%
									while(rs1.next()){
										if(rs1.getString(1).equals(mi.rs.getString(1)) && rs1.getInt(2)==mi.rs.getInt(4)){
											%>
											<tr>
												<td><%=rs1.getInt(3) %></td>
												<td><%=rs1.getString(5) %></td>
												<td><%=rs1.getInt(4) %></td>
											</tr>
											<%
										}
										
									}
									%>
									</table>
									<%
									rs1.beforeFirst();
								}
							%>
						</div>
							<font color="blue" onmouseover="dispPopup('popup_<%=mi.rs.getString(1)%>_<%=mi.rs.getString(4)%>')" 
								onmouseout="hidePopup('popup_<%=mi.rs.getString(1)%>_<%=mi.rs.getString(4)%>')"><u><b>V:</b><%=mi.rs.getInt(4)%></u></font>|<b>M:</b><%=mi.rs.getFloat(5)%>|<b>R:</b><%=mi.rs.getFloat(6)%>
						<br/>
						<%
						if(mi.rs.getString(7).equals("Y")){
							%>
							<input type="radio" 
								name="current_<%=mi.rs.getString(1)%>" 
								id="current_id_<%=mi.rs.getString(1)%>_ <%=mi.rs.getInt(4)%>" 
								checked="checked" value="<%=mi.rs.getInt(4)%>"
								onclick="checkField1('current_id_<%=mi.rs.getString(1)%>_ <%=mi.rs.getInt(4)%>','discard_id_<%=mi.rs.getString(1)%>_<%=mi.rs.getInt(4)%>')"/>Current
							<input type="checkbox" 
								name="discard_<%=mi.rs.getString(1)%>" 
								id="discard_id_<%=mi.rs.getString(1)%>_<%=mi.rs.getInt(4)%>"
								value="<%=mi.rs.getInt(4)%>"
								onclick="checkField('current_id_<%=mi.rs.getString(1)%>_ <%=mi.rs.getInt(4)%>','discard_id_<%=mi.rs.getString(1)%>_<%=mi.rs.getInt(4)%>')"/>Discard
							<%
						} else {
							%>
							<input type="radio" 
								name="current_<%=mi.rs.getString(1)%>" 
								id="current_id_<%=mi.rs.getString(1)%>_ <%=mi.rs.getInt(4)%>" 
								value="<%=mi.rs.getInt(4)%>"
								onclick="checkField1('current_id_<%=mi.rs.getString(1)%>_ <%=mi.rs.getInt(4)%>','discard_id_<%=mi.rs.getString(1)%>_<%=mi.rs.getInt(4)%>')"/>Current
							<input type="checkbox" 
								name="discard_<%=mi.rs.getString(1)%>" 
								id="discard_id_<%=mi.rs.getString(1)%>_<%=mi.rs.getInt(4)%>"
								value="<%=mi.rs.getInt(4)%>"
								onclick="checkField('current_id_<%=mi.rs.getString(1)%>_ <%=mi.rs.getInt(4)%>','discard_id_<%=mi.rs.getString(1)%>_<%=mi.rs.getInt(4)%>')"/>Discard
							<%
						}
						%>
						
					</div>
			<%
			} else {
			%>
				
				<div id="pv_div" style="border: 1px solid black;float: left;">
					<div class="popup" id="popup_<%=mi.rs.getString(1)%>_<%=mi.rs.getString(4)%>">
						<div class="arrow-right"></div>
						<%
								if(rs1 != null){
									%>
									Price Version : <%=mi.rs.getInt(4) %>
									<table style="widows: 100%">
										<tr><th>Id</th><th>Site</th><th>Qty</th></tr>
									<%
									while(rs1.next()){
										if(rs1.getString(1).equals(mi.rs.getString(1)) && rs1.getInt(2)==mi.rs.getInt(4)){
											%>
											<tr>
												<td><%=rs1.getInt(3) %></td>
												<td><%=rs1.getString(5) %></td>
												<td><%=rs1.getInt(4) %></td>
											</tr>
											<%
										}
										
									}
									%>
									</table>
									<%
									rs1.beforeFirst();
								}
							%>
					</div>
					<font color="blue" onmouseover="dispPopup('popup_<%=mi.rs.getString(1)%>_<%=mi.rs.getString(4)%>')" 
						onmouseout="hidePopup('popup_<%=mi.rs.getString(1)%>_<%=mi.rs.getString(4)%>')"><u><b>V:</b><%=mi.rs.getInt(4)%></u></font>|<b>M:</b><%=mi.rs.getFloat(5)%>|<b>R:</b><%=mi.rs.getFloat(6)%>
					<br/>
					<%
					if(mi.rs.getString(7).equals("Y")){
						%>
						<input type="radio" 
							name="current_<%=mi.rs.getString(1)%>" 
							id="current_id_<%=mi.rs.getString(1)%>_ <%=mi.rs.getInt(4)%>" 
							checked="checked" value="<%=mi.rs.getInt(4)%>"
							onclick="checkField1('current_id_<%=mi.rs.getString(1)%>_ <%=mi.rs.getInt(4)%>','discard_id_<%=mi.rs.getString(1)%>_<%=mi.rs.getInt(4)%>')"/>Current
						<input type="checkbox" 
							name="discard_<%=mi.rs.getString(1)%>" 
							id="discard_id_<%=mi.rs.getString(1)%>_<%=mi.rs.getInt(4)%>"
							value="<%=mi.rs.getInt(4)%>"
							onclick="checkField('current_id_<%=mi.rs.getString(1)%>_ <%=mi.rs.getInt(4)%>','discard_id_<%=mi.rs.getString(1)%>_<%=mi.rs.getInt(4)%>')"/>Discard
						<%
					} else {
						%>
						<input type="radio" 
							name="current_<%=mi.rs.getString(1)%>" 
							id="current_id_<%=mi.rs.getString(1)%>_ <%=mi.rs.getInt(4)%>" 
							value="<%=mi.rs.getInt(4)%>"
							onclick="checkField1('current_id_<%=mi.rs.getString(1)%>_ <%=mi.rs.getInt(4)%>','discard_id_<%=mi.rs.getString(1)%>_<%=mi.rs.getInt(4)%>')"/>Current
						<input type="checkbox" 
							name="discard_<%=mi.rs.getString(1)%>" 
							id="discard_id_<%=mi.rs.getString(1)%>_<%=mi.rs.getInt(4)%>"
							value="<%=mi.rs.getInt(4)%>" 
							onclick="checkField('current_id_<%=mi.rs.getString(1)%>_ <%=mi.rs.getInt(4)%>','discard_id_<%=mi.rs.getString(1)%>_<%=mi.rs.getInt(4)%>')"/>Discard
						<%
					}
					%>
					
				</div>
			<%	
			}
			temp=mi.rs.getString(1);
			
		}while(mi.rs.next());
	} else {
		%>
		<td colspan="3">No record start with <%=first+second %></td>
		<%
	}
	mi.closeAll();
%>
	</table>
</div>
</form>