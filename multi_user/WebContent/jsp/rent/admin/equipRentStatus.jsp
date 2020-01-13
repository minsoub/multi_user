<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<%@ page trimDirectiveWhitespaces="true" %>

<c:import url="/resource/common/include/meta.jsp" />
<style>
	.ui-datepicker-trigger { position: relative; top:-1px; width: 30px;}
</style>
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
                        <c:param name="left_depth_3" value="1"></c:param>
                    </c:import>
                </div>
            </div>
            <!-- leftmenu end-->

            <!--content-->
       	 	<div class="contents-con-framebox">
            <div class="nav-box">
                <div class="nav-img"><img src="/resource/images/sub/sub8_tit_img.png"></div>
                <div class="nav-list">
                    <img src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;장비대여&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">관리메뉴</b>
                </div>
                <div class="nav-title">대여현황</div>
            </div>
            <div class="sub-nav-title">대여가능수(<span class="red-f">대여수</span>/총보유량)</div>
            <div class="basic-list2">
                <table id="listTable">
                    <caption>대여가능수</caption>
                    <thead>
                        <tr>
							<c:forEach var="codeList" items="${codeList}" varStatus="x">
							<th scope="col">${codeList.GBNM}</th>
							</c:forEach>
							<th scope="col">합계</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                        	<c:forEach var="codeList" items="${codeList}" varStatus="x">
                        		<c:set var="rentAllExist" value="false"/>
                        		<c:set var="rentExist" value="false"/>
                        		<c:set var="enableExist" value="false"/>
                        		<td>
                        		<c:forEach var="enableMap" items="${enableMap}" varStatus="y">
                       			<c:if test="${codeList.GBCD == enableMap.key }">
                       			<a href="/admin/equipList.do?gbcd=${enableMap.key}&pageNo=1&schEqlst=0">${enableMap.value}</a><c:set var="enableExist" value="true"/>
                       			</c:if>
                       			</c:forEach><c:if test="${enableExist eq 'false'}"><a href="/admin/equipList.do?gbcd=${codeList.GBCD}">0</a></c:if>(<span class="red-f"><c:forEach var="rentMap" items="${rentMap}" varStatus="y">
                       			<c:if test="${codeList.GBCD == rentMap.key }">
                       			<a href="/admin/equipList.do?gbcd=${rentMap.key}&pageNo=1&schEqlst=1">${rentMap.value}</a><c:set var="rentExist" value="true"/>
                       			</c:if>
                       			</c:forEach>
                       			<c:if test="${rentExist eq 'false'}"><a href="/admin/equipList.do?gbcd=${codeList.GBCD}">0</a></c:if></span>/<c:forEach var="rentAllMap" items="${rentAllMap}" varStatus="y">
                      			<c:if test="${codeList.GBCD == rentAllMap.key }">
                       			<a href="/admin/equipList.do?gbcd=${rentAllMap.key}&pageNo=1">${rentAllMap.value}</a><c:set var="rentAllExist" value="true"/>
                       			</c:if>
                       			</c:forEach>
                       			<c:if test="${rentAllExist eq 'false'}"><a href="/admin/equipList.do?gbcd=${codeList.GBCD}">0</a></c:if>)
                       			</td>
                        	</c:forEach>
                        	<td><a href="/admin/equipList.do?gbcd=all&pageNo=1&schEqlst=0&schEqrst=1&schEqmst=1">${equipEnableTot}</a>(<span class="red-f"><a href="/admin/equipList.do?gbcd=all&pageNo=1&schEqlst=1">${equipRentTot}</a></span>/<a href="/admin/equipList.do?gbcd=all&pageNo=1">${equipAllTot}</a>)</td>
                        </tr>
                    </tbody>
                </table>
            </div>
			<form id="frm" name="frm" action="/admin/equipRentStatus.do" method="post">
            <div class="cal-title" style="text-align: center;">
            	<!-- 2017.01.26  -->
            	<input type="text" id="setDate" name="setDate" onchange="javascript:document.frm.submit();" value="${setDate}" style="width:150px; border:0; font-size:17pt; font-weight:bold; background-color:#ffffff; color:#006291; line-height: 18px; vertical-align:baseline; cursor:pointer" readonly="readonly" onfocus="blur();">
            </div>
            </form>
            <div class="admin-nav-title orange-f">사용(대여)중</div>
            <div class="basic-list2">
                <table id="listTable">
                    <caption>대여가능수</caption>
                    <thead>
                        <tr>
                            <th scope="col">구분</th>
                            <c:forEach var="codeList" items="${codeList}" varStatus="x">
							<th scope="col">${codeList.GBNM}</th>
							</c:forEach>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th scope="col">수량</th>
                            <c:forEach var="codeList" items="${codeList}" varStatus="x">
                            <c:set var="usingEqExist" value="false"/>
                            <td>
                            <c:forEach var="usingEqMap" items="${usingEqMap}" varStatus="y">
                       			<c:if test="${codeList.GBCD == usingEqMap.key }">
                       			<a href="/admin/recList.do?gbcd=${usingEqMap.key}&pageNo=1&sch_status=4&sch_strdt=${setDate}&sch_enddt=${setDate}">${usingEqMap.value}</a><c:set var="usingEqExist" value="true"/>
                       			</c:if>
                       		</c:forEach>
                       		<c:if test="${usingEqExist eq 'false'}"><a href="/admin/recList.do?gbcd=${codeList.GBCD}&pageNo=1&sch_status=4&sch_strdt=${setDate}&sch_enddt=${setDate}">0</a></c:if>
                       		</td>
                       		</c:forEach>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="admin-nav-title green-f" style="display: inline-block;">반출(예정)</div>
            <div class="admin-nav-title green-f" style="float: right;display: inline-block;position: absolute;width: 932px; text-align: right;">${fn:substring(setDate, 5, 7)}월 노트북 총 반출 : <fmt:formatNumber value="${mInsuBanpStatMap.insu_cnt}" pattern="#,###" /> 건</div>
            <div class="basic-list2">
                <table id="listTable" summary="">
                    <caption>대여가능수</caption>
                    <thead>
                        <tr>
                            <th scope="col">구분</th>
                            <c:forEach var="codeList" items="${codeList}" varStatus="x">
							<th scope="col">${codeList.GBNM}</th>
							</c:forEach>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th scope="col">수량</th>
                            <c:forEach var="codeList" items="${codeList}" varStatus="x">
                            <c:set var="planOutExist" value="false"/>
                            <td>
                            <c:forEach var="planOutMap" items="${planOutMap}" varStatus="y">
                       			<c:if test="${codeList.GBCD == planOutMap.key }">
                       			<a href="/admin/recList.do?gbcd=${planOutMap.key}&pageNo=1&sch_status=3&sch_approval=2&sch_strdt=${setDate}&sch_enddt=${setDate}">${planOutMap.value}</a><c:set var="planOutExist" value="true"/>
                       			</c:if>
                       		</c:forEach>
                       		<c:if test="${planOutExist eq 'false'}"><a href="/admin/recList.do?gbcd=${codeList.GBCD}&pageNo=1&sch_status=3&sch_strdt=${setDate}&sch_enddt=${setDate}">0</a></c:if>
                       		</td>
                       		</c:forEach>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="admin-nav-title blue-f" style="display: inline-block;">반납(예정)</div>
            <div class="admin-nav-title blue-f" style="float: right;display: inline-block;position: absolute;width: 932px; text-align: right;">${fn:substring(setDate, 5, 7)}월 노트북 총 반납 : <fmt:formatNumber value="${mInsuBanpStatMap.banp_cnt}" pattern="#,###" /> 건</div>
            <div class="basic-list2">
                <table id="listTable" summary="">
                    <caption>대여가능수</caption>
                    <thead>
                        <tr>
                            <th scope="col">구분</th>
                            <c:forEach var="codeList" items="${codeList}" varStatus="x">
							<th scope="col">${codeList.GBNM}</th>
							</c:forEach>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th scope="col">수량</th>
                            <c:forEach var="codeList" items="${codeList}" varStatus="x">
                            <c:set var="returnExist" value="false"/>
                            <td>
                            <c:forEach var="returnMap" items="${returnMap}" varStatus="y">
                       			<c:if test="${codeList.GBCD == returnMap.key }">
                       			<a href="/admin/recList.do?gbcd=${returnMap.key}&pageNo=1&sch_return=planStat&sch_strdt=${setDate}&sch_enddt=${setDate}">${returnMap.value}</a><c:set var="returnExist" value="true"/>
                       			</c:if>
                       		</c:forEach>
                       		<c:if test="${returnExist eq 'false'}"><a href="/admin/recList.do?gbcd=${codeList.GBCD}&pageNo=1&sch_return=planStat&sch_strdt=${setDate}&sch_enddt=${setDate}">0</a></c:if>
                       		</td>
                       		</c:forEach>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="admin-nav-title purple-f">미반납</div>
            <div class="basic-list2">
                <table id="listTable" summary="">
                    <caption>대여가능수</caption>
                    <thead>
                        <tr>
                            <th scope="col">구분</th>
                            <c:forEach var="codeList" items="${codeList}" varStatus="x">
							<th scope="col">${codeList.GBNM}</th>
							</c:forEach>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th scope="col">수량</th>
                            <c:forEach var="codeList" items="${codeList}" varStatus="x">
                            <c:set var="missingExist" value="false"/>
                            <td>
                            <c:forEach var="missingMap" items="${missingMap}" varStatus="y">
                       			<c:if test="${codeList.GBCD == missingMap.key}">
                       			<a href="/admin/recList.do?gbcd=${missingMap.key}&pageNo=1&sch_return=noStat&sch_strdt=${setDate}&sch_enddt=${setDate}">${missingMap.value}</a><c:set var="missingExist" value="true"/>
                       			</c:if>
                       		</c:forEach>
                       		<c:if test="${missingExist eq 'false'}"><a href="/admin/recList.do?gbcd=${codeList.GBCD}&pageNo=1&sch_return=noStat&sch_strdt=${setDate}&sch_enddt=${setDate}">0</a></c:if>
                       		</td>
                       		</c:forEach>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="basic-list2">
                <div class="btn-zone">
                    <ul>
                        <li><input type="button" name="srchDescription" class="admin_btn" onclick="javascript:window.open('/admin/monthlyRentStatus.do', 'monthlyRentStatus', '');" value="월간장비 대여현황 보기"></li>
                    </ul>
                </div>
            </div>




        </div>
        <!--content end-->
        </div>
    </div>

    <div class="popup_view_box view1" id="apDiv" style="display:none;">
    </div>
