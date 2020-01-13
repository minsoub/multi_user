<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<!DOCTYPE html>
<html>
<head>    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">

<link rel="stylesheet" type="text/css" href="/resource/common/css/kube_common.css" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/jquery-1.12.1-ui.css" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/jquery.tag-editor.css" />

<title>KEPCO YouTube</title>
<style>
.darkness {
  position:absolute;
  top:0;
  left:0;
  width:inherit;
  height:inherit;
  background:#000000;
  opacity:0;
  transition:all .6s linear;
}

.btn-plus {
  position:absolute;
  top:23px;   
  left:10px;
  right:10px;
  width:150px;
  height:100px;    
  text-align:center;
  font-weight:bold;
  opacity:0;
}

.btn-plus span {
  font-size:1.3em;   
  color:#ffffff;
  user-select:none;
}         

.img-wrapper {
  width:180px;
  height:110px;
  position:absolute;
  cursor:pointer;
}

.img-wrapper:hover .darkness{
  opacity:0.4;
}          

.img-wrapper:hover .btn-plus {
  opacity:1;
}


.filebox input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip:rect(0,0,0,0);
	border: 0;
}

.filebox label {
	display: inline-block;
	padding: .5em .75em;
	color: #999;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
}

/* named upload */
.filebox .upload-name {
	display: inline-block;
	padding: .5em .75em;
	font-size: inherit;
	font-family: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #f5f5f5;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
  -webkit-appearance: none; /* 네이티브 외형 감추기 */
  -moz-appearance: none;
  appearance: none;
}


