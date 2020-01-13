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
				<c:param name="left_depth_2" value="${p_code_seq + 1}"></c:param>
			</c:import>
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<form id="frm" name="frm" method="post">
		<input type="hidden" id="code_seq" name="code_seq" value="${code_seq }">
		<input type="hidden" id="p_code_seq" name="p_code_seq" value="${p_code_seq }">
		<input type="hidden" id="vi_seq_hash" name="vi_seq_hash" value="${vi_seq_hash}">
		<input type="hidden" id="target_vc_seq" name="target_vc_seq" value="LX4IaGcnTLA8InG">
		<input type="hidden" id="target_vc_seq_idx" name="target_vc_seq_idx" value="0">
		<input type="hidden" id="pre_approve" name="pre_approve" value="${videoInfo.pre_approve}">
		<input type="hidden" id="orderVal" name="orderVal" value="${orderVal}">
		<input type="hidden" id="autoplay" name="autoplay" value="${autoplay}">
		<input type="hidden" id="right_gubun" name=right_gubun value="${right_gubun}">
		<c:forEach var="chkVideoSeqArr" items="${chkVideoSeqArr }"> 
			<input type="hidden" id="chkVideoSeqArr" name=chkVideoSeqArr value="${chkVideoSeqArr}">
		</c:forEach>
		<!-- 우측 리스트 중 현재 재생 영상 번호 관리 -->
		<input type="hidden" id="nextNum" name="nextNum" value="${nextNum }" />

		<%-- 코드 변경으로 다운로드 강제 요청 시 df 값과 비교 처리 후 다운 진행 --%>
		<input type="hidden" id="df" name="df" value="${videoInfo.download_flag }">
		
	        <div class="contents-con-framebox" style="width:940px">
				<div class="nav-box">
	                <div class="nav-img"><img alt="" src="/resource/images/sub/sub9_tit_img.png"></div>
					<div class="nav-list">
						<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;KUBE&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">${videoInfo.p_code_desc}</b>
					</div>
					<div class="nav-title">${videoInfo.code_desc}</div>
				</div>
	            
	            <div class="searchArea_con_box">
					<fieldset>
	                    <div class="search-box"  style="float:right">		
	                        <div class="form-group">
	                            <legend>검색영역</legend>	        
	                            <input type="text" title="검색바" id="srh_keyword" name="srh_keyword" placeholder="제목, 작성자 조회" style="width: 570px; height:34px; padding-left: 20px;font-size:14px;color:#666; border:1px solid #bea2d9" onkeydown="javascript:if(event.keyCode == 13){funGoPageDetail('/kube/channel/${videoInfo.channel}/${cha:seqEncode(p_code_seq)}/${cha:seqEncode(code_seq)}');}">
	                            <img src="/resource/images/sub/btn_search.png" style="cursor: pointer;" onclick="javascript:funGoPageDetail('/kube/channel/${videoInfo.channel}/${cha:seqEncode(p_code_seq)}/${cha:seqEncode(code_seq)}');"/>
	                        </div>
	                    </div>
					</fieldset>
				 </div> 
	            
	            <div class="view_box01" style="margin-top:10px;margin-bottom:10px">
	            	<div style="width:760px;height: 600px;"> 
		                <!--
		                <div class="media_btn">
		                    <img alt="" src="/resource/images/sub/btn_play.png" style="margin-right:10px">
		                    <img alt="" src="/resource/images/sub/btn_pause.png" style="margin-right:10px">
		                    <img alt="" src="/resource/images/sub/btn_stop.png" style="margin-right:10px">
		                    <img alt="" src="/resource/images/sub/btn_next.png" style="margin-right:10px">
		                    <img alt="" src="/resource/images/sub/btn_sound.png" >
		                </div>
		                <div class="media_btn" style="margin-left:700px">480p <img alt="" src="/resource/images/sub/icon_11.png" ></div>
		                 -->
		                 <c:if test="${videoInfo.conv_flag == '1'}">
		                 	<div id="flashContent">
					        	<p>
						        	To view this page ensure that Adobe Flash Player version 
									11.1.0 or greater is installed. 
								</p>
								<script type="text/javascript"> 
									var pageHost = ((document.location.protocol == "https:") ? "https://" :	"http://"); 
									document.write("<a href='http://www.adobe.com/go/getflashplayer'><img src='" 
													+ pageHost + "www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' /></a>" ); 
								</script>    
					        </div>
		                 	<noscript>
						         <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="100%" id="GMPlayer">
						             <param name="movie" value="/resource/common/kube_video/GMPlayer.swf" />
						             <param name="quality" value="high" />
						             <param name="bgcolor" value="#ffffff" />
						             <param name="allowScriptAccess" value="sameDomain" />
						             <param name="allowFullScreen" value="true" />
						             <param name="wmode" value="opaque" />
						             <!--[if !IE]>-->     
						             <object type="application/x-shockwave-flash" data="/resource/common/kube_video/GMPlayer.swf" width="100%" height="100%">
						                 <param name="quality" value="high" />
						                 <param name="bgcolor" value="#ffffff" />
						                 <param name="allowScriptAccess" value="sameDomain" />
						                 <param name="allowFullScreen" value="true" />
						                 <param name="wmode" value="opaque" />
						             <!--<![endif]-->
						             <!--[if gte IE 6]>-->
						             	<p> 
						             		Either scripts and active content are not permitted to run or Adobe Flash Player version
						             		11.1.0 or greater is not installed.
						             	</p>
						             <!--<![endif]-->
						                 <a href="http://www.adobe.com/go/getflashplayer">
						                     <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash Player" />
						                 </a>
						             <!--[if !IE]>-->
						             </object>
						             <!--<![endif]-->
						         </object>
						  	</noscript>	
		                 </c:if>
		                 <c:if test="${videoInfo.conv_flag == '9'}">
		                 	<img src="${web_url.concat(videoInfo.thumb_log_path)}" class="imgMaxWidth760" />
		                 </c:if>
	            	</div>
	            	
		            <div class="title-box" style="height: auto; overflow: hidden;">
		                <div style="float:left">
		                    <span class="media_tit1">
		                        ${videoInfo.title}<c:if test="${videoInfo.conv_flag == '9'}"> (영상 컨버팅 진행 중)</c:if>
		                    </span>
		                </div>
		                <div style="float:right">
		                	<c:if test="${videoInfo.conv_flag == '1'}">
								<c:if test="${videoInfo.reg_empno ==  sessionScope.SESS_EMPNO}">
									<img alt="" src="/resource/images/sub/btn_download.png" style="cursor: pointer;" onclick="javascript:funFileDownAct();">
								</c:if>
								<%--41 모두 다운로드 가능	42 승인자만 다운로드	43 다운로드 불가 --%>
								<c:if test="${videoInfo.reg_empno !=  sessionScope.SESS_EMPNO}">
			                		<c:if test="${videoInfo.download_flag == 41 || videoInfo.download_flag == 42}">
			                    		<img alt="" src="/resource/images/sub/btn_download.png" style="cursor: pointer;" onclick="javascript:funFileDown('${videoInfo.download_flag}');">
			                    	</c:if>
			                    </c:if>
			                </c:if>   
		                </div>
		                
		                <div style="clear:both"></div>
		                
		                <div style="float:left; margin-top:40px">
		                    <span class="media_name">${videoInfo.dept_name1} ${videoInfo.dept_name2 } ${videoInfo.writer }</span>
		                </div>
		                <%--1-조회 2-좋아요 3-좋아요 취소 4-싫어요 5-싫어요 취소 6-즐겨찾기 7-즐겨찾기 취소 8-다운로드 --%>
		                <div style="float:right; margin-top:40px; text-align:right">
		                    <span class="media_name">게시일 : ${cha:todate(videoInfo.reg_date, '-', '3') }  ㅣ   ▷<fmt:formatNumber value="${videoInfo.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span><br><br>
		                    <img name="${videoInfo.v_like_cnt == 0 ? '2' : '3'}" src="/resource/images/sub/icon_kube0${videoInfo.v_like_cnt == 0 ? '2' : '3'}.png" style="cursor: pointer;" onclick="javascript:funMyAct(this);" /> <font><fmt:formatNumber value="${videoInfo.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></font> &nbsp;&nbsp;&nbsp;&nbsp;
		                    <img name="${videoInfo.v_unlike_cnt == 0 ? '4' : '5'}" src="/resource/images/sub/icon_kube0${videoInfo.v_unlike_cnt == 0 ? '4' : '5'}.png" style="cursor: pointer;" onclick="javascript:funMyAct(this);" /> <font><fmt:formatNumber value="${videoInfo.unlike_cnt}" pattern="#,###,###,###"></fmt:formatNumber></font>
		                </div>
		                
		                <div style="clear:both"></div>
		                <div style="float:right; margin-top:20px;">
		                    <a class="txt_box" style="cursor: pointer;" onclick="javascript:funExpand(this, 'Y');"><img src="/resource/images/sub/icon_06.png" style="margin-right:10px" />펼침</a>
		                    <a class="txt_box" style="cursor: pointer;display: none;" onclick="javascript:funExpand(this, 'N');"><img src="/resource/images/sub/icon_09.png" style="margin-right:10px" />닫힘</a>
		                    <a class="txt_box" style="cursor: pointer;" href="#popular"><img id="totCmmCnt" src="/resource/images/sub/icon_07.png" style="margin-right:10px" /> <font><fmt:formatNumber value="${videoInfo.comment_cnt}" pattern="#,###,###,###"></fmt:formatNumber></font></a>
		                    <a class="txt_box" style="cursor: pointer;" onclick="javascript:funMyAct($(this).children().eq(0));"><img name="${videoInfo.v_favor_cnt == 0 ? '6' : '7'}" src="/resource/images/sub/icon_kube0${videoInfo.v_favor_cnt == 0 ? '6' : '7'}.png" style="margin-right:10px;" /><font><fmt:formatNumber value="${videoInfo.favor_cnt}" pattern="#,###,###,###"></fmt:formatNumber></font></a> 
		                    <a class="txt_box" style="cursor: pointer;" onclick="javascript:funReportShow('1');">신고하기</a>
		                </div>
		                
		                <div style="clear:both"></div>
		                <div id="contents_div" style="margin-top: 20px;height: 7px;">
		                	<pre>${videoInfo.contents_desc }</pre> 
		                </div>
					</div>
				</div>
			
				<div class="view_box02" style="position:absolute;margin:10px 0px 10px 780px;padding-bottom: 100px;">
	                <div class="sub-nav-title-sm" style="border-bottom: 1px solid #cecece">
	                    <img src="/resource/images/sub/icon_10.png" style="margin-right:10px" />
	                    	<c:if test="${right_gubun == 'R'}">추천영상</c:if>
	                    	<c:if test="${right_gubun == 'M'}">즐겨찾기영상</c:if>
	                </div>
	                <div id="rightVideoDiv" class="sub-nav-title-sm" style="margin-top:10px;">
	                	<c:if test="${autoplay == '1'}">
	                    	<img class="playImg1" src="/resource/images/sub/play_01.png" style="cursor: pointer;" onclick="javascript:funPlayCtrl(this, '1', '2');" />
	                    </c:if>
	                	<c:if test="${autoplay != '1'}">
	                    	<img class="playImg1" src="/resource/images/sub/play_01_off.png" style="cursor: pointer;" onclick="javascript:funPlayCtrl(this, '1', '2');" />
	                    </c:if>
	                    <c:if test="${autoplay == '2'}">
	                    	<img class="playImg2" src="/resource/images/sub/play_02.png" style="cursor: pointer;" onclick="javascript:funPlayCtrl(this, '2', '1');" />
	                    </c:if>	
	                    <c:if test="${autoplay != '2'}">
	                    	<img class="playImg2" src="/resource/images/sub/play_02_off.png" style="cursor: pointer;" onclick="javascript:funPlayCtrl(this, '2', '1');" />
	                    </c:if>	
	                </div> 
	                
	            </div>
	            
	            <div style="clear:both"></div>
	            <div style="width:760px">
	                <div style="border-top: 1px solid #cecece">
	                    <div class="sub-nav-title1" style="margin-top:30px">댓글</div>                
	                    <div style="margin-top:5px; padding-top:5px">
	                        <textarea class="textarea-style" rows="4" name="comment_desc" style="width:88%; border:1px solid #cfcfcf"></textarea>
	                        <input type="button" name="srchDescription" class="btn_down" onclick="javascript:funCommentReg(this, '0')" value="등록" style="width:80px;height:69px;background-color:#0b4894" >
	                        <input type="hidden" name="p_vc" value="LX4IaGcnTLA8InG" />
	                    </div>
	                </div>
	                <div id="comment_div" class="sub-nav-title-sm" style="margin-top:30px;border-bottom: 1px solid #cecece;display: none;">
	                	<div class="kubeCommentBtn_div">
		                    <img src="/resource/images/sub/icon_06.png" style="margin-right:10px" /><a id="popular" href="javascript:;" onclick="javascript:funGetCommentList('P');">인기 댓글 순</a>   &nbsp;&nbsp;
		                    <span class="media_name"><a id="recent" href="javascript:;" onclick="javascript:funGetCommentList('R');">최신 댓글 순</a></span>
	                    </div>
	                	<div class="kubeCommentBtn_div">
		                    <span class="media_name"><a id="popular" href="javascript:;" onclick="javascript:funGetCommentList('P');">인기 댓글 순</a></span>   &nbsp;&nbsp;
		                    <img src="/resource/images/sub/icon_06.png" style="margin-right:10px" /><a id="recent" href="javascript:;" onclick="javascript:funGetCommentList('R');">최신 댓글 순</a>
	                    </div>
	                </div>
	                <div class="basic-list">
	                    <table id="listTable" summary="">
	                        <caption>게시판 테이블</caption>
	                        <tbody id="commentTbody">
						   </tbody>
					    </table>
				     </div>
	            </div>
			</div>
		</form>
		<!--content end-->
	</div>
</div>
<div style="width: 100%;height:100%; position: absolute;top:153px; z-index:1; background-color: rgba(0, 0, 0, 0.8); display: none;">
	<div id="approve_div" class="popup_view_box1" style="display: none; z-index:2; width:350px; background-color: #fff;">
	<h3 style="color:#fff">다운로드 안내</h3>
	    <div style="margin-top:35px; line-height:25px;">
	        해당 영상은 저작권자의 승인 후 다운로드가 가능합니다. <br>
	        승인 요청하시겠습니까? <br>
	        승인 여부는 마이페이지에서 확인하실 수 있습니다
	    </div> 
	    
	    <div class="btn-zone" style="margin-top:15px;">
			<ul>
	            <li><input type="button" name="" class="search_btn" style="width:60px;" onclick="javascript:funApproveReq();" value="승인요청"></li>
				<li><input type="button" name="" class="search_btn" onclick="javascript:$('#approve_div').parent().hide();" value="취소"></li>
			</ul>
		</div>
	</div>
</div> 

   
<div style="width: 100%;height:100%; position: absolute;top:153px; z-index:1; background-color: rgba(0, 0, 0, 0.8); display: none;">
	<div id="report_div" class="popup_view_box1" style="width:650px; z-index:2; background-color: #fff;">
	<h3 style="color:#fff">신고하기</h3>
	    <div class="basic-list" style="margin-top:35px;">
	        <form id="rfrm" name="rfrm" method="post">		
	        <input type="hidden" id="vi_seq_hash_r" name="vi_seq_hash_r">
	        <input type="hidden" id="vc_seq_hash_r" name="vc_seq_hash_r">
			<input type="hidden" id="report_gubun" name="report_gubun">		
	            <div class="insrtfrom-framebox">
					<div class="insert-step1-box">
						<div class="form-step1">
							<fieldset>
							<legend>화면1</legend>
								<div class="row-group">	                                
	                                <dl class="insert_ready">
										<dt class="must-option"><label for="" id="">신고분류</label></dt>
										<dd>                                    
                                            <fieldset>	
                                                <div class="form-group">
                                                    <legend>신고분류</legend>                        
                                                    <div>
                                                        <p class="inputDesign">
                                                        <select name="selReport" style="width:200px">
                                                            <option value="">선택</option>
                                                            <c:forEach var="codeList" items="${codeList }">
	                                                        	<option value="${codeList.code_seq}">${codeList.code_desc}</option>
															</c:forEach>				                                    
                                                        </select> <b>※ 등록된 신고 내용은 취소가 불가능합니다.</b>
							                        </div>
                                                </div>
                                            </fieldset>
	                                    </dd>
									</dl>
	                                <dl class="insert_ready">
										<dt class="must-option"><label for="" id="">신고사유</label></dt>
										<dd><textarea rows="6" cols="50" id="re_desc" name="re_desc"></textarea></dd>
									</dl>
								</div>
							</fieldset>
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

