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
                    <c:import
                        url="/resource/common/include/leftMenu_01.jsp">
                        <c:param name="left_depth_1" value="4"></c:param>
                        <c:param name="left_depth_2" value="2"></c:param>
                    </c:import>
                </div>
            </div>
            <!-- leftmenu end-->

            <!--content-->
            <div class="contents-con-framebox">
                <div class="nav-box">
                    <div class="nav-img">
                        <img alt=""
                            src="/resource/images/sub/sub4_tit_img.png">
                    </div>
                    <div class="nav-list">            
                        <img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;마이페이지&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">전광판게시 신청내역</b>
                    </div>
                    <div class="nav-title">전광판게시 신청내역</div>
                </div>

                <div class="nav-info">
                    <ul>
                        <li><img alt=""
                            src="/resource/images/sub/sub4_img.png"></li>
                        <li>
                            <div style="line-height: 1.5em;">
                                <font color="RGB(5,61,99)" style="font-weight: bold;"><%= (String)session.getAttribute("SESS_USER_NAME") %></font> 님께서 전광판 신청한 서비스 내역입니다.<br /> 제목을 클릭하면
                                신청상세내역을 확인 할 수 있습니다. 신청취소는 <font color="RGB(219,107,57)" style="font-weight: bold;">신청상태</font>일때만 가능합니다.<br />
                                기타 문의 사항은 061-6382로 문의 바랍니다.<br />
                            </div>
                        </li>
                    </ul>
                </div>

                <form id="frm" name="frm" method="post" action="/displayDetail.do">
                    <input type="hidden" name="pageNo" id="pageNo"
                        value="${paging.pageNo }" />
                    <input type="hidden" id="SHSEQNUM" name="SHSEQNUM">
					<input type="hidden" id="mode"	name="mode" value="1"/>    
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

                    <div class="basic-list">
                        <table id="listTable" summary="">
                            <caption>게시판 테이블</caption>
                            <colgroup>
                                <col style="width: 2%" class="no-td">
                                <col style="width: 10%" class="ref-td">
                                <col style="width: 4%">
                                <col style="width: 5%" class="date-td">
                                <col style="width: 12%" class="like-td">
                                <col style="width: 5%">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col" class="no-td">번호</th>
                                    <th scope="col" class="ref-td"><span
                                        class="sort sort_desc"
                                        sortid="1">제목</span></th>
                                    <th scope="col">게시장소</th>
                                    <th scope="col" class="date-td">신청일</th>
                                    <th scope="col" class="like-td">게시기간</th>
                                    <th scope="col">상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${applicationList}"
                                    var="item" varStatus="status">
                                    <tr>
                                        <td class="no-td">${totalCnt - (paging.perPageCnt*(paging.pageNo-1)) - status.index }</td>
                                        <td class="ref-td">
                                            <div
                                                class="textOverflow cursor_pointer"
                                                style="overflow: hidden; padding: 0px; width: 200px; word-wrap: break-word !important; text-align: left !important;"
                                                onclick="doDetail('${cha:seqEncode(item.SM_SEQ)}');">
                                                ${item.SM_TITLE}</div>
                                        </td>
                                        <td>
                                            <c:set var="svc2"
                                                value="${fn:split(item.SM_SVC2,', ')}" />
                                            <c:forEach items="${svc2}"
                                                var="svc"
                                                varStatus="sts">
                                                <c:choose>
                                                    <c:when
                                                        test="${svc eq 3074}">
                                                        <img
                                                            alt="북측 LED전광판"
                                                            src="/resource/images/btn/icon_01.png">
                                                    </c:when>
                                                    <c:when
                                                        test="${svc eq 3075}">
                                                        <img
                                                            alt="남측 LED전광판"
                                                            src="/resource/images/btn/icon_02.png">
                                                    </c:when>
                                                    <c:when
                                                        test="${svc eq 3076}">
                                                        <img alt="엘리베이터"
                                                            src="/resource/images/btn/icon_03.png">
                                                    </c:when>
                                                </c:choose>
                                            </c:forEach>
                                        </td>
                                        <td class="date-td">${item.SM_DATE}</td>
                                        <td class="like-td"><fmt:parseDate
                                                value="${item.SDP_FDATE}"
                                                var="PARSE_SDP_FDATE"
                                                pattern="yyyyMMddHHmm" />
                                            <fmt:parseDate
                                                value="${item.SDP_TDATE}"
                                                var="PARSE_SDP_TDATE"
                                                pattern="yyyyMMddHHmm" />
                                            <fmt:formatDate
                                                value="${PARSE_SDP_FDATE}"
                                                pattern="yyyy-MM-dd HH:mm" />~<fmt:formatDate
                                                value="${PARSE_SDP_TDATE}"
                                                pattern="yyyy-MM-dd HH:mm" />
                                        </td>
                                        <td><c:choose>
                                                <c:when
                                                    test="${item.SM_LSTATE eq '3093'}">
                                                    <!-- 신청 -->
                                                    <font
                                                        color="RGB(64,117,171)">${item.CD2_NAME}</font>
                                                </c:when>
                                                <%-- <c:when
                                                    test="${item.SM_LSTATE eq '3275'}">
                                                    <!-- 검수중 -->
                                                    <font
                                                        color="RGB((28,164,82)">${item.CD2_NAME}</font>
                                                </c:when> --%>
                                                <c:when
                                                    test="${item.SM_LSTATE eq '3099'}">
                                                    <!-- 작업중 -->
                                                    <font
                                                        color="RGB((28,164,82)">진행중</font>
                                                </c:when>
                                                <c:when
                                                    test="${item.SM_LSTATE eq '3094'}">
                                                    <!-- 접수/제작중, 승인대기 -->
                                                    <font
                                                        color="RGB(244,138,96)">${item.CD2_NAME}</font>
                                                </c:when>
                                                <c:when 
                                                    test="${item.SM_LSTATE eq '3095' || item.SM_LSTATE  eq '3096'}">
                                                    <!-- 정상완료 -->
                                                    <font
                                                        color="RGB(124,31,187)">${item.CD2_NAME}</font>
                                                </c:when>
                                                <c:when
                                                    test="${item.SM_LSTATE eq '3097'}">
                                                    <!-- 사용자취소 -->
                                                    <font
                                                        color="RGB(114,114,114)">${item.CD2_NAME}</font>
                                                </c:when>
                                                <c:otherwise>${item.CD2_NAME}</c:otherwise>
                                            </c:choose> <c:if
                                                test="${(item.SM_LSTATE eq 3093) && (item.SM_ISSIGN eq 3112)}">&nbsp;
                                                <img alt=""
                                                    class="cursor_pointer"
                                                    src="/resource/images/btn/cancel1.png"
                                                    onclick="javascript:btnCancelNo('${item.SM_SEQ}','${item.SM_NO}');">
                                            </c:if></td>
                                    </tr>
                                </c:forEach>
                                <c:if
                                    test="${fn:length(applicationList) == 0}">
                                    <tr>
                                        <td colspan="6">검색 결과가 없습니다</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </form>

                <c:import url="/resource/common/include/paging.jsp" />

                <div style="padding: 10px; border: #0B9DCC solid 1px;">
                    <div>
                        <img alt="북측 LED전광판"
                            src="/resource/images/btn/icon_01.png">북측
                        LED전광판&nbsp; <img alt="북측 LED전광판"
                            src="/resource/images/btn/icon_02.png">남측
                        LED전광판&nbsp; <img alt="북측 LED전광판"
                            src="/resource/images/btn/icon_03.png">엘리베이터
                    </div>
                </div>
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

                    /*제목, 글 내용등을 생략할떄...*/
                    $('.textOverflow')
                            .each(
                                    function() {
                                        var $target = $(this);
                                        var html = $target.html();

                                        var $clone = $target.clone();
                                        $clone.css({
                                            display : 'none',
                                            position : 'absolute',
                                            overflow : 'visible'
                                        }).width($target.width())
                                                .height('auto');

                                        $target.after($clone);

                                        while ((html.length > 0)
                                                && ($clone.height() > $target
                                                        .height())) {
                                            html = html.substr(0,
                                                    html.length - 1);
                                            $clone.html(html + '...');
                                        }

                                        $target.html($clone.html());
                                        $clone.remove();
                                    });
                    /*제목, 글 내용등을 생략할떄...*/

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
                        funFrmPagingSubmit();
                        return true;
                    }

                    function btnSvcView(id) {
                        document.frm.strID.value = id;
                        // 	document.frm.action = "./contents_view02.asp";
                        document.frm.submit();
                    }

                    function btnCancelNo(id, no) {
                        var conf;
                        conf = confirm("해당 서비스 신청건에 대해서 취소를 하시겠습니까?\n(취소는 '신청' 단계에서만 가능합니다.)\n정말 취소를 원하시면 확인 버튼을 클릭 하십시오.");
                        
	               		 if(conf){
	               			$("#frm").attr("action","/displayDel.do");
	               			$("#SHSEQNUM").val(id);
		               		$("#frm").submit();
	               	     } else {  
	               			return false;
	               	     } 
                    }
                    
                    function doDetail(id){
                    	$("#SHSEQNUM").val(id);
                    	$("#frm").submit();
                    }
                </script>
    <c:import url="/resource/common/include/bottom.jsp" />