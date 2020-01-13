<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/kube_topMenu.jsp" />
<c:import url="/resource/common/include/kube_leftMenu.jsp" />
<div id="contents">
                        
    <div class="m_title_01" style="margin:10px 0 30px 0">
    	<c:if test="${channel == 'top' }">
			TOP 100
		</c:if>
		<c:if test="${channel == 'weekly' }">
			인기 동영상
		</c:if>
		<c:if test="${channel == 'hits' }">
			조회수 인기 동영상
		</c:if>
		<c:if test="${channel == 'like' }">
			좋아요 인기 동영상
		</c:if>
		<c:if test="${channel == 'recently' }">
			최신 동영상
		</c:if>
		<c:if test="${channel == 'recommend' }">
			추천 동영상
		</c:if>
		<c:if test="${channel == 'dept' }">
			사업소별 영상
			
			<c:if test="${fn:length(firstDeptName) > 0}">
				<font style="font-size: 17px;vertical-align: top;">&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;</font>${firstDeptName }
				
				<c:if test="${fn:length(secondDeptName) > 0}">
					<font style="font-size: 17px;vertical-align: top;">&nbsp;&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;</font>${secondDeptName }
				</c:if>
			</c:if>
		</c:if>
	</div>
    
    
    <form id="frm" name="frm" method="post">
	<input type="hidden" id="p_code_seq" name="p_code_seq" /> 
	<input type="hidden" id="code_seq" name="code_seq" />
	<input type="hidden" id="srh_keyword" name="srh_keyword" />
	<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">

			<c:if test="${channel == 'dept' }">
				<div class="fl_right" style="margin-bottom: 15px;"> 
					<label for=""></label>
			        <select name="sel_f_dept_code" class="selectbox" style="width:150px;" onchange="javascript:funFrmPagingSubmit2(document.location.href);">
			        	<c:forEach var="dept_info" items="${firstDept }">
							<option value="${dept_info.dept_code }" ${paging.sel_f_dept_code == dept_info.dept_code ? 'selected' : '' }>${dept_info.dept_name }</option>
						</c:forEach>
					</select>
					<select name="sel_s_dept_code" class="selectbox" style="width:150px;margin-left: 15px;" onchange="javascript:funFrmPagingSubmit2(document.location.href);">
						<option value="none">--선택--</option>
						<c:forEach var="dept_info" items="${secondDept }">
							<option value="${dept_info.dept_code }" ${paging.sel_s_dept_code == dept_info.dept_code ? 'selected' : '' }>${dept_info.dept_name }</option>
						</c:forEach>
					</select>
			    </div>
		    </c:if>
		    
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
				                <img src="${web_url.concat(videoList.thumb_log_path)}" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');" class="img_pointer" style="width:253px; height: 142px;" />
				            </div>	
				            <div class="mbox01">
				            	<c:if test="${channel == 'top' }">
				                	<div class="top_num_blue fl_left" style="width:60px;">${(paging.pageNo - 1) *  paging.perPageCnt + videoStatus.count}</div>
				                </c:if>
				                <div class="fl_left">
				                    <span class="media_txt01" style="width: 220px; overflow: hidden; display: inline-block; white-space: nowrap; -ms-text-overflow: ellipsis;">${videoList.title}</span><br>
				                    <span class="media_txt02">${videoList.code_desc }</span><br>
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
	</form>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$('#srh_keyword').val($('#srh_keyword_top').val());
});

function funVideoDetail(url, c1, c2){
	$('#p_code_seq').val(c1);
	$('#code_seq').val(c2);
	$('#srh_keyword').val($('#srh_keyword_top').val());
	funGoPageDetail(url);
}
</script>
<c:import url="/resource/common/include/kube_bottom.jsp" />