<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="/resource/common/js/jquery-1.9.1.js"></script>   
<%@ include file="/resource/common/include/common.jsp"%>
			
			<!-- dext업로드 form -->
			<form id="file_frm" name="file_frm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="SCF_SEQ" name="SCF_SEQ" value="0" />
			<input type="hidden" id="target_file" name="target_file" value=""/>
			<input type="hidden" id="tmp_EMPNO" name="tmp_EMPNO" value="1111"/>
				<div class="insrtfrom-framebox1">
					<div class="insert-step1-box">
						<div class="form-step1" >
							<div class="row-group">
								<dl class="insert_ready3">
									<dt class="must-option"><label for="ServiceName" id="ServiceName_label">첨부파일1</label></dt>
									<dd class="must-option2-dd">
										<div class="filebox">
 											<input class="upload-name" value="파일선택" disabled="disabled">
  											<label for="files1">업로드</label> 
											<input class="upload-hidden" name="uploadFile1" id="files1" type="file" />
											&nbsp<progress id="progressBar_1" min="0" max="100" value="0" style="width:250px;height:30px;position:absolute;"></progress>
											<span id="progressT_1" style="display: none;position:absolute;color:#ffffff;">진행중 <font id="progressBarRate_1">0</font>%</span>
										</div>
									</dd>
								</dl>
								<dl class="insert_ready3">
									<dt class="must-option"><label for="ServiceName" id="ServiceName_label">첨부파일2</label></dt>
									<dd class="must-option2-dd">
										<div class="filebox">
 											<input class="upload-name" value="파일선택" disabled="disabled">
  											<label for="files2">업로드</label> 
											<input class="upload-hidden" name="uploadFile2" id="files2" type="file" />
											&nbsp<progress id="progressBar_2" min="0" max="100" value="0" style="width:250px;height:30px;position:absolute;"></progress>
											<span id="progressT_2" style="display: none;position:absolute;color:#ffffff;">진행중 <font id="progressBarRate_2">0</font>%</span>
										</div>
									</dd>
								</dl>
								<dl class="insert_ready3">
									<dt class="must-option"><label for="ServiceName" id="ServiceName_label">첨부파일3</label></dt>
									<dd class="must-option2-dd">
										<div class="filebox">
 											<input class="upload-name" value="파일선택" disabled="disabled">
  											<label for="files3">업로드</label> 
											<input class="upload-hidden" name="uploadFile3" id="files3" type="file" />
											&nbsp<progress id="progressBar_3" min="0" max="100" value="0" style="width:250px;height:30px;position:absolute;"></progress>
											<span id="progressT_3" style="display: none;position:absolute;color:#ffffff;">진행중 <font id="progressBarRate_3">0</font>%</span>
										</div>
									</dd>
								</dl>
							</div>
						</div>
					</div>
				</div>
			</form>
			

<script type="text/javascript" src="/resource/common/js/jquery.form.js"></script>   

<script type="text/javascript">
var resultNum 	= 0;
var toDay		= new Date();
var toDayOg		= new Date();
var lastDay		= new Date();
jQuery.noConflict();
(function($){
	$(".filebox .upload-hidden").on('change',function(){
		
		var ua = window.navigator.userAgent;
		var filesId = $(this)[0].id;
		var inputName = $(this)[0].name;
		var filename  = $(this)[0].files[0].name;
		var subFileId = filesId.substring(5,6);

		$('#target_file').val(inputName);
		
		if(navigator.appName == 'Netscape' && ua.indexOf('Trident/7.0') != -1){
			if(filename != null || filename == ""){
				
				$('form[name="file_frm"]').ajaxForm({  
					url: "<%=Constants.CONTENTS_ASP_CALL %>",
					type: "POST",
					crossdomain: true, 
					enctype: "multipart/form-data",
					dataType: "json",
					contentType: "multipart/form-data",
					timeout: 1000 * 60 * 10,
					beforeSend: function() {
						var percentVal = '0%';
						$('span[id^=progressT_'+subFileId+']').show();
					},
					uploadProgress: function(event, position, total, percentComplete) {
						$('progress[id^=progressBar_'+subFileId+']').val(percentComplete);
						$('font[id^=progressBarRate_'+subFileId+']').text(percentComplete);
						//$('#srchDescription').text('업로드 진행 중');
					},
					success: function(msg) {
				    	if(subFileId == '1'){
				    		$("#fileSeq_1").val(msg);
				    	}else if (subFileId == '2'){
				    		$("#fileSeq_2").val(msg);
				    	}else{
				    		$("#fileSeq_3").val(msg);
				    	}
				    },
				    complete: function(xhr) {
				    },
				    error: function(e){
				    	console.log(e);
				    	alert('업로드 중 오류가 발생했습니다\n새로고침 후 다시 진행 하시기 바랍니다');
				    	/* location.replace(location.href); */
				    }
				})
				$('form[name="file_frm"]').submit();
			}
			
		}else{
			alert('IE 최신 브라우저에서 사용 가능합니다.');
		}
	})

	
})(jQuery);



</script>
