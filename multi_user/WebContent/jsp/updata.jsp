<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id" style="width:800px;padding-bottom:0px;">
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img" style="top:0px;"><img alt="" src="/resource/images/update_bg.png"></div>
				<div class="nav-list"></div>
				<div class="nav-title" style="position: absolute;padding-top: 65px;padding-left: 20px;"><img alt="" src="/resource/images/update_tit1.png"></div>
			</div>        
		
			<form id="frm" name="frm" method="post" onSubmit="return false;">
			<input type="hidden" name="pageNo" id="pageNo"  value="${paging.pageNo }"/>
			<div class="basic-list">
					<table id="listTable" summary="" style="width:95%;margin-left: 2%;">
						<caption>게시판 테이블</caption>
						<colgroup>
							<col style="width: 8%" class="no-td">
							<col style="width: auto%">
							<col style="width: 20%">
							<col style="width: 15%" class="date-td">
							<col style="width: 15%" class="ref-td">
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
							<c:forEach var="item" items="${today_updateList}" varStatus="status">
								<tr>
									<td class="no-td" style="min-height:15px;">${totalCnt - (paging.perPageCnt*(paging.pageNo-1)) - status.index }</td>
									<td class="subject" style="padding-left:px; min-height:15px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
										<a href="javascript:;" onclick="javascript:VOD_Link('${item.re_form}', '${item.re_Step }', '${item.subject }', '${item.num}');">${item.subject }</a>
									</td>
									<td class="date-td" style="min-height:15px;">${item.r_date }</td>
									<td class="ref-td" style="min-height:15px;">${item.visited }</td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(today_updateList) == 0}">
				              	<tr>
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
</body>
</html>