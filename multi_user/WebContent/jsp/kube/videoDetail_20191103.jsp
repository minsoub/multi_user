<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/kube_topMenu.jsp" />
<c:import url="/resource/common/include/kube_leftMenu.jsp" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/jquery.tag-editor.css" />
<div id="contents">
                            
	<form id="frm" name="frm" method="post">
		<input type="hidden" id="code_seq" name="code_seq" value="${code_seq }">
		<input type="hidden" id="p_code_seq" name="p_code_seq" value="${p_code_seq }">
		<input type="hidden" id="vi_seq_hash" name="vi_seq_hash" value="${vi_seq_hash}">
		<input type="hidden" id="c" name="c" value="${cha:seqEncode(code_seq)}">
		<input type="hidden" id="p" name="p" value="${cha:seqEncode(p_code_seq)}">
		<input type="hidden" id="target_vc_seq" name="target_vc_seq" value="LX4IaGcnTLA8InG">
		<input type="hidden" id="target_vc_seq_idx" name="target_vc_seq_idx" value="0">
		<input type="hidden" id="pre_approve" name="pre_approve" value="${videoInfo.pre_approve}">
		<input type="hidden" id="orderVal" name="orderVal" value="${orderVal}">
		<input type="hidden" id="autoplay" name="autoplay" value="${autoplay}">
		<input type="hidden" id="right_gubun" name=right_gubun value="${right_gubun}">
		<input type="hidden" id="srh_keyword" name="srh_keyword" />
		<c:forEach var="chkVideoSeqArr" items="${chkVideoSeqArr }"> 
			<input type="hidden" id="chkVideoSeqArr" name=chkVideoSeqArr value="${chkVideoSeqArr}">
		</c:forEach>
		<!-- 우측 리스트 중 현재 재생 영상 번호 관리 -->
		<input type="hidden" id="nextNum" name="nextNum" value="${nextNum }" />

		<%-- 코드 변경으로 다운로드 강제 요청 시 df 값과 비교 처리 후 다운 진행 --%>
		<input type="hidden" id="df" name="df" value="${videoInfo.download_flag }">
	    <div class="view-box">
	        <div class="view_box01 fl_left">
	            <div id="playerDiv" style="width:100%;height: 600px;"> 
	                <c:if test="${videoInfo.conv_flag == '1'}">
	                 	<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="100%"
			                    id="GMPlayer"
			                    codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
			                <param name="movie" value="/resource/common/kube_video/GMPlayer.swf" /> <!-- 플레이어 swf  경로 설정 -->
			                <param name="quality" value="high" />
			                <param name="bgcolor" value="#869ca7" />
			                <param name="allowScriptAccess" value="sameDomain" />
			                <param name="wmode" value="opaque" />
			                <param name="allowFullScreen" value="true" />
			                <!-- 플레이어 swf  경로 설정 -->
			                <embed src="/resource/common/kube_video/GMPlayer.swf" quality="high" bgcolor="#869ca7" 
			                       width="100%" height="100%" name="GMPlayer" align="middle"
			                       play="true"
			                       loop="false"
			                       quality="high"
			                       wmode ="opaque"
			                       allowScriptAccess="sameDomain"
			                       allowFullScreen ="true"
			                       type="application/x-shockwave-flash"
			                       pluginspage="http://www.adobe.com/go/getflashplayer" >
			                </embed>
			            </object>
	                 </c:if>
	                 <c:if test="${videoInfo.conv_flag == '9'}">
	                 	<img src="${web_url.concat(videoInfo.thumb_log_path)}" class="imgMaxWidth760" />
	                 </c:if>
	            </div>                               
	            
	            <div class="title-box">
	                <div class="fl_left" style="margin-bottom:30px;">
	                    <span class="media_tit1">
	                        ${videoInfo.title}<c:if test="${videoInfo.conv_flag == '9'}"> (영상 컨버팅 진행 중)</c:if><c:if test="${videoInfo.reg_empno ==  sessionScope.SESS_EMPNO}"><a class="txt_box" style="background-color:#ffffff; margin-left: 15px;cursor: pointer;" onclick="javascript:funGoPageDetail('/videoMoidfy.do');">수정</a><a class="txt_box" style="background-color:#f7f7f7; margin-left: 10px;cursor: pointer;" onclick="javascript:funTaskAct();">삭제</a></c:if>
	                    </span>
	                </div>
	                <div class="fl_right">
	                    <img name="${videoInfo.v_like_cnt == 0 ? '2' : '3'}" src="/resource/images/sub/icon_kube0${videoInfo.v_like_cnt == 0 ? '2' : '3'}.png" style="cursor: pointer;" onclick="javascript:funMyAct(this);" /> <span class="num_gray"><fmt:formatNumber value="${videoInfo.like_cnt}" pattern="#,###,###,###" /></span>
	                    <img name="${videoInfo.v_unlike_cnt == 0 ? '4' : '5'}" src="/resource/images/sub/icon_kube0${videoInfo.v_unlike_cnt == 0 ? '4' : '5'}.png" style="margin-left:10px;cursor: pointer;" onclick="javascript:funMyAct(this);" /> <span class="num_gray"><fmt:formatNumber value="${videoInfo.unlike_cnt}" pattern="#,###,###,###" /></span>
	                    
	                    <c:if test="${videoInfo.conv_flag == '1'}">
							<c:if test="${videoInfo.reg_empno ==  sessionScope.SESS_EMPNO}">
								<img alt="" src="/resource/kube_images/btn_download.png" style="cursor: pointer;margin-left:20px;" onclick="javascript:funFileDownAct();">
							</c:if>
							<%--41 모두 다운로드 가능	42 승인자만 다운로드	43 다운로드 불가 --%>
							<c:if test="${videoInfo.reg_empno !=  sessionScope.SESS_EMPNO}">
		                		<c:if test="${videoInfo.download_flag == 41 || videoInfo.download_flag == 42}">
		                    		<img alt="" src="/resource/images/sub/btn_download.png" style="cursor: pointer;margin-left:20px;" onclick="javascript:funFileDown('${videoInfo.download_flag}');">
		                    	</c:if>
		                    </c:if>
		                </c:if>   
	                </div>                                  
	                
	                <div style="clear:both"></div>
	                <div style="border-bottom: 1px solid #d5d5d5;"></div>
	                <div class="fl_left" style="margin-top:30px">
	                    <span class="media_name">게시일 : ${cha:todate(videoInfo.reg_date, '-', '3') }   ㅣ   ▷<fmt:formatNumber value="${videoInfo.visit_cnt}" pattern="#,###,###,###" /></span><br>
	                    <span class="media_name" onclick="javascript:userLayer('${videoInfo.reg_empno}')" style="cursor: pointer;">등록자 : ${videoInfo.dept_name1} ${videoInfo.dept_name2 } ${videoInfo.writer }</span>             
	                </div>
	                <div class="fl_right" style="margin-top:45px">
	                    <a id="descOpen" class="txt_box_s" style="cursor: pointer;" onclick="javascript:funExpand(this, 'Y');"><img src="/resource/kube_images/icon_06.png" style="margin-right:10px" />펼침</a> 
	                    <a class="txt_box" style="cursor: pointer;display: none;" onclick="javascript:funExpand(this, 'N');"><img src="/resource/kube_images/icon_09.png" style="margin-right:10px" />닫힘</a> 
	                    <a class="txt_box" style="cursor: pointer;" href="#recent"><img id="totCmmCnt" src="/resource/kube_images/icon_07.png" style="margin-right:10px" /><font><fmt:formatNumber value="${videoInfo.comment_cnt}" pattern="#,###,###,###"/></font></a> 
	                    <a class="txt_box" style="cursor: pointer;" onclick="javascript:funMyAct($(this).children().eq(0));"><img name="${videoInfo.v_favor_cnt == 0 ? '6' : '7'}" src="/resource/images/sub/icon_kube0${videoInfo.v_favor_cnt == 0 ? '6' : '7'}.png" style="margin-right:10px" /><font><fmt:formatNumber value="${videoInfo.favor_cnt}" pattern="#,###,###,###" /></font></a> 
	                    <a class="txt_box" style="cursor: pointer;" onclick="javascript:funReportShow('1');"><img id="totCmmCnt" src="/resource/kube_images/icon_07_1.png" style="margin-right:5px; width:13px; height:15px; margin-top: -4px;" />영상신고</a>
	                </div> 
		                    
	                <div style="clear:both"></div>
                    <div id="contents_div" style="margin-top: 20px;height:35px;overflow: hidden;word-wrap: break-word;">
	                	<pre>${videoInfo.contents_desc }</pre>
	                </div>
                	<br />
                	<ul class="tag-editor ui-sortable">
                	<c:forEach var="tagList" items="${tagList }">
                		<li style="width:1px" class="ui-sortable-handle">&nbsp;</li><li><div class="tag-editor-spacer">&nbsp; </div><div class="tag-editor-tag" onclick="javascript:$('#srh_keyword').val('${tagList.tag_desc }'); funGoPageDetail('/kube/channel/${videoInfo.channel}/${cha:seqEncode(p_code_seq)}/${cha:seqEncode(code_seq)}');">${tagList.tag_desc }</div></li>
                	</c:forEach>
                	</ul>
	            </div>
	        </div> 
	        
	        <div class="view_box02 fl_right">
	            <div class="txt_tit">
	            	<c:if test="${right_gubun == 'R'}">추천 영상</c:if>
	                <c:if test="${right_gubun == 'M'}">즐겨찾기영상</c:if>
				</div>
	            <div id="rightVideoDiv" style="text-align:center; height:50px; border-bottom:1px solid #ececec; padding-top:10px;">
	            	<c:if test="${autoplay == '1'}">
                    	<img class="playImg1" src="/resource/kube_images/play_01.png" style="cursor: pointer;" onclick="javascript:funPlayCtrl(this, '1', '2');" />
                    </c:if>
                	<c:if test="${autoplay != '1'}">
                    	<img class="playImg1" src="/resource/kube_images/play_01_off.png" style="cursor: pointer;" onclick="javascript:funPlayCtrl(this, '1', '2');" />
                    </c:if>
                    <c:if test="${autoplay == '2'}">
                    	<img class="playImg2" src="/resource/kube_images/play_02.png" style="cursor: pointer;" onclick="javascript:funPlayCtrl(this, '2', '1');" />
                    </c:if>	
                    <c:if test="${autoplay != '2'}">
                    	<img class="playImg2" src="/resource/kube_images/play_02_off.png" style="cursor: pointer;" onclick="javascript:funPlayCtrl(this, '2', '1');" />
                    </c:if>	
	            </div>
	            
	        </div>
	    </div>
	    
	    
	    <div style="clear:both"></div>
	    <div class="reply-box">
	        <div>
	            <div class="title_01" style="margin:30px 0 20px 0">댓글</div>                
	            <div>
	                <textarea class="textarea" rows="4"  name="comment_desc" style="width:90%"></textarea>                                    
	                <button type="button" onclick="javascript:funCommentReg(this, '0')" value="등록" class="btn_blue" style="height:69px;cursor: pointer;">등록</button>
	                <input type="hidden" name="p_vc" value="LX4IaGcnTLA8InG" />
	            </div>
	            
	        </div>                            
	        <div id="comment_div" style="display:none; margin-top:20px; border-bottom: 1px solid #cecece; height:35px;">
	        	<div class="kubeCommentBtn_div">
		            <img src="/resource/kube_images/icon_06.png" style="margin-right:10px" /><a id="recent"></a><span class="img_pointer" onclick="javascript:funGetCommentList('R');">최신 댓글 순</span> &nbsp;&nbsp;
		            <span class="media_name"><a id="popular"></a><span class="img_pointer" onclick="javascript:funGetCommentList('P');">인기 댓글 순</span></span>
	            </div>
	            <div class="kubeCommentBtn_div">
		            <span class="media_name"><a id="recent"></a><span class="img_pointer" onclick="javascript:funGetCommentList('R');">최신 댓글 순</span></span> &nbsp;&nbsp;
		            <img src="/resource/kube_images/icon_06.png" style="margin-right:10px" /><a id="popular"></a><span class="img_pointer" onclick="javascript:funGetCommentList('P');">인기 댓글 순</span>
		        </div>
	        </div>
	        <div id="commentTbody">
	        </div>
	    </div>
	</form>
</div>

<div style="width: 100%;height:100%; position: absolute;top:0px; z-index:1; background-color: rgba(0, 0, 0, 0.8); display: none;">
	<div id="approve_div" class="popup_view_box1" style="display: none; z-index:2; width:350px; background-color: #fff;background-image: url('/resource/kube_images/top_bg.png');">
	<h3 style="color:#fff">다운로드 안내</h3>
	    <div style="margin-top:35px; line-height:25px;">
	        해당 영상은 저작권자의 승인 후 다운로드가 가능합니다. <br>
	        승인 요청하시겠습니까? <br>
	        승인 여부는 마이페이지에서 확인하실 수 있습니다
	    </div> 
	    
	    <div class="btn-zone" style="margin-top:15px;">
			<ul>
	            <li><input type="button" name="" class="search_btn" onclick="javascript:funApproveReq();" value="승인요청"></li>
				<li><input type="button" name="" class="search_btn" onclick="javascript:$('#approve_div').parent().hide();" value="취소"></li>
			</ul>
		</div>
	</div>
</div> 

   
<div style="width: 100%;height:100%; position: absolute;top:0px; z-index:1; background-color: rgba(0, 0, 0, 0.8); display: none;">
	<div id="report_div" class="popup_view_box1" style="width:650px; z-index:2; background-color: #fff;background-image: url('/resource/kube_images/top_bg.png');">
	<h3 style="color:#fff">신고하기</h3>
	    <div class="basic-list" style="margin-top:35px;">
	        <form id="rfrm" name="rfrm" method="post">		
	        <input type="hidden" id="vi_seq_hash_r" name="vi_seq_hash_r">
	        <input type="hidden" id="vc_seq_hash_r" name="vc_seq_hash_r">
			<input type="hidden" id="report_gubun" name="report_gubun">		
	            <div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
								<div class="row-group">	                                
	                                <dl class="insert_ready">
										<dt class="must-option"><label for="" id="">신고분류</label></dt>
										<dd>                                    
                                                <div class="form-group">
                                                    <div>
                                                        <select name="selReport" style="width:200px;padding-top:0px;padding-right: 33px;">
                                                            <option value="">선택</option>
                                                            <c:forEach var="codeList" items="${codeList }">
	                                                        	<option value="${codeList.code_seq}">${codeList.code_desc}</option>
															</c:forEach>				                                    
                                                        </select><br /><b>※ 등록된 신고 내용은 취소가 불가능합니다.</b>
							                        </div>
                                                </div>
	                                    </dd>
									</dl>
	                                <dl class="insert_ready">
										<dt class="must-option"><label for="" id="">신고사유</label></dt>
										<dd><textarea rows="6" cols="50" id="re_desc" name="re_desc"></textarea></dd>
									</dl>
								</div>
						</div>
	                </div>
	            </div>
	        </form>
	    </div>    
	    <div class="btn-zone">
			<ul>
	            <li><input type="button" name="" class="search_btn" onclick="javascript:funReport();" value="신고"></li>
				<li><input type="button" name="" class="search_btn" onclick="javascript:$('#report_div').parent().hide();" value="취소"></li>
			</ul>
		</div>
	</div>
</div>


<div style="width: 100%;height:100%; position: absolute;top:0px; z-index:1; background-color: rgba(0, 0, 0, 0.8); display: none;">
	<div id="approve_div" class="popup_view_box1" style="display: none; z-index:2; width:350px; background-color: #fff;background-image: url('/resource/kube_images/top_bg.png');">
	<h3 style="color:#fff">다운로드 안내</h3>
	    <div style="margin-top:35px; line-height:25px;">
	        해당 영상은 저작권자의 승인 후 다운로드가 가능합니다. <br>
	        승인 요청하시겠습니까? <br>
	        승인 여부는 마이페이지에서 확인하실 수 있습니다
	    </div> 
	    
	    <div class="btn-zone" style="margin-top:15px;">
			<ul>
	            <li><input type="button" name="" class="search_btn" onclick="javascript:funApproveReq();" value="승인요청"></li>
				<li><input type="button" name="" class="search_btn" onclick="javascript:$('#approve_div').parent().hide();" value="취소"></li>
			</ul>
		</div>
	</div>
</div> 

<div style="width: 100%;height:100%; position: absolute;top:0px; z-index:1; background-color: rgba(0, 0, 0, 0.8); display: none;">
	<div id="continueView_div" class="popup_view_box1" style="display: none; z-index:2; width:350px; background-color: #fff;background-image: url('/resource/kube_images/top_bg.png');">
	<h3 style="color:#fff">재생 안내</h3>
	    <div style="margin-top:35px; line-height:25px;">
	        기존 시청 이력이 있습니다.
	    </div> 
	    
	    <div class="btn-zone" style="margin-top:15px;">
			<ul>
	            <li><input type="button" name="" class="search_btn" onclick="javascript:funElearnView('C');" value="이어보기"></li>
				<li><input type="button" name="" class="search_btn" onclick="javascript:funElearnView('F');" value="처음부터"></li>
			</ul>
		</div>
	</div>
</div>

<div style="width: 100%;height:100%; position: absolute;top:0px; z-index:1; background-color: rgba(0, 0, 0, 0.8); display: none;">
	<div id="percentView_div" class="popup_view_box1" style="display: none; z-index:2; width:370px; background-color: #fff;background-image: url('/resource/kube_images/top_bg.png');">
	<h3 style="color:#fff">이수 안내</h3>
	    <div style="margin-top:35px; line-height:25px;">
	        90% 이상 시청하여 본 교육을 이수하였습니다.<br />계속 시청하시겠습니까? 
	    </div> 
	    
	    <div class="btn-zone" style="margin-top:15px;">
			<ul>
	            <li><input type="button" name="" class="search_btn" onclick="javascript:funElearnView('C');" value="이어보기"></li>
				<li><input type="button" name="" class="search_btn" onclick="javascript:funElearnView('N');" value="아니오"></li>
			</ul>
		</div>
	</div>
</div> 

<%-- e-러닝 제어 관련 입력 값 --%>
<c:set var="eduPercent" value="${elearnUserMap.play_duration_sec * 100 / videoInfo.duration }" />
<input type="hidden" id="elearnComplete_flag" name="elearnComplete_flag"  value="${elearnUserMap.complete_flag}" />
<input type="hidden" id="elearnComplete_per" name="elearnComplete_per"  value="${eduPercent}" />

<script type="text/javascript" src="/resource/common/kube_video/js/browser.js"></script>
<script type="text/javascript">
var gmplayer = null;
var gmAutoPlay = true;
var gmEduComplete = true;
var gmPlayTime = '0';

$(function() {
    objDetectBrowser(); // 브라우져 버전 체크	
});

// 크로스 도메인 URL 정보 호출
// 플레이어와 영상, 이미지가 다른 서버인 경우 설정 필요
function getCrossDomain(){
	return "<%= Constants.KUBE_UPLOAD_ASP_IP %>/crossdomain.xml";
	/* return "http://localhost:8091/GMPlayer/crossdomain.xml"; */
}

//플레이어 로딩 완료
function GMPlayerCreationComplete(){
	if (browser != "IE") { // IE11 및 크롬, 사파리, 파이어 폭츠 
        gmplayer = $("embed[name=GMPlayer]").get(0);
		
		if(gmplayer == null || gmplayer == "undefined"){
		  gmplayer = document.getElementById("GMPlayer");
		}

    } else { // IE10 이하
        gmplayer = document.getElementById("GMPlayer");
    }

	playerCtrl();
}


//재생시작, 일시정지, 정지  이벤트마다 플레이어에서 호출하는 함수 (return 값으로 현재 재생되고있는 영상의 플레이시간을 받음)
//status : 1 - 재생시작, 2 - 일시정지, 9 - 정지
function playTime(time, status){
	
	//중간 저장 시점을 저장함
	if('${videoInfo.channel}' == 'elearn'
		&& $('#elearnComplete_flag').val() == 0
		&& status != 1){

		var timePer = parseInt(time * 100 / ${videoInfo.duration });
		
		//정지시 기존 이어보기 시간에 영향받지 않기 위함
		if(status == 9){
			setCurrentTime(time);
		}
		
		if(90 <= timePer){
			//90% 이상은 교육 이수처리는 하되 중간 시간을 저장한다
			updateElearnVideoUserMap('3', parseInt(time));
		}else{
			updateElearnVideoUserMap('0', parseInt(time));
		}
	}
}

function getCurrentTime(){ // 현재 재생되고 있는 영상의 플레이 시간을 받는 함수(플레이어에 요청)
	var time = 0;

	if(gmplayer != null && gmplayer != "undefined"){
		time =  gmplayer.getPlayTime(); // 플레이어에 요청하는 함수
	}
	
	return time;
}

function setCurrentTime(time){
	if(gmplayer != null && gmplayer != "undefined"){
		gmplayer.setPlayTime(time); // 영상 시작지점 설정
	}
}

// 영상의 재생이 완료되면 호출되는 함수
function playComplete(){

	if('${videoInfo.channel}' == 'elearn'){
		if($('#elearnComplete_flag').val() == 0){
			updateElearnVideoUserMap('1', '${videoInfo.duration}');
		}else if($('#elearnComplete_flag').val() == 1){
			if($('#elearnComplete_per').val() != 100){
				updateElearnVideoUserMap('3', parseInt(getCurrentTime()));
			}
		}
	}
	
	if($('#autoplay').val() == '1'){ 
		if($.trim($('#nextVi_seq_hash').val()) != ''){
			funRightVideoDetail('/kube/watch/' + $('#nextVi_seq_hash').val(), $('#nextP_code_seq').val(), $('#nextCode_seq').val());
		}
	}else if($('#autoplay').val() == '2'){
		funRightVideoDetail('/kube/watch/' + $('#vi_seq_hash').val(), $('#p_code_seq').val(), $('#code_seq').val());
	} 
}

//complete_flag = 0 : 중간 재생 시점 저장
//complete_flag = 1 : 최초 재생 또는 90% 미만 재생된 건으로, 완료처리가 되지 않은 케이스로 100% 재생 되었으므로 이수 완료 처리
//complete_flag = 3 : 기존에 90% 이상 재생하여 교육은 이수한 건으로, 최종 100% 재생이 되었으므로 재생률 업데이트 처리
function updateElearnVideoUserMap(gubun, time){
	var param = {'vi_seq_hash' : $('#vi_seq_hash').val()
			, 'complete_flag' : gubun == '3' ? '1' : gubun
			, 'play_duration_sec' : time}
	
	$.ajax({
       url: "/kube/updateElearnVideoUserMap.do",
       type: "POST",
       data: param,
       dataType: "html",
       success: function(msg) {
		   
    	   if(gubun == '1'){
	    	   var tmp_result = $.trim(msg);
	    	   
    		   if(tmp_result != 'false'){
    			   alert('교육을 이수하였습니다. 수고하셨습니다!');
    			   setCurrentTime('0');
    			   $('#elearnComplete_flag').val('1');
    			   $('#elearnComplete_per').val('100');
    			   
    			   gmAutoPlay = false;
    			   gmEduComplete = true;
    			   gmPlayTime = '0';
    			   
    			   //플레이어 설정값 재적용
    			   var playerContainer = document.getElementById("playerDiv");
    			   var playerContent = playerContainer.innerHTML; 
    			   playerContainer.innerHTML= playerContent; 
    			    
    			   return true;
			   }else{
    		   	   return false;
			   }
    	   }else if(gubun == '3'){
    		   setCurrentTime('0');
			   $('#elearnComplete_flag').val('1');
			   $('#elearnComplete_per').val('100');
			   
			   gmAutoPlay = false;
			   gmEduComplete = true;
			   gmPlayTime = '0';
			   
			   //플레이어 설정값 재적용
			   var playerContainer = document.getElementById("playerDiv");
			   var playerContent = playerContainer.innerHTML; 
			   playerContainer.innerHTML= playerContent; 
    	   }
 		}
	});
}

function playerCtrl(obj){
	console.log(obj);
	//e-러닝 영상 구분하여 플레이어 초기화
	if('${videoInfo.channel}' == 'elearn'){
		//미이수 상태인 경우, 스킵 기능 제한. 이어보기 알림
		//complete_flag : 0-미이수, 1-이수
		if($('#elearnComplete_flag').val() == 0){
			gmEduComplete = false;

			if('${elearnUserMap.play_duration_sec}' > 0){
				$('#continueView_div').parent().show();
				layerPopupCenter2($('#continueView_div'));
			}else{
				gmplayer.GMPlayerInit();
			}
		}else{
			//90~99% 이수자는 알림 문구 출력 및 이어보기 또는 처음재생 컨트롤
			if(90 <= parseInt($('#elearnComplete_per').val()) &&  parseInt($('#elearnComplete_per').val()) < 100){
				$('#percentView_div').parent().show();
				layerPopupCenter2($('#percentView_div'));
			}else{
				gmplayer.GMPlayerInit();
			} 
		}
	}else{
		gmplayer.GMPlayerInit();
	} 
}

function funElearnView(val){
	
	//C - continue 이어보기, F - first 처음부터 재생, N - no 재생 안함
	if(val == 'C'){
		gmPlayTime = '${elearnUserMap.play_duration_sec}';
	}else if(val == 'N'){
		gmAutoPlay = false;
	}
	
	$('#continueView_div').parent().hide();
	$('#percentView_div').parent().hide();
	
	gmplayer.GMPlayerInit();
}

//http://100.1.48.20/KUBE/video/2017/1026/171026151743898_ex099118.mp4
function GMPlayerConfig(){
	return { 
		playURL  : '<%= Constants.KUBE_UPLOAD_ASP_IP %>${fn:replace(videoInfo.pds_log_path, '.mp4', '_0.mp4')}', // 영상 url
		playURL_high  : '<%= Constants.KUBE_UPLOAD_ASP_IP %>${videoInfo.pds_log_path}', // 영상 url
		autoPlay : gmAutoPlay, // 자동재생설정 ( true or false )  
		logoImage : '<%= Constants.WEB_URL %>/resource/common/kube_video/image/logo.png', //업체 로고 이미지
		titleImage : '', // 영상 title image
		playerWidth : $('#playerDiv').width(),  // 플레이어 가로 크기 
		playerHeight : '600',  // 플레이어 세로 크기
		clipPlay : false, 
		clipStartTime : '10',
		clipEndTime : '20',
		snakeImage : true, // 스네이크 이미지 사용 유무(true/false)   
		snakeImageURL : '<%= Constants.KUBE_UPLOAD_ASP_IP %>${fn:replace(videoInfo.pds_log_path, "mp4", "jpg")}', // 스네이크 이미지 url
		snakeImageWidth : '120', // 스네이크 이미지 가로 크기
		snakeImageHeight : '80', // 스네이크 이미지 세로 크기
		snakeImageRowNum : '20', // 스네이크 이미지 가로 갯수
		snakeImageCellNum : '2', // 스네이크 이미지 세로 갯수
		snakeImageTimeInterval : '1', // 스네이크 이미지 추출 시간       
		smi : false,
		smiurl : '',
		isLogo : true,
		eduComplete : gmEduComplete, // seek바 이벤트 관련 (false : seek바 이동 X , true : seek바 이동 O)
		playTime : gmPlayTime // 이어보기 시간설정 ( 처음시작 : 0 )
	}
}
</script>
    
<script type="text/javascript">
var _submit = true;

$(document).ready(function() {
	funRightVideoList();
	
	funGetCommentList('R');
	
	funExpand($('#descOpen'), 'Y');
});
      	
window.onbeforeunload = function() {
	//화면 강제로 벗어난 경우 중간 저장 시점을 저장함
	if('${videoInfo.channel}' == 'elearn'
		&& $('#elearnComplete_flag').val() == 0){

		var time = getCurrentTime();
		
		//정지 상태에서 나가는 경우, 0으로 업데이트 됨
		if(time > 0){
			var timePer = parseInt(time * 100 / ${videoInfo.duration });
			
			if(90 <= timePer){
				//90% 이상은 교육 이수처리는 하되 중간 시간을 저장한다
				updateElearnVideoUserMap('3', parseInt(time));
			}else{
				updateElearnVideoUserMap('0', parseInt(time));
			}
		}
	}
}
	
$('textarea').keydown(function(e){
	if(e.keyCode == 13 && $(this).val().split("\n").length >= $(this).attr('rows')) { 
	    return false;
	}
});

function funRightVideoList(){ 
	
	var param = {'vi_seq_hash' : $('#vi_seq_hash').val()
			, 'right_gubun' : $('#right_gubun').val()
			, 'autoplay' : $('#autoplay').val()
			, 'nextNum' : $('#nextNum').val() 
			, 'chkVideoSeqArr' : '${chkVideoSeqArr}'
			}      
	
	$.ajax({
       url: "/kube/getRightVideoList.do",
       type: "POST",
       data: param,
       dataType: "html",
       success: function(msg) {
			
    	   var tmp_result = $.trim(msg);
    	   if(tmp_result != 'false'){
    		   $('#rightVideoDiv').after(msg);
    		   $('#nextNum').val($('#nextNumChk').val());
    		   return true;
			}else{
    		   return false;
			}
 		}
	});
}

function funPlayCtrl(obj, playVal, targetVal){

	if($(obj).attr('src').indexOf('off') != -1){
		$('#autoplay').val(playVal);
		$(obj).attr('src', $(obj).attr('src').replace(playVal + '_off.png', playVal + '.png'));
		$('.playImg' + targetVal).attr('src', $('.playImg' + targetVal).attr('src').replace(targetVal + '.png', targetVal + '_off.png'));
	}else{
		$('#autoplay').val('3');
		$(obj).attr('src', $(obj).attr('src').replace(playVal + '.png', playVal + '_off.png')); 
	}
}

function funDetail(v){
	funGoPageDetail('/kube/watch/' + v);
}

function funFileDown(p){
	if(p == '41'){
		funFileDownAct();
	}else if(p == '42'){
		var approveVal = $('#pre_approve').val();
		
		if(approveVal == '44'){
			alert('해당 영상에 대해 승인 요청이 진행중입니다.');
		}else if(approveVal == '45'){
			funFileDownAct();
		}else{
			$('#approve_div').parent().show();
			layerPopupCenter2($('#approve_div'));
		}
	}
}
 
function funFileDownAct(){
	//50번에서는 DB 업데이트 처리만 하고 실제 다운로드는 20번에서 진행. 
	//20번에 다운로드 전용 톰캣 존재
	dataString = $("#frm").serialize();
	
    $.ajax({
       url: "/kube/kubeVideoFileDown.do",
       type: "POST",
       data: dataString,
       dataType: "json",
       success: function(msg) {
    	   $("#frm").attr("action","http://100.1.48.20:8091/kube/kubeVideoFileDown.do")
    	   $("#frm").submit();
 		}
	});
}

function funApproveReq(){
	dataString = $("#frm").serialize();
	
    $.ajax({
       url: "/kube/approveReqVideo.do",
       type: "POST",
       data: dataString,
       dataType: "json",
       success: function(msg) {
			
    	   var tmp_result = $.trim(msg);
    	   if(tmp_result != 'false'){
			   alert('승인 요청 되었습니다\n승인 여부는 마이페이지에서 확인하실 수 있습니다');
			   
			   $('#pre_approve').val('44');
			   $('#approve_div').parent().hide();
    		   return true;
			}else{
    		   alert("오류가 발생 했습니다");
    		   $('#approve_div').parent().hide();
    		   return false;
			}
 		}
	});
}

function funExpand(obj, g){
	
	$(obj).hide();
	
	var childHeight = $('#contents_div').children().eq(0).height(); 
	
	if(g == 'Y'){       
		$(obj).next().show();
		
		if($.trim($('#contents_div').text()) == ''){
			$('#contents_div').css('height', '35px');
		}else{
			if(childHeight <= 35){
				$('#contents_div').css('height', '35px');
			}else{
				$('#contents_div').css('height', 'auto');
			}
		}
	}else if(g == 'N'){
		$(obj).prev().show();
		$('#contents_div').css('height', '35px');
	}
}

//각 이벤트 
function funMyAct(obj, vc){
	 
	if(_submit){
		
		_submit = false;
		
		if(vc != undefined){
			$('#target_vc_seq').val(vc);
		}
			//console.log($('#target_vc_seq').val());
		var param = {'vi_seq_hash' : $('#vi_seq_hash').val(), 'ma' : $(obj).attr('name'), 'target_vc_seq' : $('#target_vc_seq').val()} 
		
	    $.ajax({
	       url: "/kube/userActCtrl.do",
	       type: "POST",
	       data: param,
	       dataType: "json",
	       success: function(msg) {
				
	    	   var tmp_result = $.trim(msg);
	    	   if(tmp_result != 'false'){
	    		   
	    		   var idVal = parseInt($(obj).attr('name'));
	    		   var cntVal = parseInt($(obj).next().text().replace(/,/gi, ''));
				   
	    		   if(parseInt(idVal) < 10){
		    		   	//영상 관리
		    		    //2-좋아요 3-좋아요 취소 4-싫어요 5-싫어요 취소 6-즐겨찾기 7-즐겨찾기 취소 8-다운로드 
		    			if(idVal % 2 == 0){
		    				$(obj).attr('name', idVal + 1);
		    				$(obj).next().text(cntVal + 1).number(true);
		    				$(obj).attr('src', $(obj).attr('src').replace(idVal, idVal + 1));
		    			}else{
		    				$(obj).attr('name', idVal - 1);
		    				$(obj).next().text(cntVal - 1).number(true);
		    				$(obj).attr('src', $(obj).attr('src').replace(idVal, idVal - 1)); 
		    			} 
	    		   }else if(parseInt(idVal) > 10){
		    			//댓글 관리
		    			//11-댓글 좋아요 12-댓글 좋아요 취소 13-댓글 싫어요 14-댓글 싫어요 취소
	    			    if(idVal % 2 == 0){
		    				$(obj).attr('name', idVal - 1);
		    				$(obj).next().text(cntVal - 1).number(true);
		    				$(obj).attr('src', $(obj).attr('src').replace(idVal, idVal - 1));
		    			}else{
		    				$(obj).attr('name', idVal + 1);
		    				$(obj).next().text(cntVal + 1).number(true); 
		    				$(obj).attr('src', $(obj).attr('src').replace(idVal, idVal + 1));
		    			}
	    		   }
	    		   
	    		   $('#target_vc_seq').val('LX4IaGcnTLA8InG');

		    	   _submit = true;
		    	   
	    		   return true;
				}else{
	    		   alert("오류가 발생 했습니다");
	    		   
	    		   $('#target_vc_seq').val('LX4IaGcnTLA8InG');

		    	   _submit = true;
		    	   
	    		   return false;
				}
	 		}
		});
	}else{
		alert('요청 처리중 입니다.');
		return false;
	}
}

//댓글 입력
function funCommentReg(obj, idx){ 
	var s 		= $('input[name=p_vc]').eq(idx).val();	//댓글 순서. db 기준(삭제로 인해 순서 이빨 나감)
	
	if($.trim($('textarea[name=comment_desc]').eq(idx).val()) == ''){
		alert('내용을 입력하시기 바랍니다');
		$('textarea[name=comment_desc]').eq(idx).focus();
		return false;
	}
	
	if(confirm('등록 하시겠습니까?')){
		
		if(_submit){
			
			_submit = false;
		
			$('#target_vc_seq').val(s);
			$('#target_vc_seq_idx').val(idx);
			
			dataString = $("#frm").serialize();
			
		    $.ajax({
		       url: "/kube/insertUserComment.do",
		       type: "POST",
		       data: dataString,
		       dataType: "html",
		       success: function(msg) {
					
		    	   var tmp_result = $.trim(msg);
		    	   if(tmp_result != '99999999'){
	
		    		   $('textarea[name=comment_desc]').eq(idx).val('');
		    		   
		    		   if(s == 'LX4IaGcnTLA8InG'){
		    			   //댓글 신규는 최근 작성 글 보여주자. 등록 글 확인용
		    		   	   funGetCommentList('R');
		    			   
		    		   	   $('#totCmmCnt').next().text(parseInt($('#totCmmCnt').next().text().replace(/,/gi, '')) + 1).number(true);
		    		   }else{  
		    			   //대댓글은 사이에 잘 끼어넣어준다 
		    			   var param = {'vi_seq_hash' : $('#vi_seq_hash').val(), 'vc_seq' : msg, 'pCnt' : idx, 'gubun' : 'one'} 
		    				
		    			    $.ajax({
		    			       url: "/kube/getCommentList.do",
		    			       type: "POST",
		    			       data: param,
		    			       dataType: "html",
		    			       success: function(msg) {
		    			    	   
		    			    	   var tmp_result = $.trim(msg);
		    			    	   if(tmp_result != 'false'){
		    			    		   
		    			    		   $(obj).parent().parent().after(msg);
		    			    		   
		    			    		   //기존 작성 폼 삭제
		    			    		   //대댓글 없는 경우와 있는 경우, 폼이 다름
		    			    		   var comment_cnt = parseInt($('#subCmTotCnt' + idx).children().eq(0).text().replace(/,/gi, ''));

		    			    		   if($(obj).parent().parent().children().length == 1){
			   			    		   		$(obj).parent().parent().remove();
			   			    		   }else{
			   			    			   $(obj).parent().remove();
			   			    		   }
			    			    		   

	    			    			   //댓글 카운트 증가
		    			    		   $('#subCmTotCnt' + idx).children().eq(0).text(comment_cnt + 1).number(true)
		    			    		   $('#totCmmCnt').next().text(parseInt($('#totCmmCnt').next().text().replace(/,/gi, '')) + 1).number(true);
		    			    		    
		    			    		   return true;
		    						}else{
		    			    		   alert("신규 등록된 댓글을 가져오는 중 오류가 발생 했습니다");
		    			    		   
		    			    		   return false;
		    						}
		    			 		}
	    					});
		    		   }
		    		   
		    		   $('#target_vc_seq').val('LX4IaGcnTLA8InG');
		    		   $('#target_vc_seq_idx').val('0');
		    		   
			    	   _submit = true;
			    	   
		    		   return true;
					}else{
		    		   alert("오류가 발생 했습니다");
		    		   
		    		   $('#target_vc_seq').val('LX4IaGcnTLA8InG');
		    		   $('#target_vc_seq_idx').val('0');

			    	   _submit = true;
			    	   
		    		   return false;
					}
		    	   
		 		}
			});
		}else{
			alert('요청 처리중 입니다.');
			return false;
		}
	}
}

//댓글 삭제
function funCommentDel(obj, vc_seq_hash, idx, gubun, vc_seq){ 

	var comment_cnt = parseInt($('#subCmTotCnt' + idx).children().eq(0).text().replace(/,/gi, ''));
	
	if((gubun == 'Y' && comment_cnt == 0) || gubun == 'N'){
		if(confirm('삭제 하시겠습니까?')){
			if(_submit){
				
				_submit = false;
				
				var param = {'vi_seq_hash' : $('#vi_seq_hash').val(), 'vc_seq_hash' : vc_seq_hash}
				
			    $.ajax({
			       url: "/kube/deleteUserComment.do",
			       type: "POST",
			       data: param, 
			       dataType: "json",
			       success: function(msg) {
						
			    	   var tmp_result = $.trim(msg);
			    	   if(tmp_result != 'false'){
			    		   
			    		   //댓글창이 있는 div 삭제시 댓글 창은 남겨둠. 입력에서 제거
			    		   if($(obj).parent().parent().parent().children().length == 1){
			    		   		$(obj).parent().parent().parent().remove();
			    		   }else{
			    			   $(obj).parent().parent().remove();
			    		   }
			    		   
			    		   if(vc_seq != undefined){ 
			    			   $('.sub_comment_' + vc_seq).remove();
			    		   }
			    		   
			    		   //댓글 카운트 감소
			    		   $('#subCmTotCnt' + idx).children().eq(0).text(comment_cnt - 1).number(true)
			    		   $('#totCmmCnt').next().text(parseInt($('#totCmmCnt').next().text().replace(/,/gi, '')) - 1).number(true);

				    	   _submit = true;
				    	   
			    		   return true;
						}else{
			    		   alert("오류가 발생 했습니다");

				    	   _submit = true;
				    	   			    		   
			    		   return false;
						}
			 		}
				});
			}else{
				alert('요청 처리중 입니다.');
				return false;
			}
		}
	}else{
		alert('하위 댓글이 있는 경우 삭제할 수 없습니다.');
		return false;
	}
}

//댓글 동적 리스트
function funGetCommentList(val){
	
	var param = {'vi_seq_hash' : $('#vi_seq_hash').val(), 'o' : val, 'gubun' : 'all'}
	
    $.ajax({
       url: "/kube/getCommentList.do",
       type: "POST",
       data: param,
       dataType: "html",
       success: function(msg) {
    	   var tmp_result = $.trim(msg);
			
    	   if(tmp_result != 'false'){
    		   
    		   if(tmp_result != ''){
	    		   $('#comment_div').show();
	    		   
	    		   if(val == 'P'){
	    				$('.kubeCommentBtn_div').eq(1).show();	
	    				$('.kubeCommentBtn_div').eq(0).hide();	
	    			}else if(val == 'R'){
	    				$('.kubeCommentBtn_div').eq(0).show();	
	    				$('.kubeCommentBtn_div').eq(1).hide();	
	    			}
	    		   
	    		    $('#commentTbody').html(msg);
    		   }
    		   
    		   return true;
			}else{
    		   alert("댓글을 가져오는 중 오류가 발생 했습니다");
    		   
    		   return false;
			}
 		}
	});
}

function funReportShow(g, vc_seq_hash){
	$('#vi_seq_hash_r').val('');
	$('select[name=selReport]').val('');
	$('#re_desc').val('');
	
	$('#report_gubun').val(g);
	$('#vc_seq_hash_r').val(vc_seq_hash);
	
	$('#report_div').parent().show();
	layerPopupCenter2($('#report_div'));
}

function funReport(){
	
	if($('select[name=selReport]').val() == ''){
		alert('신고 분류를 선택하시기 바랍니다.');
		
		return false;
	}
	
	if($.trim($('#re_desc').val()) == ''){
		alert('신고 사유를 입력하시기 바랍니다.');
		$('#re_desc').focus();
		
		return false;
	}
	
	if(confirm('신고 하시겠습니까?\n신고 내용은 취소가 불가능합니다')){
		$('#vi_seq_hash_r').val($('#vi_seq_hash').val());
		
		var dataString = $("#rfrm").serialize();
		
		$.ajax({
	       url: "/kube/reportReqV_C.do",
	       type: "POST",
	       data: dataString,
	       dataType: "html",
	       success: function(msg) {
	    	   var tmp_result = $.trim(msg);
				
	    	   if(tmp_result != 'false'){
	    		   
	    		   alert('신고 되었습니다.\n관리자 확인 절차를 통해 처리될 예정입니다.');
				   
				   $('#report_div').parent().hide();
	    		   return true;
				}else{
				   alert("오류가 발생 했습니다");
					
	    		   $('#report_div').parent().hide();
	    		   return false;
				}
	 		}
		});
	}
}

function funTaskAct(){
	
	var alert_msg = '영상을 삭제할 경우 복구가 불가능 합니다.\n\n정말 삭제하시겠습니까?';
	
	if(confirm(alert_msg)){
		dataString = $("#frm").serialize();
		dataString = dataString + '&taskVal=9';
		dataString = dataString + '&videoChk=' + $('#vi_seq_hash').val();
		
	    $.ajax({
	       type: "POST",
	       url: "/kube/mypage/updateMyVideoFlag.do",
	       data: dataString,
	       dataType: "json",
	       success: function(msg) {
	    	   
	    	   var tmp_result = $.trim(msg);
	    	   if(tmp_result != 'false'){
	    		   alert("삭제 되었습니다");
	    		   location.replace('/kube/channel/theme/' + $('#p').val() + '/' + $('#c').val());
				   
	    		   return true;
				}else{
	    		   alert("오류가 발생 했습니다");
	    		   return false;
				}
	 		}             
		}); 
	}
}

function funRightVideoDetail(url, c1, c2){
	$('#p_code_seq').val(c1);
	$('#code_seq').val(c2);
	funGoPageDetail(url);
}

function funRightVideoDetail2(id, url, c1, c2){
	$('#nextNum').val(id);
	$('#p_code_seq').val(c1);
	$('#code_seq').val(c2);
	funGoPageDetail(url);
}
</script>
<c:import url="/resource/common/include/kube_bottom.jsp" />