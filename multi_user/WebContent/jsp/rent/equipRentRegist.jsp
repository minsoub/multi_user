<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<style>
	.imgSty{
	float: left;
	width: 17%;
}
</style>
<body>
    <div class="topMenu-bg-img-sub"></div>
    <c:import url="/resource/common/include/topMenu.jsp" />
    <c:set value="2" var="left_depth_1"/>

    <c:set var="empno" value="${sessionScope.SESS_EMPNO }"/>
    <c:set var="userNm" value="${sessionScope.SESS_USER_NAME }"/>
	<c:set var="deptno" value="${sessionScope.SESS_USER_INFO['deptno'] }" />
    <c:set var="telno" value="${sessionScope.SESS_USER_INFO['telno'] }"/>
    <c:set var="mailno" value="${sessionScope.SESS_USER_INFO['mailno'] }"/>

    <div id="contents" class="learn-frame-area">
        <div class="contents-framebox" id="contents_id">
            <!-- leftmenu -->
            <div class="contents-header-framebox">
                <div class="learn-tit-framebox">
                    <c:import url="/resource/common/include/leftMenu_01.jsp">
                        <c:param name="left_depth_1" value="3"></c:param>
                        <c:param name="left_depth_2" value="2"></c:param>
                    </c:import>
                </div>
            </div>
            <!-- leftmenu end-->

            <!--content-->
            <div class="contents-con-framebox">
                <div class="nav-box" style="height: auto;">
                    <div class="nav-img"><img alt="" src="./resource/images/sub/sub8_tit_img.png"></div>
                    <div class="nav-list">
                        <img alt="" src="./resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">설비현황</b>
                    </div>
                    <div class="nav-title">설비현황</div>
                </div>

				<!-- 
				<div class="desc">
					<h3>▢ 유의사항</h3>
					<p>○ 회사 자산을 소중히 다뤄 주시고, 분실․파손시 해당 부서 및 사용자에게 책임이 있사오니 유의하시기 바랍니다.</p>
					<p>○ 대여기간 만료 또는 보직변경 시 반납 원칙을 필히 지켜주시기 바랍니다.</p>
				</div>
				 -->
				<div class="desc ca2" style="font-size: 11px;">
					<h3>▢ 해외출장 시 유의사항</h3>
					<p>[출국 前]<br>
					- 소프트웨어, 앱을 최신버전으로 유지하고, 백신 프로그램 사용<br>
					- 중요한 데이터와 사진은 미리 백업하고 비공식 출처로부터 앱 다운로드 금지<br>
					- 영화, 책 등을 원할 경우 미리 다운로드<br><br>
					</p>
					<p>[체류 中]<br>
					- 공공, 호텔 무선망 사용자제<br>
					- 개인기기는 타인과 공유하지 말고, 특히 USB 등 IT제품을 선물 받을 경우 사용금지<br>
					- 태블릿, 노트북 등은 항상 본인이 휴대<br>
					</p>
				</div>
				
                <div class="sub-nav-title">장비신청</div>

                <div class="basic-list">
                <form id="reg_form" name="reg_form" action="/equipRentUpdate.do" method="post" onsubmit="return check();" enctype="multipart/form-data">
                    <!-- 신청자 -->
                    <input type="hidden" name="appeno" value="${empno}" />
                    <input type="hidden" name="appenm" value="${userNm}" />
                    <input type="hidden" name="appss" value="${deptName}" />
                    <input type="hidden" name="bsknoArr" value="${bsknoArr}" />
                    <input type="hidden" id="gbnm" name="gbnm"/>
                    <input type="hidden" id="mdnm" name="mdnm" />

                    <!-- 검토결재자 정보 -->
                    <input type="hidden" name="sign1Empno" value="" />
                    <input type="hidden" name="sign1Sosok" value="" />
                    <input type="hidden" name="sign1UserName" value="" />
                    <input type="hidden" name="sign1PosName" value="" />

                    <!-- 결정결재자 정보 -->
                    <input type="hidden" name="sign2Empno" value="" />
                    <input type="hidden" name="sign2Sosok" value="" />
                    <input type="hidden" name="sign2UserName" value="" />
                    <input type="hidden" name="sign2PosName" value="" />
                    <input type="hidden" name="gbcdChk" id="gbcdChk" value="" />

                    <div class="insrtfrom-framebox">
                    <div class="insert-step1-box">
                        <div class="form-step1">
                            <fieldset>
                            <legend>장비신청</legend>
                                <div class="row-group">

                                    <dl class="insert_ready">
                                        <dt class="must-option">
                                            <label>신청부서</label>
                                        </dt>
                                        <dd style="width: 260px;">
                                            <label>${deptName}</label>
                                        </dd>
                                        <dt class="must-option">
                                            <label>신청자</label>
                                        </dt>
                                        <dd style="width: 188px;">
                                            <label>${userNm}</label>
                                        </dd>
                                    </dl>
                                    <dl class="insert_ready">
                                        <dt class="must-option">
                                            <label>연락처</label>
                                        </dt>
                                        <dd style="width: 260px;">
                                            <input type="text" id="apptel" name="apptel" title="" placeholder="" value="${telno }">
                                        </dd>
                                        <dt class="must-option">
                                            <label>E-MAIL</label>
                                        </dt>
                                        <dd style="width: 188px;">
                                            <input type="text" id="appmail" name="appmail" title="" placeholder="" value="${mailno }@kepco.co.kr">
                                        </dd>
                                    </dl>

                                    <dl class="insert_ready">
                                        <dt class="must-option"><label for="SCT_RDATE" id="SCT_RDATE_label">신청정보</label></dt>


                                        <c:forEach var="listMap" items="${listMap }" >
                                        <c:set var="listMapVal"  value="${listMap.value }"/>
                                        <c:set var="listMapKey"  value="${listMap.key }"/>
                                        <c:set var="listStrdt"  value="${fn:substring(listMapKey, 0, 8)}"/>
                                        <c:set var="listEnddt"  value="${fn:substring(listMapKey, 9, 17)}"/>
                                        <dd class="equip_area">
                                            <div style="width:600px;">대여기간 : ${listMapKey}
                                                <c:if test="${bsknoArr eq null}">
                                                    <span style="float:right;">
                                                        <img alt="" class="cursor_pointer add_eq" src="resource/images/sub/icon_plus.png">
                                                    </span>
                                                </c:if>
                                            </div>
                                        </dd>
                                        <dd>
                                            <div class="basic-list1">
                                                <table class="table02 tbl_equip" id="tid_${listStrdt}${listEnddt}">
                                                    <colgroup>
                                                        <col style="width: 30%">
                                                        <col style="">
                                                        <col style="width: 25%">
                                                        <col style="width: 10%">
                                                    </colgroup>
                                                    <thead>
                                                        <tr>
                                                            <th scope="col" class="like-td">장비구분</th>
                                                            <th scope="col" class="like-td">모델명</th>
                                                            <th scope="col" class="like-td">사용자</th>
                                                            <th scope="col" class="ref-td">비고</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="list" items="${listMapVal }" >
                                                            <c:choose>
                                                                <c:when test="${list.amount > 1 }">
                                                                    <c:forEach var="i" begin="1" end="${list.amount}">
                                                                        <tr class="app_tr">
                                                                            <c:if test="${not empty(listMapVal)}">
                                                                                <input type="hidden" name="strdt[]" class="strdt"
                                                                                    value="${list.strdt }">
                                                                                <input type="hidden" name="enddt[]" class="enddt"
                                                                                    value="${list.enddt }">
                                                                            </c:if>
                                                                            <c:choose>
                                                                                <c:when test="${!empty bsknoArr}">
                                                                                    <input type="hidden" name="gbcd[]"
                                                                                        value="${list.gbcd }">
                                                                                    <input type="hidden" name="mdseq[]"
                                                                                        value="${list.mdseq }">
                                                                                    <%-- <input type="hidden" name="amount[]"
                                                                                        value="${list.amount }"> --%>
                                                                                    <td class="list01 gbcd">
                                                                                        ${list.gbnm}
                                                                                    </td>
                                                                                    <td class="list02 model">
                                                                                        ${list.mdnm}
                                                                                    </td>
                                                                                    <td align="center" class="list02 amount">
                                                                                        <div class="amountSel">
                                                                                            <div class="btn-zone" style="float:none">
                                                                                                <input type="hidden" name="amount[]" value="1">
                                                                                                <input type="hidden" name="appueno" class="empno_${list.mdseq}" value="${empno}" />
                                                                                                <input type="hidden" name="appuenm" class="username_${list.mdseq}" value="${userNm}" />
                                                                                                <input type="text" class="schword username_${list.mdseq}" value="${userNm}" style="width: 60px;">
                                                                                                <input type="hidden" name="deptno_arr" class="deptno_arr_${list.mdseq}" value="${deptno}" />
                                                                                                <input type="hidden" name="dept_Nm1dept_arr" class="dept_Nm1dept_arr_${list.mdseq}" value="${deptName}" />
                                                                                                <input type="button" style="cursor: pointer; height: 27px;" class="search_btn schbtn btn_${list.mdseq}" value="검색">
                                                                                            </div>
                                                                                        </div>
                                                                                    </td>
                                                                                    <td align="center" class="list02"></td>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <td class="list01 gbcd">
                                                                                        <div class="gbcdSel">
                                                                                            <p class="inputDesign">
                                                                                                <select name="gbcd[]"
                                                                                                    style="width: 150px;">
                                                                                                    <option value="">...</option>
                                                                                                    <c:forEach var="codeList" items="${codeList}">
                                                                                                        <option value="${codeList.gbcd}" ${list.gbcd eq codeList.gbcd ? "selected" : ""}>${codeList.gbnm}</option>
                                                                                                    </c:forEach>
                                                                                                </select>
                                                                                            </p>
                                                                                        </div>
                                                                                    </td>
                                                                                    <td class="like-td list02 model">
                                                                                        <div class="mdseqSel">
                                                                                            <p class="inputDesign">
                                                                                                <select name="mdseq[]"
                                                                                                    style="width: 200px;">
                                                                                                    <option value="">...</option>
                                                                                                    <c:forEach
                                                                                                        var="modelByCodeList"
                                                                                                        items="${list.modelByCodeList }">
                                                                                                        <option value="${modelByCodeList.key}" ${list.mdseq eq modelByCodeList.key ? "selected" : ""}>${modelByCodeList.value}</option>
                                                                                                    </c:forEach>
                                                                                                </select>
                                                                                            </p>
                                                                                        </div>
                                                                                    </td>
                                                                                    <td align="center" class="like-td list02 amount">
                                                                                        <div class="amountSel">
                                                                                            <div class="btn-zone" style="float:none">
                                                                                                <input type="hidden" name="amount[]" value="1">
                                                                                                <input type="hidden" name="appueno" class="empno_${list.mdseq}" value="${empno}" />
                                                                                                <input type="hidden" name="appuenm" class="username_${list.mdseq}" value="${userNm}" />
                                                                                                <input type="text" class="schword username_${list.mdseq}" value="${userNm}" style="width: 60px;">
                                                                                                <input type="hidden" name="deptno_arr" class="deptno_arr_${list.mdseq}" value="${deptno}" />
                                                                                                <input type="hidden" name="dept_Nm1dept_arr" class="dept_Nm1dept_arr_${list.mdseq}" value="${deptName}" />
                                                                                                <input type="button" style="cursor: pointer; height: 27px;" class="search_btn schbtn btn_${list.mdseq}" value="검색">
                                                                                            </div>
                                                                                        </div>
                                                                                    </td>
                                                                                    <td class="list02">
                                                                                        <img alt="" class="cursor_pointer equip_del"
                                                                                            src="resource/images/btn/del.png">
                                                                                    </td>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </c:when>
                                                                <c:when test="${list.amount == 1 }">
                                                                    <tr class="app_tr">
                                                                        <c:if test="${not empty(listMapVal)}">
                                                                            <input type="hidden" name="strdt[]" class="strdt"
                                                                                value="${list.strdt }">
                                                                            <input type="hidden" name="enddt[]" class="enddt"
                                                                                value="${list.enddt }">
                                                                        </c:if>
                                                                        <c:choose>
                                                                            <c:when test="${!empty bsknoArr}">
                                                                                <input type="hidden" name="gbcd[]" value="${list.gbcd }">
                                                                                <input type="hidden" name="mdseq[]" value="${list.mdseq }">
                                                                                <input type="hidden" name="amount[]" value="${list.amount }">
                                                                                <td class="list01 gbcd">
                                                                                    ${list.gbnm}
                                                                                </td>
                                                                                <td class="list02 model">
                                                                                    ${list.mdnm}
                                                                                </td>
                                                                                <td align="center" class="list02 amount">
                                                                                    <div class="amountSel">
                                                                                        <div class="btn-zone" style="float:none">
                                                                                            <input type="hidden" name="amount[]" value="1">
                                                                                            <input type="hidden" name="appueno" class="empno_${list.mdseq}" value="${empno}" />
                                                                                            <input type="hidden" name="appuenm" class="username_${list.mdseq}" value="${userNm}" />
                                                                                            <input type="text" class="schword username_${list.mdseq}" value="${userNm}" style="width: 60px;">
                                                                                            <input type="hidden" name="deptno_arr" class="deptno_arr_${list.mdseq}" value="${deptno}" />
                                                                                            <input type="hidden" name="dept_Nm1dept_arr" class="dept_Nm1dept_arr_${list.mdseq}" value="${deptName}" />
                                                                                            <input type="button" style="cursor: pointer; height: 27px;" class="search_btn schbtn btn_${list.mdseq}" value="검색">
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td align="center" class="list02"></td>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <td class="list01 gbcd">
                                                                                    <div class="gbcdSel">
                                                                                        <p class="inputDesign">
                                                                                            <select name="gbcd[]" style="width: 150px;">
                                                                                                <option value="">...</option>
                                                                                                <c:forEach var="codeList" items="${codeList}">
                                                                                                    <option value="${codeList.gbcd}" ${list.gbcd eq codeList.gbcd ? "selected" : ""}>${codeList.gbnm}</option>
                                                                                                </c:forEach>
                                                                                            </select>
                                                                                        </p>
                                                                                    </div>
                                                                                </td>
                                                                                <td class="like-td list02 model">
                                                                                    <div class="mdseqSel">
                                                                                        <p class="inputDesign">
                                                                                            <select name="mdseq[]" style="width: 200px;">
                                                                                                <option value="">...</option>
                                                                                                <c:forEach
                                                                                                    var="modelByCodeList"
                                                                                                    items="${list.modelByCodeList }">
                                                                                                    <option value="${modelByCodeList.key}" ${list.mdseq eq modelByCodeList.key ? "selected" : ""}>${modelByCodeList.value}</option>
                                                                                                </c:forEach>
                                                                                            </select>
                                                                                        </p>
                                                                                    </div>
                                                                                </td>
                                                                                <td align="center" class="like-td list02 amount">
                                                                                    <div class="amountSel">
                                                                                        <div class="btn-zone" style="float:none">
                                                                                            <input type="hidden" name="amount[]" value="1">
                                                                                            <input type="hidden" name="appueno" class="empno_${list.mdseq}" value="${empno}" />
                                                                                            <input type="hidden" name="appuenm" class="username_${list.mdseq}" value="${userNm}" />
                                                                                            <input type="text" class="schword username_${list.mdseq}" value="${userNm}" style="width: 60px;">
                                                                                            <input type="hidden" name="deptno_arr" class="deptno_arr_${list.mdseq}" value="${deptno}" />
                                                                                            <input type="hidden" name="dept_Nm1dept_arr" class="dept_Nm1dept_arr_${list.mdseq}" value="${deptName}" />
                                                                                            <input type="button" style="cursor: pointer; height: 27px;" class="search_btn schbtn btn_${list.mdseq}" value="검색">
                                                                                        </div>
                                                                                    </div>
                                                                                </td>
                                                                                <td class="list02">
                                                                                    <img class="cursor_pointer equip_del"
                                                                                        src="resource/images/btn/del.png">
                                                                                </td>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </tr>
                                                                </c:when>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </dd>
                                        </c:forEach>
                                    </dl>
									<dl class="insert_ready" id="changeStatus">
	                                    <dt class="must-option"><label>노트북 사용용도</label></dt>
	                                    <dd>
											<input type="radio" id="ex_chk_1" name="rent_NB_Gubun" value="<c:out value="1" />"> 
											<label for="ex_chk_1"><c:out value="업무망(사내)" /></label>
											<input type="radio" id="ex_chk_2" name="rent_NB_Gubun" value="<c:out value="2" />"> 
											<label for="ex_chk_2"><c:out value="인터넷망(사내)" /></label>
											<input type="radio" id="ex_chk_3" name="rent_NB_Gubun" value="<c:out value="3" />"> 
											<label for="ex_chk_3"><c:out value="FA망[설비운영](사내)" /></label>
											<input type="radio" id="ex_chk_4" name="rent_NB_Gubun" value="<c:out value="4" />"> 
											<label for="ex_chk_4"><c:out value="인터넷(외부)" /></label> 
	                                    </dd>
	                                </dl>
                                    <dl class="insert_ready">
                                        <dt class="must-option"><label>사용용도</label></dt>
                                        <dd><textarea class="textarea-style" style="width:618px;" rows="10" cols="88" name="useobj"></textarea></dd>
                                    </dl>
                                    <dl class="insert_ready" id="changeStatus_1">
	                                    <dt class="must-option"><label>보안서약서 업로드</label></dt>
	                                    <dd><input type="file" name="file_attach" id="file_attach" value="" style="width: 618px;"></dd>
	                                </dl>

                        </div>
                        <div  class="filebox" >
							<label class="imgSty" style="background-color: #08a0ce; font-weight: bold; color: white;">
								<img alt="" src="/resource/images/sub/btn_download.png" style="width: 20%"> 보안 서약서 다운로드
							</label>
						</div>
                        <div class="btn-zone">
                            <ul>
                                <li><input type="submit" class="search_btn" value="신청"></li>
                                <li><input type="button" class="search_btn" onclick="javascript:window.location='/equipRentList.do';" value="목록"></li>
                            </ul>
                        </div>
                    </fieldset>

                    </div>
                </div>
                </div>
                </form>
                </div>

            </div>
            <!--content end-->
        </div>
    </div>

    <div class="popup_view_box view1" id="apDiv" style="display:none;">
    </div>
    <form id="securityDownForm" name="securityDownForm" method="post" ></form>
</body>

<script type="text/javascript">
    var code1 = $('#selectCode').val();
    var modal_eq = '';
    $(document).ready(function() {
        load_fnc('4', '0', '0'); //menu script
        $("#strdt").datepicker();
        $("#enddt").datepicker();
        window.open('/equipRentPop.do','equipRentPop','width=300 height=400 scrollbars=yes');
        var searchVal = '${searchVal}';
        var searchValArr = searchVal.split(',');
        for(var i=0; i<searchValArr.length; i++ ){
            var codeVal = 'sch_' + searchValArr[i].substring(0, 6);
            var codeValReal = searchValArr[i];
            $('input:radio[name="'+codeVal+'"][value="'+codeValReal+'"]').prop('checked', true);
        }
        
        changeNB_Gubun();
    });
    $(window).load(function() {
        eventInit();

        var orderBy = $("#orderBy").val();
        if (orderBy){
            if (orderBy.substring(0, 4) == 'best') {
                $('#bestOrderBy').css('color', 'royalblue');
            } else if (orderBy.substring(0,3) == 'lch') {
                $('#lchOrderBy').css('color', 'royalblue');
            }
        }

        $('.add_eq').click(function() {
            var idx = $('.add_eq').index($(this));
            var eq_clone = $('.tbl_equip:eq('+idx+') tr.app_tr:first').clone();

            $('.tbl_equip:eq('+idx+')').append(eq_clone);
            $('.tbl_equip:eq('+idx+') .gbcd:last option').removeAttr('selected');
            $('.tbl_equip:eq('+idx+') .gbcd:last select').jqTransSelect();
            $('.tbl_equip:eq('+idx+') .model:last, .tbl_equip:eq('+idx+') .amount:last').empty();

            eventInit();
        });

        //삭제
        $('.tbl_equip').on('click', 'tr .equip_del', function(e) {

            e.preventDefault();

            if( $(this).parents('table.tbl_equip').find('tr.app_tr').length < 2 )
            {
                return false;
            }
            var key = $('.equip_del').index($(this));
            $('.app_tr').eq(key).remove();
            changeNB_Gubun();

        });


        $(".schword").keypress(function(e) {
            if(e.keyCode == 13)
            {
                var key = $('.schword').index($(this));
                $('.schbtn').eq(key).trigger('click');
                return false;
            }
        });



        //신청자, 사용자 검색
        $(document).on("click",".schbtn", function(e){
            $('#mem_list_layer').slideUp('fast').remove();
            e.preventDefault();
            
            var cls = $(this).attr('class');
            cls = cls.replace('search_btn schbtn btn_', '');
            var obj = $(this);
            var schword = obj.siblings('.schword');
            
            if( !$.trim(schword.val()) )
            {
                alert('이름/사번을 입력하여 주십시요.');
                schword.focus();
                return false;
            }

            $.ajax({
                url : '/admin/searchMember.do',
                type : 'post',
                data : { 'mode':'search_member', 'keyword':$.trim(schword.val()) },
                success : function(data) {
                    var parse_data = $.parseJSON(data).memberList;
                    var data_len = parse_data.length;
                    var arr = {};
                    arr.key = $('.schbtn').index(obj);
                    arr.cls = cls;

                    if(!data_len)
                    {
                        alert('검색된 데이터가 없습니다.');
                        $("input[name='empno'], input[name='empnm'], input[name='deptnm'], .schword").val('');
                        return false;
                    }
                    else if(data_len)
                    {
                        var html = "<div id='mem_list_layer'><table width='450'>";
                        html += "<colgroup><col width='100' /><col width='100' /><col width='300 /></colgroup>";
                        html += "<tr id='_title'><th class='titbg'>사번</th>";
                        html += "<th class='titbg'>이름</th>";
                        html += "<th class='titbg'>소속</th></tr>";

                        $.each(parse_data, function() {
                        	arr.deptno = this.deptno;
                            arr.empno = this.empno;
                            arr.name = this.name;
                            arr.dept_nm = (this.dept_nm_depth1 == '' ? this.dept_nm : this.dept_nm_depth1);

                            html += "<tr>";
                            html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData("+JSON.stringify(arr)+");'>"+this.empno+"</a></td>";
                            html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData("+JSON.stringify(arr)+");'>"+this.name+"</a></td>";
                            html += "<td class='mem_list_td'><a href='javascript:;' onclick='userSetData("+JSON.stringify(arr)+");'>"+this.dept_nm+"</a></td>";
                            html += "</tr>";
                        });

                        html += "</table></div>";
                        obj.after(html);
                        $('#mem_list_layer').slideDown();

                    }
                    else
                    {

                        alert('검색된 데이터가 없습니다.');
                        obj.siblings('input').val('');
                        if( obj.siblings().hasClass('appeno') )
                        {
                            $("input[name='appueno'], input[name='appuenm'], .schword").val('');
                            $(".appuss_area").text('');
                        }
                        return false;

                    }

                }

            }); //end of ajax
        });


    });

    function eventInit() {
        $(".gbcdSel div ul li a").off('click', gbcdSelEvent);
        $(".mdseqSel div ul li a").off('click', mdseqSelEvent);
//         $(".amountSel div ul li a").off('click', amountSelEvent);
        $(".gbcdSel div ul li a").on('click', gbcdSelEvent);
        $(".mdseqSel div ul li a").on('click', mdseqSelEvent);
//         $(".amountSel div ul li a").on('click', amountSelEvent);
    }

    function gbcdSelEvent(){

        var selbx = $(this).parent().parent().parent().children('select');
        var idx = $("select[name='gbcd[]']").index(selbx);
        var gbcd = selbx.val();
        $('.app_tr .amount').eq(idx).empty().append('');
        $('.app_tr .model').eq(idx).empty().append('');
        changeNB_Gubun();

        $.ajax({
            url : 'rentLoad.do',
            type : 'post',
            data : {'mode':'load_model', 'gbcd':gbcd},
            success : function(data) {

                var html = '';
                if(data != 'error')
                {
                    var option = $.parseJSON(data);
                    if(option.length)
                    {
                        html = '<div class="mdseqSel">';
                        html += '<p class="inputDesign">';
                        html += "<select name='mdseq[]' style='width: 200px;'><option value=''>...</option>";
                        $.each(option, function() {
                            html += "<option value='"+this.mdseq+"'>"+this.mdnm+"</option>";
                        });
                        html += "</select>";
                        html += '</p>';
                    }
                }
                $('.app_tr .model').eq(idx).empty().append(html);
                $('.inputDesign').jqTransform();
            }, complete : function(data) {
                eventInit();
            }
        });
    }

    function mdseqSelEvent(){
        var selbx = $(this).parent().parent().parent().children('select');

        var th = selbx;
        var table_id = selbx.parents('table').attr('id');
        var mdseq = selbx.val();
        var strdt = selbx.parents('tr.app_tr').find('input.strdt').val();
        var enddt = selbx.parents('tr.app_tr').find('input.enddt').val();
        var amountbx = $(this).parent().parent().parent().parent().parent().parent().parent().children('.amount');

        $.ajax({
            url : '/rentLoad.do',
            type : 'post',
            data : {'mode':'load_amount', 'mdseq':mdseq, 'strdt':strdt, 'enddt':enddt},
            success : function(data) {

                var html = '';
                
                if($("select[name='mdseq[]'] option:selected[value="+mdseq+"]").length > parseInt(data)){
                	alert("신청가능한 수량이 초과 되었습니다. \n가능신청수량 : 최대 " + data + "개");
                	selbx.children('option').eq(0).attr('selected', 'selected');
                    selbx.siblings('div').children('span').text('...');
                    eventInit();
                	amountbx.empty();
                	return false;
                }
                
                if(parseInt(data) > 0)
                {
                    html = '<div class="amountSel">';
                    html += '<div class="btn-zone" style="float:none">';
                    html += '<input type="hidden" name="amount[]" value="1">';
                    html += '<input type="hidden" name="appueno" class="empno_' + mdseq + '" value="${empno}" />';
                    html += '<input type="hidden" name="appuenm" class="username_' + mdseq + '" value="${userNm}" />';
                    html += '<input type="text" class="schword username_' + mdseq + '" value="${userNm}" style="width: 60px;"> ';
                    
                    html += '<input type="hidden" name="deptno_arr" class="deptno_arr_' + mdseq + '" value="${deptno}" />';
                   	html += '<input type="hidden" name="dept_Nm1dept_arr" class="dept_Nm1dept_arr_' + mdseq + '" value="${deptName}" />';
                    html += '<input type="button" style="cursor: pointer; height: 27px;" class="search_btn schbtn btn_' + mdseq + '" value="검색">';
                    html += '</div>';
                    html += '</div>';
                }
//                     alert(data);
                th.parents('tr.app_tr').children('.amount').empty().append(html);
            }, complete : function(data) {
                eventInit();
            }
        });
    }

//     function amountSelEvent(){
//         var selbx = $(this).parent().parent().parent().children('select');
//         var idx = selbx.parents('tr.app_tr').index()-1;
//         $('.app_tr .alloc_equip_num').eq(idx).empty();
//         $('.app_tr .alloc_equip').eq(idx).val('');
//         eventInit();
//     }

    function selectZindex()
    {
        var n = $('.jqTransformSelectWrapper').length;
        $(".jqTransformSelectWrapper").each(function(i) {
            $(this).css("z-index", n-i);
        });
    }

    function selectChanged()
    {
        $('.inputDesign').jqTransform();
        eventInit();
//         $('select').jqTransSelect();
    }

/*
    function fix_select(selector) {
        var i=$(selector).parent().find('div,ul').remove().css('zIndex');
        $(selector).unwrap().removeClass('jqTransformHidden').jqTransSelect();
        $(selector).parent().css('zIndex', i);
    }
 */
    function selectRating(rating) {
        $("#ratingModal .jqTransformSelectWrapper ul li a").each(function() {
          if (parseInt($(this).attr("index")) == rating - 1) {
              $(this).click();
          }
        });
     }

    function userSetData(arr) {
        $('.schword').eq(arr.key).siblings('.empno_'+arr.cls).val(arr.empno);
        $('.schword').eq(arr.key).siblings('.username_'+arr.cls).val(arr.name);
        $('.schword').eq(arr.key).siblings('.username_'+arr.cls).next().val(arr.name);
        $('.schword').eq(arr.key).siblings('.deptno_arr_'+arr.cls).val(arr.deptno);
    	$('.schword').eq(arr.key).siblings('.dept_Nm1dept_arr_'+arr.cls).val(arr.dept_nm);
        $('#mem_list_layer').slideUp('fast');
    }


    //대여신청
    function check()
    {
        ch = false;
        $.each($(".tbl_equip select[name='gbcd[]']"), function(i) {
            if( !$(this).val() || !$(".tbl_equip select[name='mdseq[]']").eq(i).val() || !$(".tbl_equip [name='amount[]']").eq(i).val() )
            {
                ch = true;
            }

        });
        if(ch)
        {
            alert('장비, 모델명, 신청수량을 빠짐없이 선택하세요.');
            return false;
        }
        var radioVal = $("input[name=rent_NB_Gubun]:checked").val();
        if($("#gbcdChk").val().indexOf("001") != '-1'){
	    	if(!radioVal){
	    		 alert('노트북 사용용도에 맞게 선택하세요.');
	             return false;
	    	}
        }


        if( !$('.equip_area').length )
        {
            alert('신청 모델이 존재하지 않습니다.');
            return false;
        }
        else if( !$.trim($("input[name='appss']").val()) )
        {
            alert('신청부서를 입력하세요.');
            $("input[name='appss']").focus();
            return false;
        }
        else if( !$.trim($("input[name='apptel']").val()) )
        {
            alert('연락처를 입력하세요.');
            $("input[name='apptel']").focus();
            return false;
        }
        else if( !$.trim($("input[name='appueno']").val()) )
        {
            alert('사용자를 입력하세요.');
            $(".schword").focus();
            return false;
        }
        else if( getByteLength( $.trim($("textarea[name='useobj']").val()) ) < 10 )
        {
            alert('사용용도를 최소 5자 이상입력하세요.');
            $("textarea[name='useobj']").focus();
            return false;
        }

    	var fileCheck = document.getElementById("file_attach").value;
    	if($("#gbcdChk").val().indexOf("001") != '-1'){
    		if(!fileCheck){
    			alert("보안서약서를 첨부해주세요.");
    		return false;
	    	}
    	}

        /* 대여기간이 한달이상 결재선 지정 
        var is_line = ${isLine};
        var is_tablet = ${isTablet};
        if(is_line == true || is_tablet == true)
        {
            var user_name = encodeURIComponent("${sessionScope.SESS_USER_NAME }");
            var pos_name = encodeURIComponent("${sessionScope.SESS_USER_INFO.USER_TITLE }");
            window.open('iniJojikdo.do?userName='+user_name+'&posName='+pos_name, 'jojikdo', 'width=1000px, height=1000px, scrollbars=no');
            
            return false;
        }*/

      	//메일 전송시 메일 제목에 장비 이름 넣는 요구 사항
        $("#gbnm").val($("select[name='gbcd[]'] option:selected").text());
        $("#mdnm").val($("select[name='mdseq[]'] option:selected").text());


        if(confirm('신청하시겠습니까?'))
        {
            return true;
        }
        else
        {
            return false;
        }

    }
    
    function changeNB_Gubun(){
    	var add_arr = new Array;
    	add_arr = [];
    	
    	var raioValue = '';
    	var pageGubun = $("input[name=bsknoArr]").val();
    	
    	if(pageGubun == null || pageGubun == '' || pageGubun == 'undefined'){
    		$("select[name='gbcd[]']").each(function(){
    			add_arr.push($(this).find('option:selected').val());
    		});
    	}else{
    		$.each($(".tbl_equip input[name='gbcd[]']"), function(i) {
        		add_arr.push($(".tbl_equip input[name='gbcd[]']").eq(i).val());
        	});
    	}
   		$("#gbcdChk").val(add_arr);
    		$.each(add_arr, function (index, item){
    			if(add_arr.indexOf("001") == '-1'){
    				$("#changeStatus").hide();
    				$("#changeStatus_1").hide();
    				$("input[name=rent_NB_Gubun]").attr("disabled", true);
    				$("input[name=file_attach]").attr("disabled", true);
    			}else{
    				$("#changeStatus").show();
    				$("#changeStatus_1").show();
    				$("input[name=rent_NB_Gubun]").attr("disabled", false);
    				$("input[name=file_attach]").attr("disabled", false);
    			}
    		})
    	}
    
    $("#file_attach").change(function(){
		if($(this).val() != ''){
			var ext = $(this).val().split(".").pop().toLowerCase();
			if($.inArray(ext, ["pdf","gif","png","jpg","jpeg"]) == -1 ){
				alert("pdf, gif, png, jpg, jpeg 파일만 업로드 가능합니다.");
				$(this).val('');
			}
		}
	})
	
	$(".imgSty").on("click", function (){
 	   funGoPageDetailSetFrm("/contentsSecurityDown.do", "securityDownForm");
    })
    </script>
<c:import url="/resource/common/include/bottom.jsp" />