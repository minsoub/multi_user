<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/kube_topMenu.jsp" />
<c:import url="/resource/common/include/kube_leftMenu.jsp" />
<div id="contents">
                      
	<c:if test="${fn:length(mainInfos) > 0}">
		<!-- 주요동영상 3단 -->
		<div class="m_media-box">
		    <div class="fl_left">
		        <div class="media-text" style="margin-top:420px;">
		           <p>${mainInfos[0].caption_min_title}</p><br>
	               <p style="font-size:30px">${mainInfos[0].caption_title}</p>
	           </div>
	           <a href="${mainInfos[0].link_url }"><img src="${web_url.concat(mainInfos[0].thumb_log_path)}" style="width:889px;height:500px;"/></a>
		   </div>
		   <div class="fl_left">
		       <div class="media-text" style="margin-top:210px;">
		           ${mainInfos[1].caption_title}
		       </div>
		       <a href="${mainInfos[1].link_url }"><img src="${web_url.concat(mainInfos[1].thumb_log_path)}" style="width:445px;height:250px;"/></a>
		   </div>
		   <div class="fl_left">
		       <div class="media-text" style="margin-top:210px;">
					${mainInfos[2].caption_title}
		        </div>
		        <a href="${mainInfos[2].link_url }"><img src="${web_url.concat(mainInfos[2].thumb_log_path)}" style="width:445px;height:250px;"/></a>
		    </div>                
		</div>                       
	</c:if>
	
	<c:set var="homeCategory1" value="false"></c:set>
	<c:set var="homeCategory2" value="false"></c:set>
	<c:set var="homeCategory3" value="false"></c:set>
	<c:set var="homeCategory4" value="false"></c:set>
	<c:set var="homeCategory4DeptName" value=""></c:set>
	<c:forEach var="homeList" items="${homeList }" varStatus="homeListStatus">
		<c:if test="${homeList.order_seq == 1 && !homeCategory1}">
			<c:set var="homeCategory1" value="true"></c:set>
			<c:set var="homeCategoryLink1" value="hits"></c:set>
		</c:if>
		<c:if test="${homeList.order_seq == 2 && !homeCategory2}">
			<c:set var="homeCategory2" value="true"></c:set>
			<c:set var="homeCategoryLink2" value="recently"></c:set>
		</c:if>
		<c:if test="${homeList.order_seq == 3 && !homeCategory3}">
			<c:set var="homeCategory3" value="true"></c:set>
			<c:set var="homeCategoryLink3" value="top"></c:set>
		</c:if>
		<c:if test="${homeList.order_seq == 4 && !homeCategory4}">
			<c:set var="homeCategory4" value="true"></c:set>
			<c:set var="homeCategoryLink4" value="${homeList.channel}/${cha:seqEncode(homeList.code_seq1)}/${cha:seqEncode(homeList.code_seq2)}"></c:set>
			<c:set var="homeCategory4DeptName" value="${homeList.dept_name1 }"></c:set>
		</c:if>
	</c:forEach>

	<c:set var="contentsCnt" value="0"></c:set>
	<!-- 최신동영상 -->
	<div class="media-box" style="${homeCategory2 ? '' : 'display:none;'}">
		<c:if test="${homeCategory2 }">
		    <div class="title_01 fl_left" style="margin:40px 0 10px 0">
		       <img src="/resource/kube_images/tit_icon02.png" style="margin-right:10px;margin-bottom:7px"/>최신 동영상
		   </div>
		   <div class="fl_right" style="margin-top:40px;">
		       <img src="/resource/kube_images/btn_more.png" onclick="location.href='/kube/channel/${homeCategoryLink2 }'" class="img_pointer" />	   		
		   </div>
	   </c:if>
	   <c:set var="tmpHomeListFirstChk" value="true"></c:set>
		<c:forEach var="homeList" items="${homeList }" varStatus="homeListStatus">
	   	   <c:if test="${homeList.order_seq == 2 }">
	   	   	   <c:if test="${tmpHomeListFirstChk}">
	   	   	   		<c:set var="clearStyle" value="clear:both"></c:set>
	   	   	   </c:if>
			   <div class="media-box01 fl_left" style="${clearStyle};${contentsCnt % 5 != 4 ? 'margin-right:16px;' : ''};${contentsCnt > 4 ? 'margin-top:18px;' : ''}">
			       <div>
			           <div class="media-time">${cha:secToHour(homeList.duration)}</div>
			           <img src="${storage_web_url.concat(homeList.thumb_log_path)}" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(homeList.vi_seq) }', '${homeList.code_seq1 }', '${homeList.code_seq2 }');" class="img_pointer" style="width:253px; height: 142px;"/>
			       </div>
			       <div class="mbox01" style="padding: 15px 15px 0px 15px">
			           <span class="media_txt01" style="width: 220px; overflow: hidden; display: inline-block; white-space: nowrap; -ms-text-overflow: ellipsis;">${homeList.title}</span><br>
			           <span class="media_txt02">${homeList.code_desc }</span><br />
			           <span class="media_txt03">
			               <img src="/resource/kube_images/icon_12.png"> <fmt:formatNumber value="${homeList.visit_cnt}" pattern="#,###,###,###" />
			               <img src="/resource/kube_images/icon_13.png" style="margin-left:15px;"> <fmt:formatNumber value="${homeList.like_cnt}" pattern="#,###,###,###"/>
			               <img src="/resource/kube_images/icon_07.png" style="margin-left:15px;"> <fmt:formatNumber value="${homeList.comment_cnt}" pattern="#,###,###,###"/>
			           </span>
			       </div>                                
			   </div>
			   <c:set var="tmpHomeListFirstChk" value="false"></c:set>
			   <c:set var="clearStyle" value=""></c:set>
			   <c:set var="contentsCnt" value="${contentsCnt + 1 }"></c:set>
			</c:if>
	   </c:forEach>
	</div>
	
	
	<c:set var="contentsCnt" value="0"></c:set>
	<!-- 주간인기동영상 -->
	<div class="media-box" style="${homeCategory1 ? '' : 'display:none;'}">
		<c:if test="${homeCategory1 }">
		    <div class="title_01 fl_left" style="margin:40px 0 10px 0">
		       <img src="/resource/kube_images/tit_icon01.png" style="margin-right:10px;margin-bottom:7px"/>인기 동영상
		   </div>
		   <div class="fl_right" style="margin-top:40px;">
		       <img src="/resource/kube_images/btn_more.png" onclick="location.href='/kube/channel/${homeCategoryLink1 }'" class="img_pointer" />
		   </div>
	   </c:if>
	   <c:set var="tmpHomeListFirstChk" value="true"></c:set>
	   <c:forEach var="homeList" items="${homeList }" varStatus="homeListStatus">
	   	   <c:if test="${homeList.order_seq == 1 }">
	   	   	   <c:if test="${tmpHomeListFirstChk}">
	   	   	   		<c:set var="clearStyle" value="clear:both"></c:set>
	   	   	   </c:if>
			   <div class="media-box01 fl_left" style="${clearStyle};${contentsCnt % 5 != 4 ? 'margin-right:16px;' : ''};${contentsCnt > 4 ? 'margin-top:18px;' : ''}">
			       <div>
			           <div class="media-time">${cha:secToHour(homeList.duration)}</div>
			           <img src="${storage_web_url.concat(homeList.thumb_log_path)}" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(homeList.vi_seq) }', '${homeList.code_seq1 }', '${homeList.code_seq2 }');" class="img_pointer" style="width:253px; height: 142px;" />
			       </div>
			       <div class="mbox01" style="padding: 15px 15px 0px 15px">
			           <span class="media_txt01" style="width: 220px; overflow: hidden; display: inline-block; white-space: nowrap; -ms-text-overflow: ellipsis;">${homeList.title}</span><br>
			           <span class="media_txt02">${homeList.code_desc }</span><br />
			           <span class="media_txt03">
			               <img src="/resource/kube_images/icon_12.png"> <fmt:formatNumber value="${homeList.visit_cnt}" pattern="#,###,###,###" />
			               <img src="/resource/kube_images/icon_13.png" style="margin-left:15px;"> <fmt:formatNumber value="${homeList.like_cnt}" pattern="#,###,###,###"/>
			               <img src="/resource/kube_images/icon_07.png" style="margin-left:15px;"> <fmt:formatNumber value="${homeList.comment_cnt}" pattern="#,###,###,###"/>
			           </span>
			       </div>                                
			   </div>
			   <c:set var="tmpHomeListFirstChk" value="false"></c:set>
			   <c:set var="clearStyle" value=""></c:set>
			   <c:set var="contentsCnt" value="${contentsCnt + 1 }"></c:set>
			</c:if>
	   </c:forEach>
	</div>
	
	
	<!-- Top 100 -->
	<%-- 
	<div class="media-box" style="${homeCategory3 ? '' : 'display:none;'}">
		<c:if test="${homeCategory3 }">
		    <div class="title_01 fl_left" style="margin:40px 0 20px 0">
		       TOP 100
		   </div>
		   <div class="fl_right" style="margin-top:40px;">
		       <img src="/resource/kube_images/btn_more.png" onclick="location.href='/kube/channel/${homeCategoryLink3 }'" class="img_pointer" />
		   </div>
	   </c:if>
	   <c:set var="tmpHomeListFirstChk" value="true"></c:set>
		<c:forEach var="homeList" items="${homeList }" varStatus="homeListStatus">
	   	   <c:if test="${homeList.order_seq == 3 }">
	   	   	   <c:if test="${tmpHomeListFirstChk}">
	   	   	   		<c:set var="clearStyle" value="clear:both"></c:set>
	   	   	   </c:if>
			   <div class="media-box01 fl_left" style="${clearStyle};${homeListStatus.index % 5 != 4 ? 'margin-right:16px;' : ''}">
			       <div>
			           <div class="media-time">${cha:secToHour(homeList.duration)}</div>
			           <img src="${storage_web_url.concat(homeList.thumb_log_path)}" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(homeList.vi_seq) }', '${homeList.code_seq1 }', '${homeList.code_seq2 }');" class="img_pointer" style="width:253px; height: 142px;"/>
			       </div>
			       <div class="mbox01">
			           <span class="media_txt01">${cha:splitStr(homeList.title, '23') }</span><br>
			           <span class="media_txt02 fl_left">${homeList.code_desc }</span>
			           <span class="media_txt03 fl_right">
			               <img src="/resource/kube_images/icon_12.png"> <fmt:formatNumber value="${homeList.visit_cnt}" pattern="#,###,###,###" />
			               <img src="/resource/kube_images/icon_13.png" style="margin-left:15px;"> <fmt:formatNumber value="${homeList.like_cnt}" pattern="#,###,###,###"/>
			           </span>
			       </div>                                
			   </div>
			   <c:set var="tmpHomeListFirstChk" value="false"></c:set>
			   <c:set var="clearStyle" value=""></c:set>
			</c:if>
	   </c:forEach>
	</div>
	 --%>
	 
	<!-- 사업소별 동영상 -->
	<%-- 
	<div class="media-box" style="${homeCategory4 ? '' : 'display:none;'}">
		<c:if test="${homeCategory4 }">
		    <div class="title_01 fl_left" style="margin:40px 0 10px 0">
		       <img src="/resource/kube_images/tit_icon01.png" style="margin-right:10px;margin-bottom:7px"/> ${homeCategory4DeptName } 최신 동영상
		   </div>
		   <div class="fl_right" style="margin-top:40px;">
		       <img src="/resource/kube_images/btn_more.png" onclick="location.href='/kube/channel/${homeCategoryLink4 }'" class="img_pointer" />
		   </div>
	   </c:if>
	   <c:set var="tmpHomeListFirstChk" value="true"></c:set>
		<c:forEach var="homeList" items="${homeList }" varStatus="homeListStatus">
	   	   <c:if test="${homeList.order_seq == 4 }">
	   	   	   <c:if test="${tmpHomeListFirstChk}">
	   	   	   		<c:set var="clearStyle" value="clear:both"></c:set>
	   	   	   </c:if>
			   <div class="media-box01 fl_left" style="${clearStyle};${homeListStatus.index % 5 != 4 ? 'margin-right:16px;' : ''}">
			       <div>
			           <div class="media-time">${cha:secToHour(homeList.duration)}</div>
			           <img src="${storage_web_url.concat(homeList.thumb_log_path)}" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(homeList.vi_seq) }', '${homeList.code_seq1 }', '${homeList.code_seq2 }');" class="img_pointer" style="width:253px; height: 142px;"/>
			       </div>
			       <div class="mbox01">
			           <span class="media_txt01">${cha:splitStr(homeList.title, '23') }</span><br>
			           <span class="media_txt02 fl_left">${homeList.code_desc }</span>
			           <span class="media_txt03 fl_right">
			               <img src="/resource/kube_images/icon_12.png"> <fmt:formatNumber value="${homeList.visit_cnt}" pattern="#,###,###,###" />
			               <img src="/resource/kube_images/icon_13.png" style="margin-left:15px;"> <fmt:formatNumber value="${homeList.like_cnt}" pattern="#,###,###,###"/>
			           </span>
			       </div>                                
			   </div>
			   <c:set var="tmpHomeListFirstChk" value="false"></c:set>
			   <c:set var="clearStyle" value=""></c:set>
			</c:if>
	   </c:forEach>
	</div>
	 --%>
</div>
<form id="frm" name="frm" method="post">
<input type="hidden" id="p_code_seq" name="p_code_seq" /> 
<input type="hidden" id="code_seq" name="code_seq" />
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