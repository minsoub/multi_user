<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:forEach var="c_list" items="${commentList }" varStatus="status" >
	<tr class="sub_comment_${c_list.p_vc_seq}">
		<td style="background-color: #f7f7f7; padding: 10px 25px; text-align: left">
			<div>
				<span class="media_txt04"><img src="/resource/images/sub/icon_reply.png" style="padding-right: 10px" /> ${c_list.dept_name1} ${c_list.dept_name2 } ${c_list.name}</span> 
				<span class="media_txt03" style="padding-left: 10px">${cha:todate(c_list.reg_date, '-', '2')}</span>
				<span class="media_txt03" style="float: right;margin-right: 1px;cursor: pointer;"><img src="/resource/images/btn/del.png" onclick="javascript:funCommentDel(this, '${cha:seqEncode(c_list.vc_seq)}', '${pCnt}', 'N')" /></span>
			</div>
			<div style="clear: both"></div>
			<div>
				<div class="media_txt05" style="padding-left: 25px"> 
					<pre>${c_list.comment_desc }</pre>
				</div>
			</div>
			<div style="margin-top: 20px; float: right">
				<img name="11" src="/resource/images/sub/icon_kube11.png" style="cursor: pointer;" onclick="javascript:funMyAct(this, '${cha:seqEncode(c_list.vc_seq)}');" /> <font><fmt:formatNumber value="0" pattern="#,###,###,###"></fmt:formatNumber></font>&nbsp;&nbsp;&nbsp;&nbsp;
                <img name="13" src="/resource/images/sub/icon_kube13.png" style="cursor: pointer;" onclick="javascript:funMyAct(this, '${cha:seqEncode(c_list.vc_seq)}');" /> <font><fmt:formatNumber value="0" pattern="#,###,###,###"></fmt:formatNumber></font>&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="txt_box" style="cursor: pointer;" onclick="javascript:funReportShow('2', '${cha:seqEncode(c_list.vc_seq)}');">신고하기</a>
			</div>
			
			<div style="clear: both"></div>

			<div style="border-top: 1px solid #e7e7e7; margin-top: 15px; padding-top: 15px">
				<img src="/resource/images/sub/icon_reply.png" style="padding-right: 10px" />
				<textarea class="textarea-style" rows="3" name="comment_desc" style="width: 87%"></textarea>
				<input type="button" name="srchDescription" class="btn_down" onclick="javascript:funCommentReg(this, '${pCnt}')" value="등록" style="width: 60px; height: 55px; background-color: #0b4894">
				<input type="hidden" name="p_vc" value="${cha:seqEncode(c_list.p_vc_seq) }" />
			</div>
		</td>
	</tr>
</c:forEach>