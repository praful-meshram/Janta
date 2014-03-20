// Check Chars

function check_chars (ref)
{
	if (ref.keyword.value == '*')
	{
		alert('Invalid Keyword');
		return false;
	}
	else
	{
		return true;
	}
	
}

function changeImages() {
	if (document.images) {
		for (var i=0; i<changeImages.arguments.length; i+=2) {
			
			document[changeImages.arguments[i]].src = changeImages.arguments[i+1];
			
		}
	}
	return true;
}


// Image rollover
function imagerollover(name,normalimagepath,hiliteimagepath,over)
{
	if(window.document.images) 
	{
		if (over)
			window.document.images[name].src = "media/" + hiliteimagepath;
		else
			window.document.images[name].src =  "media/" + normalimagepath;
	}
}

// Search box validation used for both the search box and the main search page
function searchpagevalidate(ref) {
	// search box is called "search", not keyword
	if (ref.search.value.search('^[ A-Za-z0-9_\\.-]+$') !=-1)
	{
	 	return true;
	}
	else
	{
		alert('Need a valid keyword to \nsearch on!');
		return false;			
	}
}
function gotoarticle(sel)
	{
		artID=sel.options[sel.selectedIndex].value;
		if (artID.length > 0){
			aURL="index.cfm?articleid="+artID;
			window.location.href = aURL;
		}
	}
	

//scripts used in the forum template
// check all fields have been entered.
function  _forum_checkThreadForm(_forum_this){
    if  (_forum_this.forum_topic.value.length ==0){
		alert("You must enter a Title.");
		return false;
	}
    if  (_forum_this.forum_username.value.length ==0){
		alert("You must enter your name to post to the forum.");
		return false;
	}
    if  (_forum_this.forum_body.value.length ==0){
		alert("In order to post you need to enter text into the message.");
		return false;
	}
	return true;
} 
//variables and functions used in the calendar template
var Days_in_Month = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
function monthchange(sel){
	mnth=sel.options[sel.selectedIndex].value;
	aform=sel.form;
	if(aform.aday != null){
		if (mnth =='2'){
			theYear=aform.ayear.options[aform.ayear.selectedIndex].value;
			Days_in_Month[1] = ((theYear % 400 == 0) || ((theYear % 4 == 0) && (theYear % 100 !=0))) ? 29 : 28;
		}
		for(i=27; i < Days_in_Month[mnth-1]; i++){
			aform.aday.options[i].text=i+1;
		}
		for(i=Days_in_Month[mnth-1]; i < 31; i++){
			aform.aday.options[i].text='';
		}
		checkday(aform);
	}
	changer(sel);	
}

function checkday(aform){
	if (aform.aday.options[aform.aday.selectedIndex].text==''){
		aform.aday.options[eval(Days_in_Month[aform.amonth.selectedIndex]-1)].selected=true;
		aform.aday.focus();
	}
}

function changer(sel)
{
	aform=sel.form;
	dy=(aform.aday != null)?aform.aday.options[aform.aday.selectedIndex].value:1;
	mnth=aform.amonth.options[aform.amonth.selectedIndex].value;
	yer=aform.ayear.options[aform.ayear.selectedIndex].value;
	aid=aform.articleid.value;
	aURL="index.cfm?articleid="+aid+"&ayear="+yer+"&amonth="+mnth+"&aday="+dy;
	window.location.href = aURL;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}