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
	<c:set var="videoArray" value="${fn:split(fn:replace(videoInfo.pds_log_path, '.mp4', ''), '/') }" />
    <div class="m_title_01" style="margin:10px 0 30px 0">동영상 수정</div> 
	<form id="frm" name="frm" method="post" enctype="multipart/form-data">
	<input type="hidden" id="vi_seq_hash" name="vi_seq_hash" value="${vi_seq_hash }" />
	<input type="hidden" id="p_code_seq" name="p_code_seq" /> 
	<input type="hidden" id="code_seq" name="code_seq" />
	<input type="hidden" id="tmpFileName2" name="tmpFileName2" value="${videoArray[fn:length(videoArray)-1] }" />
	    <table class="table-view">
	        <colgroup>
	            <col width="15%" />
	            <col />
	            <col width="15%" />
	            <col />
	        </colgroup>
		        <tr>
		            <th>공개권한</th>
		            <td>
		                    <label for=""></label>
		                    <select name="open_flag" class="selectbox" style="width:50%">
	                        	<c:forEach var="codeList" items="${codeList }">
		                            <c:if test="${codeList.code_gubun == 11}">
		                            	<option value="${codeList.code_seq}" ${videoInfo.open_flag == codeList.code_seq ? 'selected' : '' }>${codeList.code_desc}</option>
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
		                            	<option value="${codeList.code_seq}" ${videoInfo.download_flag == codeList.code_seq ? 'selected' : '' }>${codeList.code_desc}</option>
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
	                                	<option value="${codeList.code_seq}" ${videoInfo.mod_code_seq1 == codeList.code_seq ? 'selected' : '' }>${codeList.code_desc}</option>
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
		                    <input type="text" id="title" name="title" title="제목" value="${videoInfo.title}" class="textbox" maxlength="100"/>
		            </td>
		        </tr>
		        <tr>
		            <th>내용</th>
		            <td colspan="3">
		            	<textarea class="textarea" rows="8" cols="88" id="contents_desc" name="contents_desc" title="내용" style="width:100%">${videoInfo.contents_desc }</textarea>
		            </td>
		        </tr>
		        <tr>
		            <th>태그</th>
		            <td colspan="3">
		            	<c:forEach var="tagList" items="${tagList }">
		            		<c:set var="tagDesc">${tagDesc } ${tagList.tag_desc }</c:set>
		            	</c:forEach>
						<textarea class="textarea" rows="8" cols="88" id="tag_desc" name="tag_desc" title="태그" style="width:100%">${tagDesc }</textarea>
		            </td>
		        </tr>
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
	    </table>  
	</form>
    <div class="fl_right" style="margin:15px 0">
        <button type="button" onclick="javascript:funSave();" class="btn_black img_pointer">수정</button> 
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
<script type="text/javascript" src="/resource/common/js/jquery.caret.min.js"></script>   
<script type="text/javascript" src="/resource/common/js/jquery.tag-editor.min.js"></script>   
<script src="/resource/common/js/neodreams.js"></script>
<script src="/resource/common/js/jscript.js"></script>   

<script type="text/javascript">
$(document).ready(function() {
	funCategoryChg($('select[name="code_seq1"]'));
	
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
						if('${videoInfo.mod_code_seq2}' == msg[i].code_seq){
							optHtml = optHtml + "<option value='" + msg[i].code_seq + "' selected>" + msg[i].code_desc + "</option>";
						}else{
							optHtml = optHtml + "<option value='" + msg[i].code_seq + "'>" + msg[i].code_desc + "</option>";
						}
					}
					 
					$(sel2).html(optHtml); 
				} 
			}
		});
	}
}

function funCancel(){
	if(confirm('동영상 수정을 취소 하시겠습니까?')){
		history.back();
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
	
	if(confirm('수정 하시겠습니까?')){
		funIfrmSubmit('/kube/updateVideoInfo.do');    
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
 
 function goPageDetail(){
	 $('#p_code_seq').val($('select[name=code_seq1]').val());
	 $('#code_seq').val($('select[name=code_seq2]').val());
	 funGoPageDetail('/kube/watch/' + $('#vi_seq_hash').val());
 }
</script>
<c:import url="/resource/common/include/kube_bottom.jsp" />