</body>
<c:if test="${!empty msg}">alert("<spring:message code="${msg}" >");</spring:message></c:if>

<script type="text/javascript">
    var code1 = $('#selectCode').val();
    var modal_eq = '';
    $(document).ready(function() {
        load_fnc('4', '0', '0'); //menu script
        
        $("#setDate").datepicker({
        	
        	showOn : 'both',
    		buttonImage : '/resource/images/btn/calendar_Icon.png',
    		buttonImageOnly : true
        	
        });
        
        $("#ymd").datepicker({
        	
        	showOn : 'both',
    		buttonImage : '/resource/images/btn/calendar_Icon.png',
    		buttonImageOnly : true
        	
        });
        $( ".ui-datepicker-trigger" ).css('cursor','pointer');   
        
        var searchVal = '${searchVal}';
        var searchValArr = searchVal.split(',');
        for(var i=0; i<searchValArr.length; i++ ){
            var codeVal = 'sch_' + searchValArr[i].substring(0, 6);
            var codeValReal = searchValArr[i];
            $('input:radio[name="'+codeVal+'"][value="'+codeValReal+'"]').prop('checked', true);
        }
    });
    $(window).load(function() {
        var orderBy = $("#orderBy").val();
        if (orderBy){
            if (orderBy.substring(0, 4) == 'best') {
                $('#bestOrderBy').css('color', 'royalblue');
            } else if (orderBy.substring(0,3) == 'lch') {
                $('#lchOrderBy').css('color', 'royalblue');
            }
        }

        var n = $('.jqTransformSelectWrapper').length;
        $(".jqTransformSelectWrapper").each(function(i) {
            $(this).css("z-index", n-i);
        });

    });
    
    function dualMonitor_user_popup_set(){
    	var _rental_user_sign_popup = window.open("/jsp/rent/admin/sign/sign_popup.jsp","_rental_user_sign_popup","width=1920, height=1080");
    	_rental_user_sign_popup.focus();
    }
</script>
<c:import url="/resource/common/include/bottom.jsp" />