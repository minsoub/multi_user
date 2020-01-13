<%@page import="kr.co.neodreams.multi_user.common.CommonUtil"%>
<%@page import="kr.co.neodreams.multi_user.common.NeoUtil"%>
<%@page import="kr.co.neodreams.multi_user.common.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*"%>
<% response.setHeader("X-UA-Compatible", "IE=Edge"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, minimal-ui" />
<title>멀티미디어 장비대여 반납 시스템</title>     
<link rel="stylesheet" href="/resource/common/css/sign.css" />
<script type="text/javascript" src="/resource/common/js/jquery-1.9.1.js"></script>
</head>
<body>
<form id="frm" name="frm" onsubmit="return false;">
<input type="text" id="empno" name="empno" style="position:absolute;z-index:-1; width: 0; height: 0;" />
<input type="hidden" id="now_page" name="now_page" value="0" />
<input type="hidden" id="outin_gubun" name="outin_gubun" />
</form>
<!-- sign_div 순서는 바뀌면 안됩니다. -->

<div id="top">
    <div class="logo"></div>
    <h1 class="main_tit">멀티미디어 장비 대여/반납 서비스</h1>                 
    <div class="time"><%= NeoUtil.getDateTmFormat(DateUtil.getCurrentDate(), "-", "3") %> <%= CommonUtil.getWeekKor(CommonUtil.getWeek(DateUtil.getCurrentDate())) %> <font id="clock" style="color: #fffc00;font-size: 29px;"></font></div>
</div>

<!-- sign_div 0 start -->
<div class="sign_div">   
	<div class="main01">
	    <div class="text01"><img src="/resource/images/sign/text_01.png"></div>
	    <div class="btn01">
	        <a href="javascript:;" onclick="javascript:funDivShow('1');$('#outin_gubun').val('out');$('#out_in_text').text('수령');"><img src="/resource/images/sign/btn_01.png"></a>
	        <span style="margin-left:50px;"></span>
	        <a href="javascript:;" onclick="javascript:funDivShow('1');$('#outin_gubun').val('in');$('#out_in_text').text('반납');"><img src="/resource/images/sign/btn_02.png"></a>
	    </div>
	</div> 
</div>
<!-- sign_div 0 end-->

<!-- sign_div 1 start -->
<div class="sign_div" style="display: none;">
	<div id="main">
        <div class="text02"><img src="/resource/images/sign/text_02.png"></div>
        <div class="btn02">
            <a href="javascript:;" onclick="javascript:funDivShow($('#now_page').val() - 1);"><img src="/resource/images/sign/btn_03.png"></a>
        </div>
    </div>
</div>
<!-- sign_div 1 end-->

<!-- sign_div 2 start -->
<div class="sign_div" style="display: none;">
	<div id="main">
	    <div class="text03"><img src="/resource/images/sign/text_03.png"></div>
	    <div class="box">     
	        <div class="btn01">
	            <a href="javascript:;" onclick="javascript:openerSearch();"><img src="/resource/images/sign/btn_04.png"></a>
	            <span style="margin-left:50px;"></span>
	            <a href="javascript:;" onclick="javascript:funDivShow('3');"><img src="/resource/images/sign/btn_05.png"></a>
	        </div>          
	    </div>
	    <div class="btn03">
	        <a href="javascript:;" onclick="javascript:funDivShow($('#now_page').val() - 1);"><img src="/resource/images/sign/btn_03.png"></a>
	    </div>
	    
	</div>
</div>         
<!-- sign_div 2 end-->

<!-- sign_div 3 start -->
<div class="sign_div" style="display: none;">
	<div id="main">
	    <div class="text03"><img src="/resource/images/sign/text_04.png"></div>
	    <div class="box"> 
	        <div class="formbox">
	            <input type="text" id="regEmpno" name="regEmpno" maxlength="8" placeholder="신청자 사번 입력" >
	            <br/>
	            대리<font id="out_in_text"></font>을 선택하였습니다. <br/>
	            본 시스템을 이용하기 위해서는 사번 입력이 필요합니다 .<br/>
	            사번이 없는 외부 이용자분들은 본 시스템을 <br/>
	            이용하실 수 없으니 양해하여 주시기 바랍니다.<br/>
	        </div> 
	        <div class="number">
	            <table>
	                <tr>
	                    <td><img src="/resource/images/sign/num_01.png" onclick="javascript:funSetRegEmpno('1')"></td>
	                    <td><img src="/resource/images/sign/num_02.png" onclick="javascript:funSetRegEmpno('2')"></td>
	                    <td><img src="/resource/images/sign/num_03.png" onclick="javascript:funSetRegEmpno('3')"></td>
	                </tr>
	                <tr>
	                    <td><img src="/resource/images/sign/num_04.png" onclick="javascript:funSetRegEmpno('4')"></td>
	                    <td><img src="/resource/images/sign/num_05.png" onclick="javascript:funSetRegEmpno('5')"></td>
	                    <td><img src="/resource/images/sign/num_06.png" onclick="javascript:funSetRegEmpno('6')"></td>
	                </tr>
	                <tr>
	                    <td><img src="/resource/images/sign/num_07.png" onclick="javascript:funSetRegEmpno('7')"></td>
	                    <td><img src="/resource/images/sign/num_08.png" onclick="javascript:funSetRegEmpno('8')"></td>
	                    <td><img src="/resource/images/sign/num_09.png" onclick="javascript:funSetRegEmpno('9')"></td>
	                </tr>
	                <tr>
						<td><!-- <img src="/resource/images/sign/num_11.png"> --></td>
	                    <td><img src="/resource/images/sign/num_10.png" onclick="javascript:funSetRegEmpno('0')"></td>
	                    <td><img src="/resource/images/sign/num_12.png" onclick="javascript:funSetRegEmpno('del')"></td>
	                </tr>
	            </table>
	        </div>       
	    </div>
	    <div class="btn03">
	        <a href="javascript:;" onclick="javascript:funRegEmpno();"><img src="/resource/images/sign/btn_06.png"></a>
	        <span style="margin-left:50px;"></span>
	        <a href="javascript:;" onclick="javascript:funDivShow($('#now_page').val() - 1);$('#regEmpno').val('');"><img src="/resource/images/sign/btn_03.png"></a>
	    </div>
	</div>
</div>         
<!-- sign_div 3 end-->

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

<script>
$(document).ready(function(){
	printClock();
});

$("#empno").on("input", function() {
	
	if($('#now_page').val() == '1'
			&& $('#empno').val() != null 
			&& $('#empno').val() != ''
			&& $('#empno').val().length == 8){
		
		funDivShow('2');
		
		$("#rfid_empno", opener.document).val($('#empno').val());
		
		return true;
	}else if($('#now_page').val() == '1' 
			&& $('#empno').val().length == 0){
		//태그 인식 실패는 무조건 재시도로 넘긴다. alert 팝업 사용 안함
		funRFIDConnector();
	}
});
 
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

function funDivShow(val){
	
	$('#now_page').val(val);
	
	$.each($('.sign_div'), function(index){
		if(index == val){
			$(this).show();
		}else{
			$(this).hide();
		}
	});           
	
	if(val == '1'){
		//RFID 태그 실행
		funRFIDConnector();
	}               
}

function funRFIDConnector(){
	
	$('#empno').val('');
	
	$('#empno').focus();
}

function funSetRegEmpno(setNum){

	if(setNum != 'del'
			&& $('#regEmpno').val().length < 8){
		$('#regEmpno').val($('#regEmpno').val() + setNum);
	}else if(setNum == 'del' 
			&& $('#regEmpno').val().length > 0){
		$('#regEmpno').val($('#regEmpno').val().substring(0, $('#regEmpno').val().length -1));
	}
}

function funRegEmpno(){
	
	if($('#regEmpno').val() != null 
			&& $.trim($('#regEmpno').val()) != ''
			&& $.trim($('#regEmpno').val()).length == 8){
		
		$('#empno').val($('#regEmpno').val());
		openerSearch();
		
		mouseCursorMove();
		
		return true;
	}else{
		$('#alert_popup').show();
		$('#etc_btn').show();
		$('#alert_msg').text('사번을 확인하시기 바랍니다.');
		return false;
	}
}

function openerSearch(){
   //RFID 에서 가져온 사번 또는 대리인이 입력한 신청자 사번 정보로 부모창 조회를 시도한다
   if($("input[name=sch_text]", opener.document).val() != undefined){
	   $("input[name=sch_text]", opener.document).val($('#empno').val());
	   
	   var outin = $('#outin_gubun').val();
	   
	   //out 반출, in 반입
	   if(outin == 'out'){  
		   $("select[name=sch_status]", opener.document).val("3").attr("selected", "selected");
		   $("select[name=sch_approval]", opener.document).val("2").attr("selected", "selected");		   
	   }else if(outin == 'in'){
		   $("select[name=sch_status]", opener.document).val("4").attr("selected", "selected");
		   $("select[name=sch_approval]", opener.document).val("2").attr("selected", "selected");
	   }
	   
	   mouseCursorMove();
	   
	   opener.recList();
	   
	   return true;
   }else{
	   //이 오류는 관리자가 접수현황 또는 금일접수현황이 아닌 다른 페이지를 열어둔 경우
	   $('#alert_popup').show();
	   $('#etc_btn').show();
	   $('#alert_msg').text('[4049]관리자에게 문의하세요.');
	   
	   mouseCursorMove();
	   
	   return false;
   }
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
</script>
</body>
</html> 