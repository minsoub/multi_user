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

				<ul class="tabNav sub5">
					<li><a href="javascript:goWrite();">촬영요청</a></li>
					<li><a href="javascript:goList();" class="active">진행사항</a></li>
				</ul>	
			
				<div class="sub-nav-title">사진촬영 수정하기</div>
				<div class="red-f">
					* 촬영요청은 익일부터 가능합니다.<br>
					* 사진은 1인당 5매 이내로 출력 가능합니다.<br>
					* 비자사진의 경우 요청사항에 특이사항 꼭 기입바랍니다.
				</div>
																
				<div class="insrtfrom-framebox">
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
												<dd ><input type="text" id="reg_dept_nm" name="reg_dept_nm" value="${resultDetail.reg_dept_nm }" readonly></dd>
												<dt class="must-option"><label>신청자</label></dt>
												<dd class="btn-zone" style="width: 250px;">
													<input type="text" id="reg_nm" name="reg_nm" value="${resultDetail.reg_nm}" readonly class="schword" style="width: 40%">
													<c:if test="${isGetAdmin != null}">
													<input type="button" style="cursor: pointer; height:27px;"  onclick="javascript:popupUserSearch();" class="search_btn schbtn" value="검색"><span class="help" style="color:#666; ">*이름/사번</span>
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
												<dt class="must-option"><label>사진종류</label></dt>
												<dd style="width: 250px;">
													<input type="radio" id="req_type" name="req_type" value="1" <c:if test="${resultDetail.req_type eq '1'}">checked</c:if>>증명사진
													<input type="radio" id="req_type" name="req_type" value="2" <c:if test="${resultDetail.req_type eq '2'}">checked</c:if>>여권사진
													<input type="radio" id="req_type" name="req_type" value="3" <c:if test="${resultDetail.req_type eq '3'}">checked</c:if>>비자사진
													<input type="radio" id="req_type" name="req_type" value="4" <c:if test="${resultDetail.req_type eq '4'}">checked</c:if>>EP사진
													<input type="radio" id="req_type" name="req_type" value="5" <c:if test="${resultDetail.req_type eq '5'}">checked</c:if>>사원증사진
												</dd>
											</dl>	
											<dl class="insert_ready">
												<dt class="must-option"><label>추가사항</label></dt>
												<dd style="width: 120px;">
												     파일(JPG) 제공 <input type="checkbox" id="add_type" name="add_type" value="Y" <c:if test="${resultDetail.add_type eq 'Y'}">checked</c:if>>&nbsp;
												     사진출력 <input type="checkbox" id="prt_cnt" name="prt_cnt" value="Y" <c:if test="${resultDetail.prt_cnt eq 'Y'}">checked</c:if>>&nbsp;												   
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
												<dd><textarea class="textarea-style" rows="6" cols="88" id="memo" name="memo" style="width: 618px;">${resultDetail.memo}</textarea></dd>
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
									<div class="btn-zone">
										<ul>
											<li><input type="submit" class="search_btn" value="수정" onclick="goSubmit(); return false;"></li>
											<c:if test="${isGetAdmin != null}">
											<!-- li><input type="submit" class="search_btn" value="상태처리" onclick="goProcessSubmit(); return false;"></li  -->
											</c:if>
											<li><input type="button" onclick="goList();" class="search_btn" value="목록"></li>
										</ul>
									</div>
								</fieldset>
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
		
	$('#prt_req_dt').datepicker('option', 'disabled', true);	// 관리자인 경우 수정이 가능해야 한다.
	
})

// 정보 수정
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
				"seq" : $('#seq').val(),
				"subject": $('#subject').val(),
				"prt_req_dt": $('#prt_req_dt').val(),
				"want_req_dt" : $('#want_req_dt').val(),
				"req_type" : $('#req_type').val(),
				"add_type" : $('#add_type').val(),					
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
				url : '/photoUpdateSave.do',
				dataType : 'json',
				data : params,
				success : function(result){
					alert('수정되었습니다.');
					$('#frm').attr('action', '/photoDetail.do');
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

	if(progressChk){

		if($.trim($('#subject').val()) == ''){
			alert('제목을 작성해주세요.');
			$('#subject').focus();
			return false;
		}

		var params = {
				"seq" : $('#seq').val(),
				"aprv_status" : $("#aprv_status").val(),
				"subject" : $('#subject').val(),
				"content" : escapeHtml($('#content').text()),
				"memo" : escapeHtml($('#memo').text())
		}
		// 수정은 공통으로 사용
		if(confirm('상태 처리하시겠습니까?')){
			$.ajax({
				type : 'post',
				url : '/photoStsUpdate.do',
				dataType : 'json',
				data : params,
				success : function(result){
					alert('처리완료 되었습니다.');
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
function goWrite(){
	$('#frm').attr('action', '/photoWrite.do');
	$('#frm').submit();	
}
function StsChange(dd)
{
	$("#aprv_status").val(dd);
}

</script>
<c:import url="/resource/common/include/bottom.jsp" />