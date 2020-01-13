<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/kube_topMenu.jsp" />
<c:import url="/resource/common/include/kube_leftMenu.jsp" />
<div id="contents">
	<c:forEach var="categoryCnt" items="${categoryCnt }">
		<c:set var="categoryCntSum" value="${categoryCntSum + categoryCnt.cnt }"></c:set>
	</c:forEach>
	                        
    <div class="search_result" style="margin:10px 0 25px 0">'${paging.srh_keyword}' <span style="color:#6a6a6a">검색결과</span> (총 <fmt:formatNumber value="${totalCnt['totCnt'] + categoryCntSum}" pattern="#,###,###,###" />건)</div>
    
    <c:set var="videoCategory1" value="false"></c:set>
	<c:set var="videoCategory2" value="false"></c:set>
	<c:set var="videoCategory3" value="false"></c:set>
	<c:set var="videoCategory4" value="false"></c:set>
	<c:set var="videoCategory4DeptName" value=""></c:set>
	<c:forEach var="videoList" items="${videoList }" varStatus="videoListStatus">
		<c:if test="${videoList.order_seq == 1 && !videoCategory1}">
			<c:set var="videoCategory1" value="true"></c:set>
			<c:set var="videoCategoryLink1" value="hits"></c:set>
		</c:if>
		<c:if test="${videoList.order_seq == 2 && !videoCategory2}">
			<c:set var="videoCategory2" value="true"></c:set>
			<c:set var="videoCategoryLink2" value="top"></c:set>
		</c:if>
		<c:if test="${videoList.order_seq == 4 && !videoCategory4}">
			<c:set var="videoCategory4" value="true"></c:set>
		<c:set var="videoCategoryLink4" value="${videoList.channel}/${cha:seqEncode(videoList.code_seq1)}/${cha:seqEncode(videoList.code_seq2)}"></c:set>
		<c:set var="videoCategory4DeptName" value="${videoList.dept_name1 }"></c:set>
		</c:if>
	</c:forEach>
	
	<c:if test="${videoCategory1 }"> 
		<div class="m_title_02" style="margin:10px 0 10px 0;display:inline-block;width:94%;">인기동영상 : <fmt:formatNumber value="${totalCnt['week_cnt']}" pattern="#,###,###,###" />건</div>
        <div style="margin-top:30px;margin-bottom:10px;display: inline-block;"><a href="javascript:;" onclick="javascript:funFrmPagingSubmit2('/kube/channel/${videoCategoryLink1 }')"><img src="/resource/images/sub/btn_more.png" /></a></div> 
	</c:if>
        
    <div class="media-box" style="${videoCategory1 ? '' : 'display:none;'}">
    	<c:set var="tmpFirstChk" value="true"></c:set>                                                 
    	<c:forEach var="videoList" items="${videoList }" varStatus="videoListStatus">
    		<c:if test="${videoList.order_seq == '1'}">
    			<c:if test="${tmpFirstChk}">
	   	   	   		<c:set var="clearStyle" value="clear:both"></c:set>
	   	   	    </c:if>
		        <div class="media-box01 fl_left" style="${clearStyle};${videoListStatus.index % 5 != 4 ? 'margin-right:16px;' : ''}">
		            <div>
		                <div class="media-time">${cha:secToHour(videoList.duration)}</div>
		                <img src="${web_url.concat(videoList.thumb_log_path)}" class="img_pointer" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');" style="width:253px; height: 142px;"/>
		            </div>
		            <div class="mbox01">
		            	<span class="media_txt01" style="width: 220px; overflow: hidden; display: inline-block; white-space: nowrap; -ms-text-overflow: ellipsis;">${videoList.title}</span><br>
		                <span class="media_txt02 fl_left">${videoList.code_desc }</span>
		                <span class="media_txt03 fl_right">
		                    <img src="/resource/kube_images/icon_12.png"> <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###" />
		                    <img src="/resource/kube_images/icon_13.png" style="margin-left:15px;"> <fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###" />
		                    <img src="/resource/kube_images/icon_07.png" style="margin-left:15px;"> <fmt:formatNumber value="${videoList.comment_cnt}" pattern="#,###,###,###"/>
		                </span>
		            </div>                                
		        </div>
		        <c:set var="tmpFirstChk" value="false"></c:set>
			    <c:set var="clearStyle" value=""></c:set>
			</c:if>
		</c:forEach>
    </div>
    <%-- 
    <c:set var="titleDivStyle" value="margin:40px 0 10px 0;"></c:set>
    <c:if test="${!videoCategory1 }">
		<c:set var="titleDivStyle" value="margin:10px 0 10px 0;"></c:set>
	</c:if>
    <c:if test="${videoCategory2 }"> 
		<div class="m_title_02" style="${titleDivStyle};display:inline-block;width:94%;">TOP 100 : <fmt:formatNumber value="${totalCnt['top_cnt']}" pattern="#,###,###,###" />건</div>
        <div style="margin-top:30px;margin-bottom:10px;display: inline-block;"><a href="javascript:;" onclick="javascript:funFrmPagingSubmit2('/kube/channel/${videoCategoryLink2 }')"><img src="/resource/images/sub/btn_more.png" /></a></div> 
	</c:if>
	
	<div class="media-box" style="${videoCategory2 ? '' : 'display:none;'}">
    	<c:set var="tmpFirstChk" value="true"></c:set>                                                 
    	<c:forEach var="videoList" items="${videoList }" varStatus="videoListStatus">
    		<c:if test="${videoList.order_seq == '2'}">
    			<c:if test="${tmpFirstChk}">
	   	   	   		<c:set var="clearStyle" value="clear:both"></c:set>
	   	   	    </c:if>
		        <div class="media-box01 fl_left" style="${clearStyle};${videoListStatus.index % 5 != 4 ? 'margin-right:16px;' : ''}">
		            <div>
		                <div class="media-time">${cha:secToHour(videoList.duration)}</div>
		                <img src="${web_url.concat(videoList.thumb_log_path)}" class="img_pointer" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');" style="width:253px; height: 142px;"/>
		            </div>
		            <div class="mbox01">
		                <span class="media_txt01" style="width: 220px; overflow: hidden; display: inline-block; white-space: nowrap; -ms-text-overflow: ellipsis;">${videoList.title}</span><br>
		                <span class="media_txt02 fl_left">${videoList.code_desc }</span>
		                <span class="media_txt03 fl_right">
		                    <img src="/resource/kube_images/icon_12.png"> <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###" />
		                    <img src="/resource/kube_images/icon_13.png" style="margin-left:15px;"> <fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###" />
		                </span>
		            </div>           
		        </div>
		        <c:set var="tmpFirstChk" value="false"></c:set>
			    <c:set var="clearStyle" value=""></c:set>
			</c:if>
		</c:forEach>
    </div>
    
    <c:set var="titleDivStyle" value="margin:40px 0 10px 0;"></c:set>
	<c:if test="${!videoCategory1 && !videoCategory2 }">
		<c:set var="titleDivStyle" value="margin:10px 0 10px 0;"></c:set>
	</c:if>
     --%>

	<c:set var="titleDivStyle" value="margin:40px 0 10px 0;"></c:set>
	<c:if test="${!videoCategory1}">
		<c:set var="titleDivStyle" value="margin:10px 0 10px 0;"></c:set>
	</c:if>
	
    <c:set var="chkCnt" value="true"></c:set>
    <c:set var="tmpP_code" value=""></c:set>
	<c:set var="tmpP_codeCnt" value="0"></c:set>
	<c:forEach var="videoList" items="${videoList }" varStatus="videoListStatus">
		<c:if test="${videoList.order_seq == '3'}">
			<c:set var="videoCategory3" value="true"></c:set>
			<c:if test="${tmpP_code != videoList.code_seq1}">
				<c:if test="${tmpP_code != ''}">
					</div>
				</c:if>
				
				<div class="m_title_02" style="${titleDivStyle};display:inline-block;width:94%;">${videoList.p_code_desc } : <fmt:formatNumber value="${categoryCnt[tmpP_codeCnt].cnt}" pattern="#,###,###,###"/>건</div>
				<div style="margin-top:30px;margin-bottom:10px;display: inline-block;"><a href="javascript:;" onclick="javascript:funFrmPagingSubmit2('/kube/channel/${videoList.channel}/${cha:seqEncode(videoList.code_seq1)}/${cha:seqEncode('999999')}');"><img src="/resource/images/sub/btn_more.png" /></a></div>
             	<c:set var="tmpP_codeCnt" value="${tmpP_codeCnt + 1}"></c:set> 
            	<c:set var="clearStyle" value=""></c:set>
            	<c:set var="chkCnt" value="false"></c:set>
    		
    			<div class="media-box">
    		</c:if>                                                 
        
	        <c:if test="${chkCnt}">
				<c:set var="clearStyle" value="clear:both"></c:set>
			</c:if>
			
	        <div class="media-box01 fl_left" style="${clearStyle};${videoListStatus.index % 5 != 4 ? 'margin-right:16px;' : ''}">
	            <div>
	                <div class="media-time">${cha:secToHour(videoList.duration)}</div>
	                <img src="${web_url.concat(videoList.thumb_log_path)}" class="img_pointer" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');" style="width:253px; height: 142px;"/>
	            </div>
	            <div class="mbox01">
	                <span class="media_txt01" style="width: 220px; overflow: hidden; display: inline-block; white-space: nowrap; -ms-text-overflow: ellipsis;">${videoList.title}</span><br>
	                <span class="media_txt02 fl_left">${videoList.code_desc }</span>
	                <span class="media_txt03 fl_right">
	                    <img src="/resource/kube_images/icon_12.png"> <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###" />
	                    <img src="/resource/kube_images/icon_13.png" style="margin-left:15px;"> <fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###" />
	                </span>
	            </div>                                
	        </div>
	        <c:set var="chkCnt" value="false"></c:set>
			<c:set var="tmpP_code" value="${videoList.code_seq1}"></c:set>
		</c:if>
		
		<c:if test="${videoListStatus.last }">
			</div>
		</c:if>
	</c:forEach>

    <%-- 
    <c:set var="titleDivStyle" value="margin:40px 0 10px 0;"></c:set>
	<c:if test="${!videoCategory1 && !videoCategory2 && !videoCategory3}">
		<c:set var="titleDivStyle" value="margin:10px 0 10px 0;"></c:set>
	</c:if>
	 --%>
	 
    <c:set var="titleDivStyle" value="margin:40px 0 10px 0;"></c:set>
	<c:if test="${!videoCategory1 && !videoCategory3}">
		<c:set var="titleDivStyle" value="margin:10px 0 10px 0;"></c:set>
	</c:if>
	
	<c:if test="${videoCategory4 }"> 
		<div class="m_title_02" style="${titleDivStyle};display:inline-block;width:94%;">${videoCategory4DeptName } 영상 : <fmt:formatNumber value="${totalCnt['saupso_cnt']}" pattern="#,###,###,###" />건</div>
        <div style="margin-top:30px;margin-bottom:10px;display: inline-block;"><a href="javascript:;" onclick="javascript:funFrmPagingSubmit2('/kube/channel/${videoCategoryLink4 }')"><img src="/resource/images/sub/btn_more.png" /></a></div> 
	</c:if>
	
	<div class="media-box" style="${videoCategory4 ? '' : 'display:none;'}">
    	<c:set var="tmpFirstChk" value="true"></c:set>                                                 
    	<c:forEach var="videoList" items="${videoList }" varStatus="videoListStatus">
    		<c:if test="${videoList.order_seq == '4'}">
    			<c:if test="${tmpFirstChk}">
	   	   	   		<c:set var="clearStyle" value="clear:both"></c:set>
	   	   	    </c:if>
		        <div class="media-box01 fl_left" style="${clearStyle};${videoListStatus.index % 5 != 4 ? 'margin-right:16px;' : ''}">
		            <div>
		                <div class="media-time">${cha:secToHour(videoList.duration)}</div>
		                <img src="${web_url.concat(videoList.thumb_log_path)}" class="img_pointer" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');" style="width:253px; height: 142px;"/>
		            </div>
		            <div class="mbox01">
		                <span class="media_txt01" style="width: 220px; overflow: hidden; display: inline-block; white-space: nowrap; -ms-text-overflow: ellipsis;">${videoList.title}</span><br>
		                <span class="media_txt02 fl_left">${videoList.code_desc }</span>
		                <span class="media_txt03 fl_right">
		                    <img src="/resource/kube_images/icon_12.png"> <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###" />
		                    <img src="/resource/kube_images/icon_13.png" style="margin-left:15px;"> <fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###" />
		                </span>
		            </div>           
		        </div>
		        <c:set var="tmpFirstChk" value="false"></c:set>
			    <c:set var="clearStyle" value=""></c:set>
			</c:if>
		</c:forEach>
    </div>
</div>
<form id="frm" name="frm" method="post">
<input type="hidden" id="p_code_seq" name="p_code_seq" /> 
<input type="hidden" id="code_seq" name="code_seq" />
<input type="hidden" id="srh_keyword" name="srh_keyword" value="${paging.srh_keyword_top }"/>
<input type="hidden" id="srh_keyword_top" name="srh_keyword_top" value="${paging.srh_keyword_top }"/>
</form>
<script type="text/javascript">
$(document).ready(function() {
});

function funVideoDetail(url, c1, c2){
	$('#p_code_seq').val(c1);
	$('#code_seq').val(c2);
	funGoPageDetail(url);
}
</script>
<c:import url="/resource/common/include/kube_bottom.jsp" />