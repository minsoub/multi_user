<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>


<c:choose>
    <c:when test="${param.left_depth_1 eq 1 }">
        <!-- 사내방송 -->
        <div>
            <img alt="사내방송" src="/resource/images/sub/sub_title01.png">
        </div>
        <div>
            <ul>
                <li>
                    <a href="/kepcnNewsList.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 1 }"><img alt="" src="/resource/images/sub/sub1_leftmenu_01b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub1_leftmenu_01.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/kepcnFocusList.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 6 }"><img alt="" src="/resource/images/sub/sub1_leftmenu_06b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub1_leftmenu_06.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/issueTalkList.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 5 }"><img alt="경영진 대담" src="/resource/images/sub/sub1_leftmenu_05b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub1_leftmenu_05.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/promotionalVideoList.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 2 }"><img alt="홍보영상" src="/resource/images/sub/sub1_leftmenu_02b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub1_leftmenu_02.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>

                <li>
                    <a href="/kepcnConferenceList.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 7 }"><img alt="경영회의 영상" src="/resource/images/sub/sub1_leftmenu_07b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub1_leftmenu_07.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                 <li>
                    <a href="/kepcnPlanList.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 3 }"><img alt="" src="/resource/images/sub/sub1_leftmenu_03b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub1_leftmenu_03.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li> 
            </ul>
        </div>
        <!--사내방송 끝 -->
    </c:when>
 
    
    <c:when test="${param.left_depth_1 eq 2 }">
    <c:set var="isGetAdmin" value="${sessionScope.SESS_USER_INFO['rentAdmin']}"></c:set>
        <!-- 서비스요청 -->
        <div>
            <img alt="서비스요청" src="/resource/images/sub/sub_title02.png">
        </div>
        <div>
            <ul>
            	<!--  컨텐츠 제작  -->
                <li>                    
                    <a href="/contentsInfo.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 1 }"><img alt="컨텐츠제작" src="/resource/images/sub/sub2_leftmenu_01b.png"></c:when>
                        <c:otherwise><img alt="컨텐츠제작" src="/resource/images/sub/sub2_leftmenu_01.png"></c:otherwise>
                    </c:choose>
                    </a>
                    <!-- 
                    <c:if test="${isGetAdmin != null}">
						<div class="left-depth-menu" style="margin-top:5px;">
							<ul class="side-navCt">
								<c:choose>
									<c:when test="${param.left_depth_2 eq 6 }">
										<li class="active" ><a href="/acceptList.do">이용동의 관리</a></li>
									</c:when>
									<c:otherwise>
										<li><a href="/acceptList.do">이용동의 관리</a></li>
									</c:otherwise>
								</c:choose>
							</ul>
						 </div>
					 </c:if>
                    -->
                </li>
                
                <!-- 전광판 게시 -->
                <li>
                    <a href="/displayBoardInfo.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 2 }"><img alt="" src="/resource/images/sub/sub2_leftmenu_02b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub2_leftmenu_02.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                
                <!-- 플로터출력 (IT플라자)  -->
                <li>
                    <a href="/printlist.do">
                    <c:choose>
                    	<c:when test="${param.left_depth_2 eq 4 }"><img alt="출력요청" src="/resource/images/sub/sub2_leftmenu_03b.png"></c:when>
                    	<c:otherwise><img alt="출력요청" src="/resource/images/sub/sub2_leftmenu_03.png"></c:otherwise>
                	</c:choose>
                	</a>
                </li>  
                
                <!--  사진촬영 (IT플라자) -->
                <li>
                    <a href="/photolist.do">
                    <c:choose>
                    	<c:when test="${param.left_depth_2 eq 5 }"><img alt="사진촬영" src="/resource/images/sub/sub2_leftmenu_04b.png"></c:when>
                    	<c:otherwise><img alt="사진촬영" src="/resource/images/sub/sub2_leftmenu_04.png"></c:otherwise>
                	</c:choose>
                	</a>
                </li>  
                
                <!-- OA 교육장 (IT플라자) -->
                <li>
                    <a href="/oalist.do">
                    <c:choose>
                    	<c:when test="${param.left_depth_2 eq 6 }"><img alt="OA 교육장" src="/resource/images/sub/sub2_leftmenu_05b.png"></c:when>
                    	<c:otherwise><img alt="OA 교육장" src="/resource/images/sub/sub2_leftmenu_05.png"></c:otherwise>
                	</c:choose>
                	</a>
                </li>                   
             
            </ul>                   
        </div>
        <!-- 컨텐츠제작 끝 -->
    </c:when>
    
    <c:when test="${param.left_depth_1 eq 3 }">
    <c:set var="isGetAdmin" value="${sessionScope.SESS_USER_INFO['rentAdmin']}"></c:set>
    <!-- 장비대여 -->
        <div>
            <img alt="장비대여" src="/resource/images/sub/sub_title08.png">
        </div>
        <div>
            <ul>
                <li>
                    <a href="/equipManual.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 1 }"><img alt="" src="/resource/images/sub/sub8_leftmenu_01b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub8_leftmenu_01.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/equipRentList.do">
                        <c:choose>
                            <c:when test="${param.left_depth_2 eq 2 }"><img alt="" src="/resource/images/sub/sub8_leftmenu_02b.png"></c:when>
                            <c:otherwise><img alt="" src="/resource/images/sub/sub8_leftmenu_02.png"></c:otherwise>
                        </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/appList.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 3 }"><img alt="" src="/resource/images/sub/sub8_leftmenu_03b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub8_leftmenu_03.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/basketList.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 4 }"><img alt="" src="/resource/images/sub/sub8_leftmenu_04b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub8_leftmenu_04.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <c:if test="${isGetAdmin != null}">
                <li>
                    <a href="/admin/equipRentStatus.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 5 }"><img alt="" src="/resource/images/sub/sub8_leftmenu_05b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub8_leftmenu_05.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                </c:if>
            </ul>
        </div>
        <c:if test="${isGetAdmin != null}">
        <div class="left-depth-menu" style="margin-top:5px;">
            <ul class="side-nav">
                <c:choose>
                    <c:when test="${param.left_depth_3 eq 1 }">
                        <li class="active"><a href="/admin/equipRentStatus.do">대여현황</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/admin/equipRentStatus.do">대여현황</a></li>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${param.left_depth_3 eq 2 }">
                        <li class="active"><a href="/admin/recList.do">접수현황</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/admin/recList.do">접수현황</a></li>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${param.left_depth_3 eq 9 }">
                        <li class="active"><a href="/admin/checkAppMonthList.do">노트북 현황 관리대장</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/admin/checkAppMonthList.do">노트북 점검대장</a></li>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${param.left_depth_3 eq 3 }">
                        <li class="active"><a href="/admin/todayRecList.do">금일접수현황</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/admin/todayRecList.do">금일접수현황</a></li>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${param.left_depth_3 eq 4 }">
                        <li class="active"><a href="/admin/equipList.do">장비현황</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/admin/equipList.do">장비현황</a></li>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${param.left_depth_3 eq 5 }">
                        <li class="active"><a href="/admin/code.do">설정관리</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/admin/code.do">설정관리</a></li>
                    </c:otherwise>
                </c:choose>
                <!--<c:choose>
                    <c:when test="${param.left_depth_3 eq 6 }">
                        <li class="active"><a href="/admin/access.do">출입대장관리</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/admin/access.do">출입대장관리</a></li>
                    </c:otherwise>
                </c:choose>-->
                <c:choose>
                    <c:when test="${param.left_depth_3 eq 7 }">
                        <li class="active"><a href="/admin/longTermUser.do">설비대여현황</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/admin/longTermUser.do">설비대여현황</a></li>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${param.left_depth_3 eq 8 }">
                        <li class="active"><a href="/admin/notebookCheckList.do">반출입대장</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/admin/notebookCheckList.do">보안조치현황</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
        </c:if>
        <!--장비대여 끝 -->
    </c:when>    
    
	<c:when test="${param.left_depth_1 eq 11 }">
	<!--  다운로드    -->
        <div>
            <img alt="다운로드" src="/resource/images/sub/sub_title06.png">
        </div>	
        <div>
            <ul>
                <li>
                    <a href="/publicsw.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 1 }"><img alt="" src="/resource/images/sub/sub6_leftmenu_01b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub6_leftmenu_01.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/jobsw.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 2 }"><img alt="" src="/resource/images/sub/sub6_leftmenu_02b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub6_leftmenu_02.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/driversw.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 3 }"><img alt="" src="/resource/images/sub/sub6_leftmenu_03b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub6_leftmenu_03.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/patchsw.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 4 }"><img alt="" src="/resource/images/sub/sub6_leftmenu_04b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub6_leftmenu_04.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li> 
                <!-- li>
                    <a href="/multisw.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 5 }"><img alt="" src="/resource/images/sub/sub6_leftmenu_05b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub6_leftmenu_05.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li  -->
                <li>
                    <a href="/winsw.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 6 }"><img alt="" src="/resource/images/sub/sub6_leftmenu_06b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub6_leftmenu_06.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>                                                
            </ul>
        </div>                
	</c:when>    

	<c:when test="${param.left_depth_1 eq 12 }">
	<!--  게시판    -->
        <div>
            <img alt="게시판" src="/resource/images/sub/sub_title10.png">
        </div>	
        <div>
            <ul>
                <li>
                    <a href="/notice.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 1 }"><img alt="" src="/resource/images/sub/sub10_leftmenu_01b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub10_leftmenu_01.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/freeboard.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 2 }"><img alt="" src="/resource/images/sub/sub10_leftmenu_02b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub10_leftmenu_02.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/qnaboard.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 3 }"><img alt="" src="/resource/images/sub/sub10_leftmenu_03b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub10_leftmenu_03.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
            </ul>
        </div>                
	</c:when>
	
 
    <c:when test="${param.left_depth_1 eq 4 }">
        <!-- 마이페이지-->
        <div>
            <img alt="마이페이지" src="/resource/images/sub/sub_title04.png">
        </div>
        <div>
            <ul>
                <li>
                    <a href="/mypageContentsList.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 1 }"><img alt="" src="/resource/images/sub/sub4_leftmenu_01b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub4_leftmenu_01.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/mypageDisplayBoardList.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 2 }"><img alt="" src="/resource/images/sub/sub4_leftmenu_02b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub4_leftmenu_02.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/mypagePrintList.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 3 }"><img alt="" src="/resource/images/sub/sub4_leftmenu_03b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub4_leftmenu_03.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/mypagePhotoList.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 4 }"><img alt="" src="/resource/images/sub/sub4_leftmenu_04b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub4_leftmenu_04.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li> 
                <li>
                    <a href="/mypageOaList.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 5 }"><img alt="" src="/resource/images/sub/sub4_leftmenu_05b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub4_leftmenu_05.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>                                
                <li>
                    <a href="/mypageStatistics.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 6 }"><img alt="" src="/resource/images/sub/sub4_leftmenu_06b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub4_leftmenu_06.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
            </ul>
        </div>
        <!--마이페이지 끝 -->
    </c:when>

    <c:when test="${param.left_depth_1 eq 7 }">
        <!-- 멀티미디어센터 -->
        <div>
            <img alt="멀티미디어센터" src="/resource/images/sub/sub_title07.png">
        </div>
        <div>
            <ul>
                <li>
                    <a href="/notice.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 1 }"><img alt="" src="/resource/images/sub/sub7_leftmenu_01b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub7_leftmenu_01.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/siteMap.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 2 }"><img alt="" src="/resource/images/sub/sub7_leftmenu_02b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub7_leftmenu_02.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
            </ul>
        </div>
        <!--멀티미디어센터 끝 -->
    </c:when>

    <c:when test="${param.left_depth_1 eq 14 }">
        <!-- 전력수급현황 -->
        <div>
            <img alt="전력수급현황" src="/resource/images/sub/sub_title10.png">
        </div>
        <div>
            <ul>
            
                <li>
                    <a href="/powerStatus.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 1 }"><img alt="" src="/resource/images/sub/sub10_leftmenu_02b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub10_leftmenu_02.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="/dustLocation.do">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 2 }"><img alt="" src="/resource/images/sub/sub10_leftmenu_03b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub10_leftmenu_03.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>
                <li>
                    <a href="http://band.kepco.co.kr/share">
                    <c:choose>
                        <c:when test="${param.left_depth_2 eq 2 }"><img alt="" src="/resource/images/sub/sub10_leftmenu_04b.png"></c:when>
                        <c:otherwise><img alt="" src="/resource/images/sub/sub10_leftmenu_04.png"></c:otherwise>
                    </c:choose>
                    </a>
                </li>                
            </ul>
        </div>
        <!--전력수급현황 끝 -->
    </c:when>
    
    <c:otherwise></c:otherwise>
</c:choose>


<div class="mov_qa">
    <img alt="" src="/resource/images/sub/icon_media_sub.png" style="cursor: pointer;" onclick="javascript:na_open_window('video_help', '/jsp/video_help.jsp', 0, 0, 757, 379, 0, 0, 0, 0, 0);">
</div>