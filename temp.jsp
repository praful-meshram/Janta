

<jsp:include page="header.jsp" />


<br><br>
<form name="myform">
<center>

<jsp:plugin type="applet" code="EditCustomerOrderApplet.class" name="order"  width="600" height="400" >
   <jsp:params>
          <jsp:param
               name="max"
               value="100"
          />
          <jsp:param
               name="customerCode"
               value="JS148"
          />
          <jsp:param
               name="user"
               value="admin"
          />
          
     </jsp:params>

     <jsp:fallback>
          <B>Unable to start plugin!</B>
     </jsp:fallback>

</jsp:plugin>
<jsp:plugin type="applet" code="ApplEx.class" name="order"  width="600" height="400" >
        <jsp:fallback>
          <B>Unable to start plugin!</B>
     </jsp:fallback>

</jsp:plugin>

<script>
function check(){
	 document.myform.action="customer_detailsForm.jsp";
      document.myform.submit();
}
</form>
</body>
</html>

