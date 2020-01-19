<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<jsp:useBean id="toDay" class="java.util.Date" />
<c:forEach items="${contentsCount}" var="contentsCount">
	<c:set var="CON1_ING" value="${contentsCount.CON1_ING}" />
	<c:set var="CON2_ING" value="${contentsCount.CON2_ING}" />
	<c:set var="CON3_ING" value="${contentsCount.CON3_ING}" />
	<c:set var="CON4_ING" value="${contentsCount.CON4_ING}" />
	<c:set var="CON5_ING" value="${contentsCount.CON5_ING}" />
	<c:set var="CON6_ING" value="${contentsCount.CON6_ING}" />
	<c:set var="CON7_ING" value="${contentsCount.CON7_ING}" />
	<c:set var="CON1_WAIT" value="${contentsCount.CON1_WAIT}" />
	<c:set var="CON2_WAIT" value="${contentsCount.CON2_WAIT}" />
	<c:set var="CON3_WAIT" value="${contentsCount.CON3_WAIT}" />
	<c:set var="CON4_WAIT" value="${contentsCount.CON4_WAIT}" />
	<c:set var="CON5_WAIT" value="${contentsCount.CON5_WAIT}" />
	<c:set var="CON6_WAIT" value="${contentsCount.CON6_WAIT}" />
	<c:set var="CON7_WAIT" value="${contentsCount.CON7_WAIT}" />
</c:forEach>
<style>
.labelSty{
	margin: -2px 3px 0px 10px;
}
.imgSty{
	float: right;
	width: 14%;
}
</style>

<body>



<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />

<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="2"></c:param>
				<c:param name="left_depth_2" value="1"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub2_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;서비스요청&nbsp;&nbsp;>&nbsp;&nbsp;컨텐츠제작&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">진행상황</b>
				</div>
				<div class="nav-title">컨텐츠 제작 <small class="sub2">진행상황</small></div>
			</div>
	
			<div class="tabNav sub2">
				<li><a href="/contentsInfo.do">이용안내</a></li>
				<li><a href="/contentsRequest.do">제작요청</a></li>
				<li><a href="#" class="active">진행사항</a></li>
			</div>
			
			
			<form id="frm" name="frm" method="post" onSubmit="return false;" onkeypress="javascript:if(event.keyCode == 13){btnSearFrm()}">
            <input type="hidden" id="SM_SEQ" name="SM_SEQ" value="0">
            <input type="hidden" id="SHSEQNUM" name="SHSEQNUM">
            <input type="hidden" id="mode"  name="mode" value="0"/>
			<input type="hidden" name="pageNo" id="pageNo"  value="${paging.pageNo }"/>
			<input type="hidden" name="s3" id="s3"  value="${paging.s3 }"/>
			
			<div class="searchArea_con">
					<fieldset>
					<div class="search-box">		
						<div class="form-group">
							<legend>검색영역</legend>
							<div class="checks small" style="margin-bottom: 10px;">
                            	<input type="checkbox" id="all" name="chkSearch" value=""  ${empty paging.s3 ? 'checked="checked"' : ''}><label for="all" class="labelSty">전체</label>
                                <input type="checkbox" id="order" name="chkSearch" value="3093" ${fn:contains(paging.s3, '3093') ? 'checked="checked"' : ''}><label for="order" class="labelSty">신청</label> 
                                <input type="checkbox" id="wait" name="chkSearch" value="3094" ${fn:contains(paging.s3, '3094') ? 'checked="checked"' : ''}><label for="wait" class="labelSty">승인대기</label> 
                                <input type="checkbox" id="proceeding" name="chkSearch" value="3099" ${fn:contains(paging.s3, '3099') ? 'checked="checked"' : ''}><label for="proceeding" class="labelSty">진행중</label> 
                                <input type="checkbox" id="complete" name="chkSearch" value="3095" ${fn:contains(paging.s3, '3095') ? 'checked="checked"' : ''}><label for="complete" class="labelSty">완료</label> 
                                <input type="checkbox" id="useCancle" name="chkSearch" value="3097" ${fn:contains(paging.s3, '3097') ? 'checked="checked"' : ''}><label for="useCancle" class="labelSty">사용자취소</label> 
							</div>
                            <div>
                                <p class="inputDesign">
    							<select name="s2" style="width:148px;">
    							<option value="">서비스구분</option>
    							<c:forEach items="${svc2Code}" var ="svc2Cnt" varStatus="cstatis">
    								<option value="<c:out value="${svc2Cnt.CD2_CODE}" />"
    								<c:if test="${svc2Cnt.CD2_CODE == paging.s2 }">selected="selected"</c:if>>
    								<c:out value="${svc2Cnt.CD2_NAME}" />
    								</option>
    							</c:forEach>
    							</select>
                            </div>
							<c:set var="fdate" value="${paging.SM_WDATE_FROM }" />
							<input type="text" name="SM_WDATE_FROM" id="SM_WDATE_FROM" readonly="readonly" value='<c:out value="${fdate }" />' 
                            style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
							~
							<input type="text" name="SM_WDATE_TO" id="SM_WDATE_TO" readonly="readonly" value="${paging.SM_WDATE_TO}"
                            style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
							
							<input type="text" title="검색바" id="s4" name="s4" value="${paging.s4 }" style="width: 185px;height:15px;margin-left: 7px;font-size:12px;color:#666;">
							<input type="button" style="cursor: pointer;" class="search_btn" onclick="javascript:btnSearFrm();" value="검색">
						</div>
					</div>
					</fieldset>
			</div>
			
			<div class="basic-list">
				<div class="insrtfrom-framebox">
				<div class="insert-step1-box">
					<div class="form-step1">
						<fieldset>
						<legend>제작요청</legend>
							<div class="row-group2">
								<c:forEach var="svc2Code" items="${svc2Code }" varStatus="sts">
								<c:if test="${sts.index % 2 == 0 }">
									<dl class="insert_ready2">
								</c:if>
									<dt class="must-option2"><label for="UserName" id="UserName_label">${svc2Code.CD2_NAME }</label></dt>
	                                   	<dd>
	                                        <ul style="width: 100%">
	                                            <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${svc2Code.LISTCNT }건</li>
	                                            <c:if test="${svc2Code.CD2_CODE == '3079' || svc2Code.CD2_CODE == '3080' }">
		                                            <c:set var="mdate" value="${svc2Code.LISTSUM / 60 }" />
		                                            <c:set var="sdate" value="${svc2Code.LISTSUM % 60 }" />
		                                            <fmt:parseNumber var="sdate" value="${sdate }" integerOnly="true" />
		                                            <fmt:parseNumber var="mdate" value="${mdate }" integerOnly="true" />
		                                            <li>${mdate } 분 ${sdate} 초</li>
	                                            </c:if>
	                                            <c:if test="${svc2Code.CD2_CODE == '3081' || svc2Code.CD2_CODE == '3082' }">
	                                            	<li>${svc2Code.LISTSUM } 매수</li>
	                                            </c:if>
	                                        </ul>
	                                    </dd>
                                   <c:if test="${sts.index % 2 == 1 }">
                                  	 </dl>
                                   </c:if>
								</c:forEach>
							</div>
						</fieldset>
					</div>
				</div>
				</div>	
			</div>
			
	
			<div class="basic-list">
				<table id="listTable" summary="">
					<caption>게시판 테이블</caption>
					<colgroup>
						<col style="width: 15%" class="no-td">
						<col style="width: 35%">
						<col style="width: 10%">
						<col style="width: 10%">
						<col style="width: 10%" class="date-td">
						<col style="width: 10%" class="ref-td">
						<col style="width: 10%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col" class="no-td">신청번호</th>
							<th scope="col" style="cursor: pointer;"><span class="sort" sortid="2">제목</span></th>
							<th scope="col">서비스구분</th>
							<th scope="col" >신청자</th>
							<th scope="col" class="date-td" style="cursor: pointer;"><span class="sort sort_desc" sortid="-1">등록일</span></th>
							<th scope="col" class="ref-td">희망완료일</th>
							<!-- <th scope="col" class="like-td"><p class="con-font-sub1">완료(예정)일</p></th> -->
							<th scope="col">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${contentsList}" varStatus="status">
								<tr>
									<td class="no-td">${item.SM_NO}</td>
									<td class="subject" style="overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
										<a href="#" onclick="doDetail('${cha:seqEncode(item.SM_SEQ)}');">${item.SM_TITLE }</a>
									</td>
									<td class="date-td">
										<c:set var="SVC2_SPLIT" value="${fn:split(item.SM_SVC2,',')}"/>
										<c:choose>
											<c:when test="${fn:length(SVC2_SPLIT) > 1 }">
												${cha:svc2Name(SVC2_SPLIT[0])} 외 [${fn:length(SVC2_SPLIT)-1}]
											</c:when>
											<c:otherwise>${cha:svc2Name(item.SM_SVC2)}</c:otherwise>
										</c:choose>
									</td>
									<td>
										<span onClick="popLayer('${item.SM_MEMPNO }');" title="${item.SM_MNAME }" style="cursor:hand;">${item.SM_MNAME }</span>
									</td>
									<td class="ref-td">
										<fmt:parseDate value="${item.SM_WDATE}" var="dateFmt" pattern="yyyy-MM-dd" />
										<fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/>
									</td>
									<td class="like-td">
										<c:out value="${item.SCT_RDATE eq '' || item.SCT_RDATE eq null ? '' : item.SCT_RDATE }" />
									</td>
									<td>${cha:codeStatus(item.SM_LSTATE) }</td>
								</tr>
						</c:forEach>
						<c:if test="${fn:length(contentsList) == 0}">
			              	<tr>
			              		<td colspan="7">검색 결과가 없습니다</td>
			              	</tr>
			            </c:if>
					</tbody>
				</table>
			</div>
			</form>
			<c:import url="/resource/common/include/paging.jsp" />
			<c:if test="${sessionScope.SESS_SERVICE_ADMIN_INFO >= 1 }">
			<div  class="filebox">
				<label class="imgSty">
					<img alt="" src="/resource/images/icon_exel.png" style="width: 20%"> 처리내용 다운로드
				</label>
			</div>
			</c:if>
		</div>
		<!--content end-->
	</div>
</div>


<!-- ### INNER CONTENT END ### -->
<script language="JavaScript" src="/resource/common/js/layer_ctrl_new.js"></script>
<div id="infobox" style="left:0; top:0; z-index:999; visibility: hidden; position: absolute;" onMouseOver="overdiv=1;" onMouseOut="overdiv=0; setTimeout('hideLayer()',200);">
   <TABLE cellpadding=0 cellspacing=0 border=0>
   <TR>
    <TD valign=top><img src="http://serv.kepco.co.kr/USER_INFO/icon/01.gif"></TD>
    <TD><iframe name="user_info" src="#" width=258 height=140 allowTransparency='true' frameborder=0></iframe></TD>
   </TR>
   </TABLE>
</div>
<script type="text/javascript">
var items=[];
$(document).ready(function() {
	load_fnc('2', '0', '0'); //menu script
	$("#SM_WDATE_FROM").datepicker();
	$("#SM_WDATE_TO").datepicker();
	
	$('input[name="chkSearch"]:checked').each(function(){
		if($(this).attr('id') != 'all'){
			items.push($(this).val());
		}
	});
	
	/* 체크박스 검색 */
	$("input[name='chkSearch']").on("click", function (){
		if($(this).is(':checked')){
			if($(this).attr('id') == 'all'){
				$(this).prop("checked", true);
				$("input[name='chkSearch']").not(':eq(0)').prop('checked',false);
			}else{
				if($("input[name='chkSearch']:checked").not(0).length == 5){
					$('#all').prop("checked", true);
					$("input[name='chkSearch']").not(':eq(0)').prop('checked',false);
					items=[];
				}else{
					$('#all').prop("checked", false);
					items.push($(this).val());
				}
			}
		}else{
			var delidx = items.indexOf($(this).val());
			items.splice(delidx, 1);
			//items.pop($(this).val());
		}
	})

});

/* List 다운로드 엑셀*/
$(".imgSty").on("click", function (){
	$("#frm").attr("action", "/contentsExcelDown.do");
	$("#frm").attr("onSubmit", "");
	$("#frm").submit();
	$("#frm").attr("onSubmit", "return false;");
})

//검색
function btnSearFrm() {
    if (document.frm.SM_WDATE_TO.value < document.frm.SM_WDATE_FROM.value) {
        alert("조건의 시작일이 종료일보다 작을 수 없습니다.");
        document.frm.SM_WDATE_TO.focus();
        return false;
    }
	var tmp = items.join(',');
	$("#s3").val(tmp);
    funFrmPagingSubmit();
    return true;
}

function doDetail(seq){
	$("#SHSEQNUM").val(seq);
	$("#frm").attr("action", "/contentsDetail.do");
	$("#frm").attr("onSubmit", "");
	$("#frm").submit();
	$("#frm").attr("onSubmit", "return false;");
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />