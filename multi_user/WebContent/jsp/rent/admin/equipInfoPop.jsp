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
<div id="contents" class="learn-frame-area">
    <div class="contents-framebox" id="contents_id">
        <!--content-->
        <div class="contents-con-framebox" style="padding: 13px;">
            <div class="sub-nav-title" style="margin-top: 20px;">대여설비 상세</div>

            <div class="basic-list">
            <form id="frm" name="frm" action="/admin/saveEquip.do" method="post" enctype="multipart/form-data">

                <div id="apDiv" style="display:none;"></div>
                
                <%--apDiv 조회용 --%>
				<select id="gbcd" name="gbcd" style="display: none;">
                         <option value="">분류선택</option>
                     <c:forEach var="codeList" items="${codeList}" varStatus="x">
                         <option value="${codeList.GBCD}" ${codeList.GBCD == gbcd ? "selected" : ""}>${codeList.GBNM}</option>
                     </c:forEach>
                </select>
				<select id="mdseq" name="mdseq" style="display: none;">
                            <option value="">모델선택</option>
                        <c:forEach var="modelList" items="${modelList}" varStatus="x">
                            <option value="${modelList.MDSEQ}" ${modelList.MDSEQ == equipInfo.MDSEQ ? "selected" : ""}>${modelList.MDNM}</option>
                        </c:forEach>
                </select>
                <%--apDiv 조회용 --%>
                
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
										<c:forEach var="codeList" items="${codeList}" varStatus="x">
											<c:if test="${codeList.GBCD == gbcd}">${codeList.GBNM}</c:if>
                                        </c:forEach>
                                    </div>
                                    </dd>
                                    <dt class="must-option"><label>모델명</label></dt>
                                    <dd style="width: 250px;">
                                    <div id="model_area" style="float:left;">
                                        <c:choose>
                                            <c:when test="${fn:length(modelList) > 0}">
                                            	<c:forEach var="modelList" items="${modelList}" varStatus="x">
                                                	<c:if test="${modelList.MDSEQ == equipInfo.MDSEQ}">${modelList.MDNM}</c:if>
												</c:forEach>
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
                                    <dd style="width: 250px;">${equipInfo.EQSN}</dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>설비별칭</label></dt>
                                    <dd style="width: 200px;">${equipInfo.EQALIAS}</dd>
                                    <dt class="must-option"><label>설비자산번호</label></dt>
                                    <dd style="width: 250px;">${equipInfo.EQASSETSNO}</dd>
                                </dl>
<%-- equipRegist.jsp 기준. 미사용중인 코드로 주석처리 함. 태블릿과 에그는 대여항목이 아닌가봄. 20180516
                                <!-- 타블렛 -->
                                <dl class="insert_ready tablet_area" style="display: none;">
                                    <dt class="must-option" style="background-image: none; background-color: #fcaeae;"><label>번호</label></dt>
                                    <dd><input type="text" name="etc1" value='${equipInfo.ETC1}'></dd>
                                    <dt class="must-option" style="background-image: none; background-color: #fcaeae;"><label>통신사</label></dt>
                                    <dd>${equipInfo.ETC2 == "SKT" ? "SKT" : equipInfo.ETC2 == "KT" ? "KT" : equipInfo.ETC2 == "LGU" ? "LGU" : ""}</dd>
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
                                    <dd><input type="text" name="etc1" value='${equipInfo.ETC1}'></dd>
                                    <dt class="must-option" style="background-image: none; background-color: #fcaeae;"><label>항목2</label></dt>
                                    <dd><input type="text" name="etc2" value='${equipInfo.ETC2}'></dd>
                                </dl>
                                <dl class="insert_ready egg_area" style="display: none;">
                                    <dt class="must-option" style="background-image: none; background-color: #fcaeae;"><label>항목3</label></dt>
                                    <dd><input type="text" name="etc3" value='${equipInfo.ETC3}'></dd>
                                    <dt class="must-option" style="background-image: none; background-color: #fcaeae;"><label>항목4</label></dt>
                                    <dd><input type="text" name="etc4" value='${equipInfo.ETC4}'></dd>
                                </dl>
                                <!-- 에그 -->
 --%>

                                <dl class="insert_ready">
                                    <dt class="must-option"><label>설비제조일</label></dt>
                                    <dd style="width: 200px;">
                                        <fieldset>
                                            <div class="form-group">
                                                <legend>설비제조일</legend>
                                                <c:set var="fn_eqcdt" value="${fn:substring(equipInfo.EQCDT,0,4)}-${fn:substring(equipInfo.EQCDT,4,6)}-${fn:substring(equipInfo.EQCDT,6,8)}"></c:set>
                                                ${equipInfo.EQCDT ne null ? fn_eqcdt : ''}
                                            </div>
                                        </fieldset>
                                    </dd>
                                    <dt class="must-option"><label>설비등록일</label></dt>
                                    <dd style="width: 250px;">
                                        <fieldset>
                                            <div class="form-group">
                                                <legend>설비등록일</legend>
                                                <c:set var="fn_eqrdt" value='${fn:substring(equipInfo.EQRDT,0,4)}-${fn:substring(equipInfo.EQRDT,4,6)}-${fn:substring(equipInfo.EQRDT,6,8)}'></c:set>
                                                ${equipInfo.EQRDT ne null ? fn_eqrdt : ''}
                                            </div>
                                        </fieldset>
                                    </dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>설비 등록상태</label></dt>
                                    <dd style="width: 200px;">
                                    <c:choose>
                                        <c:when test="${equipInfo.EQLST eq '1'}">
                                            ${eqrstMap[equipInfo.EQRST]}
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="eqrstMap" items="${eqrstMap}" varStatus="x">
                                            	<c:if test="${ ( eqno == null && eqrstMap.key == '1') || equipInfo.EQRST == eqrstMap.key}">
                                            		${eqrstMap.value}
                                            	</c:if>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                    </dd>
                                    <dt class="must-option"><label>설비 관리상태</label></dt>
                                    <dd style="width: 250px;">
                                    <c:choose>
                                        <c:when test="${equipInfo.EQLST eq '1'}">
                                            ${eqmstMap[equipInfo.EQMST]}
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="eqmstMap" items="${eqmstMap}" varStatus="x">
                                            	<c:if test="${ ( eqno == null && eqmstMap.key == '1') || (equipInfo.EQMST == eqmstMap.key)}">
                                            		${eqmstMap.value}
                                            	</c:if>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                    </dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>구성품내역</label></dt>
                                    <dd><textarea class="textarea-style" rows="3" cols="88" name="eqpkg" readonly="readonly" onfocus="$(this).blur();">${equipInfo.EQPKG}</textarea></dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>특징(상세설명)</label></dt>
                                    <dd><textarea class="textarea-style" rows="3" cols="88" name="eqdet" readonly="readonly" onfocus="$(this).blur();">${equipInfo.EQDET}</textarea></dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>고장처리내역</label></dt>
                                    <dd><textarea class="textarea-style" rows="3" cols="88" name="eqbrk" readonly="readonly" onfocus="$(this).blur();">${equipInfo.EQBRK}</textarea></dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>고장발생일시</label></dt>
                                    <dd>
                                    <c:set var="fn_eqbrkdt" value="${fn:substring(equipInfo.EQBRKDT,0,4)}/${fn:substring(equipInfo.EQBRKDT,4,6)}/${fn:substring(equipInfo.EQBRKDT,6,8)}&nbsp;${fn:substring(equipInfo.EQBRKDT,8,10)}:${fn:substring(equipInfo.EQBRKDT,10,12)}"></c:set>
                                    ${equipInfo.EQBRKDT ne null ? fn_eqbrkdt : ""}
                                    </dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>비고</label></dt>
                                    <dd><textarea class="textarea-style" rows="3" cols="88" name="eqbg" readonly="readonly" onfocus="$(this).blur();">${equipInfo.EQBG}</textarea></dd>
                                </dl>
                                <dl class="insert_ready">
                                    <dt class="must-option"><label>첨부파일</label></dt>
                                    <dd>
                                        <c:if test="${fileList != null}">
                                        <div>
                                            <c:forEach var="fileList" items="${fileList}" varStatus="x">
                                                ${fileList.FILENM} <br/>
                                            </c:forEach>
                                        </div>
                                        </c:if>
                                    </dd>
                                </dl>

                    </div>
                    <div class="btn-zone">
                        <ul>
                            <li><input type="button" name="srchDescription" class="search_btn" onclick="javascript:window.self.close();" value="닫기"></li>
                        </ul>
                    </div>
                </fieldset>

                </div>
            </div>
            </div>
            <input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo }">
            <input type="hidden" id="eqno" name="eqno" value="${eqno }">
            </form>
            
            <div class="sub-nav-title"style="margin-top: 20px;">설비대여 현황</div>
	        <div id="rentUserList"></div>
	            
			</div>
            </div>

        </div>
        <!--content end-->
    </div>
</body>
    
<script type="text/javascript">
$(document).ready(function() {
    goPage($('#pageNo').val());
    
    var resultMessage = '<%= session.getAttribute("resultMessage") %>';
    if(resultMessage != 'null'){
        alert(resultMessage);
        <% session.removeAttribute("resultMessage"); %>
    }

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
    
    
});
        
    function goPage(val) {
    	if(val == null){
    		val = 1;
    	}
    	
    	var pagingNum = Number(val);
    	var param = '';
    	$("#pageNo").val(pagingNum);
    	
   		params = {'GBCD':$("#gbcd").val() ,'EQNO':$("#eqno").val(), 'pageNo':val};
   		
   		$.ajax({
    		url: "/admin/rentUserListAjax.do",
    		data: params,
            type: 'POST',
            dataType:"html",
    		success: function(data) {
   				$('#rentUserList').html(data);
    		}
   		});
	}

</script>
