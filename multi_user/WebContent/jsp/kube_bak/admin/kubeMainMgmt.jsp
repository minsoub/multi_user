<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
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
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;KUBE&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리자</b>
				</div>
				<div class="nav-title">메인화면 관리</div>
			</div>
            
            <div style="margin-bottom:10px;">
                <ul class="equip">
                    <li id="1" class="active"><a href="javascript:;">메인화면 관리</a></li>
                    <li id="2"><a href="javascript:;">카테고리 관리</a></li>
                    <li id="3"><a href="javascript:;">신고영상 관리</a></li>
                    <li id="6"><a href="javascript:;">영상 관리</a></li>
                    <li id="4"><a href="javascript:;">사용자 관리</a></li>
                    <li id="5"><a href="javascript:;">운영자 관리</a></li>
                </ul>
            </div>
            
            <form id="frm" name="frm" method="post" enctype="multipart/form-data">
	            
	            <c:if test="${fn:length(mainInfos) > 0}">
	            	<c:forEach var="mainInfos" items="${mainInfos}" varStatus="status">
	            		<c:if test="${status.index == 0}">
							<c:set var="imgWH" value="381px X 434px"></c:set>
						</c:if>
						<c:if test="${status.index == 1}">
							<c:set var="imgWH" value="327px X 217px"></c:set>
						</c:if>
						<c:if test="${status.index == 2}">
							<c:set var="imgWH" value="379px X 217px"></c:set>
						</c:if>
			            <div class="sub-nav-title-sm">화면 ${status.count}</div>		
						<div class="basic-list">
							<div class="insrtfrom-framebox">
							<div class="insert-step1-box">
								<div class="form-step1">
									<fieldset>
									<legend>화면 ${status.count}</legend>
										<div class="row-group">	
			                            	<dl class="insert_ready">
												<dt class="must-option"><label for="">URL 입력</label></dt>
												<dd><input type="text" name="url_info" title="URL 입력" value="${mainInfos.link_url }" style="width:580px" maxlength="300"></dd>
											</dl>
											<c:if test="${status.first }">
				                                <dl class="insert_ready">
													<dt class="must-option"><label for="">소제목</label></dt>
													<dd><input type="text" id="min_title" name="min_title" title="소제목" value="${mainInfos.caption_min_title }" style="width:580px" maxlength="100"></dd>
												</dl>
											</c:if> 
			                                <dl class="insert_ready">
												<dt class="must-option"><label for="">제목</label></dt>
												<dd><input type="text" name="cap_title" title="제목" value="${mainInfos.caption_title }" style="width:580px" maxlength="100"></dd>
											</dl>
			                                <dl class="insert_ready">
												<dt class="must-option"><label for="">썸네일 업로드</label></dt>
												<dd>
													<div class="filebox">
			 											<input type="text" class="upload-name" title="썸네일 업로드" value=${fn:length(mainInfos.thumb_file_name) > 0 ? mainInfos.thumb_file_name : '파일선택 '.concat(imgWH) } disabled="disabled">
			  											<label for="files${status.index }">업로드</label><%--id는 label떄메 index 사용 --%>
														<input class="upload-hidden" name="files" id="files${status.index }" title="썸네일 업로드" type="file" onchange="javascript:funFileInfoSet(this, '${status.index }');" />
														<c:if test="${fn:trim(mainInfos.thumb_file_name) != ''}">
															<div class="imgupload" style="margin-top: 5px;">
																<img class="imgObj${status.index}" src="${web_url.concat(mainInfos.thumb_log_path)}" />
															</div>
														</c:if>
														<c:if test="${fn:trim(mainInfos.thumb_file_name) == ''}">
															<div class="imgupload" style="display: none;margin-top: 5px;">
																<img src="" />
															</div>
														</c:if>
														<input type="hidden" name="mainSeq" value="${mainInfos.seq}" />
													</div>
												</dd>
											</dl>
										</div>
									</fieldset>
								</div>
			                </div>
			                </div>
						</div>
					</c:forEach>
	            </c:if>
	            <c:if test="${fn:length(mainInfos) == 0}">
	            	<c:forEach var="mainInfos" begin="0" end="2" step="1" varStatus="status">
	            		<c:if test="${status.index == 0}">
							<c:set var="imgWH" value="381px X 434px"></c:set>
						</c:if>
						<c:if test="${status.index == 1}">
							<c:set var="imgWH" value="327px X 217px"></c:set>
						</c:if>
						<c:if test="${status.index == 2}">
							<c:set var="imgWH" value="379px X 217px"></c:set>
						</c:if>
			            <div class="sub-nav-title-sm">화면 ${status.count}</div>		
						<div class="basic-list">
							<div class="insrtfrom-framebox">
							<div class="insert-step1-box">
								<div class="form-step1">
									<fieldset>
									<legend>화면 ${status.count}</legend>
										<div class="row-group">	
			                            	<dl class="insert_ready">
												<dt class="must-option">URL 입력</dt>
												<dd><input type="text" name="url_info" title="URL 입력" value="" style="width:580px" maxlength="300"></dd>
											</dl>
											<c:if test="${status.first }">
				                                <dl class="insert_ready">
													<dt class="must-option">소제목</dt>
													<dd><input type="text" id="min_title" name="min_title" title="소제목" value="" style="width:580px" maxlength="100"></dd>
												</dl>
											</c:if> 
			                                <dl class="insert_ready">
												<dt class="must-option">제목</dt> 
												<dd><input type="text" name="cap_title" title="제목" value="" style="width:580px" maxlength="100"></dd>
											</dl>
			                                <dl class="insert_ready">
												<dt class="must-option">썸네일 업로드</dt>
												<dd>
													<div class="filebox">
			 											<input type="text" class="upload-name" title="썸네일 업로드" value="파일선택 ${imgWH}" disabled="disabled">
			  											<label for="files${status.index }">업로드</label><%--id는 label떄메 index 사용 --%>
														<input class="upload-hidden" name="files" id="files${status.index }" title="썸네일 업로드" type="file" onchange="javascript:funFileInfoSet(this, '${status.index }');" />
														<div class="imgupload" style="display: none;margin-top: 5px;">
															<img src="" />
														</div>
														<input type="hidden" />
													</div>
												</dd>
											</dl>
										</div>
									</fieldset> 
								</div>
			                </div>
			                </div>
						</div>
					</c:forEach>
	            </c:if>
            </form> 
            
            <div class="btn-zone">
                <ul>
                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funCancel();" value="취소"></li>
                    <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:funMainLayerPreview();" value="미리보기" style="width:80px;" ></li>
                </ul>
            </div>
            
		</div>
		<!--content end-->
	</div>
</div>
<div id="mainPreviewDiv" style="width: 100%;height:1722px; position: absolute;top:153px; background-color: rgba(0, 0, 0, 0.8); display: none;">
	<div style="width: 800px; height:600px; margin-top: 70px; margin-left: 30%; background-color: #fff;" class="popup_view_box1">
		<h3 style="color:#fff">미리보기</h3>
		<div class="media-box" style="margin-top:35px;" >
    	<div style="float:left">
        <div class="media-text" style="margin-top:360px;"></div>
        <a class="preview_link" href="" target="_pre_link1"></a>
    </div>
    <div style="float:left">
        <div class="media-text" style="margin-top:180px;"></div>
        <a class="preview_link" href="" target="_pre_link2"></a>
    </div>
    <div style="float:left">
        <div class="media-text" style="margin-top:180px;"></div>
        <a class="preview_link" href="" target="_pre_link3"></a> 
    </div>                
</div>
<div class="btn-zone" style="margin-top:15px;">
<ul>
	<li><input type="button" class="search_btn" onclick="javascript:funClose();" value="취소"></li>
        <li><input type="button" class="search_btn" onclick="javascript:funSave()" value="등록"></li>
			</ul>
		</div>
	</div>
</div>
<iframe name="ifrm" id="ifrm" style="display: none;"></iframe>

<script type="text/javascript">
$(document).ready(function() {
	load_fnc('8', '0', '0'); //menu script
});

$('.equip > li').click(function (){
	var menu = $(this).attr('id');
	var linkUrl = '/kubeMainMgmt.do';
	
	if(menu == 2){
    	linkUrl = '/kubeCategoryMgmt.do';
	}else if(menu == 3){
		linkUrl = '/kubeReportMgmt.do';
	}else if(menu == 4){
		linkUrl = '/kubeUserMgmt.do';
	}else if(menu == 5){
		linkUrl = '/kubeSaMgmt.do';
	}else if(menu == 6){
		linkUrl = '/kubeVideoMgmt.do';
	}
	
	goUrl(linkUrl);
});

function funFileInfoSet(targetObj, idx){

	var ua = window.navigator.userAgent;
	
	if(navigator.appName == 'Netscape' && ua.indexOf('Trident/7.0') != -1){
		var file = $(targetObj).prop("files")[0];
		var preview = $(targetObj).next();
		var prevImg = $(targetObj).next().children();
		var hiddenForm = $(targetObj).next().next();	//수정 시 사용
		var width  = ['381','379','379'];
		var height = ['434','217','217'];
		
		if(file != null){
			var filename = file.name;
			var filedot = filename.lastIndexOf('.');
			var fileExt = filename.substring(filedot + 1, filename.length).toLowerCase();
			var IMG_FORMAT = "\.(gif|png|jpg|jpeg)$"; //파일 확장자 검사
			
			if (!(new RegExp(IMG_FORMAT, "i")).test(targetObj.value)) {
	      		alert("이미지 파일만 첨부하실 수 있습니다.\n\n확장자 : gif, png, jpg, jpeg");
	      		
	      		funImgFormReset(targetObj, img, preview, hiddenForm, width[idx], height[idx]);
	      		
	      		return false;
			}else{  
	           	//미리보기삭제. 중복 add 방지
	            if (prevImg){
	            	$(prevImg).remove(); 
	            }
	           	
	           	//객체 새로 생성
				var img = document.createElement("img");
	            
	            img.classList.add("imgObj" + idx);
	            img.file = file;
	            
	            //미리보기 영역에 삽입
	            $(preview).append(img);
	            
				if(window.FileReader){
	                var reader = new FileReader();

	                reader.readAsDataURL(file);
	                 
	            	reader.onload = function(file) {
	            		img.src    = file.target.result;
	            		img.onload = function() {
	                        if(width[idx] != this.width
	        			    		|| height[idx] != this.height){
	        			    	alert('이미지 규격이 맞지 않습니다\n가로 : ' + width[idx] + 'px, 세로 : ' + height[idx] + 'px 이미지를 업로드 하시기 바랍니다');
	        			    	
	        			    	funImgFormReset(targetObj, img, preview, hiddenForm, width[idx], height[idx]);
	        		      		
	        			    	return false;
	        			    }else{ 
	        					$(targetObj).prev().prev().val(filename);
	        					$(preview).css('display','block');
	        					$(hiddenForm).remove();	//신규, 수정 시 hidden값 제거
	        			    }
	                    };
	                };
	            }else{
	             	var info = document.createElement("<p>"); 
	                info.innerHTML = "지원하지 않는 브라우저 입니다\n관리자에게 문의하시기 바랍니다";
	                
	                funImgFormReset(targetObj, img, preview, hiddenForm, width[idx], height[idx]);
	            }
			}
		}
	}else{
		alert('IE 11 이상 사용 가능합니다.');
		$(targetObj).val('');
	}
}

function funImgFormReset(targetObj, img, preview, hiddenForm, width, height){
	$(targetObj).val('');
    $(targetObj).prev().prev().val('파일선택 ' + width + 'px X ' + height + 'px');
	$(img).remove();
	$(preview).css('display','none');
	$(hiddenForm).remove();
}

function funCancel(){
	if(confirm('취소 하시겠습니까?')){
		location.replace('/kubeMainMgmt.do');
	}
}

function funMainLayerPreview(){
	
	if(funFormChk()){
		var mainPreviewDiv = $('#mainPreviewDiv');
		$('.media-text').html('');
		$('.preview_link').html('');
		
		for(var i = 0; i < 3; i++){
			if(i == 0){
				$('.media-text').eq(i).append('<p>' + $('#min_title').val() + '</p><br />').append('<p style="font-size:30px;">' + $('input[name=cap_title]').eq(i).val() + '</p>');
			}else{
				$('.media-text').eq(i).append('<p>' + $('input[name=cap_title]').eq(i).val() + '</p>');
			}
			
			$('.preview_link').eq(i).attr('href',$('input[name=url_info]').eq(i).val());
			$('.preview_link').eq(i).append($('.imgObj' + i).clone());
		}
		
		$(mainPreviewDiv).show();
        $('html, body').animate({scrollTop : 0}, 0);
	}
}

function funClose(){
	$('#mainPreviewDiv').hide();
}

function funSave(){
	
	if(funFormChk()){
		if(confirm('등록 하시겠습니까?')){
			funIfrmSubmit('/kube/insertUpdateMainMgmt.do');
		}
	}
}

function funFormChk(){
	var chkIdx = -1; 
	var tmpTitle = '';
	var tmpType = '';
 
	$('input').each(function(index){
		if($(this).attr('type') == 'text'){
			if(($.trim($(this).val()) == '' || $.trim($(this).val()).indexOf('파일선택') != -1)
					&& chkIdx == -1){
				chkIdx 		= index;
				tmpTitle 	= $(this).attr('title');
				tmpType 	= $(this).attr('type');
			}
		}
	});
	
	if(chkIdx >= 0){
		alert(tmpTitle + ' 입력은 필수 입니다');
		
		if(tmpType == 'text'){
			$('input').eq(chkIdx).focus();
		}
		return false;
	}else{
		return true;
	}
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />