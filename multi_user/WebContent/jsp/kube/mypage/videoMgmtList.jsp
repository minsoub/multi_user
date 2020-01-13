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
            <li><a href="/kube/mypage/downloadReqList.do">다운로드 신청목록</a></li>
            <li class="active"><a href="/kube/mypage/videoMgmtList.do">동영상 관리</a></li>
            <li><a href="/kube/mypage/approveReqList.do">저작권 관리</a></li>
            <li><a href="/kube/mypage/videoCommentList.do">댓글 관리</a></li>
            <li><a href="/kube/mypage/customizeMenu.do">메뉴 관리</a></li>
        </ul>
    </div>
    
    <form id="frm" name="frm" method="post">
	<input type="hidden" id="code_seq" name="code_seq">
	<input type="hidden" id="p_code_seq" name="p_code_seq">
	<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
	<input type="hidden" id="taskVal" name="taskVal">
	<input type="hidden" id="vi_seq_hash" name="vi_seq_hash">
	
    <div class="fl_left" style="margin-bottom:10px">
    	<input type="checkbox" id="chk0" name="videoChk" value="all"> 
		<label for="chk0"></label>
		<select name="selTask" onchange="javascript:funTaskAct(this);" class="selectbox" style="width:150px">
        	<optgroup label="작업선택">
            	<option value="">작업선택</option>
            </optgroup>                            
            <optgroup label="공개여부">					           			                                    
            	<option value="39">공개</option>
                <option value="40">비공개</option>
            </optgroup>								                                    
            <optgroup label="다운로드">								                                    
				<option value="41">모두 다운로드 가능</option>
                <option value="42">등록자(본인) 승인 후 다운로드</option>								                                    
                <option value="43">다운로드 불가</option>
            </optgroup>		
            <optgroup label="삭제">								                                    
                <option value="9">삭제</option>
            </optgroup>						                                    
		</select>                            
    </div>
    <div class="fl_right">
    	<select name="selOrder" class="selectbox" style="width:150px" onchange="javascript:funFrmPagingSubmit2(document.location.href);">
			<option value="reg_date" ${paging.selOrder == 'reg_date' ? 'selected' : '' }>최신순</option>
			<option value="visit_cnt" ${paging.selOrder == 'visit_cnt' ? 'selected' : '' }>조회순</option>
			<option value="like_cnt" ${paging.selOrder == 'like_cnt' ? 'selected' : '' }>좋아요순</option>
			<option value="down_cnt" ${paging.selOrder == 'down_cnt' ? 'selected' : '' }>다운로드순</option>
		</select>
    </div>
    
    <table class="table-list1" style="margin-top:10px">
        <colgroup>
            <col width="5%" />
            <col width="22%" />
            <col />
            <col width="30%" />
        </colgroup>
        <tbody>
        	<c:forEach var="videoList" items="${videoList}" varStatus="videoStatus">
				<tr>
					<td>
                    	<div class="checks small">
                        	<input type="checkbox" id="chk${videoStatus.count }" name="videoChk" value="${cha:seqEncode(videoList.vi_seq) }"> 
							<label for="chk${videoStatus.count }"></label> 
                         </div>
					</td>
					<td>
						<div>
							<img src="${web_url.concat(videoList.thumb_log_path)}" style="cursor: pointer;width:253px; height: 142px;" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');" />
						</div>
					</td>
					<td class="report">
	                    <div class="mbox01">
	                        <span class="media_txt01">${videoList.title}<c:if test="${videoList.conv_flag == '9'}"> (영상 컨버팅 진행 중)</c:if><img src="/resource/kube_images/btn_edit2.png" style="margin-left: 15px;cursor: pointer;" onclick="javascript:$('#vi_seq_hash').val('${cha:seqEncode(videoList.vi_seq)}'); funGoPageDetail('/videoMoidfy.do');"></span><br>
	                        <span class="media_txt02">${videoList.p_code_desc}</span><br>
	                        <span class="media_txt01">등록일: ${cha:todate(videoList.reg_date, '-', '2')}</span><br><br>
                        	<select name="selOpenFlag" class="selectbox" style="width:100px;" onchange="javascript:funTaskAct(this, '${videoList.open_flag}');">
								<option value="39" ${videoList.open_flag == '39' ? 'selected' : ''}>공개</option>
								<option value="40" ${videoList.open_flag == '40' ? 'selected' : ''}>비공개</option>
							</select>
							<select name="selDownFlag" class="selectbox" style="width:200px;" onchange="javascript:funTaskAct(this, '${videoList.download_flag }');">
								<option value="41" ${videoList.download_flag == '41' ? 'selected' : ''}>모두 다운로드 가능</option>
								<option value="42" ${videoList.download_flag == '42' ? 'selected' : ''}>등록자(본인) 승인 후 다운로드</option>
								<option value="43" ${videoList.download_flag == '43' ? 'selected' : ''}>다운로드 불가</option>
                           	</select>
                           	<c:if test="${videoList.approve_cnt > 0}">
                           		<span class="media_txt01 img_pointer" style="margin-left:10px;text-decoration: underline;" onclick="javascript:funApproveList('${cha:seqEncode(videoList.vi_seq) }');">다운로드 요청 : <span class="text_red"><fmt:formatNumber value="${videoList.approve_cnt}" pattern="#,###,###,###"/> 건</span> / <span><fmt:formatNumber value="${videoList.tot_approve_cnt }" pattern="#,###,###,###" /> 건</span></span><br>
							</c:if>        
							<c:if test="${videoList.approve_cnt == 0}">
								<span class="media_txt01" style="margin-left:10px;">다운로드 요청 : <span>0 건</span> / <span><fmt:formatNumber value="${videoList.tot_approve_cnt }" pattern="#,###,###,###" /> 건</span></span><br>
							</c:if>                   		
	                    </div>
	                </td>
	                <td style="text-align:right; padding-right:25px;">
	                    <span class="media_txt01">
	                        조회수 : <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###" /> &nbsp;&nbsp;/&nbsp;&nbsp; 댓글 : <fmt:formatNumber value="${videoList.comment_cnt}" pattern="#,###,###,###"/> &nbsp;&nbsp;/&nbsp;&nbsp; 다운로드 : <fmt:formatNumber value="${videoList.down_cnt}" pattern="#,###,###,###" />
	                    </span><br><br><br><br>
	                    <span class="media_txt03">
	                        <img src="/resource/kube_images/icon_04.png" /> <span class="num_gray"><fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###" /></span>
	                        <img src="/resource/kube_images/icon_05.png" style="margin-left:10px;"/> <span class="num_gray"><fmt:formatNumber value="${videoList.unlike_cnt}" pattern="#,###,###,###" /></span>
	                    </span>
	                </td>
				</tr>
    		</c:forEach>
    		<c:if test="${fn:length(videoList) == 0}">
		  		<tr><td>등록된 영상이 없습니다.</td></tr>
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
	$('select[name=selTask]').prev().css('height','210px');          
	$('select[name=selDownFlag]').parent().css('margin-left','10px');           
	
	funAllChkCtrl();
});

function funTaskAct(obj, g){
	
	var selectedVal	= $(obj).val();
	var pre_selectedVal = '';
	var boolChk = true;
	
	if(g != undefined){
		//같은 상태값으로 변경 불가		
		if(selectedVal != g){
			pre_selectedVal = g;
			$(obj).closest('td').prev().prev().find('input').prop("checked", true);
		}else{
			boolChk = false;
		}
	}
	
	if(selectedVal != '' && boolChk){
		var chkCnt = 0;
		
		$('#taskVal').val(selectedVal);
		
		$('input[name=videoChk]').each(function(){
			if($(this).is(":checked")){
				chkCnt = chkCnt + 1;
			}
		});
		
		if(chkCnt == 0){
			alert('1개 이상의 영상을 선택해야 합니다.');
			$(obj).val('');
			$('select[name=selTask]').prev().css('height','210px'); 
			return false;
		}else{
			var alert_msg = '';
			
			if(selectedVal == '39' || selectedVal == '40' ){
				alert_msg = '공개 상태를 변경하시겠습니까?';
			}else if(selectedVal == '41' || selectedVal == '42' || selectedVal == '43'){
				alert_msg = '다운로드 요청 건이 있는 상태에서 다운로드 권한을 변경할 경우\n기존의 요청은 모두 거절 됩니다.\n\n그래도 다운로드 권한을 변경하시겠습니까?';
			}else if(selectedVal == '9'){
				alert_msg = '영상을 삭제할 경우 복구가 불가능 합니다.\n\n정말 삭제하시겠습니까?';
			}
			
			if(confirm(alert_msg)){
				dataString = $("#frm").serialize();

			    $.ajax({
			       type: "POST",
			       url: "/kube/mypage/updateMyVideoFlag.do",
			       data: dataString,
			       dataType: "json",
			       success: function(msg) {
			    	   
			    	   var tmp_result = $.trim(msg);
			    	   if(tmp_result != 'false'){
			    		   funFrmPagingSubmit2(document.location.href);
						   
			    		   return true;
						}else{
			    		   alert("오류가 발생 했습니다");
			    		   
			    		   if(g != undefined){ 
								$(obj).val(pre_selectedVal);
								$(obj).closest('td').prev().prev().find('input').prop("checked", false);
							}else{
								$(obj).val('');
								$('select[name=selTask]').prev().css('height','210px');
							}
			    		   return false;
						}
			 		}             
				}); 
			}else{
				if(g != undefined){ 
					$(obj).val(pre_selectedVal);
					$(obj).closest('td').prev().prev().find('input').prop("checked", false);
				}else{
					$(obj).val('');
					$('select[name=selTask]').prev().css('height','210px');
				}
				return false;
			}
		}
	}
}

function funApproveList(vi_seq_hash){
	$('#vi_seq_hash').val(vi_seq_hash);
	funFrmPagingSubmit2('/kube/mypage/approveReqList.do');
}

function funVideoDetail(url, c1, c2){
	$('#p_code_seq').val(c1);
	$('#code_seq').val(c2);
	funGoPageDetail(url);
}
</script>
<c:import url="/resource/common/include/kube_bottom.jsp" />