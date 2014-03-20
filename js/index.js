function a(){

	if(document.myform.sname.value=='' 
           && document.myform.sadd.value=='' 
           && document.myform.semail.value==''
           && document.myform.sphone.value==''
          ){
          alert("Please enter some value");
         return false;
      }
	var myurl="studentDetails.jsp?callfor=insertlist";
myurl=myurl+"&stud_name="+document.myform.sname.value;
myurl=myurl+"&stud_add="+document.myform.sadd.value;
myurl=myurl+"&stud_email="+document.myform.semail.value;
myurl=myurl+"&stud_phone="+document.myform.sphone.value;

	$.ajax({
		url:myurl,
		type:'post',
			
		success:function(completeData)
		{			
			alert(completeData);
			 document.getElementById('message').innerHTML=completeData;
	    document.getElementById('message').style.display="block";
		}
	});

}