<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<body>
    <div class="topMenu-bg-img-sub"></div>
    <c:import url="/resource/common/include/topMenu.jsp" />
    <c:set value="2" var="left_depth_1"/>

    <div id="contents" class="learn-frame-area">
        <div class="contents-framebox" id="contents_id">
            <!-- leftmenu -->
            <div class="contents-header-framebox">
                <div class="learn-tit-framebox">
                    <c:import url="/resource/common/include/leftMenu_01.jsp">
                        <c:param name="left_depth_1" value="8"></c:param>
                        <c:param name="left_depth_2" value="5"></c:param>
                        <c:param name="left_depth_3" value="9"></c:param>
                    </c:import>
                </div>
            </div>
            <!-- leftmenu end-->

            <!--content-->
            <div class="contents-con-framebox">
                <div class="nav-box">
                    <div class="nav-img"><img alt="" src="/resource/images/sub/sub8_tit_img.png"></div>
                    <div class="nav-list">
                        <img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리메뉴</b>
                    </div>
                    <div class="nav-title">${fn:substring(cha:todate(dataMap.target_date, "-", "3"), 0, 7)} ${dataMap.gbcd eq '001' ? '노트북' : dataMap.gbcd eq '010' ? '태블릿' : '' }&nbsp; ${dataMap.gubun == 'long' ? '장기' : dataMap.gubun == 'short' ? '단기' : '' } 대여 ${dataMap.insban == 'ins' ? '반출' : '반납' } 대장</div>
                </div>
                
				<div id="tablelist" class="basic-list2" style="margin-top:5px;">
	                <table id="listTable" summary="">
	                    <caption>노트북 점검대장 상세</caption>
	                    <colgroup>
	                        <col style="width:4%">
	                        <col style="width:10%">
	                        <col style="width:8%">
	                        <col style="width:8%">
	                        <col style="width:16%">
	                        <col style="width:12%">
	                        <col />
	                        <col style="width:8%">
	                        <col style="width:8%">
	                        <col style="width:8%">
	                    </colgroup>
	                    <thead>
	                        <tr>
	                        	<th>no</th>
	                        	<th>신청번호</th>
	                        	<th>신청자</th>
	                        	<th>신청일</th>
	                        	<th>대여기간</th>
	                        	<th>모델명</th>
	                        	<th>배정(별칭)</th>
	                        	<th>인수일자</th>
	                        	<th>반납자</th>
	                        	<th>반납일시</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:forEach var="monthList" items="${monthList}" varStatus="x">
		                        <tr>
		                        	<td>${x.count }</td>
		                        	<td>${monthList.appnum}</td>
		                        	<td>${monthList.appenm }</td>
		                        	<td>${cha:todate(monthList.regdt, '-', '3') }</td>
		                        	<td>${cha:todate(monthList.strdt, '-', '3') } ~ ${cha:todate(monthList.enddt, '-', '3') }</td>
		                        	<td>${monthList.mdnm }</td>
		                        	<td>${monthList.eqnm } (${monthList.eqalias })</td>
		                        	<td>${cha:todate(monthList.insudt, '-', '3') }</td>
		                        	<td>${monthList.banpnm }</td>
		                        	<td>${fn:substring(monthList.banpdt, 0, 19) }</td>
		                        </tr>
	                        </c:forEach>
	                        <c:if test="${fn:length(monthList) == 0}">
	                        <tr>
	                            <td align="center" colspan="9">조회된 데이터가 없습니다.</td>
	                        </tr>
	                        </c:if>
	                    </tbody>
	                </table>
            	</div>
            	
            </div>
        </div>
    </div>

    <form id="srhFrm" name="srhFrm" method="post">
		${srhReq }
	</form>
</body>
<script language="javascript">
$(document).ready(function() {
	 load_fnc('4', '0', '0'); //menu script
});

function funList(){
	funGoPageDetailSetFrm("/admin/checkAppMonthList.do", "srhFrm");
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />