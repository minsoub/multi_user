<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />

<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="9"></c:param>
				<c:param name="left_depth_2" value="${p_code_seq + 1}"></c:param>
			</c:import>
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<form id="frm" name="frm" method="post">
		<input type="hidden" id="code_seq" name="code_seq" value="${code_seq }">
		<input type="hidden" id="p_code_seq" name="p_code_seq" value="${p_code_seq }">
		<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
		   
			<div class="contents-con-framebox">
				<div class="nav-box">
	                <div class="nav-img"><img alt="" src="/resource/images/sub/sub9_tit_img.png"></div>
					<div class="nav-list">
						<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;KUBE&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">${categoryInfo.p_code_desc}</b>
					</div>
					<c:if test="${code_seq == 999999}">
						<div class="nav-title">전체</div>
					</c:if>
					<c:if test="${code_seq != 999999}">
						<div class="nav-title">${categoryInfo.code_desc}</div>
					</c:if>
				</div>
	            
	            <div class="searchArea_con_box">
					<fieldset>
	                    <div class="search-box"  style="float:right">		
	                        <div class="form-group">
	                            <legend>검색영역</legend>	 
	                            <input type="text" title="검색바" id="srh_keyword" name="srh_keyword" value="${paging.srh_keyword}" placeholder="제목, 작성자 조회" style="width: 570px; height:34px; padding-left: 20px;font-size:14px;color:#666; border:1px solid #bea2d9" onkeydown="javascript:if(event.keyCode == 13){funFrmPagingSubmit2(location.href);}">
	                            <img src="/resource/images/sub/btn_search.png" style="cursor: pointer;" onclick="javascript:funFrmPagingSubmit2(location.href);"/> 
	                        </div>
	                    </div>
					</fieldset>
				 </div>
	            
	            <div style="margin-top:10px;margin-bottom:10px; float:right">
	            	<p class="inputDesign">
					<select name="selOrder" style="width:150px" onchange="javascript:funFrmPagingSubmit2(document.location.href);">
						<option value="reg_date" ${paging.selOrder == 'reg_date' ? 'selected' : '' }>최신순</option>
						<option value="popular_cnt" ${paging.selOrder == 'popular_cnt' ? 'selected' : '' }>인기순</option>
						<option value="visit_cnt" ${paging.selOrder == 'visit_cnt' ? 'selected' : '' }>조회순</option>
						<option value="like_cnt" ${paging.selOrder == 'like_cnt' ? 'selected' : '' }>좋아요순</option>
					</select>
	            </div>
				
				<c:forEach var="videoList" items="${videoList}" varStatus="videoStatus">
					<c:if test="${videoStatus.first}">
						<div class="media-box" style="clear:both">
					</c:if>
					<c:if test="${!videoStatus.first && videoStatus.index % 4 == 0}">
						</div>
						
						<div style="clear:both"></div> 
	            
	            		<div class="media-box" style="margin-top:95px;">
					</c:if>
		                <div class="media-box01" style="float:left; ${videoStatus.index % 4 != 0 ? 'margin-left:13px' : ''}">
		                    <div style="float:left">
		                        <div class="media-time" style="margin-top:80px; margin-left:134px">
		                            ${cha:secToHour(videoList.duration)}
		                        </div> 
		                        <img src="${web_url.concat(videoList.thumb_log_path)}" style="cursor: pointer;" class="imgMaxWidth180" onclick="javascript:funDetail('${cha:seqEncode(videoList.vi_seq)}');" />
		                    </div>                
		                    <span class="media_txt01">${cha:splitStr(videoList.title, '20')}</span><br>
		                    <!-- <span class="media_txt02">한전 NEWS</span><br> -->
		                    <span class="media_txt03"><img src="/resource/images/icon_12.png"> <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp; <img src="/resource/images/icon_13.png"> <fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span>
		                </div>
					<c:if test="${videoStatus.last}">
						</div>
						
						<div style="clear:both;"></div>
					</c:if> 
	            </c:forEach>
	            <c:if test="${fn:length(videoList) == 0}">
	            	<div class="none_srh_result" style="clear:both">
	            		조회 결과가 없습니다.
	            	</div>
	            	
	            	<div style="clear:both"></div>
	            </c:if>
	                    
	            <div style="margin-bottom: 250px;margin-top: -170px;"></div>  
				<c:import url="/resource/common/include/kube_paging.jsp" />
				</div> 
			</form>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('8', '0', '0'); //menu script
	
	if($.trim($('#srh_keyword').val()) == ''){
		$('#srh_keyword').focus();
	}
});

function funDetail(v){
	funGoPageDetail('/kube/watch/' + v);
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />