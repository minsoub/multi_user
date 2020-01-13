<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<div class="scrollbar-box" style="height:741px;">
    <div class="medialist-box">
		<c:forEach var="rightList" items="${rightList}" varStatus="status">
			<c:if test="${status.first }">
				<div class="media-box03">
			</c:if>
			<c:if test="${!status.first }">
				<div class="media-box03" style="margin-top:20px;">
			</c:if>
			
					<div class="fl_left" style="width:140px;">
		                <div class="media-time" style="margin-top:58px; margin-left:75px">
		                    ${cha:secToHour(rightList.duration)}
		                </div>
		                <a href="javascript:;" onclick="javascript:funRightVideoDetail2('${status.index }', '/kube/watch/${cha:seqEncode(rightList.vi_seq) }', '${rightList.code_seq1 }', '${rightList.code_seq2 }');"><img src="${web_url.concat(rightList.thumb_log_path)}" style="width:135px;height:76px;" /></a>
		            </div>
		            <div class="fl_right" style="width:140px;">
		            	<span class="media_txt02" style="width: 140px; overflow: hidden; display: inline-block; white-space: nowrap; -ms-text-overflow: ellipsis;">${rightList.title}</span><br>
		                <span class="media_txt01">${rightList.writer }</span><br>
		                <span class="media_txt03">
		                    <img src="/resource/kube_images/icon_12.png"> <fmt:formatNumber value="${rightList.visit_cnt}" pattern="#,###,###,###" />
		                    <img src="/resource/kube_images/icon_13.png" style="margin-left:15px;"> <fmt:formatNumber value="${rightList.like_cnt}" pattern="#,###,###,###" />
		                    <img src="/resource/kube_images/icon_07.png" style="margin-left:15px;"> <fmt:formatNumber value="${rightList.comment_cnt}" pattern="#,###,###,###"/>
		                </span>
		            </div>
			    <c:if test="${nextVi_seq_hash == cha:seqEncode(rightList.vi_seq) }">
			    	<c:set var="nextCodeSeq1">${rightList.code_seq1 }</c:set>
			    	<c:set var="nextCodeSeq2">${rightList.code_seq2 }</c:set>
			    </c:if>
		    </div>
		</c:forEach>
	</div>
</div>
<input type="hidden" id="nextVi_seq_hash" name="nextVi_seq_hash" value="${nextVi_seq_hash }" />
<input type="hidden" id="nextNumChk" name="nextNumChk" value="${nextNumChk }" />
<input type="hidden" id="nextP_code_seq" name="nextP_code_seq" value="${nextCodeSeq1 }" />
<input type="hidden" id="nextCode_seq" name="nextCode_seq" value="${nextCodeSeq2 }" />