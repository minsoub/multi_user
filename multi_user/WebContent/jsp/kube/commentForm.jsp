<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:if test="${fn:length(commentList) > 0}">
	<c:set var="pCnt" value="0"></c:set>
	<c:set var="subCnt" value="0"></c:set>
	<c:forEach var="c_list" items="${commentList }" varStatus="status" >
		<c:if test="${c_list.p_vc_seq == '0'}">
			<c:set var="tmpSubCnt" value="${c_list.c_comment_cnt}"></c:set>
			<c:set var="subCnt" value="0"></c:set>
			<c:set var="pCnt" value="${pCnt + 1}"></c:set>
			<div>
				<div class="reply-box01">
			        <div class="fl_left">
			            <span class="reply-txt01" onclick="javascript:userLayer('${c_list.reg_empno}')" style="cursor: pointer;"><b>${c_list.dept_name1} ${c_list.dept_name2 } ${c_list.name}</b></span>
			            <span class="reply-txt02">${cha:todate(c_list.c_reg_date, '-', '2')}</span>
			        </div>
			        <div class="fl_right"><a onclick="javascript:funReportShow('2', '${cha:seqEncode(c_list.vc_seq)}');" class="txt_box img_pointer">댓글신고</a></div>
			        <c:if test="${c_list.reg_empno ==  sessionScope.SESS_EMPNO}">
						<span class="media_txt03" style="float: right;margin-right: 10px;cursor: pointer;"><a onclick="javascript:funCommentDel(this, '${cha:seqEncode(c_list.vc_seq)}', '${pCnt}', 'Y', '${c_list.vc_seq }')" style="background-color:#f7f7f7" class="txt_box img_pointer">삭제</a></span>
					</c:if>
			        <div class="fl_left" style="width:100% ; margin-bottom:15px;">
			            <div class="reply-txt01" style="word-wrap: break-word;"><pre>${c_list.comment_desc }</pre></div>    
			        </div>
			        <div class="fl_left">
			            <a class="txt_box img_pointer" id="subCmTotCnt${pCnt }" onclick="javascript:$('.sub_comment_${c_list.vc_seq}').toggle();">댓글 <font><fmt:formatNumber value="${c_list.c_comment_cnt}" pattern="#,###,###,###" /></font></a> 
			        </div>
			        <div class="fl_right">
			            <img name="${c_list.my_like_cnt == 0 ? '11' : '12'}" src="/resource/images/sub/icon_kube${c_list.my_like_cnt == 0 ? '11' : '12'}.png" style="cursor: pointer;" onclick="javascript:funMyAct(this, '${cha:seqEncode(c_list.vc_seq)}');" /> <span class="num_gray"><fmt:formatNumber value="${c_list.p_like_cnt}" pattern="#,###,###,###" /></span>
			            <img name="${c_list.my_unlike_cnt == 0 ? '13' : '14'}" src="/resource/images/sub/icon_kube${c_list.my_unlike_cnt == 0 ? '13' : '14'}.png" style="cursor: pointer;margin-left:10px;" onclick="javascript:funMyAct(this, '${cha:seqEncode(c_list.vc_seq)}');" /> <span class="num_gray"><fmt:formatNumber value="${c_list.p_unlike_cnt}" pattern="#,###,###,###" /></span>
			        </div>                                
			    </div>
			    
			    <c:if test="${tmpSubCnt == 0}">
			    	<div class="reply-box02 sub_comment_${c_list.vc_seq}" style="display: none;">
			            <img src="/resource/kube_images/icon_reply.png" style="margin-right:10px;">
			            <textarea class="textarea" rows="3" name="comment_desc" style="width:89%"></textarea>                                    
			            <button type="button" onclick="javascript:funCommentReg(this, '${pCnt}')" class="btn_blue img_pointer" style="height:69px;">등록</button>
			            <input type="hidden" name="p_vc" value="${cha:seqEncode(c_list.vc_seq) }" />                           
			        </div>
				</c:if>
			</div>
		</c:if>
		<c:if test="${c_list.p_vc_seq != '0'}">
			<c:set var="subCnt" value="${subCnt + 1}"></c:set>
			
			<div class="sub_comment_${c_list.p_vc_seq}" style="display: none;">
				<div class="reply-box02">
			        <div class="fl_left">
			            <span class="reply-txt01" onclick="javascript:userLayer('${c_list.reg_empno}')" style="cursor: pointer;"><b>${c_list.dept_name1} ${c_list.dept_name2 } ${c_list.name}</b></span>
			            <span class="reply-txt02">${cha:todate(c_list.c_reg_date, '-', '2')}</span>
			        </div>
			        <div class="fl_right"><a onclick="javascript:funReportShow('2', '${cha:seqEncode(c_list.vc_seq)}');" class="txt_box img_pointer">댓글신고</a></div>
			        <c:if test="${c_list.reg_empno ==  sessionScope.SESS_EMPNO}">
						<span class="media_txt03" style="float: right;margin-right: 10px;cursor: pointer;"><a onclick="javascript:funCommentDel(this, '${cha:seqEncode(c_list.vc_seq)}', '${pCnt}', 'N')" style="background-color:#f7f7f7" class="txt_box img_pointer">삭제</a></span>
					</c:if>
			        <div class="fl_left" style="width:100% ; margin-bottom:15px;">
			            <div class="reply-txt01" style="word-wrap: break-word;"><pre>${c_list.comment_desc }</pre></div>    
			        </div>
			        <div class="fl_right">
			            <img name="${c_list.my_like_cnt == 0 ? '11' : '12'}" src="/resource/images/sub/icon_kube${c_list.my_like_cnt == 0 ? '11' : '12'}.png" style="cursor: pointer;" onclick="javascript:funMyAct(this, '${cha:seqEncode(c_list.vc_seq)}');" /> <span class="num_gray"><fmt:formatNumber value="${c_list.c_like_cnt}" pattern="#,###,###,###" /></span>
			            <img name="${c_list.my_unlike_cnt == 0 ? '13' : '14'}" src="/resource/images/sub/icon_kube${c_list.my_unlike_cnt == 0 ? '13' : '14'}.png" style="cursor: pointer;margin-left:10px;" onclick="javascript:funMyAct(this, '${cha:seqEncode(c_list.vc_seq)}');" /> <span class="num_gray"><fmt:formatNumber value="${c_list.c_unlike_cnt}" pattern="#,###,###,###" /></span>
			        </div>                                
			    </div>
			    
			    <c:if test="${subCnt == tmpSubCnt}">
			    	<div class="reply-box02">
			            <img src="/resource/kube_images/icon_reply.png">
			            <textarea class="textarea" rows="3" name="comment_desc" style="width:89%"></textarea>                                    
			            <button type="button" onclick="javascript:funCommentReg(this, '${pCnt}')" class="btn_blue img_pointer" style="height:69px;">등록</button>
			            <input type="hidden" name="p_vc" value="${cha:seqEncode(c_list.p_vc_seq) }" />                           
			        </div>
				</c:if>
			</div>
		</c:if>
	</c:forEach>
</c:if>