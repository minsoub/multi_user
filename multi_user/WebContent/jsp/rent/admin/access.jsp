<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<script language="javascript">
$(document).ready(function() {
    $("#sch_strdt, #sch_enddt").datepicker();
});

function accessList(code, mode){
    var frm = document.frm;

    var strdt = $("#sch_strdt").val();
    var enddt = $("#sch_enddt").val();

    if( (strdt && !enddt) || (!strdt && enddt) )
    {
        alert('날짜를 모두 선택하세요.');
        return false;
    }
    if(strdt > enddt)
    {
        alert('검색날짜를 다시 선택하세요.');
        return false;
    }
    frm.submit();
};
	
</script>
<body>
    <div class="topMenu-bg-img-sub"></div>
    <c:import url="/resource/common/include/topMenu.jsp" />
    <c:set value="2" var="left_depth_1"/>

    <c:set var="empno" value="${sessionScope.SESS_EMPNO }"/>
    <c:set var="userNm" value="${sessionScope.SESS_USER_NAME }"/>

    <c:set var="telno" value="${sessionScope.SESS_USER_INFO['telno'] }"/>
    <c:set var="mailno" value="${sessionScope.SESS_USER_INFO['mailno'] }"/>

    <div id="contents" class="learn-frame-area">
        <div class="contents-framebox" id="contents_id">
            <!-- leftmenu -->
            <div class="contents-header-framebox">
                <div class="learn-tit-framebox">
                    <c:import url="/resource/common/include/leftMenu_01.jsp">
                        <c:param name="left_depth_1" value="8"></c:param>
                        <c:param name="left_depth_2" value="5"></c:param>
                        <c:param name="left_depth_3" value="6"></c:param>
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
                    <div class="nav-title">출입대장관리</div>
                </div>
                <form id="frm" name="frm" method="get" action="/admin/access.do" onSubmit="return false;">
                <div class="searchArea_con" style="width:1000px;">
                    <fieldset>
                    <div class="search-box">
                        <div class="form-group">
                            <legend>검색영역</legend>
                            <input type="text" name="sch_strdt" id="sch_strdt" readonly value='${sch_strdt}'
                            style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
                            ~
                            <input type="text" name="sch_enddt" id="sch_enddt" readonly value="${sch_enddt}"
                            style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
                            <input type="button" style="cursor: pointer;" onclick="javascript:accessList();" class="search_btn" value="검색">
                        </div>
                    </div>
                    </fieldset>
            	</div>
				<div class="basic-list2" style="margin-top:5px;">
	                <table id="listTable" summary="">
	                    <caption>출입대장</caption>
	                    <colgroup>
	                        <col style="width:10%">
	                        <col style="width:10%">
	                        <col style="width:50%">
	                        <col style="width:30%">
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th scope="col">출입일자</th>
	                            <th scope="col">출입 및 퇴실 시간</th>
	                            <th scope="col">용무</th>
	                            <th scope="col">출입자 정보</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:forEach var="accessList" items="${accessList}" varStatus="x">
	                        <tr>
	                            <td>${fn:substring(accessList.REGDT,0,10)}</td>
	                            <td>${fn:substring(accessList.REGDT,11,19)}</td>
	                            <td>${accessList.ACCUSEOBJ}</td>
	                            <td>${accessList.ACCSS} ${accessList.ACCENM}</td>
	                        </tr>
	                        </c:forEach>
	                        <c:if test="${fn:length(accessList) == 0}">
	                        <tr>
	                            <td align="center" colspan="4">등록된 데이터가 없습니다.</td>
	                        </tr>
	                        </c:if>
	                    </tbody>
	                </table>
            	</div>
            	</form>
            </div>
            <!--content end-->
        </div>
    </div>

    <div class="popup_view_box view1" id="apDiv" style="display:none;">
    </div>
</body>

<script type="text/javascript">
    </script>
<c:import url="/resource/common/include/bottom.jsp" />