.filebox.bs3-primary label {
  color: #fff;
  background-color: #337ab7;
	border-color: #2e6da4;
}
</style>
</head>
<c:import url="/resource/common/include/kube_topMenu.jsp" />
<c:import url="/resource/common/include/kube_leftMenu.jsp" />
<div id="contents">
    <div class="m_title_01" style="margin:10px 0 20px 0;display: inline-block;">업로드</div>
	<div style="color: rgb(93, 93, 93); font-size: 14px; margin-top: 5px; margin-left: 15px; display: inline-block; position: absolute;">잠깐! 제작된 영상물 인용 시 상업적 목적이 아닌 보도·비평·교육·연구 등을 위하여는 정당한 범위 안에서 활용이 가능합니다.<br />단, 상업용 음반이나 영상 저작물을 재생할 경우 등 여러 예외 사항이 있으니 유의하시기 바랍니다.(저작권법 제28조, 제29조)</div>    
    <table class="table-view">
        <colgroup>
            <col width="15%" />
            <col />
            <col width="15%" />
            <col />
        </colgroup>
        <tr>
            <th>진행상태</th>
            <td colspan="3">
                <div class="box01 fl_left">
                    <img id="selPreviewImg" src="/resource/kube_images/icon_01.png" style="margin-top:30px"/>
                </div>
                
                <form id="file_frm" name="file_frm" method="post" enctype="multipart/form-data">
	                <div class="fl_left" style="margin:25px 0 0 25px">
							<input type="hidden" id="video_duration" name="video_duration" />
							<input type="hidden" id="tmpFileName" name="tmpFileName" />
							<input type="hidden" id="tmpFileExt" name="tmpFileExt" /> 
							<button type="button" id="srchDescription" name="srchDescription" onclick="javascript:$('#uploadFile').trigger('click')" class="btn_yellow" style="width:530px;cursor: pointer;">업로드 할 동영상 파일을 클릭해주세요</button>
	                        <input type="file" id="uploadFile" name="uploadFile" title="영상 파일" style="display: none;" onclick="javascript:submitChk = false;" onchange="javascript:funFileChg(this);" accept="video/*"/>
	                        <p id="progressP"><progress id="progressBar" min="0" max="100" value="0" style="width:530px;height:30px;"></progress></p>
							<span id="progressT" style="display: none;">진행중 <font id="progressBarRate">0</font>%</span>
	                </div>
	            </form>
            </td>
        </tr>
        <form id="frm" name="frm" method="post" enctype="multipart/form-data" >
			<input type="hidden" id="selThumbImgIdx" name="selThumbImgIdx" />		
			<input type="hidden" id="cid" name="cid" />		
			<input type="hidden" id="oriFileName" name="oriFileName" />
			<input type="hidden" id="tmpFileName2" name="tmpFileName2" />
			<input type="hidden" id="tmpFileSize" name="tmpFileSize" />
			
	        <tr>
	        	<th>퀴즈&자막</th>
	        	<td colspan="3">
	        		<div class="filebox bs3-primary preview-image">
		        		<input class="upload-name" value="파일선택" disabled="disabled" style="width: 200px;">
		        		<label for="vttFile">업로드</label>
		        		<input type="file" name="vtt_File" id="vttFile" class="upload-hidden" accept=".zip" />
		        	</div>
		        	<span style="color:red">※ 제공받은 zip파일이 아닐경우 자막&퀴즈가 나오지 않을 수 있습니다.</span>
	        	</td>
	        </tr>
	        <tr>
	            <th>공개권한</th>
	            <td>
	                    <label for=""></label>
	                    <select name="open_flag" class="selectbox" style="width:50%">
                        	<c:forEach var="codeList" items="${codeList }">
	                            <c:if test="${codeList.code_gubun == 11}">
	                            	<option value="${codeList.code_seq}">${codeList.code_desc}</option>
								</c:if>
							</c:forEach> 								                                    
                        </select>
	            </td>
	            <th>다운로드권한</th>
	            <td>
	                    <label for=""></label>
	                    <select name="download_flag" class="selectbox" style="width:50%">
                        	<c:forEach var="codeList" items="${codeList }">
	                            <c:if test="${codeList.code_gubun == 12}">
	                            	<option value="${codeList.code_seq}">${codeList.code_desc}</option>
								</c:if>
							</c:forEach> 								                                    
                        </select>
	            </td>
	        </tr>
	        <tr>
	            <th>카테고리</th>
	            <td colspan="3">
	                    <label for=""></label>
	                    <select name="code_seq1" title="카테고리" class="selectbox" style="width:20%" onchange="javascript:funCategoryChg(this);">
                        	<option value="">선택</option>
                            <c:forEach var="codeList" items="${codeList }">
                            	<c:if test="${codeList.code_gubun == 1}">
                                	<option value="${codeList.code_seq}">${codeList.code_desc}</option>
								</c:if>
                            </c:forEach> 							                                    
                        </select>
                        <select name="code_seq2" title="카테고리" class="selectbox" style="width:20%">
                        	<option value="">선택</option> 								                                    
                        </select>
	            </td>
	        </tr>
	        <tr>
	            <th>제목</th>
	            <td colspan="3">
	                    <label for=""></label>
	                    <input type="text" id="title" name="title" title="제목" value="" class="textbox" maxlength="100"/>
	            </td>
	        </tr>
	        <tr>
	            <th>내용</th>
	            <td colspan="3">
	                    <textarea class="textarea" rows="8" cols="88" id="contents_desc" name="contents_desc" title="내용" style="width:100%"></textarea>
	            </td>
	        </tr>
	        <tr>
	            <th>태그</th>
	            <td colspan="3">
	                    <textarea class="textarea" rows="8" cols="88" id="tag_desc" name="tag_desc" title="태그" style="width:100%"></textarea>
	            </td>
	        </tr>
	        <tr>
	            <th>동영상 미리보기<br />이미지 선택</th>        
	            <td colspan="3">
	            	<div id="review_dd" style="display: none;">
	            		<c:set var="marginStyle" value="margin-right: 5px;" />
	            		<c:forEach begin="0" end="5" step="1" varStatus="status">
	            			<c:if test="${!status.last }">
	            				<c:set var="marginStyle" value="margin-right: 5px;" />
	            			</c:if>
					        <div class="box01 fl_left" style="${marginStyle}">
					        	<div class="img-wrapper" onclick="javascript:funSetPreviewImg(this, '${status.index}');"> 
						            <img name="videoThumb" style="width: 180px; height: 110px;" />
						            <input type="hidden" name="thumb_url" />
						            <div class="darkness"></div>
									<div class="btn-plus"><span draggable="false">미리보기 이미지로 선택</span></div>
								</div>
							</div>
							<c:set var="marginStyle" value="" />
						</c:forEach>
					</div>
					
	            	<div id="review_dd2">
		                <div class="box01 fl_left" style="margin-right:5px">
		                    <img src="/resource/kube_images/icon_02.png" style="margin-top:30px"/>
		                </div>
		                <div class="box01 fl_left" style="margin-right:5px">
		                    <img src="/resource/kube_images/icon_02.png" style="margin-top:30px"/>
		                </div>
		                <div class="box01 fl_left" style="margin-right:5px">
		                    <img src="/resource/kube_images/icon_02.png" style="margin-top:30px"/>
		                </div>
		                <div class="box01 fl_left" style="margin-right:5px">
		                    <img src="/resource/kube_images/icon_02.png" style="margin-top:30px"/>
		                </div>
		                <div class="box01 fl_left" style="margin-right:5px">
		                    <img src="/resource/kube_images/icon_02.png" style="margin-top:30px"/>
		                </div>
		                <div class="box01 fl_left">
		                    <img src="/resource/kube_images/icon_02.png" style="margin-top:30px"/>
		                </div>
					</div>
	            </td>         
	        </tr>
		</form>
    </table>  
    <div class="fl_right" style="margin:15px 0">
        <button type="button" onclick="javascript:funSave();" class="btn_black img_pointer">등록</button> 
        <button type="button" onclick="javascript:funCancel();" class="btn_black img_pointer">취소</button>
    </div>
</div>
 
<!-- 영상 재생 시간 추출용 -->
<video id="file_form" width="0" height="0" controls style="display: none;">
	<source id="file_source" src="" type="video/mp4">
</video>
  
<iframe name="ifrm" id="ifrm" style="display: none;"></iframe>

<script type="text/javascript" src="/resource/common/js/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.number.min.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery-1.12.1-ui.js"></script>
<script type="text/javascript" src="/resource/common/js/jquery.jqtransform.js"></script>     
<script type="text/javascript" src="/resource/common/js/jquery.form.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.caret.min.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.tag-editor.min.js"></script>   
<script src="/resource/common/js/neodreams.js"></script>
<script src="/resource/common/js/jscript.js"></script>   

<script type="text/javascript">
$(document).ready(function() {
	var fileTarget = $('.filebox .upload-hidden');

    fileTarget.on('change', function(){
        if(window.FileReader){
            // 파일명 추출
            var filename = $(this)[0].files[0].name;
        } 

        else {
            // Old IE 파일명 추출
            var filename = $(this).val().split('/').pop().split('\\').pop();
        };

        if(filename.substring(filename.lastIndexOf(".")+1,filename.length).search("zip") == -1){
        	alert('확장자 zip파일만 등록가능합니다.');
        	$(this).val('');
        }else{
        	$(this).siblings('.upload-name').val(filename);
        }
        
        
    });
});


//크로스 도메인 URL 정보 호출
function getCrossDomain(){
	return "http://<%= Constants.VOD_CROSS_DOMAIN %>";
}
//영상 업로드 이중 서브밋 방지
var submitChk = false; 

function funFileChg(obj){
	
	var ua = window.navigator.userAgent;
	
	if(navigator.appName == 'Netscape' && ua.indexOf('Trident/7.0') != -1){
		var file = $(obj).prop("files")[0];
	
		if(file != null){
			var filename = file.name;
			var fileSize = file.size;
			var filedot = filename.lastIndexOf('.');
			var fileExt = filename.substring(filedot + 1, filename.length).toLowerCase();
			var IMG_FORMAT = "\.(mp4|avi|mpg|mpeg|wmv|asf|mkv)$"; //파일 확장자 검사
			
			if (!(new RegExp(IMG_FORMAT, "i")).test(obj.value)) {
	      		alert("동영상 파일만 첨부하실 수 있습니다.\n\n확장자 : mp4, avi, mpg, mpeg, wmv, asf, mkv");
	      		return false;
			}else{
				$('#oriFileName').val(filename);
				$('#tmpFileExt').val(fileExt);
				$('#tmpFileSize').val(fileSize);

				//재생시간 체크
				blobURL = window.URL.createObjectURL(file);
			    
				$("#file_source").attr("src", blobURL);
				//동영상을 다시 load 함  
				$("#file_form").load();
				
				var vid = document.getElementById("file_form");
				
				//메타 데이터 로드 완료. 전체 재생시간 / 6 * num 으로 각각 썸네일 추출
				vid.addEventListener('loadedmetadata', function() {
				    $('#video_duration').val(parseInt(vid.duration));
				    window.URL.revokeObjectURL(blobURL);
				    
				    funAjaxFormSubmit(submitChk);
				    
				    submitChk = true;
				});  
				     
				//재생 불가 영상. 전체 재생시간을 디폴트 0으로 정하고 asp 에서 썸네일 추출 시간 디폴트로 진행
				vid.addEventListener("error", function() {
					$('#video_duration').val('0'); 
					funAjaxFormSubmit(submitChk);
				    
				    submitChk = true;
				});
			}
		}
	}else{
		alert('IE 최신 브라우저에서 사용 가능합니다.');
		$(obj).val('');
	}
}

function funAjaxFormSubmit(submitChk){
	
	if(!submitChk){

		$('#tmpFileName').val(getTimeStamp() + '_${SESS_EMPNO}');
		
		$('#tmpFileName2').val($('#tmpFileName').val());
		
		$('#file_frm').ajaxForm({  
			url: "<%= Constants.KUBE_UPLOAD_ASP_CALL %>",
			type: "POST",
			crossdomain: true, 
			enctype: "multipart/form-data",   
			dataType: "json",  
			contentType: "multipart/form-data",
			timeout: 1000 * 60 * 10,
		    beforeSend: function() {
		        var percentVal = '0%';
		        $('#progressP').show();
		        $('#progressT').show();
		    },
		    uploadProgress: function(event, position, total, percentComplete) {
		    	$('#progressBar').val(percentComplete);
		    	$('#progressBarRate').text(percentComplete);
		    	$('#srchDescription').text('영상 업로드 진행 중');
		    	
		    	if(percentComplete == 100){
		    		$('#srchDescription').text('영상 이미지 추출 중');		    		
		    	}
		    },
		    success: function(msg) {     
				$('#srchDescription').text('업로드 완료. 미리보기 이미지를 선택하세요');
				$('#progressP').hide();
				$('#progressT').hide();

				$('#cid').val(msg);
				var tempFileName = $('#tmpFileName').val();
				   
				sleep(3000);
				
				$('img[name=videoThumb]').each(function(index){
					$(this).attr('src', '<%= Constants.KUBE_UPLOAD_ASP_IP %>/kube/video_thumb/${thumbPath}/' + tempFileName + '_' + (index + 1) + '.jpg');
                       $('input[name=thumb_url').eq(index).val('/kube/video_thumb/${thumbPath}/' + tempFileName + '_' + (index + 1) + '.jpg');
				});
                       
				
				$('#review_dd2').hide();
				$('#review_dd').show();
				//첫 썸네일을 자동으로 미리보기에 세팅
				funSetPreviewImg($('.img-wrapper').eq(0), '0');
				alert('업로드 및 이미지 추출이 완료되었습니다.');
		    }, 
		    complete: function(xhr) {
		    },
		    error: function(e){
		    	console.log(e);   
		    	if((e.responseText).indexOf('THUMB_ERR') != -1){
		    		alert('영상 이미지 추출 중 오류가 발생했습니다\n새로고침 후 다시 진행 하시기 바랍니다');
			    	
		        	location.replace(location.href);
		    	}else{
		    		alert('영상 업로드 중 오류가 발생했습니다\n새로고침 후 다시 진행 하시기 바랍니다');
			    	
		        	location.replace(location.href);
		    	}
		    }
		}); 
		
		$("#file_frm").submit();
	}
	
}

function sleep(milliseconds){
	var start = new Date().getTime();
	
    for (var i = 0; i <= milliseconds; i++) {
    	if((new Date().getTime() - start) > milliseconds){
       		break;
      	}
    }
}

function getTimeStamp() {
 var d = new Date();

 var s =
   leadingZeros(d.getFullYear(), 4).substring(2,4) +
   leadingZeros(d.getMonth() + 1, 2) +
   leadingZeros(d.getDate(), 2) +

   leadingZeros(d.getHours(), 2) +
   leadingZeros(d.getMinutes(), 2) +
   leadingZeros(d.getSeconds(), 2) + 
   leadingZeros(d.getMilliseconds(), 2);
	  
  return s;
}

function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}



function funSetPreviewImg(obj, idx){
	$('#selPreviewImg').attr('src', $(obj).children().eq(0).attr('src')).css('margin-top','0px').css('width','180px').css('height','110px');
	$('#selThumbImgIdx').val(idx);
}

function funCategoryChg(obj){
	var selVal = $(obj).val();
	var sel2 = $('select[name=code_seq2]');
	
	if(selVal == ''){
		$(sel2).html('<option value="">선택</option>');
	}else{
		var param = {'p_code_seq':selVal, 'code_gubun':'2'};

		$.ajax({   
			url: "/kube/getCategoryCode.do",
			data: param,
			type: "POST",
			dataType: "json",
			async: false,
			success: function(msg) {
				
				var optHtml = '<option value="">선택</option>';
				
				if(msg != null && msg.length > 0){
					
					var forCnt = msg.length;
					
					for(var i = 0; i < forCnt; i++){
						optHtml = optHtml + "<option value='" + msg[i].code_seq + "'>" + msg[i].code_desc + "</option>";
					}
					 
					$(sel2).html(optHtml); 
				} 
			}
		});
	}
}

function funCancel(){
	if(confirm('영상 업로드를 취소 하시겠습니까?')){
		location.replace = "/videoWrite.do";
	}
}

function funSave(){

	var tmpIdx = '';
	var tmpTitle = '';

	$('input').each(function(index){
		if($.trim($(this).val()) == ''
				&& tmpIdx == ''
				&& $(this).attr('type') != 'hidden'
				&& $(this).attr('name') != 'vtt_File'
				&& $(this).attr('class') != 'upload-name'
			){
			tmpIdx = index;
			tmpTitle = $(this).attr('title');
		}
	});
	
	if(tmpIdx != ''){
		alert(tmpTitle + '을 입력하시기 바랍니다.');
		$('input').eq(tmpIdx).focus(); 
		return false;
	}
	
	tmpIdx = '';
	tmpTitle = '';
	
	$('select').each(function(index){
		if($.trim($(this).val()) == ''
				&& tmpIdx == ''){
			tmpIdx = index; 
			tmpTitle = $(this).attr('title');
		}
	});
	 
	if(tmpIdx != ''){
		alert(tmpTitle + '를 선택하시기 바랍니다.');
		$('select').eq(tmpIdx).focus();
		return false;
	}
	
	if($.trim($('#contents_desc').val()) == ''){
		alert('내용을 입력하시기 바랍니다.');
		$('#contents_desc').focus();
		return false;
	} 
	
	if(parseInt($('#progressBarRate').text()) < 100){
		alert('영상 업로드 중입니다. 업로드 완료 후 등록할 수 있습니다.');
		return false;
	}
	
	if($('#selPreviewImg').attr('src').indexOf('/resource/images/sub/icon_01.png') != -1){
		alert('영상 이미지 추출 중입니다. 잠시 후 등록할 수 있습니다.');
		return false;
	}
	 
	if(confirm('등록 하시겠습니까?')){
		funIfrmSubmit('/kube/insertVideoUpload.do');    
	}        
}

$(function() {
    $('#tag_desc').tagEditor({
         placeholder: '태그를 입력하세요. 입력 방법 : 태그 문구 입력 후 스페이스 바 입력 (ex: 태그1 태그2 태그3)',
         delimiter: ' ',
         onChange: function(field, editor, tags){
        	 //일단 삭제
        	 $('input[name=tagsInfo]').remove();
        	 
        	 for(var i = 0; i < tags.length; i++){
				$('#frm').append('<input type="hidden" name="tagsInfo" value="' + tags[i] + '" />');
        	 }
         }
     });
 });
</script>
<c:import url="/resource/common/include/kube_bottom.jsp" />