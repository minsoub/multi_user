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
			<c:import url="/resource/common/include/leftMenu_01.jsp">
				<c:param name="left_depth_1" value="4"></c:param>
				<c:param name="left_depth_2" value="3"></c:param>
			</c:import>
		</div> 
		</div>
		<!-- leftmenu end-->
		
		<!--content-->
		<div class="contents-con-framebox">
			<div class="nav-box">
				<div class="nav-img"><img alt="" src="/resource/images/sub/sub4_tit_img.png"></div>
				<div class="nav-list">
					<img alt="" src="/resource/images/sub/icon_home.png">&nbsp;HOME&nbsp;&nbsp;>&nbsp;&nbsp;마이페이지&nbsp;&nbsp;>&nbsp;&nbsp;<b style="color:#000000;">장비대여 신청내역</b>
				</div>
				<div class="nav-title">장비대여 신청내역</div>
			</div>
			
			<div class="nav-info">
				<ul>
					<li><img alt="" src="/resource/images/sub/sub4_img.png"></li>
					<li>
						<div>
						홍길동 님께서 신청한 서비스 내역입니다.<br/>
						신청번호를 클릭하면 상세내역을 확인 할 수 있습니다.<br/>
						신청취소는 신청상태(승인대기중)일때만 가능합니다.<br/>
						</div>
					</li>
				</ul>
			</div>
			
			<div class="searchArea_con">
				<form name="FormSrch" id="FormSrch" method="post" onsubmit="return false;">
					<fieldset>
					<div class="search-box">		
						<div class="form-group">
							<legend>검색영역</legend>
							<span>조회기간</span>
							<!-- <select>
								<option>제목 + 내용</option>
							</select>
							<input type="text" title="검색바" name="srchTitleDescription" value=""> -->
							<select name="srchStateCd" onchange="doSearch()">
							<option value="">전체</option>
							<option value="test">test</option></select>
							부터
							<select name="srchStateCd" onchange="doSearch()">
							<option value="">전체</option>
							<option value="test">test</option></select>
							<input type="submit" name="srchDescription" class="search_btn" onclick="doSearch()" value="검색">
						</div>
					</div>
					</fieldset>
				</form>
			</div>
		
			<div class="basic-list">
			<form id="FormData" name="FormData" method="post" onsubmit="return false;">
					<table id="listTable" summary="">
						<caption>게시판 테이블</caption>
						<colgroup>
							<col style="width: 3%" class="no-td">
							<col style="width: 4%">
							<col style="width: 4%">
							<col style="width: 8%" class="date-td">
							<col style="width: 6%" class="ref-td">
							<col style="width: 4%" class="like-td">
							<col style="width: 4%" >
							<col style="width: 4%" >
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="no-td">번호</th>
								<th scope="col" style="cursor: pointer;"><span class="sort" sortid="2">신청번호</span></th>
								<th scope="col">신청일</th>
								<th scope="col" class="date-td" style="cursor: pointer;"><span class="sort sort_desc" sortid="-1">제목</span></th>
								<th scope="col" class="ref-td">희망완료일</th>
								<th scope="col" class="like-td">실제완료일</th>
								<th scope="col" class="like-td">상태</th>
								<th scope="col" class="like-td">신청취소</th>
							</tr>
						</thead>
						<tbody>
							<%for (int i = 1; i <= 10; i++){ %>
							<tr>
								<td class="no-td">188</td>
								<td>2016090625421</td>
								<td class="date-td">2016-10-27</td>
								<td class="ref-td">PPT 템플릿 제작요청</td>
								<td class="like-td">2016-11-05</td>
								<td class="like-td">2016-11-05</td>
								<td class="like-td">사용자취소</td>
								<td><img alt="" src="/resource/images/btn/cancel1.png"></td>
							</tr>
							<%} %>
						</tbody>
					</table>
			</form>
			</div>
			
			<div class="page-zone">
				<ul class="pagination">
					<li class="first-page"><a onclick="doPage(1);"></a></li>			
					<li class="prev-page"><a onclick="doPage(5);"></a></li>			
					<li class="active"><a href="#">1</a></li>
					<li><a onclick="doPage(2);" style="cursor:pointer">2</a></li>			
					<li><a onclick="doPage(3);" style="cursor:pointer">3</a></li>			
					<li><a onclick="doPage(4);" style="cursor:pointer">4</a></li>			
					<li><a onclick="doPage(5);" style="cursor:pointer">5</a></li>
					<li><a onclick="doPage(5);" style="cursor:pointer">6</a></li>
					<li><a onclick="doPage(5);" style="cursor:pointer">7</a></li>
					<li><a onclick="doPage(5);" style="cursor:pointer">8</a></li>
					<li><a onclick="doPage(5);" style="cursor:pointer">9</a></li>
					<li><a onclick="doPage(5);" style="cursor:pointer">10</a></li>			
					<li class="next-page"><a onclick="doPage(11);"></a></li>	
					<li class="last-page"><a onclick="doPage(19);"></a></li>
				</ul>
			</div>
		
		</div>
		<!--content end-->
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	load_fnc('7', '0', '0'); //menu script
});
</script>
<c:import url="/resource/common/include/bottom.jsp" />