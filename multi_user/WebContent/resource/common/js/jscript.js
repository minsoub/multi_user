function tv_show(radio_sel) { // 실시간  TV
 open("/live/onair.asp?radio_sel="+radio_sel,"tv","toolbar=no,location=no,directories=no, status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width=555,height=370")
}
function radio_show(x) { // 실시간  RADIO
open("/popup/radio.asp?radio_sel="+x+"","radio","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,copyhistory=no,width=550,height=200");
}
function mysearch(object)
{
   if(object.SearchString.value=="")
   {
     alert("검색어를 넣어주세요");
     object.SearchString.focus();
     return;
   }

   object.submit();
}

// 사원 정보 보여주기  시작
// 2008.4.11(금) ivory.hq 도메인을 serv.kepco.co.kr 로 변경 적용. 파워넷 신칠승(님)/3429-6932
 	var IE5 = (document.all && document.getElementById) ? true : false;
	overdiv="0";
	var prediv
	function popLayer(user_id){
			var div_width=187;
			var div_height=140;

			if ( !IE5 ) return;
			linkdiv = document.all.infobox;
			if(!linkdiv) return;
			
			linkdiv.style.width=div_width;
			linkdiv.style.height=div_height;
			user_info.location.href="http://serv.kepco.co.kr/USER_INFO/user_info_new.php?user_id="+user_id;

			if (prediv) prediv.style.visibility  = "hidden";
			prediv = linkdiv;

			var divwidth = document.getElementById("infobox").all[0].clientWidth;
			var divheight = document.getElementById("infobox").all[0].clientHeight;			

			var xpos = x+12;
			if ( xpos < 10 ) xpos = 10;
			var ypos = y-5;

			//인포박스 왼쪽 삐져나옴 방지
			if (document.body.scrollLeft > xpos) xpos = document.body.scrollLeft + 10;
			//인포박스 우측 삐져나옴 방지
			if (document.body.scrollLeft + document.body.clientWidth < xpos + divwidth) xpos = document.body.scrollLeft + document.body.clientWidth - divwidth;
			//인포박스 하단 삐져나옴 방지
			if (document.body.scrollTop + document.body.clientHeight < ypos + divheight) {
				//인포박스 상단 삐져나옴 방지
				//if (document.body.scrollTop < ypos-divheight-27) 
				ypos = ypos-divheight;
				if (document.all.adsquare) {
					if ( xpos+divwidth > adpos - 340 && ypos < 600 ) {
						ypos = ypos+divheight+27;
					}
				}
			}

			linkdiv.style.pixelLeft = xpos;
			linkdiv.style.pixelTop = ypos-5;
			linkdiv.style.visibility  = "visible";
	}
	function hideLayer(){
		linkdiv = document.all.infobox;
		if(!linkdiv) return;

		if (overdiv == "0") {
			linkdiv.style.visibility = "hidden";
			user_info.location.href="http://serv.kepco.co.kr/USER_INFO/user_infom.php";
		}
	}

	var isNav = (navigator.appName.indexOf("Netscape") !=-1);
	function handlerMM(e){
		x = (isNav) ? e.pageX : event.clientX + document.body.scrollLeft;
		y = (isNav) ? e.pageY : event.clientY + document.body.scrollTop;
	}
	if (isNav){document.captureEvents(Event.MOUSEMOVE);}
	document.onmousemove = handlerMM;

	function showinfo(user_id)
	{
		popLayer(user_id);	
	}
 
// 사원 정보 보여주기  끝


function na_open_window(name, url, left, top, width, height, toolbar, menubar, statusbar, scrollbar, resizable)
{ // 플레이어 open창 열기
  toolbar_str = toolbar ? 'yes' : 'no';
  menubar_str = menubar ? 'yes' : 'no';
  statusbar_str = statusbar ? 'yes' : 'no';
  scrollbar_str = scrollbar ? 'yes' : 'no';
  resizable_str = resizable ? 'yes' : 'no';
  window.open(url, name, 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);
}

function Check_Form() { // 한줄댓글 등록화면
var form   = document.form1;

if (form.k_id.value == "") {
	    alert("아이디가 없습니다.\n\nhttp://media.hq로 접속을 하시거나\n\n http://powernet.hq Top메뉴 [멀티미디어]로 접속하시면 등록이 가능 합니다.");
	    form.k_id.focus();
	   return;
	  }
if (form.k_id == "") {
	    alert("아이디가 없습니다.\n\nhttp://media.hq로 접속을 하시거나\n\n http://powernet.hq Top메뉴 [멀티미디어]로 접속하시면 등록이 가능 합니다.");
	    form.k_id.focus();
	   return;
	  }
if (form.k_title.value == "") {
	    alert("내용을 입력해주세요");
	    form.k_title.focus();
	   return;
	  }

document.form1.submit();
//	return true;
}

function k_edit(k_id,k_title,k_num){
document.form1.k_id.value = k_id ;
document.form1.k_title.value = k_title ;
document.form1.f_mode.value = "edit" ;
document.form1.k_num.value = k_num ;
}
function k_del(f_num,k_num){//내부 고객의 소리 삭제
if (confirm(" 삭제버튼을 클릭하셨습니다. \n\n삭제를 원하시면 확인 버튼을 클릭하세요"))
location.href="../del.asp?f_num="+f_num+"&k_num="+k_num ;
else
	     alert(" 취소하셨습니다.");
}
function textCounter(field,cntfield,maxlimit) {
		if (field.value.replace(/[\n\r\n]/g,'  ').length > maxlimit){
			 // if too long...trim it!
			field.value = field.value.substring(0, maxlimit-(field.value.replace(/[\n\r\n]/g,'  ').length-field.value.length));
			}
		// otherwise, update 'characters left' counter
		else
			cntfield.value = maxlimit - field.value.replace(/[\n\r\n]/g,'  ').length;
	}

function storeCaret (textEl)
	{	if (textEl.createTextRange)
		{	textEl.caretPos = document.selection.createRange().duplicate();
		}
	}


function msgset(str){
	var text
	text ='<table border="0" cellpadding="6" cellspacing="0"  bgcolor="#E7E7E7" style="font-size:9pt; border-width:1; border-color:black; border-style:solid; word-break:break-all;">'
	text += '<tr><td><br><b>제 목 : </b>' + str + '</td></tr></table>'
	message.innerHTML=text
	}
function msgposit(){
	//message.style.posLeft = event.x + 40 + document.body.scrollLeft
	message.style.posLeft = 300
	message.style.posTop = event.y - -10 + document.body.scrollTop
	}
function msghide(){
	message.innerHTML=''
}

function msgset_photo(str){
	var text
	text ='<table border="0" cellpadding="6" cellspacing="0"  bgcolor="#E7E7E7" style="font-size:9pt; border-width:1; border-color:black; border-style:solid; word-break:break-all;">'
	text += '<tr><td><br><b>제 목 : </b>' + str + '</td></tr></table>'
	message.innerHTML=text
	}
function msgposit_photo(flag){
	//message.style.posLeft = event.x + 40 + document.body.scrollLeft
	if (flag == 1)
	{
		message.style.posLeft = 670
		message.style.posTop = event.y - -10 + document.body.scrollTop
	}else if(flag == 2){
		message.style.posLeft = 350
		message.style.posTop = event.y - -10 + document.body.scrollTop
	}
}
function msghide_photo(){
	message.innerHTML=''
}

function msgset_movie(str){
	var text
	text ='<table border="0" cellpadding="6" cellspacing="0"  bgcolor="#E7E7E7" style="font-size:9pt; border-width:1; border-color:black; border-style:solid; word-break:break-all;">'
	text += '<tr><td><br><b>제 목 : </b>' + str + '</td></tr></table>'
	message.innerHTML=text
	}
function msgposit_movie(){
	message.style.posLeft = event.x + 20 + document.body.scrollLeft
	//message.style.posLeft = 250
	message.style.posTop = event.y - -10 + document.body.scrollTop
	}
function msghide_movie(){
	message.innerHTML=''
}
function b64EncodeUnicode(str) {
    return btoa(encodeURIComponent(str).replace(/%([0-9A-F]{2})/g, function(match, p1) {
        return String.fromCharCode('0x' + p1);
    }));
}
function b64DecodeUnicode(str) {
    return decodeURIComponent(atob(str).split('').map(function(c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));
}




