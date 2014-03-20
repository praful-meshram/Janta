<%@page pageEncoding="Cp1252" contentType="text/html; charset=Cp1252" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>

<script src="js/jquery-1.2.6.min.js" type="text/javascript"></script>
	<script src="js/jquery.js" type="text/javascript"></script>
<script  type="text/javascript" src="js/ShowMessage.js"></script>
<script type="text/javascript" charset="utf-8"></script>

<style>
 
#popupfade{
    display: none;
    position: absolute;
    top: 0%;
    left: 0%;
    width: 100%;
    height: 100%;
    background-color: black;
    z-index:1001;
    -moz-opacity: 0.8;
    opacity:.80;
    filter: alpha(opacity=80);
}

#popuplight{
    display: none;
    position: absolute;
    top: 25%;
    left: 35%;
    width: 30%;
    height: 30%;
    padding: 16px;
    border: 5px solid yellow;
    background-color: #FFFFCC;
    z-index:1002;
    font-family: arial;
   
}


#popupContactClose{
text-shadow: highlighttext;
}

#msgpop{
background-color: #color;
border-left: #FFEEEE;
border-top: #EEEEEE;
color: black;
font-family: Verdana, Arial
}

</style>

<html>
<body>


<form >
<div id="popuplight">
<a id="popupContactClose" onclick="popupclose()"  style="color:red;cursor:pointer;font-size: 1.275em;position: right;float: right">X</a>
<b>Code</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Name</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Phone</b>
<br>
<label id="singleMessageCode"></label>&nbsp;
<label id="singleMessageName"></label>&nbsp;
<label id="singleMessagePhone"></label>&nbsp;&nbsp;
<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;
<b>Message Type</b><select name="MType" id="msgType">
<option value="">Select Type</option>
<option value="Transactinal">Transactional</option>
<option value="Promotional">Promotional</option>
</select><br>
<b>Message</b><br/>
<textarea accesskey="m" id="textmsg" rows="5" cols="30"  style="resize:none; name="message">
</textarea>
<div id="messageLimit"></div>
<br/>

<input type="button" name="message"  value="SEND MESSAGE" onclick="singleCustMessage()" id="msgpop"/>
</div>
<div id="popupfade"></div>

</form>
</body>
</html>