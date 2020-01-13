<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/kube_topMenu.jsp" />
<c:import url="/resource/common/include/kube_leftMenu.jsp" />

<div id="contents">
                        
    <div class="m_title_01" style="margin:10px 0 30px 0">마이페이지</div> 
    
    <div class="tab_box">
        <ul class="equip">
            <li class="active"><a href="/kube/mypage/bookmarkList.do">즐겨찾기</a></li>
            <li><a href="/kube/mypage/downloadReqList.do">다운로드 신청목록</a></li>
            <li><a href="/kube/mypage/videoMgmtList.do">동영상 관리</a></li>
            <li><a href="/kube/mypage/approveReqList.do">저작권 관리</a></li>
            <li><a href="/kube/mypage/videoCommentList.do">댓글 관리</a></li>
            <li><a href="/kube/mypage/customizeMenu.do">메뉴 관리</a></li>
        </ul>
    </div>
    
    <form id="frm" name="frm" method="post">
	<input type="hidden" id="code_seq" name="code_seq">
	<input type="hidden" id="p_code_seq" name="p_code_seq">
	<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
	<input type="hidden" id="right_gubun" name="right_gubun">
    <div class="fl_left" style="margin-bottom:10px">                            
        <input type="checkbox" id="chk0" name="videoChk" value="all"> 
		<label for="chk0"></label> 
        <label for=""></label>
        <select name="selTask" onchange="javascript:funTaskAct(this);" class="selectbox" style="width:150px">
			<option value="">작업선택</option>								                                    
            <option value="1">영상 반복재생</option>
            <option value="2">즐겨찾기 제거</option>								                                    
		</select>
    </div>
    <div class="fl_right">
		<label for=""></label>
        <select name="selOrder" class="selectbox" style="width:150px;" onchange="javascript:funFrmPagingSubmit2(document.location.href);">
			<option value="reg_date" ${paging.selOrder == 'reg_date' ? 'selected' : '' }>최신순</option>
			<option value="popular_cnt" ${paging.selOrder == 'popular_cnt' ? 'selected' : '' }>인기순</option>
		</select>
    </div>
    
    <c:set var="chkCnt" value="true"></c:set>
    <c:forEach var="videoList" items="${videoList}" varStatus="videoStatus">
		<c:if test="${videoStatus.first}">
			<div class="media-box">
		</c:if>
		<c:if test="${!videoStatus.first && videoStatus.index % 5 == 0}">
			</div>              
          
          	<c:set var="clearStyle" value=""></c:set>
           	<c:set var="chkCnt" value="true"></c:set> 

          	<div class="media-box" style="margin-top:40px;">
          	
		</c:if>
		
		<c:if test="${chkCnt}">
			<c:set var="clearStyle" value="clear:both"></c:set> 
		</c:if> 
               <div class="media-box01 fl_left" style="${clearStyle};${videoStatus.index % 5 != 4 ? 'margin-right:16px;' : ''}">
               		<div>
               			<div style="position: absolute; padding:10px;">
		                    <input type="checkbox" id="chk${videoStatus.count }" name="videoChk" value="${cha:seqEncode(videoList.vi_seq) }"> 
							<label for="chk${videoStatus.count }" style="margin-right: -6px;"></label> 
		                </div>
		                <div class="media-time">${cha:secToHour(videoList.duration)}</div>
		                <img src="${web_url.concat(videoList.thumb_log_path)}" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');" class="img_pointer" style="width:253px; height: 142px;" />
		            </div>	
		            <div class="mbox01">
		            	<span class="media_txt01" style="width: 220px; overflow: hidden; display: inline-block; white-space: nowrap; -ms-text-overflow: ellipsis;">${videoList.title}</span><br>
	                    <span class="media_txt02 fl_left">${videoList.p_code_desc }</span>
	                    <span class="media_txt03 fl_right">
	                        <img src="/resource/kube_images/icon_12.png"> <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###" />
	                        <img src="/resource/kube_images/icon_13.png" style="margin-left:15px;"> <fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###" />
	                    </span>
		            </div>    
		            
               </div>
		<c:if test="${videoStatus.last}"> 
			</div>
			
		</c:if>           
		<c:set var="chkCnt" value="false"></c:set>
		<c:set var="clearStyle" value=""></c:set>
	</c:forEach>
	</form>
	
    <c:if test="${fn:length(videoList) == 0}">
    	<table class="table-list1" style="margin-top:10px">
        <tbody>
			<tr><td>즐겨찾기 목록이 없습니다.</td></tr>
		</tbody>
	</table>

	</c:if>
	<c:if test="${fn:length(videoList) != 0}">	                  
		<c:import url="/resource/common/include/kube_paging.jsp" />
	</c:if>
</div>
<script type="text/javascript">
$(document).ready(function() {
	funAllChkCtrl();
});

function funTaskAct(obj){
	var selectedVal = $(obj).val();
	
	if(selectedVal != ''){
		var chkCnt = 0;
		
		$('input[name=videoChk]').each(function(){
			if($(this).is(":checked")){
				chkCnt = chkCnt + 1;
			}
		});
		
		if(chkCnt == 0){
			alert('1개 이상의 영상을 선택해야 합니다.');
			$(obj).val('');
			return false;
		}else{
			if(selectedVal == '1'){
				
				$('input[name=chkVideoSeqArr]').remove();
				
				$('input[name=videoChk]').each(function(){
					if($(this).is(":checked")){  
						if($(this).val() != 'all'){  
							$('#frm').append('<input type="hidden" name="chkVideoSeqArr" value="' + $(this).val() + '" />');
						}
					}
				});
				
				$('#right_gubun').val('M');
				
				funGoPageDetail('/kube/watch/' + $('input[name=chkVideoSeqArr]').eq(0).val());
				return true;
			}else if(selectedVal == '2'){
				if(confirm('선택하신 영상을 즐겨찾기 목록에서 제거 하시겠습니까?')){
					dataString = $("#frm").serialize();
	
				    $.ajax({
				       type: "POST",
				       url: "/kube/mypage/deleteMyBookMarkVideo.do",
				       data: dataString,
				       dataType: "json",
				       success: function(msg) {
				    	   
				    	   var tmp_result = $.trim(msg);
				    	   if(tmp_result != 'false'){
							   location.replace('/kube/mypage/bookmarkList.do');
							   
				    		   return true;
							}else{
				    		   alert("오류가 발생 했습니다");
				    		   $(obj).val('');
				    		   return false;
							}
				 		}
					});
				}else{
					$(obj).val('');
					
					return false;
				}
			}
		}
	}
}

function funVideoDetail(url, c1, c2){
	$('#p_code_seq').val(c1);
	$('#code_seq').val(c2);
	funGoPageDetail(url);
}
</script>
<c:import url="/resource/common/include/kube_bottom.jsp" />