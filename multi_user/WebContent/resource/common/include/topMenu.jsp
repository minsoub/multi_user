<%@page import="kr.co.neodreams.multi_user.common.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header>
<%@ include file="/resource/common/include/common.jsp"%>
<SCRIPT LANGUAGE="JavaScript">
	function powerband() {
		alert("서비스 준비중 입니다.!");
	}
</SCRIPT>

<div class="gnbmenu-box">
    <div class="header-visualbox">
        <div class="site-framebox">
        <div class="top-logo"><a href="/main.do"><img alt="" src="/resource/images/logo.png"></a></div>
        </div>
        <div class="gnb-framebox">
            <div class="top-login-title">
                <ul>
                    <!-- <li>ICT서비스부&nbsp;<span>김종찬님 환영합니다.</span></li> -->
                    <li><span class="top-left-font"><a href="/notice.do">공지사항</a></span>&nbsp;</li>
                    <li><span class="top-right-font">&nbsp;|&nbsp;</span></li>
                    <li>&nbsp;<span class="top-left-font"><a href="/siteMap.do">사이트맵</a></span></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="topmenu-framebox">
    <div class="header-visualbox">
        <div id="topmenu-framebox" class="web-topmenu">
                <ul>
                    <li id="topmenu1"><a href="/kepcnNewsList.do">사내방송</a>
                        <ul>
                            <li class="menu-on"><a href="/kepcnNewsList.do">KEP-CN NEWS</a></li>
                            <li><a href="/kepcnFocusList.do">KEP-CN 기획</a></li>
                            <li><a href="/issueTalkList.do">현안 대담</a></li>
                            <li><a href="/promotionalVideoList.do">회사홍보영상</a></li>
                            <li><a href="/kepcnConferenceList.do">감사나눔릴레이</a></li>
                            <li><a href="/kepcnPlanList.do">소셜미디어 홍보영상</a></li>
                            <!--<li><a href="/kepcnRequest.do">사내방송 출연신청</a></li> -->
                        </ul>
                    </li>
                    
                    <li id="topmenu2"><a href="/contentsInfo.do">서비스요청</a>
                    	<ul>
                    		<li class="menu-on"><a href="/contentsInfo.do">컨텐츠제작</a></li>
                    		<li><a href="/displayBoardInfo.do">전광판게시</a></li>
                    		<!-- li><a href="/admin/noticeList.do">업무자료실</a></li  -->
                    		<li><a href="/printlist.do">플로터출력</a></li>
                    		<li><a href="/photolist.do">사진촬영</a></li>
                    		<li><a href="/oalist.do">OA교육장</a></li>
                    	</ul>
                    </li>
                    
					<li id="topmenu3"><a href="/equipManual.do">장비대여</a>
						<ul>
							<li class="menu-on"><a href="/equipManual.do">이용안내</a></li>
							<li><a href="/equipRentList.do">설비현황</a></li>
							<li><a href="/appList.do">마이페이지</a></li>
							<li><a href="/basketList.do">장바구니</a></li>
							<c:set var="isGetAdmin" value="${sessionScope.SESS_USER_INFO['rentAdmin']}"></c:set>
							<c:if test="${isGetAdmin != null}">
							<li><a href="/admin/equipRentStatus.do">관리메뉴</a></li>
							</c:if>
						</ul>
					</li>   
					
					<li id="topmenu4"><a href="/swlicense.do">S/W라이센스</a>
						<ul>
							<li class="menu-on"><a href="/swlicense.do">라이센스등록</a></li>
							<li><a href="/swmng.do">소프트웨어관리</a></li>
						</ul>
					</li>    
					
					<li id="topmenu5"><a href="/publicsw.do">다운로드</a>
						<ul>
							<li class="menu-on"><a href="/publicsw.do">공개소프트웨어</a></li>
							<li><a href="/jobsw.do">업무소프트웨어</a></li>
							<li><a href="/driversw.do">드라이버</a></li>
							<li><a href="/patchsw.do">패치/업데이트</a></li>
							<!-- li><a href="/multisw.do">멀티미디어</a></li  -->
							<li><a href="/winsw.do">윈도우10</a></li>
						</ul>
					</li>    
					
					<li id="topmenu6"><a href="/notice.do">게시판</a>
						<ul>
							<li class="menu-on"><a href="/notice.do">공지사항</a></li>
							<li><a href="/freeboard.do">자유게시판</a></li>
							<li><a href="/qnaboard.do">Q&A</a></li>
						</ul>
					</li>  
					
                    <li id="topmenu7"><a href="/mypageContentsList.do">마이페이지</a>
                        <ul id="topmenu_sub6" style="left:-340px;">
                            <li class="menu-on"><a href="/mypageContentsList.do">컨텐츠제작 신청내역</a></li>
                            <li><a href="/mypageDisplayBoardList.do">전광판게시 신청내역</a></li>
                            <!-- <li><a href="/mypageRentalList.do">장비대여 신청내역</a></li> -->
                            <li><a href="#">출력요청 신청내역</a></li>
                            <li><a href="#">사진촬영 신청내역</a></li>
                            <li><a href="#">QA교육장 신청내역</a></li>
                            <li><a href="/mypageStatistics.do">이용현황통계</a></li>
                        </ul>
                    </li>					       
                                                                                                 
                    <!-- li id="topmenu8"><a href="/kube.do" target="_blank">KUBE</a></li -->

                    <!-- li id="topmenu9"><a href="/promote/promoteInfo.do">행사신청</a>
                        <ul>
                            <li class="menu-on"><a href="/promote/promoteInfo.do">이용안내</a></li>
                            <li><a href="/promote/promoteRequest.do">행사신청</a></li>
                            <li><a href="/promote/promoteProgress.do">진행사항</a></li>
                        </ul>
                    </li  -->

					<%--안씀                         
                    <li id="topmenu8"><a href="/kube.do" target="_blank">KUBE</a>
						<ul>
                        	<c:set var="kubeTopMenuChk" value="N" />
                        	<c:forEach var="kubeTopMenu" items="${kubeLeftMenu}" varStatus="status">
                        		<c:if test="${status.index == 0}">
                        			<li class="menu-on"><a href="/kube.do">KUBE 홈</a></li>
                        		</c:if>
                        		<c:if test="${kubeTopMenu.p_code_seq != 0 && kubeTopMenuChk == 'Y'}">
                        			<li><a href="/kube/channel/${kubeTopMenu.link_url}/${cha:seqEncode(kubeTopMenu.p_code_seq)}/${cha:seqEncode(kubeTopMenu.code_seq)}">${kubeTopMenu.code_desc}</a></li>
                        			<c:set var="kubeTopMenuChk" value="N" />
                        		</c:if>
                        		<c:if test="${kubeTopMenu.p_code_seq == 0}">
                       				<c:set var="kubeTopMenuChk" value="Y" />
                       			</c:if>	
                        	</c:forEach>
                        </ul>
                    </li>
 					--%>
                    
                    <!-- li id="topmenu2"><a href="/contentsInfo.do">컨텐츠제작</a>
                        <ul>
                            <li class="menu-on"><a href="/contentsInfo.do">이용안내</a></li>
                            <li><a href="/contentsRequest.do">제작요청</a></li>
                            <li><a href="/contentsProgress.do">진행상황</a></li>
                            <c:set var="isGetAdmin" value="${sessionScope.SESS_USER_INFO['rentAdmin']}"></c:set>
                            <c:if test="${isGetAdmin != null}">
                            <li><a href="/contentsImgBrdList.do">이미지 자료실</a></li>
                            <li><a href="/admin/noticeList.do">업무 자료실</a></li>
                            </c:if>
                        </ul>
                    </li  -->
                    <!-- li id="topmenu3"><a href="/displayBoardInfo.do">전광판게시</a>
                        <ul>
                            <li class="menu-on"><a href="/displayBoardInfo.do">이용안내</a></li>
                            <li><a href="/displayBoardRequest.do">게시신청</a></li>
                            <li><a href="/displayBoardProgress.do">진행상황</a></li>
                        </ul>
                    </li>

                    <li id="topmenu5"><a href="/powerStatus.do">전력수급현황</a>
                        <ul>
                            <li class="menu-on"><a href="/powerStatus.do">내 사업소 현황</a></li>
                            <li><a href="/businessLocation.do">사업소별 현황</a></li>
                        </ul>
                    </li>
                    <li id="topmenu10"><a href="/dustLocation.do">미세먼지 현황</a>
                        <ul>
                            <li class="menu-on"><a href="/dustLocation.do">사업소별 현황 (1920 * 1080)</a></li>
                            <li class="menu-on"><a href="/dustLocation1024.do">사업소별 현황 (1024 * 768)</a></li>
                        </ul>
                    </li>
                    <li id="topmenu6"><a href="http://band.kepco.co.kr/share">파워밴드</a>
                    </li -->
                    <!-- 어드민 추가 매뉴 --> 
                    <!-- 맞춤형 사용 안함 시작 -->
                    <!--
                    <li id="topmenu6"><a href="/scheduling.do">맞춤형디스플레이</a>
                        <ul>
                            <li class="menu-on"><a href="/scheduling.do">일정관리</a></li>
                            <li><a href="/businessStatus.do">업무현황관리</a></li>
                        </ul>
                    </li>
                    -->
                    <!-- 맞춤형 사용 안함 끝 -->
                    <!-- 어드민 추가 매뉴 끝-->

                </ul>
        </div>
    </div>
</div>
<div id="sub_tab"></div>
</header>