<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/jquery.datetimepicker.css" />
<script type="text/javascript" src="/resource/common/js/jquery.datetimepicker.full.min.js"></script>
<style>
    .tabList:hover{background-color: lightblue; cursor: pointer;}
</style>
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />
<c:set value="8" var="left_depth_1"></c:set>
<div id="contents" class="learn-frame-area">
    <div class="contents-framebox" id="contents_id">
        <!-- leftmenu -->
        <div class="contents-header-framebox">
        <div class="learn-tit-framebox">
            <c:import url="/resource/common/include/leftMenu_01.jsp">
                <c:param name="left_depth_1" value="8"></c:param>
                <c:param name="left_depth_2" value="5"></c:param>
                <c:param name="left_depth_3" value="4"></c:param>
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
                <div class="nav-title">장비현황</div>
            </div>

            <div class="sub-nav-title">대여설비 등록</div>

            <div class="basic-list">
            <form id="frm" name="frm" action="/admin/saveEquip.do" method="post" enctype="multipart/form-data">
                <input type="hidden" name="eqno" value="${eqno}"/>
                <input type="hidden" name="pageNo" value="${pageNo}"/>

                <div id="apDiv" style="display:none;"></div>

                <div class="insrtfrom-framebox">
                <div class="insert-step1-box">
                    <div class="form-step1">
                        <fieldset>
                        <legend>장비신청</legend>
                            <div class="row-group">

                                <dl class="insert_ready">
                                    <dt class="must-option"><label>설비종류</label></dt>
                                    <dd style="width: 200px;">
                                    <div>
                                           <p class="inputDesign">
                                           <select id="gbcd" name="gbcd" style="width: 150px;" onchange="javascript:getSelectModel(this);">
                                                    <option value="">분류선택</option>
                                                <c:forEach var="codeList" items="${codeList}" varStatus="x">
                                                    <option value="${codeList.GBCD}" ${codeList.GBCD == gbcd ? "selected" : ""}>${codeList.GBNM}</option>
                                                </c:forEach>
                                           </select>
                                           </p>
                                    </div>
                                    </dd>
                                    <dt class="must-option"><label>모델명</label></dt>
                                    <dd style="width: 250px;">
                                    <div id="model_area" style="float:left;">
                                        <c:choose>
                                            <c:when test="${fn:length(modelList) > 0}">
                                                <p class="inputDesign">
                                            <select id="mdseq" name="mdseq" style="width: 160px;">
                                                        <option value="">모델선택</option>
                                                    <c:forEach var="modelList" items="${modelList}" varStatus="x">
                                                        <option value="${modelList.MDSEQ}" ${modelList.MDSEQ == equipInfo.MDSEQ ? "selected" : ""}>${modelList.MDNM}</option>
                                                    </c:forEach>
                                            </select>
                                            </p>
                                            </c:when>
                                            <c:otherwise>
                                                <p>등록된 모델이 없습니다.&nbsp;&nbsp;</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <span class="btn-zone">
                                    <input type="button" id="detail_model_view" style="cursor: pointer; height:27px;" class="search_btn" value="상세">
                                    </span>
                                    </dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>설비관리번호</label></dt>
                                    <dd style="width: 200px;"><span class="red-f">${(equipInfo.EQNM ne null) ? equipInfo.EQNM : "자동생성" }<!-- 자동생성 --></span></dd>
                                    <dt class="must-option"><label>설비고유번호</label></dt>
                                    <dd style="width: 250px;"><input type="text" name="eqsn" value='${equipInfo.EQSN}'></dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>설비별칭</label></dt>
                                    <dd style="width: 200px;"><input type="text" name="eqalias" value='${equipInfo.EQALIAS}'></dd>
                                    <dt class="must-option"><label><c:if test="${gbcd =='021' }">유심번호</c:if><c:if test="${gbcd != '021' }">설비자산번호</c:if></label></dt>
                                    <dd style="width: 250px;"><input type="text" name="eqassetsno" value='${equipInfo.EQASSETSNO}' maxlength="30"></dd>
                                </dl>

                                <!-- 타블렛 -->
                                <dl class="insert_ready tablet_area" style="display: none;">
                                    <dt class="must-option" style="background-image: none; background-color: #fcaeae;"><label>번호</label></dt>
                                    <dd><input type="text" name="etc1" value='${equipInfo.ETC1}'></dd>
                                    <dt class="must-option" style="background-image: none; background-color: #fcaeae;"><label>통신사</label></dt>
                                    <dd>
                                        <p class="inputDesign">
                                        <select name="etc2" style="width: 90px;">
                                            <option value="SKT" ${equipInfo.ETC2 == "SKT" ? "selected" : ""}>SKT</option>
                                            <option value="KT" ${equipInfo.ETC2 == "KT" ? "selected" : ""}>KT</option>
                                            <option value="LGU" ${equipInfo.ETC2 == "LGU" ? "selected" : ""}>LGU</option>
                                        </select>
                                        </p>
                                    </dd>
                                </dl>
                                <dl class="insert_ready tablet_area" style="display: none;">
                                    <dt class="must-option" style="background-image: none; background-color: #fcaeae;"><label>통신지원방식</label></dt>
                                    <dd>
                                        <p class="inputDesign">
                                        <select name="etc3" style="width: 90px;">
                                        <option value="LTE" ${equipInfo.ETC3 == "LTE" ? "selected" : ""}>LTE</option>
                                        <option value="WiFi" ${equipInfo.ETC3 == "WiFi" ? "selected" : ""}>WiFi</option>
                                        </select>
                                        </p>
                                    </dd>
                                    <dt class="must-option" style="background-image: none; background-color: #fcaeae;"><label>요금제</label></dt>
                                    <dd><input type="text" name="etc4" value='${equipInfo.ETC4}'></dd>
                                </dl>
                                <dl class="insert_ready tablet_area" style="display: none;">
                                    <dt class="must-option" style="background-image: none; background-color: #fcaeae;"><label>데이터용량</label></dt>
                                    <dd><input type="text" name="etc5" value='${equipInfo.ETC5}'></dd>
                                </dl>
                                <!-- 타블렛 -->

                                <!-- 에그 -->
                                <dl class="insert_ready egg_area" style="display: none;">
                                    <dt class="must-option" style="background-image: none; background-color: #fcaeae;"><label>항목1</label></dt>
                                    <dd style="width: 200px;"><input type="text" name="etc1" value='${equipInfo.ETC1}'></dd>
                                    <dt class="must-option" style="background-image: none; background-color: #fcaeae;"><label>항목2</label></dt>
                                    <dd style="width: 250px;"><input type="text" name="etc2" value='${equipInfo.ETC2}'></dd>
                                </dl>
                                <dl class="insert_ready egg_area" style="display: none;">
                                    <dt class="must-option" style="background-image: none; background-color: #fcaeae;"><label>항목3</label></dt>
                                    <dd style="width: 200px;"><input type="text" name="etc3" value='${equipInfo.ETC3}'></dd>
                                    <dt class="must-option" style="background-image: none; background-color: #fcaeae;"><label>항목4</label></dt>
                                    <dd style="width: 250px;"><input type="text" name="etc4" value='${equipInfo.ETC4}'></dd>
                                </dl>
                                <!-- 에그 -->
								
								<!-- 신형 에그 -->
								<dl class="insert_ready new_egg_Area" style="display: none;">
                                    <dt class="must-option" style="background-image: none; background-color: #fcaeae;"><label>통신사</label></dt>
                                    <dd>
                                        <p class="inputDesign">
                                        <select name="etc2" style="width: 90px;">
                                            <option value="SKT" ${equipInfo.ETC2 == "SKT" ? "selected" : ""}>SKT</option>
                                            <option value="KT" ${equipInfo.ETC2 == "KT" ? "selected" : ""}>KT</option>
                                            <option value="LGU" ${equipInfo.ETC2 == "LGU" ? "selected" : ""}>LGU</option>
                                        </select>
                                        </p>
                                    </dd>
                                </dl>
                                <!--  -->
                                
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>설비제조일</label></dt>
                                    <dd style="width: 200px;">
                                        <fieldset>
                                            <div class="form-group">
                                                <legend>설비제조일</legend>
                                                <c:set var="fn_eqcdt" value="value=${fn:substring(equipInfo.EQCDT,0,4)}-${fn:substring(equipInfo.EQCDT,4,6)}-${fn:substring(equipInfo.EQCDT,6,8)}"></c:set>
                                                <input type="text" id="eqcdt" name="eqcdt" ${equipInfo.EQCDT ne null ? fn_eqcdt : ''} readonly
                                                style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
                                            </div>
                                        </fieldset>
                                    </dd>
                                    <dt class="must-option"><label>설비등록일</label></dt>
                                    <dd style="width: 250px;">
                                        <fieldset>
                                            <div class="form-group">
                                                <legend>설비등록일</legend>
                                                <c:set var="fn_eqrdt" value='value=${fn:substring(equipInfo.EQRDT,0,4)}-${fn:substring(equipInfo.EQRDT,4,6)}-${fn:substring(equipInfo.EQRDT,6,8)}'></c:set>
                                                <input type="text" id="eqrdt" name="eqrdt" ${equipInfo.EQRDT ne null ? fn_eqrdt : ''} readonly
                                                style="width: 108px;height:15px;font-size:12px;color:#666;border-right-width: 0px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">
                                            </div>
                                        </fieldset>
                                    </dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>설비 등록상태</label></dt>
                                    <dd style="width: 225px;">
                                    <c:choose>
                                        <c:when test="${equipInfo.EQLST eq '1' || rentCheck.size() ne 0}">
                                            ${eqrstMap[equipInfo.EQRST]}
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="eqrstMap" items="${eqrstMap}" varStatus="x">
                                                <label><input type="radio" name="eqrst" value="${eqrstMap.key}" ${ ( eqno == null && eqrstMap.key == "1") || equipInfo.EQRST == eqrstMap.key ? "checked='checked'" : ""}class="checks small">${eqrstMap.value}</label>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                    </dd>
                                    <dt class="must-option"><label>설비 관리상태</label></dt>
                                    <dd style="width: 280px;">
                                    <c:choose>
                                        <c:when test="${equipInfo.EQLST eq '1' || rentCheck.size() ne 0}">
                                            ${eqmstMap[equipInfo.EQMST]}
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="eqmstMap" items="${eqmstMap}" varStatus="x">
                                                <label><input type="radio" name="eqmst" value="${eqmstMap.key}" ${ ( eqno == null && eqmstMap.key == "1") || (equipInfo.EQMST == eqmstMap.key) ? "checked='checked'" : ""}class="checks small">${eqmstMap.value}</label>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                    </dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>구성품내역</label></dt>
                                    <dd><textarea class="textarea-style" rows="3" cols="88" name="eqpkg">${equipInfo.EQPKG}</textarea></dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>특징(상세설명)</label></dt>
                                    <dd><textarea class="textarea-style" rows="3" cols="88" name="eqdet">${equipInfo.EQDET}</textarea></dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>고장처리내역</label></dt>
                                    <dd><textarea class="textarea-style" rows="3" cols="88" name="eqbrk">${equipInfo.EQBRK}</textarea></dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>고장발생일시</label></dt>
                                    <dd>
                                    <c:set var="fn_eqbrkdt" value="value=${fn:substring(equipInfo.EQBRKDT,0,4)}/${fn:substring(equipInfo.EQBRKDT,4,6)}/${fn:substring(equipInfo.EQBRKDT,6,8)}&nbsp;${fn:substring(equipInfo.EQBRKDT,8,10)}:${fn:substring(equipInfo.EQBRKDT,10,12)}"></c:set>
                                    <input type="text" name="eqbrkdt" ${equipInfo.EQBRKDT ne null ? fn_eqbrkdt : ""} readonly>
                                    </dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>비고</label></dt>
                                    <dd><textarea class="textarea-style" rows="3" cols="88" name="eqbg">${equipInfo.EQBG}</textarea></dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>첨부파일</label></dt>
                                    <dd>
                                        <c:if test="${fileList != null}">
                                        <div>
                                            <c:forEach var="fileList" items="${fileList}" varStatus="x">
                                                ${fileList.FILENM}  <img src="/resource/images/btn/btn_del.png" style="cursor: pointer;" class="file_del" id="ref_${fileList.FILENO}"> <br/>
                                            </c:forEach>
                                        </div>
                                        </c:if>
                                        <div class="filebox">
                                            <input type="text" id="E_attFileName" class="upload-name" value="파일선택" disabled="disabled">
                                            <label for="E_attFile">업로드</label>
                                            <input type="file" class="upload-hidden" id="E_attFile" name="E_attFile" onchange="javascript:document.getElementById('E_attFileName').value = this.value"/>
                                        </div>
                                    </dd>
                                </dl>

                    </div>
                    <div class="btn-zone">
                        <ul>
                            <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:equipReg();" value="저장"></li>
                            <c:if test="${eqno ne null}">
                            <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:equip_delete('${eqno}')" value="삭제"></li>
                            </c:if>
                            <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:window.location='/admin/equipList.do?pageNo=${pageNo}&gbcd=${gbcd }'" value="목록"></li>
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
<script type="text/javascript">
$(document).ready(function() {
    load_fnc('4', '0', '0'); //menu script

    var resultMessage = '<%= session.getAttribute("resultMessage") %>';

    if(resultMessage != 'null'){
        alert(resultMessage);
        <% session.removeAttribute("resultMessage"); %>
    }


    $("#eqcdt, #eqrdt").datepicker();

    $('#apDiv').dialog({
        autoOpen : false,
        resizable : true,
        draggable : true,
        /* position : ['center', 'center'], */
        width : 650,
        height: 430,
        open : function() {

            var gbcd = '',
                mdseq = '',
                ndnm = '';

            if( $('#gbcd option').length )
            {
                gbcd = $('#gbcd').val();
            }
            else
            {
                gbcd = "${gbcd}";
            }

            if( $('#mdseq option').length )
            {
                mdseq =  $('#mdseq').val();
                mdnm =  $('#mdseq option:selected').text();
            }
            else
            {
                mdseq = "${mdseq}";
                mdnm = "${equipInfo.EQNM}";
            }

            if(!gbcd || !mdseq)
            {
                alert('설비,모델명을 확인하세요.');
                $('#apDiv').dialog('close');
                return false;
            }

            $("span.ui-dialog-title").html("<span style='color:#fff;'>장비정보 - "+mdnm+"</span>");
            $('#apDiv').load('/appPopView.do?gbcd='+gbcd+'&mdseq='+mdseq);

        },
        close : function() {
            $('#apDiv').empty();
        },
        buttons : {
            '닫기' : function() {
                $(this).dialog('close');
            }
        },
        show : {
            effect : 'blind',
            duration : 200
        },
        hide : {
            effect : 'explode',
            duration : 200
        },
        modal : true
    });

    //모델 상세보기
    $('#detail_model_view').click(function() {
        $('#apDiv').dialog('open');
    });

    $("input[name=eqbrkdt]").datetimepicker({
        formatTime:'H:i',
        defaultTime:'17:00',
        timepickerScrollbar:false
    });

    //파일삭제
    $('.file_del').click(function() {

        var split_id = $(this).attr('id').split('_');

        if(!split_id[1])
        {
            alert('error');
            return false;
        }

        if(confirm('파일을 삭제하시겠습니까?'))
        {

            $.ajax({
                url : '/admin/delFile.do',
                type : 'post',
                data : {'fileNo':split_id[1], 'type':'E'},
                success : function(data) {
                    if(data == 'success')
                    {
                        window.location.reload();
                    }
                }
            });

        }

    });
    eq_set();

});

