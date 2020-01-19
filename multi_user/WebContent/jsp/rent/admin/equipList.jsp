<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<style>
    .tabList:hover{background-color: lightblue; cursor: pointer;}
</style>
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />
<c:set value="3" var="left_depth_1"></c:set>
<div id="contents" class="learn-frame-area">
    <div class="contents-framebox" id="contents_id">
        <!-- leftmenu -->
        <div class="contents-header-framebox">
        <div class="learn-tit-framebox">
            <c:import url="/resource/common/include/leftMenu_01.jsp">
                <c:param name="left_depth_1" value="3"></c:param>
                <c:param name="left_depth_2" value="5"></c:param>
                <c:param name="left_depth_3" value="4"></c:param>
            </c:import>
        </div>
        </div>
        <!-- leftmenu end-->

        <!--content-->
        <div class="contents-con-framebox">
            <div class="nav-box">
                <div class="nav-img"><img src="/resource/images/sub/sub8_tit_img.png"></div>
                <div class="nav-list">
                    <img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리메뉴</b>
                </div>
                <div class="nav-title">장비현황</div>
            </div>

            <form id="frm" name="frm" method="get" onSubmit="return false;" onkeypress="javascript:if(event.keyCode == 13){equipList()}"
                action="/admin/equipList.do">
            <input type="hidden" id="gbcd" name="gbcd" value="${gbcd}"/>
            <input type="hidden" name="pageNo" id="pageNo"  value="${paging.pageNo}"/>
            <div class="searchArea_con">
                    <fieldset>
                    <div class="search-box">
                        <div class="form-group">
                            <legend>검색영역</legend>

                            <!-- 대여상태 -->
                            <div>
                                <p class="inputDesign">
                                <select name="schEqlst" onchange="javascript:equipList();">
                                    <option value="" ${schEqlst == "" ? "selected" : ""}>전체</option>
                                    <c:forEach var="eqlstMap" items="${eqlstMap}" varStatus="x">
                                    <option value="${eqlstMap.key}" ${schEqlst == eqlstMap.key ? "selected" : ""}>${eqlstMap.value}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- 등록상태 -->
                            <div>
                                <p class="inputDesign">
                                <select name="schEqrst" onchange="javascript:equipList();">
                                    <option value="" ${schEqrst == "" ? "selected" : ""}>전체</option>
                                    <c:forEach var="eqrstMap" items="${eqrstMap}" varStatus="x">
                                    <option value="${eqrstMap.key}" ${schEqrst == eqrstMap.key ? "selected" : ""}>${eqrstMap.value}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- 관리상태 -->
                            <div>
                                <p class="inputDesign">
                                <select name="schEqmst" onchange="javascript:equipList();">
                                    <option value="" ${schEqmst == "" ? "selected" : ""}>전체</option>
                                    <c:forEach var="eqmstMap" items="${eqmstMap}" varStatus="x">
                                    <option value="${eqmstMap.key}" ${schEqmst == eqmstMap.key ? "selected" : ""}>${eqmstMap.value}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <input type="text" name="schEqsn" placeholder="설비고유,관리번호,설비별칭, 자산번호" onkeydown="if(event.keyCode==13){ equipList(); event.returnValue=false; }" style="width:180px;height:15px;margin-left: 8px;font-size:12px;color:#666;">
                            <input type="button" style="cursor: pointer;" class="search_btn" onclick="javascript:equipList();" value="검색">
                        </div>
                    </div>
                    </fieldset>
            </div>

            <div class="basic-list2">
                <table id="listTable">
                    <caption>탭정보</caption>
                    <thead>
                        <tr>
                            <th scope="col" ${gbcd == 'all' ? 'style="background-color: lightblue; cursor: pointer;"' : 'class=tabList'} onclick="javascript:equipList('all')">전체<br/><span class="red-f">(${totalSumCnt})</span></th>
                            <c:forEach var="codeList" items="${codeList}" varStatus="x">
                            <th scope="col" ${gbcd == codeList.GBCD ? 'style="background-color: lightblue; cursor: pointer;"' : 'class=tabList'} onclick="javascript:equipList('${codeList.GBCD}')">${codeList.GBNM}<br/><span class="red-f">(${codeList.totalCnt})</span></th>
                            </c:forEach>
                        </tr>
                    </thead>
                </table>
            </div>

            <!-- 부가정보 -->
            <c:if test="${gbcd != 'all'}">
            <div class="basic-list2" style="margin-top:5px;">
            <table id="listTable">
                <caption>부가정보</caption>
                <colgroup>
                    <col style="width:5%">
                    <col style="width:${fn:length(companyList) == 0 ? 20 : fn:length(companyList) * 8}%">
                    <col style="width:5%">
                    <col style="width:20%">
                </colgroup>
                <thead>
                    <tr>
                        <td style="padding: 0px;">제조사</td>
                        <td style="padding: 0px;">
                            <c:set var="dynWidth" value="${100 div fn:length(companyList)}"></c:set>
                            <c:forEach var="companyList" items="${companyList}" varStatus="x">
                                <div style="float: left; width:${dynWidth}%">
                                <label><input type="radio" name="schCompany" value="${companyList.GBCD}" ${companyList.GBCD == schCompany ? "checked" : "" } onclick="javascript:equipList();"/> ${companyList.GBNM}</label>
                                </div>
                            </c:forEach>
                        </td>
                        <td style="padding: 0px;">모델</td>
                        <td style="padding: 0px;">
                        <div style="display: inline-block; text-align: center; vertical-align: middle;">
                            <p class="inputDesign">
                            <select name="schModel" onchange="javascript:equipList();" style="width: 170px;">
                                <option value="">모델선택</option>
                                <c:forEach var="modelList" items="${modelList}" varStatus="x">
                                <option value="${modelList.MDSEQ}" ${modelList.MDSEQ == schModel ? "selected" : ""}>${modelList.MDNM}</option>
                                </c:forEach>
                            </select>
                            </p>
                        </div>
                        </td>
                    </tr>
                </thead>
            </table>
            </div>
            </c:if>

            </form>


            <div class="basic-list2" style="margin-top:5px;">
                <table id="listTable">
                    <caption>대여가능수</caption>
                    <colgroup>
                        <col style="width:5%">
                        <col style="width:8%">
                        <col style="width:12%">
                        <col style="width:15%">
                        <col style="width:15%">
                        <col style="width:8%">
                        <col style="width:8%">
                        <col style="">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">설비관리번호</th>
                            <th scope="col">설비고유번호</th>
                            <th scope="col">모델명</th>
                            <th scope="col">별칭</th>
                            <th scope="col">대여상태</th>
                            <th scope="col">관리상태</th>
                            <th scope="col">특징(상세설명)</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="list" items="${list}" varStatus="x">
                        <tr onclick="javascript:window.location='/admin/equipRegist.do?gbcd=${list.gbcd}&eqno=${list.eqno}&pageNo=${paging.pageNo}'" style="cursor: pointer;">
                            <td>${list.no}</td>
                            <td>${list.eqnm}</td>
                            <td>${list.eqsn}</td>
                            <td>${list.mdnm}</td>
                            <td>${list.eqalias}</td>
                            <td><span <c:if test="${list.eqlst == 0}">class="blue-f"</c:if> <c:if test="${list.eqlst == 1}">class="red-f"</c:if> >${eqlstMap[list.eqlst]}</span></td>
                            <td>${eqmstMap[list.eqmst]}</td>
                            <td>${list.eqdet}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${fn:length(list) == 0}">
                        <tr>
                            <td align="center" colspan="8">등록된 데이터가 없습니다.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
            <div class="basic-list2">
            <c:import url="/resource/common/include/paging.jsp" />
                <div class="btn-zone">
                    <ul>
                        <li><input type="button" name="srchDescription" class="admin_btn" onclick="javascript:window.location='/admin/discardList.do'" value="폐기목록"></li>
                        <li><input type="button" name="srchDescription" class="admin_btn" onclick="javascript:window.location='/admin/equipList.do';" value="전체목록"></li>
                        <li><input type="button" name="srchDescription" class="admin_btn" onclick="javascript:window.location='/admin/equipRegist.do?gbcd=' + '${gbcd}'" value="등록"></li>
                    </ul>
                </div>
            </div>

        </div>
        <!--content end-->
    </div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    load_fnc('3', '0', '0'); //menu script

    var resultMessage = '<%= session.getAttribute("resultMessage") %>';

    if(resultMessage != 'null'){
        alert(resultMessage);
        <% session.removeAttribute("resultMessage"); %>
    }


});

function equipList(code){
    var frm = document.frm;
    if(code != undefined){
        $("#gbcd").val(code);
    }
    $("#pageNo").val("1");
    frm.submit();
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />