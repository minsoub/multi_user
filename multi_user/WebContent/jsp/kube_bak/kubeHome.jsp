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
				<c:param name="left_depth_2" value="1"></c:param>
			</c:import>
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="searchArea_con" style="float:right; margin-top:45px">
					<fieldset>
					<div class="search-box">		
						<div class="form-group">
							<form id="frm" name="frm" method="post" onSubmit="return false;">
								<input type="hidden" id="p_code_seq" name="p_code_seq" /> 
								<input type="hidden" id="code_seq" name="code_seq" />  
								<legend>검색영역</legend>	 
								<input type="text" title="검색바" id="srh_keyword" name="srh_keyword" placeholder="통합검색" style="width: 300px; height:34px; padding-left: 20px;font-size:14px;color:#666; border:1px solid #bea2d9" onkeydown="javascript:if(event.keyCode == 13){funGoPageDetail('/kube/channel/search');}">
	                            <img src="/resource/images/sub/btn_search.png" style="cursor: pointer;" onclick="javascript:funGoPageDetail('/kube/channel/search');" />
                            </form>
						</div>
					</div>
					</fieldset>
			     </div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;KUBE&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">홈 (KEPCO YOUTUBE)</b>
				</div>
				<div class="nav-title">KEPCO YOUTUBE</div>
			</div>
		
			<c:if test="${fn:length(mainInfos) > 0}">
				<div class="media-box">
	                <div style="float:left">
	                    <div class="media-text" style="margin-top:360px;">
	                        <p>${mainInfos[0].caption_min_title}</p><br>
	                        <p style="font-size:30px">${mainInfos[0].caption_title}</p>
	                    </div>
	                    <a href="${mainInfos[0].link_url }"><img src="${web_url.concat(mainInfos[0].thumb_log_path)}" /></a>
	                </div>
	                
	                
	                <div style="float:left">
	                    <div class="media-text" style="margin-top:180px;">
	                        ${mainInfos[1].caption_title}
	                    </div>
	                    <a href="${mainInfos[1].link_url }"><img src="${web_url.concat(mainInfos[1].thumb_log_path)}" /></a>
	                </div>
	                
	                
	                <div style="float:left">
	                    <div class="media-text" style="margin-top:180px;">
	                        ${mainInfos[2].caption_title}
	                    </div>
	                    <a href="${mainInfos[2].link_url }"><img src="${web_url.concat(mainInfos[2].thumb_log_path)}" /></a>
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
					<c:set var="homeCategoryLink1" value="weekly"></c:set>
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
			
			<c:if test="${homeCategory1 }">
	            <div class="sub-nav-title1" style="margin-top:30px; float:left"><img src="/resource/images/sub/tit_icon01.png" style="margin-right:10px"/>주간 인기동영상</div>
	            <div style="margin-top:30px; float:right"><a href="/kube/channel/${homeCategoryLink1 }"><img src="/resource/images/sub/btn_more.png" /></a></div>
            </c:if>
            
            <c:set var="tmpHomeListFirstChk" value="true"></c:set>
            <div class="media-box" style="clear:both;margin-bottom: 180px; ${homeCategory1 ? '' : 'display:none;'}">
            	<c:forEach var="homeList" items="${homeList }" varStatus="homeListStatus">
            		<c:choose>
            			<c:when test="${tmpHomeListFirstChk && homeList.order_seq == 1}">
            				<c:set var="tmpHomeListFirstChk" value="false"></c:set>
			                <div class="media-box01" style="float:left; cursor: pointer;">
			                    <div style="float:left">
			                        <div class="media-time" style="margin-top:80px; margin-left:134px">
			                            ${cha:secToHour(homeList.duration)}
			                        </div> 
			                        <a href="javascript:;" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(homeList.vi_seq) }', '${homeList.code_seq1 }', '${homeList.code_seq2 }');"><img src="${storage_web_url.concat(homeList.thumb_log_path)}" class="imgMaxWidth180" /></a>
			                    </div>                
			                    <span class="media_txt01">${cha:splitStr(homeList.title, '23') }</span><br>
			                    <span class="media_txt02">${homeList.p_code_desc }</span><br>
			                    <span class="media_txt03"><img src="/resource/images/icon_12.png"> <fmt:formatNumber value="${homeList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp; <img src="/resource/images/icon_13.png"> <fmt:formatNumber value="${homeList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span>
			                </div>
            			</c:when>
            			<c:when test="${!tmpHomeListFirstChk && homeList.order_seq == 1}">
	            			<div class="media-box01" style="float:left; margin-left:13px; cursor: pointer;">
			                    <div style="float:left">
			                        <div class="media-time" style="margin-top:80px; margin-left:134px">
			                            ${cha:secToHour(homeList.duration)}
			                        </div>
			                        <a href="javascript:;" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(homeList.vi_seq) }', '${homeList.code_seq1 }', '${homeList.code_seq2 }');"><img src="${storage_web_url.concat(homeList.thumb_log_path)}" class="imgMaxWidth180" /></a>
			                    </div>
			                    <span class="media_txt01">${cha:splitStr(homeList.title, '23') }</span><br>
			                    <span class="media_txt02">${homeList.p_code_desc }</span><br>
			                    <span class="media_txt03"><img src="/resource/images/icon_12.png"> <fmt:formatNumber value="${homeList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp; <img src="/resource/images/icon_13.png"> <fmt:formatNumber value="${homeList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span>
			                </div>
			            </c:when>
            		</c:choose>
				</c:forEach>
            </div>
            
            <c:if test="${homeCategory2 }">
	            <div class="sub-nav-title1" style="margin-top:30px; float:left"><img src="/resource/images/sub/tit_icon02.png" style="margin-right:10px"/>최신 동영상</div>
	            <div style="margin-top:30px; float:right"><a href="/kube/channel/${homeCategoryLink2 }"><img src="/resource/images/sub/btn_more.png" /></a></div>
            </c:if>
            
            <c:set var="tmpHomeListFirstChk" value="true"></c:set>
            <div class="media-box" style="clear:both;margin-bottom: 180px; ${homeCategory2 ? '' : 'display:none;'}">
            	<c:forEach var="homeList" items="${homeList }" varStatus="homeListStatus">
            		<c:choose>
            			<c:when test="${tmpHomeListFirstChk && homeList.order_seq == 2}">
            				<c:set var="tmpHomeListFirstChk" value="false"></c:set>
			                <div class="media-box01" style="float:left; cursor: pointer;">
			                    <div style="float:left">
			                        <div class="media-time" style="margin-top:80px; margin-left:134px">
			                            ${cha:secToHour(homeList.duration)}
			                        </div>
			                        <a href="javascript:;" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(homeList.vi_seq) }', '${homeList.code_seq1 }', '${homeList.code_seq2 }');"><img src="${storage_web_url.concat(homeList.thumb_log_path)}" class="imgMaxWidth180" /></a>
			                    </div>                
			                    <span class="media_txt01">${cha:splitStr(homeList.title, '23') }</span><br>
			                    <span class="media_txt02">${homeList.p_code_desc }</span><br>
			                    <span class="media_txt03"><img src="/resource/images/icon_12.png"> <fmt:formatNumber value="${homeList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp; <img src="/resource/images/icon_13.png"> <fmt:formatNumber value="${homeList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span>
			                </div>
            			</c:when>
            			<c:when test="${!tmpHomeListFirstChk && homeList.order_seq == 2}">
	            			<div class="media-box01" style="float:left; margin-left:13px; cursor: pointer;">
			                    <div style="float:left">
			                        <div class="media-time" style="margin-top:80px; margin-left:134px">
			                            ${cha:secToHour(homeList.duration)}
			                        </div>
			                        <a href="javascript:;" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(homeList.vi_seq) }', '${homeList.code_seq1 }', '${homeList.code_seq2 }');"><img src="${storage_web_url.concat(homeList.thumb_log_path)}" class="imgMaxWidth180" /></a>
			                    </div>
			                    <span class="media_txt01">${cha:splitStr(homeList.title, '23') }</span><br>
			                    <span class="media_txt02">${homeList.p_code_desc }</span><br>
			                    <span class="media_txt03"><img src="/resource/images/icon_12.png"> <fmt:formatNumber value="${homeList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp; <img src="/resource/images/icon_13.png"> <fmt:formatNumber value="${homeList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span>
			                </div>
			            </c:when>
            		</c:choose>
				</c:forEach>
            </div>
             
            <c:if test="${homeCategory3 }">
	            <div class="sub-nav-title1" style="margin-top:30px; float:left; clear:both"><img src="/resource/images/sub/tit_icon01.png" style="margin-right:10px"/>TOP 100</div>
	            <div style="margin-top:30px; float:right"><a href="/kube/channel/${homeCategoryLink3 }"><img src="/resource/images/sub/btn_more.png" /></a></div>
            </c:if>
            
            <c:set var="tmpHomeListFirstChk" value="true"></c:set>
            <div class="media-box" style="clear:both; margin-bottom: 180px; ${homeCategory3 ? '' : 'display:none;'}">
            	<c:forEach var="homeList" items="${homeList }" varStatus="homeListStatus">
            		<c:choose>
            			<c:when test="${tmpHomeListFirstChk && homeList.order_seq == 3}">
            				<c:set var="tmpHomeListFirstChk" value="false"></c:set>
			                <div class="media-box01" style="float:left; cursor: pointer;">
			                    <div style="float:left">
			                        <div class="media-time" style="margin-top:80px; margin-left:134px">
			                            ${cha:secToHour(homeList.duration)}
			                        </div>
			                        <a href="javascript:;" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(homeList.vi_seq) }', '${homeList.code_seq1 }', '${homeList.code_seq2 }');"><img src="${storage_web_url.concat(homeList.thumb_log_path)}" class="imgMaxWidth180" /></a>
			                    </div>                
			                    <span class="media_txt01">${cha:splitStr(homeList.title, '23') }</span><br>
			                    <span class="media_txt02">${homeList.p_code_desc }</span><br>
			                    <span class="media_txt03"><img src="/resource/images/icon_12.png"> <fmt:formatNumber value="${homeList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp; <img src="/resource/images/icon_13.png"> <fmt:formatNumber value="${homeList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span>
			                </div>
            			</c:when>
            			<c:when test="${!tmpHomeListFirstChk && homeList.order_seq == 3}">
	            			<div class="media-box01" style="float:left; margin-left:13px; cursor: pointer;">
			                    <div style="float:left">
			                        <div class="media-time" style="margin-top:80px; margin-left:134px">
			                            ${cha:secToHour(homeList.duration)}
			                        </div>
			                        <a href="javascript:;" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(homeList.vi_seq) }', '${homeList.code_seq1 }', '${homeList.code_seq2 }');"><img src="${storage_web_url.concat(homeList.thumb_log_path)}" class="imgMaxWidth180" /></a>
			                    </div>
			                    <span class="media_txt01">${cha:splitStr(homeList.title, '23') }</span><br>
			                    <span class="media_txt02">${homeList.p_code_desc }</span><br>
			                    <span class="media_txt03"><img src="/resource/images/icon_12.png"> <fmt:formatNumber value="${homeList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp; <img src="/resource/images/icon_13.png"> <fmt:formatNumber value="${homeList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span>
			                </div>
			            </c:when>
            		</c:choose>
				</c:forEach>
            </div>
  
  			<c:if test="${homeCategory4 }">
		            <div class="sub-nav-title1" style="margin-top:30px; float:left; clear:both"><img src="/resource/images/sub/tit_icon02.png" style="margin-right:10px"/>${homeCategory4DeptName } 최신 동영상</div>
		            <div style="margin-top:30px; float:right"><a href="/kube/channel/${homeCategoryLink4 }"><img src="/resource/images/sub/btn_more.png" /></a></div>
            </c:if>
			            
            <c:set var="tmpHomeListFirstChk" value="true"></c:set>
            <div class="media-box" style="clear:both; margin-bottom: 180px; ${homeCategory4 ? '' : 'display:none;'}">
            	<c:forEach var="homeList" items="${homeList }" varStatus="homeListStatus">
            		<c:choose>
            			<c:when test="${tmpHomeListFirstChk && homeList.order_seq == 4}">
            				<c:set var="tmpHomeListFirstChk" value="false"></c:set>
			                <div class="media-box01" style="float:left; cursor: pointer;">
			                    <div style="float:left">
			                        <div class="media-time" style="margin-top:80px; margin-left:134px">
			                            ${cha:secToHour(homeList.duration)}
			                        </div>
			                        <a href="javascript:;" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(homeList.vi_seq) }', '${homeList.code_seq1 }', '${homeList.code_seq2 }');"><img src="${storage_web_url.concat(homeList.thumb_log_path)}" class="imgMaxWidth180" /></a>
			                    </div>                
			                    <span class="media_txt01">${cha:splitStr(homeList.title, '23') }</span><br>
			                    <span class="media_txt02">${homeList.p_code_desc }</span><br>
			                    <span class="media_txt03"><img src="/resource/images/icon_12.png"> <fmt:formatNumber value="${homeList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp; <img src="/resource/images/icon_13.png"> <fmt:formatNumber value="${homeList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span>
			                </div>
            			</c:when>
            			<c:when test="${!tmpHomeListFirstChk && homeList.order_seq == 4}">
	            			<div class="media-box01" style="float:left; margin-left:13px; cursor: pointer;">
			                    <div style="float:left">
			                        <div class="media-time" style="margin-top:80px; margin-left:134px">
			                            ${cha:secToHour(homeList.duration)}
			                        </div>
			                        <a href="javascript:;" onclick="javascript:funVideoDetail('/kube/watch/${cha:seqEncode(homeList.vi_seq) }', '${homeList.code_seq1 }', '${homeList.code_seq2 }');"><img src="${storage_web_url.concat(homeList.thumb_log_path)}" class="imgMaxWidth180" /></a>
			                    </div>
			                    <span class="media_txt01">${cha:splitStr(homeList.title, '23') }</span><br>
			                    <span class="media_txt02">${homeList.p_code_desc }</span><br>
			                    <span class="media_txt03"><img src="/resource/images/icon_12.png"> <fmt:formatNumber value="${homeList.visit_cnt}" pattern="#,###,###,###"></fmt:formatNumber> &nbsp;&nbsp; <img src="/resource/images/icon_13.png"> <fmt:formatNumber value="${homeList.like_cnt}" pattern="#,###,###,###"></fmt:formatNumber></span>
			                </div>
			            </c:when>
            		</c:choose>
				</c:forEach>
            </div>
            
            
            
			</form>
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('8', '0', '0'); //menu script
});

function funVideoDetail(url, c1, c2){
	$('#p_code_seq').val(c1);
	$('#code_seq').val(c2);
	funGoPageDetail(url);
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />