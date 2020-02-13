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
				<c:param name="left_depth_1" value="${menu_depth1}"></c:param>
				<c:param name="left_depth_2" value="${menu_depth2}"></c:param>
			</c:import>
		</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub2_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;서비스요청&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">${title}</b>
				</div>
				<div class="nav-title">${title}</div>
			</div>
			<div class="sub-nav-title">진행사항</div>
			
			<div class="tabNav sub5">
				<li><a href="javascript:ReqWrite();">출력요청</a></li>
				<li><a href="javascript:ReqList();" class="active">진행사항</a></li>
			</div>				
			
			<form id="frm" name="frm" method="post" onSubmit="return false;" onkeypress="javascript:if(event.keyCode == 13){funFrmPagingSubmit3('/printlist.do')}">
			<input type="hidden" name="pageNo" id="pageNo"  value="${paging.pageNo }"/>
			<input type="hidden" id="bbsid" name="bbsid" value="${bbsid}" />
			<input type="hidden" id="seq" name="seq" value="0">

			<div class="searchArea_con">
					<fieldset>
					<div class="search-box">
						<div class="form-group">
							<input type="checkbox" id="sts1" name="sts1" value="ALL" checked onClick="javascript:Check();"> 전체
							<input type="checkbox" id="sts2" name="sts2" value="R" disabled="disabled"> 신청
							<input type="checkbox" id="sts3" name="sts3" value="Y" disabled="disabled"> 진행
							<input type="checkbox" id="sts4" name="sts4" value="A" disabled="disabled"> 완료
							<input type="checkbox" id="sts5" name="sts5" value="C" disabled="disabled"> 사용자취소
						</div>	
						<div class="form-group">
							<legend>검색영역</legend>
							<div>
                                <p class="inputDesign">
    							<select id="req_type">
    								<option value="">출력종류</option>
    								<option value="1">현수막</option>
    								<option value="2">A2</option>
    								<option value="3">A1</option>
    								<option value="4">A0</option>
    								<option value="5">기타</option>
    							</select>    							    							
                            
                            	<input type="text" name="searchFromDt" id="searchFromDt" readonly="readonly"/> ~
                            	<input type="text" name="searchToDt"   id="searchToDt" readonly="readonly" />
                            </div>
							<input type="text" title="검색바" id="searchString" name="searchString" value="${paging.searchString}">
							<input type="button" style="cursor: pointer;" class="search_btn" onclick="javascript:ReqList();" value="검색">
						</div>						
					</div>
					</fieldset>
				</div>
				
		
				<div class="basic-list">
						<table id="listTable" summary="">
							<caption>게시판 테이블</caption>
							<colgroup>
								<col style="width: 5%" class="no-td">
								<col style="width: auto%">
								<col style="width: 10%">
								<col style="width: 10%">
								<col style="width: 15%" class="date-td">
								<col style="width: 15%" class="date-td">
								<col style="width: 10%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col" class="no-td">번호</th>
									<th scope="col" ><span class="sort" sortid="2">제목</span></th>
									<th scope="col">출력종류</th>
									<th scope="col">신청자</th>
									<th scope="col">요청일</th>
									<th scope="col">완료일</th>
									<th scope="col">상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${noticeList}" varStatus="status">
									<tr>
										<td class="no-td">${totalCnt - (paging.perPageCnt*(paging.pageNo-1)) - status.index }</td>
										<td style="text-align: left;cursor: pointer;" onclick="javascript:ViewDetail('${item.seq}');">${item.subject }</td>
										<td style="text-align">${item.req_type_nm}</td>
										<td style="text-align">${item.reg_nm}</td>
										<td class="date-td">${item.prt_req_dt }</td>
										<td class="date-td">${item.aprv_dt }</td>
										<td style="text-align">${item.aprv_status_nm}</td>
									</tr>
								</c:forEach>
							<c:if test="${fn:length(noticeList) == 0}">
				              	<tr>
				              		<td colspan="7">검색 결과가 없습니다</td>
				              	</tr>
				            </c:if>
						</tbody>	
					</table>
				</div>		
			</form>
				
			<c:import url="/resource/common/include/paging.jsp" />	
					<div class="btn-zone">
						<ul>
							<li><input type="button" name="srchDescription" class="admin_btn" onclick="javascript:ReqWrite();" value="등록"></li>
						</ul>
					</div>			
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('2', '0', '0'); //menu script
	
	$("#searchFromDt").datepicker();
	$("#searchToDt").datepicker();	
});

function Check()
{
	if ($("input:checkbox[id='sts1']").is(":checked") == true)  // 전체 선택한 경우
	{
		$("input:checkbox[id='sts2']").prop("checked", false);
		$("input:checkbox[id='sts3']").prop("checked", false);
		$("input:checkbox[id='sts4']").prop("checked", false);
		$("input:checkbox[id='sts5']").prop("checked", false);
		
		$("#sts2").attr("disabled", 'disabled');
		$("#sts3").attr("disabled", 'disabled');
		$("#sts4").attr("disabled", 'disabled');
		$("#sts5").attr("disabled", 'disabled');
	}else {
		$("#sts2").removeAttr("disabled");
		$("#sts3").removeAttr("disabled");
		$("#sts4").removeAttr("disabled");
		$("#sts5").removeAttr("disabled");		
	}
}
function ReqWrite()
{
	var f = document.frm;
	f.target = "_self";
	//f.pageNo.value = "1";
	f.action = '/printWrite.do';	
	f.submit();			
}

function ViewDetail(seq)
{
	$("#seq").val(seq);	
	var f = document.frm;
	f.target = "_self";
	//f.pageNo.value = "1";
	f.action = '/bbsDetail.do';	
	f.submit();
}

function ReqList()
{
	var f = document.frm;
	f.target = "_self";
	//f.pageNo.value = "1";
	f.action = '/printlist.do';	
	f.submit();	
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />