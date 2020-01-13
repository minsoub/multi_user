<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<style>
.jqTransformSelectWrapper {
    float: left;
    position: relative;
    width: 106px;
    height: 27px;
    background: url("/resource/images/btn/select_bg.gif") no-repeat top left;
    margin-right: 0px;
}
</style>
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
		<form id="frm" name="frm" method="post">
		<input type="hidden" id="code_seq" name="code_seq">
		<input type="hidden" id="p_code_seq" name="p_code_seq">
		<input type="hidden" id="vi_seq_hash" name="vi_seq_hash">
		<input type="hidden" id="va_status_hash" name="va_status_hash">
		<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
		   
			<div class="contents-con-framebox">
				<div class="nav-box">
	                <div class="nav-img"><img alt="" src="/resource/images/sub/sub9_tit_img.png"></div>
					<div class="nav-list">
						<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;KUBE&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">마이페이지</b>
					</div>
					<div class="nav-title">마이페이지</div>
				</div>
	            
	            <div style="margin-bottom:10px;">
	                <ul class="equip">
	                    <li><a href="/kube/mypage/bookmarkList.do">즐겨찾기</a></li>
	                    <li class="active"><a href="/kube/mypage/downloadReqList.do">다운로드 신청목록</a></li>
	                    <li><a href="/kube/mypage/videoMgmtList.do">동영상 관리</a></li>
	                    <li><a href="/kube/mypage/approveReqList.do">저작권 관리</a></li>
	                    <li><a href="/kube/mypage/videoCommentList.do">댓글 관리</a></li>
	                </ul>
	            </div>
	            
	            <div style="margin-top:10px;margin-bottom:10px;margin-left:662px;clear:both;display: inline-block;">
	            	<p class="inputDesign"> 
					<select name="selOrder" style="width:90px" onchange="javascript:funFrmPagingSubmit2(document.location.href);">
						<option value="0" ${paging.selOrder == '0' ? 'selected' : '' }>전체</option>
						<c:forEach var="codeList" items="${codeList }">
							<option value="${codeList.code_seq}" ${paging.selOrder == codeList.code_seq ? 'selected' : '' }>${codeList.code_desc}</option>
						</c:forEach>                                                   		
					</select>
	            </div>
				
				<div class="basic-list">
					<table id="listTable" summary="">
						<caption>게시판 테이블</caption>
						<colgroup>
							<col style="width: 28%">
							<col style="">
							<col style="width: 15%">
							<col style="width: 15%">
						</colgroup>
						<tbody>			
							<c:forEach var="videoList" items="${videoList}" varStatus="videoStatus">
								<c:if test="${videoStatus.first}">
									<tr style="border-top:2px solid #a9abae">
								</c:if>
								<c:if test="${!videoStatus.first}">
									</tr>
									
				            		<tr>
								</c:if>			
										<td class="like-td">
			                                <img src="${web_url.concat(videoList.thumb_log_path)}" style="cursor: pointer;" class="imgMaxWidth180" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');" />
			                            </td>
			                            <td class="like-td" style="text-align:left">
			                                <span class="media_txt01">${videoList.title}</span><br>
			                                <span class="media_txt02">${videoList.p_code_desc }</span><br>
			                                <span class="media_txt02">신청일 : ${cha:todate(videoList.reg_date, '-', '2') }</span>
			                            </td>
										<td class="like-td">
											<c:if test="${videoList.va_status == '44'}">
												<input type="button" name="srchDescription" class="btn_kube_app44" onclick="javascript:funApproveAct('${cha:seqEncode(videoList.vi_seq)}', '${cha:seqEncode('47')}', '9');" value="승인대기" style="width:80px;" >
											</c:if>
											<c:if test="${videoList.va_status == '45'}">
												<input type="button" name="srchDescription" class="btn_kube_app45" onclick="" value="승인완료" style="width:80px;cursor: default;" >
											</c:if>
											<c:if test="${videoList.va_status == '46'}">
												<input type="button" name="srchDescription" class="btn_kube_app46" onclick="javascript:funApproveAct('${cha:seqEncode(videoList.vi_seq)}', '${cha:seqEncode('44')}', '1');" value="승인거절" style="width:80px;" >
											</c:if>
											<c:if test="${videoList.va_status == '47'}">
												<input type="button" name="srchDescription" class="btn_kube_app46" onclick="javascript:funApproveAct('${cha:seqEncode(videoList.vi_seq)}', '${cha:seqEncode('44')}', '1');" value="신청취소" style="width:80px;" >
											</c:if>
			                            </td>
										<td class="like-td">
											<c:if test="${videoList.va_status == '45'}">
			                                	<input type="button" name="srchDescription" class="btn_down" onclick="javascript:funFileDownAct('${cha:seqEncode(videoList.vi_seq)}');" value="다운로드" style="width:80px;" >
			                                </c:if>
			                            </td>
								<c:if test="${videoStatus.last}">
									</tr>
								</c:if> 
							</c:forEach>
						</tbody>
					</table>
				</div>
	            <c:if test="${fn:length(videoList) == 0}">
	            	<div class="none_srh_result" style="clear:both">
	            		조회 결과가 없습니다.
	            	</div>
	            	
	            	<div style="clear:both"></div>
	            </c:if>
	                    
	            <div style="margin-bottom: 250px;margin-top: -170px;"></div>  
				<c:import url="/resource/common/include/kube_paging.jsp" />
				</div> 
			</form>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('8', '0', '0'); //menu script
});

function funApproveAct(vi_seq_hash, va_status_hash, g){
	
	var alert_msg = '';
	
	if(g == '1'){
		alert_msg = '재승인 요청하시겠습니까?';
	}else if(g == '9'){
		alert_msg = '승인 요청을 취소하시겠습니까?';
	}
		 
	if(confirm(alert_msg)){
		$('#vi_seq_hash').val(vi_seq_hash);
		$('#va_status_hash').val(va_status_hash);
		
		dataString = $("#frm").serialize();
		
	    $.ajax({
	       url: "/kube/updateApproveVideo.do",
	       type: "POST",
	       data: dataString,
	       dataType: "json",
	       success: function(msg) {
				
	    	   var tmp_result = $.trim(msg);
	    	   if(tmp_result != 'false'){
				   alert('처리 되었습니다');
				   location.replace('/kube/mypage/downloadReqList.do');
	    		   return true;
				}else{
	    		   	alert("오류가 발생 했습니다");
	    		   	$('#vi_seq_hash').val('');
	    			$('#va_status_hash').val('');
	    			return false;
				}
	 		}
		});
	}
}

function funFileDownAct(vi_seq_hash){
	$('#vi_seq_hash').val(vi_seq_hash);
	
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

function funVideoDetail(url, c1, c2){
	$('#p_code_seq').val(c1);
	$('#code_seq').val(c2);
	funGoPageDetail(url);
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />