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
		<c:set var="isGetAdmin" value="${sessionScope.SESS_USER_INFO['rentAdmin']}"></c:set>
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub2_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;서비스요청&nbsp;&nbsp;>&nbsp;&nbsp;${title}&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">진행사항</b>
				</div>
				<div class="nav-title">${title} <small class="sub2">진행사항</small></div>
			</div>
			
			<ul class="tabNav sub2">
				<li><a href="javascript:ReqWrite();">출력요청</a></li>
				<li><a href="javascript:ReqList();" class="active">진행사항</a></li>
			</ul>				
			
			<form id="frm" name="frm" method="post" onSubmit="return false;" onkeypress="javascript:if(event.keyCode == 13){funFrmPagingSubmit3('/printlist.do')}">
			<input type="hidden" name="pageNo" id="pageNo"  value="${paging.pageNo }"/>
			<input type="hidden" id="bbsid" name="bbsid" value="${bbsid}" />
			<input type="hidden" id="seq" name="seq" value="0">

			<div class="searchArea_con">
				<fieldset>
				<div class="search-box mt0">
				  <div class="form-group">
						<legend>검색영역</legend>
						<div class="checks small" style="margin:3px 20px 3px 0;">
							<input type="checkbox" id="sts1" name="sts1" value="ALL" <c:if test="${paging.sts1 eq 'ALL'}">checked</c:if>><label for="sts1" class="labelSty">전체</label>
							<input type="checkbox" id="sts2" name="sts2" value="R"   <c:if test="${paging.sts2 eq 'R'}">checked</c:if>><label for="sts2" class="labelSty">신청</label>
							<input type="checkbox" id="sts3" name="sts3" value="Y"   <c:if test="${paging.sts3 eq 'Y'}">checked</c:if>><label for="sts3" class="labelSty">진행중</label> 
							<input type="checkbox" id="sts4" name="sts4" value="A"   <c:if test="${paging.sts4 eq 'A'}">checked</c:if>><label for="sts4" class="labelSty">완료</label> 
							<input type="checkbox" id="sts5" name="sts5" value="C"   <c:if test="${paging.sts5 eq 'C'}">checked</c:if>><label for="sts5" class="labelSty">사용자취소</label> 
						</div>	
						<div>
							<p class="inputDesign">
    							<select id="req_type"  name="req_type" style="width:148px;">
    								<option value="">출력종류</option>
    								<option value="1" <c:if test="${paging.req_type eq '1'}">selected</c:if>>현수막</option>
    								<option value="2" <c:if test="${paging.req_type eq '2'}">selected</c:if>>A2</option>
    								<option value="3" <c:if test="${paging.req_type eq '3'}">selected</c:if>>A1</option>
    								<option value="4" <c:if test="${paging.req_type eq '4'}">selected</c:if>>A0</option>
    								<option value="5" <c:if test="${paging.req_type eq '5'}">selected</c:if>>기타</option>
    							</select>    							    							
                            </p>
                            <input type="text" name="searchFromDt" id="searchFromDt" value="${paging.searchFromDt}" readonly="readonly" style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;"/>
                            ~
                            <input type="text" name="searchToDt"   id="searchToDt"  value="${paging.searchToDt}"  readonly="readonly" style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;"/>     
                                                   
							<input type="text" title="검색바" id="searchString" name="searchString" value="${paging.searchString}"  style="width:120px;height:15px;margin-left: 7px;font-size:12px;color:#666;">
							<input type="button" style="cursor: pointer;" class="search_btn" onclick="javascript:ReqList();" value="검색">
							
						</div>	
				  </div>					
				</div>
				</fieldset>
			</div>
				
		
			<div class="basic-list mtSm">
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
							<th scope="col" style="cursor: pointer;"><span class="sort" sortid="2">제목</span></th>
							<th scope="col">출력종류</th>
							<th scope="col">신청자</th>
							<th scope="col" class="date-td" style="cursor: pointer;"><span class="sort sort_desc" sortid="-1">요청일</span></th>
							<th scope="col" class="ref-td">완료일</th>
							<th scope="col">상태</th>
						</tr>
					</thead>
					<tbody>
					    <c:set var="isGetAdmin" value="${sessionScope.SESS_USER_INFO['rentAdmin']}"></c:set>
						<c:forEach var="item" items="${noticeList}" varStatus="status">
						<tr>
							<td class="no-td">${totalCnt - (paging.perPageCnt*(paging.pageNo-1)) - status.index }</td>
							<c:if test="${isGetAdmin != null or SESS_EMPNO eq item.reg_id}">
								<td class="subject" style="text-align: left;cursor: pointer;" onclick="javascript:ViewDetail('${item.seq}', '${item.reg_id}');">${item.subject }</td>
							</c:if>
							<c:if test="${isGetAdmin == null or SESS_EMPNO ne item.reg_id}">
								<td class="subject" style="text-align: left;">${item.subject }</td>
							</c:if>
							<td class="date-td">${item.req_type_nm}</td>
							<td>${item.reg_nm}</td>
							<td class="ref-td">${item.prt_req_dt }</td>
							<td class="like-td">${item.aprv_dt }</td>
							<c:set var="cls" value="con-font-0"></c:set>
							<c:if test="${item.aprv_status eq 'R'}"><c:set var="cls" value="con-font-0"></c:set></c:if>
							<c:if test="${item.aprv_status eq 'Y'}"><c:set var="cls" value="con-font-1"></c:set></c:if>
							<c:if test="${item.aprv_status eq 'A'}"><c:set var="cls" value="con-font-2"></c:set></c:if>
							<c:if test="${item.aprv_status eq 'C'}"><c:set var="cls" value="con-font-3"></c:set></c:if>
							<td><p class="${cls}">${item.aprv_status_nm}</p></td>
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
			
			<div class=btn-zone>
				<ul>
					<li><input type="button" name="srchDescription" class="admin_btn" onclick="javascript:ReqWrite();" value="등록"></li>
				</ul>
			</div>	
			<c:if test="${isGetAdmin != null}">
			<div class="filebox">
				<label class="imgSty fl">
					<a href="javascript:ExcelDownload();"><img alt="" src="/resource/images/icon_exel.png" style="width: 20%"> 처리내용 다운로드</a>
				</label>
			</div>			
			</c:if>
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript" src="/resource/common/js/jquery.fileDownload.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('2', '0', '0'); //menu script
	
	$("#searchFromDt").datepicker();
	$("#searchToDt").datepicker();	
	
	$("#sts1").change(function() {
		StsCheck();
	});
});

function StsCheck()
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

function ViewDetail(seq, reg_id)
{
	$("#seq").val(seq);	
	var f = document.frm;
	f.target = "_self";
	//f.pageNo.value = "1";
	f.action = '/printDetail.do';	
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
 
function ExcelDownload()
{
	var xlsDown = true;
	if(xlsDown){
		xlsDown = false;
		
		$('#frm').attr('action','/printExcelDownload.do').attr('method', 'post').attr('target', 'ifrm').submit();
		
		$.fileDownload($("#frm").prop('action'),{
			httpMethod: "POST",  
			data:jQuery("#frm").serialize(),   
			successCallback: function (url) {
				xlsDown = true;
			},
			failCallback: function(responesHtml, url){
				alert('다운로드 오류 발생. 관리자에게 문의 하시기 바랍니다.');
				xlsDown = true;
			}
		}); 
	}else{ 
		alert('다운로드 진행 중 입니다.\n데이터 양이 많을수록 엑셀 처리 속도가 지연됩니다.(약 50건/초)\n화면 이동시 진행중인 다운로드는 취소됩니다.');
	}
	
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />