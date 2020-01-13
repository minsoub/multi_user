<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:forEach var="rightList" items="${rightList}" varStatus="status">
    <div class="media-box01" style="height:180px;cursor: pointer;">
        <div>
            <div class="media-time" style="margin-top:82px; margin-left:114px">
                ${cha:secToHour(rightList.duration)}
            </div>
            <a href="javascript:;" onclick="javascript:funRightVideoDetail2('${status.index }', '/kube/watch/${cha:seqEncode(rightList.vi_seq) }', '${rightList.code_seq1 }', '${rightList.code_seq2 }');"><img src="${web_url.concat(rightList.thumb_log_path)}" class="imgMaxWidth160" /></a>
        </div>                
        <span class="media_txt01" style="line-height: 30px;">${cha:splitStr(rightList.title, '20')}</span><br>
        <span class="media_txt02" style="line-height: 20px;">${rightList.writer }</span><br>
        <span class="media_txt03"><img src="/resource/images/icon_12.png"> <fmt:formatNumber value="${rightList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp; <img src="/resource/images/icon_13.png"> <fmt:formatNumber value="${rightList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span>
    </div>
    <c:if test="${nextVi_seq_hash == cha:seqEncode(rightList.vi_seq) }">
    	<c:set var="nextCodeSeq1">${rightList.code_seq1 }</c:set>
    	<c:set var="nextCodeSeq2">${rightList.code_seq2 }</c:set>
    </c:if>
</c:forEach>
<input type="hidden" id="nextVi_seq_hash" name="nextVi_seq_hash" value="${nextVi_seq_hash }" />
<input type="hidden" id="nextNumChk" name="nextNumChk" value="${nextNumChk }" />
<input type="hidden" id="nextP_code_seq" name="nextP_code_seq" value="${nextCodeSeq1 }" />
<input type="hidden" id="nextCode_seq" name="nextCode_seq" value="${nextCodeSeq2 }" />