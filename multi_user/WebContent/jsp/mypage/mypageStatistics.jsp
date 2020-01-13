<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />
<c:set value="2" var="left_depth_1"></c:set>
<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="4"></c:param>
				<c:param name="left_depth_2" value="4"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub4_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;마이페이지&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">이용현황 통계</b>
				</div>
				<div class="nav-title">이용현황 통계</div>
			</div>

            <form id="frm" name="frm" method="post"
                onSubmit="return false;">
                <div class="searchArea_con">
                    <fieldset>
                        <div class="search-box">
                            <div class="form-group">
                                <legend>검색영역</legend>
                                <span style="font-weight: bold;color: RGB(5,61,99)">조회기간</span>
                                <input type="text" readonly
                                    name="SM_WDATE_FROM" id="s1"
                                    value="${paging.SM_WDATE_FROM}"
                                    style="width: 140px;height:15px; margin-left:8px; margin-right: 3px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">부터
                                <input type="text" readonly
                                    name="SM_WDATE_TO" id="s2"
                                    value="${paging.SM_WDATE_TO}"
                                    style="width: 140px;height:15px; margin-left:3px; background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;"> 
                                <input
                                    type="button"
                                    name="srchDescription"
                                    class="search_btn"
                                    onclick="javascript:btnSearFrm();"
                                    style="margin-left:3px; width:58px;height:27px; cursor: pointer; vertical-align: middle;"
                                    value="검색">
                            </div>
                        </div>
                    </fieldset>
                </div>
	
    			<div class="data_table01">
					<table width="100%" border="0" class="data" cellspacing="0" cellpadding="0" style="font-size: 0.93em;">
					<caption>예선사용기준표</caption>
						<thead>
						<tr>
							<th scope="col" rowspan="2" width="18%;"></th>
							<th class="lb_b" colspan="3">컨텐츠 제작</th>
							<th class="lb_b" colspan="3">전광판 게시</th>
						</tr>
						<tr>
							<th scope="col" class="l_b">신청건</th>
							<th scope="col">취소건</th>
							<th scope="col">완료건</th>
							<th class="l_b" scope="col">신청건</th>
							<th scope="col">취소건</th>
							<th scope="col">완료건</th>
						</tr>
						</thead>
						<tbody class="ac">
                            <c:set var = "sum1" value = "0" />
                            <c:set var = "sum2" value = "0" />
                            <c:set var = "sum3" value = "0" />
                            <c:set var = "sum4" value = "0" />
                            <c:set var = "sum5" value = "0" />
                            <c:set var = "sum6" value = "0" />
                            
                            <c:forEach items="${applicationList}"
                                var="item" varStatus="status">
    							<tr>
    							<td scope="row" style="font-size: 0.98em;font-weight: 500;">
                                    <fmt:parseDate value="${item.YR}${item.MTH}"
                                    var="YR_MTH" pattern="yyyyMM" />
                                    <fmt:formatDate
                                                value="${YR_MTH}"
                                                pattern="yyyy년 MM월" />
                                </td>
                                
    							<td style="font-weight: 600;" class="l_b"><p class="t_1">${item.CNT1}</p></td>
                                <c:set var= "sum1" value="${sum1 + item.CNT1}"/>
                                
    							<td style="font-weight: 600;">${item.CNT2}</td>
                                <c:set var= "sum2" value="${sum2 + item.CNT2}"/>
                                
    							<td style="font-weight: 600;"><p class="t_2">${item.CNT3}</p></td>
                                <c:set var= "sum3" value="${sum3 + item.CNT3}"/>
                                
    							<td style="font-weight: 600;" class="l_b"><p class="t_1">${item.CNT4}</p></td>
                                <c:set var= "sum4" value="${sum4 + item.CNT4}"/>     
                                
    							<td style="font-weight: 600;">${item.CNT5}</td>
                                <c:set var= "sum5" value="${sum5 + item.CNT5}"/>
                                
    							<td style="font-weight: 600;"><p class="t_2">${item.CNT6}</p></td>
                                <c:set var= "sum6" value="${sum6 + item.CNT6}"/>
    							</tr>
                            </c:forEach>
							<c:if test="${fn:length(applicationList) == 0}">
	                             <tr>
	                                 <td colspan="7">검색 결과가 없습니다</td>
	                             </tr>
                        	</c:if>
						
    						<tr>
    						<td class="b_b" scope="row">합계</td>
    						<td class="b_b l_b" style="font-size: 0.98em;font-weight: 600;"><p class="tb_1"><c:out value="${sum1}"/></p></td>
    						<td class="b_b" style="font-size: 0.98em;font-weight: 600;"><font style="font-size: 15px;"><c:out value="${sum2}"/></font></td>
    						<td class="b_b" style="font-size: 0.98em;font-weight: 600;"><p class="tb_2"><c:out value="${sum3}"/></p></td>
    						<td class="b_b l_b" style="font-size: 0.98em;font-weight: 600;"><p class="tb_1"><c:out value="${sum4}"/></p></td>
    						<td class="b_b" style="font-size: 0.98em;font-weight: 600;"><font style="font-size: 15px;"><c:out value="${sum5}"/></font></td>
    						<td class="b_b" style="font-size: 0.98em;font-weight: 600;"><p class="tb_2"><c:out value="${sum6}"/></p></td>
    						</tr>          
						</tbody>
					</table>
    			</div>
            </form>
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('7', '0', '0'); //menu script
    $("#s1").datepicker();
    $("#s2").datepicker();
});

// 검색
function btnSearFrm() {
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
    var s1 = document.frm.s1.value;
    var s2 = document.frm.s2.value;
    if (s1 !== "" || s1 == "") {
        // 시작일자
        if (CheckStr(s1, " ", "") == 0
                || document.frm.s1.value.length < 10
                || document.frm.s1.value.indexOf("-") == -1) {
            alert("시작일자를 날짜 형식으로 입력 하십시오.\n\n( 예 : "
                    + strToday + " )");
            document.frm.s1.focus();
            return false;
        }
    }
    // 게시종료일시
    if (CheckStr(s2, " ", "") == 0
            || document.frm.s2.value.length < 10
            || document.frm.s2.value.indexOf("-") == -1) {
        alert("종료일자를 날짜 형식으로 입력 하십시오.\n\n( 예 : " + strToday
                + " )");
        document.frm.s2.focus();
        return false;
    }
    if (document.frm.s2.value < document.frm.s1.value) {
        alert("조건의 시작일이 종료일보다 작을 수 없습니다.");
        document.frm.s2.focus();
        return false;
    }
    funGoPageDetail(document.location);
    return true;
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />