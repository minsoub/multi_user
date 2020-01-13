<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div class="topMenu-bg-img-sub"></div>
<c:import url="/resource/common/include/topMenu.jsp" />

<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
		<div class="learn-tit-framebox">
			<div class="learn-tit-framebox">
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="7"></c:param>
				<c:param name="left_depth_2" value="2"></c:param>
			</c:import>
			</div> 
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub7_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;멀티미디어센터&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">사이트맵</b>
				</div>
				<div class="nav-title">사이트맵</div>
			</div>
		
			<div class="siteMapList">
				<ul>
					<li><p>사내방송</p>
						<ul>
							<li><p><a href="/kepcnNewsList.do">KEP-CN NEWS</a></p></li>
							<li><p><a href="/issueTalkList.do">이슈&토크</a></p></li>
							<li><p><a href="/promotionalVideoList.do">감성홍보영상</a></p></li>
							<li><p><a href="/kepcnPlanList.do">KEP-CN기획</a></p></li>
							<li><p><a href="/kepcnRequest.do">사내방송 출연신청</a></p></li>
						</ul>
					</li>
					<li><p>KUBE</p>
						<ul>
                   			<li><p><a href="/kube.do">KUBE 홈</a></p></li>
                   			<li><p><a href="/kube/channel/recently">최신 동영상</a></p></li>
                   			<li><p><a href="/kube/channel/weekly">인기 동영상</a></p></li>
							<c:forEach var="kubeMenu" items="${kubeMenu}" varStatus="status">
	                       		<c:if test="${kubeMenu.p_code_seq != 0 && kubeTopMenuChk == 'Y'}">
	                       			<li><p><a href="/kube/channel/${kubeMenu.link_url}/${cha:seqEncode(kubeMenu.p_code_seq)}/${cha:seqEncode(kubeMenu.code_seq)}">${kubeMenu.code_desc}</a></p></li>
	                       			<c:set var="kubeTopMenuChk" value="N" />
	                       		</c:if>
	                       		<c:if test="${kubeMenu.p_code_seq == 0}">
	                      			<c:set var="kubeTopMenuChk" value="Y" />
	                      		</c:if>	
	                       	</c:forEach>
						</ul>
					</li>
					<li><p>컨텐츠제작</p>
						<ul>
							<li><p><a href="/contentsInfo.do">이용안내</a></p></li>
							<li><p><a href="/contentsRequest.do">제작요청</a></p></li>
							<li><p><a href="/contentsProgress.do">진행상황</a></p></li>
						</ul>
					</li>
				</ul>
				
				<ul>
					<li><p>전광판게시</p>
						<ul>
							<li><p><a href="/displayBoardInfo.do">이용안내</a></p></li>
							<li><p><a href="/displayBoardRequest.do">게시신청</a></p></li>
							<li><p><a href="/displayBoardProgress.do">진행상황</a></p></li>
						</ul>
					</li>
					<li><p>행사신청</p>
						<ul>
							<li><p><a href="/promote/promoteInfo.do">이용안내</a></p></li>
							<li><p><a href="/promote/promoteRequest.do">행사신청</a></p></li>
							<li><p><a href="/promote/promoteProgress.do">진행사항</a></p></li>
						</ul>
					</li>
					<li><p>장비대여</p>
						<ul>
							<li><p><a href="/equipManual.do">이용안내</a></p></li>
							<li><p><a href="/equipRentList.do">설비현황</a></p></li>
							<li><p><a href="/appList.do">마이페이지</a></p></li>
							<li><p><a href="/basketList.do">장바구니</a></p></li>
							<!-- <li><p><a href="#">관리메뉴</a></p></li> -->
						</ul>
					</li>
				</ul>
				
				<ul>
					<li><p>전력수급현황</p>
						<ul>
							<li><p><a href="/powerStatus.do">내 사업소 현황</a></p></li>
							<li><p><a href="/businessLocation.do">사업소별 현황</a></p></li>
						</ul>
					</li>
					<li><p>파워밴드</p>
						<ul>
							<li><p><a href="http://band.kepco.co.kr/share">파워밴드</a></p></li>
						</ul>
					</li>
					<li><p>마이페이지</p>
						<ul>
							<li><p><a href="/mypageContentsList.do">컨텐츠제작</a></p></li>
							<li><p><a href="/mypageDisplayBoardList.do">전광판게시</a></p></li>
							<!-- <li><p><a href="/mypageRentalList.do">장비대여</a></p></li> -->
							<li><p><a href="/mypageStatistics.do">이용현황통계</a></p></li>
						</ul>
					</li>
				</ul>
			</div>

		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('0', '0', '0'); //menu script
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />