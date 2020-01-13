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
				<c:param name="left_depth_1" value="1"></c:param>
				<c:param name="left_depth_2" value="3"></c:param>
			</c:import>
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub1_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;사내방송&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">소셜미디어 홍보영상</b>
				</div>
				<div class="nav-title">소셜미디어 홍보영상</div>
			</div>
		
			<form id="frm" name="frm" method="post" onSubmit="return false;" onkeypress="javascript:if(event.keyCode == 13){funFrmPagingSubmit()}">
			<input type="hidden" name="pageNo" id="pageNo"  value="${paging.pageNo }"/>
		
			<div class="searchArea_con">
					<fieldset>
					<div class="search-box">		
						<div class="form-group">
							<legend>검색영역</legend>
							<div>
                                <p class="inputDesign">
    							<select>
    								<option>제목 + 내용</option>
    							</select>
                            </div>
							<input type="text" title="검색바" id="searchString" name="searchString" value="${paging.searchString}">
							<input type="button" style="cursor: pointer;" class="search_btn" onclick="javascript:funFrmPagingSubmit();" value="검색">
						</div>
					</div>
					</fieldset>
			</div>
		
			<div class="basic-list">
					<table id="listTable" summary="">
						<caption>게시판 테이블</caption>
						<colgroup>
							<col style="width: 10%" class="no-td">
							<col style="width: auto%">
							<col style="width: 20%">
							<col style="width: 10%" class="date-td">
							<col style="width: 12%" class="ref-td">
							<col style="width: 8%" >
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="no-td">번호</th>
								<th scope="col"><span class="sort" sortid="2">제목</span></th>
								<th scope="col">등록일</th>
								<th scope="col" class="date-td"><span class="sort sort_desc" sortid="-1">조회</span></th>
								<th scope="col" class="ref-td">댓글</th>
								<!--다운로드 주석
								<th scope="col" class="like-td">다운로드</th>
								-->
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${kepcnPlanList}" varStatus="status">
								<c:url value="http://${DIR_URL}/download.asp" var="url">
									<c:param name="file_dir" value="${fn:trim(item.re_Step)}" />
									<c:param name="file_name" value="${fn:trim(item.pdsFile)}" />
									<c:param name="db" value="vod_s1" />
									<c:param name="Num" value="${item.num}" />
									<c:param name="cook_name" value="${sess_id}" />
								</c:url>
								<c:set var="re_step" value="${fn:trim(item.re_Step)}"></c:set>
									<tr>
										<td class="no-td">${totalCnt - (paging.perPageCnt*(paging.pageNo-1)) - status.index }</td>
										<td class="subject" style="padding-left:px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
											<a href="javascript:;" onclick="javascript:playPopup('${item.re_form}', '${item.num}');">${item.subject }</a>
										</td>
										<td class="date-td">${item.r_date }</td>
										<td class="ref-td">${item.visited }</td>
										<td class="like-td">${item.re_comment }</td> 
										<%--다운로드 주석
										<td><a href="http://100.1.48.20/<%= Constants.getMultiUrl((String)pageContext.getAttribute("re_step")) %>/${fn:trim(item.pdsFile)}" onFocus="this.blur()" target="_new"><img alt="" src="/resource/images/btn/download.png"></a></td>
										--%>
									</tr>
							</c:forEach>
							<c:if test="${fn:length(kepcnPlanList) == 0}">
				              	<tr>
				              		<!--다운로드 주석
				              		<td colspan="6">검색 결과가 없습니다</td>
				              		-->
				              		<td colspan="5">검색 결과가 없습니다</td>
				              	</tr>
				            </c:if>
						</tbody>
					</table>
				</div>	
			</form>
				
			<c:import url="/resource/common/include/paging.jsp" />
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('1', '0', '0'); //menu script
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />