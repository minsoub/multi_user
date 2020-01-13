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
            <li><a href="/kube/mypage/videoMgmtList.do">동영상 관리</a></li>
            <li class="active"><a href="/kube/mypage/approveReqList.do">저작권 관리</a></li>
            <li><a href="/kube/mypage/videoCommentList.do">댓글 관리</a></li>
            <li><a href="/kube/mypage/customizeMenu.do">메뉴 관리</a></li>
        </ul>
	</div>
	
	<form id="frm" name="frm" method="post">
	<input type="hidden" id="code_seq" name="code_seq">
	<input type="hidden" id="p_code_seq" name="p_code_seq">
	<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
	<input type="hidden" id="taskVal" name="taskVal">
	<input type="hidden" id="app_empno" name="app_empno">
	<input type="hidden" id="vi_seq_hash" name="vi_seq_hash">
	<div class="fl_left" style="margin-bottom:10px">                            
	     <input type="checkbox" id="chk0" name="videoChk" value="all"> 
         <label for="chk0"></label> 
	     <select name="selTask" onchange="javascript:funTaskAct(this);" class="selectbox" style="width:150px;">
         	<option value="">작업선택</option>
            <option value="45">전체 승인</option>
            <option value="46">전체 거절</option>								                                    
          </select>
	</div>
	<div class="fl_right">
		<select name="selOrder" class="selectbox" style="width:150px;" onchange="javascript:funFrmPagingSubmit2(document.location.href);">
			<option value="approve_date" ${paging.selOrder == 'approve_date' ? 'selected' : '' }>최근요청순</option>
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
		<c:set var="tmp_vi_seq" value=""></c:set>	
		<c:set var="tmp_app_vi_seq" value=""></c:set>
		<c:forEach var="videoList" items="${videoList}" varStatus="videoStatus">	
		  <tr>
	          <td>
	              	<input type="checkbox" id="chk${cha:seqEncode(videoList.vi_seq)}" name="videoChk" value="${cha:seqEncode(videoList.vi_seq) }"> 
					<label for="chk${cha:seqEncode(videoList.vi_seq)}"></label> 
	          </td>
	          <td>
	              	<div>
						<img src="${web_url.concat(videoList.thumb_log_path)}" style="cursor: pointer;width:253px; height: 142px;" class="imgMaxWidth180" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');"/>
					</div>
	          </td>
	          <td class="report">
	              <div class="mbox01">
	                  <span class="media_txt01">${videoList.title}</span><br>
                      <span class="media_txt02">${videoList.p_code_desc }</span><br>
                      <span class="media_txt01">등록일: ${cha:todate(videoList.reg_date, '-', '2') }</span><br><br>
	                  <c:if test="${videoList.approve_cnt > 0}">
                      	<span class="media_txt01 img_pointer" style="text-decoration: underline;" onclick="javascript:$('.approveSubTr${videoList.vi_seq}').toggle();">다운로드 요청 : <span class="text_red"><fmt:formatNumber value="${videoList.approve_cnt}" pattern="#,###,###,###"/> 건</span> / <span><fmt:formatNumber value="${videoList.tot_approve_cnt }" pattern="#,###,###,###" /> 건</span></span><br>
					  </c:if>        
					  <c:if test="${videoList.approve_cnt == 0}">
						<span class="media_txt01">다운로드 요청 : <span>0 건</span> / <span><fmt:formatNumber value="${videoList.tot_approve_cnt }" pattern="#,###,###,###" /> 건</span></span><br>
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
		      <c:forEach var="approveList" items="${approveList }" varStatus="approveStatus">
				<c:if test="${videoList.vi_seq == approveList.vi_seq}">
					<c:if test="${fn:trim(targetVi_seq) != '' && fn:trim(targetVi_seq) != null}">
						<tr class="approveSubTr${approveList.vi_seq }" style="${targetVi_seq != cha:seqEncode(approveList.vi_seq) ? 'display: none;' : ''}">
					</c:if>
					<c:if test="${fn:trim(targetVi_seq) == '' || fn:trim(targetVi_seq) == null}">
						<tr class="approveSubTr${approveList.vi_seq }">
					</c:if>
							<td colspan="4" style="background-color:#f7f7f7;">
								<div class="fl_left" style="padding-left:30px; width:375px; text-align:left">
                                    <span class="reply-txt01" onclick="javascript:userLayer('${approveList.app_empno}')" style="cursor: pointer;">
                                        <img src="/resource/kube_images/icon_reply.png" style="margin-right:10px;"><b>${approveList.dept_name1 }  ${approveList.dept_name2 } ${approveList.name }</b>
                                    </span>
                                </div>
                                <div class="fl_left" style="width:200px; text-align:left;" >
                                    <span class="reply-txt01">신청일 : ${cha:todate(approveList.approve_date, '-', '2') }</span>
                                </div>
                                <div class="fl_right" style="margin-right:20px">
                                	<c:if test="${approveList.va_status == 44}">
                                		<a class="blue_box" style="cursor: pointer;" onclick="javascript:funTaskAct('${cha:seqEncode(approveList.vi_seq) }', '${approveList.app_empno}', '45');">승인</a> <a class="red_box" style="cursor: pointer;" onclick="javascript:funTaskAct('${cha:seqEncode(approveList.vi_seq) }', '${approveList.app_empno}', '46');">거절</a>
									</c:if>
									<c:if test="${approveList.va_status == 45}">
										<span><b>승인완료</b></span>
									</c:if>
									<c:if test="${approveList.va_status == 46}">
										<span class="text_red"><b>승인거절</b></span>
									</c:if>
                                </div>
							</td>
						</tr>
				</c:if>
			</c:forEach>
		</c:forEach>
		<c:if test="${fn:length(videoList) == 0}">
		  	<tr><td>조회 결과가 없습니다.</td></tr>
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
	funAllChkCtrl();
});

function funTaskAct(obj, app_empno, g){
	
	var selectedVal	= '';
	
	if(g != undefined){
		$('#chk' + obj).prop("checked", true);
		selectedVal	= g;
	}else{
		selectedVal	= $(obj).val();
	}
	
	if(selectedVal != ''){
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
			return false;
		}else{
			var alert_msg = '';
			
			if(selectedVal == '45'){
				alert_msg = '선택하신 요청 건을 승인 하시겠습니까?';
			}else if(selectedVal == '46'){
				alert_msg = '선택하신 요청 건을 거절 하시겠습니까?';
			}
			
			if(confirm(alert_msg)){
				
				if(g != undefined){
					$('#app_empno').val(app_empno);
					$('#vi_seq_hash').val(obj);
				}
				
				dataString = $("#frm").serialize();

			    $.ajax({
			       type: "POST",
			       url: "/kube/mypage/updateMyVideoApproveFlag.do",
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
								$('#chk' + obj).prop("checked", false);
								$('#app_empno').val('');
								$('#vi_seq_hash').val('');
							}else{
								$(obj).val('');
							}
			    		   return false;
						}
			 		}             
				}); 
			}else{
				if(g != undefined){ 
					$('#chk' + obj).prop("checked", false);
					$('#app_empno').val('');
					$('#vi_seq_hash').val('');
				}else{
					$(obj).val('');
				}
				return false;
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