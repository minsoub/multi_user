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
						<img src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;서비스요청&nbsp;&nbsp;>&nbsp;&nbsp;${title}&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">진행사항</b>
					</div>
					<div class="nav-title">${title} <small class="sub2">진행사항</small></div>
				</div>

				<ul class="tabNav sub2">
					<li><a href="javascript:goWrite();">출력요청</a></li>
					<li><a href="javascript:goList();" class="active">진행사항</a></li>
				</ul>	
				
				<div class="sub-nav-title">출력요청 수정하기</div>
				<div class="red-f">* 출력물은 종이만 가능합니다.</div>
								
				<div class="insrtfrom-framebox mtSm">				
					<div class="basic-list">					
						<div class="insert-step1-box">
							<div class="form-step1">
								<fieldset>
									<legend>${title}</legend>
									<div class="row-group">
										<form id="frm" name="frm" method="post">
										<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo}" />
										<input type="hidden" id="bbsid" name="bbsid" value="${bbsid}" />
										<input type="hidden" id="seq" name="seq" value="${resultDetail.seq }" />
										<input type="hidden" id="aprv_status"   name="aprv_status" value="${resultDetail.aprv_status}"/>
										<input type="hidden" id="reg_id" name="reg_id" value="${resultDetail.reg_id}" />
										
										<dl class="insert_ready">
											<dt class="must-option"><label>신청번호</label></dt>
											<dd style="width: 203px;">${resultDetail.seq}</dd>
											<dt class="must-option"><label>완료일</label></dt>
											<dd style="width: 250px;">${resultDetail.aprv_dt}</dd>
										</dl>
																					
										<dl class="insert_ready">
											<dt class="must-option"><label>신청부서</label></dt>
											<dd><input type="text" id="reg_dept_nm" name="reg_dept_nm" value="${resultDetail.reg_dept_nm }" readonly></dd>
											<dt class="must-option"><label>신청자</label></dt>
											<dd class="btn-zone" style="width: 250px;">
												<input type="text" id="reg_nm" name="reg_nm" value="${resultDetail.reg_nm}" readonly class="schword" style="width: 40%">
												<c:if test="${isGetAdmin != null}">
												<input type="button" style="cursor: pointer; height:27px;" onclick="javascript:popupUserSearch();" class="search_btn schbtn" value="검색"><span class="help" style="color:#666; ">*이름/사번</span>
												</c:if>
											</dd>
										</dl>																					
										<dl class="insert_ready">
											<dt class="must-option"><label>전화번호</label></dt>
											<dd><input type="text" id="reg_tel" name="reg_tel" value="${resultDetail.reg_tel}" readonly></dd>
											<dt class="must-option"><label>E-MAIL</label></dt>
											<dd style="width: 250px;"><input type="text" id="reg_email" name="reg_email" value="${resultDetail.reg_email}" readonly></dd>
										</dl>	
											
										<dl class="insert_ready">
											<dt class="must-option"><label>출력요청일</label></dt>
											<dd><input type="text" name="prt_req_dt" id="prt_req_dt" value="${resultDetail.prt_req_dt}" readonly="readonly"/></dd>
											<dt class="must-option"><label>희망 요청완료일</label></dt>
											<dd style="width:250px;"><input type="text" name="want_req_dt" id="want_req_dt" value="${resultDetail.want_req_dt}" readonly="readonly"/></dd>
										</dl>	
																																
										<dl class="insert_ready">
											<dt class="must-option"><label>제목</label></dt>
											<dd><input type="text" id="subject" name="subject" value="${resultDetail.subject}" style="width:580px;"></dd>
										</dl>
										<dl class="insert_ready">
											<dt class="must-option"><label>출력종류</label></dt>
											<dd>
												<span style="color:#666;">
													<input type="radio" id="req_type" name="req_type" value="1" <c:if test="${resultDetail.req_type eq '1'}">checked</c:if>>
													<label>현수막</label>
												</span>
												<span style="color:#666;">
													<input type="radio" id="req_type" name="req_type" value="2" <c:if test="${resultDetail.req_type eq '2'}">checked</c:if>>
													<label>A0</label>
												</span>
												<span style="color:#666;">
													<input type="radio" id="req_type" name="req_type" value="3" <c:if test="${resultDetail.req_type eq '3'}">checked</c:if>>
													<label>A1</label>
												</span>
												<span style="color:#666;">
													<input type="radio" id="req_type" name="req_type" value="4" <c:if test="${resultDetail.req_type eq '4'}">checked</c:if>>
													<label>A2</label>
												</span>
												<span style="color:#666;">
													<input type="radio" id="req_type" name="req_type" value="5" <c:if test="${resultDetail.req_type eq '5'}">checked</c:if>>
													<label>기타</label>
												</span>
											</dd>
											<dt class="must-option"><label>출력부수</label></dt>
											<dd style="width: 250px;"><input type="text" id="prt_cnt" name="prt_cnt" value="${resultDetail.prt_cnt}" style="width:40%" maxlength="4" style="ime-mode: disabled;" onkeydown="filterNumber(event);"> 부</dd>
										</dl>	
											
										<dl class="insert_ready">
											<dt class="must-option"><label>규격</label></dt>
											<dd style="width: 580px;">
											   <select id="prt_size" name="prt_size" onChange="javascript:PrtSizeChange(this.value);">
											   	 <option value="">규격선택</option>
											   	 <option value="1" <c:if test="${resultDetail.prt_size eq '1'}">selected</c:if>>24 Inch</option>
											   	 <option value="2" <c:if test="${resultDetail.prt_size eq '2'}">selected</c:if>>36 Inch</option>
											   	 <option value="3" <c:if test="${resultDetail.prt_size eq '3'}">selected</c:if>>42 Inch</option>
											   	 <option value="4" <c:if test="${resultDetail.prt_size eq '4'}">selected</c:if>>기타 </option>
											   </select>
											      가로 <input type="text" id="prt_size1" name="prt_size1" value="${resultDetail.prt_size1}" readonly maxlength="6" style="width:60px;"> cm
											      세로 <input type="text" id="prt_size2" name="prt_size2" value="${resultDetail.prt_size2}" readonly maxlength="6" style="width:60px;">cm
										    </dd>												
										</dl>																					
																																
										<dl class="insert_ready">
											<dt class="must-option"><label>요청사항</label></dt>
											<dd><textarea class="textarea-style" rows="6" cols="88" id="content" name="content">${resultDetail.content}</textarea></dd>
										</dl>
								<!-- 																								
										<c:if test="${isGetAdmin != null}">
										<dl class="insert_ready">
											<dt class="must-option"><label>관리자메모</label></dt>
											<dd><textarea class="textarea-style" rows="6" cols="88" id="memo" name="memo">${resultDetail.memo}</textarea></dd>
										</dl>	
																																
										<dl class="insert_ready">
											<dt class="must-option"><label>상태</label></dt>
											<dd style="width: 300px;">
												<select id="stsCheck" name="stsCheck" onChange="javascript:StsChange(this.value);">
													<option value="">진행상태 선택</option>
													<option value="R" <c:if test="${resultDetail.aprv_status eq 'R'}">selected</c:if>>요청</option>
													<option value="Y" <c:if test="${resultDetail.aprv_status eq 'Y'}">selected</c:if>>진행</option>
													<option value="A" <c:if test="${resultDetail.aprv_status eq 'A'}">selected</c:if>>완료</option>
													<option value="C" <c:if test="${resultDetail.aprv_status eq 'C'}">selected</c:if>>취소</option>
												</select>
											</dd>
										</dl>												
										</c:if>
										<c:if test="${isGetAdmin == null}">
										<dl class="insert_ready">
											<dt class="must-option"><label>상태</label></dt>
											<dd style="width: 300px;">
												<c:if test="${resultDetail.aprv_status eq 'R'}">신청</c:if>
												<c:if test="${resultDetail.aprv_status eq 'Y'}">진행</c:if>
												<c:if test="${resultDetail.aprv_status eq 'A'}">완료</c:if>
												<c:if test="${resultDetail.aprv_status eq 'C'}">취소</c:if>
											</dd>
										</dl>						
										</c:if>	
								 -->														
									</form>
									</div>
								</fieldset>
							</div>
						</div>
							
						<!-- File 첨부  -->	
						<div class="insrtfrom-framebox1">
							<div class="insert-step1-box">
								<div class="form-step1">
									<div class="row-group">																
										<dl class="insert_ready3" id="attatchArea">
											<dt class="must-option"><label>첨부파일</label></dt>
											<c:forEach var="item" items="${resultDetail.attachList }" varStatus="status">
											<dd style="width:97%" class="fileSet">
												<div style="position: relative;">
													<div>
														${item.filename }
														<div style="float:right; ">
															<button type="button" class="btn_blue" data-attatchseq="${item.freq }" onclick="fn_AttatchDel(this);return false;" >삭제</button>
														</div>
													</div>
												</div>
											</dd>
											</c:forEach>
																						
											<dd class="must-option2-dd"  id="file_view" <c:if test="${not empty resultDetail.attachList}">style="display:none; "</c:if>>
												<div style="position: relative;">
													<form id="file_frm" name="file_frm" method="post" enctype="multipart/form-data">
													<input type="hidden" id="seqs_0" name="seqs" />
													<input type="hidden" id="bbsid" name="bbsid" value="${bbsid}" />
														<div class="filebox">																														
															<input class="upload-name" value="파일선택" disabled="disabled" style="width: 20%;">
		  													<label for="uploadFlie">업로드</label> 		  																											
															<input type="file" class="upload-hidden" id="uploadFlie" name="uploadFile" title="영상 파일" onclick="javascript:submitChk = false;" style="height:30px;" accept="*.*"/>
															<progress id="progressBar_0" min="0" max="100" value="0" style="width:250px;height:30px;position:absolute;"></progress>
															<span id="progressT_0" style="display: none;position:absolute;color:#ffffff;">진행중 <font id="progressBarRate_0">0</font>%</span>
														</div>
													</form>
												</div>
											</dd>
										</dl>
									</div>
								</div>
							</div>	
						</div>
						<!-- File 첨부  -->		
									
						<div class="btn-zone">
							<ul>
								<li><input type="submit" class="search_btn" value="수정" onclick="goSubmit(); return false;"></li>
								<c:if test="${isGetAdmin != null}">
								<!-- li><input type="submit" class="search_btn" value="상태처리" onclick="goProcessSubmit(); return false;"></li  -->
								</c:if>
								<li><input type="button" onclick="goList();" class="search_btn" value="목록"></li>
							</ul>
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
		
	$('#prt_req_dt').datepicker('option', 'disabled', true);	// 관리자인 경우 수정이 가능해야 한다.
	
	$(document).on('change', 'input[name="uploadFile"]', function(event){
		var ua = window.navigator.userAgent;
		var rowIdx = $(this).closest('dd').index();
		var attatchedLng = parseInt($('.fileSet').length + 1); 
		if(navigator.appName == 'Netscape' && ua.indexOf('Trident/7.0') != -1){
			var file = $(this).prop("files")[0];
			if(file != null){
				$('form[name="file_frm"]').eq((rowIdx-attatchedLng)).ajaxForm({
					url: "<%=Constants.COMMON_UPLOAD_ASP_CALL %>",
					type: "POST",
					crossdomain: true, 
					enctype: "multipart/form-data",   
					dataType: "json",  
					contentType: "multipart/form-data",
					timeout: 1000 * 60 * 10,
					beforeSend: function() {
						var percentVal = '0%';
						$('span[id^=progressT_').eq(rowIdx-attatchedLng).show();
					},
					uploadProgress: function(event, position, total, percentComplete) {
						$('progress[id^=progressBar_]').eq(rowIdx-attatchedLng).val(percentComplete);
						$('font[id^=progressBarRate_]').eq(rowIdx-attatchedLng).text(percentComplete);
					},
					success: function(msg) {
						$('input[id^=seqs_]').eq(rowIdx-attatchedLng).val(msg);
				    }, 
				    complete: function(xhr) {
				    },
				    error: function(e){
				    	alert('업로드 중 오류가 발생했습니다\n새로고침 후 다시 진행 하시기 바랍니다');
				    	location.replace(location.href);
				    }
				})
				$('form[name="file_frm"]').eq((rowIdx-attatchedLng)).submit();
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

// 정보 수정
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
		//$('#freq').val(attatch_Ids.join('|'));
		var params = {
				"seq" : $('#seq').val(),
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
				"aprv_status" : $("#aprv_status").val()
		}
		// 수정은 공통으로 사용
		if(confirm('수정하시겠습니까?')){
			$.ajax({
				type : 'post',
				url : '/printUpdateSave.do',
				dataType : 'json',
				data : params,
				success : function(result){
					alert('수정되었습니다.');
					$('#frm').attr('action', '/printDetail.do');
					$('#frm').submit();
				},
				error : function(e){
				}
			})
		}
	}
}
// 관리자 승인 처리
function goProcessSubmit(){
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
		$('#freq').val(attatch_Ids.join('|'));
		var params = {
				"seq" : $('#seq').val(),
				"freqs" : attatch_Ids.join('|'),
				"aprv_status" : $("#aprv_status").val(),
				"subject" : $('#subject').val(),
				"content" : escapeHtml($('#content').text()),
				"memo" : escapeHtml($('#memo').text())
		}
		// 수정은 공통으로 사용
		if(confirm('상태 처리하시겠습니까?')){
			$.ajax({
				type : 'post',
				url : '/printStsUpdate.do',
				dataType : 'json',
				data : params,
				success : function(result){
					alert('처리완료 되었습니다.');
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
	var rowsIdx = $('#attatchArea').children('dd').length - $('.fileSet').length;
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
	var attatchSeq = '0';
	var params = '';
	
	if(typeof($(obj).data('attatchseq')) != 'undefined'){
		attatchSeq = $(obj).data('attatchseq');
		
		params = {
			"seq" : $('#seq').val(),
			"freq" : attatchSeq
		}
	}else{
		if(($('#attatchArea dd').length - $('.fileSet').length) == 1){
			alert('삭제하실 수 없습니다.');
			return false;
		}
		
		var rowIdx = $(this).closest('dd').index();
		var attatchedLng = parseInt($('.fileSet').length + 1);
		
		params = {
				"seq" : 0,
				"freq" : $('input[name=seqs]').eq(rowIdx-attatchedLng).val()
		}
		if(
			typeof($('input[name=seqs]').eq(rowIdx-attatchedLng)) == 'undefined' ||
			$('input[name=seqs]').eq(rowIdx-attatchedLng).val() == '' ||
			$('input[name=seqs]').eq(rowIdx-attatchedLng).val() == undefined
				
		){
			$(obj).parents('dd').remove();
			return false;
		}
	}

	
	
	if(confirm('파일을 삭제하시겠습니까?')){
		$.ajax({
			type : 'post',
			url : '/deleteBoardAttatch.do',
			dataType : 'json',
			data : params,
			success : function(result){
				if(result > 0){
					alert('삭제되었습니다.');
					$(obj).parents('dd').remove();
					
					$("#file_view").css("display", "none");  
				}
			},
			error : function(e){
			}
		})
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

function goWrite(){
	$('#frm').attr('action', '/printWrite.do');
	$('#frm').submit();	
}

function StsChange(dd)
{
	$("#aprv_status").val(dd);
}

</script>
<c:import url="/resource/common/include/bottom.jsp" />