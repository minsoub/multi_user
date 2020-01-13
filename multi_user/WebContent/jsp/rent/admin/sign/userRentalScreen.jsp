<%@page import="kr.co.neodreams.multi_user.common.CommonUtil"%>
<%@page import="kr.co.neodreams.multi_user.common.NeoUtil"%>
<%@page import="kr.co.neodreams.multi_user.common.DateUtil"%>
<%@ include file="/resource/common/include/common.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>멀티미디어 장비대여 반납 시스템</title>     
<link rel="stylesheet" href="/resource/common/css/sign.css" />
<script type="text/javascript" src="/resource/common/js/jquery-1.9.1.js"></script>
<script src="/resource/common/js/jSignature.js"></script>
<script src="/resource/common/js/jquery-printThis.js"></script>
<script src="/resource/common/js/ie-touch.js"></script>
<style type="text/css">
#signature {
  -ms-touch-action: none;
  touch-action: none;
}

</style>  
</head>
<body>
<div id="top">
    <div class="logo"></div>
    <h1 class="main_tit">멀티미디어 장비 대여/반납 서비스</h1>                 
    <div class="time"><%= NeoUtil.getDateTmFormat(DateUtil.getCurrentDate(), "-", "3") %> <%= CommonUtil.getWeekKor(CommonUtil.getWeek(DateUtil.getCurrentDate())) %> <font id="clock" style="color: #fffc00;font-size: 29px;"></font></div>
</div>

<!-- div standby start -->
<div name="div_standby" style="display: none;">
	<div class="main01">
        <div class="text01"><img src="/resource/images/sign/text_01.png"></div>
    </div>
</div>
<!-- div standby end-->

<!-- div tagging start -->
<div name="div_tag" style="display: none;">
	<div class="main01">
        <div class="ursText02"><img src="/resource/images/sign/text_02.png"></div>
    </div>
</div>
<!-- div tagging end-->

<!-- div identify start -->
<div name="div_identify" style="display: none;">
	<div class="main01">
        <div class="ursText02"><img src="/resource/images/sign/text_11.png"></div>
    </div>
</div>
<!-- div identify end-->

<!-- div rentalList start -->
<div name="div_rentalList" style="display: none;">
	<div id="main">
		<div class="text03"><img src="/resource/images/sign/text_10.png"></div>
       <div class="box" style="padding-top:60px;">
        <div style="width:1630px; height:540px; padding-left:70px; overflow:auto; overflow-x:hidden; ">
          <table class="table-view">
				<colgroup>
					<col style="width: 15%" class="no-td">
					<col style="width: 20%">
					<col style="width: 20%" class="date-td">
					<col style="width: 15%" class="ref-td">
					<col style="width: 8%" >
				</colgroup>
				<thead>
					<tr>
						<th scope="col" class="no-td">신청번호</th>
						<th scope="col" class="like-td">대여장비</th>
						<th scope="col" class="like-td">대여기간</th>
						<th scope="col" class="date-td">신청일</th>
						<th scope="col" class="like-td">상태</th>
					</tr>
				</thead>
				<tbody>						
					<c:forEach var="userRentList" items="${userRentList}" varStatus="x">
					<tr>
						<td align="center">${userRentList.APPNUM}</td>
						<td align="center">${userRentList.GBNM}</td>
						<td align="center">${fn:substring(userRentList.STRDT,0,4)}.${fn:substring(userRentList.STRDT,4,6)}.${fn:substring(userRentList.STRDT,6,8)} ~ ${fn:substring(userRentList.ENDDT,0,4)}.${fn:substring(userRentList.ENDDT,4,6)}.${fn:substring(userRentList.ENDDT,6,8)}</td>						
						<td align="center">${fn:substring(userRentList.REGDT,0,4)}.${fn:substring(userRentList.REGDT,4,6)}.${fn:substring(userRentList.REGDT,6,8)}</td>
						<td align="center">${userRentList.STATUSSTR}</td>
					</tr>
					</c:forEach>
					<c:if test="${fn:length(userRentList) == 0}">
					<tr>
						<td align="center" colspan="5">등록된 데이터가 없습니다.</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		</div>	
       </div>
   </div>
</div>
<!-- div rentalList end-->

<!-- div signature start -->
<div name="div_signature" style="display: none;">
	<div id="main">
	    <div class="text03"><img src="/resource/images/sign/text_07.png"></div>
	    <div class="signaturebox" style="padding-top:60px">
	    	<div id="signature" class="sign_opacity" style="padding-top: 0px;"></div>
	    	<div id="sign_comment" class="signature_text">정자체 서명 후 하단의 확인 버튼을 터치 하세요</div>
	    </div>
	    <div class="btn03">
	        <a href="javascript:;" onclick="javascript:sendSignImgData();"><img src="/resource/images/sign/btn_07.png"></a>  
	        <span style="margin-right: 20px;"></span>
	        <a href="javascript:;" onclick="javascript:funResetSign();"><img src="/resource/images/sign/btn_08.png"></a>
	    </div>
	</div>
</div>
<!-- div signature end-->

<!-- div confirm start -->
<div name="div_confirm" style="display: none;">
	<div id="main">
		<div class="text03"><img src="/resource/images/sign/text_07.png"></div>
		<div class="box" style="padding-top:60px;">
		    <div id="print_div" style="box-sizing: border-box;padding: 0; margin-top:50px; margin-left:230px; width:1203px;">
		          <table style="border-collapse: collapse;table-layout: auto;border: 3px solid #ac7a61;font-size: 13px;margin: 0px;width: 100%;height:500px;">           
		          <colgroup>
		               <col class="" width="13%" />
		               <col class="">
		          </colgroup>   
		              <tr>
		                  <th style="height: 20px;background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;color: #4c2f22;">신청인</th>
		                  <td style="height: 20px;background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;color: #414141;padding: 7px 10px;" colspan="5">${view.appss} <span style="color: blue;font-weight: bold;">${view.appenm }</span> 님</td>
		              </tr>           
		              <tr>
		                  <th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">장비목록</th>
		                  <td colspan="5" style="padding: 0px 0px;background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;">             
		                  	<table style="margin-left:9px;width:100%;table-layout: fixed;">
			                  <c:forEach var="list" items="${modelList }" varStatus="sts">
			                  	<tr>
			                  		<c:if test="${!sts.last }">
				                  		<td style="border-right: 0;">
				                  	</c:if>
				                  	<c:if test="${sts.last }">
				                  		<td style="border-bottom: 0;border-right: 0;">
				                  	</c:if>
			                  	${list.gbnm }
			                  		<c:choose>
										<c:when test="${view.status eq '1' && view.status eq '3' }">
											(${list.mdnm })
										</c:when>
										<c:otherwise>
											<span>(${list.mdnm })</span>
										</c:otherwise>
									</c:choose> 수량 <span style="color: red;font-weight: bold;"><c:out value="${list.amount} / ${list.assignedAmount}" /></span>대
									<%-- 화면 넘쳐서 주석처리. 최종적으로 스크린샷 뜰때 스크롤 발생 문제가 생김 
									배정 <c:forEach var="asMap" items="${assignedMap }" varStatus="vsts">
										<c:if test="${vsts.index eq sts.index }">
											<c:forEach var="v" items="${asMap.value }" varStatus="vsts">
												${v.eqnm }<br>${v.eqalias}
											</c:forEach>
										</c:if>
									</c:forEach>
									 --%>
									</td>
								</tr>
			                  </c:forEach>
			              	</table>
		                  </td>
		              </tr>
		              <tr>
		                  <th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">대여기간</th>
		                  <td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" colspan="5">
		                  	<fmt:parseDate value="${view.strdt}" var="parseStrdt" pattern="yyyyMMdd" />
							<fmt:parseDate value="${view.enddt}" var="parseEnddt" pattern="yyyyMMdd" />
							<fmt:formatDate value="${parseStrdt}" pattern="yyyy년 MM월 dd일" />
							~
							<fmt:formatDate value="${parseEnddt}" pattern="yyyy년 MM월 dd일" /> <!-- (<span class="red">2</span>일) -->
						 </td>
		              </tr>
		              
		              <c:if test="${view.status eq '3' && view.approval eq '2'}">
			              <tr>
			              	<th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">인수자</th>
			              	<td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" id="insunm" colspan="1"></td>
			              	<th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">인수일</th>
			              	<td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" colspan="2" id="insudt"></td>
			              </tr>
					  </c:if>
		              <c:if test="${view.status eq '4' && view.approval eq '2'}">
			              <tr>
			              	<th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">반납자</th>
			              	<td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" id="banpnm"></td>
			              	<th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">반납일</th>
			              	<td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" id="banpdt"></td>
			              	<th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">반납처리</th>
			              	<td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" id="banpst"></td>
			              </tr>
					  </c:if>
					  <tr id="bigo_tr">
					  	<th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">특이사항</th>
					  	<td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" id="bigo" colspan="5"></td>
					  </tr>
					  <tr>
					  	<th style="background-color: #fff6f2;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;line-height: 1;height: 50px;color: #4c2f22;">서명</th>
					  	<td style="background-color: #fff;border-bottom: 1px solid #ac7a61;border-right: 1px solid #ac7a61;height: 50px;color: #414141;padding: 7px 10px;" colspan="5"><font id="act_name"></font><img id="sign_img_data_complete" style="width:177px;height:100px;vertical-align: middle;margin:0;margin-left: 15px;">(인)</td>
					  </tr>
		          </table> 
			</div>
		</div>
	</div>
</div>
<!-- div confirm end-->

<!-- div finish start -->
<div name="div_finish" style="display: none;">
	<div class="main01">
        <div class="ursText02"><img src="/resource/images/sign/text_09.png"></div>
    </div>
</div>
<!-- div finish end-->

<div id="alert_popup" class="popup_box_layer" style="display: none;">
	<div class="popup_box">
		<p class="popup_title"><span id="markTitle">대여/반납 서비스 알림</span></p>	
	    	<div class="popup_con">
				<p id="alert_msg"></p>				
			</div>                 
		<p class="marker_bottom_btn">
			<span class="white al_c" id="rfid_btn" style="width:100%;display: none;" onClick="javascript:$('#alert_popup').hide();$('#rfid_btn').hide();funRFIDConnector();">재시도</span>
			<span class="white al_c" id="etc_btn" style="width:100%;display: none;" onClick="javascript:$('#alert_popup').hide();$('#etc_btn').hide();">확인</span>
	    </p>                      
	</div>
</div> 

<input type="text" id="empno" name="empno" style="z-index:-1; width: 0; height: 0; border:0;" />
<input type="text" id="appno" name="appno" style="z-index:-1; width: 0; height: 0; border:0;" value="${appno}" />
<input type="text" id="status" name="status" style="z-index:-1; width: 0; height: 0; border:0;" value="${view.status}" />
<input type="hidden" id="popupstatus" name="popupstatus" />

<script>
var $sigdiv;

$(document).ready(function(){	
	printClock();
	var _open = location.search.split('?')[1];
	
	showScreen(_open);
	
	setInterval("popopstatus()", 5000);
});

$(window).on('resize', function() {
	if(screen.width === window.innerWidth && screen.height === window.innerHeight){ 	
		//RFID 태그 실행
		funRFIDConnector();
	}
});

$("#empno").on("input", function() {
	var _empno = $('#empno').val();
	if (_empno.length == 8) {
		
		$("#rfid_empno", opener.document).val(_empno);
		openerSearch();
	}	
});

function openerSearch(){
   //RFID 에서 가져온 사번 또는 대리인이 입력한 신청자 사번 정보로 부모창 조회를 시도한다
   if($("input[name=sch_text]", opener.document).val() != undefined){
	   $("input[name=sch_text]", opener.document).val($('#empno').val());
	   	   
	   opener.recList();
	   showScreen('identify');
	   showRentList();
	   return true;
   }else{
	   //이 오류는 관리자가 접수현황 또는 금일접수현황이 아닌 다른 페이지를 열어둔 경우
	   $('#alert_popup').show();
	   $('#alert_msg').text('[4049]관리자에게 문의하세요.');
   
	   return false;
   }
}
 
function printClock() {
    
    var currentDate = new Date();                                     // 현재시간
    var calendar = currentDate.getFullYear() + "-" + (currentDate.getMonth()+1) + "-" + currentDate.getDate() // 현재 날짜
    var amPm = '오전'; // 초기값 AM
    var currentHours = addZeros(currentDate.getHours(),2); 
    var currentMinute = addZeros(currentDate.getMinutes() ,2);
    var currentSeconds =  addZeros(currentDate.getSeconds(),2);
    
    if(currentHours >= 12){ // 시간이 12보다 클 때 PM으로 세팅, 12를 빼줌
    	amPm = '오후';
    	currentHours = addZeros(currentHours - 12,2);
    }

    $('#clock').text(amPm + " " + currentHours+":"+currentMinute+":"+currentSeconds);
    
    setTimeout("printClock()",1000);         // 1초마다 printClock() 함수 호출
}

function addZeros(num, digit) { // 자릿수 맞춰주기
	  var zero = '';
	  num = num.toString();
	  if (num.length < digit) {
	    for (i = 0; i < digit - num.length; i++) {
	      zero += '0';
	    }
	  }
	  return zero + num;
}

function showScreen(val){	
	var _val = val.split('&');
	
	var _name = "div_" + _val[0];
	$("div[name^=div_]").each(function() {	
		
		if (_name == $(this).attr('name')) {
			$(this).show();
		} else {
			$(this).hide();
		}
		
	});
	
	var _str;
	
	if(_val[0] == 'tag'){
		//RFID 태그 실행
		funRFIDConnector();
		_str = 'RFID 태그';
	} else if (_val[0] == 'standby') {
		_str = '사용자 대기';
	} else if (_val[0] == 'rentalList') {
		_str = '장비대여내역';
	} else if (_val[0] == 'signature') {
		$sigdiv = $("#signature").jSignature({width:1533, height: 480});
		_str = '서명';
		$("#appno").val(_val[1]);
		var _status = _val[2].split('=');
		
		$("#status").val(_status[1]);
	} else if (_val[0] == 'confirm') {
		opener.getInfomation();
		
		sendMail();
		
		//출입자 등록
		accessEnter();
	
	} else if (_val[0] == 'finish') {
		_str = '완료';
		setTimeout(function(){
			location.replace('/jsp/rent/admin/sign/userRentalScreen.jsp?standby');	
		}, 5000);
	}
	
	$("#userscreen", opener.document).html(_str);
	$('#popupstatus').val(_str);
}



function popopstatus() {
	$("#userscreen", opener.document).html($('#popupstatus').val());
}

function funRFIDConnector(){
	$('#empno').val('');
	$('#empno').focus();
}


function mouseCursorMove(){	
	$.ajax({
       url: "/jsp/rent/admin/sign/mouseCursorMove.jsp",
       type: "POST",
       dataType: "json",
       success: function(msg) {
    	   
       }
	});
}

$('#signature').onmousedown = function () {
	
    var
      handler = {
        handleEvent: function (e) {
          this[e.type](e);
        },
        touchstart: function (e) {
          var div = e.currentTarget,
              touch = e.touches[0];
          e.preventDefault();
          e.currentTarget.textContent = 'start';
          this.diffY = touch.pageY - parseFloat(div.style.top || 60);
          this.diffX = touch.pageX - parseFloat(div.style.left || 60);
        },
        touchmove: function (e) {
          var div = e.currentTarget,
              touch = e.touches[0];
          e.preventDefault();
          div.textContent = 'move';
          div.style.top = (touch.pageY - this.diffY) + 'px';
          div.style.left = (touch.pageX - this.diffX) + 'px';
        },
        touchend: function (e) {
          e.preventDefault();
          e.currentTarget.textContent = 'end';
        },
        touchcancel: function (e) {
          e.preventDefault();
          e.currentTarget.textContent = 'cancel';
        }  
      }
    ;
    Object.keys(handler).forEach(function (key) {
      this.addEventListener(key, handler);
      //this['on' + key] = function(e){handler.handleEvent(e)};
      console.log('a');
    }, document.querySelector('#signature'));
};

function funResetSign(){
	$sigdiv.jSignature("reset");
	
	$('#sign_comment').show();	
}

function sendSignImgData(){	
	var sign_data = $sigdiv.jSignature('getData', 'default');
	
	if($('#sign_comment').css('display') != 'block'){
		opener.syncSignature(sign_data);
		$('#sign_img_data_complete').attr('src',sign_data);//화면리프레쉬되면서 사라짐.
		
		showSignConfirm();		
	}else{
		$('#alert_popup').show();
		
		return false;
	}	
}

function accessEnter() {
	$.ajax({
	       url: "/admin/accessEnter.do",
	       type: "POST",
	       data: {'appno' : $('#appno').val()},
	       dataType: "json",
	       success: function(msg) {	    	   
	       }
	});
}

 function showRentList() {
	window.location.href = "/admin/userRentList.do?rentalList&empno="+ $('#empno').val();
 }
 
 function showSignConfirm() {
	 window.location.href = "/admin/signConfirm.do?confirm&"+ $('#appno').val();
 }
 
 function sendMail(){
	var mail_form = '<!DOCTYPE html>\n'
					+ '<html>\n'
					+ '<head>\n'
					+ '<meta charset="euc-kr" />\n'
					+ '<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />\n'
					+ '<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, minimal-ui" />\n'
					+ '<title>멀티미디어 장비대여 반납 시스템</title>\n'
					+ '</head>\n'
					+ '<body style="box-sizing: border-box;padding: 0;margin: 0;font-size: 100%;font-family:sans-serif;height: 100%;">\n'
					+ $('#print_div').html() + '\n'
					+ '</body>\n</html>';

	//url: "http://media.hq:8080/admin/saveImgSendMail.do",
	$.ajax({
	       url: "/admin/saveImgSendMail.do",
	       type: "POST",
	       data: {'appno' : $('#appno').val()
	    	   		, 'mail_form' : mail_form
	    	   		, 'status' : $("#status").val()},
	       dataType: "json",
	       success: function(msg) {	    	   
	       }
	});
}
</script>
</body>
</html> 