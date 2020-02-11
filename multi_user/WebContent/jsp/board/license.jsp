<%@page import="kr.co.neodreams.multi_user.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>

<c:import url="/resource/common/include/meta.jsp" />
<link rel="stylesheet" type="text/css" href="/resource/common/css/jquery.datetimepicker.css" />
<script type="text/javascript" src="/resource/common/js/jquery.datetimepicker.full.min.js"></script>
<style>
.btn_yellow {
	background-color: #ff9620;
	color: #fff;
	font-size: 14px;
}

.btn_blue {
	background-color: #08A0CE;
	color: #fff;
	font-size: 14px;
	padding: 0px 5px;
}

</style>
<body>
	<div class="topMenu-bg-img-sub"></div>
	<c:import url="/resource/common/include/topMenu.jsp" />
	<c:set value="${menudepth_1}" var="left_depth_1"/>
	
<div id="contents" class="learn-frame-area">
	<div class="contents-framebox" id="contents_id">
			<!-- leftmenu -->
			<div class="contents-header-framebox">
				<div class="learn-tit-framebox">
					<c:import url="/resource/common/include/leftMenu_01.jsp">
						<c:param name="left_depth_1" value="13"></c:param>
						<c:param name="left_depth_2" value="1"></c:param>
					</c:import>
				</div>
			</div>
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub2_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;S/W라이센스&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">라이센스 등록</b>
				</div>
				<div class="nav-title">라이센스 등록</div>
			</div>

			<div class="searchArea_con">
				<fieldset>
					<div class="search-box">
						<div class="form-group">
							<legend>검색영역</legend>
							
						</div>
					</div>
				</fieldset>
			</div>

			<div class="basic-list">
				<p class="numTotal">총 수량 : 11396</p>
				<table width="100%" id="listTable">
					<colgroup>
						<col width="40%">
						<col>
						<col>
					</colgroup>
					<thead>
						<tr>
							<th>소프트웨어</th>
							<th>버전</th>
							<th>수량</th>
						</tr>
					</thead>
					<tbody class="ac">
						<tr>
							<td rowspan="2">ABCUpload</td>
							<td></td>
							<td>1</td>
						</tr>
						<tr>
							<td>소계</td>
							<td>1</td>
						</tr>
						<tr>
							<td rowspan="2">ACD See</td>
							<td>6.0</td>
							<td>1</td>
						</tr>
						<tr>
							<td>소계</td>
							<td>1</td>
						</tr>
						<tr>
							<td rowspan="2">ACL</td>
							<td>-</td>
							<td>1</td>
						</tr>
						<tr>
							<td>소계</td>
							<td>1</td>
						</tr>
						<tr>
							<td rowspan="2">Able 2 Extract Pro</td>
							<td></td>
							<td>1</td>
						</tr>
						<tr>
							<td>소계</td>
							<td>1</td>
						</tr>
						<tr>
							<td rowspan="2">Acrobat Professional</td>
							<td>8.0</td>
							<td>8</td>
						</tr>
						<tr>
							<td>7.0</td>
							<td>29</td>
						</tr>    
					</tbody>
				</table>
				<div class="page-zone">
					<ul class="pagination">
						<li class="first-page"><a href=""></a></li>
						<li class="prev-page"><a href="" class="prev"></a></li>				
						<li class="active"><a href="# return false;">1</a></li>
						<li><a href="javascript:goPage('2')">2</a></li>
						<li><a href="javascript:goPage('3')">3</a></li>
						<li><a href="javascript:goPage('4')">4</a></li>
						<li><a href="javascript:goPage('5')">5</a></li>
						<li><a href="javascript:goPage('6')">6</a></li>
						<li><a href="javascript:goPage('7')">7</a></li>
						<li><a href="javascript:goPage('8')">8</a></li>
						<li><a href="javascript:goPage('9')">9</a></li>
						<li><a href="javascript:goPage('10')">10</a></li>						
						<li class="next-page"><a href=""></a></li>
						<li class="last-page"><a href=""></a></li>
					</ul>
				</div>
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