<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
				<c:param name="left_depth_1" value="2"></c:param>
				<c:param name="left_depth_2" value="6"></c:param>
			</c:import>
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
						<a href="/oalist.do?date=${pDate}" class="btnColorA sizeSm">지난 주</a>
					</span>
					<div class="date">${year}년 ${month}월</div>
					<span class="btnWrap">
						<a href="/oalist.do?date=${nDate}" class="btnColorA sizeSm">다음 주</a>
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
							<c:set var="week" value="" />
							<c:forEach var="_date" items="${dateList}" varStatus="status">								
								<c:if test="${status.index == 0}"><c:set var="week" value="월" /></c:if>
								<c:if test="${status.index == 1}"><c:set var="week" value="화" /></c:if>
								<c:if test="${status.index == 2}"><c:set var="week" value="수" /></c:if>
								<c:if test="${status.index == 3}"><c:set var="week" value="목" /></c:if>
								<c:if test="${status.index == 4}"><c:set var="week" value="금" /></c:if>
								
								<th scope="col">${fn:substring(_date, 4, 6)}월 ${fn:substring(_date, 6, 8)} 일(${week})</th>
							</c:forEach>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="idx" begin="9" end="18" varStatus="loop">
						<tr>
							<td>${idx}시 ~ ${idx + 1 }시</td>
							<c:forEach var="_date" items="${dateList}" varStatus="status">
								<c:set var="t1" />
								<c:if test="${idx == 9}"><c:set var="t1" value="09" /></c:if>
								<c:if test="${idx > 9}"><c:set var="t1" value="${idx}"/></c:if>
								<c:set var="tmp" value="${_date}${t1}" />
								<!--  KEPCO-EP 활성화, 한전직원만 예약이 가능함 (해당 데이터 확인 여부 필요) -->
								
								<c:set var="btnText" value="예약신청" />
								<c:set var="btnClass" value="btnColorB" />
								<c:set var="btnClick" value="javascript:oaForm('${tmp}');" />		
								
								<c:if test="${not empty rsrvMap[tmp]}">
									<c:if test="${rsrvMap[tmp] eq SESS_EMPNO }">
										<c:set var="btnText" value="내 예약" />
										<c:set var="btnClass" value="green" />
										<c:set var="btnClick" value="javascript:oaView('${idMap[tmp]}');" />		
									</c:if>
									<c:if test="${rsrvMap[tmp]}'] ne SESS_EMPNO }">
										<c:set var="btnText" value="예약불가" />
										<c:set var="btnClass" value="btnDefault" />
										<c:set var="btnClick" value="javascript:oaView('${idMap[tmp]}');" />		
									</c:if>									
								</c:if>		
								<c:if test="${reserveInterval >  _date}">
									<c:set var="btnText" value="기간초과" />
									<c:set var="btnClass" value="btnLight" />
									<c:set var="btnClick" value="javascript:alert('신청하실 수 없는 일자 입니다.');" />											
								</c:if>
							<td><p class="btnWrap"><a href="${btnClick}" class="${btnClass}">${btnText}</a></p></td>
							</c:forEach>
						</tr>
						</c:forEach> 
					</tbody>
				</table>
			</div>
		</div>
		<!--content end-->
	</div>
</div>
<form name="frm" id="frm" method="post">
	<input type="hidden" id="date" name="date">
	<input type="hidden" id="rsrv_id" name="rsrv_id" value="0">
</form>
<script type="text/javascript">

	$(document).ready(function(){
		load_fnc('2', '0', '0'); //menu script
	});

	function oaForm(dd)
	{
		if("${SESS_EMPNO}" == "")
		{
			alert("사용자 세션정보가 없습니다. 신청이 불가능합니다!!")
			return;
		}
		$("#date").val(dd);
		frm.action = "/oaWrite.do";
		frm.submit();
	}
	
	function oaView(rsv_key)
	{
		$("#rsrv_id").val(rsv_key);
		frm.action = "/oaView.do";
		frm.submit();
	}

</script>
<c:import url="/resource/common/include/bottom.jsp" />