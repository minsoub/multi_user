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
				<c:param name="left_depth_1" value="2"></c:param>
				<c:param name="left_depth_2" value="6"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub2_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;컨텐츠제작&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">이용동의 관리</b>
				</div>
				<div class="nav-title">이용동의 목록</div>
			</div>
			
			<form id="frm" name="frm" method="post" onSubmit="return false;" onkeypress="javascript:if(event.keyCode == 13){btnSearFrm()}">
            <input type="hidden" id="AC_SEQ" name="AC_SEQ" value="0">
            <input type="hidden" id="mode"  name="mode" value="0"/>
			<input type="hidden" name="pageNo" id="pageNo"  value="${paging.pageNo }"/>
			<div class="searchArea_con">
			</div>
			
			<div class="searchArea_con">
					<fieldset>
					<div class="search-box">		
						<div class="form-group">
							<legend>검색영역</legend>
							<c:set var="fdate" value="${paging.SM_WDATE_FROM }" />
							<input type="text" name="SM_WDATE_FROM" id="SM_WDATE_FROM" readonly="readonly" value='<c:out value="${fdate }" />' 
                            style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
							~
							<input type="text" name="SM_WDATE_TO" id="SM_WDATE_TO" readonly="readonly" value="${paging.SM_WDATE_TO}"
                            style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
							
							<input type="text" title="검색바" id="s4" name="s4" value="${paging.s4 }" style="width: 185px;height:15px;margin-left: 7px;font-size:12px;color:#666;" placeholder="제목">
							<input type="button" style="cursor: pointer;" class="search_btn" onclick="javascript:btnSearFrm();" value="검색">
						</div>
					</div>
					</fieldset>
			</div>
			
			<div class="basic-list">
				<table id="listTable" summary="">
						<caption>게시판 테이블</caption>
						<colgroup>
							<col style="width: 5%">
							<col style="/">
							<col style="width: 15%">
							<col style="width: 15%">
							<col style="width: 10%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="no-td">번호</th>
								<th scope="col" >제목</th>
								<th scope="col" >등록자</th>
								<th scope="col" >등록일</th>
								<th scope="col" >상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${acceptList }" var="listResult" varStatus="status">
								<tr>
									<td>${totalCnt - (paging.perPageCnt*(paging.pageNo-1)) - status.index } </td>
									<td onclick="javascript:update(${listResult.AC_SEQ});" style="cursor: pointer;">${listResult.AC_TITLE }</td>
									<td>${listResult.AC_REG_NAME }</td>
									<td>${listResult.AC_REG_DATE }</td>
									<td>${listResult.AC_STATUS == 'H' ? '미선택' : '선택'}</td>
								</tr>
							</c:forEach>
						</tbody>
						<c:if test="${acceptList.size() eq 0 }">
							<tr><td colspan="5">검색 결과가 없습니다.</td></tr>
						</c:if>
					</table>
			</div>
			<c:import url="/resource/common/include/paging.jsp" />
			</form>
			<div class="btn-zone">
				<ul>
					<li><input type="button" name="srchDescription" class="admin_btn" onclick="javascript:window.location='/acceptWrite.do';" value="등록"></li>
				</ul>
			</div>
		</div>
		<!--content end-->
	</div>
</div>

<form id="FormDetail" name="FormDetail" action="/contentsDetail.do" method="post">
</form>


<script type="text/javascript">
$(document).ready(function() {
	load_fnc('2', '0', '0'); //menu script
	 $('#SM_WDATE_FROM').datepicker({
			dateFormat: "yy-mm-dd",
			onClose: function( selectedDate ) {
				// 시작일(fromDate) datepicker가 닫힐때
				// 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
				$("#SM_WDATE_TO").datepicker( "option", "minDate", selectedDate );
			}
		 });
		 
		//종료일
		$('#SM_WDATE_TO').datepicker({
			dateFormat: "yy-mm-dd",
			onClose: function( selectedDate ) {
				// 종료일(toDate) datepicker가 닫힐때
				// 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정
				$("#SM_WDATE_FROM").datepicker( "option", "maxDate", selectedDate );
			}
		});
});

//검색
function btnSearFrm() {
    /* 
	// 날짜 형식
    var today = new Date()
    thismonth = today.getMonth() + 1;
    thisyear = today.getFullYear();
    thisday = today.getDate();

    thismonth = "" + thismonth;
    if (thismonth.length == 1) {
        thismonth = "0" + thismonth;
    }
    thisday = "" + thisday;
    if (thisday.length == 1) {
        thisday = "0" + thisday;
    }
    // 오늘일시(200802141102)
    var strToday = thisyear + "-" + thismonth + "-"
            + thisday;
    var SM_WDATE_FROM = document.frm.SM_WDATE_FROM.value;
    var SM_WDATE_TO = document.frm.SM_WDATE_TO.value;
    if (SM_WDATE_FROM !== "" || SM_WDATE_FROM == "") {
        // 시작일자
        if (CheckStr(SM_WDATE_FROM, " ", "") == 0
                || document.frm.SM_WDATE_FROM.value.length < 10
                || document.frm.SM_WDATE_FROM.value.indexOf("-") == -1) {
            alert("시작일자를 날짜 형식으로 입력 하십시오.\n\n( 예 : "
                    + strToday + " )");
            document.frm.SM_WDATE_FROM.focus();
            return false;
        }
    }
    // 게시종료일시
    if (CheckStr(SM_WDATE_TO, " ", "") == 0
            || document.frm.SM_WDATE_TO.value.length < 10
            || document.frm.SM_WDATE_TO.value.indexOf("-") == -1) {
        alert("종료일자를 날짜 형식으로 입력 하십시오.\n\n( 예 : " + strToday
                + " )");
        document.frm.SM_WDATE_TO.focus();
        return false;
    }
     */
    if (document.frm.SM_WDATE_TO.value < document.frm.SM_WDATE_FROM.value) {
        alert("조건의 시작일이 종료일보다 작을 수 없습니다.");
        document.frm.SM_WDATE_TO.focus();
        return false;
    }
    funFrmPagingSubmit();
    return true;
}

function update(id){
	$("#AC_SEQ").val(id);
	var f = document.frm;
	f.action = "/acceptUpdate.do";
	f.submit();
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />