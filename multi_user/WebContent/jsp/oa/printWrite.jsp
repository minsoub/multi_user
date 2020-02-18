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
						<img src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;서비스요청&nbsp;&nbsp;>&nbsp;&nbsp;${title}&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">출력요청</b>
					</div>
					<div class="nav-title">${title} <small class="sub2">출력요청</small></div>					
				</div>			

				<ul class="tabNav sub2">
					<li><a href="#"  class="active">출력요청</a></li>
					<li><a href="javascript:goList();">진행사항</a></li>
				</ul>	
				<div class="sub-nav-title">요청사항 기재</div>
				<div class="red-f">* 출력물은 종이만 가능합니다.</div>
				
				<div class="insrtfrom-framebox mtSm">
					<div class="basic-list">										
						<div class="insert-step1-box">
							<div class="form-step1">
							<fieldset>
								<legend>제작요청</legend>
								<div class="row-group">
									<form id="frm" name="frm" method="post">
									<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo}" />
									<input type="hidden" id="bbsid" name="bbsid" value="${bbsid}" />
									<input type="hidden" id="seq" name="seq" value="0" />	
									<input type="hidden" id="reg_id" name="reg_id" value="${SESS_EMPNO}" />
											
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
										<dd><input type="text" id="subject" name="subject" value="[출력요청]" style="width:580px;"></dd>
									</dl>
									<dl class="insert_ready">
										<dt class="must-option"><label>출력종류</label></dt>
										<dd>
											<input type="radio" id="req_type" name="req_type" value="1" checked>현수막
											<input type="radio" id="req_type" name="req_type" value="2">A0
											<input type="radio" id="req_type" name="req_type" value="3">A1
											<input type="radio" id="req_type" name="req_type" value="4">A2
											<input type="radio" id="req_type" name="req_type" value="5">기타
										</dd>
										<dt class="must-option"><label>출력부수</label></dt>
										<dd style="width: 250px;"><input type="text" id="prt_cnt" name="prt_cnt" value="" style="width:40%" maxlength="4" style="ime-mode: disabled;" onkeydown="filterNumber(event);"> 부</dd>
									</dl>	
									<dl class="insert_ready">
										<dt class="must-option"><label>규격</label></dt>
										<dd style="width: 580px;">
										   <select id="prt_size" name="prt_size" onChange="javascript:PrtSizeChange(this.value);">
										   	 <option value="">규격선택</option>
										   	 <option value="1">24 Inch</option>
										   	 <option value="2">36 Inch</option>
										   	 <option value="3">42 Inch</option>
										   	 <option value="4">기타 </option>
										   </select>
										     가로 <input type="text" id="prt_size1" name="prt_size1" readonly maxlength="6" style="width: 20%;"> cm 
										     세로 <input type="text" id="prt_size2" name="prt_size2" readonly maxlength="6" style="width: 20%;"> cm 	
										</dd>											
									</dl>																					
																																
									<dl class="insert_ready">
										<dt class="must-option"><label>요청사항</label></dt>
										<dd><textarea class="textarea-style" rows="10" cols="88" id="content" name="content"></textarea></dd>
									</dl>
									</form>	
								</div>
							</fieldset>
						</div>
						
						<div class="insrtform-framebox1">
							<div class="insert-step1-box">
								<div class="form-step1">
									<div class="row-group">		
										<dl class="insert_ready" id="attatchArea">
											<dt class="must-option"><label for="ServiceName" id="ServiceName_label">첨부파일</label></dt>
											<dd class="must-option2-dd" id="fileIdx_0">
												<div class="filebox" style="position: relative;">
													<form id="file_frm" name="file_frm" method="post" enctype="multipart/form-data">
													<input type="hidden" id="bbsid" name="bbsid" value="${bbsid}" />
													<input type="hidden" id="seqs_0" name="seqs" />
														<div>
															<input class="upload-name" value="파일선택" disabled="disabled" style="width: 20%;">
		  													<label for="uploadFile">업로드</label> 
															<input type="file" class="upload-hidden" id="uploadFile" name="uploadFile" title="영상 파일" onclick="javascript:submitChk = false;" style="height:30px;" accept="*.*"/>
															<progress id="progressBar_0" min="0" max="100" value="0" style="width:250px;height:30px;position:absolute;"></progress>
															<span id="progressT_0" style="display: none;position:absolute;color:#ffffff;">진행중 <font id="progressBarRate_0">0</font>%</span>
															<!-- div style="float:right;">
																<button type="button" class="btn_blue" onclick="fn_AttatchAdd(this);return false;" >추가</button>
																<button type="button" class="btn_blue" onclick="fn_AttatchDel(this);return false;" >삭제</button>
															</div  -->
														</div>
													</form>
												</div>
											</dd>
										</dl>
									</div>
								</div>
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
			</div>			
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
		
	$(document).on('change', 'input[name="uploadFile"]', function(event){
		var ua = window.navigator.userAgent;
		var rowIdx = $(this).closest('dd').index();
		if(navigator.appName == 'Netscape' && ua.indexOf('Trident/7.0') != -1){
			var file = $(this).prop("files")[0];
		
			if(file != null){
				$('form[name="file_frm"]').eq((rowIdx-1)).ajaxForm({
					url: "<%=Constants.COMMON_UPLOAD_ASP_CALL %>",
					type: "POST",
					crossdomain: true, 
					enctype: "multipart/form-data",   
					dataType: "json",  
					contentType: "multipart/form-data",
					timeout: 1000 * 60 * 10,
					beforeSend: function() {
						var percentVal = '0%';
						$('span[id^=progressT_').eq(rowIdx-1).show();
					},
					uploadProgress: function(event, position, total, percentComplete) {
						$('progress[id^=progressBar_]').eq(rowIdx-1).val(percentComplete);
						$('font[id^=progressBarRate_]').eq(rowIdx-1).text(percentComplete);
						
						//$('#srchDescription').text('업로드 진행 중');
					},
					success: function(msg) {
						$('input[id^=seqs_]').eq(rowIdx-1).val(msg);
						
				    }, 
				    complete: function(xhr) {
				    },
				    error: function(e){
				    	alert('업로드 중 오류가 발생했습니다\n새로고침 후 다시 진행 하시기 바랍니다' + e);
				    	location.replace(location.href);
				    }
				})
				$('form[name="file_frm"]').eq((rowIdx-1)).submit();
			}
		}else{
			alert('IE 최신 브라우저에서 사용 가능합니다.');
			$(this).val('');
		}
	});
	
	
	
	$("input:radio[name=req_type]").click(function()
	{
		var click_value = $("input:radio[name=req_type]:checked").val();
		if (click_value == "1") // 현수막
		{
			$("#prt_size").val("1");
			// 24 inch default
			$("#prt_size1").attr("readonly", true);
			$("#prt_size2").attr("readonly", false);
			$("#prt_size1").val("");
			$("#prt_size2").val("60.9");
		} else if(click_value == "2")	// A0
		{
			$("#prt_size").val("");
			$("#prt_size1").attr("readonly", true);
			$("#prt_size2").attr("readonly", true);			
			$("#prt_size1").val("84.1");
			$("#prt_size2").val("118.9");
		} else if(click_value == "3")   // A1
		{
			$("#prt_size").val("");
			$("#prt_size1").attr("readonly", true);
			$("#prt_size2").attr("readonly", true);			
			$("#prt_size1").val("59.4");
			$("#prt_size2").val("84.1");			
		} else if(click_value == "4")   // A2
		{
			$("#prt_size").val("");
			$("#prt_size1").attr("readonly", true);
			$("#prt_size2").attr("readonly", true);			
			$("#prt_size1").val("42.0");
			$("#prt_size2").val("59.4");			
		} else if(click_value == "5")   // 기타
		{
			$("#prt_size").val("");
			$("#prt_size1").attr("readonly", false);
			$("#prt_size2").attr("readonly", false);			
			$("#prt_size1").val("");
			$("#prt_size2").val("");
		}
	});
})

// 규격의 인치 변화
function PrtSizeChange(data)
{
	var click_value = $("input:radio[name=req_type]:checked").val();
	if (click_value != "1")
	{
		$("#prt_size").value("0");
		return;
	}
	if (data == "") {
		$("#prt_size1").val("");
		$("#prt_size2").val("");
		$("#prt_size1").attr("readonly", true);
		$("#prt_size2").attr("readonly", true);
	}else if(data == "1") {
		$("#prt_size1").val("");
		$("#prt_size2").val("60.9");
		$("#prt_size1").attr("readonly", true);
		$("#prt_size2").attr("readonly", true);		
	}else if(data == "2") {
		$("#prt_size1").val("");
		$("#prt_size2").val("91.4");
		$("#prt_size1").attr("readonly", true);
		$("#prt_size2").attr("readonly", true);	
	}else if(data == "3") {
		$("#prt_size1").val("");
		$("#prt_size2").val("106.6");
		$("#prt_size1").attr("readonly", true);
		$("#prt_size2").attr("readonly", true);	
	}else if(data == "4") {
		$("#prt_size1").attr("readonly", false);
		$("#prt_size2").attr("readonly", false);		
	}
}

function goSubmit(){
	var attatch_Ids = [];
	var progressChk = true;
	$('progress[id^=progressBar_]').each(function(){
		if($(this).val() != 100 && $(this).val() != 0){
			alert('첨부파일 업로드중입니다. 잠시만 기다려주십시오.');
			progressChk = false;
			return false;
		}
	})
	
	if(progressChk){
		if ($("#prt_cnt").val() == "")
		{
			alert("출력 부수를 입력하세요!!!");
			$("#prt_cnt").focus();
			return false;
		}
		
		if ($("input:radio[name=req_type]:checked").val() == "1" && $("#prt_size").val() == "")
		{
			alert("규격은 필수입니다!!!");
			$("#prt_size").focus();
			return false;
		}
		if ($("#prt_size").val() == "4" && ($("prt_size1").val() == "" || $("prt_size2").val() == ""))
		{
			alert("규격이 기타일 경우 가로/세로를 입력하셔야 합니다!!!");
			$("#prt_size").focus();
			return false;
		}
		
		if($.trim($('#subject').val()) == ''){
			alert('제목을 작성해주세요.');
			$('#subject').focus();
			return false;
		}
		
		$('input[name=seqs]').each(function(){
			if($.trim($(this).val()) != ''){
				attatch_Ids.push($(this).val());
			}
		});
		//alert(attatch_Ids.join('|'));
		var params = {
				"freqs" : attatch_Ids.join('|'),
				"bbsid" : "${bbsid}",
				"subject": $('#subject').val(),
				"prt_req_dt": $('#prt_req_dt').val(),
				"want_req_dt" : $('#want_req_dt').val(),
				"req_type" : $("input:radio[name=req_type]:checked").val(),
				"prt_cnt" : $('#prt_cnt').val(),
				"prt_size" : $('#prt_size').val(),
				"prt_size1" : $('#prt_size1').val(),
				"prt_size2" : $('#prt_size2').val(),						
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
				url : '/registPrint.do',	
				dataType : 'json',
				data : params,
				success : function(result){					
					alert('등록되었습니다.');
		// 작업필요		
					//$('#frm').append('<input type="hidden" name="seq" value="'+result+'" />');
					$("#seq").val(result);
					$('#frm').attr('action', '/printDetail.do');
					$('#frm').submit();
				},
				error : function(e){
				}
			})
		}
	}
	
}

function fn_AttatchAdd(obj){
	var cloneObj = $(obj).parents('dd').clone();
	var rowsIdx = $('#attatchArea').children('dd').length;
	$(cloneObj).find('input').each(function(){
		if(typeof($(this).attr('id')) != 'undefined'){
			var attrId = $(this).attr('id').split('_');
			$(this).attr('id', attrId[0]+'_'+rowsIdx);
			
			if(attrId[0] != 'seqs'){
				$(this).attr('name', attrId[0]+'_'+rowsIdx);
			}
			
		}
	});
	$(cloneObj).find('progress').each(function(){
		if(typeof($(this).attr('id')) != 'undefined'){
			var attrId = $(this).attr('id').split('_');
			$(this).val(0);
			$(this).attr('id', attrId[0]+'_'+rowsIdx);
		}
	});
	$(cloneObj).find('span').each(function(){
		if(typeof($(this).attr('id')) != 'undefined'){
			var attrId = $(this).attr('id').split('_');
			$(this).attr('id', attrId[0]+'_'+rowsIdx);
			$(this).hide();
		}
	});

	$(cloneObj).find('font').each(function(){
		if(typeof($(this).attr('id')) != 'undefined'){
			var attrId = $(this).attr('id').split('_');
			$(this).attr('id', attrId[0]+'_'+rowsIdx);
			$(this).html(0);
		}
	});
	$('#attatchArea').append(cloneObj);
}

function fn_AttatchDel(obj){
	if($('#attatchArea dd').length == 1){
		alert('삭제하실 수 없습니다.');
		return false;
	}else{
		var rowIdx = $(this).closest('dd').index();
		var params = {
			"seq" : 0,
			"freq" : $('input[name=seqs]').eq(rowIdx-1).val()
		}
		
		if(
			typeof($('input[name=seqs]').eq(rowIdx-1)) == 'undefined' ||
			$('input[name=seqs]').eq(rowIdx-1).val() == '' ||
			$('input[name=seqs]').eq(rowIdx-1).val() == undefined		
		){
			$(obj).parents('dd').remove();
			return false;
		}
		
		if(confirm('파일을 삭제하시겠습니까?')){
			$.ajax({
				type : 'post',
				url : '/admin/removeAttatch.do',
				dataType : 'json',
				data : params,
				success : function(result){
					if(result >= 0){
						alert('삭제되었습니다.');
						$(obj).parents('dd').remove();
					}
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
	$('#frm').attr('action', '/printlist.do');
	$('#frm').submit();
}
</script>

<c:import url="/resource/common/include/bottom.jsp" />