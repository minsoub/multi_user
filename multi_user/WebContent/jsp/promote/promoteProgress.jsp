<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<jsp:useBean id="toDay" class="java.util.Date" />

<body>


<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />

<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="9"></c:param>
				<c:param name="left_depth_2" value="${left_depth_2 }"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<form id="frm" name="frm" method="post">
		<input type="hidden" id="p_seq" name="p_seq">
		<input type="hidden" id="left_depth_2" name="left_depth_2" value="${left_depth_2 }">
		<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
			<!--content-->
			<div class="contents-con-framebox">
				<div class="nav-box">
					<div class="nav-img"><img alt="" src="/resource/images/sub/sub9_tit_img.png"></div>
					<div class="nav-list">
						<c:if test="${left_depth_2 == '3' }">
							<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;행사신청&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">진행사항</b>
						</c:if>
						<c:if test="${left_depth_2 == '4' }">
							<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;행사신청&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">결재</b>
						</c:if>
					</div>
					<c:if test="${left_depth_2 == '3' }">
						<div class="nav-title">진행사항</div>
					</c:if>
					<c:if test="${left_depth_2 == '4' }">
						<div class="nav-title">결재</div>
					</c:if>
				</div>	
	            
	            <div class="searchArea_con">
						<fieldset>
						<div class="search-box">		
							<div class="form-group">
	                            <legend>검색영역</legend>
	                            <div style="float:left">
	                                <p class="inputDesign">
	                                    <select name="srh_sel_status">
	                                        <option value="">전체</option>
	                                        <option value="1" ${paging.srh_sel_status == '1' ? 'selected' : '' }>신청</option>
	                                        <option value="2" ${paging.srh_sel_status == '2' ? 'selected' : '' }>승인</option>
	                                        <option value="3" ${paging.srh_sel_status == '3' ? 'selected' : '' }>반려</option>   	
	                                        <option value="4" ${paging.srh_sel_status == '4' ? 'selected' : '' }>취소</option>   	
	                                        <option value="6" ${paging.srh_sel_status == '6' ? 'selected' : '' }>완료</option>                                 
	                                    </select>
	                                <legend>검색영역</legend>                        
	                                    기간
	                                    <input type="text" name="start_date" id="start_date" readonly value='${paging.start_date }'
	                                    style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
	                                    ~
	                                    <input type="text" name="end_date" id="end_date" readonly value="${paging.end_date }"
	                                    style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
								</div>
	                            
								<div style="float:left; margin-left:20px">
	                                <p class="inputDesign">
	    							<select name="srh_gubun">
	    								<option value="all">전체</option>
	                                    <option value="1" ${paging.srh_gubun == '1' ? 'selected' : '' }>행사명</option>
	    								<option value="2" ${paging.srh_gubun == '2' ? 'selected' : '' }>신청자</option>
	    							</select>
								</div>							
								<input type="text" title="검색바" id="srh_keyword" name="srh_keyword" value="${paging.srh_keyword }" style="width: 158px;height:15px;margin-left: 8px;font-size:12px;color:#666;" onkeydown="javascript:if(event.keyCode == 13){funFrmPagingSubmit();}">
								<input type="button" style="cursor: pointer;" class="search_btn" onclick="javascript:funFrmPagingSubmit();" value="검색">
							</div>
						</div>
						</fieldset>
				</div>
	
				<div class="basic-list">
					<table id="listTable" summary="">
						<caption>게시판 테이블</caption>
						<colgroup>
							<col style="width: 5%" class="no-td">
							<col style="width: 15%">
							<col />
							<col style="width: 10%">
							<col style="width: 9%">
							<col style="width: 15%">
	                        <col style="width: 8%">
							<col style="width: 10%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="no-td" style="padding: 7px 0;">번호</th>
								<th scope="col" class="like-td" style="padding: 7px 0;">행사일시</th>
								<th scope="col" class="like-td" style="padding: 7px 0;">행사명</th>
	                            <th scope="col" class="like-td" style="padding: 7px 0;">행사주체</th>
								<th scope="col" class="like-td" style="padding: 7px 0;">에너지밸리<br />홍보설명</th>
	                            <th scope="col" class="like-td" style="padding: 7px 0;">신청부서</th>
	                            <th scope="col" class="like-td" style="padding: 7px 0;">신청자</th>
	                            <th scope="col" class="like-td" style="padding: 7px 0;">진행상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="promoteList" items="${promoteList }" varStatus="status">
								<tr>
									<td class="no-td">${totalCnt - (paging.perPageCnt*(paging.pageNo-1)) - status.index }</td>
									<td class="like-td">${cha:todate(promoteList.p_date, '-', '3')}<br />${cha:todate(promoteList.start_time,'','5') } ~ ${cha:todate(promoteList.end_time,'','5') }</td>
		                            <td class="like-td" onclick="javascript:funDetail('${promoteList.p_seq}')" style="cursor:pointer;text-decoration:underline; text-align:left; width:220px;overflow: hidden; white-space: nowrap; -ms-text-overflow: ellipsis;">${promoteList.p_title }</td>
									<td class="like-td">${cha:pTarget(promoteList.p_target_code, promoteList.p_target_desc)}</td>
									<td class="like-td">${promoteList.energy_flag == '0' ? '미신청' : '신청' }</td> 
									<td class="like-td">${promoteList.dept_name }</td>
		                            <td class="like-td">${promoteList.name }</td>
		                            <td class="like-td"><img src="/resource/images/sub/st_0${promoteList.p_status }.png"></td>
								</tr>
							</c:forEach>
							<c:if test="${fn:length(promoteList) == 0}">
								<tr><td colspan="8">검색 결과가 없습니다.</td></tr>
							</c:if>						
						</tbody>
					</table>
				</div>
	        	<c:import url="/resource/common/include/paging.jsp" />
			</div>
			<!--content end-->
		</form>
	</div>
</div>

<script type="text/javascript"> 
$(document).ready(function() {
	load_fnc('9', '0', '0'); //menu script
	$('#start_date').datepicker();
	$('#end_date').datepicker();
});

function funDetail(p_seq){
	$('#p_seq').val(p_seq);
	funGoPageDetail('/promote/promoteDetail.do');	
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />