<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:if test="${fn:length(commentList) > 0}">
	<div class="basic-list">
		<table id="listTable" summary="">
			<tbody>
				<c:set var="pCnt" value="0"></c:set>
				<c:set var="subCnt" value="0"></c:set>
				<c:forEach var="c_list" items="${commentList }" varStatus="status" >
					<c:if test="${c_list.p_vc_seq == '0'}">
						<c:set var="tmpSubCnt" value="${c_list.c_comment_cnt}"></c:set>
						<c:set var="subCnt" value="0"></c:set>
						<c:set var="pCnt" value="${pCnt + 1}"></c:set> 
						<tr>
							<td style="padding-left: 20px; text-align: left">
								<div>
									<span class="media_txt04">${c_list.dept_name1} ${c_list.dept_name2 } ${c_list.name}</span> 
									<span class="media_txt03" style="padding-left: 10px">${cha:todate(c_list.c_reg_date, '-', '2')}</span>
									<c:if test="${c_list.reg_empno ==  sessionScope.SESS_EMPNO}">
										<span class="media_txt03" style="float: right;margin-right: 1px;cursor: pointer;"><img src="/resource/images/btn/del.png" onclick="javascript:funCommentDel(this, '${cha:seqEncode(c_list.vc_seq)}', '${pCnt}', 'Y', '${c_list.vc_seq }')" /></span>
									</c:if> 
								</div>
								<c:if test="${c_list.reg_empno ==  sessionScope.SESS_EMPNO}">
									<div style="clear: both"></div>
								</c:if>
								<div>
									<div class="media_txt05"> 
										<pre>${c_list.comment_desc }</pre>
									</div>
								</div>
								<div style="margin-top: 20px; float: left; cursor: pointer;">
									<a class="txt_box media_txt04" id="subCmTotCnt${pCnt }" onclick="javascript:$('.sub_comment_${c_list.vc_seq}').toggle();">댓글 <font><fmt:formatNumber value="${c_list.c_comment_cnt}" pattern="#,###,###,###"></fmt:formatNumber></font></a> 
								</div>
								<div style="margin-top: 20px; float: right">
									<img name="${c_list.my_like_cnt == 0 ? '11' : '12'}" src="/resource/images/sub/icon_kube${c_list.my_like_cnt == 0 ? '11' : '12'}.png" style="cursor: pointer;" onclick="javascript:funMyAct(this, '${cha:seqEncode(c_list.vc_seq)}');" /> <font><fmt:formatNumber value="${c_list.p_like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></font>&nbsp;&nbsp;&nbsp;&nbsp;
				                    <img name="${c_list.my_unlike_cnt == 0 ? '13' : '14'}" src="/resource/images/sub/icon_kube${c_list.my_unlike_cnt == 0 ? '13' : '14'}.png" style="cursor: pointer;" onclick="javascript:funMyAct(this, '${cha:seqEncode(c_list.vc_seq)}');" /> <font><fmt:formatNumber value="${c_list.p_unlike_cnt}" pattern="#,###,###,###"></fmt:formatNumber></font>&nbsp;&nbsp;&nbsp;&nbsp;
									<a class="txt_box" style="cursor: pointer;" onclick="javascript:funReportShow('2', '${cha:seqEncode(c_list.vc_seq)}');">신고하기</a>
								</div>
							</td> 
						</tr>
							
						<c:if test="${tmpSubCnt == 0}">
							<tr class="sub_comment_${c_list.vc_seq}" style="display: none;">
								<td style="background-color: #f7f7f7; padding: 10px 25px; text-align: left">
									<div style="clear: both"></div> 
				 				
									<div style="border-top: 1px solid #e7e7e7; margin-top: 15px; padding-top: 15px">
										<img src="/resource/images/sub/icon_reply.png" style="padding-right: 10px" />
										<textarea class="textarea-style" rows="3" name="comment_desc" style="width: 87%"></textarea>
										<input type="button" name="srchDescription" class="btn_down" onclick="javascript:funCommentReg(this, '${pCnt}')" value="등록" style="width: 60px; height: 55px; background-color: #0b4894">
										<input type="hidden" name="p_vc" value="${cha:seqEncode(c_list.vc_seq) }" />
									</div>
								</td>
							</tr>
						</c:if>
					</c:if>
					<c:if test="${c_list.p_vc_seq != '0'}">
						<c:set var="subCnt" value="${subCnt + 1}"></c:set>
						<tr class="sub_comment_${c_list.p_vc_seq}" style="display: none;">
							<td style="background-color: #f7f7f7; padding: 10px 25px; text-align: left">
								<div>
									<span class="media_txt04"><img src="/resource/images/sub/icon_reply.png" style="padding-right: 10px" /> ${c_list.dept_name1} ${c_list.dept_name2 } ${c_list.name}</span> 
									<span class="media_txt03" style="padding-left: 10px">${cha:todate(c_list.c_reg_date, '-', '2')}</span>
									<c:if test="${c_list.reg_empno ==  sessionScope.SESS_EMPNO}">
										<span class="media_txt03" style="float: right;margin-right: 1px;cursor: pointer;"><img src="/resource/images/btn/del.png" onclick="javascript:funCommentDel(this, '${cha:seqEncode(c_list.vc_seq)}', '${pCnt}', 'N')" /></span>
									</c:if> 
								</div>  
								<c:if test="${c_list.reg_empno ==  sessionScope.SESS_EMPNO}">
									<div style="clear: both"></div>
								</c:if> 
								<div>
									<div class="media_txt05" style="padding-left: 25px"> 
										<pre>${c_list.comment_desc }</pre>
									</div>
								</div>
								<div style="margin-top: 20px; float: right">
									<img name="${c_list.my_like_cnt == 0 ? '11' : '12'}" src="/resource/images/sub/icon_kube${c_list.my_like_cnt == 0 ? '11' : '12'}.png" style="cursor: pointer;" onclick="javascript:funMyAct(this, '${cha:seqEncode(c_list.vc_seq)}');" /> <font><fmt:formatNumber value="${c_list.c_like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></font>&nbsp;&nbsp;&nbsp;&nbsp;
				                    <img name="${c_list.my_unlike_cnt == 0 ? '13' : '14'}" src="/resource/images/sub/icon_kube${c_list.my_unlike_cnt == 0 ? '13' : '14'}.png" style="cursor: pointer;" onclick="javascript:funMyAct(this, '${cha:seqEncode(c_list.vc_seq)}');" /> <font><fmt:formatNumber value="${c_list.c_unlike_cnt}" pattern="#,###,###,###"></fmt:formatNumber></font>&nbsp;&nbsp;&nbsp;&nbsp;
									<a class="txt_box" style="cursor: pointer;" onclick="javascript:funReportShow('2', '${cha:seqEncode(c_list.vc_seq)}');">신고하기</a>
								</div>
								
								<c:if test="${subCnt == tmpSubCnt}">
									<div style="clear: both"></div>
		 
									<div style="border-top: 1px solid #e7e7e7; margin-top: 15px; padding-top: 15px">
										<img src="/resource/images/sub/icon_reply.png" style="padding-right: 10px" />
										<textarea class="textarea-style" rows="3" name="comment_desc" style="width: 87%"></textarea>
										<input type="button" name="srchDescription" class="btn_down" onclick="javascript:funCommentReg(this, '${pCnt}')" value="등록" style="width: 60px; height: 55px; background-color: #0b4894">
										<input type="hidden" name="p_vc" value="${cha:seqEncode(c_list.p_vc_seq) }" />
									</div>
								</c:if>
							</td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>
</c:if>