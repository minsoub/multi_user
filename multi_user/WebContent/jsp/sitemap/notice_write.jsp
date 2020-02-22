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
	<c:set value="12" var="left_depth_1"/>
	<div id="contents" class="learn-frame-area">
		<div class="contents-framebox" id="contents_id">
			<!-- leftmenu -->
			<div class="contents-header-framebox">
				<div class="learn-tit-framebox">
					<c:import url="/resource/common/include/leftMenu_01.jsp">
						<c:param name="left_depth_1" value="12"></c:param>
						<c:param name="left_depth_2" value="1"></c:param>
					</c:import>
				</div>
			</div>
			<!-- leftmenu end-->
<c:set var="isGetAdmin" value="${sessionScope.SESS_USER_INFO['rentAdmin']}"></c:set>
			<!--content-->
			<div class="contents-con-framebox">
				<div class="nav-box">
					<div class="nav-img"><img src="/resource/images/sub/sub7_tit_img.png"></div>
					<div class="nav-list">
						<img src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;게시판&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">공지사항</b>
					</div>
					<div class="nav-title">공지사항</div>
				</div>
				<div class="sub-nav-title">공지사항 작성</div>

				<div class="basic-list">
					
						<div class="insrtfrom-framebox">
							<div class="insert-step1-box">
								<div class="form-step1">
								<fieldset>
									<legend>공지사항</legend>
									<div class="row-group">
										<form id="frm" name="frm" method="post">
											<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo}" />
											<input type="hidden" id="bbsid"  name="bbsid"  value="${paging.bbsid}" />
											<input type="hidden" id="html"   name="html"   value="0" />
											<dl class="insert_ready">
												<dt class="must-option"><label>제목</label></dt>
												<dd style="width: 400px;"><input type="text" id="subject" name="subject" value=""></dd>
											</dl>
											<dl class="insert_ready">
												<dt class="must-option"><label>내용</label></dt>
												<dd><textarea class="textarea-style" rows="10" cols="88" id="content" name="content" style="width: 618px;"></textarea></dd>
											</dl>
										</form>

										<dl class="insert_ready" id="attatchArea">
											<dt class="must-option"><label>첨부파일</label></dt>
											<dd style="width:97%" id="fileIdx_0">
												<div style="position: relative;">
													<form id="file_frm" name="file_frm" method="post" enctype="multipart/form-data">
														<div>
															<input type="hidden" id="bbsid" name="bbsid" value="${bbsid}" />
															<input type="hidden" id="seqs_0" name="seqs" />
															<!-- <button type="button" id="srchDescription" name="srchDescription" onclick="javascript:$('#uploadFile').trigger('click')" class="btn_yellow" style="width:250px;cursor: pointer;">업로드 파일을 클릭해주세요</button> -->
															<input type="file" name="uploadFile" title="영상 파일" onclick="javascript:submitChk = false;" style="height:30px;" accept="*.*"/>
															<progress id="progressBar_0" min="0" max="100" value="0" style="width:250px;height:30px;position:absolute;"></progress>
															<span id="progressT_0" style="display: none;position:absolute;color:#ffffff;">진행중 <font id="progressBarRate_0">0</font>%</span>
															<div style="float:right; ">
																<button type="button" class="btn_blue" onclick="fn_AttatchAdd(this);return false;" >추가</button>
																<button type="button" class="btn_blue" onclick="fn_AttatchDel(this);return false;" >삭제</button>
															</div>
														</div>
													</form>
												</div>
											</dd>
										</dl>
										
									</div>
									<div class="btn-zone">
										<ul>
											<c:if test="${isGetAdmin != null}">
											<li><input type="submit" class="search_btn" value="등록" onclick="goSubmit(); return false;"></li>
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
</body>
<script type="text/javascript" src="/resource/common/js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.number.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery-1.12.1-ui.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.jqtransform.js"></script>     
<script type="text/javascript" src="/resource/common/js/jquery.form.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.caret.min.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.tag-editor.min.js"></script>   

<script type="text/javascript">

$(document).ready(function(){
	load_fnc('6', '0', '0'); //menu script
	
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
});

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
		var params = {
				"freqs" : attatch_Ids.join('|'),
				"bbsid" : "${bbsid}",
				"html"  : $('#html').val(),
				"subject" : $('#subject').val(),
				"content" : escapeHtml($('#content').text()),
		}
		
		if(confirm('등록하시겠습니까?')){
			$.ajax({
				type : 'post',
				url : '/registMemo.do',	 
				dataType : 'json',
				data : params,
				success : function(result){					
					alert('등록되었습니다.');
		// 작업필요		
					$('#frm').append('<input type="hidden" name="num" value="'+result+'" />');
					$('#frm').attr('action', '/notice_view.do');
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
	$('#frm').attr('action', '/notice.do');
	$('#frm').submit();
}

</script>
<c:import url="/resource/common/include/bottom.jsp" />