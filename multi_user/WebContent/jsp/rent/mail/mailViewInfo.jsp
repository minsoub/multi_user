<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/common/include/common.jsp"%>
<c:import url="/resource/common/include/meta.jsp" />
<style>
.td01{padding: 5px;}
</style>
<table width="700" border="0" cellspacing="0" cellpadding="0">
	<tr>
	<td height="140" background="/resource/images/mail/top_info.jpg">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" background="/resource/images/mail/middle.jpg">
			<table width="600">
				<colgroup>
					<col width="110px" />
					<col width="220px" />
					<col width="110px" />
					<col width="*" />
				</colgroup>
				<tr>
					<td class="td01">신청번호</td>
					<td class="td02">${mailContext.appnum}</td>
					<td class="td01">등록날짜</td>
					<td class="td02">${mailContext.regdt}</td>
				</tr>
				<tr>
					<td class="td01">대여기간</td>
					<td class="td02">${mailContext.strdt} ~ ${mailContext.enddt}</td>
					<td class="td01">신청자</td>
					<td class="td02">${mailContext.appenm}(${mailContext.appeno})</td>
				</tr>
				<tr>
					<td class="td01">인수자</td>
					<td class="td02">${mailContext.insunm}(${mailContext.insuno})</td>
					<td class="td01">사용자</td>
					<td class="td02">${mailContext.appuenm}</td>
				</tr>
				<tr>
					<td class="td01">대여장비</td>
					<td class="td02">${mailContext.gbnm}</td>
					<td class="td01">내용</td>
					<td class="td02">대여장비 정보확인</td>
				</tr>
				<tr>
					<td class="td01">모델명</td>
					<td class="td02">${mailContext.mdnm}</td>
					<td class="td01">장비명</td>
					<td class="td02">
					${mailContext.eqnm}
					<c:if test="${mailContext.eqalias != null}">
					<br>${mailContext.eqalias}					
					</c:if>
					</td>
				</tr>
				<tr>
					<td class="td01">수량</td>
					<td class="td02">${mailContext.amount}</td>
					<td class="td01"></td>
					<td class="td02"></td>
				</tr>

			</table>
		</td>
	</tr>
	<tr>
		<td height="105" align="center" valign="top" background="/resource/images/mail/bottom.jpg">
		</td>
	</tr>
</table>

<script></script>