<%@page import="kr.co.neodreams.multi_user.common.CommonUtil"%>
<%@page import="kr.co.neodreams.multi_user.common.DateUtil"%>
<%@page import="kr.co.neodreams.multi_user.common.NeoUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="java.sql.*"%>
<%@ include file="/resource/common/include/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>멀티미디어 장비대여 반납 시스템</title> 
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, minimal-ui" />
<style type="text/css">
#signature {
  -ms-touch-action: none;
  touch-action: none;
}
</style>  
<link rel="stylesheet" href="/resource/common/css/sign.css" />
<script src="/resource/common/js/ie-touch.js"></script>
<!-- this, preferably, goes inside head element: -->
<!--[if lt IE 9]>
<script type="text/javascript" src="flashcanvas.js"></script>
<![endif]-->
<script src="/resource/common/js/jquery-1.9.1.js"></script>
</head>
<body>
<form id="frm" name="frm" method="post">
	<input type="hidden" name="appno" value="${appno}" />
</form>
<div id="top">
    <div class="logo"></div>
    <h1 class="main_tit">멀티미디어 장비 대여/반납 서비스</h1>
    <div class="time"><%= NeoUtil.getDateTmFormat(DateUtil.getCurrentDate(), "-", "3") %> <%= CommonUtil.getWeekKor(CommonUtil.getWeek(DateUtil.getCurrentDate())) %> <font id="clock" style="color: #fffc00;font-size: 29px;"></font></div>
</div>
<div id="retal_detail_div">
    <div id="main">
    	<c:if test="${view.status eq '3' && view.approval eq '2'}">
    		<div class="text03"><img src="/resource/images/sign/text_05.png"></div>
		</c:if>
        <c:if test="${view.status eq '4' && view.approval eq '2'}">
        	<div class="text03"><img src="/resource/images/sign/text_10.png"></div>
        </c:if>
       <div class="box" style="padding-top:60px;">      
          <table class="table-view">           
          <colgroup>
               <col class="" width="15%" />
               <col class="">
          </colgroup>   
              <tr>
                  <th>신청인</th>
                  <td colspan="5">${view.appss} <span class="blue">${view.appenm }</span> 님</td>
              </tr>           
              <tr>
                  <th class="list">장비목록</th>
                  <td colspan="5" style="padding: 0px 0px;">             
                  	<table style="margin-top:-58px; width:100%;table-layout: fixed;">
	                  <c:forEach var="list" items="${modelList }" varStatus="sts">
	                  	<tr>
	                  		<c:if test="${!sts.last }">
		                  		<td style="border-right: 0;">
		                  	</c:if>
		                  	<c:if test="${sts.last }">
		                  		<td  style="border-bottom: 0;border-right: 0;">
		                  	</c:if>
	                  	${list.gbnm }
	                  		<c:choose>
								<c:when test="${view.status eq '1' && view.status eq '3' }">
									(${list.mdnm })
								</c:when>
								<c:otherwise>
									<span>(${list.mdnm })</span>
								</c:otherwise>
							</c:choose> 수량 <span class="red"><c:out value="${list.amount} / ${list.assignedAmount}" /></span>대
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
                  <th>대여기간</th>
                  <td colspan="5">
                  	<fmt:parseDate value="${view.strdt}" var="parseStrdt" pattern="yyyyMMdd" />
					<fmt:parseDate value="${view.enddt}" var="parseEnddt" pattern="yyyyMMdd" />
					<fmt:formatDate value="${parseStrdt}" pattern="yyyy년 MM월 dd일" />
					~
					<fmt:formatDate value="${parseEnddt}" pattern="yyyy년 MM월 dd일" /> <!-- (<span class="red">2</span>일) -->
				 </td>
              </tr>
              
              <c:if test="${view.status eq '3' && view.approval eq '2'}">
	              <tr>
	              	<th>인수자</th>  
	              	<td id="insunm" colspan="2"></td>
	              	<th>인수일</th>
	              	<td colspan="2" id="insudt"></td>
	              </tr>
			  </c:if>
              <c:if test="${view.status eq '4' && view.approval eq '2'}">
	              <tr>
	              	<th>반납자</th>
	              	<td id="banpnm"></td>
	              	<th>반납일</th>
	              	<td id="banpdt"></td>
	              	<th>반납처리</th>
	              	<td id="banpst"></td>
	              </tr>
			  </c:if>
          </table>               
       </div>
       <div class="btn03">
           <a href="javascript:;" onclick="javascript:funShowSign();"><img src="/resource/images/sign/btn_06.png"></a>
           <span style="margin-left: 50px;"></span>
           <a href="javascript:;" onclick="javascript:$('#confirm_popup').show();"><img src="/resource/images/sign/btn_03.png"></a>
       </div>
       <div class="text04"><img src="/resource/images/sign/text_06.png"></div>
   </div>
</div>
<div id="retal_detail_div_sign" style="display: none;">
    <div id="main">
        <c:if test="${view.status eq '3' && view.approval eq '2'}">
    		<div class="text03"><img src="/resource/images/sign/text_05.png"></div>
		</c:if>
        <c:if test="${view.status eq '4' && view.approval eq '2'}">
        	<!-- 이미지 받아서 넣어야 됨 -->          
        	<div class="text03"><img src="/resource/images/sign/text_10.png"></div>
        </c:if>
       <div class="box" style="padding-top:60px;">      
			<div id="print_div">
	          <table class="table-view">           
	          <colgroup>
	               <col class="" width="15%" />
                   <col class="">
                   <col class="" width="1%"/>
	          </colgroup>   
	              <tr>
	                  <th>신청인</th>
	                  <td colspan="5">ICT${view.appss} <span class="blue">${view.appenm }</span> 님</td>
	                  <th>서명</th>
	              </tr>           
	              <tr>
	                  <th class="list">장비목록</th>
	                  <td colspan="5" style="padding: 0px 0px;">             
	                  	<table style="margin-top:-58px; width:100%;table-layout: fixed;">
		                  <c:forEach var="list" items="${modelList }" varStatus="sts">
		                  	<tr>
		                  		<c:if test="${!sts.last }">
			                  		<td style="border-right: 0;">
			                  	</c:if>
			                  	<c:if test="${sts.last }">
			                  		<td  style="border-bottom: 0;border-right: 0;">
			                  	</c:if>
		                  	${list.gbnm }
		                  		<c:choose>
									<c:when test="${view.status eq '1' && view.status eq '3' }">
										(${list.mdnm })
									</c:when>
									<c:otherwise>
										<span>(${list.mdnm })</span>
									</c:otherwise>
								</c:choose> 수량 <span class="red"><c:out value="${list.amount} / ${list.assignedAmount}" /></span>대
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
	                  <td rowspan="2" style="text-align:center">
                           <font id="dept_name"></font>
                           <br/><br/>
                           <span class="blue" id="act_name"></span>
                           <br/><br/>
                           <img id="sign_img_data_complete" style="margin-left:-20px;width:120px;height:70px;">(인)
                       </td>
	              </tr>
	              <tr>
	                  <th>대여기간</th>
	                  <td colspan="5">
	                  	<fmt:parseDate value="${view.strdt}" var="parseStrdt" pattern="yyyyMMdd" />
						<fmt:parseDate value="${view.enddt}" var="parseEnddt" pattern="yyyyMMdd" />
						<fmt:formatDate value="${parseStrdt}" pattern="yyyy년 MM월 dd일" />
						~
						<fmt:formatDate value="${parseEnddt}" pattern="yyyy년 MM월 dd일" /> <!-- (<span class="red">2</span>일) -->
					 </td>
	              </tr>
	              
	              <c:if test="${view.status eq '3' && view.approval eq '2'}">
		              <tr>
		              	<th>인수자</th>
		              	<td id="insunm2" colspan="2"></td>
		              	<th>인수일</th>
		              	<td colspan="3" id="insudt2"></td>
		              </tr>
				  </c:if>
	              <c:if test="${view.status eq '4' && view.approval eq '2'}">
		              <tr>
		              	<th>반납자</th>
		              	<td id="banpnm2" colspan="2"></td>
		              	<th>반납일</th>
		              	<td id="banpdt2"></td>
		              	<th>반납처리</th>
		              	<td id="banpst2"></td>
		              </tr>
				  </c:if>
	          </table>               
	       </div>
		</div>
       <div class="btn03">
		   <a href="javascript:;" onclick="javascript:funPrint();"><img src="/resource/images/sign/btn_10.png"></a>
		   <span style="margin-left: 50px;"></span>
		   <a href="javascript:;" onclick="javascript:funSuccess();"><img src="/resource/images/sign/btn_09.png"></a>
	   </div>
   </div>
</div>

<div id="sign_input_div" style="display: none;">
<div id="main">
    <div class="text03"><img src="/resource/images/sign/text_07.png"></div>
    <div class="box" style="padding-top:60px">
    	<div id="sign_comment" class="sign_text" style="position:absolute;">서명 후 하단의 확인 버튼을 터치 하세요</div>
    	<div id="signature" class="sign" style="padding-top: 0px;"></div>
    </div>
    <div class="btn03">
        <a href="javascript:;" onclick="javascript:sendSignImgData();"><img src="/resource/images/sign/btn_07.png"></a>  
        <span style="margin-right: 20px;"></span>
        <a href="javascript:;" onclick="javascript:funResetSign();"><img src="/resource/images/sign/btn_08.png"></a>
        <span style="margin-right: 20px;"></span>
        <a href="javascript:;" onclick="javascript:$('#confirm_popup').show();"><img src="/resource/images/sign/btn_03.png"></a>
    </div>
</div>
</div>

<div id="success_comment" class="main01" style="display: none;">
    <div class="text01"><img src="/resource/images/sign/text_09.png"></div>
</div>


<div id="alert_popup" class="popup_box_layer" style="display: none;">
	<div class="popup_box">
		<p class="popup_title"><span id="markTitle">대여/반납 서비스 알림</span></p>	
	    	<div class="popup_con">
				<p>서명을 진행해 주세요</p>				
			</div>                 
		<p class="marker_bottom_btn">
			<span class="white al_c" style="width:100%;" onClick="javascript:$('#alert_popup').hide();">확인</span>
	    </p>
	</div>
</div>             


<div id="confirm_popup" class="popup_box_layer" style="display: none;">
	<div class="popup_box">
		<p class="popup_title"><span id="markTitle">대여/반납 서비스 알림</span></p>	
	    	<div class="popup_con" style="line-height: 30px;height: 100px;">
				<p>
					<c:if test="${view.status eq '3' && view.approval eq '2'}">
						장비 대여를 취소하시고<br>메인으로 돌아가시겠습니까?
					</c:if>
					<c:if test="${view.status eq '4' && view.approval eq '2'}">
						장비 반납을 취소하시고<br>메인으로 돌아가시겠습니까? 
					</c:if>
				</p>				
			</div>                 
		<p class="confirm_bottom_btn">
			<span class="white al_c" onClick="javascript:funCancelRent();">네</span>
			<span class="white al_c" onClick="javascript:$('#confirm_popup').hide();">아니오</span>
	    </p> 
    </div>                     
</div>             
<script>
(function($) {
	var topics = {};
	$.publish = function(topic, args) {
	    if (topics[topic]) {
	        var currentTopic = topics[topic],
	        args = args || {};
	
	        for (var i = 0, j = currentTopic.length; i < j; i++) {
	            currentTopic[i].call($, args);
	        }
	    }
	};
	$.subscribe = function(topic, callback) {
	    if (!topics[topic]) {
	        topics[topic] = [];
	    }
	    topics[topic].push(callback);
	    return {
	        "topic": topic,
	        "callback": callback
	    };
	};
	$.unsubscribe = function(handle) {
	    var topic = handle.topic;
	    if (topics[topic]) {
	        var currentTopic = topics[topic];
	
	        for (var i = 0, j = currentTopic.length; i < j; i++) {
	            if (currentTopic[i] === handle.callback) {
	                currentTopic.splice(i, 1);
	            }
	        }
	    }
	};  
})(jQuery);
</script>
<script src="/resource/common/js/jSignature.js"></script>
<script src="/resource/common/js/jquery-printThis.js"></script>
<script type="text/javascript">
var $sigdiv;

$(document).ready(function(){
	opener.setFormValue('user');
	printClock();
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
  
function funShowSign(){
	$('#retal_detail_div').hide();
	$('#sign_input_div').show();
	
  	$sigdiv = $("#signature").jSignature({width:1533, height: 480});       
  	
  	opener.popupFormSync();
}

function funResetSign(){
	$sigdiv.jSignature("reset");
	
	$('#sign_comment').show();
	
	opener.signImageSync('');
}

function sendSignImgData(){
	var sign_data = $sigdiv.jSignature('getData', 'default');
	
	if($('#sign_comment').css('display') != 'block'){
		opener.signImageSync(sign_data);
		
		$('#sign_img_data_complete').attr('src',sign_data);
		
		mouseCursorMove();
	}else{
		$('#alert_popup').show();
		
		return false;
	}
	
}

function funCancelRent(){
	location.replace = "/jsp/rent/admin/sign/sign_popup.jsp";
	opener.popupAdminClose();
}

function funAdminChk(){
	
	$("#insunm2").html($("#insunm").html());
	$("#insudt2").html($("#insudt").html());
	$("#act_name").html($("#insunm").html());
	
	$("#banpnm2").html($("#banpnm").html());
	$("#banpdt2").html($("#banpdt").html());
	$("#banpst2").html($("#banpst").html());
	$("#act_name").html($("#banpnm").html());
	
	$('#retal_detail_div').hide();
	$('#retal_detail_div_sign').show();
	$('#sign_input_div').hide();
	$('#sign_img_data_complete').show();
}	

function funPrint(){
	$("#print_div").printThis();
}

function funSuccess(){
	$('#success_comment').show();
	$('#retal_detail_div').hide();
	$('#retal_detail_div_sign').hide();
	$('#sign_input_div').hide();
	$('#sign_img_data_complete').hide();
	
	mouseCursorMove();
	
	setTimeout(function(){
		location.replace = "/jsp/rent/admin/sign/sign_popup.jsp";
	}, 5000);
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












