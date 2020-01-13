<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<script language="javascript">

$(document).ready(function() {
    $("#sch_strdt, #sch_enddt").datepicker();
    
    $("#checkbox_top").click(function() {
		if ($('input:checkbox[name="checkbox_top"]').is(":checked") ==  true) {
			$("input[name=chk_all]:checkbox").prop("checked", true);
		} else {
			$("input[name=chk_all]:checkbox").prop("checked", false);
		}			
	});
});

function searchLongTermUserList() {
	var f = document.frm;
	f.action = '/admin/longTermUser.do';
	f.submit(); 
};

/* function excelDownload() {
	var html = $("#tablelist").html();

    $("#fe_html").val(html);

    $("#form_ex").submit();
}; */

function fn_excel(){
	var f = document.frm;
	f.action = '/admin/longTermExcelDownload.do';
	f.submit(); 
}

function rentNotify() {	
	var _userData = [];
	$("input[name=chk_all]:checked").each(function() {			
		_userData.push($(this).val());
	});
	
	var sendSMS = false;
	if ($("#chkSMS").is(":checked")) {
		sendSMS = true;
	} else {
		sendSMS = false;
	}
	
	if (_userData.length == 0) {
		alert("알림을 보낼 사용자를 선택해 주세요!");	
		return;
	}
	
	$('#loading').fadeIn();
	
	$("#user_data").val(_userData);
	$.ajax({
		url : '/admin/longTermUserNotify.do',
		type : 'post',
        data : {'userdata': $("#user_data").val(), 'sendsms': sendSMS},
		success : function(data) {
			$('#loading').hide();
			if(data == 'OK')
			{
				alert('모든 사용자에게 알림 전송 완료 되었습니다.');
			}
		},
        error : function(request, status, error) {
        	$('#loading').hide();
        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
	}); 
}

function longTermUserNotify() {
	var _userData = [];
	$("input[name=chk_all]:checked").each(function() {			
		_userData.push($(this).val());
	});
	
	if (_userData.length == 0) {
		alert("알림을 보낼 사용자를 선택해 주세요!");	
		return;
	}
	
	$("#user_data").val(_userData);
	
	openPopup();
}


var _showPopup;
function openPopup() {
	_showPopup = window.open("/jsp/rent/admin/longTermUserPopup.jsp","_showPopup","width=500, height=400");
	_showPopup.blur();		
}
	
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
                        <c:param name="left_depth_3" value="7"></c:param>
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
                    <div class="nav-title">설비대여현황</div>
                </div>
                <!-- <form id="form_ex" name="form_ex" method="post" action="/admin/excelDownload.do">
				    <input type="hidden" id="fe_html" name="fe_html">
				</form> -->
                <form id="frm" name="frm" method="get" action="/admin/longTermUser.do" onSubmit="return false;">
                <div class="searchArea_con" style="width:1000px;">
                    <fieldset>
                    <div class="search-box">
                        <div class="form-group">
                            <legend>검색영역</legend>
                           	<!-- 대여상태 -->
                            <select name="schCode" style="width: 120px;">
                                <c:forEach var="codeList" items="${codeList}" varStatus="x">
                                <option value="${codeList.GBCD}" ${schCode == codeList.GBCD ? "selected" : ""}>${codeList.GBNM}</option>
                                </c:forEach>
                            </select>
                            <select id="schEQST" name="schEQST" style="width: 100px;">
                            	<option value="useing" ${schEQST == "useing" ? "selected" : ""}>사용가능</option>
                            	<option value="trouble" ${schEQST == "trouble" ? "selected" : ""}>고장</option>
                            	<option value="repair" ${schEQST == "repair" ? "selected" : ""}>수리중</option>
                            	<option value="disuse" ${schEQST == "disuse" ? "selected" : ""}>폐기</option>
                            	<option value="Terminate" ${schEQST == "Terminate" ? "selected" : ""}>해지</option>
                            	<option value="Store" ${schEQST == "Store" ? "selected" : ""}>임시보관</option>
                            </select>
                            <select id="schStatus" name="schStatus" style="width: 120px;">
                            	<option value="all" ${schStatus == "all" ? "selected" : ""}>전체</option>
                            	<option value="longNShort" ${schStatus == "longNShort" ? "selected" : ""}>장기+단기대여</option>
                            	<option value="long" ${schStatus == "long" ? "selected" : ""}>장기대여</option>
                            	<option value="short" ${schStatus == "short" ? "selected" : ""}>단기대여</option>
                            	<option value="available" ${schStatus == "available" ? "selected" : ""}>대여가능</option>
                            	<option value="expected" ${schStatus == "expected" ? "selected" : ""}>대여예정</option>
                            	<option value="unreturn" ${schStatus == "unreturn" ? "selected" : ""}>미반납</option>
                            </select>
                            <select name="schOrder" style="width: 100px;">
                            	<optgroup label="정렬기준">
	                            	<option value="MDNM" ${schOrder == "MDNM" ? "selected" : ""}>모델명</option>
	                            	<option value="EQALIAS" ${schOrder == "EQALIAS" ? "selected" : ""}>관리번호</option>
	                            	<option value="ENDDT" ${schOrder == "ENDDT" ? "selected" : ""}>반납일</option>
	                            </optgroup>
                            </select>
                            <img src="/resource/images/btn/qMark.png" style="margin-left: 8px;" title="신청자 OR 사용자 OR 부서명 OR 모델명">
                            <input type="text" id="schText" name="schText" value="${schText}" style="width: 158px;height:15px;font-size:12px;color:#666;" placeholder="검색어를 입력하세요." onkeydown="javascript:if(event.keyCode == 13){searchLongTermUserList(); return false;}">
                            <input type="button" style="cursor: pointer;" onclick="javascript:searchLongTermUserList();" class="search_btn" value="검색">
                            <input type="button" style="cursor: pointer; width: 70px;" onclick="javascript:fn_excel();" class="search_btn" value="엑셀저장">
                            <!-- input type="button" style="cursor: pointer; width: 165px;" onclick="javascript:longTermUserNotify();" class="search_btn" value="사용자 알림(문자, 이메일)"-->
                            <input type="button" style="cursor: pointer; width: 70px;" onclick="javascript:rentNotify();" class="search_btn" value="대여알림">
                            &nbsp;<input type="checkbox" name="chkSMS" id="chkSMS" value="true" checked />&nbsp;SMS
                        </div>
                    </div>
                    </fieldset>
            	</div>
            		<c:if test="${schCode == '001' || schCode == '018' || schCode == '010' }">
            			<c:set var="width" value="1200"></c:set>
            		</c:if>
            		<c:if test="${schCode == '021' }">
            			<c:set var="width" value="1300"></c:set>
            		</c:if>
            		
				<div id="tablelist" class="basic-list2" style="margin-top:5px;width:${width}px;">
	                <table id="listTable" summary="">
	                    <caption>설비대여현황</caption>
	                    <colgroup>
	                        <col style="width:2%">
	                        <col style="width:3%">
	                        <col style="width:6%">
	                        <c:if test="${schCode == '001'|| schCode == '018'|| schCode == '010' || schCode == '021'}">
	                        	<col style="width:8%">
	                        	<col style="width:8%"> 
	                        </c:if>
	                        <c:if test="${schCode == '010' || schCode == '021'}">
	                        	<col style="width:8%">
	                        </c:if>
	                        <col style="width:8%">
	                        <col style="width:15%">
	                        <col style="width:15%">
	                        <c:if test="${schCode == '001'|| schCode == '018'|| schCode == '021'}">
	                        	<col style="width:15%">
	                        </c:if>
                        	<col style="width:11%">
	                        <col style="width:15%">
	                        <col style="width:8%">
	                        <col style="width:15%">
	                        <col style="width:8%">
	                        <col style="width:8%">
	                        <col style="width:8%">
	                        <col style="width:15%">
	                    </colgroup>
	                    <thead>
	                        <tr>
	                        	<th rowspan="2" scope="col"><input type="checkbox" id="checkbox_top" name="checkbox_top" /></th>
	                            <th rowspan="2" scope="col">순번</th>
	                            <th rowspan="2" scope="col">구분</th>
	                            <c:if test="${schCode == '001' || schCode == '018' || schCode == '010' || schCode == '021'}">
									<th rowspan="2" scope="col">제조일</th>
	                            	<th rowspan="2" scope="col">등록일</th>
	                            </c:if>
	                            <th rowspan="2" scope="col">제조사</th>
	                            <c:if test="${schCode == '010' || schCode == '021'}">
	                            	<th rowspan="2" scope="col">통신사</th>
	                            </c:if>
	                            <th rowspan="2" scope="col">모델명</th>
	                            <th rowspan="2" scope="col">관리번호</th>
	                            <c:if test="${schCode == '001' || schCode == '018' || schCode == '021' }">
	                            	<c:if test="${schCode == '021' }">
	                            		<th rowspan="2" scope="col">유심번호</th>
	                            	</c:if>
	                            	<c:if test="${schCode != '021' }">
	                            		<th rowspan="2" scope="col">자산번호</th>
	                            	</c:if>
	                            </c:if>
                            	<th rowspan="2" scope="col">설비고유번호</th>
	                            <th scope="col" colspan="2">신청자 정보</th>
	                            <th scope="col" colspan="2">사용자 정보</th>
	                            <c:if test="${schStatus == 'available'}">
									<th rowspan="2" scope="col">대여예정일자</th>
	                            	<th rowspan="2" scope="col">반납예정일자</th>
	                            </c:if>
	                            <c:if test="${schStatus != 'available'}">
									<th rowspan="2" scope="col">대여일자</th>
	                            	<th rowspan="2" scope="col">반납일자</th>
	                            </c:if>
                            	<th rowspan="2" scope="col">대여부서</th>
	                        </tr>
	                        <tr>
	                        	<th scope="col">부서명</th>
	                        	<th scope="col">사번<br />이름</th>
	                        	<th scope="col">부서명</th>
	                        	<th scope="col">사번<br />이름</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:forEach var="longTermUserList" items="${longTermUserList}" varStatus="status">
	                        <tr>
	                        	<td onclick="event.cancelBubble=true;" style="cursor:default;" ​><input type="checkbox" name="chk_all" id="chk_${longTermUserList.NUM}" value="${longTermUserList.APPNO}" /></td>
	                            <td>${status.index+1}</td>
	                            <c:choose>
	                            	<c:when test="${longTermUserList.EQMST eq '2'}">
	                            		<td class="bg_s01" >${longTermUserList.EQMSTNM }</td>
	                            	</c:when>
	                            	<c:when test="${longTermUserList.EQMST eq '3'}">
	                            		<td class="bg_02" >${longTermUserList.EQMSTNM }</td>
	                            	</c:when>
	                            	<c:when test="${longTermUserList.EQMST eq '4'}">
	                            		<td class="bg_02" >${longTermUserList.EQMSTNM }</td>
	                            	</c:when>
	                            	<c:when test="${longTermUserList.EQMST eq '5'}">
	                            		<td class="bg_02" >${longTermUserList.EQMSTNM }</td>
	                            	</c:when>
	                            	<c:when test="${longTermUserList.STATUSNM eq '0'}">
	                            		<td class="bg_s01" >대여<br />가능</td>
	                            	</c:when>
	                            	<c:when test="${longTermUserList.STATUSNM eq '3'}">
	                            		<td class="bg_s01"  >대여<br />예정</td>
	                            	</c:when>
	                            	<c:when test="${longTermUserList.STATUSNM eq '4'}">
	                            		<td class="bg_s03" >단기<br />대여</td>
	                            	</c:when>
	                            	<c:when test="${longTermUserList.STATUSNM eq '5'}">
	                            		<td class="bg_s02" >장기<br />대여</td>
	                            	</c:when>
                            		<c:when test="${longTermUserList.STATUSNM eq '2'}">
                            		<td class="bg_s04"  >미반납</td>
	                            	</c:when>
	                            	<c:otherwise>
	                            		<td bgcolor="lightgray" >error</td>
	                            	</c:otherwise>
	                            </c:choose>
	                            <c:if test="${schCode == '001' || schCode == '018' ||  schCode == '010' || schCode == '021'}">
	                            	<td>${longTermUserList.EQCDT }</td>
	                            	<td>${longTermUserList.EQRDT }</td>
	                            </c:if>
	                            <td>${longTermUserList.GBNM}</td>
	                            <c:if test="${schCode == '010' || schCode == '021' }">
	                            	<td>${longTermUserList.ETC2}</td>
	                            </c:if>
	                            <td><a href="javascript:void(0);" onclick="javascript:funDetailPop('${longTermUserList.EQNO}');" >${longTermUserList.MDNM}</a></td>
	                            <td>${longTermUserList.EQALIAS}</td>
	                            <c:if test="${schCode == '001' || schCode == '018' || schCode == '021'}">
	                            	<td>${longTermUserList.EQASSETSNO}</td>
	                            </c:if>
                            	<td style="word-wrap:break-word" >${longTermUserList.EQSN }</td>
	                            <td>${longTermUserList.APPSS}</td>
	                            <td>${longTermUserList.APPENO}<br />${longTermUserList.APPENM}</td>
	                            <td>${longTermUserList.APPE_DEPTNM}</td>
	                            <td>${longTermUserList.APPUENO}<br />${longTermUserList.APPUENM}</td>
	                            <td>${longTermUserList.STRDT}</td>
	                            <td>${longTermUserList.ENDDT}</td>
	                            <td>${longTermUserList.DEPT1NM}</td>
	                        </tr>
	                        </c:forEach>
	                        <c:if test="${fn:length(longTermUserList) == 0}">
	                        <tr>
	                        	<c:if test="${schCode != '001' }">
	                            	<td align="center" colspan="15">등록된 데이터가 없습니다.</td>
	                            </c:if>
	                            <c:if test="${schCode == '001' }">
	                            	<td align="center" colspan="18">등록된 데이터가 없습니다.</td>
	                            </c:if>
	                        </tr>
	                        </c:if>
	                    </tbody>
	                </table>
            	</div>
            	</form>
            </div>
            <input type="hidden" id="user_data" name="user_data">
            <input type="hidden" id="user_appno" name="user_appno">
            <!--content end-->
            <div id="loading" style="display:none; position:absolute; left:150px; top:450px; text-align:center; width:100%; z-index:9999"><img src="/resource/images/pre-loader.gif" /></div>
        </div>
    </div>

    <div class="popup_view_box view1" id="apDiv" style="display:none;">
    </div>
</body>

<script type="text/javascript">
$(document).ready(function() {
    load_fnc('4', '0', '0'); //menu script
});

function funDetailPop(eqno) {
	var popWin = window.open('about:blank', 'equip_detail_pop', 'scrollbars=1, resizable=1, width=1050px, height=1050px');
	
	popWin.location.href = "/admin/equipRegist.do?pageGubun=Pop&gbcd=" + '${schCode}' + '&eqno=' + eqno;
	
}

</script>
<c:import url="/resource/common/include/bottom.jsp" />



