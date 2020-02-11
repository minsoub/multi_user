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
						<a href="location.href='/oalist.do?date=${pDate}" class="btnColorA sizeSm">지난 주</a>
					</span>
					<div class="date">${year}년 ${month}월</div>
					<span class="btnWrap">
						<a href="location.href='/oalist.do?date=${nDate}" class="btnColorA sizeSm">다음 주</a>
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
							<c:forEach var="_date" items="$dateList" varStatus="status">								
								<c:if test="${status.Index == 0}"><c:set var="week" value="월" /></c:if>
								<c:if test="${status.Index == 1}"><c:set var="week" value="화" /></c:if>
								<c:if test="${status.Index == 2}"><c:set var="week" value="수" /></c:if>
								<c:if test="${status.Index == 3}"><c:set var="week" value="목" /></c:if>
								<c:if test="${status.Index == 4}"><c:set var="week" value="금" /></c:if>
								
								<th scope="col">${fn:substring(_date, 4, 6)}월 ${fn:substring(_date, 6, 8)} 일(${week})</th>
							</c:forEach>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="idx" begin="9" end="18" varStatus="loop">
						<tr>
							<td>${idx}시 ~ ${idx + 1 }시</td>
							<c:forEach var="_date" items="$dateList" varStatus="status">
								<c:if test="{idx == 9}"><c:set var="t1" value="09" /></c:if>
								<c:if test="{idx > 9}"><c:set var="t1" value="0${idx}"/></c:if>
								<c:set var="tmp" value="${_date}${t1}" />
								<!--  KEPCO-EP 활성화, 한전직원만 예약이 가능함 (해당 데이터 확인 여부 필요) -->
								
								<c:set var="btnText" value="예약신청" />
								<c:set var="btnClass" value="btnColorB" />
								<c:set var="btnClick" value="oaForm('${tmp}');" />		
								
								<c:if test="${not empty rsrvMap['${tmp}']}">
									<c:if test="${rsrvMap['${tmp}'] eq ${SESS_EMPNO} }">
										<c:set var="btnText" value="내 예약" />
										<c:set var="btnClass" value="green" />
										<c:set var="btnClick" value="oaForm('${idMap[${tmp]}');" />		
									</c:if>
									<c:if test="${rsrvMap['${tmp}'] ne ${SESS_EMPNO} }">
										<c:set var="btnText" value="예약불가" />
										<c:set var="btnClass" value="btnDefault" />
										<c:set var="btnClick" value="oaForm('${idMap[${tmp]}');" />		
									</c:if>									
								</c:if>		
								<c:if test="${reserveInterval <  _date}">
									<c:set var="btnText" value="기간초과" />
									<c:set var="btnClass" value="btnLight" />
									<c:set var="btnClick" value="oaForm('신청하실 수 없는 일자 입니다.');" />											
								</c:if>
							<td><p class="btnWrap"><a href="${btnClick}" class="${btnClass}">${btnText}</a></p></td>
							</c:forEach>
						</tr>
						</c:forEach>
						<!-- tr>
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
						</tr  -->
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