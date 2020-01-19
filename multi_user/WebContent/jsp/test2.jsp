<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>    
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">

	<link rel="stylesheet" type="text/css" href="/resource/common/css/basic.css" />
	<link rel="stylesheet" type="text/css" href="/resource/common/css/main.css" />
	<link rel="stylesheet" type="text/css" href="/resource/common/css/jquery-1.12.1-ui.css" />

	<title>멀티미디어센터</title>
	<script type="text/javascript" src="/resource/common/js/jquery-1.9.1.js"></script>   
	<script type="text/javascript" src="/resource/common/js/jquery-1.12.0.min.js"></script>
	<script type="text/javascript" src="/resource/common/js/jquery.number.min.js"></script>
	<script type="text/javascript" src="/resource/common/js/jquery-1.12.1-ui.js"></script>
	<script type="text/javascript" src="/resource/common/js/jquery.jqtransform.js"></script>
	<script src="/resource/common/js/neodreams.js"></script>
	<script src="/resource/common/js/jscript.js"></script>
</head>
<body>
	<div class="topMenu-bg-img-sub"></div>
	<header>
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
								<li><a href="/admin/noticeList.do">업무자료실</a></li>
								<li><a href="#">출력요청</a></li>
								<li><a href="#">사진촬영</a></li>
								<li><a href="#">OA교육장</a></li>
							</ul>
						</li>

						<li id="topmenu3"><a href="/equipManual.do">장비대여</a>
							<ul>
								<li class="menu-on"><a href="/equipManual.do">이용안내</a></li>
								<li><a href="/equipRentList.do">설비현황</a></li>
								<li><a href="/appList.do">마이페이지</a></li>
								<li><a href="/basketList.do">장바구니</a></li>

							</ul>
						</li>   

						<li id="topmenu4"><a href="#">S/W라이센스</a>
							<ul>
								<li class="menu-on"><a href="#">라이센스등록</a></li>
								<li><a href="#">소프트웨어관리</a></li>
							</ul>
						</li>    

						<li id="topmenu5"><a href="#">다운로드</a>
							<ul>
								<li class="menu-on"><a href="#">공개소프트웨어</a></li>
								<li><a href="#">업무소프트웨어</a></li>
								<li><a href="#">드라이버</a></li>
								<li><a href="#">패치/업데이트</a></li>
								<li><a href="#">멀티미디어</a></li>
								<li><a href="#">윈도우10</a></li>
							</ul>
						</li>    

						<li id="topmenu6"><a href="#">게시판</a>
							<ul>
								<li class="menu-on"><a href="#">공지사항</a></li>
								<li><a href="#">자유게시판</a></li>
								<li><a href="#">Q&A</a></li>
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

			</ul>
		</div>
	</div>
</div>
<div id="sub_tab"></div>
</header>

<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!-- leftmenu -->
		<div class="contents-header-framebox">
			<div class="learn-tit-framebox">			
				<!-- 컨텐츠제작 -->
				<div>
					<img alt="서비스 요청" src="/resource/images/sub/sub_title02.png">
				</div>
				<div>
					<ul>
						<li><a href=""><img src="/resource/images/sub/sub2_leftmenu_01b.png" alt="컨텐츠제작"></a></li>
						<li><a href=""><img src="/resource/images/sub/sub2_leftmenu_02.png" alt="전광판게시"></a></li>
						<li><a href=""><img src="/resource/images/sub/sub2_leftmenu_03.png" alt="출력요청"></a></li>
						<li><a href=""><img src="/resource/images/sub/sub2_leftmenu_04.png" alt="사진촬영"></a></li>
						<li><a href=""><img src="/resource/images/sub/sub2_leftmenu_05.png" alt="OA교육장"></a></li>
						<li><a href=""><img src="/resource/images/sub/sub2_leftmenu_06.png" alt="업무자료실"></a></li>
					</ul>
				</div>
				<!-- 컨텐츠제작 끝 -->

				<div class="mov_qa">
					<img alt="" src="/resource/images/sub/icon_media_sub.png" style="cursor: pointer;" onclick="javascript:na_open_window('video_help', '/jsp/video_help.jsp', 0, 0, 757, 379, 0, 0, 0, 0, 0);">
				</div>
			</div>  
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub2_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;서비스요청&nbsp;&nbsp;>&nbsp;&nbsp;컨텐츠제작&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">이용안내</b>
				</div>
				<div class="nav-title">컨텐츠 제작 <small class="sub2">이용안내</small></div>
			</div>

			<div class="tabNav sub2">
				<li><a href="" class="active">이용안내</a></li>
				<li><a href="">제작요청</a></li>
				<li><a href="">진행사항</a></li>
			</div>

			<div class="basic-list">
				<h2>목적</h2>
<pre>
<font style="font-family: NanumGothic;">
사내 중요 원시미디어 자료를 디지털화하여 정보자원 활용 극대화와 내부고객 만족실현 및 관련 업무 집중처리로 업무혼선 및 
중복 투자 방지
</font>
</pre>
				<br/>
				<h2>요청절차</h2>
<pre>
<font style="font-family: NanumGothic;">
컨텐츠 제작 요청된 사항은 담당부서의 검토를 통해 제작 가능 한 경우 접수하여 진행상황에 게시됩니다.
컨텐츠 제작은 접수순으로 제작되며, 진행 처리 상태를 웹에 게시됩니다.
컨텐츠 제작이 완료되면  인수인계서를 통하여 제작매체와 원시자료를 요청부서에 인계 합니다.
</font>
</pre>
				<br/>			
				<img alt="" src="/resource/images/sub/sub2_img.png">
			</div>

		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
	load_fnc('2', '0', '0'); //menu script
});
</script>


<footer>
	<div class="footerFrame">
		<div class="footerFrame-center">
			<div class="footer-tel">
				<ul>
					<li>장비대여&nbsp;&nbsp;<span>061-6383</span>&nbsp;&nbsp;&nbsp;<span>/</span>&nbsp;&nbsp;&nbsp;</li>
					<li>PPT제작&nbsp;&nbsp;<span>061-6381,6384</span>&nbsp;&nbsp;&nbsp;<span>/</span>&nbsp;&nbsp;&nbsp;</li>
					<li>이미지제작&nbsp;&nbsp;<span>061-6382</span>&nbsp;&nbsp;&nbsp;<span>/</span>&nbsp;&nbsp;&nbsp;</li>
					<li>전광판게시&nbsp;&nbsp;<span>061-6382</span>&nbsp;&nbsp;&nbsp;<span>/</span>&nbsp;&nbsp;&nbsp;</li>
					<li>영상제작&nbsp;&nbsp;<span>061-6386</span>&nbsp;&nbsp;&nbsp;<span>/</span>&nbsp;&nbsp;&nbsp;</li>
					<li>기술지원&nbsp;&nbsp;<span>061-6385</span></li>
				</ul>
			</div>
			<div class="footer-logo"><img alt="" src="/resource/images/logo1.png"></div>
			<div class="footer-addr">(우) 58217 전라남도 나주시 전력로 55 (빛가람동 120)  멀티미디어센터    Copyright@2016 KEPCO. All Rights Reserved. </div>
		</div>
	</div>
</footer>

</body>
</html>