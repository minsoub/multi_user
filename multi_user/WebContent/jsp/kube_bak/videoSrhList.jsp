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
			</c:import>
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
			<div class="contents-con-framebox">
				<div class="nav-box">
	                <div class="nav-img"><img alt="" src="/resource/images/sub/sub9_tit_img.png"></div>
					<div class="nav-list">
						<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;KUBE&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">전체 검색</b>
					</div>
					<div class="nav-title">전체 검색</div>
				</div>

			<form id="frm" name="frm" method="post">
			<input type="hidden" id="p_code_seq" name="p_code_seq" /> 
			<input type="hidden" id="code_seq" name="code_seq" />	            
	            <div class="searchArea_con_box">
					<fieldset>
	                    <div class="search-box"  style="float:right">
		                        <div class="form-group">
		                            <legend>검색영역</legend>	 
		                            <input type="text" title="검색바" id="srh_keyword" name="srh_keyword" value="${paging.srh_keyword}" placeholder="제목, 작성자 조회" style="width: 570px; height:34px; padding-left: 20px;font-size:14px;color:#666; border:1px solid #bea2d9" onkeydown="javascript:if(event.keyCode == 13){funSubmit(location.href);}">
		                            <img src="/resource/images/sub/btn_search.png" style="cursor: pointer;" onclick="javascript:funSubmit(location.href);"/>
		                        </div>
	                    </div>
					</fieldset>
				 </div>
	            
	            <div style="margin-top:10px;margin-bottom:10px; float:right">
	            	<%-- 
	            	<p class="inputDesign">
					<select name="selOrder" style="width:150px" onchange="javascript:funSubmit(document.location.href);">
						<option value="reg_date" ${paging.selOrder == 'reg_date' ? 'selected' : '' }>최신순</option>
						<option value="popular_cnt" ${paging.selOrder == 'popular_cnt' ? 'selected' : '' }>인기순</option>
						<option value="visit_cnt" ${paging.selOrder == 'visit_cnt' ? 'selected' : '' }>조회순</option>
						<option value="like_cnt" ${paging.selOrder == 'like_cnt' ? 'selected' : '' }>좋아요순</option>
					</select>
					 --%>
	            </div>
			</form>
				
				<c:set var="categoryCntSum" value="0"></c:set>
				<c:forEach var="categoryCnt" items="${categoryCnt }">
					<c:set var="categoryCntSum" value="${categoryCntSum + categoryCnt.cnt }"></c:set>
				</c:forEach>
				<div class="sub-nav-title-sm" style="margin-top:10px">"${paging.srh_keyword}"에 대한 검색 결과 : 총 <fmt:formatNumber value="${totalCnt['totCnt'] + categoryCntSum}" pattern="#,###,###,###"></fmt:formatNumber>건</div>
            
	            <c:set var="videoCategory1" value="false"></c:set>
				<c:set var="videoCategory2" value="false"></c:set>
				<c:set var="videoCategory3" value="false"></c:set>
				<c:set var="videoCategory4" value="false"></c:set>
				<c:set var="videoCategory4DeptName" value=""></c:set>
				<c:forEach var="videoList" items="${videoList }" varStatus="videoListStatus">
					<c:if test="${videoList.order_seq == 1 && !videoCategory1}">
						<c:set var="videoCategory1" value="true"></c:set>
						<c:set var="videoCategoryLink1" value="weekly"></c:set>
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
		            <div class="sub-nav-title1" style="width:690px; margin-top:30px;margin-bottom:10px; float:left">주간 인기동영상 : <fmt:formatNumber value="${totalCnt['week_cnt']}" pattern="#,###,###,###"></fmt:formatNumber>건</div>
		            <div style="margin-top:30px;margin-bottom:10px;"><a href="javascript:;" onclick="javascript:funFrmPagingSubmit2('/kube/channel/${videoCategoryLink1 }')"><img src="/resource/images/sub/btn_more.png" /></a></div> 
	            </c:if>
	            
	            <div class="media-box" style="clear:both">
	            	<c:set var="divStyle" value=""></c:set>
	            	<c:set var="chkCnt" value="false"></c:set>
	            	<c:forEach var="videoList" items="${videoList }" varStatus="videoListStatus">
	            		<c:if test="${videoList.order_seq == '1'}">
	            			<c:if test="${chkCnt}">
	            				<c:set var="divStyle" value="margin-left:13px;"></c:set>
	            			</c:if>
			                <div class="media-box01" style="float:left;${divStyle}">
			                    <div style="float:left">
			                        <div class="media-time" style="margin-top:80px; margin-left:134px">
			                            ${cha:secToHour(videoList.duration)}
			                        </div>
			                        <a href="javascript:;" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');"><img src="${web_url.concat(videoList.thumb_log_path)}" class="imgMaxWidth180" /></a>
			                    </div>                 
			                    <span class="media_txt01">${cha:splitStr(videoList.title,'20') }</span><br>
			                    <span class="media_txt02">${videoList.p_code_desc }</span><br>
			                    <span class="media_txt03"><img src="/resource/images/icon_12.png"> <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp; <img src="/resource/images/icon_13.png"> <fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span>
			                </div>
			                <c:set var="chkCnt" value="true"></c:set>
						</c:if>
	                </c:forEach>
				</div>
				
				<div style="clear:both"></div>

				<c:set var="titleDivStyle" value="margin-top:120px;"></c:set>
				<c:if test="${!videoCategory1 }">
					<c:set var="titleDivStyle" value="margin-top:30px;"></c:set>
				</c:if>
				<c:if test="${videoCategory2 }"> 
		            <div class="sub-nav-title1" style="width:690px; ${titleDivStyle} margin-bottom:10px; float:left">TOP 100 : <fmt:formatNumber value="${totalCnt['top_cnt']}" pattern="#,###,###,###"></fmt:formatNumber>건</div>
		            <div style="${titleDivStyle} margin-bottom:10px;"><a href="javascript:;" onclick="javascript:funFrmPagingSubmit2('/kube/channel/${videoCategoryLink2 }');"><img src="/resource/images/sub/btn_more.png" /></a></div> 
	            </c:if>
	             
	            <div class="media-box">
	            	<c:set var="divStyle" value=""></c:set>
	            	<c:set var="chkCnt" value="false"></c:set>
	            	<c:forEach var="videoList" items="${videoList }" varStatus="videoListStatus">
	            		<c:if test="${videoList.order_seq == '2'}">
	            			<c:if test="${chkCnt}">
	            				<c:set var="divStyle" value="margin-left:13px;"></c:set>
	            			</c:if>
			                <div class="media-box01" style="float:left;${divStyle}">
			                    <div style="float:left">
			                        <div class="media-time" style="margin-top:80px; margin-left:134px">
			                            ${cha:secToHour(videoList.duration)}
			                        </div>
			                        <a href="javascript:;" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');"><img src="${web_url.concat(videoList.thumb_log_path)}" class="imgMaxWidth180" /></a>
			                    </div>                
			                    <span class="media_txt01">${cha:splitStr(videoList.title, '20') }</span><br>
			                    <span class="media_txt02">${videoList.p_code_desc }</span><br>
			                    <span class="media_txt03"><img src="/resource/images/icon_12.png"> <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp; <img src="/resource/images/icon_13.png"> <fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span>
			                </div>
			                <c:set var="chkCnt" value="true"></c:set>
						</c:if>
	                </c:forEach>
				</div>
	            
	            <div style="clear:both"></div>
				
				<c:set var="titleDivStyle" value="margin-top:120px;"></c:set>
				<c:if test="${!videoCategory1 && !videoCategory2 }">
					<c:set var="titleDivStyle" value="margin-top:30px;"></c:set>
				</c:if>
				
				<c:set var="tmpP_code" value=""></c:set>
				<c:set var="tmpP_codeCnt" value="0"></c:set>
				<c:forEach var="videoList" items="${videoList }" varStatus="videoListStatus">
					<c:if test="${videoList.order_seq == '3'}">
						<c:set var="videoCategory3" value="true"></c:set>
						<c:if test="${tmpP_code != videoList.code_seq1}">
							<c:if test="${tmpP_code != ''}">
								</div>
								 
								<div style="clear:both"></div> 
							</c:if>
							
				            <div class="sub-nav-title1" style="width:690px; ${titleDivStyle} margin-bottom:10px; float:left">${videoList.p_code_desc } : <fmt:formatNumber value="${categoryCnt[tmpP_codeCnt].cnt}" pattern="#,###,###,###"></fmt:formatNumber>건</div>
				            <div style="${titleDivStyle} margin-bottom:10px;"><a href="javascript:;" onclick="javascript:funFrmPagingSubmit2('/kube/channel/${videoList.channel}/${cha:seqEncode(videoList.code_seq1)}/${cha:seqEncode(999999)}');"><img src="/resource/images/sub/btn_more.png" /></a></div> 
			             	<c:set var="tmpP_codeCnt" value="${tmpP_codeCnt + 1}"></c:set> 
			            	<c:set var="divStyle" value=""></c:set>
			            	<c:set var="chkCnt" value="false"></c:set>
			            
			            <c:set var="titleDivStyle" value="margin-top:120px;"></c:set>	
			            
			            <div class="media-box">
			            </c:if>
	            			<c:if test="${chkCnt}">
	            				<c:set var="divStyle" value="margin-left:13px;"></c:set>
	            			</c:if>
			                <div class="media-box01" style="float:left;${divStyle}">
			                    <div style="float:left">
			                        <div class="media-time" style="margin-top:80px; margin-left:134px">
			                            ${cha:secToHour(videoList.duration)}
			                        </div>
			                        <a href="javascript:;" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');"><img src="${web_url.concat(videoList.thumb_log_path)}" class="imgMaxWidth180" /></a>
			                    </div>                
			                    <span class="media_txt01">${cha:splitStr(videoList.title,'20') }</span><br>
			                    <span class="media_txt02">${videoList.p_code_desc }</span><br>
			                    <span class="media_txt03"><img src="/resource/images/icon_12.png"> <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp; <img src="/resource/images/icon_13.png"> <fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span>
			                </div>
			                <c:set var="chkCnt" value="true"></c:set>
						<c:set var="tmpP_code" value="${videoList.code_seq1}"></c:set>
					</c:if>
				</c:forEach>
				
	            <div style="clear:both"></div>
				
				<c:set var="titleDivStyle" value="margin-top:120px;"></c:set>
				<c:if test="${!videoCategory1 && !videoCategory2 && !videoCategory3}">
					<c:set var="titleDivStyle" value="margin-top:30px;"></c:set>
				</c:if>
				
				<c:if test="${videoCategory4 }"> 
		            <div class="sub-nav-title1" style="width:690px; ${titleDivStyle} margin-bottom:10px; float:left">${videoCategory4DeptName } 영상 : <fmt:formatNumber value="${totalCnt['saupso_cnt']}" pattern="#,###,###,###"></fmt:formatNumber>건</div>
		            <div style="${titleDivStyle} margin-bottom:10px;"><a href="javascript:;" onclick="javascript:funFrmPagingSubmit2('/kube/channel/${videoCategoryLink4 }');"><img src="/resource/images/sub/btn_more.png" /></a></div> 
	            </c:if>
	             
	            <div class="media-box">
	            	<c:set var="divStyle" value=""></c:set>
	            	<c:set var="chkCnt" value="false"></c:set>
	            	<c:forEach var="videoList" items="${videoList }" varStatus="videoListStatus">
	            		<c:if test="${videoList.order_seq == '4'}">
	            			<c:if test="${chkCnt}">
	            				<c:set var="divStyle" value="margin-left:13px;"></c:set>
	            			</c:if>
			                <div class="media-box01" style="float:left;${divStyle}">
			                    <div style="float:left">
			                        <div class="media-time" style="margin-top:80px; margin-left:134px">
			                            ${cha:secToHour(videoList.duration)}
			                        </div>
			                        <a href="javascript:;" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(videoList.vi_seq) }', '${videoList.code_seq1 }', '${videoList.code_seq2 }');"><img src="${web_url.concat(videoList.thumb_log_path)}" class="imgMaxWidth180" /></a>
			                    </div>                
			                    <span class="media_txt01">${cha:splitStr(videoList.title,'20') }</span><br>
			                    <span class="media_txt02">${videoList.p_code_desc }</span><br>
			                    <span class="media_txt03"><img src="/resource/images/icon_12.png"> <fmt:formatNumber value="${videoList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp; <img src="/resource/images/icon_13.png"> <fmt:formatNumber value="${videoList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span>
			                </div>
			                <c:set var="chkCnt" value="true"></c:set>
						</c:if>
	                </c:forEach>
				</div> 
	            
	            <div style="clear:both;margin-bottom: 180px;"></div>
	            
			</div>
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

function funVideoDetail(url, c1, c2){
	$('#p_code_seq').val(c1);
	$('#code_seq').val(c2);
	funGoPageDetail(url);
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />