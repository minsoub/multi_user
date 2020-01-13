<%@page import="kr.co.neodreams.multi_user.common.StringUtil"%>
<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<body>
<div class="topMenu-bg-img-main"></div>
<div class="mainMenu-bg-box"></div>
<c:import url="/resource/common/include/topMenu.jsp" />

<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
		<!--content-->
		<div class="contents-con-framebox">
			<div id="main_img">
				<img alt="" src="/resource/images/mainimg.png">
			</div>
			<div id="main_menu">
				<ul>
					<li><a href="/contentsInfo.do"><img alt="" src="/resource/images/img_01.png"></a></li>
					<li><a href="/displayBoardInfo.do"><img alt="" src="/resource/images/img_02.png"></a></li>
					<li><a href="/equipManual.do"><img alt="" src="/resource/images/img_03.png"></a></li>
					<li><img alt="" src="/resource/images/img_04.png"></li>
				</ul>
				<ul>
					<li>
						<div id="main_menu_box1">
							<div id="main_menu_sub1">
								<ul id="main_menu_sub_ul1">
									<li><img alt="" src="/resource/images/update_tit.png"></li>
									<li><img alt="" src="/resource/images/update_more.png" onclick="javascript:na_open_window('updata', 'updata.do', 0, 0, 800, 650, 0, 0, 0, 0, 0);" style="cursor:pointer;"></li>
								</ul>
								<ul id="main_menu_sub_ul2">  
									<c:forEach var="item" items="${today_updateList}">       
										<li style="width:100%;"><a href="javascript:;" onclick="javascript:VOD_Link('${item.re_form}', '${item.re_Step}', '${item.subject}', '${item.num}');">
										<c:choose> 
											<c:when test="${fn:length(item.subject) > 35}">    
												${fn:substring(item.subject, 0, 35)}
											</c:when>
											<c:otherwise>
												${item.subject}
											</c:otherwise>
										</c:choose> 
										<span>(${item.r_date})</span></a></li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</li>
					<li>
						<div id="main_menu_sub2">
							<img alt="" src="/resource/images/img_05.png">
							<ul>
								<li><a href="/powerStatus.do"><img alt="" src="/resource/images/img_05_1.png"></a></li>
								<li><a href="/businessLocation.do"><img alt="" src="/resource/images/img_05_2.png"></a></li>
							</ul>
						</div>
					</li>
					<li>
					
						<div id="main_menu_sub3">
							<img alt="" src="/resource/images/img_06.png">
							<ul>
								<li><img alt="" src="/resource/images/img_06_1.png"></li>
								<li><img alt="" src="/resource/images/img_06_2.png"></li>
							</ul>
						</div>
						<form id="frm" name="frm" method="post" onSubmit="return false;"></form>
						<div id="main_menu_sub4">
							<img alt="" src="/resource/images/img_08.png">
							<ul id="main_menu_sub_ul3">
								<c:forEach var="item" items="${noticeList}"> 
									<c:choose> 
										<c:when test="${fn:length(item.subject) > 20}">     
											<li><a href="javascript:;" onclick="javascript:funGoPageDetail('/notice_view.do?num=${item.num}');">${fn:substring(item.subject, 0, 20)}...</a></li>
										</c:when>
										<c:otherwise>
											<li><a href="javascript:;" onclick="javascript:funGoPageDetail('/notice_view.do?num=${item.num}');">${item.subject}</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${fn:length(noticeList) == 0}">
				              		<li>등록된 공지가 없습니다.</li>
				            	</c:if>
							</ul>
						</div>
					</li>
				</ul>
			</div>
			
		</div>
		<!--content end-->
	</div>
</div>
<iframe id="flashDownload" style="border: 0;visibility:hidden;height: 0px;"></iframe>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('0', '0', '0'); //menu script
	
	openCookieWin();
	
	//flash 설치 여부 확인 
	var is_flash_installed = false;
	try {
	  if(new ActiveXObject('ShockwaveFlash.ShockwaveFlash')){
		  is_flash_installed = true;
	  }
	}catch(e){
	  if(navigator.mimeTypes['application/x-shockwave-flash'] != undefined){
		  is_flash_installed = true;
	  }
	}
	
	if(!is_flash_installed){
		setTimeout(function(){
			alert('플래시 플레이어 미설치 브라우저입니다.\n\r영상 재생을 위해 파일 다운로드 및 설치를 진행해주세요.');
	   	    document.getElementById('flashDownload').src = 'http://media.hq/resource/adobe_flash_player_22.zip';			
		}, 1000)
	}
});

//팝업창 띄우기
function getCookie(name) {
		var nameOfCookie = name + "=";
		var x = 0

		while ( x <= document.cookie.length ) {
				var y = (x+nameOfCookie.length);
				if ( document.cookie.substring( x, y ) == nameOfCookie ) {
						if ( (endOfCookie=document.cookie.indexOf( ";",y )) == -1 )
								endOfCookie = document.cookie.length;
						return unescape( document.cookie.substring(y, endOfCookie ) );
				}
				x = document.cookie.indexOf( " ", x ) + 1;
				if ( x == 0 )
						break;
		}
		return "";
}

function openCookieWin() {
	/* 
	if (getCookie("MediaHQ20170110") != "no") {
		noticeWindow =  window.open('/popup/popup/20170110.asp','MediaHQ20170110','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=635,height=720,top=100,left=50');
		noticeWindow.opener = self;
	}
   */
   
	if (getCookie("MediaHQ20160302") != "no") {
		noticeWindow =  window.open('/popup/popup/20160302.asp','MediaHQ20160302','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=620,top=100,left=50');
		noticeWindow.opener = self;
	}
}
</script>
<c:import url="/resource/common/include/bottom.jsp" />