<!-- BEGIN Browser History required section -->
<link rel="stylesheet" type="text/css" href="/resource/common/kube_video/history/history.css" />
<script type="text/javascript" src="/resource/common/kube_video/history/history.js"></script>
<!-- END Browser History required section -->  
<script type="text/javascript" src="/resource/common/kube_video/swfobject.js"></script>
<script type="text/javascript">
         //<!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
         var swfVersionStr = "11.1.0";
         //<!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
         var xiSwfUrlStr = "/resource/common/kube_video/playerProductInstall.swf";
         var flashvars = {};
         var params = {};
         params.quality = "high";
         params.bgcolor = "#ffffff";
         params.allowscriptaccess = "sameDomain";
         params.allowfullscreen = "true";
         params.wmode = "opaque";
         var attributes = {};
         attributes.id = "GMPlayer"; 
         attributes.name = "GMPlayer";
         attributes.align = "middle"; 
         swfobject.embedSWF(
             "/resource/common/kube_video/GMPlayer.swf", "flashContent", 
             "100%", "100%", 
             swfVersionStr, xiSwfUrlStr, 
             flashvars, params, attributes);
		//<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
		swfobject.createCSS("#flashContent", "display:block;text-align:left;");
</script>
<script type="text/javascript">
     
// 크로스 도메인 URL 정보 호출
// 플레이어와 영상, 이미지가 다른 서버인 경우 설정 필요
function getCrossDomain(){
	return "<%= Constants.KUBE_UPLOAD_ASP_IP %>/crossdomain.xml";
}

function GMPlayerCreationComplete(){
	var gmplayer = document.getElementById("GMPlayer");	 		 		
		gmplayer.GMPlayerInit();
}

// 영상의 재생이 완료되면 호출되는 함수
function playComplete(){
	if($('#autoplay').val() == '1'){ 
		if($.trim($('#nextVi_seq_hash').val()) != ''){
			funRightVideoDetail('/kube/watch/' + $('#nextVi_seq_hash').val(), $('#nextP_code_seq').val(), $('#nextCode_seq').val());
		}
	}else if($('#autoplay').val() == '2'){
		funRightVideoDetail('/kube/watch/' + $('#vi_seq_hash').val(), $('#p_code_seq').val(), $('#code_seq').val());
	} 
}
	 
//http://100.1.48.20/KUBE/video/2017/1026/171026151743898_ex099118.mp4
function GMPlayerConfig(){
	return { 
		playURL : '<%= Constants.KUBE_UPLOAD_ASP_IP %>${videoInfo.pds_log_path}', // 영상 url
		autoPlay : true, // 자동재생설정 ( true or false )  
		logoImage : '<%= Constants.WEB_URL %>/resource/common/kube_video/image/logo.png', //업체 로고 이미지
		titleImage : '', // 영상 title image
		playerWidth : '760',  // 플레이어 가로 크기
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
		isLogo : true
	}
}
</script>
    
<script type="text/javascript">
var _submit = true;

$(document).ready(function() {
	load_fnc('8', '0', '0'); //menu script
	
	//상세에서 굳이 조회 포커싱은 필요 없지 싶다
	//$('#srh_keyword').focus();
	funRightVideoList();
	
	funGetCommentList('P');
});
      	
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
			layerPopupCenter($('#approve_div'));
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
	
	if(g == 'Y'){
		$(obj).next().show();
		$('#contents_div').css('height', 'auto');
	}else if(g == 'N'){
		$(obj).prev().show();
		$('#contents_div').css('height', '7px');
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
		    			    		   
		    			    		   $(obj).parent().parent().parent().after(msg);  
		    			    		   
		    			    		   //기존 작성 폼 삭제
		    			    		   //대댓글 없는 경우와 있는 경우, 폼이 다름
		    			    		   var comment_cnt = parseInt($('#subCmTotCnt' + idx).children().eq(0).text().replace(/,/gi, ''));
		    			    		   
		    			    		   if(comment_cnt == 0){
		    			    			   $(obj).parent().parent().parent().remove();
		    			    		   }else if(comment_cnt > 0){
		    			    			   if($(obj).parent().prev().get(0) == undefined){
		    			    				   $(obj).parent().parent().parent().remove(); 
		    			    			   }else{       
				    			    		   $(obj).parent().prev().remove();
				    			    		   $(obj).parent().remove();
		    			    			   }
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
			    		   var trObj = $(obj).closest('tr');
			    		   var tdObjChild = $(obj).closest('td').children();   
			    		   
			    		   if(gubun == 'Y'){
			    			   $('.sub_comment_' + vc_seq).remove();
			    		   }
			    		   
			    		   if($(trObj).find('textarea').html() == undefined){
				    		   $(trObj).remove();
			    		   }else{
			    			   var len = $(tdObjChild).length;   
			    			   
			    			   $(tdObjChild).each(function(index){
			    				   if(index < len - 1){
			    			   			$(this).remove();
			    				   }
			    			   }); 
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
	    				$('.kubeCommentBtn_div').eq(0).show();	
	    				$('.kubeCommentBtn_div').eq(1).hide();	
	    			}else if(val == 'R'){
	    				$('.kubeCommentBtn_div').eq(1).show();	
	    				$('.kubeCommentBtn_div').eq(0).hide();	
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
	$('select[name=selReport]').jqTransSelect();
	$('#re_desc').val('');
	
	$('#report_gubun').val(g);
	$('#vc_seq_hash_r').val(vc_seq_hash);
	
	$('#report_div').parent().show();
	layerPopupCenter($('#report_div'));
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
<c:import url="/resource/common/include/bottom.jsp" />