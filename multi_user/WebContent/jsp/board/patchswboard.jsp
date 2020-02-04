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
				<c:param name="left_depth_1" value="11"></c:param>
				<c:param name="left_depth_2" value="4"></c:param>
			</c:import>
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub7_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;다운로드&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">패치/업데이트</b>
				</div>
				<div class="nav-title">패치/업데이트</div>
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
								<col style="width: 8%" class="no-td">
								<col style="width: auto%">
								<col style="width: 20%">
								<col style="width: 15%" class="date-td">
							</colgroup>
							<thead>
								<tr>
									<th scope="col" class="no-td">번호</th>
									<th scope="col" ><span class="sort" sortid="2">제목</span></th>
									<th scope="col">등록일</th>
									<th scope="col" class="date-td" ><span class="sort sort_desc" sortid="-1">조회</span></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${noticeList}" varStatus="status">
									<tr>
										<td class="no-td">${totalCnt - (paging.perPageCnt*(paging.pageNo-1)) - status.index }</td>
										<td style="text-align: left;cursor: pointer;" onclick="javascript:funGoPageDetail('/freeboard_view.do?seq=${item.seq}');">${item.subject }</td>
										<td class="date-td">${item.wtime }</td>
										<td class="ref-td">${item.hit }</td>
									</tr>
								</c:forEach>
							<c:if test="${fn:length(noticeList) == 0}">
				              	<tr>
				              		<td colspan="4">검색 결과가 없습니다</td>
				              	</tr>
				            </c:if>
						</tbody>	
					</table>
				</div>		
			</form>
				
			<c:import url="/resource/common/include/paging.jsp" />	
					<div class="btn-zone">
						<ul>
							<li><input type="button" name="srchDescription" class="admin_btn" onclick="javascript:window.location='/bbsWrite.do?bbsid=10025';" value="등록"></li>
						</ul>
					</div>				
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('5', '0', '0'); //menu script
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />