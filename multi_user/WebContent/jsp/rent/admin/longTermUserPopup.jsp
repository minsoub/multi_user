<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<style>
.sms_text_tit input{padding:2px 5px 0 12px; width:193px; height:30px; border:none; background:url(/resource/images/bg_sms_text_tit_on.gif) no-repeat left top;}
.sms_text_tit input:disabled {width:193px; background:url(/resource/images/bg_sms_text_tit_off.gif) no-repeat left top;}
.sms_inputBox {padding:5px 0 0; background:url(/resource/images/bg_sms_txtTop.gif) no-repeat left top}
.sms_inputBox .sms_msgInput {padding:10px 15px 0px; width:178px; border-left:1px solid #c5c5c5; border-right:1px solid #c5c5c5; background:#fff;}
.sms_inputBox .sms_msgInput textarea {padding:0;width:178px; height:108px;}
.sms_inputBox .sms_txt_num {padding:0 0 5px; background:#fff url(/resource/images/bg_sms_txtBottom.gif) no-repeat left bottom}
.sms_inputBox .right {padding:10px 10px 2px; width:188px; border-left:1px solid #c5c5c5; border-right:1px solid #c5c5c5; background:#fff;}
.sms_inputBox span{display:block;text-align:right;}
.txtBtnArea {padding-top:14px; padding:14px 0 0 26px;}
.txtBtnArea .inner {background:none; text-align:center;}
.txtBtnArea .inner button + button {width:115px; padding-left:20px;}
.email_text_tit input{width:405px;}
p.groove {width: 407px; border-style: groove;}
.email {position: absolute; margin-left: 300px; margin-top: -265px;}
}

</style>
<body>
      <div class="contents-framebox" id="contents_id">
            <!--content-->
            <div id="popup" style="width:700px; padding: 20px;">
	            <div class="sms">
	            <form id="frm_sms" name="frm_sms" method="post">
	            <div class="sub-nav-title" style="margin-top: 5px;">SMS 보내기</div>
					<div class="sms_text_tit">
						<input type="text" id="title_sms" name="title_sms" value="제목을 입력하세요." title="sms 전송제목 입력">
					</div>
					<div class="sms_inputBox">
						<div class="sms_msgInput">
							<textarea name="inputsms" id="inputsms" rows="5" cols="16" onkeyup="focusArea='inputsms';chksizeAndAutoLMS(this);" onmouseup="focusArea='inputsms';chksizeAndAutoLMS(this);" title="sms내용 입력"></textarea>
						</div>
						<div class="sms_txt_num">
							<span class="right" id="msgSizeDiv"><strong class="point">0</strong>/90byte</span>
						</div>
					</div>		
					<p class="txtBtnArea">
						<input type="button" style="cursor: pointer; width: 70px;" onclick="javascript:clearMsgBox();" class="search_btn" value="새로쓰기">
						<input type="button" style="cursor: pointer; width: 75px;" onclick="javascript:sendToSMS();" class="search_btn" value="SMS 전송">
					</p>
					<input type="hidden" id="userdata_sms" name="userdata_sms">
				</form>
				</div>
				
				<div class="email">
				<form id="frm_email" name="frm_email" method="post">
				<div class="sub-nav-title" style="margin-top: 5px;">이메일 보내기</div>
					<div class="email_text_tit">
						<p class="groove">
							<input type="text" id="title_email" name="title_email" value="제목을 입력하세요." title="이메일 전송제목 입력">
						</p>
					</div>
					<div class="email_inputBox">
						<div class="email_msgInput">
							<p class="groove">
								<textarea name="input_email" id="input_email" rows="8" cols="65" title="이메일 내용 입력" style="width:407px; border: 1;"></textarea>
							</p>
						</div>
						<div class="email_txt_num"></div>
					</div>		
					<p class="txtBtnArea">
						<input type="button" style="cursor: pointer; width: 70px;" onclick="javascript:sendToEmail();" class="search_btn" value="메일 전송">
					</p>
					<input type="hidden" id="userdata_email" name="userdata_email">
				</form>
				</div>
			</div>
            <!--content end-->
            <div id="loading" style="display:none; position:absolute; top:120px; text-align:center; width:100%;"><img src="/resource/images/sub/ajax_loading.gif" /></div>
      </div>
</body>

<script type="text/javascript">
var lstmsgtype="SMS";

if ($(window).height() != $("#popup").outerHeight()) {
    setTimeout(function(){
    	$(document).attr("overflow-x","auto");
    	$(document).attr("overflow-y","auto");

    	var wrapWidth = $("#popup").outerWidth();
    	var wrapHeight = $("#popup").outerHeight();

    	var w1 = $(window).width();
    	var h1 = $(window).height() - 30;

    	// 크롬의 문제로 W, H 값을 따로 설정
    	window.resizeBy(wrapWidth - w1, wrapHeight-h1);
    	//window.resizeBy(wrapWidth- w1, 0);
    	//window.resizeBy(0, wrapHeight - h1);
    	//창 크기 자동 조절 E
    	
    }, 100);
    $(window).focus();
}

function sendToSMS() {
	$('#loading').fadeIn();
	var data = $("#user_data", opener.document).val();
	$("#userdata_sms").val(data);
	
	var formData = $("#frm_sms").serialize();
	
	$.ajax({
		url : '/admin/longTermUserSms.do',
		type : 'post',
		data : formData,
		success : function(data) {
			$('#loading').fadeOut();
			if(data == 'OK')
			{
				alert('모든 사용자에게 SMS 전송 완료 되었습니다.');
			}
		}
	}); 
}

function sendToEmail() {
	$('#loading').fadeIn();
	var data = $("#user_data", opener.document).val();
	$("#userdata_email").val(data);
	
	var formData = $("#frm_email").serialize();
	
	$.ajax({
		url : '/admin/longTermUserEmail.do',
		type : 'post',
		data : formData,
		success : function(data) {
			$('#loading').fadeOut();
			if(data == 'OK')
			{
				alert('모든 사용자에게 이메일 전송 완료 되었습니다.');
			}
		}
	}); 
}

function clearMsgBox(){
	document.getElementById("inputsms").value = "";
	document.getElementById("inputsms").focus();
	document.getElementById("msgSizeDiv").innerHTML="<strong class='point'>0</strong>/90byte";
}


function getMaxByte() {
	var permission = "Y";
	if (permission=="Y") {return 90;}
}

function chksizeAndAutoLMS(t) {
	var tmpVal = t.value;
	if(lstmsgtype == 'URL'){
		tmpVal = document.getElementById("inputsms").value + document.getElementById("inputurl").value;
	}
	chksizeRealAndAutoLMS(t,tmpVal,getMaxByte());
}

function chksizeRealAndAutoLMS(t,val,maxcount) {
	var maxcount = maxcount-0;
	var inputForm = document.inputMessageForm;
	var tempi1=0;
	var tempi2=0;
	var byteIs=0;
	var prtmaxcount = maxcount-0;
	var disLmsFlag = false;
	if (val=="") {
		document.getElementById("msgSizeDiv").innerHTML="<strong class='point'>"+byteIs+"</strong>/"+prtmaxcount+"byte";	
	} else {
		for (i=0;i<val.length;i++) {
			tmp = val.charAt(i);
			escChar = escape(tmp);
			if (escChar=='%0D') {
			} else if (escChar.length > 4) {
				byteIs += 2;
			} else if (tmp == '·') { //2바이트 문자처리
				byteIs += 2;
			} else {
				byteIs += 1;
			}
			if (byteIs>maxcount) {break;}
			if (byteIs==(maxcount-1)) {tempi1 = i+1;}
			if (byteIs==maxcount) {tempi2 = i+1;}
		}

		if (byteIs>maxcount) {
			if (maxcount >= getMaxByte()) {
				alert(maxcount+' Byte 를 초과하실 수 없습니다.');
			}
			
			if (tempi2>0) {tmpval = t.value.substr(0,tempi2);byteIs=maxcount;}
			else {tmpval = t.value.substr(0,tempi1);byteIs=(maxcount-1);}
			t.value = tmpval;
			document.getElementById("msgSizeDiv").innerHTML="<strong class='point'>"+byteIs+"</strong>/"+prtmaxcount+"byte";				
		} else {
			document.getElementById("msgSizeDiv").innerHTML="<strong class='point'>"+byteIs+"</strong>/"+prtmaxcount+"byte";				
		}
	}
}
</script>
