<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<!DOCTYPE html>
<html>
<head>    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">

<link rel="stylesheet" type="text/css" href="/resource/common/css/basic.css" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/main.css" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/jquery-1.12.1-ui.css" />

<title>멀티미디어센터</title>
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
</style>
</head>
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />
<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="9"></c:param>
			</c:import>
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub9_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;KUBE&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">업로드</b>
				</div>
				<div class="nav-title">업로드</div> 
			</div>
            
            <div class="sub-nav-title-sm">업로드 사항 기재</div>		
       
			<div class="basic-list"> 
				<div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
							<fieldset>
							<legend>화면1</legend>
								<div class="row-group">	
	                            	<dl class="insert_ready">
										<dt class="must-option"><label for="" id="">진행상태</label></dt>
										<dd>
	                                        <div class="btn-zone" style="float:left; margin-top:25px">      
	                                        	<form id="file_frm" name="file_frm" method="post" enctype="multipart/form-data">
	                                        		<input type="hidden" id="video_duration" name="video_duration" />
	                                        		<input type="hidden" id="tmpFileName" name="tmpFileName" />
													<input type="hidden" id="tmpFileExt" name="tmpFileExt" /> 
		                                            <input type="button" id="srchDescription" name="srchDescription" class="search_btn" onclick="javascript:$('#uploadFile').trigger('click')" value="클릭하여 파일을 업로드 하세요" style="width:390px;height:30px; background-color:#ff9620">
		                                            <input type="file" id="uploadFile" name="uploadFile" title="영상 파일" style="display: none;" onclick="javascript:submitChk = false;" onchange="javascript:funFileChg(this);" accept="video/*"/>
		                                            <p id="progressP" style="display: none;"><progress id="progressBar" min="0" max="100" value="0" style="width:390px;height:30px;"></progress></p>
		                                        </form>
	                                        </div>
	                                        <div class="media-img-box" style="float:right; margin-left:10px">
	                                            <img id="selPreviewImg" src="/resource/images/sub/icon_01.png" style="margin-top:30px"/>
	                                        </div>
	                                    </dd>
									</dl>
									<form id="frm" name="frm" method="post">
										<input type="hidden" id="selThumbImgIdx" name="selThumbImgIdx" />		
										<input type="hidden" id="cid" name="cid" />		
										<input type="hidden" id="oriFileName" name="oriFileName" />
										<input type="hidden" id="tmpFileName2" name="tmpFileName2" />
										<input type="hidden" id="tmpFileSize" name="tmpFileSize" />
		                                <dl class="insert_ready">
											<dt class="must-option"><label for="" id="">공개권한</label></dt>
											<dd>                                    
		                                    	<fieldset>	
		                                        	<div class="form-group">
		                                            <legend>공개권한</legend>                        
		                                            	<div>
		                                                  <p class="inputDesign">
		                                                  <select name="open_flag" style="width:150px">
		                                                    	<c:forEach var="codeList" items="${codeList }">
		                                                      		<c:if test="${codeList.code_gubun == 11}">
		                                                        		<option value="${codeList.code_seq}">${codeList.code_desc}</option>
																	</c:if>
																</c:forEach> 								                                    
		                                                  </select>
			                        					</div>
		                                          </div>
		                                      </fieldset>
		                                    </dd>
		                                    <dt class="must-option"><label for="" id="">다운로드권한</label></dt>
											<dd>                                    
		                                            <fieldset>	
		                                                <div class="form-group">
		                                                    <legend>다운로드권한</legend>                        
		                                                    <div>
		                                                        <p class="inputDesign">
		                                                        <select name="download_flag" style="width:150px">
		                                                        	<c:forEach var="codeList" items="${codeList }">
		                                                        		<c:if test="${codeList.code_gubun == 12}">
			                                                            	<option value="${codeList.code_seq}">${codeList.code_desc}</option>
																		</c:if>
		                                                            </c:forEach> 								                                    
		                                                        </select>
									                        </div>
		                                                </div>
		                                            </fieldset>
		                                    </dd>
										</dl>
		                                
		                                <dl class="insert_ready">
											<dt class="must-option"><label for="" id="">카테고리</label></dt>
											<dd>                                    
		                                            <fieldset>	
		                                                <div class="form-group">
		                                                    <legend>카테고리</legend>                        
		                                                    <div>
		                                                        <p class="inputDesign">                
		                                                        <select name="code_seq1" title="카테고리" style="width:150px" onchange="javascript:funCategoryChg(this);">
		                                                        	<option value="">선택</option>
		                                                            <c:forEach var="codeList" items="${codeList }">
		                                                        		<c:if test="${codeList.code_gubun == 1}">
			                                                            	<option value="${codeList.code_seq}">${codeList.code_desc}</option>
																		</c:if>
		                                                            </c:forEach> 	         
		                                                        </select>
		                                                        <p class="inputDesign">
		                                                        <select name="code_seq2" title="카테고리" style="width:150px">
		                                                        	<option value="">선택</option>
		                                                        </select>
									                        </div>
		                                                </div>
		                                            </fieldset>
		                                    </dd>
										</dl>
		                                <dl class="insert_ready">
											<dt class="must-option"><label for="" id="">제목</label></dt>
											<dd><input type="text" id="title" name="title" title="제목" style="width:580px" maxlength="100"></dd>
										</dl>
		                                <dl class="insert_ready">
											<dt class="must-option"><label for="" id="">내용</label></dt>
											<dd><textarea class="textarea-style" rows="8" cols="88" id="contents_desc" name="contents_desc" title="내용"></textarea></dd>
										</dl>
		                                <dl class="insert_ready">
											<dt class="must-option"><label for="" id="">미리보기<br>이미지 선택</label></dt>
											<dd id="review_dd" style="display: none;">
		                                        <div class="media-img-box" style="float:left;">
		                                        	<div class="img-wrapper" onclick="javascript:funSetPreviewImg(this, '0');"> 
			                                            <img name="videoThumb" style="width: 180px; height: 110px;" />
			                                            <input type="hidden" name="thumb_url" />
			                                            <div class="darkness"></div>
			      										<div class="btn-plus"><span draggable="false">미리보기 이미지로 선택</span></div>
			      									</div>
		                                        </div>
		                                        <div class="media-img-box" style="float:left; margin-left:15px;">
		                                        	<div class="img-wrapper" onclick="javascript:funSetPreviewImg(this, '1');">
			                                            <img name="videoThumb" style="width: 180px; height: 110px;" />
			                                            <input type="hidden" name="thumb_url" />
			                                            <div class="darkness"></div>
				      									<div class="btn-plus"><span draggable="false">미리보기 이미지로 선택</span></div>
				      								</div>
		                                        </div>
		                                        <div class="media-img-box" style="float:left; margin-left:15px;">
		                                            <div class="img-wrapper" onclick="javascript:funSetPreviewImg(this, '2');">
			                                            <img name="videoThumb" style="width: 180px; height: 110px;" />
			                                            <input type="hidden" name="thumb_url" />
			                                            <div class="darkness"></div>
				      									<div class="btn-plus"><span draggable="false">미리보기 이미지로 선택</span></div>
				      								</div> 
		                                        </div>
		                                        <div class="media-img-box" style="float:left; margin-top: 5px;;"> 
		                                            <div class="img-wrapper" onclick="javascript:funSetPreviewImg(this, '3');">
			                                            <img name="videoThumb" style="width: 180px; height: 110px;" />
			                                            <input type="hidden" name="thumb_url" />
			                                            <div class="darkness"></div>
				      									<div class="btn-plus"><span draggable="false">미리보기 이미지로 선택</span></div>
				      								</div>
		                                        </div>
		                                        <div class="media-img-box" style="float:left; margin-top: 5px; margin-left:15px;">
		                                            <div class="img-wrapper" onclick="javascript:funSetPreviewImg(this, '4');">
			                                            <img name="videoThumb" style="width: 180px; height: 110px;" />
			                                            <input type="hidden" name="thumb_url" />
			                                            <div class="darkness"></div>
				      									<div class="btn-plus"><span draggable="false">미리보기 이미지로 선택</span></div>
				      								</div>
		                                        </div>
		                                        <div class="media-img-box" style="float:left; margin-top: 5px; margin-left:15px;">
		                                            <div class="img-wrapper" onclick="javascript:funSetPreviewImg(this, '5');">
		                                            	<img name="videoThumb" style="width: 180px; height: 110px;" />
			                                            <input type="hidden" name="thumb_url" />
			                                            <div class="darkness"></div>
				      									<div class="btn-plus"><span draggable="false">미리보기 이미지로 선택</span></div>
				      								</div>
		                                        </div>
		                                    </dd> 
		                                    <dd id="review_dd2">
		                                        <div class="media-img-box" style="float:left">
		                                            <img src="/resource/images/sub/icon_02.png" style="margin-top:30px"/>
		                                        </div>
		                                        <div class="media-img-box" style="float:left; margin-left:15px">
		                                            <img src="/resource/images/sub/icon_02.png" style="margin-top:30px"/>
		                                        </div>
		                                        <div class="media-img-box" style="float:left; margin-left:15px">
		                                            <img src="/resource/images/sub/icon_02.png" style="margin-top:30px"/>
		                                        </div>
		                                        <div class="media-img-box" style="float:left; margin-top: 5px;"> 
		                                            <img src="/resource/images/sub/icon_02.png" style="margin-top:30px"/>
		                                        </div>
		                                        <div class="media-img-box" style="float:left; margin-top: 5px; margin-left:15px">
		                                            <img src="/resource/images/sub/icon_02.png" style="margin-top:30px"/>
		                                        </div>
		                                        <div class="media-img-box" style="float:left; margin-top: 5px; margin-left:15px">
		                                            <img src="/resource/images/sub/icon_02.png" style="margin-top:30px"/>
		                                        </div>
		                                    </dd>
										</dl>
									</form>
								</div>
							</fieldset>
						</div>
	                </div>
                </div>
			</div>
            
            
            <div class="btn-zone">
                <ul>
                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funSave();" value="등록"></li>
                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funCancel();" value="취소"></li>
                </ul>
            </div>



		</div>
		<!--content end-->
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
<script src="/resource/common/js/neodreams.js"></script>
<script src="/resource/common/js/jscript.js"></script>   

<script type="text/javascript">
$(document).ready(function() {
	load_fnc('8', '0', '0'); //menu script
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
		    },
		    uploadProgress: function(event, position, total, percentComplete) {
		    	$('#progressBar').val(percentComplete);
		    	$('#srchDescription').val('영상 업로드 진행 중');
		    	
		    	if(percentComplete == 100){
		    		$('#srchDescription').val('영상 이미지 추출 중');		    		
		    	}
		    },
		    success: function(msg) {     
				$('#srchDescription').val('업로드 완료. 미리보기 이미지를 선택하세요');
				$('#progressP').hide();

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
	
    for (var i = 0; i < 1e7; i++) {
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
		$(sel2).jqTransSelect();
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
					
					$(sel2).jqTransSelect();
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
				&& $(this).attr('type') != 'hidden'){
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
	
	if(parseInt($('#progressBar').val()) < 100){
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
</script>
<c:import url="/resource/common/include/bottom.jsp" />