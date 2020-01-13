<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/kube_topMenu.jsp" />
<c:import url="/resource/common/include/kube_leftMenu.jsp" />

<div id="contents">
                   
	<form id="frm" name="frm" method="post">
	<input type="hidden" id="code_seq" name="code_seq" value="${code_seq }">
	<input type="hidden" id="p_code_seq" name="p_code_seq" value="${p_code_seq }">
	<input type="hidden" id="srh_keyword" name="srh_keyword" value="${paging.srh_keyword}" />
	<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">

	<div>
	    <div class="m_title_01" style="margin:10px 0 30px 0;display: inline-block;">${categoryInfo.p_code_desc}<font style="font-size: 17px;vertical-align: top;">&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;</font>
	    	<c:if test="${code_seq == 999999}">전체</c:if>
	    	<c:if test="${code_seq != 999999}">
	    		${categoryInfo.code_desc}
	    		<c:if test="${code_seq == 12}"><font style="font-size: 17px;vertical-align: top;">&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;</font>${sessionScope.SESS_USER_INFO['first_dept_name'] }<font style="font-size: 17px;vertical-align: top;">&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;</font>${sessionScope.SESS_USER_INFO['second_dept_name'] }
	    		</c:if>
	    	</c:if>
	    </div>
	    <c:if test="${channel == 'elearn'}">
			<div style="color: #126954; font-size: 14px; margin-top: 5px; margin-left: 15px; display: inline-block; position: absolute;">
			<b>이제 e-러닝 콘텐츠를 KEPCO YouTube로 만나세요!<br />
			더욱 다양한 직무콘텐츠는 <font style="color: #0000ED;">사외망 직무 e-러닝사이트(KEMPUS)</font>에서 언제나 학습 가능합니다.</b>&nbsp;&nbsp;※ 콘텐츠의 사외 유출, 무단 도용, 복제 금지
			</div>
		</c:if>
    </div>
    
    <c:set var="chkCnt" value="true"></c:set>
    <c:forEach var="videoList" items="${videoList}" varStatus="videoStatus">
		<c:if test="${videoStatus.first}">
			<div class="media-box">
		</c:if>
		<c:if test="${!videoStatus.first && videoStatus.index % 5 == 0}">
			</div>              
          
          	<c:set var="clearStyle" value=""></c:set>
           	<c:set var="chkCnt" value="true"></c:set> 

          	<div class="media-box" style="margin-top:40px;">
          	
		</c:if>
		
		<c:if test="${chkCnt}">
			<c:set var="clearStyle" value="clear:both"></c:set> 
		</c:if>
               <div class="media-box01 fl_left" style="${clearStyle};${videoStatus.index % 5 != 4 ? 'margin-right:16px;' : ''}">
               		<div>
		                <div class="media-time">${cha:secToHour(videoList.duration)}</div>
		                <img src="${web_url.concat(videoList.thumb_log_path)}" onclick="javascript:funDetail('${cha:seqEncode(videoList.vi_seq)}');" class="img_pointer" style="width:253px; height: 142px;" />
		            </div>	
		            <div class="mbox01">
		                <div class="fl_left" style="width:160px;">
		                	<span class="media_txt01" style="width: 220px; overflow: hidden; display: inline-block; white-space: nowrap; -ms-text-overflow: ellipsis;">${videoList.title}</span><br>
		                    <%-- <span class="media_txt02">${videoList.p_code_desc }</span><br> --%> 
		                    <span class="media_txt03">
		                        <img src="/resource/kube_images/icon_12.png"> <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###" />
		                        <img src="/resource/kube_images/icon_13.png" style="margin-left:15px;"> <fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###" />
		                        <img src="/resource/kube_images/icon_07.png" style="margin-left:15px;"> <fmt:formatNumber value="${videoList.comment_cnt}" pattern="#,###,###,###"/>
		                    </span>
		                </div>                                                
		            </div>    
		            
               </div>
		<c:if test="${videoStatus.last}"> 
			</div>
			
		</c:if>           
		<c:set var="chkCnt" value="false"></c:set>
		<c:set var="clearStyle" value=""></c:set>
      </c:forEach>
      <c:if test="${fn:length(videoList) == 0}">
  		<div class="media-box no-result-div">
  			조회 결과가 없습니다.
  		</div>
      </c:if>
	  <c:if test="${fn:length(videoList) != 0}">	                  
		<c:import url="/resource/common/include/kube_paging.jsp" />
	  </c:if>
</div>
<script type="text/javascript">
$(document).ready(function() {
});

function funDetail(v){
	funGoPageDetail('/kube/watch/' + v);
}
</script>
<c:import url="/resource/common/include/kube_bottom.jsp" />