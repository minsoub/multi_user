<%@page import="kr.co.neodreams.multi_user.common.StringUtil"%>
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
						<li><a href=""><img src="/resource/images/sub/sub2_leftmenu_01.png" alt="컨텐츠제작"></a></li>
						<li><a href=""><img src="/resource/images/sub/sub2_leftmenu_02.png" alt="전광판게시"></a></li>
						<li><a href=""><img src="/resource/images/sub/sub2_leftmenu_03.png" alt="출력요청"></a></li>
						<li><a href=""><img src="/resource/images/sub/sub2_leftmenu_04.png" alt="사진촬영"></a></li>
						<li><a href=""><img src="/resource/images/sub/sub2_leftmenu_05b.png" alt="OA교육장"></a></li>
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
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;서비스요청&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">OA교육장</b>
				</div>
				<div class="nav-title">OA교육장</div>
			</div>
			
			<div class="clearfix">
				<div class="ctrlCal fl">
					<span class="btnWrap">
						<a href="" class="btnColorA sizeSm">지난 주</a>
					</span>
					<div class="date">2019년 12월</div>
					<span class="btnWrap">
						<a href="" class="btnColorA sizeSm">다음 주</a>
					</span>
				</div>
				<div class="fr">
					<div class="btnWrap">
						<a href="" class="btnPrimary">매뉴얼 다운로드</a>
					</div>
				</div>
			</div>
			<div class="basic-list mtSm">
				<table>
					<thead>
						<tr>
							<th scope="col"></th>
							<th scope="col">12월 16일(월)</th>
							<th scope="col">12월 17일(화)</th>
							<th scope="col">12월 18일(수)</th>
							<th scope="col">12월 19일(목)</th>
							<th scope="col">12월 20일(금)</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>09시~10시</td>
							<td><p class="btnWrap"><a href="" class="btnColorB">예약가능</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnLight">기간초과</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
						</tr>
						<tr>
							<td>10시~11시</td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
						</tr>
						<tr>
							<td>11시~12시</td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
						</tr>
						<tr>
							<td>12시~13시</td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
						</tr>
						<tr>
							<td>13시~14시</td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
						</tr>
						<tr>
							<td>14시~15시</td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
						</tr>
						<tr>
							<td>15시~16시</td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
						</tr>
						<tr>
							<td>16시~17시</td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
						</tr>
						<tr>
							<td>17시~18시</td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
							<td><p class="btnWrap"><a href="" class="btnDefault">예약불가</a></p></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!--content end-->
	</div>
</div>

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