function eq_set()
{
    var sel_code1 = $("select[name='gbcd']").val();

    //태블릿, 에그 별도 항목출력
    if(sel_code1 == '010')
    {
        $('.tablet_area').fadeIn('fast');
        $('.tablet_area input').attr('disabled', false);
        $('.tablet_area select').attr('disabled', false);

        $('.egg_area').fadeOut('fast');
        $('.new_egg_Area').fadeOut('fast');
        $('.egg_area input').attr('disabled', true);
        $('.new_egg_Area input').attr('disabled', true);
        $('.new_egg_Area select').attr('disabled', true);
    }
    else if(sel_code1 == '011')
    {
        $('.egg_area').fadeIn('fast');
        $('.egg_area input').attr('disabled', false);

        $('.tablet_area').fadeOut('fast');
        $('.new_egg_Area').fadeOut('fast');
        $('.tablet_area input').attr('disabled', true);
        $('.new_egg_Area input').attr('disabled', true);
        $('.new_egg_Area select').attr('disabled', true);
    }
    else if(sel_code1 == '021'){
    	$('.new_egg_Area').fadeIn('fast');
        $('.new_egg_Area select').attr('disabled', false);
        
    	$('.tablet_area, .egg_area').fadeOut('fast');
    	$('.tablet_area input').attr('disabled', true);
        $('.tablet_area select').attr('disabled', true);
    	$('.egg_area input').attr('disabled', true);
    }
    else
    {
        $('.tablet_area, .egg_area .new_egg_Area').fadeOut('fast');
        $('.tablet_area input').attr('disabled', true);
        $('.egg_area input').attr('disabled', true);
        $('.new_egg_Area input').attr('disabled', true);

        $('.tablet_area select').attr('disabled', true);
        $('.new_egg_Area select').attr('disabled', false);
    }

}

function equipList(code){
    var frm = document.frm;
    if(code != undefined){
        $("#gbcd").val(code);
    }
    $("#pageNo").val("1");
    frm.submit();
}

//설비종류 셀렉트
function getSelectModel(code){

    var gbcd = $(code).val();

    if(gbcd == ""){
        var html = "";
        html += "등록된 모델이 없습니다. &nbsp;";

        $('#model_area').empty().append(html);

    }else{

        $.ajax({
            url : '/admin/getModelList.do',
            type : 'post',
            dataType : 'json',
            data : {'gbcd':gbcd},
            success : function(data) {

                var html = '';
                if(data != 'error')
                {

                    if(data.model_list)
                    {

                        html = "<p class=\"inputDesign\">";
                        html += "<select id='mdseq' name='mdseq' style='width: 169px; margin-right: 10px;'>";
                        html += "<option value=\"\">모델선택</option>";
                        $.each(data.model_list, function() {
                            html += "<option value='"+this.mdseq+"'>"+this.mdnm+"</option>";
                        });
                        html += "</select>";
                        html += "</p>";

                    }
                    else
                    {
                        html += "등록된 모델이 없습니다.";
                    }
                }

                $('#model_area').empty().append(html);
                $('#mdseq').jqTransSelect();
                $('.inputDesign').jqTransform();
            }

        });


    }


    eq_set();
}

function equipReg(){
    if(confirm('저장하시겠습니까?')){
        frm.submit();
    }
}

function equip_delete(eqno)
{
    if(!eqno)
    {
        alert('error');
        return false;
    }

    if(confirm('삭제하시겠습니까?'))
    {

        var newForm = $('<form>', {
            'name' : 'delete_form',
            'action' : '/admin/deleteEquip.do',
            'method' : 'post',
            'target' : '_top'
        }).append($('<input>', {
            'name' : 'eqno',
            'value' : eqno,
            'type' : 'hidden'
        })).append($('<input>', {
            'name' : 'gbcd',
            'value' : "${gbcd}",
            'type' : 'hidden'
        })).appendTo('body');

        newForm.submit();

    }
}





</script>
<c:import url="/resource/common/include/bottom.jsp" />