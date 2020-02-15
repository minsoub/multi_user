<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/jquery.datetimepicker.css" />
<script type="text/javascript" src="/resource/common/js/jquery.datetimepicker.full.min.js"></script>
<style>
.btn_yellow {
	background-color: #ff9620;
	color: #fff;
	font-size: 14px;
}

.btn_blue {
	background-color: #08A0CE;
	color: #fff;
	font-size: 14px;
	padding: 0px 5px;
}

</style>

<body>
	<div class="topMenu-bg-img-sub"></div>
	<c:import url="/resource/common/include/topMenu.jsp" />
	<c:set value="${menudepth_1}" var="left_depth_1"/>
	<c:set var="isGetAdmin" value="${sessionScope.SESS_USER_INFO['rentAdmin']}"></c:set>
	<div id="contents" class="learn-frame-area">
		<div class="contents-framebox" id="contents_id">
			<!-- leftmenu -->
			<div class="contents-header-framebox">
				<div class="learn-tit-framebox">
					<c:import url="/resource/common/include/leftMenu_01.jsp">
						<c:param name="left_depth_1" value="${menu_depth1}"></c:param>
						<c:param name="left_depth_2" value="${menu_depth2}"></c:param>
					</c:import>
				</div>
			</div>
			<!-- leftmenu end-->

			<!--content-->
			<div class="contents-con-framebox">
				<div class="nav-box">
					<div class="nav-img"><img src="/resource/images/sub/sub2_tit_img.png"></div>
					<div class="nav-list">
						<img src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;서비스요청&nbsp;&nbsp;>&nbsp;&nbsp;${title}&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">촬영요청</b>
					</div>
					<div class="nav-title">${title} <small class="sub2">촬영요청</small></div>					
				</div>
				
				<ul class="tabNav sub5">
					<li><a href="#"  class="active">촬영요청</a></li>
					<li><a href="javascript:goList();">진행사항</a></li>
				</ul>	
			
				<div class="red-f">
					* 촬영요청은 익일부터 가능합니다.<br>
					* 사진은 1인당 5매 이내로 출력 가능합니다.<br>
					* 비자사진의 경우 요청사항에 특이사항 꼭 기입바랍니다.
				</div>
					
				<form id="frm" name="frm" method="post">
				<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo}" />
				<input type="hidden" id="bbsid" name="bbsid" value="${bbsid}" />
				<input type="hidden" id="seq" name="seq" value="0" />	
				<input type="hidden" id="reg_id" name="reg_id" value="${SESS_EMPNO}" />
										
				<div class="insrtfrom-framebox mtSm">			
					<div class="basic-list">
						<div class="insert-step1-box">
							<div class="form-step1">
								<fieldset>
									<legend>제작요청</legend>
									<div class="row-group">
												
									<dl class="insert_ready">
										<dt class="must-option"><label>신청부서</label></dt>
										<dd><input type="text" id="reg_dept_nm" name="reg_dept_nm" value="${SESS_USER_INFO.user_dept_name }" readonly></dd>
										<dt class="must-option"><label>신청자</label></dt>
										<dd class="btn-zone" style="width: 250px;">
											<input type="text" id="reg_nm" name="reg_nm" value="${SESS_USER_NAME}" readonly class="schword" style="width: 40%" >
											<c:if test="${isGetAdmin != null}">
											<input type="button" style="cursor: pointer; height:27px;" onclick="javascript:popupUserSearch();" class="search_btn schbtn" value="검색"><span class="help" style="color:#666; ">*이름/사번</span>
											</c:if>
										</dd>
									</dl>																					
									
									<dl class="insert_ready">
										<dt class="must-option"><label>전화번호</label></dt>
										<dd><input type="text" id="reg_tel" name="reg_tel" value="${SESS_USER_TELNO}" readonly></dd>
										<dt class="must-option"><label>E-MAIL</label></dt>
										<dd style="width: 250px;"><input type="text" id="reg_email" name="reg_email" value="${SESS_USER_TELNO}" readonly></dd>
									</dl>	
											
									<dl class="insert_ready">
										<dt class="must-option"><label>출력요청일</label></dt>
										<dd><input type="text" name="prt_req_dt" id="prt_req_dt" readonly="readonly"/></dd>
										<dt class="must-option"><label>희망 요청완료일</label></dt>
										<dd style="width:250px;"><input type="text" name="want_req_dt" id="want_req_dt" readonly="readonly"/></dd>
									</dl>	
											
																					
									<dl class="insert_ready">
										<dt class="must-option"><label>제목</label></dt>
										<dd><input type="text" id="subject" name="subject" value="" style="width:580px;"></dd>
									</dl>
										
										<dl class="insert_ready">
											<dt class="must-option"><label>사진종류</label></dt>
											<dd>
												<input type="radio" id="req_type" name="req_type" value="1" checked>증명사진
												<input type="radio" id="req_type" name="req_type" value="2">여권사진
												<input type="radio" id="req_type" name="req_type" value="3">비자사진
												<input type="radio" id="req_type" name="req_type" value="4">EP사진
												<input type="radio" id="req_type" name="req_type" value="5">사원증사진
											</dd>
										</dl>	
										<dl class="insert_ready">
											<dt class="must-option"><label>추가사항</label></dt>
											<dd style="width: 580px;">
											   파일(JPG)제공 <input type="checkbox" id="add_type" name="add_type" value="Y" style="margin-right:15px;">
											  사진출력  <input type="checkbox" id="prt_cnt" name="prt_cnt" value="Y" style="margin-right:15px;">
											</dd>											
										</dl>																					
																																
										<dl class="insert_ready">
											<dt class="must-option"><label>요청사항</label></dt>
											<dd><textarea class="textarea-style" rows="6" cols="88" id="content" name="content"></textarea></dd>
										</dl>									

									</div>
								</fieldset>
							</div>
						</div>
						
						<div class="btn-zone">
							<ul>
								<li><input type="submit" class="search_btn" value="등록" onclick="goSubmit(); return false;"></li>
								<li><input type="button" onclick="goList();" class="search_btn" value="취소"></li>
							</ul>
						</div>
								
					</div>
				</div>
				</form>				
			</div>
			<!--content end-->
		</div>
	</div>
<script type="text/javascript" src="/resource/common/js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.number.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery-1.12.1-ui.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.jqtransform.js"></script>     
<script type="text/javascript" src="/resource/common/js/jquery.form.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.caret.min.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.tag-editor.min.js"></script>   

<script type="text/javascript">

$(document).ready(function(){
	load_fnc('2', '0', '0'); //menu script
	
	$("#prt_req_dt").datepicker({ dateFormat: 'yy-mm-dd' });
	$("#want_req_dt").datepicker({ dateFormat: 'yy-mm-dd' });
	
	$('#prt_req_dt').datepicker('setDate', 'today');
	
	<c:if test="${isGetAdmin == null}">
		$('#prt_req_dt').datepicker('option', 'disabled', true);	// 관리자인 경우 수정이 가능해야 한다.
	</c:if>
		
})

function goSubmit(){
	var attatch_Ids = [];
	var progressChk = true;

	if(progressChk){		
		if($.trim($('#subject').val()) == ''){
			alert('제목을 작성해주세요.');
			$('#subject').focus();
			return false;
		}
		
		if ($("#want_req_dt").val() == "")
		{
			alert("희망 요청완료일을 입력하지 않았습니다!!!");
			return;
		}

		var params = {
				"subject": $('#subject').val(),
				"prt_req_dt": $('#prt_req_dt').val(),
				"want_req_dt" : $('#want_req_dt').val(),
				"req_type" : $('#req_type').val(),
				"prt_cnt" : $('#prt_cnt').val(),
				"add_type" : $('#add_type').val(),						
				"content" : escapeHtml($('#content').text()),
				"reg_id" : $('#reg_id').val(),
				"reg_nm" : $('#reg_nm').val(),
				"reg_dept_nm" :  $('#reg_dept_nm').val(), 
				"reg_tel" : $("#reg_tel").val(),
				"reg_email" : $("#reg_email").val(),
				"aprv_status" : "R"
		}
		
		if(confirm('등록하시겠습니까?')){
			$.ajax({
				type : 'post',
				url : '/registPhoto.do',	
				dataType : 'json',
				data : params,
				success : function(result){					
					alert('등록되었습니다.');
		// 작업필요		
					$("#seq").val(result);
					$('#frm').attr('action', '/photoDetail.do');
					$('#frm').submit();
				},
				error : function(e){
				}
			})
		}
	}
	
}

var entityMap = { 
		'&': '&amp;', 
		'<': '&lt;', 
		'>': '&gt;', 
		'"': '&quot;', 
		"'": '&#39;', 
		'/': '&#x2F;', 
		'`': '&#x60;', 
		'=': '&#x3D;',
		' ' : '&nbsp;',
		'\n' : '&#10;'
}; 

function escapeHtml (string) {
	return String(string).replace(/[&<>"'`=\/\s\\r\\n]/g, function fromEntityMap (s) {
		return entityMap[s]; 
	}); 
} 

function goList(){
	$('#frm').attr('action', '/photolist.do');
	$('#frm').submit();
}

</script>
<c:import url="/resource/common/include/bottom.jsp" />