<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/kube_topMenu.jsp" />
<c:import url="/resource/common/include/kube_leftMenu.jsp" />

<div id="contents">
                        
    <div class="m_title_01" style="margin:10px 0 30px 0">마이페이지</div> 
    
    <div class="tab_box">
        <ul class="equip">
            <li><a href="/kube/mypage/bookmarkList.do">즐겨찾기</a></li>
            <li class="active"><a href="/kube/mypage/downloadReqList.do">다운로드 신청목록</a></li>
            <li><a href="/kube/mypage/videoMgmtList.do">동영상 관리</a></li>
            <li><a href="/kube/mypage/approveReqList.do">저작권 관리</a></li>
            <li><a href="/kube/mypage/videoCommentList.do">댓글 관리</a></li>
            <li><a href="/kube/mypage/customizeMenu.do">메뉴 관리</a></li>
        </ul>
    </div>
    
    <form id="frm" name="frm" method="post">
	<input type="hidden" id="code_seq" name="code_seq">
	<input type="hidden" id="p_code_seq" name="p_code_seq">
	<input type="hidden" id="vi_seq_hash" name="vi_seq_hash">
	<input type="hidden" id="va_status_hash" name="va_status_hash">
	<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
	
    <div class="fl_left" style="margin-bottom:10px">                            
		<select name="selOrder" class="selectbox" style="width:150px;" onchange="javascript:funFrmPagingSubmit2(document.location.href);">
			<option value="0" ${paging.selOrder == '0' ? 'selected' : '' }>전체</option>
			<c:forEach var="codeList" items="${codeList }">
				<option value="${codeList.code_seq}" ${paging.selOrder == codeList.code_seq ? 'selected' : '' }>${codeList.code_desc}</option>
			</c:forEach>                                                   		
		</select>
    </div>
    
    <table class="table-list1" style="margin-top:10px">
        <colgroup>
            <col width="22%" />
            <col />
            <col width="15%" />
            <col width="18%" />
        </colgroup>
        <tbody>
        	
        	<c:forEach var="videoList" items="${videoList}" varStatus="videoStatus">
      		<tr>
				<td>
					<div>
						<img src="${web_url.concat(videoList.thumb_log_path)}" style="cursor: pointer;width:253px; height: 142px;" class="imgMaxWidth180" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');"/>
					</div>
				</td>
				<td class="report">
                    <div class="mbox01">
                        <span class="media_txt01">${videoList.title}</span><br>
                        <span class="media_txt02">${videoList.p_code_desc }</span><br>
                        <span class="media_txt01">신청일: ${cha:todate(videoList.reg_date, '-', '2') }</span>
                    </div>
                </td>
                <td>
	                <c:if test="${videoList.va_status == '44'}">
						<a class="btn_white img_pointer" onclick="javascript:funApproveAct('${cha:seqEncode(videoList.vi_seq)}', '${cha:seqEncode('47')}', '9');">승인대기</a>
					</c:if>
					<c:if test="${videoList.va_status == '45'}">
						<a class="btn_white">승인완료</a>
					</c:if>
					<c:if test="${videoList.va_status == '46'}">
						<a class="btn_white img_pointer" onclick="javascript:funApproveAct('${cha:seqEncode(videoList.vi_seq)}', '${cha:seqEncode('44')}', '1');"><span class="text_red">거절</span></a>
					</c:if>
					<c:if test="${videoList.va_status == '47'}">
						<a class="btn_white img_pointer" onclick="javascript:funApproveAct('${cha:seqEncode(videoList.vi_seq)}', '${cha:seqEncode('44')}', '1');">신청취소</a>
					</c:if>
                </td>
                <td>
                	<c:if test="${videoList.va_status == '45'}">
                		<a class="btn_orange1 img_pointer" onclick="javascript:funFileDownAct('${cha:seqEncode(videoList.vi_seq)}');">다운로드</a>
                	</c:if>	
                	<c:if test="${videoList.va_status != '45'}">-</c:if>
				</td>
			</tr>
			</c:forEach>
			<c:if test="${fn:length(videoList) == 0}">
		  		<tr><td>다운로드 신청목록이 없습니다.</td></tr>
			</c:if>
		</tbody>
	</table>
	</form>
	<c:if test="${fn:length(videoList) != 0}">	                  
		<c:import url="/resource/common/include/kube_paging.jsp" />
	</c:if>
</div>
<script type="text/javascript">
$(document).ready(function() {
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
<c:import url="/resource/common/include/kube_bottom.jsp" />