<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:forEach var="c_list" items="${commentList }" varStatus="status" >
	<div class="sub_comment_${c_list.p_vc_seq}">
		<div class="reply-box02">
	        <div class="fl_left">
	            <span class="reply-txt01" onclick="javascript:userLayer('${c_list.reg_empno}')" style="cursor: pointer;"><b>${c_list.dept_name1} ${c_list.dept_name2 } ${c_list.name}</b></span>
	            <span class="reply-txt02">${cha:todate(c_list.reg_date, '-', '2')}</span>
	        </div>
	        <div class="fl_right"><a onclick="javascript:funReportShow('2', '${cha:seqEncode(c_list.vc_seq)}');" class="txt_box img_pointer">댓글신고</a></div>
	        <c:if test="${c_list.reg_empno ==  sessionScope.SESS_EMPNO}">
				<span class="media_txt03" style="float: right;margin-right: 10px;cursor: pointer;"><a onclick="javascript:funCommentDel(this, '${cha:seqEncode(c_list.vc_seq)}', '${pCnt}', 'N')" style="background-color:#f7f7f7" class="txt_box img_pointer">삭제</a></span>
			</c:if>
	        <div class="fl_left" style="width:100% ; margin-bottom:15px;">
	            <div class="reply-txt01" style="word-wrap: break-word;"><pre>${c_list.comment_desc }</pre></div>    
	        </div>
	        <div class="fl_right">
	            <img name="11" src="/resource/images/sub/icon_kube11.png" style="cursor: pointer;" onclick="javascript:funMyAct(this, '${cha:seqEncode(c_list.vc_seq)}');" /> <span class="num_gray"><fmt:formatNumber value="0" pattern="#,###,###,###" /></span>
	            <img name="13" src="/resource/images/sub/icon_kube13.png" style="cursor: pointer;" onclick="javascript:funMyAct(this, '${cha:seqEncode(c_list.vc_seq)}');" /> <span class="num_gray"><fmt:formatNumber value="0" pattern="#,###,###,###" /></span>
	        </div>                                
	    </div>
	    
	   	<div class="reply-box02">
	        <img src="/resource/kube_images/icon_reply.png" style="margin-right:10px;">
	        <textarea class="textarea" rows="3" name="comment_desc" style="width:89%"></textarea>                                    
	        <button type="button" onclick="javascript:funCommentReg(this, '${pCnt}')" class="btn_blue img_pointer" style="height:69px;">등록</button>
	        <input type="hidden" name="p_vc" value="${cha:seqEncode(c_list.p_vc_seq) }" />                           
	    </div>
	</div>
</c:forEach>