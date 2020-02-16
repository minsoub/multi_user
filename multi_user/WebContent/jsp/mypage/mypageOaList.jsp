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
                        <c:param name="left_depth_2" value="5"></c:param>
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
                        <img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;마이페이지&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">OA교육장 신청내역</b>
                    </div>
                    <div class="nav-title">OA교육장 신청내역</div>
                </div>

                <div class="nav-info">
                    <ul>
                        <li><img alt=""
                            src="/resource/images/sub/sub4_img.png"></li>
                        <li>
                            <div style="line-height: 1.5em;">
                                <font color="RGB(5,61,99)" style="font-weight: bold;"><%= (String)session.getAttribute("SESS_USER_NAME") %></font> 님께서 출력요청 신청한 서비스 내역입니다.<br /> 제목을 클릭하면
                                신청상세내역을 확인 할 수 있습니다. 신청취소는 <font color="RGB(219,107,57)" style="font-weight: bold;">신청상태</font>일때만 가능합니다.<br />
                                기타 문의 사항은 061-6381,6384,6386으로 문의 바랍니다.<br />
                            </div>
                        </li>
                    </ul>
                </div>

                <form id="frm" name="frm" method="post" action="/mypageOaList.do">
                    <input type="hidden" name="pageNo" id="pageNo" value="${paging.pageNo }" />
                    <input type="hidden" id="rsrv_id"  name="rsrv_id" value="0">
                    <input type="hidden" id="mode" name="mode">
                    <div class="searchArea_con">
                        <fieldset>
                            <div class="search-box">
                                <div class="form-group">
                                    <legend>검색영역</legend>
                                    <span style="font-weight: bold;color: RGB(5,61,99)">조회기간</span>
                                    <input type="text" readonly
                                        name="searchFromDt" id="s1"
                                        value="${paging.searchFromDt}"
                                        style="width: 140px;height:15px; margin-left:8px; margin-right: 3px;background-image:url('/resource/images/btn/down_01.png'); background-position:right; background-repeat: no-repeat;">부터  
                                    <input type="text" readonly
                                        name="searchToDt" id="s2"
                                        value="${paging.searchToDt}"
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
                                <col style="width: 5%" class="no-td">
                                <col style="width: 40%" class="ref-td">
                                <col style="width: 15%">
                                <col style="width: 13%" class="date-td">
                                <col style="width: 13%" class="like-td">
                                <col style="width: 13%">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col" class="no-td">번호</th>
                                    <th scope="col" class="ref-td"><span class="sort sort_desc" sortid="-1">이용목적</span></th>
                                    <th scope="col">이용시간</th>
                                    <th scope="col">이용인원</th>
                                    <th scope="col" class="date-td">승인일자</th>
                                    <th scope="col">상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${resultList}" var="item" varStatus="status">
                                    <tr>
                                        <td class="no-td">${totalCnt - (paging.perPageCnt*(paging.pageNo-1)) - status.index }</td>
                                        <c:set var="cuttitle" value="${fn:substring(item.subject, 0 , 15) }" />
                                        <c:set var="allLength" value="${fn:length(item.subject) }" />
                                        <td class="ref-td" onclick="doDetail('${item.rsrv_id}');" style="cursor: pointer;">
                                        ${allLength > 15 ? cuttitle.concat('...') : item.subject }
                                        </td>
                                        <td>${item.rsrv_dt}</td>
                                        <td class="date-td">${item.people_cnt} 명</td>
                                        <td class="like-td">${item.aprv_dttm}</td>
                                        <td><c:choose>
                                                <c:when test="${item.aprv_status eq 'R'}">
                                                    <!-- 신청 -->
                                                    <font color="RGB(64,117,171)">${item.aprv_status_nm}</font>
                                                </c:when>
                                                 <c:when test="${item.aprv_status eq 'Y'}">
                                                    <!-- 작업중 -->
                                                    <font color="RGB((28,164,82)">${item.aprv_status_nm}</font>
                                                </c:when>
                                                <c:when test="${item.aprv_status eq 'A'}">
                                                    <!-- 정상완료 -->
                                                    <font color="RGB(124,31,187)">${item.aprv_status_nm}</font>
                                                </c:when>
                                                <c:when test="${item.aprv_status eq 'C'}">
                                                    <!-- 사용자취소 -->
                                                    <font color="RGB(114,114,114)">${item.aprv_status_nm}</font>
                                                </c:when>
                                            </c:choose> <c:if test="${(item.aprv_status eq 'R')}">
                                        &nbsp;<img alt=""
                                                    class="cursor_pointer"
                                                    style="margin-bottom: 3px;"
                                                    src="/resource/images/btn/cancel1.png"
                                                    onclick="javascript:btnCancelNo('${item.rsrv_id}');">
                                            </c:if></td>
                                    </tr>
                                </c:forEach>
                                <c:if
                                    test="${fn:length(resultList) == 0}">
                                    <tr>
                                        <td colspan="6">검색 결과가 없습니다</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </form>

                <c:import url="/resource/common/include/paging.jsp" />

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

            if (document.frm.searchFromDt.value > document.frm.searchToDt.value) {
                alert("조건의 시작일이 종료일보다 작을 수 없습니다.");
                document.frm.searchToDt.focus();
                return false;
            }
            frm.submit();
        }

        function btnSvcView(id) {
            document.frm.strID.value = id;
            // 	document.frm.action = "./contents_view02.asp";
            document.frm.submit();
        }

        function btnCancelNo(id) {
            var conf;
            conf = confirm("해당 서비스 신청건에 대해서 취소를 하시겠습니까?\n(취소는 '신청' 단계에서만 가능합니다.)\n정말 취소를 원하시면 확인 버튼을 클릭 하십시오.");
            
       		 if(conf){
       			var params = {
       					"rsrv_id" : id,
       					"aprv_status" : "C"
       			}	

       			$.ajax({
       					type : 'post',
       					url : '/deleteOA.do',
       					dataType : 'json',
       					data : params,
       					success : function(result){
       						if(result >= 0){
       							alert('OA교육장 신청취소 되었습니다.');
       							goList();
       						}
       					},
       					error : function(e){
       					}
       			})
       	     } else {  
       			return false;
       	     } 
        }
        function goList()
        {
        	frm.action = "/mypageOaList.do";
        	frm.submit();
        }
        
        function doDetail(id){
        	$("#rsrv_id").val(id);
        	$("#mode").val("mypage");
        	frm.action = "/oaView.do";
        	$("#frm").submit();
        }
    </script>
    <c:import url="/resource/common/include/bottom.jsp" />